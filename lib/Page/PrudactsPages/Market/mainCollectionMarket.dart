import 'dart:io';
import 'package:adminhala/Page/PrudactsPages/Market/PrudactCollectionMarket.dart';
import 'package:adminhala/Page/PrudactsPages/prudacts%20detals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' show basename, url;
import '../../../models/FireBaseStatemant.dart';
import '../ProductsCollections.dart';

class Main_Collection_Market extends StatefulWidget {
 const Main_Collection_Market({Key? key,}) : super(key: key);

  @override
  State<Main_Collection_Market> createState() => _Main_Collection_MarketState();
}
FireBase EditData=FireBase();
final NewName=TextEditingController();
final detalsPrudact=TextEditingController();
final PrudactName=TextEditingController();
final PrudactPrise=TextEditingController();
File? imgPath;
String? imgName;
bool Imagedone=false;
final NameMainCollection= TextEditingController();


class _Main_Collection_MarketState extends State<Main_Collection_Market> {
  FireBase addMainCollection=FireBase();

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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
                              children: [Text('Add Image Prudoct'),Icon(Icons.camera)],)),
                            TextFormField(
                              controller: NameMainCollection,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Main Collection Name'
                              ),
                            ),
                            ElevatedButton(onPressed: () async {
                              String RandomIdCollection=Uuid().v1();
                              await addMainCollection.uploadMain_Collection_Market(
                                  imgPath: imgPath!,
                                  imgName: imgName!,
                                  Name: NameMainCollection.text,
                                  IdMainColl: RandomIdCollection,
                                  );
                              Navigator.pop(context);
                              imgPath=null;
                              imgName='';
                            }, child: Text('Add'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),)
                          ],
                        ),
                      ))
                    ,);
                },
                child: Container(
                  height: h/8,
                  width: w/4,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: Icon(Icons.add,size: 60,color: Colors.white,),
                ),

              ),
            ),

            SizedBox(height: 150,),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('mainCollection').where('UidAdmin',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                return SizedBox(
                  child: GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio:18/30,
                      mainAxisSpacing: 10,
                    ),
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return SizedBox(
                        height: 100,
                        child: InkWell(
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>PrudactCollection_Market(Data_From_Main_Collection: data,)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 15,),
                                CachedNetworkImage(
                                  imageUrl: data['Image'],
                                  placeholder: (context, url) => CircularProgressIndicator(color: Colors.red),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: h/8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(data['Name'],style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
