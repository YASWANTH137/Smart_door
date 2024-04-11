import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:smart_door/Forgotpass.dart';
import 'package:smart_door/customwidgets/Textfield.dart';
import 'package:smart_door/main.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final ValueNotifier<bool> obscure = ValueNotifier(true);
  final ValueNotifier<bool> check = ValueNotifier(true);
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(
                              duration: Duration(seconds: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1300),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1800),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)))),
                                    child: Customtextfield(
                                      prefixicon: Icon(Icons.person),
                                      labelText: "Username",
                                      controller: usernameController,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: ValueListenableBuilder(
                                        valueListenable: obscure,
                                        builder: (context, value, child) {
                                          return Customtextfield(
                                            prefixicon:
                                                Icon(Icons.key_outlined),
                                            labelText: "Password",
                                            suffixIcon: IconButton(
                                              icon: obscure.value
                                                  ? Icon(Icons.visibility_off)
                                                  : Icon(Icons.visibility),
                                              onPressed: () {
                                                obscure.value = !obscure.value;
                                                print(obscure.value);
                                              },
                                            ),
                                            controller: passwordController,
                                            obscureText: obscure.value,
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return 'Invalid';
                                              } else if (value
                                                      .toString()
                                                      .length <
                                                  8) {
                                                return 'Password must be 8 digit';
                                              }
                                              return null;
                                            },
                                          );
                                        },
                                      ))
                                ],
                              ),
                            )),
                         Positioned(
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: (
                            TextButton(
                              onPressed: () {
                                 navigation(context, ForgotPassword());
                              },
                              child: Text("Forgot password ?"),

                            )
                                  ),
                                ),
                              )),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {},
                        //       child: Text("Forgot password ?"),
                        //     )
                        //   ],
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await loginUser(usernameController.text, passwordController.text, context);
                                  // print(usernameController.text);
                                  // print(passwordController.text);
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
