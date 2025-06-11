import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userImage;
  final String recipientId; // Added recipientId

  ChatScreen({
    super.key,
    required this.userName,
    required this.userImage,
    required this.recipientId, // Required recipientId
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  User? _currentUser;
  String? _chatRoomId; // To store the unique chat room ID

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _generateChatRoomId(); // Generate chat room ID on init
  }

  // Generates a unique chat room ID by sorting the current user's UID and recipient's UID
  void _generateChatRoomId() {
    if (_currentUser != null) {
      List<String> ids = [_currentUser!.uid, widget.recipientId];
      ids.sort(); // Sort to ensure consistent chatRoomId regardless of who started the chat
      _chatRoomId = ids.join('_'); // e.g., "uid1_uid2"
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() async {
    if (_controller.text.trim().isNotEmpty &&
        _currentUser != null &&
        _chatRoomId != null) {
      await _firestore
          .collection('chats')
          .doc(_chatRoomId)
          .collection('messages')
          .add({
            'text': _controller.text.trim(),
            'senderId': _currentUser!.uid,
            'receiverId': widget.recipientId, // Added receiverId
            'timestamp': FieldValue.serverTimestamp(),
          });
      _controller.clear();
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
                child:
                    _chatRoomId == null
                        ? const Center(
                          child: CircularProgressIndicator(),
                        ) // Show loading if chatRoomId isn't ready
                        : StreamBuilder(
                          stream:
                              _firestore
                                  .collection('chats')
                                  .doc(
                                    _chatRoomId,
                                  ) // Access the specific chat room
                                  .collection(
                                    'messages',
                                  ) // Access the messages subcollection
                                  .orderBy('timestamp', descending: true)
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            final messages = snapshot.data!.docs;

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollToBottom();
                            });

                            return ListView.builder(
                              controller: _scrollController,
                              reverse: true,
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
                            if (value.trim().isNotEmpty) {
                              _sendMessage();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: _sendMessage,
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
