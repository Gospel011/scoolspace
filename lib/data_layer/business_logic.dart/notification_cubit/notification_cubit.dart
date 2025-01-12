// // import 'package:app/utils/helpers/logger.dart';
// import 'package:agriculture_weather_app/data_layer/models/notification/notification.dart';
// import 'package:agriculture_weather_app/utils/enums/enums.dart';
// import 'package:agriculture_weather_app/utils/helpers/notifications_db.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'notification_state.dart';

// class NotificationsCubit extends Cubit<NotificationState> {
//   NotificationsCubit(List<Notification> notifications)
//       : super(NotificationState(
//           state: NotificationStates.initial,
//           notifications: notifications,
//           count: 0,
//         )) {
//     // sync notification count
//     emit(state.copyWith(
//       count: notifications.length,
//     ));
//   }

//   void addNotification(Notification notification) {
//     final notifications = [...state.notifications, notification]
//       ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

//     emit(state.copyWith(
//         notifications: notifications, count: notifications.length));
//   }

//   void clearAll() {
//     emit(state.copyWith(notifications: [], count: 0));
//   }
// }
