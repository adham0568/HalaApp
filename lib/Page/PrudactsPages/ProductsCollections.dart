import 'dart:async';
import 'dart:io';
import 'package:adminhala/Page/PrudactsPages/AddPrudactWithDeatels.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path/path.dart' show basename, url;
import 'package:adminhala/Page/PrudactsPages/prudacts%20detals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../models/FireBaseStatemant.dart';
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
final Count_Quantity=TextEditingController();

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
          String random = const Uuid().v1();
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
                AlertDialog(content: SizedBox(height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Edit Collection',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                      ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                        OpenStdyo1();
                      }, child: const Row(mainAxisAlignment: MainAxisAlignment.center,
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

                          },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)), child: const Text('Edit'),),
                          ElevatedButton(onPressed: (){Navigator.pop(context);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)), child: const Text('Cancel'),),
                        ],
                      ),

                      ElevatedButton(onPressed: (){Navigator.pop(context);
                      showDialog(context: context, builder: (context) =>
                          AlertDialog(
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('are you sure?'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(onPressed: (){

                                        CollectionReference users =  FirebaseFirestore.instance.collection('Collection');
                                        users.doc(widget.Data_From_Main_Collection['IdCollection']).collection('mainCollection').doc(widget.Data_From_Main_Collection['IdPrudactMainCollection']).delete();

                                              FireBase().removeMainCollectionHala(
                                                  IdPrudactMainCollection: widget.Data_From_Main_Collection['IdPrudactMainCollection'],
                                                  IdCollection: widget.Data_From_Main_Collection['IdCollection']);
                                              Navigator.pop(context);
                                      },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)), child: const Text('Yes'),),
                                      ElevatedButton(onPressed: (){Navigator.pop(context);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child: const Text('No'),),
                                    ],
                                  ),
                                ],
                              ),),
                          ),);
                      },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)), child: const Text('Remove Main Collectin'),),//Remove Collection

                    ],
                  ),
                ))
              ,);
          }, icon: const Icon(Icons.settings,color: Colors.white,))],//setti
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
            Transform.translate(
              offset: const Offset(0,50),
              child: InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context) => AlertDialog(
                    content: SizedBox(
                      height: 150,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('اختار نوع المنتج'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrudactWithOpitions(
                                      Opitions: const [],
                                      data_Collection: widget.data_Collection,Data_From_Main_Collection: widget.Data_From_Main_Collection),));
                                },
                                child: Container(
                                  padding: EdgeInsets.all( w/50),
                                    decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(15)),
                                    child: Center(child: Text("منتج مع اضافات",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold,color: Colors.white),))),),

                              InkWell(
                                onTap: ()
                                {
                                  Navigator.pop(context);
                                  showDialog(context: context, builder: (context) =>
                                      AlertDialog(content: SingleChildScrollView(
                                        child: SizedBox(
                                          height: h*1.1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                                                OpenStdyo1();
                                              }, child: const Row(mainAxisAlignment: MainAxisAlignment.center,
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
                                              TextFormField(
                                                maxLength: 4,
                                                keyboardType: TextInputType.number,
                                                controller: Count_Quantity,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                    hintText: 'الكمية'
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
                                                  Count_Quantity:int.parse(Count_Quantity.text) ,
                                                  Opitions: [],
                                                  TybePrudact: 0,
                                                  Discount: double.parse(PrudactDiscount.text),
                                                  IdCollection:widget.Data_From_Main_Collection['IdCollection'],
                                                  IdMainCollection:widget.Data_From_Main_Collection['IdPrudactMainCollection'],
                                                  Prise: double.parse(PrudactPrise.text),
                                                  Name: PrudactName.text,
                                                  IdPrudacts: Random().nextInt(250000),
                                                  DetalsPrudact: detalsPrudact.text,
                                                  imgPath: imgPath!,
                                                  imgName: imgName!,
                                                  Data: widget.data_Collection,
                                                  DataMainCollection:widget.Data_From_Main_Collection,
                                                  IdMarket:FirebaseAuth.instance.currentUser!.uid,
                                                  Count_requests: 0
                                                );
                                                Navigator.pop(context);
                                              },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)), child: const Text('إضافة'),)
                                            ],
                                          ),
                                        ),
                                      ))
                                    ,);
                                },
                                child: Container(
                                    padding: EdgeInsets.only(left: w/50,right: w/50,top: w/50,bottom: w/50),

                                    decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(15)),
                                    child: Center(child: Text("بدون اضافات",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold,color: Colors.white),))),),

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
                  child: const Icon(Icons.add,size: 60,color: Colors.white,),
                ),

              ),
            ),//add Prudacts
            Container(height: 150,),//Add Prudct Or Remove Collection
            SizedBox(
              height: 700,
                /*FirebaseFirestore.instance.collection('Collection').doc(widget.Data_From_Main_Collection['IdCollection']).collection('mainCollection')
                    .where('IdPrudactMainCollection',isEqualTo: '${widget.Data_From_Main_Collection['IdPrudactMainCollection']}').get(),*/
              child: FutureBuilder<DocumentSnapshot>(
                future:  FirebaseFirestore.instance.collection('Collection').doc('${widget.Data_From_Main_Collection['IdCollection']}').collection('mainCollection')
                    .doc('${widget.Data_From_Main_Collection['IdPrudactMainCollection']}')
                    .get(),
                builder:
                    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        SizedBox(
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount:data['Produacts']==null?0:data['Produacts'].length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 15/20,
                                crossAxisCount: 3),
                            itemBuilder: (context, index) => SizedBox(
                              height: 100,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PrudactsDetals(
                                        PrudactList:data['Produacts'],
                                        PrudactData: data['Produacts'][index],
                                        Index: index,
                                        DataMainCollection: widget.Data_From_Main_Collection,
                                        DataFromeCollection: widget.data_Collection,
                                          )));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(10)),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: data['Produacts'][index]['ImageUrl'],
                                        placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                      Text(data['Produacts'][index]['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/25),)
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

                  return const Text("loading");
                },
              )
            ),//Prudacts
          ],
        ),
      ),
    );
  }
}


/**/