// import 'package:agriculture_weather_app/data_layer/models/forecast/forecast.dart';
// import 'package:agriculture_weather_app/data_layer/models/weather_data/weather_data.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class ForecastDb {
//   ForecastDb._();
//   static ForecastDb? _instance;
//   late final Box<Forecast> _box;

//   static ForecastDb get instance {
//     _instance ??= ForecastDb._();

//     return _instance!;
//   }

//   Future<void> initDb() async {
//     Hive.registerAdapter(ForecastAdapter());
//     _box = await Hive.openBox<Forecast>('forecast-db');
//   }

//   void save(Forecast data) {
//     final String name = data.name;

//     _box.put(name, data);
//   }

//   Forecast? getForecastForCity(String name) {
//     return _box.get(name);
//   }

//   Forecast? getLastSavedData() {
//     final List<Forecast> result = _box.values.toList()
//       ..sort((a, b) => b.dateFetched.compareTo(a.dateFetched));

//     if (result.isNotEmpty) {
//       return result.first;
//     } else {
//       return null;
//     }
//   }
// }
