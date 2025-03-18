import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quran_app/screens/translation_dailog.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart';

import '../constant/app_colors.dart';
import '../constant/app_text_style.dart';

class ReadingScreen extends StatefulWidget {
  final int surahIndex;
  const ReadingScreen({super.key, required this.surahIndex});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  // to handle audio
  final audioPlayer = AudioPlayer();
  // to handle autoScroll
  final ScrollController _scrollController = ScrollController();
  // to  handle audioPlayer state
  bool isPLaying = false;
  // current verse
  int verse = 0;
  // selected Index for translation
  int selectedIndex = -1;
  // selected translated text
  String selectedTranslation = "";
  @override
  void initState() {
    super.initState();
    // here we are adding one listener to audioPlayer
    audioPlayer.playerStateStream.listen((state) {
      // here we are checking if the single verse audio is completed
      if (state.processingState == ProcessingState.completed) {
        // here we are checking our current verse should not more then VerseCount of current surah
        if (verse < getVerseCount(widget.surahIndex)) {
          // if less then we simply increase verse count
          setState(() {
            verse++;
            if (selectedIndex == verse - 1) {
              selectedIndex = -1;
              selectedTranslation = "";
            }
          });
         // and playing audio based on current verse from server
          playSurahAudio(verse);
          // here we are handling auto scroll when ever we have completed one verse
          // here we are checking if the _scrollController hasClients and  _scrollController has reached to end of scroll
          if (_scrollController.hasClients &&
              !(_scrollController.position.pixels ==
                  _scrollController.position.maxScrollExtent)) {
            // here we are scrolling we animation with verse.length
            _scrollController.animateTo(
              _scrollController.offset +
                  (getVerse(
                        widget.surahIndex,
                        verse,
                        verseEndSymbol: true,
                      ).length *
                      1.5), // Adjust speed by changing this value
              duration: Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          }
        } else {
          // after completion
          setState(() {
            verse = 0;
            isPLaying = false;
          });
        }
      }
    });
  }
// this method fetch the SurahAudio url  from server with verseNumber and play it using audioPlayer
  playSurahAudio(verseNumber) {
    try {
      final audioUrl = getAudioURLByVerse(widget.surahIndex, verseNumber);
      debugPrint("audioUrl == $audioUrl");
      audioPlayer.setUrl(audioUrl);
      audioPlayer.play();
    } catch (e) {
      debugPrint("Error == $e");
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextStyle.titleLargeText(
              context,
              getSurahName(widget.surahIndex),
              Theme.of(context).primaryColor,
            ),
            AppTextStyle.titleLargeText(
              context,
              getSurahNameArabic(widget.surahIndex),
              Theme.of(context).primaryColorLight,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // here we are checking internet
            final result = await InternetAddress.lookup('example.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              // if internet is connected then only we are playing SurahAudio
              setState(() {
                // for start from beginning
                if (verse == 0) {
                  verse = 1;
                }
                // for play and pause
                if (isPLaying) {
                  // pause
                  audioPlayer.pause();
                } else {
                  // play
                  playSurahAudio(verse);
                }
                // toggle
                isPLaying = !isPLaying;
              });
            } else {
              // if internet is not connected we are showing the  SnackBar to user
              final snackBar = SnackBar(
                content: const Text('Please Connect to Internet'),
                action: SnackBarAction(
                  label: 'Okay',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            // if any error happened
          } on SocketException catch (_) {

            final snackBar = SnackBar(
              content: const Text('Please Connect to Internet'),
              action: SnackBarAction(
                label: 'Okay',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child:
            isPLaying
            //While playing audio
                ? SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/notes.gif",
                    color: Theme.of(context).primaryColorLight,
                  ),
                )
                : Icon(
                  Icons.play_arrow,
                  color: Theme.of(context).primaryColorLight,
                ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 20),
        itemCount: getVerseCount(widget.surahIndex),
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () {
              // To Prevent Live Translation
              if (isPLaying && verse == index + 1) {
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    // Custom Dialog to show no of available translation
                    return CustomDialogBox(
                      onSelect: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            // to prevent live translation
                            selectedIndex = index;
                            selectedTranslation = value;
                          });
                        }
                      },
                    );
                  },
                );
              }
            },
            child: Stack(
              children: [
                // Widget for every verse
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Text(
                    selectedIndex == index
                        ? getVerseTranslation(
                          widget.surahIndex,
                          index + 1,
                          translation: language[selectedTranslation]!,
                        )
                        : getVerse(
                          widget.surahIndex,
                          index + 1,
                          verseEndSymbol: true,
                        ),
                    strutStyle: StrutStyle(height: 4.5),
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color:
                          verse == index + 1
                              ? AppColors.primaryLightColor
                              : AppColors.textColor,
                    ),
                  ),
                ),
                // for cancel button
                selectedIndex == index
                    ? Positioned(
                      bottom: 10,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = -1;
                            selectedTranslation = "";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      ),
                    )
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
