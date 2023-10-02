import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adminhala/models/PrudactDataMarket.dart';
import 'package:adminhala/models/SnackBar.dart';
import 'package:adminhala/models/UserData.dart';
import 'package:adminhala/models/mainCollectionMarket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'CollectionData.dart';
import 'PrudactData.dart';
import 'main_CollectionData.dart';
import 'package:http/http.dart' as http;

class FireBase {

  removeCollectionHala({required String IdCollection}) async {
    List Product=[];
    CollectionReference users =  FirebaseFirestore.instance.collection('Collection');
    users.doc(IdCollection).delete();

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData')
        .doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      Product=data['Produacts'];
    } else {
      print("المستند غير موجود.");
    }

    for(int i=Product.length-1;i>=0;i--){
      if(Product[i]['IdCollection']==IdCollection){Product.removeAt(i);}
    }

    FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
    update({'Produacts':Product});

  }




  removeMainCollectionHala({required String IdPrudactMainCollection,required String IdCollection}) async {
    List Product=[];


    CollectionReference users =  FirebaseFirestore.instance.collection('Collection');
    users.doc(IdCollection).collection('mainCollection')
        .doc(IdPrudactMainCollection).delete();

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData')
        .doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      Product=data['Produacts'];
    } else {
      print("المستند غير موجود.");
    }

    for(int i=Product.length-1;i>=0;i--){
      if(Product[i]['IdMainCollection']==IdPrudactMainCollection){Product.removeAt(i);}
    }

    FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
    update({'Produacts':Product});

  }



  removeMainCollection({required String idMainCollection}) async {
    List Product=[];
    CollectionReference users =  FirebaseFirestore.instance.collection('mainCollection');
    users.doc(idMainCollection).delete();
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData')
        .doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      Product=data['Produacts'];
    } else {
      print("المستند غير موجود.");
    }

    for(int i=Product.length-1;i>=0;i--){
      if(Product[i]['IdMainCollection']==idMainCollection){Product.removeAt(i);}
    }

    FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
    update({'Produacts':Product});

  }




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
      required double Prise,
      required double Discount,
      required Map DataMainCollection,
      required String IdCollection,
      required String IdMainCollection,
      required String IdMarket,
      required int TybePrudact,
      required List Opitions,
      required int Count_Quantity,
      required int Count_requests,
  })

  async {
    List Product=[];
    List Prodact1=[];

    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Collection').doc(IdCollection).
    collection('mainCollection').doc(IdMainCollection).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      Product=data['Produacts'];

    } else {
      print("المستند غير موجود.");
    }


    try{
      PrudactData DataPrudact = PrudactData(
          Opitions: Opitions,
          TybePrudact: TybePrudact,
          IdMarket: IdMarket,
          Discount: Discount,
          ImageUrl: url,
          IdPrudact: IdPrudacts,
          Name: Name,
          PrudactsDetals: DetalsPrudact,
          Prise: Prise,
          IdCollection: IdCollection,
          IdMainCollection: IdMainCollection,
          Count_Quantity:Count_Quantity ,
          Count_requests: Count_requests,
      );





      Product.add(DataPrudact.Convert2Map());
      FirebaseFirestore.instance.collection('Collection').doc(IdCollection).collection('mainCollection').doc(IdMainCollection).
      update({'Produacts':Product}).
      then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));


        DocumentSnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
        if (snapshot1.exists) {
          Map<String, dynamic> data = snapshot1.data()!;
          data['Produacts']==null?Prodact1=[]:Prodact1=data['Produacts'];

        } else {
          print("المستند غير موجود.");
        }
          Prodact1.add(DataPrudact.Convert2Map());
        FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
      update({'Produacts':Prodact1});




      int? TotalOffer;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
      print('${TotalOffer}5555555555');
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
  UpdatePrudactsHala({
    required String Name,
    required int IdPrudacts,
    required String DetalsPrudact,
    required File imgPath,
    required String imgName,
    required Map Data,
    required double Prise,
    required double Discount,
    required String IdCollection,
    required Map DataMainCollection,
    required String IdMainCollection,
    required String IdMarket,
    required int TybePrudact,
    required List Opitions,
    required int Count_Quantity,
    required int Count_requests,
    required List PrudactList,
    required int Index,
  })

  async {
    List Prodact1=[];
    List Product=PrudactList;
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    try{
      PrudactData DataPrudact = PrudactData(
          Count_Quantity: Count_Quantity,
          Count_requests: Count_requests,
          Opitions: Opitions,
          TybePrudact: TybePrudact,
          IdCollection:IdCollection ,
          IdMarket: IdMarket,
          Discount: Discount,
          ImageUrl: url,
          IdPrudact: IdPrudacts,
          Name: Name,
          PrudactsDetals: DetalsPrudact,
          Prise: Prise,
          IdMainCollection: IdMainCollection
      );
      Product[Index]=DataPrudact.Convert2Map();
      FirebaseFirestore.instance.collection('Collection').doc(IdCollection).collection('mainCollection').doc(IdMainCollection).
      update({'Produacts':Product}).
      then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

      DocumentSnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (snapshot1.exists) {
        Map<String, dynamic> data = snapshot1.data()!;
        data['Produacts']==null?Prodact1=[]:Prodact1=data['Produacts'];

      } else {
        print("المستند غير موجود.");
      }

      for(int i=0;i<Prodact1.length;i++){
        if(Prodact1[i]['IdPrudact']==IdPrudacts){Prodact1[i]=DataPrudact.Convert2Map();break;}
      }

      FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
      update({'Produacts':Prodact1});




      int? TotalOffer;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
      print('${TotalOffer}5555555555');
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

  DeleteProductHala({required String IdMainCollection,required int Index,required String CollectionId,required List Prudact,required int IdProduct}) async {
    List Prodact1=[];
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.
    collection('mainCollection').doc(IdMainCollection).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      Prudact=data['Produacts'];
    } else {
      print("المستند غير موجود.");
    }
    Prudact.removeAt(Index);

    FirebaseFirestore.instance.collection('Collection').doc(CollectionId).collection('mainCollection').doc(IdMainCollection).
    update({'Produacts':Prudact}).then((value) => print("Product Deleted")).catchError((error) => print("Failed to add user: $error"));

    DocumentSnapshot<Map<String, dynamic>> snapshot2 = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snapshot2.exists) {
      Map<String, dynamic> data = snapshot2.data()!;
      data['Produacts']==null?Prodact1=[]:Prodact1=data['Produacts'];
      print('المستنذ موجود');
    } else {
      print("المستند غير موجود.");
    }
    for(int i=0;i<Prodact1.length;i++){
      if(Prodact1[i]['IdPrudact']==IdProduct){Prodact1.removeAt(i);
      break;}
    }

    FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
    update({'Produacts':Prodact1});


  }

  UploadPrudactsMarket({required String Name,
    required int IdPrudacts,
    required String DetalsPrudact,
    required File imgPath,
    required String imgName,
    required double Prise,
    required double Discount,
    required Map DataMainCollection,
    required String IdMainCollection,
    required String IdMarket,
    required int TybePrudact,
    required List Opitions,
    required int Count_Quantity,
    required List productData,
  })
