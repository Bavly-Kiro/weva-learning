import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawer_cubit_state.dart';

class DrawerCubitBloc extends Cubit<DrawerCubitState> {
  DrawerCubitBloc() : super(DrawerCubitInitial());

  static DrawerCubitBloc get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeTheme(bool isDark) {
    this.isDark = isDark;
    emit(ChangeThemeDrawerCubitState());
  }
}
