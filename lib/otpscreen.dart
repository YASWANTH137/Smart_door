import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:smart_door/customwidgets/Textfield.dart';
import 'package:smart_door/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_door/utils/commun/forgotPassApi.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key, this.email}) : super(key: key);
  final email;
  
  TextEditingController forgotpasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isFilled = ValueNotifier(false);

  String otp='';

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
                Stack(
                    children: <Widget>[
                      Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill
                    ),
                  ),
                
                ),
                Positioned(
                  left: 90,
                  top: 200,
                  child:Text(
  "Enter OTP",
  style: TextStyle(
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  ),
),)
                      // Position your other widgets here
                    ],
                  ),
               
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      OtpTextField(
                        numberOfFields: 5,
        borderColor: Color(0xFF512DA8),
        //set to true to show as box or false to show as dash
        showFieldAsBox: true, 
        //runs when a code is typed in
        onCodeChanged: (String code) {
            //handle validation or checks here           
        },
                        onSubmit: (String verificationCode) {
                          otp=verificationCode;
                          isFilled.value = true;
                        },
                      ),
                      SizedBox(height: 10,),
                      ValueListenableBuilder<bool>(
                        valueListenable: isFilled,
                        builder: (context, value, child) {
                          return value ? FadeInUp(
                            duration: Duration(milliseconds: 1800),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromRGBO(143, 148, 251, 1)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      // border: Border(
                                      //     bottom: BorderSide(
                                      //         color: Color.fromRGBO(
                                      //             143, 148, 251, 1)))
                                    ),
                                    child: Customtextfield(
                                      prefixicon: Icon(Icons.lock),
                                      labelText: "NewPassword",
                                      controller: forgotpasswordController,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Invalid';
                                        } else if (value.toString().length < 8) {
                                          return 'Password must be 8 digit';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) : SizedBox();
                        },
                      ),
                      SizedBox(height: 15,),
                      FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await sentOtpandPass(otp,forgotpasswordController.text,context,email);
                              // await forgotPassword(forgotpasswordController.text,context);
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
