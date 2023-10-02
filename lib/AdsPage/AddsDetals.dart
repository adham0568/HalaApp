import 'dart:io';
import 'dart:math';import 'package:adminhala/AdsPage/FireBase.dart';
import 'package:adminhala/AdsPage/AddNewImage.dart';
import 'package:path/path.dart' show basename, url;
import 'package:adminhala/AdsPage/ChangeImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//Page2
class Detal extends StatefulWidget {
  String NameDocumant;
   Detal({required this.NameDocumant,Key? key}) : super(key: key);

  @override
  State<Detal> createState() => _DetalState();
}
List images = [];
bool waiting=false;
class _DetalState extends State<Detal> {
  FireBaseUpLoad UploadImage=FireBaseUpLoad();
  Future<Map<String, dynamic>?> GetDataFromFireBase() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('Pohto add').doc(widget.NameDocumant).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()!;
        setState(() {
          images = data['Images']; // قم بتعيين القائمة images بقيمة images المسترجعة من Firestore
          waiting = true;
        });
        print(images);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
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
  void initState() {
    GetDataFromFireBase();
    setState(() {});
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
      body:Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30,top: 20),
            height: 500,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (context, index) =>InkWell(
                onTap: () {
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Image.network(images[index]['ImageUrl']),
                      Positioned(
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeImage(
                              Images: images,
                              Index: index,
                              DocumantName: widget.NameDocumant,
                              TybePrudact:images[index]['TybePrudact'].toString(),
                              imageurl: images[index]['ImageUrl'],
                              PrudactName:images[index]['PrudactName'] ,
                            ),
                                  ));
                            },
                          child: Container(
                          height: 50,width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white70,
                          ),
                            child: const Center(child: Text('Change',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,fontWeight: FontWeight.bold
                            ),)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 100,
                        child: InkWell(
                          onTap: () {
                            showDialog(context: context, builder: (context) =>
                              AlertDialog(
                                content: Container(
                                  height: 200,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text('Are You Sure Remove This Image?',style:
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 25
                                        ),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(onPressed: () {
                                            UploadImage.RemoveImage(
                                                Image:images ,
                                                DocName: widget.NameDocumant,
                                                Index: index,
                                                context: context);
                                            Navigator.pop(context);
                                          setState(() {});
                                            },style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.red)
                                          ), child: const Text('Yes'),),
                                          ElevatedButton(onPressed: () {
                                              Navigator.pop(context);
                                          },style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.green)
                                          ), child: const Text('No'),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),);
                          },
                          child: Container(
                            height: 50,width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red,
                            ),
                            child: const Center(child: Text('Remove',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,fontWeight: FontWeight.bold
                              ),)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ) ,)
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        AddNewImage(DocumantName: widget.NameDocumant),
                  ));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange)),
            child: const Text(
              'إضافة صورة جديدة',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          imgPath1==null?const SizedBox(height: 1,width: 1,):InkWell(
            onTap: () async {
             await UploadImage.addNewImage(ImageName: imgName1!, ImagePath: imgPath1,DocName: widget.NameDocumant);
              imgPath1=null;
             setState(() {});

            },
            child: Container(
              margin: const EdgeInsets.only(left: 100,right: 100),
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.green),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("UploadImage",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                    Icon(Icons.upload_outlined,color: Colors.white,size: 30,)
                  ],
                ),
              ),
            ),
          )
        ],
      ) ,
    );
  }
}
