import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:weva/presentation/widgets/dropdown_textField.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/country.dart';
import '../../cubit/registration_cubit_bloc.dart';
import '../../cubit/registration_cubit_state.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/aTXTFld.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/registration_button.dart';
import '45_choose_level.dart';

class PersonalInformation extends StatefulWidget {
  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  var formKey = GlobalKey<FormState>();

  late DateTime selectedDate;

  late DateTime selectedYear;

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  TextEditingController DateController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();



  @override
  void initState() {
    super.initState();


    getGrade();

  }


  List<grade> grades = [];
  List<String> gradess = [];

  List<country> countries = [];
  List<String> countriess = [];

  List<major> majors = [];
  List<String> majorss = [];


  void getGrade() async{

    grades = [];

    if(await checkConnectionn()){

      loading(context: context);

      FirebaseFirestore.instance.collection('grades').get(const GetOptions(source: Source.server))
          .then((value) {


        final List<grade> loadData = [];

        for (var element in value.docs) {
          // element.data();
          //log(element.data()['nameAr'].toString());

          loadData.add(grade(
            idToEdit: element.id,
            nameAr: element.data()['nameAr'] ?? "",
            nameEN: element.data()['nameEN'] ?? "",
            countryID: element.data()['countryID'] ?? "",
            majorID: element.data()['majorID'] ?? "",


            userDoneAction: element.data()['userDoneAction'] ?? "",
            LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
            status: element.data()['status'] ?? "",

          ));

          Localizations.localeOf(context).toString() == "en" ? gradess.add(element.data()['nameEN'] ?? "")
              :gradess. add(element.data()['nameAr'] ?? "");

        }

        setState(() {
          grades = loadData;
        });

       // Navigator.of(context).pop();

        getCountries();

      }).onError((error, stackTrace) {

        log(error.toString());
        showToast("Error: $error");

      });

    }else{

      showToast("Check Internet Connection !");

    }

  }


  void getCountries() async{

    countries = [];
    countriess = [];


    if(await checkConnectionn()){

     // loading(context: context);

      FirebaseFirestore.instance.collection('countries').get(const GetOptions(source: Source.server))
          .then((value) {


        final List<country> loadData = [];

        for (var element in value.docs) {
          // element.data();
          // log(element.data()['nameAr'].toString());

          loadData.add(country(
            idToEdit: element.id,
            nameAr: element.data()['nameAr'] ?? "",
            nameEN: element.data()['nameEN'] ?? "",
            code: element.data()['code'] ?? "",
            userDoneAction: element.data()['userDoneAction'] ?? "",
            LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
            status: element.data()['status'] ?? "",

          ));

         // countriess.add(element.data()['nameEN'] ?? "");

          Localizations.localeOf(context).toString() == "en" ? countriess.add(element.data()['nameEN'] ?? "")
              :countriess.add(element.data()['nameAr'] ?? "");

        }

        setState(() {
          countries = loadData;
        });

       // Navigator.of(context).pop();

        getMajors();

      }).onError((error, stackTrace) {

        log(error.toString());
        showToast("Error: $error");

      });

    }else{

      showToast("Check Internet Connection !");

    }

  }


