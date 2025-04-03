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
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Image.asset('karatte_kid/assets/images/log_image.png',
                    // height: 200,),/
                    Image.asset(
                      'assets/images/log_image.png',
                      height: 230,
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
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Welcome to Company name ",
                        style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const BoxDecoration(
                    color: Palete.lightGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: model.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: FontFamily.poppins,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextFormField(
                            controller: model.usernameController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => validateEmail(value),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'john@example.com',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          TextFormField(
                            controller: model.passcodeController,
                            obscureText: !model.isPasswordVisible,
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a password'
                                : null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
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
                                  size: 18,
                                ),
                                onPressed: model.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          loginButton(
                            label: "Login",
                            onPressed: () {},
                          ),

                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       if (model.formKey.currentState!.validate()) {
                          //         model.login(
                          //           model.usernameController.text.trim(),
                          //           model.passcodeController.text.trim(),
                          //         );
                          //         if (model.isLogedIn!) {
                          //           navigationService.pushNamedAndRemoveUntil(
                          //               RoutePaths.homeview);
                          //         } else {
                          //           showToast(
                          //               'Incorrect username or password. Please try again.');
                          //         }
                          //       }
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.white,
                          //       padding:
                          //           const EdgeInsets.symmetric(vertical: 14),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(15),
                          //       ),
                          //     ),
                          //     child: Text(
                          //       "Login",
                          //       style: TextStyle(
                          //           color: Colors.red,
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.bold,
                          //           fontFamily: FontFamily.poppins),
                          //     ),
                          //   ),
                          // ),
                          // // const SizedBox(height: 15),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
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
          stops: const [0, 0.5, 1],
          colors: [
            Palete.primaryColor,
            Palete.primaryColor,
            Palete.primaryColor
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
                style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppins,
                  color: const  Color(0xffFFFFFF),
                ),
              ),
      ),
    ),
  );
}