async{
  List Product=[];
  String? url;
  final storageRef =
  FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
  await storageRef.putFile(imgPath);
  url = await storageRef.getDownloadURL();


  PrudactDataMarket DataPrudact = PrudactDataMarket(
      Count_Quantity:Count_Quantity ,
      Count_requests: 0,
      Opitions: Opitions,
      TybePrudact: TybePrudact,
      IdMarket: IdMarket,
      Discount: Discount,
      ImageUrl: url,
      IdPrudact: IdPrudacts,
      Name: Name,
      PrudactsDetals: DetalsPrudact,
      Prise: Prise,
      IdMainCollection: IdMainCollection);

  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
  if (snapshot.exists) {
    Map<String, dynamic> data = snapshot.data()!;
    data['Produacts']==null?Product=[]:Product=data['Produacts'];

  } else {
    print("المستند غير موجود.");
  }
  Product.add(DataPrudact.Convert2Map());
  FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
  update({'Produacts':Product});



  double? TotalOffer;
  DocumentSnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
  TotalOffer=snapshot1.data()!['Offar']*1.0;
  print('${TotalOffer}5555555555');

  CollectionReference AdminData = FirebaseFirestore.instance.collection('AdminData');
  Map<String, dynamic> UpdateOffer = {'Offar': TotalOffer!+Discount,};
  AdminData
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update(UpdateOffer)
      .then((value) => print("Offer Uodated"))
      .catchError((error) => print("Failed to add order: $error"));
  print('Offer');
}

  UpdatePrudactsMarket({
    required String Name,
    required int IdPrudacts,
    required String DetalsPrudact,
    required File imgPath,
    required String imgName,
    required double Prise,
    required double Discount,
    required String IdMainCollection,
    required String IdMarket,
    required int TybePrudact,
    required List Opitions,
    required int Count_Quantity,
    required int Count_requests,
    required int Index,
  })

  async {
    List Product=[];
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    try{
      PrudactDataMarket DataPrudact = PrudactDataMarket(
          Count_Quantity: Count_Quantity,
          Count_requests: Count_requests,
          Opitions: Opitions,
          TybePrudact: TybePrudact,
          IdMarket: IdMarket,
          Discount: Discount*1.0,
          ImageUrl: url,
          IdPrudact: IdPrudacts,
          Name: Name,
          PrudactsDetals: DetalsPrudact,
          Prise: Prise,
          IdMainCollection: IdMainCollection
      );

      double? TotalOffer;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (snapshot.exists) {
        TotalOffer=snapshot.data()!['Offar'];
        Map<String, dynamic> data = snapshot.data()!;
        data['Produacts']==null?Product=[]:Product=data['Produacts'];

      } else {
        print("المستند غير موجود.");
      }

      for(int i=0;i<Product.length;i++){
        if(Product[i]['IdPrudact']==IdPrudacts){Product[i]=DataPrudact.Convert2Map();break;}
      }
      CollectionReference AdminData = FirebaseFirestore.instance.collection('AdminData');
      Map<String, dynamic> UpdateOffer = {'Offar': TotalOffer!*1.0+Discount,'Produacts':Product};
      AdminData
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(UpdateOffer)
          .then((value) => print("Offer Uodated"))
          .catchError((error) => print("Failed to add order: $error"));
      print('Offer');

    } catch(e){print(e);}
  }




