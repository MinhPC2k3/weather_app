import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minh_weather_app/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:minh_weather_app/features/weather/domain/use_cases/weather_usecase.dart';
import 'features/weather/presentation/view/search_screen.dart';
import 'features/weather/presentation/widget/weather_empty.dart';
import 'features/weather/presentation/widget/weather_populated.dart';
import 'features/weather/presentation/widget/weather_error.dart';
import 'features/weather/presentation/widget/weather_loading.dart';
import 'features/weather/domain/mapper/mappers.dart';
import 'features/weather/presentation/cubit/weather_cubit.dart';
import 'features/weather/presentation/cubit/weather_state.dart';
import 'features/weather/presentation/view/setting_screen.dart';

class WeatherApp extends StatefulWidget{
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late WeatherUseCase weatherUseCase;
  final repo = WeatherRepositoriesImp();
  @override
  void initState(){
    super.initState();
    weatherUseCase= WeatherUseCase(repository: repo);
  }

  @override
  Widget build(BuildContext context){
    return RepositoryProvider.value(
        value: weatherUseCase,
        // child: BlocProvider(
        //   create: (_) => WeatherCubit(weatherUseCase: weatherUseCase),
        //   child: const WeatherAppView(),
        // )
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          // colorScheme: ColorScheme.fromSeed(seedColor: color),
          textTheme: GoogleFonts.rajdhaniTextTheme(),
        ),
        home: BlocProvider(
            create: (context) => WeatherCubit(weatherUseCase: context.read<WeatherUseCase>()),
            child: BlocConsumer<WeatherCubit, WeatherState>(
              builder: (context, state) {
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.of(context).push<void>(
                            SettingScreen.route(context.read<WeatherCubit>()),
                          );
                        },
                      ),
                    ],
                  ),
                  body: Center(
                      child:switch (state.weatherStatus) {
                        WeatherStatus.initial => const WeatherEmpty(),
                        WeatherStatus.loading => const WeatherLoading(),
                        WeatherStatus.success =>
                            WeatherPopulated(
                              weather: state.weather,
                              units: state.temperatureUnits!,
                              onRefresh: () {
                                return context.read<WeatherCubit>().refreshWeather();
                              },
                            ),
                        WeatherStatus.failure =>
                        const WeatherError(),
                        null => const WeatherError(),
                      }
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.search, semanticLabel: 'Search'),
                    onPressed: () async {
                      final city = await Navigator.of(context).push(SearchScreen.route());
                      await context.read<WeatherCubit>().fetchWeather(city);
                    },
                  ),
                );
              },
              listener: (BuildContext context, state) {  },

            )
        ),
      ),
    );
  }
}

// class WeatherAppView extends StatelessWidget {
//   const WeatherAppView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         // colorScheme: ColorScheme.fromSeed(seedColor: color),
//         textTheme: GoogleFonts.rajdhaniTextTheme(),
//       ),
//       home: const WeatherPage(),
//     );
//   }
// }

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(weatherUseCase: context.read<WeatherUseCase>()),
      child: BlocConsumer<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push<void>(
                      SettingScreen.route(context.read<WeatherCubit>()),
                    );
                  },
                ),
              ],
            ),
            body: Center(
              child:switch (state.weatherStatus) {
                     WeatherStatus.initial => const WeatherEmpty(),
                     WeatherStatus.loading => const WeatherLoading(),
                     WeatherStatus.success =>
                       WeatherPopulated(
                        weather: state.weather,
                        units: state.temperatureUnits!,
                        onRefresh: () {
                          return context.read<WeatherCubit>().refreshWeather();
                        },
                      ),
                     WeatherStatus.failure =>
                       const WeatherError(),
                     null => const WeatherError(),
                  }
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.search, semanticLabel: 'Search'),
              onPressed: () async {
                final city = await Navigator.of(context).push(SearchScreen.route());
                await context.read<WeatherCubit>().fetchWeather(city);
              },
            ),
          );
        },
        listener: (BuildContext context, state) {  },

      )
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingScreen.route(context.read<WeatherCubit>()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            // if (state.weatherStatus!.isSuccess) {
            //   context.read<ThemeCubit>().updateTheme(state.weather);
            // }
          },
          builder: (context, state) {
            switch (state.weatherStatus) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherPopulated(
                  weather: state.weather,
                  units: state.temperatureUnits!,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                );
              case WeatherStatus.failure:
                return const WeatherError();
              case null:
                // TODO: Handle this case.
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchScreen.route());
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
