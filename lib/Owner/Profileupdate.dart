import 'dart:io';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_door/Owner/Profile.dart';
import 'package:smart_door/customwidgets/Textfield.dart';
import 'package:smart_door/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:smart_door/utils/api/updateprofileapi.dart';
import 'package:smart_door/utils/api/viewprofileapi.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({super.key, this.profiledata});
  final profiledata;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DateTime selectedDateTime = DateTime.now();
  String? selectedGender = profiledata[0]['Gender'];

  ValueNotifier<int> _radioVal = ValueNotifier<int>(0);
  ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);

  String error = '';

  var formKey = GlobalKey<FormState>();

  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _imageNotifier.value = File(pickedImage.path);
    }
  }

  @override
  void initState() {
    super.initState();
    selectedGender = widget.profiledata[0]['Gender'];

    if (selectedGender == 'male') {
      setState(() {
        _radioVal.value = 0;
      });
    } else if (selectedGender == 'female') {
      setState(() {
        _radioVal.value = 1;
      });
    } else {
      setState(() {
        _radioVal.value = 2;
      });
    }

    nameController.text = widget.profiledata[0]['Name'];
    dobController.text = widget.profiledata[0]['Date of birth'];
    emailController.text = widget.profiledata[0]['Email'];
    phoneController.text = widget.profiledata[0]['Phone'].toString();
  }

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
                      fit: BoxFit.fill,
                    ),
                  ),
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
                                image: AssetImage('assets/images/light-1.png'),
                              ),
                            ),
                          ),
                        ),
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
                                image: AssetImage('assets/images/light-2.png'),
                              ),
                            ),
                          ),
                        ),
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
                                image: AssetImage('assets/images/clock.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: Container(
                            margin: EdgeInsets.only(top: 90),
                            child: Center(
                              child: Text(
                                "PROFILE UPDATE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: _openImagePicker,
                                    child: ValueListenableBuilder<File?>(
                                      valueListenable: _imageNotifier,
                                      builder: (context, file, _) {
                                        return file != null
                                            ? CircleAvatar(
                                                radius: 50,
                                                backgroundImage:
                                                    FileImage(file),
                                              )
                                            : CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage(
                                                    '$baseUrl/static/photo/${widget.profiledata[0]['Photo']}'),
                                              );
                                      },
                                    ),
                                  ),
                                  Text(widget.profiledata[0]['Name']),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Card(
                                    child: Column(
                                      children: [
                                        Customtextfield(
                                          prefixicon: Icon(Icons.person),
                                          labelText: "Name",
                                          controller: nameController,
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Empty';
                                            }
                                            return null;
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(17.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.group_rounded),
                                                  const Text(
                                                    ' Gender :  ',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          190, 0, 0, 0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ValueListenableBuilder<int>(
                                                valueListenable: _radioVal,
                                                builder:
                                                    (context, value, child) {
                                                  return Row(
                                                    children: [
                                                      Radio(
                                                        value: 0,
                                                        groupValue: value,
                                                        onChanged: (value) {
                                                          _radioVal.value =
                                                              value!;
                                                          selectedGender =
                                                              'male';
                                                        },
                                                      ),
                                                      const Text('Male '),
                                                      Radio(
                                                        value: 1,
                                                        groupValue: value,
                                                        onChanged: (value) {
                                                          _radioVal.value =
                                                              value!;
                                                          selectedGender =
                                                              'female';
                                                        },
                                                      ),
                                                      const Text('Female '),
                                                      Radio(
                                                        value: 2,
                                                        groupValue: value,
                                                        onChanged: (value) {
                                                          _radioVal.value =
                                                              value!;
                                                          selectedGender =
                                                              'other';
                                                        },
                                                      ),
                                                      const Text('Others '),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: Customtextfield(
                                            prefixicon: IconButton(
                                              icon: Icon(
                                                  Icons.calendar_month_sharp),
                                              onPressed: () {
                                                _selectDate(context);
                                              },
                                            ),
                                            labelText: "Date of birth",
                                            controller: dobController,
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return 'Empty';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Customtextfield(
                                          prefixicon: Icon(Icons.mail),
                                          labelText: "Email",
                                          controller: emailController,
                                          validator: validateEmail,
                                        ),
                                        Customtextfield(
                                          prefixicon: Icon(Icons.phone),
                                          labelText: "Phone number",
                                          controller: phoneController,
                                          validator: validateMobile,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (_radioVal.value != null) {
                                                print(_radioVal.value);
                                                print(nameController.text);

                                                Map<String, dynamic> data = {
                                                  'login_id': loginId,
                                                  'Name': nameController.text,
                                                  'Gender': selectedGender,
                                                  'DOB': dobController.text,
                                                  'Email': emailController.text,
                                                  'Phone': phoneController.text,
                                                };
                                                String imagePath = '$baseUrl/static/photo/${widget.profiledata[0]['Photo']}';
                                                File imageFile =
                                                    File(imagePath);

                                                updateProfile(
                                                    data,
                                                    _imageNotifier.value??
                                                        imageFile,
                                                    context);
                                              } else {
                                                print("invalid");
                                                setState(() {
                                                  error = 'Select gender';
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(
                                                      143, 148, 251, 1),
                                                  Color.fromRGBO(
                                                      143, 148, 251, .6),
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 180,
                              top: 85,
                              child: Icon(Icons.camera),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      final DateTime combinedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      setState(() {
        selectedDateTime = combinedDateTime;
        dobController.text = combinedDateTime.toString().substring(0, 10);
      });
    }
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]'
        r'|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?'
        r'\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|'
        r'1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]'
        r'|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-'
        r'\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'enter email';
    }

    return value.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validateMobile(String? value) {
    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
