import 'dart:io';

import 'package:adminhala/Page/PrudactsPages/ProductsCollections.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' show basename, url;
import '../../models/FireBaseStatemant.dart';
import 'main_Collection.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}
FireBase UploadData=FireBase();
final NameCollection = TextEditingController();
File? imgPath;
String? imgName;
bool Imagedone=false;

class _CollectionPageState extends State<CollectionPage> {
  OpenStdyo1() async {
    final pickedImg = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          String random = Uuid().v1();
          imgName = "$random$imgName";
          setState(() {
            Imagedone = true;
          });
        });
      }
      else {
        print('NoImege');
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Transform.translate(
              offset: Offset(0,50),
              child: InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context) =>
                      AlertDialog(content: Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                              OpenStdyo1();
                            }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Add Image'),Icon(Icons.camera)],)),
                            TextFormField(
                              controller: NameCollection,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Collection Name'
                              ),
                            ),
                            ElevatedButton(onPressed: () async {
                              String RandomIdCollection=Uuid().v1();
                              await UploadData.UploadCollection(
                                  Name: NameCollection.text,
                                  IdCollection: RandomIdCollection
                                  ,imgName:imgName! ,
                                  imgPath:imgPath! ,
                                UidMarket: FirebaseAuth.instance.currentUser!.uid
                              );
                              Navigator.pop(context);
                            }, child: Text('Add'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),)
                          ],
                        ),
                      ))
                    ,);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: Icon(Icons.add,size: 60,color: Colors.white,),
                ),

              ),
            ),//add collection
            Container(margin: EdgeInsets.only(top: 120,right: 10,left: 10),
              child: SizedBox(
                height: 700,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Collection').where('UidAdmin',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return SizedBox(
                      child: GridView(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return SizedBox(
                            height: 100,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Main_Collection(DataFromeCollectionPage:data,)));
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: data['ImageUrl'],
                                  placeholder: (context, url) => CircularProgressIndicator(color: Colors.red),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: 105,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),

              ),
            ),//collections
          ],
        ),
      ),
    );
  }
}
