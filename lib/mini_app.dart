import 'package:flutter/material.dart';
import 'app.dart';
import 'bloc_observe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void initApp() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const WeatherApp());
}

