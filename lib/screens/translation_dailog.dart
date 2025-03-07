import 'package:flutter/material.dart';
import 'package:flutter_quran_app/constant/app_text_style.dart';
import 'package:quran/quran.dart';

class CustomDialogBox extends StatefulWidget {
  Function(String) onSelect;
   CustomDialogBox({
    super.key,
    required this.onSelect
  });

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.only(
          left: Constants.padding,
          top: Constants.padding,
          right: Constants.padding,
          bottom: Constants.padding),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Constants.padding),
          border: Border.all(color: Colors.grey)

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          Center(
            child: AppTextStyle.titleLargeText(context, "Translate to :"),
          ),
          Divider(),
          Expanded(child: ListView.builder(
            itemCount: language.length,
              itemBuilder: (context,index){
            return  ListTile(
              onTap: (){
                widget.onSelect(language.keys.elementAt(index));
                Navigator.pop(context);
                },
              title: AppTextStyle.titleMediumText(context,language.keys.elementAt(index) ),);
          }))
        ]
      ),
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;

}
var language ={
  "English":Translation.enSaheeh,
  "Urdu":Translation.urdu,
  "Farsi":Translation.faHusseinDari,
  "Malayalam":Translation.mlAbdulHameed,
  "Bengali":Translation.bengali,
  "French":Translation.frHamidullah,
  "Turkish":Translation.trSaheeh,
  "Portuguese":Translation.portuguese,
  "Italian":Translation.itPiccardo,
  "Dutch":Translation.nlSiregar,
  "Russian":Translation.ruKuliev,
  "Chinese":Translation.chinese,
  "Swedish":Translation.swedish,
  "Spanish":Translation.spanish,
  "Indonesian":Translation.indonesian
};