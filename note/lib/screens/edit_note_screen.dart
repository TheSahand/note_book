import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:note/constants/colors.dart';
import 'package:note/models/note.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({
    super.key,
    required this.note,
  });
  Note note;
  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  Note? myNote;

  TextEditingController? controller;
  @override
  void initState() {
    myNote = widget.note;
    controller = TextEditingController(text: myNote?.note);
    super.initState();
  }

  var noteBox = Hive.box<Note>('Note');
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
                    Text('Edit Note'),
                    SizedBox(
                      width: 40,
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 3.h),
                Container(
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
                  child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: controller,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Write note...',
                          border: InputBorder.none)),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    editNote(controller!.text);
                  },
                  child: Container(
                    height: 6.h,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                        color: MyColors.greenColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editNote(String note) {
    DateTime now = DateTime.now();
    String date = DateFormat.MMMMd().format(now);
    myNote?.note = note;
    myNote?.date = date;
    myNote?.save();
  }
}
