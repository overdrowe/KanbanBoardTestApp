import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/auth/auth_repository.dart';
import 'package:kanban_board/auth/form_submission_status.dart';
import 'package:kanban_board/blocs/login/login_event.dart';
import 'package:kanban_board/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(formStatus: InitialFormStatus());
      yield state.copyWith(username: event.username);

    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(formStatus: InitialFormStatus());
      yield state.copyWith(password: event.password);

    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        yield state.copyWith(token: await authRepo.login(password: state.password, username: state.username));
        print(state.token);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}