  void getMajors() async{

    majors = [];
    majorss = [];


    if(await checkConnectionn()){

      //loading(context: context);

      FirebaseFirestore.instance.collection('majors').get(const GetOptions(source: Source.server))
          .then((value) {


        final List<major> loadData = [];

        for (var element in value.docs) {
          // element.data();
          // log(element.data()['nameAr'].toString());

          loadData.add(major(
            idToEdit: element.id,
            nameAr: element.data()['nameAr'] ?? "",
            nameEN: element.data()['nameEN'] ?? "",
            countryID: element.data()['countryID'] ?? "",
            userDoneAction: element.data()['userDoneAction'] ?? "",
            LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
            status: element.data()['status'] ?? "",

          ));

          //majorss.add(element.data()['nameEN'] ?? "");

          Localizations.localeOf(context).toString() == "en" ? majorss.add(element.data()['nameEN'] ?? "")
              : majorss.add(element.data()['nameAr'] ?? "");

        }

        setState(() {
          majors = loadData;
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



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegistrationCubitBloc(),
        child: BlocConsumer<RegistrationCubitBloc, RegistrationCubitState>(
          listener: (BuildContext context, RegistrationCubitState state) {},
          builder: (BuildContext context, RegistrationCubitState state) {
            RegistrationCubitBloc cub = RegistrationCubitBloc.get(context);


            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        // top: 50,
                        right: 20,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10,
                            ),
                            Text(
                              LocaleKeys.personal_info.tr(),
                              style: GoogleFonts.montserrat(
                                color: const Color(0XFF3f3f3f),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                            TxtFld(
                              picon: Icon(Icons.person_outline),
                              controller: fullNameController,
                              label: LocaleKeys.full_name.tr(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            DropDown(
                              context: context,
                              onChanged: (value) {
                                GenderValue = value;
                                cub.emit(test());
                              },
                              Selecteditems:
                              Localizations.localeOf(context).toString() == "en"? Genders.map(buildMenuitem).toList() : arabicGenders.map(buildMenuitem).toList(),
                              hint: LocaleKeys.gender.tr(),
                              SelectedValue: GenderValue,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            TxtFld(
                              picon: Icon(Icons.date_range),
                              controller: DateController,
                              keyType: null,
                              readOnly: true,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                ).then((value) {
                                  print(value);

                                  selectedDate = value!;
                                  print(selectedDate);
                                  DateController.text =
                                      selectedDate.year.toString() +
                                          '-' +
                                          selectedDate.month.toString() +
                                          '-' +
                                          selectedDate.day.toString();
                                });
                              },
                              label: LocaleKeys.date_birth.tr(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please choose your birth date';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            DropDown(
                              context: context,
                              onChanged: (value) {
                                countryValue = value;

                                List<String> tmp = [];

                                for (var element in majors) {
                                  if(element.countryID == countries[countriess.indexWhere((f) => f == countryValue)].idToEdit){

                                    tmp.add(Localizations.localeOf(context).toString() == "en"? element.nameEN : element.nameAr);

                                    log(element.idToEdit.toString());
                                    log(Localizations.localeOf(context).toString() == "en"? element.nameEN : element.nameAr);

                                  }
                                }
                                log(countriess.toString());
                                EduValue = null;
                                gradeValue = null;

                                majorss = tmp;

                                cub.emit(test());
                              },
                              Selecteditems:
                              countriess.map(buildMenuitem).toList(),
                              hint: LocaleKeys.country.tr(),
                              SelectedValue: countryValue,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            DropDown(
                              context: context,
                              onChanged: (value) {
                                EduValue = value;

                                List<String> tmp = [];

                                for (var element in grades) {

                                  if(element.idToEdit.isNotEmpty){

                                    if(element.majorID == majors[majors.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == EduValue)].idToEdit){
                                      tmp.add(Localizations.localeOf(context).toString() == "en"? element.nameEN : element.nameAr);
                                    }

                                  }

                                }

                                gradeValue = null;

                                gradess = tmp;

                                cub.emit(test());
                              },
                              Selecteditems:
                              majorss.map(buildMenuitem).toList(),
                              hint: LocaleKeys.Edu_year.tr(),
                              SelectedValue: EduValue,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            DropDown(
                              context: context,
                              onChanged: (value) {
                                gradeValue = value;
                                cub.emit(test());
                              },
                              Selecteditems:
                               gradess.map(buildMenuitem).toList(),
                              hint: LocaleKeys.grade.tr(),
                              SelectedValue: gradeValue,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            TxtFld(
                              picon: Icon(Icons.email),
                              controller: emailController,
                              keyType: TextInputType.emailAddress,
                              label: LocaleKeys.email.tr(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty field required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            TxtFld(
                              picon: Icon(Icons.lock),
                              controller: passController,
                              keyType: TextInputType.emailAddress,
                              label: LocaleKeys.pass.tr(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty field required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            TxtFld(
                              picon: Icon(Icons.lock),
                              controller: confirmPassController,
                              keyType: TextInputType.emailAddress,
                              label: LocaleKeys.confirm_pass.tr(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty field required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                            ),
                            registrationButton(
                              text: LocaleKeys.sign_up.tr(),
                              onTap: () async{
                                if (formKey.currentState!.validate()) {
                                  //navigate b2a hna



                                    if(fullNameController.text.isNotEmpty && GenderValue!= null
                                        && selectedDate.toString().isNotEmpty && countryValue!= null
                                        && EduValue!= null && gradeValue!= null
                                        && emailController.text.isNotEmpty && passController.text.isNotEmpty
                                        && confirmPassController.text.isNotEmpty){


                                          if(passController.text == confirmPassController.text){

                                            if(await checkConnectionn()){

                                              loading(context: context);



                                              try {

                                                //log((grades[grades.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == gradeValue)].idToEdit).toString());

                                                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                                    email: emailController.text,
                                                    password: confirmPassController.text
                                                ).then((value) async {

                                                  log("hna");
                                                  log(await FirebaseAuth.instance.currentUser!.uid);

                                                FirebaseFirestore.instance.collection('students').doc(await FirebaseAuth.instance.currentUser!.uid).set({
                                                'name': fullNameController.text,
                                                'gender': GenderValue == "Male" || GenderValue == "ذكر" ? 1 : 2, //Genders.indexWhere((f) => f == GenderValue),
                                                'dateOfBirth': selectedDate,
                                                'countryID': countries[countriess.indexWhere((f) => f == countryValue)].idToEdit,
                                                'majorID': majors[majors.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == EduValue)].idToEdit,
                                                'gradeID': grades[grades.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == gradeValue)].idToEdit,
                                                'email': emailController.text,
                                                'pass': confirmPassController.text,
                                                'online': 0,
                                                'imageURL': "",
                                                  'status': "",

                                                'userID': await FirebaseAuth.instance.currentUser!.uid ?? "-",
                                                'dateCreated': DateTime.now(),

                                              })
                                                  .then((value) {

                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChooseLevel()));

                                              })
                                                  .catchError((error) {

                                                showToast("Failed to add: $error");
                                                print("Failed to add: $error");

                                              });



                                                });

                                              } on FirebaseAuthException catch (e) {

                                                if (e.code == 'weak-password') {

                                                  Navigator.of(context).pop();
                                                  log('The password provided is too weak.');

                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return textAlert(
                                                            context,
                                                            LocaleKeys.weak_pass1.tr(),
                                                            LocaleKeys.weak_pass2.tr()
                                                        );
                                                      });

                                                }
                                                else if (e.code == 'email-already-in-use') {

                                                  Navigator.of(context).pop();
                                                  log('The account already exists for that email.');

                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return textAlert(
                                                            context,
                                                            LocaleKeys.email_used1.tr(),
                                                            LocaleKeys.email_used2.tr()
                                                        );
                                                      });

                                                }
                                                else if (e.code == 'invalid-email') {

                                                  Navigator.of(context).pop();
                                                  log('invalid email.');

                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return textAlert(
                                                            context,
                                                            LocaleKeys.inv_email1.tr(),
                                                            LocaleKeys.inv_email2.tr()
                                                        );
                                                      });

                                                }
                                                else if (e.code == 'operation-not-allowed') {

                                                  Navigator.of(context).pop();
                                                  log('operation not allowed.');

                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return textAlert(
                                                            context,
                                                            LocaleKeys.signup_error1.tr(),
                                                            LocaleKeys.signup_error2.tr()
                                                        );
                                                      });

                                                }

                                              } catch (e) {
                                                log(e.toString());
                                              }

                                            }
                                            else{

                                            //  showToast("Check Internet Connection !");

                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return noInternetAlert(
                                                        context,
                                                      );
                                                    });

                                            }


                                          }else{

                                            //pass not equal to confirm pass

                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return textAlert(
                                                        context,
                                                        LocaleKeys.pass_not_conf.tr(),
                                                          LocaleKeys.pass_not_conf2.tr()
                                                      );
                                                    });

                                          }


                                      }





                                }
                              },
                              context: context,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            );
          },
        ));
  }
}
