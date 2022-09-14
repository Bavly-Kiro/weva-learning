import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:platform_info/platform_info.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/levels.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/aTXTFld.dart';
import '../widgets/friend_card.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FriendsScreen extends StatefulWidget {
  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  TextEditingController searchController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFriends();

  }


  List<friend> friends = [];

  void getFriends() async {
    friends = [];

    if (await checkConnectionn()) {
      loading(context: context);

      FirebaseFirestore.instance
          .collection('friends')
          .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get(const GetOptions(source: Source.server))
          .then((value) {

        final List<friend> loadData = [];

        for (var element in value.docs) {
          //element.data();
          //log(element.data()['nameAr'].toString());

          loadData.add(friend(
            idToEdit: element.id,
            name: element.data()['name'] ?? "",
            number: element.data()['number'] ?? "",
            imageURL: element.data()['imageURL'] ?? "",
            userID: element.data()['userID'] ?? "",
            friendID: element.data()['friendID'] ?? "",

          ));
        }

        loadData.sort((a, b) => a.name.compareTo(b.name));

        setState(() {
          friends = loadData;
        });

        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        log(error.toString());
        showToast("Error: $error");
      });
    } else {
      showToast("Check Internet Connection !");
    }
  }




  @override
  Widget build(BuildContext context) {
    if(Platform.I.operatingSystem.isAndroid || Platform.I.operatingSystem.isIOS){
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TxtFld(
                onSubmit: (v) {
                  log("dsfsacsdcsadcsadcsdac sad2222222");
                },
                controller: searchController,
                label: LocaleKeys.search_num.tr(),
                picon: Icon(
                  Icons.search,
                  size: MediaQuery.of(context).size.width * 0.08,
                ),
              ),
            ),
            ListView.builder(
                itemCount: friends.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: friendCard(
                        context,
                        friends[index].name,
                        friends[index].imageURL,
                        friends[index].number,
                        friends[index].friendID,
                        1
                    ),
                  );
                }),
          ],
        ),
      );
    }
    else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TxtFld(
                onSubmit: (v) {
                  log("dsfsacsdcsadcsadcsdac sad bs web");
                },
                controller: searchController,
                label: LocaleKeys.search_num.tr(),
                picon: Icon(
                  Icons.search,
                  size: MediaQuery.of(context).size.width * 0.01,
                ),
              ),
            ),
            ListView.builder(
                itemCount: friends.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: webfriendCard(
                      context,
                      friends[index].name,
                      friends[index].imageURL,
                      friends[index].number,
                      friends[index].friendID,
                        1
                    ),
                  );
                }
                ),
          ],
        ),
      );
    }
  }
}
