import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit_state.dart';

class HomeCubitBloc extends Cubit<HomeCubitState> {
  HomeCubitBloc() : super(HomeCubitInitial()) {}

  static HomeCubitBloc get(context) => BlocProvider.of(context);

  List<String> categoriesPaths = [
    "assets/images/categories/arabic.png",
    "assets/images/categories/biology.png",
    "assets/images/categories/chimestry.png",
    "assets/images/categories/computer.png",
    "assets/images/categories/english.png",
    "assets/images/categories/geography.png",
    "assets/images/categories/geology.png",
    "assets/images/categories/history.png",
    "assets/images/categories/math.png",
    "assets/images/categories/math-1.png",
    "assets/images/categories/math-2.png",
    "assets/images/categories/math-3.png",
    "assets/images/categories/physics.png",
    "assets/images/categories/psychology.png",
  ];
  List<String> categoriesNames = [
    "Arabic",
    "Biology",
    "Chemistry",
    "Computer",
    "English",
    "Geography",
    "Geology",
    "History",
    "Math",
    "Math 1",
    "Math 2",
    "Math 3",
    "Physics",
    "Psychology",
  ];
}
