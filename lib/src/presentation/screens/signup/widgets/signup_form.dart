import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:cricket_app/src/constants/enums.dart';
import 'package:cricket_app/src/presentation/screens/signup/bloc/signup_bloc.dart';
import 'package:cricket_app/src/utils/gradient_button.dart';
import 'package:cricket_app/src/utils/snackbars_and_toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late SignupBloc signupBloc;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    signupBloc = BlocProvider.of<SignupBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          (signupBloc.state is SignupInitial && (signupBloc.state as SignupInitial).selectedRole != null);

  void onSignup() {
    if (isPopulated) {
      signupBloc.add(SignupButtonPressed(
        email: emailController.text,
        password: passwordController.text,
        role: (signupBloc.state as SignupInitial).selectedRole!,
        name: nameController.text,
      ));
    } else {
      SnackbarsAndToasts.showErrorToast("Please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupFailure) {
          SnackbarsAndToasts.showErrorSnackbar(context, state.error);
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          if (state is SignupInitial) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return value!.isEmpty ? 'Email cannot be empty' : null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            signupBloc.add(TogglePasswordVisibility());
                          },
                        ),
                      ),
                      obscureText: !state.isShowPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return value!.isEmpty ? 'Password cannot be empty' : null;
                      },
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return value!.isEmpty ? 'Name cannot be empty' : null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ListTile(
                          title: const Text('Creator'),
                          leading: Radio<String>(
                            value: UserRole.operator.value,
                            groupValue: state.selectedRole,
                            onChanged: (value) {
                              signupBloc.add(RoleSelected(role: value!));
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('User'),
                          leading: Radio<String>(
                            value: UserRole.user.value,
                            groupValue: state.selectedRole,
                            onChanged: (value) {
                              signupBloc.add(RoleSelected(role: value!));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    state is SignupLoading
                        ? const CircularProgressIndicator(
                      color: COLOR_CONST.primaryColor,
                    )
                        : GradientButton(
                      title: 'Sign Up',
                      onTap: onSignup,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}