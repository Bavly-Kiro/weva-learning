import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:platform_info/platform_info.dart';

import '../widgets/friend_card.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.I.operatingSystem.isAndroid ||
        Platform.I.operatingSystem.isIOS) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ScoreCard(
                        context,
                        // friends[index].name,
                        // friends[index].imageURL,
                        // friends[index].number,
                        // friends[index].idToEdit,
                        'Name',
                        'http://placekitten.com/g/200/300',
                        'number',
                        'id bayen',
                        1,
                        '${index + 1}'),
                  );
                }),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: webScoreCard(
                      context,
                      'Name',
                      'http://placekitten.com/g/200/300',
                      'number',
                      'id bayen',
                      // friends[index].name,
                      // friends[index].imageURL,
                      // friends[index].number,
                      // friends[index].friendID,
                      1,
                      '${index + 1}',
                    ),
                  );
                }),
          ],
        ),
      );
    }
  }
}
