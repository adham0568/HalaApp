
import 'dart:io';
import 'package:adminhala/AdsPage/AddsDetals.dart';
import 'package:adminhala/AdsPage/FireBase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename, url;
import 'dart:math';
class AddNewImage extends StatefulWidget {
  String DocumantName;
  AddNewImage({Key? key,required this.DocumantName}) : super(key: key);

  @override
  State<AddNewImage> createState() => _AddNewImageState();
}
File? imgPath1;
String? imgName1;
final PrudactName=TextEditingController();
bool ShowFeildIdAdmin=false;
int valueOfMarketOrHala=0;
bool ContenerSetting=false;
bool ContenerSetting1=false;
class _AddNewImageState extends State<AddNewImage> {
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
    FireBaseUpLoad Upload=FireBaseUpLoad();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                OpenStdyo();
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: 55,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.yellow,
                            Colors.red
                          ]
                      )
                  ),
                  child: Center(
                    child: Text(
                      'إضافة صورة الاعلان',style: TextStyle(
                        fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 300,width: 300,
                child: imgPath1==null?Text(''):
              Image.file(imgPath1!),),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),),
                  hintText:valueOfMarketOrHala==0?'اسم المنتج':'اسم المطعم',
                ),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
                controller: PrudactName,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Hala',style: TextStyle(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.bold),),
                      SizedBox(width: 20,),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          setState(() {
                            ContenerSetting=true;
                            ContenerSetting1=false;
                          });
                        valueOfMarketOrHala=0;
                        },
                        child: Container(
                          height: 50,width: 50,
                          decoration: BoxDecoration(
                              color:ContenerSetting?Colors.green:Colors.white ,
                              shape: BoxShape.circle,
                          border: Border.all(color: Colors.black54,width: 1)
                          ),
                          child: ContenerSetting?Icon(Icons.check,color: Colors.white,size: 35,)
                          :Text('')
                          ,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            ContenerSetting=false;
                            ContenerSetting1=true;
                          });
                          valueOfMarketOrHala=1;
                        },
                        child: Container(
                          height: 50,width: 50,
                          decoration: BoxDecoration(
                              color:ContenerSetting1?Colors.green:Colors.white ,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black54,width: 1)
                          ),
                          child: ContenerSetting1?Icon(Icons.check,color: Colors.white,size: 35,)
                              :Text('')
                          ,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text('Market',style: TextStyle(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
            ShowFeildIdAdmin? Container(
              margin: EdgeInsets.only(left: 20,right: 20),
            ):Container(height: 1,width: 1,),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () async {
               await Upload.AddImageToFireBase(
                    ImageName: imgName1,
                    ImagePath: imgPath1,
                    DocName: widget.DocumantName,
                    TybePrudact:valueOfMarketOrHala,
                    PrudactName: PrudactName.text,
                    context: context,
                );
               imgPath1=null;
               PrudactName.text='';
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detal(NameDocumant: widget.DocumantName),));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.purple
                    ]
                  )
                ),
                margin: EdgeInsets.only(left: 50,right: 50,top: 20),
                height: 50,
                width: 150,
                child: Center(child: Text("ارسال الاعلان",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
