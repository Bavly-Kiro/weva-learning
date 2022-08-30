import 'package:flutter/material.dart';

import '../widgets/frind_card.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: friendCard(
          context,
          'Friend ${index + 1}',
          'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg',
          "012",
        ),
      );
    });
  }
}
