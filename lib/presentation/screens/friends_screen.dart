import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../translations/locale_keys.g.dart';
import '../widgets/aTXTFld.dart';
import '../widgets/friend_card.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FriendsScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
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
                itemCount: 15,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: webfriendCard(
                      context,
                      'Friend ${index + 1}',
                      'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg',
                      "012",
                    ),
                  );
                }),
          ],
        ),
      );
    } else {
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
                itemCount: 15,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: friendCard(
                      context,
                      'Friend ${index + 1}',
                      'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg',
                      "012",
                    ),
                  );
                }),
          ],
        ),
      );
    }
  }
}
