import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/app/utils.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/login/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewmodel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: Palete.primaryColor,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Column(
              children: [
                // Top section with logo and welcome text
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/images/log_image__1.png',
                        height: 200, // Reduced height to give more space
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Hello!",
                          style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Welcome to Company name",
                          style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Form section
                Expanded(
                  child: Container(
                    width: double.infinity,
                    
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Palete.lightGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30), // Reduced radius
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 16),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Palete.primaryColor,
                                  fontSize: 22,
                                  fontFamily: FontFamily.poppins,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // Email field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                controller: model.usernameController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => validateEmail(value),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),

                            // Password field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                controller: model.passcodeController,
                                obscureText: !model.isPasswordVisible,
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a password'
                                    : null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      model.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    onPressed: model.togglePasswordVisibility,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            // Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Palete.primaryColor,
                                    fontFamily: FontFamily.poppins,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              child: loginButton(
                                isBusy: model.isBusy,
                                label: "LOGIN",
                                onPressed: () async {
                                  if (model.isBusy) return;
                                  if (model.formKey.currentState!.validate()) {
                                    model.setBusy(true);
                                    await model.login(
                                      model.usernameController.text.trim(),
                                      model.passcodeController.text.trim(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.5, 1],
          colors: [
            Palete.primaryColor,
            Palete.primaryColor,
            Palete.primaryColor,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Palete.primaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, 4.0),
              blurRadius: 2.0,
              spreadRadius: 1.0,
              color: Palete.primaryColor.withOpacity(0.8),
            ),
            BoxShadow(
              offset: const Offset(0.0, -4.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
              color: Palete.primaryColor.withOpacity(0.8),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.5, 1],
            colors: [
              Palete.primaryColor,
              Palete.primaryColor,
              Palete.primaryColor
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(0),
        child: (isBusy ?? false)
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppins,
                  color: const Color(0xffFFFFFF),
                ),
              ),
      ),
    ),
  );
}
