import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:smart_door/Admin/Addowner.dart';
import 'package:smart_door/Admin/Addowner2.dart';
import 'package:smart_door/customwidgets/Textfield.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddOwner extends StatefulWidget {
  AddOwner({super.key});

  @override
  State<AddOwner> createState() => _RegisterState();
}

class _RegisterState extends State<AddOwner> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  DateTime selectedDateTime=DateTime.now();
Object? _radioVal;
String selectedgender='';
String error='';
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
                                      labelText: "Name",
                                      controller: nameController,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

       Padding(
         padding: const EdgeInsets.all(17.0),
         child: Column(
           children: [
            Row(
              children: [
                Icon(Icons.group_rounded),
             
                const Text(' Gender :  ',style: TextStyle(fontSize: 16,color: Color.fromARGB(190, 0, 0, 0)),),
              ],

            ),
                  
             Row(
              children: [
              
                Radio(
                  value: 0,
                  groupValue: _radioVal,
                  onChanged: ( value) {
                    if (value != null) {
                      setState(() {
                        _radioVal = value;
                        selectedgender='male';

                        print(selectedgender);
                        error='';
                      });
                    }
                  },
                ),
                const Text('Male ',),
                Radio(
                  value: 1,
                  groupValue: _radioVal,
                  onChanged: ( value) {
                    if (value != null) {
                      setState(() {
                        _radioVal = value;
                         selectedgender='female';
                        print(selectedgender);
                      });
                    }
                  },
                ),
                const Text('Female '),
                Radio(
                  value: 2,
                  groupValue: _radioVal,
                  onChanged: ( value) {
                    if (value != null) {
                      setState(() {
                        _radioVal = value;
                         selectedgender='others';
                        print(selectedgender);
                      });
                    }
                  },
                ),
                const Text('Others '),
              ],
                   ),
           ],
         ),
       ),
       Align(alignment: Alignment.bottomLeft,
        child: Text(error,style:TextStyle(fontSize: 10,color:Colors.red,))),
      Divider(height: 1,
      color: Color.fromRGBO(143, 148, 251, 1),
      ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)))),
                                    child: Customtextfield(
                                      prefixicon: IconButton(icon: Icon(Icons.calendar_month_sharp),onPressed: () {
                                        _selectDate(context);
                                      },),
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
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)))),
                                    child: Customtextfield(
                                      prefixicon: Icon(Icons.mail),
                                      labelText: "Email",
                                      controller: emailController,

                                      validator: validateEmail,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Customtextfield(
                                      prefixicon: Icon(Icons.phone),
                                      labelText: "Phone number",
                                      controller: phoneController,
                                      validator: validateMobile,
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  if (_radioVal!=null) {
                                    print(_radioVal);
                                    print(nameController.text);
                                  print(passwordController.text);

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddOwner2(name:nameController.text ,email: emailController.text,gender:selectedgender ,dob:dobController.text ,phone:phoneController.text ,))); 


                                  }
                                  else{
                                    print("invalid");
                                    setState(() {
                                      error='Select gender';
                                    });
                                  }
                                  
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
                                    "Next",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
  String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  if (value!.isEmpty) {
    return 'enter email';
  }

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.length == 0) {
          return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
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
}
