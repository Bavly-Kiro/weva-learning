import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/levels.dart';
import '../../constants.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/registration_button.dart';
import 'main_screen.dart';



class ChooseLevel extends StatefulWidget {
  @override
  State<ChooseLevel> createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  //bool isExpanded = false;

  List<level> levels = [];

  double money = 4.5;

  bool offerTrial = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLevels();

    getOffer();

  }


  void getLevels() async{

    levels = [];

    if(await checkConnectionn()){

      loading(context: context);

      FirebaseFirestore.instance.collection('levels').get(const GetOptions(source: Source.server))
          .then((value) {


        final List<level> loadData = [];

        for (var element in value.docs) {
          //element.data();
          //log(element.data()['nameAr'].toString());

          loadData.add(level(
            idToEdit: element.id,
            nameAr: element.data()['nameAr'] ?? "",
            nameEN: element.data()['nameEN'] ?? "",
            price: element.data()['price'] ?? "",
            checkBox: Checkbox(value: false, onChanged: (v){}),
            checkBoxValue: false,
            text: "",
            isExpanded: false,
            status: element.data()['status'] ?? "",

          ));
        }

        loadData.sort((a, b) => a.nameEN.compareTo(b.nameEN));

        setState(() {
          levels = loadData;
        });

        Navigator.of(context).pop();

      }).onError((error, stackTrace) {

        log(error.toString());
        showToast("Error: $error");

      });

    }else{

      showToast("Check Internet Connection !");

    }

  }

  void getOffer() async{

    if(await checkConnectionn()){

    loading(context: context);

    FirebaseFirestore.instance.collection('students').doc(FirebaseAuth.instance.currentUser!.uid).get(const GetOptions(source: Source.server))
        .then((value) {

          if(value.get("status") == ""){

            setState(() {
              offerTrial = true;
            });

          }else{
            setState(() {
              offerTrial = false;
            });
          }

          Navigator.of(context).pop();

    }).onError((error, stackTrace) {

    log(error.toString());
    showToast("Error: $error");

    });

    }else{

    showToast("Check Internet Connection !");

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      LocaleKeys.select_levels.tr(),
                      style: GoogleFonts.rubik(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    offerTrial? GestureDetector(
                      onTap: () async{

                        if(await checkConnectionn()){

                        loading(context: context);

                        FirebaseFirestore.instance.collection('students').doc(FirebaseAuth.instance.currentUser!.uid).update({
                        'status': "trial",
                        'trialStartingDate': DateTime.now(),

                        })
                            .then((value) {

                        Navigator.of(context).pop();

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainScreen()));

                        })
                            .catchError((error) {

                        showToast("Failed to add: $error");
                        print("Failed to add: $error");

                        });

                        }else{

                        showToast("Check Internet Connection !");

                        }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: Color(0XFF3787ff),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                LocaleKeys.free_trial.tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : Container()

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(0xffe4f1f8),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0,
                        left: 25.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\$ ${money}',
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                              Text(
                                '/${LocaleKeys.month.tr()}',
                                style: GoogleFonts.rubik(
                                  color: dodblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            '${LocaleKeys.month.tr()}:',
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/done.png',
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                LocaleKeys.tests.tr(),
                                style: GoogleFonts.rubik(
                                  color: dodblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/done.png',
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                LocaleKeys.videos.tr(),
                                style: GoogleFonts.rubik(
                                  color: dodblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/done.png',
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                LocaleKeys.games_chall.tr(),
                                style: GoogleFonts.rubik(
                                  color: dodblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ExpansionPanelList(
                  animationDuration: Duration(seconds: 1),
                  elevation: 1,
                  expandedHeaderPadding: EdgeInsets.all(8),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      levels[index].isExpanded = !isExpanded;
                    });
                  },
                  children: levels.map<ExpansionPanel>((level level) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          leading: level.checkBox,
                          title: Text(Localizations.localeOf(context).toString() == "en" ? level.nameEN : level.nameAr),
                        );
                      },
                      body: ListTile(
                        title: Text(level.text),
                      ),
                      isExpanded: level.isExpanded,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

