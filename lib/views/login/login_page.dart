import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/login_state.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/styles/button_style.dart';
import 'package:hope_nest/views/components/styles/login_input_style.dart';
import 'package:hope_nest/views/components/styles/text_style.dart';
import 'package:hope_nest/views/components/toast_message/toast_message.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _pwd = "";
  String _email = "";
  String _name = "";
  String _surname = "";
  String _phone = "";
  String _location = "";

  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  var key3 = GlobalKey<FormFieldState>();
  var key4 = GlobalKey<FormFieldState>();
  var key5 = GlobalKey<FormFieldState>();
  var key6 = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
/*
*     key1.currentState?.reset();
    key2.currentState?.reset();
    key3.currentState?.reset();
    key4.currentState?.reset();
    key5.currentState?.reset();
    key6.currentState?.reset();*/
    print("login");
    debugPrint("login2");
    return Scaffold(
      body: Container(
        height: DynamicSize.height(context, 1.70),
        child: SingleChildScrollView(
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
                      height: DynamicSize.height(context, 1.30),
                      child: _loginLayer(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// layer that have login process components
  Container _loginLayer(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
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
            _appUserVM.loginState == LoginState.SIGNUP
                ? signUpInfo()
                : Container(),
            _loginButton(context: context),
            const SizedBox(
              height: 5.0,
            ),
            _changeSignMethodButton(context: context),
          ],
        ),
      ),
    );
  }

  Column signUpInfo() {
    return Column(
      children: [
        _nameBox(),
        const SizedBox(
          height: 18.0,
        ),
        _surnameBox(),
        const SizedBox(
          height: 18.0,
        ),
        _phoneBox(),
        const SizedBox(
          height: 18.0,
        ),
        _locationBox(),
        const SizedBox(
          height: 18.0,
        ),
      ],
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
          key1.currentState!.validate();
          key2.currentState!.validate();
          if (_appUserVM.loginState == LoginState.SIGNUP) {
            key3.currentState!.validate();
            key4.currentState!.validate();
            key5.currentState!.validate();
            key6.currentState!.validate();
            if (key1.currentState!.isValid &&
                key2.currentState!.isValid &&
                key3.currentState!.isValid &&
                key4.currentState!.isValid &&
                key5.currentState!.isValid &&
                key6.currentState!.isValid) {
              key1.currentState!.save();
              key2.currentState!.save();
              key3.currentState!.save();
              key4.currentState!.save();
              key5.currentState!.save();
              key6.currentState!.save();
              try {
                await _appUserVM.signUpWithEmail(
                    email: _email,
                    pwd: _pwd,
                    name: _name,
                    surname: _surname,
                    phone: _phone,
                    location: _location);
                getDoneMessage(text: "successful!");
              } catch (e) {
                getErrorMessage(text: "an error occurred! " + e.toString());
              }
            } else {
              getErrorMessage(
                  text: "an error occurred! please check validation");
            }
          } else {
            if (key1.currentState!.isValid && key2.currentState!.isValid) {
              key1.currentState!.save();
              key2.currentState!.save();
              print("ss123123");
              try {
                await _appUserVM.signInWithEmail(email: _email, pwd: _pwd);
                getDoneMessage(text: "successful!");
              } catch (e) {
                getErrorMessage(text: "an error occurred! " + e.toString());
              }
            } else {
              getErrorMessage(
                  text: "an error occurred! please check validation");
            }
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
          if (_value == null || _value.length < 1) {
            return "password can not be null!";
          } else {
            return null;
          }
        },
        decoration: loginInputStyle.copyWith(
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
        decoration: loginInputStyle.copyWith(
          hintText: 'Email',
        ),
      ),
    );
  }

  /// password box
  Container _nameBox() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.05)),
      child: TextFormField(
        //keyboardType: TextInputType.pas,
        key: key3,
        onChanged: (String s) => _name = s,
        style: normalTextStyle,
        validator: (_value) {
          if (_value == null || _value.length < 1) {
            return "name can not be null!";
          } else {
            return null;
          }
        },
        decoration: loginInputStyle.copyWith(
          hintText: 'Name',
        ),
      ),
    );
  }

  /// password box
  Container _surnameBox() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.05)),
      child: TextFormField(
        //keyboardType: TextInputType.pas,
        key: key4,
        onChanged: (String s) => _surname = s,
        style: normalTextStyle,
        validator: (_value) {
          if (_value == null || _value.length < 1) {
            return "surname can not be null!";
          } else {
            return null;
          }
        },
        decoration: loginInputStyle.copyWith(
          hintText: 'Surname',
        ),
      ),
    );
  }

  /// password box
  Container _phoneBox() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.05)),
      child: TextFormField(
        //keyboardType: TextInputType.pas,
        key: key5,
        onChanged: (String s) => _phone = s,
        style: normalTextStyle,
        validator: (_value) {
          if (_value == null || _value.length < 1) {
            return "phone can not be null!";
          } else {
            return null;
          }
        },
        decoration: loginInputStyle.copyWith(
          hintText: 'Phone',
        ),
      ),
    );
  }

  /// password box
  Container _locationBox() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.05)),
      child: DropdownSearch<String>(
        key: key6,
        showSearchBox: true,
        mode: Mode.MENU,
        showSelectedItems: true,
        items: const ["Ankara", "Antalya", "Bursa", 'Istanbul'],
        dropdownSearchDecoration: loginInputStyle.copyWith(
          hintText: 'Location',
        ),
        validator: (String? item) {
          if (item == null) return "location can not be null!";
        },
        onChanged: (value) => _location = value!,
      ),
    );
  }
}
/*
*
* Container(
      margin:
          EdgeInsets.symmetric(horizontal: DynamicSize.height(context, 0.05)),
      child: TextFormField(
        //keyboardType: TextInputType.pas,
        key: key6,
        onChanged: (String s) => _location = s,
        style: normalTextStyle,
        validator: (_value) {
          if (_value == null || _value.length < 1) {
            return "location can not be null!";
          } else {
            return null;
          }
        },
        decoration: loginInputStyle.copyWith(
          hintText: 'Location',
        ),
      ),
    );
* */
