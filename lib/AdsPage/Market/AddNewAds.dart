import 'dart:io';
import 'dart:math';

import 'package:adminhala/models/SnackBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename, url;

import '../../models/FireBaseStatemant.dart';

class AddAddsMarket extends StatefulWidget {
  const AddAddsMarket({Key? key}) : super(key: key);

  @override
  State<AddAddsMarket> createState() => _AddAddsMarketState();
}

class _AddAddsMarketState extends State<AddAddsMarket> {
  final Name=TextEditingController();
  File? imgPath1;
  String? imgName1;
  OpenStdyo() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try{if(pickedImg !=null){setState(() {imgPath1=File(pickedImg.path);imgName1 = basename(pickedImg.path);int random = Random().nextInt(9999999);int random1=Random().nextInt(9999999);
    imgName1 = "$random$random1$imgName1";});
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Images/logowelcome.png'),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ]
          )),
        ),
      ),
      body: Container(
        width: w,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: h/25,),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  OpenStdyo();
                },
                child: Container(
                  width: w*0.8,
                  height: h/18,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.green,
                        Colors.greenAccent
                      ]
                    )
                  ),
                  child: Center(child: Text('إضافة صورة',style: TextStyle(fontSize: w/22,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(height: h/25,),
              Container(height: h/4,width: w*0.9,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey),
                child:imgPath1 ==null?
                Text('')
                    :
                ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.file(imgPath1!,fit: BoxFit.cover,)),
              ),
              SizedBox(height: h/25,),
              Container(
                width: w*0.9,
                child: TextFormField(
                  controller: Name,
                  style:TextStyle(fontSize: w/24,color: Colors.black54,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    hintText: 'ادخل اسم المنتج',
                  ),
                ),
              ),
              SizedBox(height: h/25,),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  imgPath1==null?showSnackBar(context: context, text: 'الرجاء ادخال الصورة', colors: Colors.redAccent)
                      :
                  await FireBase().sendImageMarket(
                  context: context,
                  AdsId:Random(0).nextInt(250000),
                  ImageName:imgName1!,
                  ImagePath:imgPath1!,
                  ProductName: Name.text,
                  );
                  Navigator.pop(context);
                  ;
                },
                child: Container(
                  width: w*0.8,
                  height: h/18,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      gradient:imgPath1==null?LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.black54,
                            Colors.black
                          ]
                      ): LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.teal,
                            Colors.greenAccent
                          ]
                      )
                  ),
                  child: Center(child: Text('ارسل الصورة',style: TextStyle(fontSize: w/22,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(height: h/25,),
              Align(
                  alignment: Alignment.center,
                  child: Text('سيتم عرض هذه الصورة في صفحة المطعم مباشرة**',style: TextStyle(fontSize: w/30,color: Colors.red),)),
            ],
          ),
        ),
      ),
    );
  }
}
