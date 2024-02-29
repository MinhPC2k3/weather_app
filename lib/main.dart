import 'dart:io';

import 'package:flutter/material.dart';
import 'app.dart';
import 'bloc_observe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const WeatherApp());
}

void closeAppUsingSystemPop() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

void closeAppUsingExit() {
  exit(0);
}