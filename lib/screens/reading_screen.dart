import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart';

import '../constant/app_colors.dart';
import '../constant/app_text_style.dart';

class ReadingScreen extends StatefulWidget {
  final int surahIndex;
  const ReadingScreen({super.key,required this.surahIndex});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();
  bool isPLaying=false;
  int verse =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if(verse<getVerseCount(widget.surahIndex)){
         setState(() {
           verse++;
         });

          playSurahAudio(verse);
         if (_scrollController.hasClients && !(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) ) {
           _scrollController.animateTo(
             _scrollController.offset + (getVerse(widget.surahIndex,verse,verseEndSymbol: true).length*1.5),  // Adjust speed by changing this value
             duration: Duration(milliseconds: 100),
             curve: Curves.linear,
           );
         }
        }else{
          setState(() {
            verse =0;
            isPLaying =false;
          });
        }
      }
    });
  }


  playSurahAudio(verseNumber) {
    try{
      final audioUrl =  getAudioURLByVerse(widget.surahIndex, verseNumber);
      debugPrint("audioUrl == $audioUrl");
      audioPlayer.setUrl(audioUrl);
      audioPlayer.play();

    }catch(e){
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
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {

          if(verse==0){
            verse =1;
          }
          if(isPLaying){
            audioPlayer.pause();

          }else{
            playSurahAudio(verse);
          }
          isPLaying =!isPLaying;
        });
      },backgroundColor: Theme.of(context).primaryColor,child:isPLaying?SizedBox(height: 30,
          width: 30,
          child: Image.asset("assets/notes.gif",color: Theme.of(context).primaryColorLight,)): Icon(Icons.play_arrow,color: Theme.of(context).primaryColorLight,),),
      body: ListView.builder(
          controller: _scrollController,
        padding:EdgeInsets.symmetric(vertical: 20),
          itemCount: getVerseCount(widget.surahIndex),
          itemBuilder: (context,index){
            print(getVerse(widget.surahIndex,index+1,verseEndSymbol: true).length);
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))
              ),
              child: Text(getVerse(widget.surahIndex,index+1,verseEndSymbol: true),
                strutStyle: StrutStyle(height: 4.5),
                textAlign: TextAlign.end, style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color:verse==index+1?AppColors.primaryLightColor:AppColors.textColor,),
              ),
            );

      }),
    );
  }
}
