import 'dart:io';

import 'package:adminhala/AdsPage/AddsDetals.dart';
import 'package:adminhala/AdsPage/FireBase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';import 'package:path/path.dart' show basename, url;

//page 3
class ChangeImage extends StatefulWidget {
  String TybePrudact,PrudactName,imageurl,DocumantName;
  List Images;
  int Index;
  ChangeImage({required this.TybePrudact,required this.imageurl,required this.PrudactName,required this.DocumantName,required this.Images,required this.Index,Key? key}) : super(key: key);

  @override
  State<ChangeImage> createState() => _ChangeImageState();
}
final PrudactName=TextEditingController();
final TybeAdd=TextEditingController();
File? imgPath1;
String? imgName1;
class _ChangeImageState extends State<ChangeImage> {
  OpenStdyo() async {

    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try{if(pickedImg !=null){setState(() {imgPath1=File(pickedImg.path);imgName1 = basename(pickedImg.path);int random = Random().nextInt(9999999);int random1=Random().nextInt(9999999);
    imgName1 = "$random$random1$imgName1";});
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }
  FireBaseUpLoad ImageUpload=FireBaseUpLoad();
  @override
  void initState() {
    PrudactName.text=widget.PrudactName;
    TybeAdd.text=widget.TybePrudact;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Images/logowelcome.png'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ]
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  OpenStdyo();
                },
                child: Container(
                  width: 300,
                  height: 80,
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.only(left: 70,right: 70),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Change',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white
                      ),),
                      Icon(Icons.camera,color: Colors.white,size: 35,)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 78,),
            SizedBox(
              width: double.infinity,
              height: 200,
              child:imgPath1==null?
              Container(decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 100,width: 100,
              child: Image.network(widget.imageurl),)
                  :
              CircleAvatar(
                backgroundImage: FileImage(imgPath1!),
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),),
                  hintText: 'اسم المنتج',
                ),
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
                controller: PrudactName,
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: TextFormField(
                maxLength: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),),
                    hintText: 'صنف المنتج',
                    helperText: '0=HalaApp or 1=Market'
                ),
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
                controller: TybeAdd,
              ),
            ),
            InkWell(
              onTap: () async {
                imgPath1==null? null:await ImageUpload.UpdateImageAds(
                    ImageName:imgName1!,
                    context: context,
                    ImagePath: imgPath1,
                    Image: widget.Images,
                    Index: widget.Index,
                    documant_Name:widget.DocumantName,
                    TybePrudact:int.parse(TybeAdd.text),
                    PrudactName:PrudactName.text,
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    Detal(NameDocumant:widget.DocumantName),));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(56, 95, 172, 1),
                          Color.fromRGBO(1, 183, 168, 1)
                        ]
                    )
                ),
                child: const Text(
                  'UpLoad New Image',style: TextStyle(fontSize: 25,color: Colors.white
                ,fontWeight: FontWeight.bold
                ),

                ),
              ),
            ),
            ElevatedButton(onPressed: () {
              print(widget.Index);
              print(widget.Images);
            }, child: const Text('test'))
          ],
        ),
      ),
    );
  }
}
