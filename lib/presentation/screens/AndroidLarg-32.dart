import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weva/cubit/registration_cubit_bloc.dart';
import 'package:weva/cubit/registration_cubit_state.dart';
import 'package:weva/presentation/widgets/registration_button.dart';

import '../widgets/basic_text_form_filed.dart';

class ScreenAndroidLarg32 extends StatelessWidget {
  ScreenAndroidLarg32({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

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
                    child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Image(
                            image: AssetImage('assets/images/Arrow left.png')),
                      ),
                      Text(
                        "Enter your details",
                        style: GoogleFonts.montserrat(
                          color: const Color(0XFF3f3f3f),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09),
                      basicTextFormFiled(
                          hintText: "user name",
                          control: userNameController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter user name';
                            }
                            return null;
                          },
                          type: TextInputType.text),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      basicTextFormFiled(
                          hintText: "email adress",
                          control: emailController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      basicTextFormFiled(
                          hintText: "password",
                          control: passwordController,
                          validate: (value) {
                            if (value.length < 8) {
                              return 'Must contain 8 characters';
                            }
                            return null;
                          },
                          type: TextInputType.text),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      basicTextFormFiled(
                          hintText: "confirm password",
                          control: confirmPasswordController,
                          validate: (value) {
                            if (value != passwordController.text) {
                              return 'Must matc both password';
                            }
                            return null;
                          },
                          type: TextInputType.text),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09),
                      registrationButton(
                          text: "Continue",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cub.Continue();
                            }
                          },
                          context: context)
                    ],
                  ),
                )),
              ),
            );
          },
        ));
  }
}
