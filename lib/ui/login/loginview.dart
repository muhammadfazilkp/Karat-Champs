import 'package:flutter/material.dart';
import 'package:karatte_kid/app/utils.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/login/login_viewmodel.dart';
import 'package:karatte_kid/widgets/tost.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class Loginview extends StatelessWidget {
  const Loginview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewmodel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, _) {
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome to Karate Academy!\nUnlock your journey to mastery.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 15),

                    const Image(
                      image: AssetImage('assets/images/karatte.png'),
                      height: 150,
                    ),
                    const SizedBox(height: 45),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login Your Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: model.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Jhone@gmail.com',
                              hintStyle: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: model.usernameController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return validateEmail(value);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 13,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  model.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: model.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            obscureText: !model.isPasswordVisible,
                            controller: model.passcodeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// **Login Button**
                    loginButton(
                      label: "Login",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          model.login(
                            model.usernameController.text.trim(),
                            model.passcodeController.text.trim(),
                          );
                          if (model.isLogedIn!) {
                            navigationService
                                .pushNamedAndRemoveUntil(RoutePaths.homeview);
                          }
                          showToast(
                              'Incorrect username or password. Please try again.');
                        }
                        model.usernameController.text = '';
                        model.passcodeController.text = '';
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewmodel(apiservice: Provider.of(context)),
    );
  }
}

Widget loginButton({
  required String label,
  required VoidCallback onPressed,
  Color? color,
  double? height,
  bool? isBusy,
  EdgeInsetsGeometry? margin,
  String? count,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: margin ?? const EdgeInsets.all(10),
      height: height ?? 52,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(
          width: .2,
          color: Colors.white,
          style: BorderStyle.solid,
        ),
        // borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.5, 1],
          colors: [
            Colors.black,
            Colors.black,
            Colors.black,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, 4.0),
              blurRadius: 2.0,
              spreadRadius: 1.0,
              color: Colors.black.withOpacity(0.8),
            ),
            BoxShadow(
              offset: const Offset(0.0, -4.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
              color: Colors.black.withOpacity(0.8),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.5, 1],
            colors: [
              Colors.black,
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(0),
        child: (isBusy ?? false)
            ? const CircularProgressIndicator(
                color: Colors.white, // Progress indicator is white
                strokeWidth: 2,
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(
                      0xffFFFFFF), // Text color is white for visibility on black
                ),
              ),
      ),
    ),
  );
}
