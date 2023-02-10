import 'package:flutter/material.dart';

import '../../common_widgets/common_textfield.dart';
import '../../utility/constants.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/authentication_controller.dart';
import '../utility/assets_utility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  commonVerticalSpacing(spacing: 20),
                  Image(image: appLogoImage,height: 80),
                  commonVerticalSpacing(spacing: 20),
                  commonHeaderTitle(title: "Login",fontSize: 1.4,align: TextAlign.center,height: 1.3,fontWeight: 3),
                  commonVerticalSpacing(spacing: 40),
                  CommonTextFiled(
                    fieldTitleText: "Email",
                    hintText: "Enter Email",
                    keyboardType: TextInputType.emailAddress,
                    textEditingController: emailController,
                    onChangedFunction: (String value){

                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    },),
                  commonVerticalSpacing(spacing: 25),
                  CommonTextFiled(
                    fieldTitleText: "Password",
                    hintText: "Enter Password",
                    isPassword: true,
                    textEditingController: passwordController,
                    onChangedFunction: (String value){

                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    },),
                  commonVerticalSpacing(spacing: 25),
                  commonFillButtonView(context: context, title: "LogIn", tapOnButton: (){
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map<String, dynamic> params = {
                        "email": emailController.text,
                        "password": passwordController.text,
                      };
                      AuthenticationController.to.loginAPI(params);
                    }
                  }, isLoading: false),
                  commonVerticalSpacing(spacing: 20),
                ],
              ),
            ),
          ),
        ));
  }
}