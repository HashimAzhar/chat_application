import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userImage;

  ChatScreen({super.key, required this.userName, required this.userImage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(); // Added ScrollController

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  // Function to scroll to the bottom of the chat list
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController
            .position
            .minScrollExtent, // minScrollExtent is the bottom when reverse: true
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 2.2,
            colors: [const Color(0xFF43116A).withOpacity(0.9), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: NetworkImage(widget.userImage),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      widget.userName,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Chat messages
              Expanded(
                child: StreamBuilder(
                  stream:
                      _firestore
                          .collection('chats')
                          .orderBy(
                            'timestamp',
                            descending: true,
                          ) // Query in descending to get latest at the top of the stream
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final messages = snapshot.data!.docs;

                    // Schedule a scroll to bottom after the messages are built
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });

                    return ListView.builder(
                      controller:
                          _scrollController, // Assign the scroll controller
                      reverse:
                          true, // This makes the list start from the bottom
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final text = msg['text'] as String;
                        final senderId = msg['senderId'] as String?;
                        final isMe =
                            _currentUser != null &&
                            senderId == _currentUser!.uid;
                        return _buildMessage(text, isMe);
                      },
                    );
                  },
                ),
              ),

              // Input field
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[800]!),
                        ),
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          onSubmitted: (value) {
                            // Allows sending message by pressing Enter
                            if (value.trim().isNotEmpty) {
                              _sendMessage();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap:
                          _sendMessage, // Call the private send message method
                      child: CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty && _currentUser != null) {
      _firestore.collection('chats').add({
        'text': _controller.text.trim(),
        'senderId': _currentUser!.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    }
  }

  Widget _buildMessage(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMe ? Colors.deepPurple : Colors.grey[850],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isMe ? 16.r : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16.r),
          ),
        ),
        child: Text(
          message,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14.sp),
        ),
      ),
    );
  }
}
