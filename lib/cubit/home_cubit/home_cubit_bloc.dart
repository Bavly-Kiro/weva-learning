import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit_state.dart';

class HomeCubitBloc extends Cubit<HomeCubitState> {
  HomeCubitBloc() : super(HomeCubitInitial()) {}

  static HomeCubitBloc get(context) => BlocProvider.of(context);

}
