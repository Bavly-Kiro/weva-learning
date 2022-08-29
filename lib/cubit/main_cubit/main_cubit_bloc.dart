import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/screens/friends_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/scores_screen.dart';
import 'main_cubit_state.dart';

class MainCubitBloc extends Cubit<MainCubitState> {
  MainCubitBloc() : super(MainCubitInitial());

  static MainCubitBloc get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> screensNames = ['Home', 'Scores', 'Friends', 'Profile'];
  List<Widget> screens = [
    HomeScreen(),
    ScoreScreen(),
    FriendsScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(MainCubitIndexChanged());
  }
}
