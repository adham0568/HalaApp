import 'dart:io';
import 'dart:math';

import 'package:adminhala/models/FireBaseStatemant.dart';
import 'package:adminhala/models/SnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename, url;

class MyAdd extends StatefulWidget {
  const MyAdd({Key? key}) : super(key: key);

  @override
  State<MyAdd> createState() => _MyAddState();
}

class _MyAddState extends State<MyAdd> {
  final Name=TextEditingController();
  bool dataComeing=false;
  List Images=[];
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
  MyAdd(){
    FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        Map<String,dynamic> AdminData =snapshot.data() as Map<String,dynamic>;
        Images=AdminData['AddImage'];
        setState(() {
          dataComeing=true;
        });
      }
      else{print('Error');}
    });
  }
  @override
  void initState() {
    MyAdd();
    super.initState();
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
      body:dataComeing? SingleChildScrollView(
        child: Container(
          width: w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:Images.length,
                itemBuilder: (context, index) =>Container(
                  margin: EdgeInsets.only(top: h/30,bottom: h/50,left: w/30,right: w/30),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                        height: h/4.2,
                        width: double.infinity,
                        child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.network(Images[index]['ImageUrl'],fit: BoxFit.cover,)),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(context: context, builder: (context) => AlertDialog(
                              backgroundColor: Colors.black54,
                              content:
                              Container(
                                height: h/5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('هل انت متأكد من حذف الصورة',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/25),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(onPressed: () async {
                                         await FireBase().DeleteImageAdd(Index: index,LastName:Images[index]['ImageName'],MyImage:Images );
                                         Navigator.pop(context);
                                         Navigator.pop(context);
                                         showSnackBar(context: context, text: 'تم حذف الصورة', colors: Colors.redAccent);
                                        }, child: Text('نعم',style: TextStyle(fontSize: w/27,color: Colors.white,fontWeight: FontWeight.bold),)
                                        ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),),
                                        ElevatedButton(onPressed: () {Navigator.pop(context);
                                        }, child: Text('لا',style: TextStyle(fontSize: w/27,color: Colors.white,fontWeight: FontWeight.bold),)
                                          ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),)
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),);
                        },
                        child: Container(width: w/4,height: h/18,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red.withOpacity(0.5)),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('حذف',style: TextStyle(fontSize: w/26,color: Colors.white,fontWeight: FontWeight.bold),),
                            Icon(Icons.delete,color: Colors.white,)
                          ],
                        ),
                      ),
                      ),
                      Positioned(
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            Name.text=Images[index]['ProductName'];
                            showDialog(context: context, builder: (context) => AlertDialog(
                                backgroundColor: Colors.black54,
                                content:
                                Container(
                                  height: h*0.7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('تعديل الاعلان',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/25),),
                                      InkWell(
                                        onTap:() {
                                          OpenStdyo();
                                        },
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: w/20,vertical: h/55),
                                          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15)),
                                          width: w/3,
                                        child: Center(child: Text('صورة جديدة',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/23),)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white54,),
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(onPressed: () async {
                                           await FireBase().editImageMarket(
                                              LastImageName: Images[index]['ImageName'],
                                              ProductName:Name.text,
                                              ImagePath: imgPath1!,
                                              ImageName: imgName1!,
                                              AdsId: Images[index]['AdsId'],
                                              context: context,
                                              ImageData:Images ,
                                              IndexImage: index,
                                            );
                                           Navigator.pop(context);
                                           Navigator.pop(context);
                                           showSnackBar(context: context, text: 'تم تعديل الصورة', colors: Colors.teal);
                                          }, child: Text('نعم',style: TextStyle(fontSize: w/27,color: Colors.white,fontWeight: FontWeight.bold),)
                                            ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),),
                                          ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text('لا',style: TextStyle(fontSize: w/27,color: Colors.white,fontWeight: FontWeight.bold),)
                                            ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),)
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),);
                          },
                          child: Container(width: w/4,height: h/18,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.teal.withOpacity(0.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('تعديل',style: TextStyle(fontSize: w/26,color: Colors.white,fontWeight: FontWeight.bold),),
                                Icon(Icons.settings,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),)
            ],
          ),
        ),
      )
          :
          Container(
            color: Colors.white,
              width: w,
              height: h,
              child: Center(child:
              Container(height: h/7,width: h/7,color: Colors.white,
                child: Center(child: CircularProgressIndicator(backgroundColor: Colors.black12,color: Colors.teal)),)))
      ,
    );
  }
}
