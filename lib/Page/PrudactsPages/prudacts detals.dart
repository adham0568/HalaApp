import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' show basename, url;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../models/FireBaseStatemant.dart';

class PrudactsDetals extends StatefulWidget {
  Map DataFromeCollection;
  Map PrudactData;
  Map DataMainCollection;
  PrudactsDetals({Key? key,required this.PrudactData,required this.DataMainCollection,required this.DataFromeCollection}) : super(key: key);

  @override
  State<PrudactsDetals> createState() => _PrudactsDetalsState();
}

FireBase EditData=FireBase();
final NewNamePrudact=TextEditingController();
final Prise=TextEditingController();
final PrudactDiscount=TextEditingController();
final detalsPrudact=TextEditingController();
final PrudactName=TextEditingController();
final PrudactPrise=TextEditingController();
File? imgPath;
String? imgName;
bool Imagedone=false;

class _PrudactsDetalsState extends State<PrudactsDetals> {
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
                      AlertDialog(content: Container(height: 550,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Edit Prudact',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                              OpenStdyo1();
                            }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Add New Image'),Icon(Icons.camera)],)),
                            TextFormField(
                              controller: Prise,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Edit Prudact Prise'
                              ),
                            ),
                            TextFormField(
                              controller: PrudactDiscount,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Edit Prudact Discount'
                              ),
                            ),
                            TextFormField(
                              controller: NewNamePrudact,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Edit Prudact Name'
                              ),
                            ),

                            TextField(
                              controller:detalsPrudact,
                              maxLines: 8,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Prudact New Discrebtion'
                              ),
                            ),//discreption

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: (){
                                  EditData.UploadPrudacts(
                                    Opitions: [],
                                    TybePrudact: 0,
                                      Discount:int.parse(PrudactDiscount.text) ,
                                      IdMainCollection:widget.DataMainCollection['IdPrudactMainCollection'],
                                      IdCollection:widget.DataMainCollection['IdCollection'],
                                      Name: NewNamePrudact.text,
                                      IdPrudacts: widget.PrudactData['IdPrudact'],
                                      DetalsPrudact: detalsPrudact.text,
                                      imgPath: imgPath!,
                                      imgName: imgName!,
                                      Data: widget.DataFromeCollection,
                                      Prise:int.parse(Prise.text),
                                      DataMainCollection: widget.DataMainCollection,
                                      IdMarket:FirebaseAuth.instance.currentUser!.uid,
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
                                            ElevatedButton(onPressed: () async {
                                              CollectionReference users =  FirebaseFirestore.instance.collection('Collection');
                                              await users.doc(widget.DataFromeCollection['IdCollection']).collection('mainCollection').doc(widget.DataMainCollection['IdPrudactMainCollection'])
                                                  .collection('Prudact').doc(widget.PrudactData['IdPrudact'])
                                                  .delete();
                                              Navigator.pop(context);
                                            }, child: Text('Yes'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('No'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                          ],
                                        ),
                                      ],
                                    ),),
                                ),);
                            }, child: Text('Remove Prudact'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),//Remove Collection

                          ],
                        ),
                      ))
                    ,);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: Icon(Icons.settings,size: 60,color: Colors.white,),
                ),

              ),
            ),//add Prudacts
            Container(height: 150,),//Add Prudct Or Remove Collection
            Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    height: 400,
                    width: 400,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl:widget.PrudactData['ImageUrl'],
                      placeholder: (context, url) => CircularProgressIndicator(color: Colors.red),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(widget.PrudactData['Name'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Text(widget.PrudactData['Prise'].toString()),
                Text(widget.PrudactData['PrudactsDetals'])
              ],
            )
          ],
        ),
      ),
    );;
  }
}
