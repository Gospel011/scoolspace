import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:schoolspace/data_layer/models/api_response.dart';
import 'package:schoolspace/data_layer/models/helper_models/error_model.dart';
import 'package:schoolspace/data_layer/models/user/user.dart';
import 'package:schoolspace/data_layer/repository/api_repo.dart';
import 'package:schoolspace/utils/enums/enums.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthState(state: Auth.initial));

  final ApiRepo _apiRepo = ApiRepo.instance;

  //? PRIVATE HELPER METHODS
  Future<void> _makeRequest({
    Map<String, dynamic>? body,
    required String endpoint,
    required Auth loadingState,
    required Auth successState,
    required Auth failedState,
    String? cityName,
    String method = 'GET',
    bool extendState = true,
  }) async {
    // emit loading state
    emit(state.copyWith(state: loadingState));

    final response = await _apiRepo.makeRequest(
      endpoint: endpoint,
      body: body,
      token: state.token,
      method: method,
    );

    _setState(response, failedState, successState,
        extendState: extendState, cityName: cityName);
  }

  void _setState(dynamic response, Auth failedState, Auth successState,
      {bool extendState = false, String? cityName}) {
    Auth? newState;

    if (response is AppError) {
      newState = failedState;
    } else {
      log.i("SUCCESS? ${response.success}");
      newState = response.success ? successState : failedState;
    }

    User? user;
    String? token;

    if (response is ApiResponse) {
      if (response.success) {
        user = response.user;
        token = response.token;
      }
    }

    emit(state.copyWith(
      state: newState,
      user: user,
      token: token,
      error: response is AppError ? response : null,
    ));

    log.i("NEW STATE IS: $state");
  }

  //* PUBLIC API ENDPOINTS

  void login(Map<String, dynamic> body) {
    _makeRequest(
        endpoint: 'api/v1/user/login',
        body: body,
        method: 'POST',
        loadingState: Auth.loggingIn,
        successState: Auth.loggedIn,
        failedState: Auth.loggingInFailed);
  }

  void signup(Map<String, dynamic> body) {
    _makeRequest(
        endpoint: 'api/v1/user/signup',
        body: body,
        method: 'POST',
        loadingState: Auth.signingUp,
        successState: Auth.signedUp,
        failedState: Auth.signingUpFailed);
  }

  void logout() {
    emit(AuthState(state: Auth.initial));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
