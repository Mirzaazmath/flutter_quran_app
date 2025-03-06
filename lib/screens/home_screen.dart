import 'package:flutter/material.dart';
import 'package:flutter_quran_app/constant/app_strings.dart';
import 'package:flutter_quran_app/constant/app_text_style.dart';
import 'package:quran/quran.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 300,
            centerTitle: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppStrings.alQuran),
              background: Hero(
                tag: AppStrings.appLogo,
                child: Image.asset(AppStrings.appLogo),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: totalSurahCount,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: AppTextStyle.titleMediumText(
                      context,
                      "${index + 1}",
                      Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  shape: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextStyle.titleLargeText(
                        context,
                        getSurahName(index + 1),
                        Theme.of(context).primaryColor,
                      ),
                      AppTextStyle.titleMediumText(
                        context,
                        getSurahNameArabic(index + 1),
                        Theme.of(context).primaryColorLight,
                      ),
                    ],
                  ),
                  subtitle: AppTextStyle.titleSmallText(
                    context,
                    "${getVerseCount(index + 1)} Verse",
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
