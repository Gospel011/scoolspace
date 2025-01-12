// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_cubit.dart';

class AuthState {
  final Auth state;
  final User? user;
  final String? token;
  final AppError? error;
  AuthState({required this.state, this.user, this.token, this.error});

  AuthState copyWith(
      {Auth? state, User? user, String? token, AppError? error}) {
    return AuthState(
      state: state ?? this.state,
      user: user ?? this.user,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'token': token,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      state: map['user'] != null ? Auth.loggedIn : Auth.initial,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source) as Map<String, dynamic>);
}
