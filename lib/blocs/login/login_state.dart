import 'package:kanban_board/auth/form_submission_status.dart';

class LoginState {
  final String username;
  final String password;
  final FormSubmissionStatus formStatus;
  final String token;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.token = '',
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
    String? token,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      token: token ?? this.token,
    );
  }
}
