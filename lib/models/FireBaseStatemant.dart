import 'dart:io';
import 'package:adminhala/models/PrudactDataMarket.dart';
import 'package:adminhala/models/SnackBar.dart';
import 'package:adminhala/models/mainCollectionMarket.dart';
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
      required double Prise,
      required double Discount,
      required Map DataMainCollection,
      required String IdCollection,
      required String IdMainCollection,
      required String IdMarket,
      required int TybePrudact,
      required List Opitions,
      required int Count_Quantity,
  })

  async {
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

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
          Count_requests: 0,
      );

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
  })

  async {
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    try{
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
        MainCollectionData DataMainColl=MainCollectionData(Name: Name,IdPrudactMainCollection: IdMainColl,IdCollection: IdCollection,Image: url,UidAdmin: FirebaseAuth.instance.currentUser!.uid);
        FirebaseFirestore.instance.collection('mainCollection').
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
      MainCollectionMarket DataMainColl=MainCollectionMarket(Name: Name,IdPrudactMainCollection: IdMainColl,Image: url,UidAdmin: FirebaseAuth.instance.currentUser!.uid) ;
      FirebaseFirestore.instance.collection('mainCollection').
      doc(IdMainColl).set(DataMainColl.Convert2Map()).
      then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

    } catch(e){print(e);}

  }


  Future<void> OrdarState({required int ordarid,required int State}) async {

    CollectionReference listItem =await FirebaseFirestore.instance.collection('Ordar');

    Map<String, dynamic> orderData = {
      'OrdarStates': State,
    };

    listItem
        .doc('${ordarid}')
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
        .doc('${DiscountCode}')
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
      'totalPrice': '${prise} ₪',
      'items': Prudact,
      'OrdarStates': 4,
      'User':Uid,
      'AdminUid':FirebaseAuth.instance.currentUser!.uid,
      'NameUser':NameUser,
      'Date':DateTime.now(),
    };

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

  Future<void> Ordarfailed({required String NameUser,required String prise,required List Prudact,required String Uid,required int IdOrdar}) async {

    String calculateTotalPrice=prise;
    CollectionReference listItem = FirebaseFirestore.instance.collection('Ordarfailed');
    Map<String, dynamic> orderData = {
      'orderID': IdOrdar,
      'totalPrice': '${prise} ₪',
      'items': Prudact,
      'OrdarStates': 6,
      'User':Uid,
      'AdminUid':FirebaseAuth.instance.currentUser!.uid,
      'NameUser':NameUser,
      'Date':DateTime.now(),
    };

    listItem
        .doc('${IdOrdar}')
        .set(orderData)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الطلب الى الاحصائيات');


    print('تم الغاء الطلب من Ordar');

  }

  Future<void> UpDateCount_requests({required List Items}) async {
    try{
      int counter=1;
      for(int i=0;i<Items.length;i++){
        int IdPrudact= Items[i]['IdPrudact'];
        int Count_requests=Items[i]['Count_requests'];
        int Count_Quantity=Items[i]['Count_Quantity'];
        if (i > 0 && Items[i - 1]['IdPrudact'] == Items[i]['IdPrudact']) {
          counter=counter+1;
        } else {
          counter = 1;
        }

        CollectionReference productData =await FirebaseFirestore.instance.collection('Prudacts');
        Map<String, dynamic> NewValue = {
          'Count_requests': Count_requests+counter,
          'Count_Quantity':Count_Quantity-counter
        };
        productData
            .doc(IdPrudact.toString())
            .update(NewValue)
            .then((value) => print("Order Added"));
        print(Count_requests);
        print(Count_Quantity);
      }
    }
    catch(e){print(e);}
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
      DocumentReference docRef = FirebaseFirestore.instance.collection('Discount').doc('$Code');
      await docRef.delete();
      showSnackBar(context: context, text: 'تم حذف الكود', colors: Colors.red);
    }
    catch(e){print(e);}

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
  })

  async {
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('CollectionImages/$Name/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();

    try{
      PrudactData DataPrudact = PrudactData(
          Count_Quantity: Count_Quantity,
          Count_requests: 0,
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

      FirebaseFirestore.instance.collection('Prudacts').
      doc(IdPrudacts.toString()).update(DataPrudact.Convert2Map()).
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
  UpdatePrudactsMarket({
    required String Name,
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
    required int Count_requests,
  })

  async {
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
          Discount: Discount,
          ImageUrl: url,
          IdPrudact: IdPrudacts,
          Name: Name,
          PrudactsDetals: DetalsPrudact,
          Prise: Prise,
          IdMainCollection: IdMainCollection
      );

      FirebaseFirestore.instance.collection('Prudacts').
      doc(IdPrudacts.toString()).update(DataPrudact.Convert2Map()).
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
}

