import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/weather/domain/mapper/mappers.dart';
import 'package:my_app/features/weather/presentation/cubit/weather_cubit.dart';

import '../cubit/weather_state.dart';

class SettingScreen extends StatelessWidget{
  const SettingScreen({super.key});

  static Route<void> route(WeatherCubit weatherCubit){
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: weatherCubit,
          child: const SettingScreen(),
        )

    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(title: const Text('Settings')),
     body: ListView(
       children: <Widget>[
         BlocBuilder<WeatherCubit, WeatherState>(
           buildWhen: (previous, current) =>
           previous.temperatureUnits != current.temperatureUnits,
           builder: (context, state) {
             return ListTile(
               title: const Text('Temperature Units'),
               isThreeLine: true,
               subtitle: const Text(
                 'Use metric measurements for temperature units.',
               ),
               trailing: Switch(
                 value: state.temperatureUnits!.isCelsius,
                 onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
               ),
             );
           },
         ),
       ],
     ),
   );
  }
}