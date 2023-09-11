import 'dart:io';
import 'package:adminhala/Page/PrudactsPages/AddOptions.dart';
import 'package:adminhala/Page/PrudactsPages/AddPrudactWithDeatels.dart';
import 'package:adminhala/Page/PrudactsPages/ProductsCollections.dart';
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

class PrudactWithOpitions extends StatefulWidget {
  List Opitions;
  Map data_Collection;
  Map Data_From_Main_Collection;
  PrudactWithOpitions({Key? key,required this.data_Collection,required this.Data_From_Main_Collection,required this.Opitions}) : super(key: key);

  @override
  State<PrudactWithOpitions> createState() => _PrudactWithOpitionsState();
}
FireBase EditData=FireBase();
final NewName=TextEditingController();
final detalsPrudact=TextEditingController();
final PrudactName=TextEditingController();
final PrudactPrise=TextEditingController();
final PrudactDiscount=TextEditingController();
final NameOpition=TextEditingController();
final Count_Quantity=TextEditingController();
File? imgPath;
String? imgName;
bool Imagedone=false;
class _PrudactWithOpitionsState extends State<PrudactWithOpitions> {
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
            Container(
              padding: EdgeInsets.all(25),
              height: 900,
              margin: EdgeInsets.only(left: 50,right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: Count_Quantity,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: 'خصم على المنتج'
                    ),
                  ),
                  TextField(
                    controller: detalsPrudact,
                    maxLines: 6,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: 'وصف المنتج'
                    ),
                  ),//discreption
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       InkWell(
                         onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Options( data_Collection: widget.data_Collection, Data_From_Main_Collection: widget.Data_From_Main_Collection)
                                ));
                          },
                         child: Container(
                           margin: EdgeInsets.only(top: 15,bottom: 10),
                           height: 60,
                           width: 150,
                           decoration: BoxDecoration(gradient: LinearGradient(
                               begin: Alignment.centerLeft,
                               end: Alignment.centerRight,
                               colors: [
                                 Color.fromRGBO(56, 95, 172, 1),
                                 Color.fromRGBO(1, 183, 168, 1)
                               ]
                           ),borderRadius: BorderRadius.circular(10),color: Colors.red,),
                           child: Center(
                             child: Text('إضافة خيارات',style: TextStyle(fontWeight: FontWeight.bold,
                             fontSize: 25,color: Colors.white),),
                           ),
                         ),
                       )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25,bottom: 25),
                    child: ElevatedButton(onPressed: () async {
                      await EditData.UploadPrudacts(
                        Count_Quantity: int.parse(Count_Quantity.text),
                        Opitions: widget.Opitions,
                        TybePrudact: 1,
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
                        Count_requests: widget.Data_From_Main_Collection['Count_requests']
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>PrudactCollection(data_Collection: widget.data_Collection, Data_From_Main_Collection: widget.Data_From_Main_Collection) ,));
                    }, child: Text('اضافة المنتج',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.green),backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
