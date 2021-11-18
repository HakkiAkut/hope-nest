import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/login_state.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/button_style.dart';
import 'package:hope_nest/views/components/input_style.dart';
import 'package:hope_nest/views/components/text_style.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _pwd = "";
  String _email = "";

  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset("assets/login/background.jpg"),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(DynamicSize.height(context, 0.05)),
                    height: DynamicSize.height(context, 0.30),
                    child: Image.asset("assets/logo/logo.png"),
                  ),
                  Container(
                    height: DynamicSize.height(context, 0.60),
                    child: _loginLayer(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// layer that have login process components
  Container _loginLayer() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      height: double.infinity,
      child: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 8.0,
            ),
            emailBox(),
            const SizedBox(
              height: 18.0,
            ),
            _passwordBox(),
            const SizedBox(
              height: 18.0,
            ),
            _loginButton(context: context),
            const SizedBox(
              height: 5.0,
            ),
            _changeSignMethodButton(context: context)
          ],
        ),
      ),
    );
  }

  GestureDetector _changeSignMethodButton({required BuildContext context}) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    return GestureDetector(
      onTap: () {
        _appUserVM.loginState == LoginState.SIGNIN
            ? _appUserVM.loginState = LoginState.SIGNUP
            : _appUserVM.loginState = LoginState.SIGNIN;
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _appUserVM.loginState == LoginState.SIGNIN
                ? const Text(
                    "Sign up for free",
                    style: TextStyle(color: Palette.MAIN_COLOR_BLUE),
                  )
                : const Text(
                    "Sign in now",
                    style: TextStyle(color: Palette.MAIN_COLOR_BLUE),
                  ),
          ],
        ),
      ),
    );
  }

  /// login button
  Container _loginButton({required BuildContext context}) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.15)),
      width: double.infinity,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () async {
          if (key1.currentState!.validate() && key2.currentState!.validate()) {
            key1.currentState!.save();
            key2.currentState!.save();
            try {
              _appUserVM.loginState == LoginState.SIGNIN
                  ? await _appUserVM.signInWithEmail(email: _email, pwd: _pwd)
                  : await _appUserVM.signUpWithEmail(email: _email, pwd: _pwd);
            } catch (e) {
              // TODO show error message
            }
          } else {
            print("hata var");
          }
        },
        child: _appUserVM.loginState == LoginState.SIGNIN
            ? Text(
                "Sign In",
                style: normalTextStyle.copyWith(color: Palette.BACKGROUND),
              )
            : Text(
                "Sign Up",
                style: normalTextStyle.copyWith(color: Palette.BACKGROUND),
              ),
      ),
    );
  }

  /// password box
  Container _passwordBox() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.05)),
      child: TextFormField(
        //keyboardType: TextInputType.pas,
        obscureText: true,
        key: key2,
        onChanged: (String s) => _pwd = s,
        style: normalTextStyle,
        validator: (_value) {
          if (_value!.length < 1) {
            return "password can not be null!";
          } else {
            return null;
          }
        },
        decoration: inputStyle.copyWith(
          hintText: 'Password',
        ),
      ),
    );
  }

  /// Email box
  Container emailBox() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.05)),
      child: TextFormField(
        key: key1,
        keyboardType: TextInputType.name,
        onChanged: (String s) => _email = s,
        style: normalTextStyle,
        validator: (_value) {
          bool validation = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(_value!);
          if (!validation) {
            return "invalid email!";
          } else {
            return null;
          }
        },
        decoration: inputStyle.copyWith(
          hintText: 'Email',
        ),
      ),
    );
  }
}
