import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note/constants/colors.dart';
import 'package:note/models/note.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShowNoteScreen extends StatefulWidget {
  ShowNoteScreen({
    super.key,
    required this.note,
  });
  Note? note;

  @override
  State<ShowNoteScreen> createState() => _ShowNoteScreenState();
}

class _ShowNoteScreenState extends State<ShowNoteScreen> {
  TextEditingController? controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.note?.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/background.png'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 10.w,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: MyColors.darkRedColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: SvgPicture.asset('images/back_icon.svg'),
                      ),
                    ),
                    const Spacer(),
                    Text('Note'),
                    SizedBox(
                      width: 40,
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 3.h),
                SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.lightRedColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 14),
                              blurRadius: 35,
                              color: MyColors.shadowColor2)
                        ]),
                    height: 75.h,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextField(
                          expands: true,
                          readOnly: true,
                          maxLines: null,
                          controller: controller,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Write note...',
                              border: InputBorder.none)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
