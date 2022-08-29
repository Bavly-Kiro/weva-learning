import 'package:flutter/material.dart';

import '../widgets/frind_card.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return friendCard(
        context,
        'Friend ${index + 1}',
        'https://www.onlinewebfonts.com/icon/553330',
        "01222222222",
      );
    });
  }
}
