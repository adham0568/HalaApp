import 'dart:io';

import 'package:adminhala/AdsPage/FireBase.dart';
import 'package:adminhala/models/SnackBar.dart';
import 'package:adminhala/models/_H_W.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';import 'package:path/path.dart' show basename, url;
import '../models/_H_W.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}
File? imgPath1;
String? imgName1;
class _WelcomePageState extends State<WelcomePage> {
  OpenStdyo() async {

    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try{if(pickedImg !=null){setState(() {imgPath1=File(pickedImg.path);imgName1 = basename(pickedImg.path);int random = Random().nextInt(9999999);int random1=Random().nextInt(9999999);
    imgName1 = "$random$random1$imgName1";});
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }
  SizeFix Sizefix=SizeFix();
  @override
  Widget build(BuildContext context) {
    FireBaseUpLoad Upload=FireBaseUpLoad();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(top: 50,bottom: 50,left: 25,right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: Sizefix.H(context: context)/3,width: Sizefix.W(context: context),
              child: imgPath1==null?Container(height: 1,width: 1,)
                  :
              Image(image: FileImage(imgPath1!),)),
            ElevatedButton(onPressed: () {
              OpenStdyo();
            }, child: Text('ChangeImage'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
            ),),
            imgPath1==null?Text('')
                :
                ElevatedButton(onPressed: () async {
                 await Upload.UploadWelvomeImage(ImageName: imgName1!, ImagePath: imgPath1);
                 showSnackBar(context: context, text: 'تم رفع الصورة بنجاح', colors: Colors.green);
                }, child: Text('Upload'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),)
          ],
        ),
      ),
    );
  }
}
