import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

import '../constant/app_colors.dart';
import '../constant/app_text_style.dart';

class ReadingScreen extends StatelessWidget {
  final int surahIndex;
  const ReadingScreen({super.key,required this.surahIndex});

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
              getSurahName(surahIndex),
              Theme.of(context).primaryColor,
            ),
            AppTextStyle.titleLargeText(
              context,
              getSurahNameArabic(surahIndex),
              Theme.of(context).primaryColorLight,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding:EdgeInsets.symmetric(vertical: 20),
          itemCount: getVerseCount(surahIndex),
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))
              ),
              child: Text(getVerse(surahIndex,index+1,verseEndSymbol: true),
                strutStyle: StrutStyle(height: 4.5),
                textAlign: TextAlign.end, style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color:AppColors.textColor,),
              ),
            );

      }),
    );
  }
}