DeleteProduct({required String IdMainCollection,required int Index,required int IdProduct}) async {
  List Product=[];

  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
  if (snapshot.exists) {
    Map<String, dynamic> data = snapshot.data()!;
    data['Produacts']==null?Product=[]:Product=data['Produacts'];
    print('المستنذ موجود');
  } else {
    print("المستند غير موجود.");
  }
  for(int i=0;i<Product.length;i++){
    if(Product[i]['IdPrudact']==IdProduct){Product.removeAt(i);
    break;}
  }

  FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
  update({'Produacts':Product});

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
      MainCollectionData DataMainColl = MainCollectionData(
          Name: Name,
          IdPrudactMainCollection: IdMainColl,
          IdCollection: IdCollection,
          Image: url,
          UidAdmin: FirebaseAuth.instance.currentUser!.uid,
          Produacts: [],
      );
      FirebaseFirestore.instance.collection('Collection').doc(IdCollection).collection('mainCollection').
        doc(IdMainColl).set(DataMainColl.Convert2Map()).
        then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

      } catch(e){print(e);}

  }

  uploadMain_Collection_Market(
      {required String Name,
        required String IdMainColl,
        required File imgPath,
        required String imgName,}) async {

    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    try{
      MainCollectionMarket DataMainColl=MainCollectionMarket(
          Name: Name,
          IdPrudactMainCollection: IdMainColl,
          Image: url,
          UidAdmin: FirebaseAuth.instance.currentUser!.uid,
          Produacts: [],
      );
      FirebaseFirestore.instance.collection('mainCollection').
      doc(IdMainColl).set(DataMainColl.Convert2Map()).
      then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

    } catch(e){print(e);}

  }


  Future<void> OrdarState({required int ordarid,required int State}) async {

    CollectionReference listItem =FirebaseFirestore.instance.collection('Ordar');

    Map<String, dynamic> orderData = {
      'OrdarStates': State,
    };

    listItem
        .doc('$ordarid')
        .update(orderData)
        .then((value) => print("Editing"))
        .catchError((error) => print("Failed to add order: $error"));

    print(ordarid);
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
        .doc(DiscountCode)
        .set(orderData)
        .then((value) => print("Editing"))
        .catchError((error) => print("Failed to add order: $error"));

    print('تم تعديل حالة الطلب بنجاح في Firestore');


  }


  Future<void> sendListToFirestore({required String prise,required List Prudact,required String Uid,required int IdOrdar,required String NameUser}) async {

    String calculateTotalPrice=prise;
    CollectionReference listItem = FirebaseFirestore.instance.collection('OrdarDone');
    Map<String, dynamic> orderData = {
      'orderID': IdOrdar,
      'totalPrice': '$prise ₪',
      'items': Prudact,
      'OrdarStates': 4,
      'User':Uid,
      'AdminUid':FirebaseAuth.instance.currentUser!.uid,
      'NameUser':NameUser,
      'Date':DateTime.now(),
    };

    listItem
        .doc('$IdOrdar')
        .set(orderData)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الطلب الى الاحصائيات');

    CollectionReference listItem1 = FirebaseFirestore.instance.collection('Ordar');
    Map<String, dynamic> orderData1 = {
      'orderID': IdOrdar,
      'totalPrice': '$prise ₪',
      'items': Prudact,
      'OrdarStates': 4,
      'User':Uid,};

    listItem1
        .doc('$IdOrdar')
        .update(orderData1)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الطلب الى الاحصائيات');
  }

  Future<void> Ordarfailed({required String NameUser,required String prise,required List Prudact,required String Uid,required int IdOrdar}) async {

    String calculateTotalPrice=prise;
    CollectionReference listItem = FirebaseFirestore.instance.collection('Ordarfailed');
    Map<String, dynamic> orderData = {
      'orderID': IdOrdar,
      'totalPrice': '$prise ₪',
      'items': Prudact,
      'OrdarStates': 6,
      'User':Uid,
      'AdminUid':FirebaseAuth.instance.currentUser!.uid,
      'NameUser':NameUser,
      'Date':DateTime.now(),
    };

    listItem
        .doc('$IdOrdar')
        .set(orderData)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الطلب الى الاحصائيات');


    print('تم الغاء الطلب من Ordar');

  }

  Future<void> UpDateCount_requests({required List Items}) async {
    List Prodact=[];
    DocumentSnapshot<Map<String, dynamic>> snapshot2 = await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snapshot2.exists) {
      Map<String, dynamic> data = snapshot2.data()!;
      data['Produacts']==null?Prodact=[]:Prodact=data['Produacts'];
      print('المستنذ موجود');
    } else {
      print("المستند غير موجود.");
    }

    for(int i=0;i<Items.length;i++){
      int Count=Items[i]['Count'];
      for(int q=0;q<Prodact.length;q++){
        if(Items[i]['ID']==Prodact[q]['IdPrudact']){
          Prodact[q]['Count_requests']+=Count;
          Prodact[q]['Count_Quantity']-=Count;
        }
      }
    }

    FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).
    update({'Produacts':Prodact});
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
    double Prise1=double.parse(numericText);
    print(Prise1);
    int? totalOrdar;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('done');
    totalOrdar=snapshot.data()!['TotalPrifit'];
    }
    catch(e){print(e);}
    CollectionReference listItem = FirebaseFirestore.instance.collection('SalesData');
    Map<String, dynamic> OrdarDoneadd = {'TotalPrifit': totalOrdar!+Prise1.round(),};
    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(OrdarDoneadd)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث الطلبات  الفاشلة');

  }

  Future<void> TotalCancelUpdate({required String Prise}) async {
    String numericText = Prise.replaceAll(' ₪', '');
    double Prise1=double.parse(numericText);
    print(Prise1);
    double? totalOrdar;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    print('done');
    totalOrdar=snapshot.data()!['TotalCnceldPrice']*1.0;
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
      DocumentReference docRef = FirebaseFirestore.instance.collection('Discount').doc(Code);
      await docRef.delete();
      showSnackBar(context: context, text: 'تم حذف الكود', colors: Colors.red);
    }
    catch(e){print(e);}

  }

  sendImageMarket({required String ImageName,required File ImagePath,required String ProductName,required int AdsId,required BuildContext context}) async {
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/AddMarket/$ImageName');
    await storageRef.putFile(ImagePath);
    url = await storageRef.getDownloadURL();

    List AdsImage=[];
   await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        Map<String,dynamic> AdminData=snapshot.data() as Map<String,dynamic>;
        AdminData['AddImage']==null?AdsImage=[]:AdsImage=AdminData['AddImage'];
      }
      else{print('Error 404');}
    });
    Map Image={'ImageUrl':url,'AdsId':AdsId,'ProductName':ProductName,'UidAdmin':FirebaseAuth.instance.currentUser!.uid,'ImageName':ImageName};

    AdsImage.add(Image);

    AdsImage.length>4?showSnackBar(context: context, text: 'لقد بلغت الحد الاقصى الرجاء حذف صور لاضافة صور جديدة', colors: Colors.red)
        :
    FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).update({'AddImage':AdsImage});
  }

  editImageMarket({required String ImageName,required File ImagePath,required String ProductName,required int AdsId,required BuildContext context,
    required int IndexImage,required List ImageData,required String LastImageName}) async {
    await FirebaseStorage.instance.ref().child('CollectionImages/AddMarket/$LastImageName').delete();

    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/AddMarket/$ImageName');
    await storageRef.putFile(ImagePath);
    url = await storageRef.getDownloadURL();

    ImageData[IndexImage]={'ImageUrl':url,'AdsId':AdsId,'ProductName':ProductName,'UidAdmin':FirebaseAuth.instance.currentUser!.uid,'ImageName':ImageName};

   await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).update({'AddImage':ImageData});
  }

  DeleteImageAdd({required int Index,required List MyImage,required String LastName}) async {
    await FirebaseStorage.instance.ref().child('CollectionImages/AddMarket/$LastName').delete();
    MyImage.removeAt(Index);
    await FirebaseFirestore.instance.collection('AdminData').doc(FirebaseAuth.instance.currentUser!.uid).update({'AddImage':MyImage});

  }

}


