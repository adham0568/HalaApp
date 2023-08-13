import 'package:adminhala/Page/AuthPages/AuthFireBase.dart';
import 'package:adminhala/Page/AuthPages/AuthFireBase.dart';
import 'package:adminhala/Page/AuthPages/AuthFireBase.dart';
import 'package:adminhala/Page/AuthPages/LogInPage.dart';
import 'package:flutter/material.dart';

import 'AuthFireBase.dart';
import 'AuthFireBase.dart';
import 'AuthFireBase.dart';
import 'LogInPage.dart';
import 'LogInPage.dart';
import 'SingUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}
final emailAddress=TextEditingController();
final password=TextEditingController();
bool Showpass = true;
bool waiting1 = false;
class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50,bottom: 10),
                height: 150,
                child: Image.asset('assets/Images/black logo.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: 35,right: 35),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      validator: (email) {return email!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))?  null: "أدخل بريد الكتروني صالح";},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailAddress,
                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                      //النص الذي سيتم ادخاله
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintText:'Enter Email' ,
                        hintStyle: TextStyle(color: Colors.grey.shade900),
                        prefixIcon:  Icon(Icons.email),
                        prefixIconColor: Colors.grey.shade900,
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value) {return  value!.length<8 ? "ادخل كلمة المرور" : null;},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                      obscureText: Showpass,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintStyle:
                        TextStyle(
                            color: Colors.grey.shade900, fontWeight: FontWeight.bold),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(Icons.password,color: Colors.grey.shade900,),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              Showpass =!Showpass;
                            });
                          },
                          icon: Showpass
                              ?
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.grey.shade900,
                          ):Icon(
                            Icons.visibility_off,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        prefixIconColor: Color.fromRGBO(0, 175, 162, 10),
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey)),
                        onPressed: ()  async {
                          await AuthMethods().LogIn(context);
                          setState(() {
                            waiting1=true;
                          });
                          // await fire.LogIn(context);
                          setState(() {
                            waiting1=false;
                          });
                        },
                        child:waiting1? CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.white,valueColor: AlwaysStoppedAnimation(Color.fromRGBO(0, 175, 162, 10)),)
                            :Text(
                          'LogIn',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.only(bottom: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont Have Account?!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>SingUpPage(Lat:0.0,Long:0.0,LocationAdd: false,)));
                        },
                        child: Text(
                          'SingUp Now',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

