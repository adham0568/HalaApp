import 'dart:io';
import 'package:adminhala/models/SnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CollectionData.dart';
import 'PrudactData.dart';
import 'main_CollectionData.dart';
import 'package:path/path.dart' show basename, url;


class FireBase {


  UploadCollection({required String Name,required String IdCollection,required File imgPath,required String imgName,required String UidMarket})
  async {
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    try{
      CollectionData DataCollection=CollectionData(Name: Name,ImageUrl: url,IdCollection: IdCollection,UidAdmin: UidMarket);

      FirebaseFirestore.instance.collection('Collection').
      doc(IdCollection).set(DataCollection.Convert2Map()).
      then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

    } catch(e){print(e);}
  }

  UploadPrudacts({required String Name,
      required int IdPrudacts,
      required String DetalsPrudact,
      required File imgPath,
      required String imgName,
      required Map Data,
      required int Prise,
      required int Discount,
      required Map DataMainCollection,
      required String IdCollection,
      required String IdMainCollection,
      required String IdMarket,
      required int TybePrudact,
      required List Opitions,
  })

  async {
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    try{
      PrudactData DataPrudact=PrudactData(Opitions: Opitions,TybePrudact:TybePrudact ,IdMarket:IdMarket,Discount: Discount,ImageUrl: url,IdPrudact: IdPrudacts,Name:Name ,PrudactsDetals:DetalsPrudact ,Prise: Prise,IdCollection: IdCollection,IdMainCollection: IdMainCollection);

      FirebaseFirestore.instance.collection('Prudacts').
      doc(IdPrudacts.toString()).set(DataPrudact.Convert2Map()).
      then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

      int? TotalOffer;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
      print(TotalOffer.toString()+'5555555555');
      TotalOffer=snapshot.data()!['Offar'];

      CollectionReference AdminData = FirebaseFirestore.instance.collection('AdminData');
      Map<String, dynamic> UpdateOffer = {'Offar': TotalOffer!+Discount,};
      AdminData
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(UpdateOffer)
          .then((value) => print("Offer Uodated"))
          .catchError((error) => print("Failed to add order: $error"));
      print('Offer');

    } catch(e){print(e);}
  }

  uploadMain_Collection(
      {required String Name,
      required String IdMainColl,
      required Map Data,
      required String IdCollection,
        required File imgPath,
        required String imgName,}) async {

    String? url;
      final storageRef =
      FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
      await storageRef.putFile(imgPath);
      url = await storageRef.getDownloadURL();

    try{
        MainCollectionData DataMainColl=MainCollectionData(Name: Name,IdPrudactMainCollection: IdMainColl,IdCollection: IdCollection,Image: url);
        FirebaseFirestore.instance.collection('Collection').
        doc(Data['IdCollection']).collection('mainCollection').doc(IdMainColl).set(DataMainColl.Convert2Map()).
        then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

      } catch(e){print(e);}

  }


  Future<void> OrdarState({required int ordarid,required int State}) async {

    CollectionReference listItem = FirebaseFirestore.instance.collection('Ordar');

    Map<String, dynamic> orderData = {
      'OrdarStates': State,
    };

    listItem
        .doc('${ordarid}')
        .update(orderData)
        .then((value) => print("Editing"))
        .catchError((error) => print("Failed to add order: $error"));

    print('تم تعديل حالة الطلب بنجاح في Firestore');
  }

  Future<void> CodeSet({required String DiscountNum,required String DiscountValue,required String DiscountCode,required String Uid}) async {


    CollectionReference listItem = FirebaseFirestore.instance.collection('Discount');
    int DiscountValuenum=int.parse(DiscountValue);
    int DiscountNumnum=int.parse(DiscountNum);
    Map<String, dynamic> orderData = {
      'DiscountValue': DiscountValuenum,
      'DiscountNum': DiscountNumnum,
      'DiscountCode': DiscountCode,
      'Uid':Uid,
    };

    listItem
        .doc('${DiscountCode}')
        .set(orderData)
        .then((value) => print("Editing"))
        .catchError((error) => print("Failed to add order: $error"));

    print('تم تعديل حالة الطلب بنجاح في Firestore');


  }


