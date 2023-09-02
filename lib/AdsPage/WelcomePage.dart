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

class _WelcomePageState extends State<WelcomePage> {
  File? imgPath1;
  String? imgName1;
  int? TybeMarket;
  final NameProduct=TextEditingController();
  final TextAdd=TextEditingController();

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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
            TextFormField(
              controller: NameProduct,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                labelText: 'اسم المنتج',
              ),
            ),
            TextField(
              maxLines: 2,
              maxLength: 70,
              controller: TextAdd,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                labelText: 'نص الاعلان',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      TybeMarket=0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w/20,vertical: h/120),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.teal),
                    child: Text('Hala Product',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      TybeMarket=1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w/20,vertical: h/120),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.pink),
                    child: Text('Market Product',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            ElevatedButton(onPressed: () {
              OpenStdyo();
            }, child: Text('ChangeImage'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
            ),),
            imgPath1==null?Text('')
                :
                ElevatedButton(onPressed: () async {
                  TybeMarket==null? showSnackBar(context: context, text: 'الرجاء تحديد نوع المنتج',colors: Colors.red):null;
                 await Upload.UploadWelvomeImage(ImageName: imgName1!, ImagePath: imgPath1,TybeMarket:TybeMarket!,NameProduct: NameProduct.text,TextAdd: TextAdd.text);
                     showSnackBar(context: context, text: 'تم رفع المنتج بنجاح', colors: Colors.green);
                }, child: Text('Upload'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(TybeMarket==null? Colors.black:Colors.green)),)
          ],
        ),
      ),
    );
  }
}