class SendToDelivary{
  List Data=[];

  sendOrdarToDelivary(
      {required int OrdarId,
        required int City,
        required LatLng location,
        required List items,
        required String NameUser,
        required GeoPoint UserLocation,
        required GeoPoint MarketLocation,
        required String MarketName,
        required String PriseOrdar}) async {
    List DataDelivary=[];
    LatLng Location;
    Map win={};
    List<String> tokens=[];
    await FirebaseFirestore.instance.collection('DilevaryHala').where('City',isEqualTo: City).where('active',isEqualTo: 0).get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.exists) {
          Map<String, dynamic> dataUser = doc.data() as Map<String, dynamic>;
          Data.add(dataUser);
        } else {
          print("Document does not exist");
        }
      });
    });
    print(Data);
/*إضافة ال tokens الى الليست الخاصة بها */
    for(int i =0;i<Data.length;i++){
      tokens.add(Data[i]['token']);
    }
    Timer(Duration(seconds: 10), () {
      sendNotificationUploadLocation(tokens: tokens);
    });





    for(int i=0;i<Data.length;i++){
      Distance distance = Distance();
      GeoPoint Position=Data[i]['Location'] as GeoPoint;
      LatLng PositionLat=LatLng(Position.latitude, Position.longitude);
      double meters = distance(location, PositionLat)*1.0;
      Map dataTime={'Uid':Data[i]['Uid'],'Location':PositionLat,'Distance':meters,'Ordar':Data[i]['Ordar'],'token':Data[i]['token'],'State':0};
      DataDelivary.add(dataTime);
    }
    double minValue=DataDelivary[0]['Distance']*1.0;
    win=DataDelivary[0];
    for(int q=0;q<DataDelivary.length;q++){
      double thisValue=DataDelivary[q]['Distance']*1.0;
      if(thisValue<minValue){
        minValue=thisValue;
        win=DataDelivary[q];
      }
    }
    //double PriseDelivary=CalculatePriseDelivary(Distance:win['Distance'])*1.0;
    Map OrdarAdd={'PriseOrdar':PriseOrdar,'OrdarId':OrdarId,'items':items,'MarketLocation':MarketLocation,'UserLocation':UserLocation,'Name':NameUser,'PriseDelivary':5.0,'Time':DateTime.now(),'MarketName':MarketName,'State':0,};

    List Ordar=win['Ordar'];
    Ordar.add(OrdarAdd);
    AddOrdarToDelivary(Uid:win['Uid'],Ordar: Ordar);
    DataDelivary.clear();

    sendNotificationUsingServerToken(body:'لديك طلب جديد' ,title:"Hala Delivary" ,Token:win['token'],);

  }

  AddOrdarToDelivary({required List Ordar,required String Uid}) async {
    await FirebaseFirestore.instance.collection('DilevaryHala').doc(Uid).update(
        {'Ordar':Ordar});
    print('OrdarAdded');
  }


  double CalculatePriseDelivary({required double Distance}){
    double prise=5*1.0;
    if(Distance<600){prise=5*1.0;}
    else if(Distance<800){prise = 5.5*1.0;}
    else if(Distance<1000){prise =6.0*1.0;}
    else if(Distance<1200){prise =6.5*1.0;}
    else if(Distance>1000*1.0){
      double metar = Distance/100*1.0;
      prise=metar*0.6*1.0;
    }
    return prise;
  }


 final String serverToken ='AAAA_AIFDMU:APA91bGndgfYtWMz6-BKNGdzjudhRoau3L1JwQZdpO9EQ2QqjPiP-uIC6E9dewVhmPqZJB54ExvumpHnySFSvqNqfMDK9bFWxbtPNsbVOQFxk1Bf_z-iK1O7QRNGEU25vOuPfWT0oVek';

  Future<void> sendNotificationUploadLocation({
    required List<String> tokens, // قائمة من الـ FCM Tokens
  }) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken', // استبدل بـ serverToken الخاص بك
    };

    final message = {
      'notification': {
        'title': 'تحديث الموقع',
        'body': "تحديث الموقع الحالي",
      },
      'priority': 'high',
      'data': {},
      'registration_ids': tokens, // تحديد قائمة الـ FCM Tokens هنا
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(message),
      );

      if (response.statusCode == 200) {
        print('تم إرسال الإشعار بنجاح');
      } else {
        print('حدث خطأ أثناء إرسال الإشعار: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء إرسال الإشعار: $e');
    }
  }



  Future<void> sendNotificationUsingServerToken(
      {required String title,required String body,required String Token,}) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken', // استبدل بـ serverToken الخاص بك
    };

    final message = {
      'notification': {
        'title': title,
        'body': body,
      },
      'priority': 'high',
      'data': {
      },
      'to': '${Token}', // يمكنك استبدالها بالـ FCM token المستهدف أو "/topics/{topic}" لاستهداف موضوع معين
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(message),
      );

      if (response.statusCode == 200) {
        print('تم إرسال الإشعار بنجاح');
      } else {
        print('حدث خطأ أثناء إرسال الإشعار: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء إرسال الإشعار: $e');
    }
  }





}