  Future<void> sendListToFirestore({required String prise,required List Prudact,required String Uid,required int IdOrdar}) async {

    String calculateTotalPrice=prise;
    CollectionReference listItem = FirebaseFirestore.instance.collection('OrdarDone');
    Map<String, dynamic> orderData = {
      'orderID': IdOrdar,
      'totalPrice': '${prise} ₪',
      'items': Prudact,
      'OrdarStates': 4,
      'User':Uid,};

    listItem
        .doc('${IdOrdar}')
        .set(orderData)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الطلب الى الاحصائيات');

    CollectionReference listItem1 = FirebaseFirestore.instance.collection('Ordar');
    Map<String, dynamic> orderData1 = {
      'orderID': IdOrdar,
      'totalPrice': '${prise} ₪',
      'items': Prudact,
      'OrdarStates': 4,
      'User':Uid,};

    listItem1
        .doc('${IdOrdar}')
        .update(orderData1)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الطلب الى الاحصائيات');
  }

  Future<void> Ordarfailed({required String prise,required List Prudact,required String Uid,required int IdOrdar}) async {

    String calculateTotalPrice=prise;
    CollectionReference listItem = FirebaseFirestore.instance.collection('Ordarfailed');
    Map<String, dynamic> orderData = {
      'orderID': IdOrdar,
      'totalPrice': '${prise} ₪',
      'items': Prudact,
      'OrdarStates': 6,
      'User':Uid,};

    listItem
        .doc('${IdOrdar}')
        .set(orderData)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الطلب الى الاحصائيات');


    print('تم الغاء الطلب من Ordar');

  }





  Future<void> OrdarDoneUpdate() async {
    int? totalOrdar;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('done');
    totalOrdar=snapshot.data()!['OrdarDone'];
    }
    catch(e){print(e);}
    CollectionReference listItem = FirebaseFirestore.instance.collection('SalesData');
    Map<String, dynamic> OrdarDoneadd = {'OrdarDone': totalOrdar!+1,};
    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(OrdarDoneadd)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث الطلبات  الناجحة');

  }

  Future<void> OrdarCanceUpdate() async {
    int? OrdarCancel;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('done');
    OrdarCancel=snapshot.data()!['OrdarCancel'];

    }
    catch(e){print(e);}
    CollectionReference listItem = FirebaseFirestore.instance.collection('SalesData');
    Map<String, dynamic> OrdarDoneadd = {'OrdarCancel': OrdarCancel!+1,};
    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(OrdarDoneadd)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث الطلبات  الفاشلة');

  }
  Future<void> TotalPrifitUpdate({required String Prise}) async {
    String numericText = Prise.replaceAll(' ₪', '');
    int Prise1=int.parse(numericText);
    print(Prise1);
    int? totalOrdar;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('done');
    totalOrdar=snapshot.data()!['TotalPrifit'];
    }
    catch(e){print(e);}
    CollectionReference listItem = FirebaseFirestore.instance.collection('SalesData');
    Map<String, dynamic> OrdarDoneadd = {'TotalPrifit': totalOrdar!+Prise1,};
    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(OrdarDoneadd)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث الطلبات  الفاشلة');

  }

  Future<void> TotalCancelUpdate({required String Prise}) async {
    String numericText = Prise.replaceAll(' ₪', '');
    int Prise1=int.parse(numericText);
    print(Prise1);
    int? totalOrdar;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('done');
    totalOrdar=snapshot.data()!['TotalCnceldPrice'];
    }
    catch(e){print(e);}
    CollectionReference listItem = FirebaseFirestore.instance.collection('SalesData');
    Map<String, dynamic> OrdarDoneadd = {'TotalCnceldPrice': totalOrdar!+Prise1,};
    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(OrdarDoneadd)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث الطلبات  الفاشلة');

  }

  Future<void> DiscountUpdate({required int Prise}) async {
    print(Prise);
    int? totalOrdar;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('done');
    totalOrdar=snapshot.data()!['TotalDiscount'];
    }
    catch(e){print(e);}
    CollectionReference listItem = FirebaseFirestore.instance.collection('SalesData');
    Map<String, dynamic> OrdarDoneadd = {'TotalDiscount': totalOrdar!+Prise,};
    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(OrdarDoneadd)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث الطلبات  الفاشلة');
  }

  Future<void> RemoveCode({required String Code,required BuildContext context}) async {
    try{
      DocumentReference docRef = FirebaseFirestore.instance.collection('Discount').doc('$Code');
      await docRef.delete();
      showSnackBar(context: context, text: 'تم حذف الكود', colors: Colors.red);
    }
    catch(e){print(e);}


  }
}

