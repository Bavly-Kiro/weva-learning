import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../screens/friend_profile.dart';
import 'alert_dialog.dart';

Widget friendCard(
    BuildContext context, String name, String imageUrl, String phone, String idToEdit, int type) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FriendProfile(),
          ));
    },
    child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              // backgroundColor: Colors.blue,
              radius: MediaQuery.of(context).size.width * 0.09,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    phone,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF616161),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(0X333787ff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child:

                    type == 1 ?
                    InkWell(
                      onTap: () async{

                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return callingg(
                                context,
                                "Ringing......",
                                idToEdit,
                              );
                            });


                        if(await checkConnectionn()){

                          FirebaseFirestore.instance.collection('students').doc(idToEdit).update({
                            'call': 1,
                            'callerID': FirebaseAuth.instance.currentUser!.uid,



                          })
                              .then((value) {



                          })
                              .catchError((error) {

                            showToast("Failed to add: $error");
                            print("Failed to add: $error");

                          });

                        }else{

                          showToast("Check Internet Connection !");

                        }

                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.ac_unit,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            'GAME',
                            style: GoogleFonts.rubik(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                        :
                    IconButton(
                        onPressed: () async{

                          //check if he is already a friend or not first

                          if(await checkConnectionn()){

                            loading(context: context);

                            //change name to be dynamic not static
                            FirebaseFirestore.instance.collection('friends').add({
                              'name': name,
                              'number': phone,
                              'imageURL': imageUrl,
                              'userID': FirebaseAuth.instance.currentUser!.uid,
                              'friendID': idToEdit,


                            })
                                .then((value) {

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();

                            })
                                .catchError((error) {

                              showToast("Failed to add: $error");

                            });

                          }else{

                            showToast("Check Internet Connection !");

                          }

                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        )),



                  )),
            ),
          ],
        )),
  );
}

Widget webfriendCard(
    BuildContext context, String name, String imageUrl, String phone, String idToEdit, int type) {
  return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            // backgroundColor: Colors.blue,
            radius: MediaQuery.of(context).size.width * 0.03,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                phone,
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF616161),
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0X333787ff),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: type == 1 ?
                  InkWell(
                    onTap: () async{

                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return callingg(
                                context,
                                "Ringing......",
                              idToEdit,
                            );
                          });


                      if(await checkConnectionn()){

                        FirebaseFirestore.instance.collection('students').doc(idToEdit).update({
                          'call': 1,
                          'callerID': FirebaseAuth.instance.currentUser!.uid,



                        })
                            .then((value) {



                        })
                            .catchError((error) {

                          showToast("Failed to add: $error");
                          print("Failed to add: $error");

                        });

                      }else{

                        showToast("Check Internet Connection !");

                      }

                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.ac_unit,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'GAME',
                          style: GoogleFonts.rubik(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                  :
                  IconButton(
                      onPressed: () async{

                        //check if he is already a friend or not first

                        if(await checkConnectionn()){

                        loading(context: context);

                        //change name to be dynamic not static
                        FirebaseFirestore.instance.collection('friends').add({
                          'name': name,
                          'number': phone,
                          'imageURL': imageUrl,
                          'userID': FirebaseAuth.instance.currentUser!.uid,
                          'friendID': idToEdit,


                        })
                            .then((value) {

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();

                        })
                            .catchError((error) {

                        showToast("Failed to add: $error");

                        });

                        }else{

                        showToast("Check Internet Connection !");

                        }

                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      )),
                )),
          ),
        ],
      ));
}
