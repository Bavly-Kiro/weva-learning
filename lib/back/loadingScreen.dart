import 'package:flutter/material.dart';


class loadingScreen extends StatefulWidget {
  const loadingScreen({Key? key}) : super(key: key);

  @override
  State<loadingScreen> createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: const Center(child: CircularProgressIndicator()),
      actions: const [
/*                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultButton(
                      context: context,
                      color: Colors.white70,
                      textColor: Colors.black,
                      text: LocaleKeys.cancel.tr(),
                      onpressed: () {
                        Navigator.pop(context);
                      },
                    ),

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),*/
      ],
    );

  }
}
