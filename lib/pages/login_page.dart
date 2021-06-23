import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/auth/auth_repository.dart';
import 'package:kanban_board/auth/form_submission_status.dart';
import 'package:kanban_board/blocs/login/login_bloc.dart';
import 'package:kanban_board/blocs/login/login_event.dart';
import 'package:kanban_board/blocs/login/login_state.dart';
import 'package:kanban_board/pages/home_page.dart';
import 'package:kanban_board/widgets/custom_app_bar.dart';
import 'package:kanban_board/widgets/custom_button.dart';
import 'package:kanban_board/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final _usernameKey = GlobalKey<FormState>(debugLabel: 'usernameKey');
  final _passwordKey = GlobalKey<FormState>(debugLabel: 'passwordKey');

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CustomAppBar(title: 'Kanban'),
          body: BlocProvider(
            create: (context) => LoginBloc(authRepo: context.read<AuthRepository>()),
            child: _loginForm(),
          )),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(
              context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(token: state.token)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loginField(),
            SizedBox(height: 16),
            _passwordField(),
            SizedBox(height: 32),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextField(
            textFieldKey: _usernameKey,
            hintText: "Enter your username",
            validator: (value) => value!.length >= 4 ? null : "Minimum is 4 characters",
            onChanged: (value) {
              context.read<LoginBloc>().add(LoginUsernameChanged(username: value));
              _usernameKey.currentState!.validate();
            });
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextField(
            textFieldKey: _passwordKey,
            hintText: "Enter your password",
            validator: (value) => value!.length >= 8 ? null : "Minimum is 8 characters",
            isPassword: true,
            onChanged: (value) {
              context.read<LoginBloc>().add(LoginPasswordChanged(password: value));
              _passwordKey.currentState!.validate();
            });
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : CustomButton(
                title: 'Log in',
                onTap: () {
                  if (_passwordKey.currentState!.validate() & _usernameKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
              );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
