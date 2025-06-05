import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchTextField({Key? key, this.hintText = 'Search', this.onChanged})
    : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: _controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 42, 29, 90),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          // You can add suffix icon here later for clear button etc.
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
