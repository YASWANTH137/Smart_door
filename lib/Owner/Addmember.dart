import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_door/Admin/Addowner2.dart';
import 'package:smart_door/customwidgets/Textfield.dart';
import 'package:smart_door/utils/api/addmemberapi.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Addmember extends StatefulWidget {
  Addmember({super.key});
  


  @override
  State<Addmember> createState() => _RegisterState();
}

class _RegisterState extends State<Addmember> {
  TextEditingController nameController = TextEditingController();
  final ValueNotifier<bool> obscure = ValueNotifier(true);
  final ValueNotifier<bool> check = ValueNotifier(true);
  var formKey = GlobalKey<FormState>();
  DateTime selectedDateTime=DateTime.now();
// Object? _radioVal;
String error='';

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
    }}

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
                                    "MEMBERS",
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
                                  Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(height: 80,width: 140,color: Colors.black12,
                                       child: _image != null
                                       ? Image.file(_image!, fit: BoxFit.cover):
                                       Text('Please select an image'),),
                                    ),
                                     Container(
                                    child: ElevatedButton(onPressed:
                                      _openImagePicker,
                                    child: Text ("Choose File"),
                                    ),
                                  ),
                                  ],),
                              Divider(height: 1,
      color: Color.fromRGBO(143, 148, 251, 1),
      ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: InkWell(
                              onTap: () async {
                          if (formKey.currentState!.validate()) {
                            print(nameController.text);
                            Map<String, dynamic> data = {
                              'name': nameController.text,
                              'L_id': loginId,
                            };
                            
                            await registerMember(data,_image!,context);
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
                  )
                  )],
              ),
            ),
          ]),
        ))));
        
        
  }
 

  
}
