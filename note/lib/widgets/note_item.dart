import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note/constants/colors.dart';
import 'package:note/models/note.dart';
import 'package:note/screens/show_note_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:note/screens/edit_note_screen.dart';

class NoteItem extends StatelessWidget {
  NoteItem({super.key, required this.myNote});
  Note myNote;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowNoteScreen(
                note: myNote,
              ),
            ));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(12),
        height: 20.h,
        decoration: BoxDecoration(
            color: MyColors.lightRedColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 14),
                  blurRadius: 35,
                  color: MyColors.shadowColor2)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  myNote.date,
                  style: TextStyle(
                      color: MyColors.redColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: SizedBox(
                                  height: 12.h,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Are you sure?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        MyColors.darkRedColor,
                                                    foregroundColor:
                                                        Colors.white),
                                                onPressed: () {
                                                  myNote.delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Delete')),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                        color: MyColors
                                                            .darkRedColor),
                                                    foregroundColor:
                                                        MyColors.darkRedColor),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel')),
                                          ],
                                        )
                                      ])),
                            ));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: MyColors.greenColor),
                      child: SvgPicture.asset('images/trash_icon.svg')),
                ),
                SizedBox(
                  width: 3.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNoteScreen(
                            note: myNote,
                          ),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: MyColors.greenColor),
                    child: SvgPicture.asset('images/edit_icon.svg'),
                  ),
                )
              ],
            ),
            Text(
              myNote.note,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
