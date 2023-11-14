import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:note/constants/colors.dart';
import 'package:note/models/note.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController controller = TextEditingController();
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
                    Text('New Note'),
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
                          maxLines: null,
                          controller: controller,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Write note...',
                              border: InputBorder.none)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    String note = controller.text;
                    if (note.isEmpty) {
                      return;
                    } else {
                      addNote(note);
                    }
                    Navigator.pop(context);
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

  void addNote(String note) {
    DateTime now = DateTime.now();
    String date = DateFormat.MMMMd().format(now);
    var notes = Note(note, date.toString());
    noteBox.add(notes);
  }
}
