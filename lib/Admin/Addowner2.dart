import 'dart:io';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_door/Admin/Addowner2.dart';

import 'package:smart_door/customwidgets/Textfield.dart';
import 'package:smart_door/utils/api/addownerapi.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddOwner2 extends StatefulWidget {
  AddOwner2({super.key, this.email, this.phone, this.name, this.dob, this.gender});
  final email;
  final phone;
  final name;
  final dob;
  final gender;
  @override
  State<AddOwner2> createState() => _RegisterState();
}

class _RegisterState extends State<AddOwner2> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final ValueNotifier<bool> obscure = ValueNotifier(true);
  final ValueNotifier<bool> check = ValueNotifier(true);
  var formKey = GlobalKey<FormState>();
  DateTime selectedDateTime = DateTime.now();
// Object? _radioVal;
  String error = '';

  File? _image;

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    // print(_image!.path??'null');
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Form(
          key: formKey,
          child: Column(children: <Widget>[
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
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
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
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
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
                                  image:
                                      AssetImage('assets/images/clock.png'))),
                        )),
                  ),
                  Positioned(
                    child: FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "OWNER",
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
              padding: EdgeInsets.all(20.0),
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
                                  color: Color.fromRGBO(143, 148, 251, .2),
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
                                prefixicon: Icon(Icons.place),
                                labelText: "Place",
                                controller: placeController,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80,
                                    width: 140,
                                    color: Colors.black12,
                                    child: _image != null
                                        ? Image.file(_image!, fit: BoxFit.cover)
                                        : Text('Please select an image'),
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                    onPressed: _openImagePicker,
                                    child: Text("Choose File"),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color.fromRGBO(143, 148, 251, 1),
                            ),
                            //  Container(
                            //       padding: EdgeInsets.all(8.0),
                            //       decoration: BoxDecoration(
                            //           border: Border(
                            //               bottom: BorderSide(
                            //                   color: Color.fromRGBO(
                            //                       143, 148, 251, 1)))),
                            //       child: Customtextfield(
                            //         prefixicon: Icon(Icons.image),
                            //         labelText: "Photo",

                            //         controller: usernameController,
                            //         validator: (value) {
                            //           if (value.toString().isEmpty) {
                            //             return 'Empty';
                            //           }
                            //           return null;
                            //         },
                            //       ),
                            //     ),

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
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromRGBO(
                                                143, 148, 251, 1)))),
                                child: ValueListenableBuilder(
                                  valueListenable: obscure,
                                  builder: (context, value, child) {
                                    return Customtextfield(
                                      prefixicon: Icon(Icons.key_outlined),
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
                                        } else if (value.toString().length <
                                            8) {
                                          return 'Password must be 8 digit';
                                        }
                                        return null;
                                      },
                                    );
                                  },
                                )),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: obscure,
                                  builder: (context, value, child) {
                                    return Customtextfield(
                                      prefixicon: Icon(Icons.key_outlined),
                                      labelText: "Confirm Password",
                                      suffixIcon: IconButton(
                                        icon: obscure.value
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          obscure.value = !obscure.value;
                                          print(obscure.value);
                                        },
                                      ),
                                      controller: confirmpasswordController,
                                      obscureText: obscure.value,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Invalid';
                                        } else if (value.toString().length <
                                            8) {
                                          return 'Password must be 8 digit';
                                        } else if (passwordController.text !=
                                            value) {
                                          return 'Invalid Password';
                                        }
                                        return null;
                                      },
                                    );
                                  },
                                )),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            print(usernameController.text);
                            print(passwordController.text);
                            Map<String, dynamic> data = {
                              'name': widget.name,
                              'gender': widget.gender,
                              'dob': widget.dob,
                              'email': widget.email,
                              'phone': widget.phone,
                              'place': placeController.text,
                              'username': usernameController.text,
                              'password': passwordController.text,
                            };
                            
                            await registerOwner(data,_image!,context);
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
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ]),
        ))));
  }
}
