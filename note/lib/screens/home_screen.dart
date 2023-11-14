import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/colors.dart';
import 'package:note/models/note.dart';
import 'package:note/provider/theme_provider.dart';
import 'package:note/screens/add_note_screen.dart';
import 'package:note/screens/settings_screen.dart';
import 'package:note/widgets/note_item.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var noteBox = Hive.box<Note>('Note');
  bool isFabVisible = true;
  String searchKeyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/background.png'),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 10.h,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 76.w,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchKeyword = value;
                                });
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: MyColors.greyColor,
                                  hintText: 'Search',
                                  hintStyle:
                                      TextStyle(color: MyColors.hintColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12)),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image(
                                        image: AssetImage(
                                            'images/search_icon.png')),
                                  )),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingsScreen(),
                                  ));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: MyColors.greyColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Image(
                                    image:
                                        AssetImage('images/settings_icon.png')),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                  ),
                  ValueListenableBuilder<Box<Note>>(
                    valueListenable: noteBox.listenable(),
                    builder: (context, value, child) {
                      if (noteBox.isEmpty) {
                        return SliverPadding(
                          padding: EdgeInsets.only(top: 25.h),
                          sliver: SliverToBoxAdapter(
                              child: Column(
                            children: [
                              Image(
                                width: 100,
                                height: 100,
                                image: AssetImage('images/book.png'),
                              ),
                              Text('Write your dreams...')
                            ],
                          )),
                        );
                      } else {
                        final filteredNotes = noteBox.values
                            .where((note) => note.note
                                .toLowerCase()
                                .contains(searchKeyword.toLowerCase()))
                            .toList();

                        return SliverList.builder(
                          itemCount: filteredNotes.length,
                          itemBuilder: (context, index) {
                            var note = filteredNotes.toList()[index];
                            return NoteItem(
                              myNote: note,
                            );
                          },
                        );
                      }
                    },
                  ),
                  SliverPadding(padding: EdgeInsets.only(bottom: 80)),
                ],
              ),
              Positioned(
                bottom: 3.h,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNoteScreen(),
                        ));
                    setState(() {});
                  },
                  child: Visibility(
                    visible: isFabVisible,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: MyColors.greenColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 14),
                                blurRadius: 22,
                                color: MyColors.shadowColor)
                          ],
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          )),
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
