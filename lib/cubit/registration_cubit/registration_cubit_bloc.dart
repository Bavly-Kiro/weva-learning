import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weva/cubit/registration_cubit/registration_cubit_state.dart';

class RegistrationCubitBloc extends Cubit<RegistrationCubitState> {
  RegistrationCubitBloc() : super(RegistrationCubitInitial()) {}

  static RegistrationCubitBloc get(context) => BlocProvider.of(context);

  void SignUpWithFacebook() {}

  void SignUpWithGoogle() {}

  void SignUpWithEmail() {}

  void Continue() {}
}
