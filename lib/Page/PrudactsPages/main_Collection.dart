import 'dart:io';
import 'package:adminhala/Page/PrudactsPages/prudacts%20detals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' show basename, url;
import '../../models/FireBaseStatemant.dart';
import 'ProductsCollections.dart';

class Main_Collection extends StatefulWidget {
  Map DataFromeCollectionPage;
  Main_Collection({Key? key,required this.DataFromeCollectionPage}) : super(key: key);

  @override
  State<Main_Collection> createState() => _Main_CollectionState();
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


class _Main_CollectionState extends State<Main_Collection> {
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
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context) =>
                AlertDialog(content: Container(height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Edit Collection',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                        OpenStdyo1();
                      }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Add New Image'),Icon(Icons.camera)],)),

                      TextFormField(
                        controller: NewName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            hintText: 'Edit Collection Name'
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: () async {
                            await addMainCollection.UploadCollection(
                                Name: NewName.text,IdCollection: widget.DataFromeCollectionPage['IdCollection'],imgName:imgName! ,imgPath:imgPath!,
                                UidMarket: FirebaseAuth.instance.currentUser!.uid
                            );
                            Navigator.pop(context);

                          }, child: Text('Edit'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),),
                          ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),),
                        ],
                      ),

                      ElevatedButton(onPressed: (){Navigator.pop(context);
                      showDialog(context: context, builder: (context) =>
                          AlertDialog(
                            content: Container(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('are you sure?'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(onPressed: (){
                                        FireBase().removeCollectionHala(IdCollection:widget.DataFromeCollectionPage['IdCollection']);
                                        Navigator.pop(context);
                                      }, child: Text('Yes'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                      ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('No'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                    ],
                                  ),
                                ],
                              ),),
                          ),);
                      }, child: Text('Remove Collectin'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),//Remove Collection

                    ],
                  ),
                ))
              ,);
          }, icon: Icon(Icons.settings,color: Colors.white,))],
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
                              await addMainCollection.uploadMain_Collection(
                                  imgPath: imgPath!,
                                  imgName: imgName!,
                                  IdCollection: widget.DataFromeCollectionPage['IdCollection'],
                                  Name: NameMainCollection.text,
                                  IdMainColl: RandomIdCollection,
                                  Data: widget.DataFromeCollectionPage);
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
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: Icon(Icons.add,size: 60,color: Colors.white,),
                ),

              ),
            ),

            SizedBox(height: 150,),

            StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance
                  .collection('Collection').doc('${widget.DataFromeCollectionPage['IdCollection']}').collection('mainCollection')
                  .snapshots(),
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
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PrudactCollection(data_Collection: widget.DataFromeCollectionPage,Data_From_Main_Collection: data,)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 15,),
                                CachedNetworkImage(
                                  height: h/8,
                                  imageUrl: data['Image'],
                                  placeholder: (context, url) => CircularProgressIndicator(color: Colors.red),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: h/7,
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
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(data['Name'],style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),)),
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