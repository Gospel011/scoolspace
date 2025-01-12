// import 'package:agriculture_weather_app/data_layer/models/weather_data/weather_data.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:agriculture_weather_app/utils/logger.dart';

// class WeatherDataDb {
//   WeatherDataDb._();
//   static WeatherDataDb? _instance;
//   late final Box<WeatherData> _box;

//   static WeatherDataDb get instance {
//     _instance ??= WeatherDataDb._();

//     return _instance!;
//   }

//   Future<void> initDb() async {
//     Hive.registerAdapter(WeatherDataAdapter());
//     _box = await Hive.openBox<WeatherData>('weather-data-db');

//     log("INTIAL WEATHER DB LOADED WITH VALUES: ${_box.values}");
//   }

//   void save(WeatherData data) {
//     final String? name = data.name;

//     if (name == null || name.isEmpty) return;

//     _box.put(name, data);
//   }

//   WeatherData? getWeatherDataForCity(String name) {
//     return _box.get(name);
//   }

//   WeatherData? getLastSavedData() {
//     final List<WeatherData> result = _box.values.toList()
//       ..sort((a, b) => b.dateFetched.compareTo(a.dateFetched));

//     if (result.isNotEmpty) {
//       return result.first;
//     } else {
//       return null;
//     }
//   }
// }
