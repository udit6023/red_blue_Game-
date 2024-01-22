import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Height1Cubit extends Cubit<double> {
  Height1Cubit() : super(0.0);

  void defualtHight(BuildContext context) {
    if (state > 0) {
      emit(0);
    }
    emit(state + MediaQuery.of(context).size.height * 0.5);
  }

  void increaseHeight() {
    emit(state + 10.0);
  }

  void decreaseHeight() {
    if (state >= 0) {
      emit(state - 10.0);
    }
  }

  int gameOver(context) {
    emit(MediaQuery.of(context).size.height * 0.5);
    return 1;
  }
}
