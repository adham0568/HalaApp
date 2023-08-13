import 'dart:io';
import 'package:adminhala/Page/PrudactsPages/AddPrudactWithDeatels.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' show basename, url;
import 'package:adminhala/Page/PrudactsPages/prudacts%20detals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../models/FireBaseStatemant.dart';
import '../../models/PrudactData.dart';
import 'main_Collection.dart';
import 'dart:math';
class PrudactCollection extends StatefulWidget {
  Map data_Collection;
  Map Data_From_Main_Collection;
   PrudactCollection({Key? key,required this.data_Collection,required this.Data_From_Main_Collection}) : super(key: key);

  @override
  State<PrudactCollection> createState() => _PrudactCollectionState();
}
FireBase EditData=FireBase();
final NewName=TextEditingController();
final detalsPrudact=TextEditingController();
final PrudactName=TextEditingController();
final PrudactPrise=TextEditingController();
final PrudactDiscount=TextEditingController();


File? imgPath;
String? imgName;
bool Imagedone=false;

class _PrudactCollectionState extends State<PrudactCollection> {
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
                        children: [Text('Add Image Prudoct'),Icon(Icons.camera)],)),

                      TextFormField(
                        controller: NewName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            hintText: 'Edit Main_Collection Name'
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          ElevatedButton(onPressed: () async {
                            await EditData.uploadMain_Collection(
                                imgName: imgName!,
                                imgPath: imgPath!,
                                IdCollection:
                                widget.data_Collection['IdCollection'],
                                Name: NewName.text,
                                IdMainColl:
                                widget.Data_From_Main_Collection[
                                'IdPrudactMainCollection'],
                                Data: widget.data_Collection);
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

                                        CollectionReference users =  FirebaseFirestore.instance.collection('Collection');
                                        users.doc(widget.data_Collection['IdCollection']).collection('mainCollection').doc(widget.Data_From_Main_Collection['IdPrudactMainCollection']).delete();

                                        Navigator.pop(context);
                                      }, child: Text('Yes'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                      ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('No'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                    ],
                                  ),
                                ],
                              ),),
                          ),);
                      }, child: Text('Remove Main Collectin'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),//Remove Collection

                    ],
                  ),
                ))
              ,);
          }, icon: Icon(Icons.settings,color: Colors.white,))],//setti
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
                  showDialog(context: context, builder: (context) => AlertDialog(
                    content: Container(
                      height: 150,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('اختار نوع المنتج'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PrudactWithOpitions(
                                    Opitions: [],
                                    data_Collection: widget.data_Collection,Data_From_Main_Collection: widget.Data_From_Main_Collection),));
                              }, child: Text("منتج مع اضافات"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),),
                              SizedBox(width: 5,),
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                                showDialog(context: context, builder: (context) =>
                                    AlertDialog(content: Container(
                                      height: 650,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                                            OpenStdyo1();
                                          }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                            children: [Text('اضافة صورة للمنتح'),Icon(Icons.camera)],)),
                                          TextFormField(
                                            controller: PrudactName,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                hintText: 'اسم المنتج'
                                            ),
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: PrudactPrise,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                hintText: 'سعر المنتج'
                                            ),
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: PrudactDiscount,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                hintText: 'خصم على المنتج'
                                            ),
                                          ),
                                          TextField(
                                            controller: detalsPrudact,
                                            maxLines: 8,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                hintText: 'وصف المنتج'
                                            ),
                                          ),//discreption
                                          ElevatedButton(onPressed: () async {
                                            await EditData.UploadPrudacts(
                                              Opitions: [],
                                              TybePrudact: 0,
                                              Discount: int.parse(PrudactDiscount.text),
                                              IdCollection:widget.Data_From_Main_Collection['IdCollection'],
                                              IdMainCollection:widget.Data_From_Main_Collection['IdPrudactMainCollection'],
                                              Prise: int.parse(PrudactPrise.text),
                                              Name: PrudactName.text,
                                              IdPrudacts: Random().nextInt(250000),
                                              DetalsPrudact: detalsPrudact.text,
                                              imgPath: imgPath!,
                                              imgName: imgName!,
                                              Data: widget.data_Collection,
                                              DataMainCollection:widget.Data_From_Main_Collection,
                                              IdMarket:FirebaseAuth.instance.currentUser!.uid,
                                            );
                                            Navigator.pop(context);
                                          }, child: Text('إضافة'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),)
                                        ],
                                      ),
                                    ))
                                  ,);
                              }, child: Text("منتج بدون اضافات"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: Icon(Icons.add,size: 60,color: Colors.white,),
                ),

              ),
            ),//add Prudacts
            Container(height: 150,),//Add Prudct Or Remove Collection
            SizedBox(
              height: 700,
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('Prudacts')
                    .where('IdMainCollection',isEqualTo:widget.Data_From_Main_Collection['IdPrudactMainCollection']).get(),
                builder:
                    (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 600,
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount:snapshot.data!.docs.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 15/20,
                                crossAxisCount: 3),
                            itemBuilder: (context, index) => SizedBox(
                              height: 100,
                              child: InkWell(
                                onTap: (){
                                  PrudactData _convertData=PrudactData.convertSnap2Model(snapshot.data!.docs[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PrudactsDetals(
                                                PrudactData:
                                                _convertData.Convert2Map(),
                                                DataMainCollection: widget
                                                    .Data_From_Main_Collection,
                                                DataFromeCollection:
                                                    widget.data_Collection,
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(10)),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: snapshot.data!.docs[index]['ImageUrl'],
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
                                      Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return Text("loading");
                },
              ),
            ),//Prudacts
          ],
        ),
      ),
    );
  }
}
