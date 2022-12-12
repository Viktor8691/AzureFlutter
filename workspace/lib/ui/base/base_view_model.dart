import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier  {

  BaseViewModel({Key? key}) {
    init();
  }

  void init();
}