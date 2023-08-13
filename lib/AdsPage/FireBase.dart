import 'dart:async';
import 'dart:io';

import 'package:adminhala/models/SnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FireBaseUpLoad{
  UpdateImageAds(
      {required List Image,
      required int Index,
      required String ImageName,
      required ImagePath,
      required String documant_Name,
      required int TybePrudact,
      required String PrudactName,
      required BuildContext context,
      }) async {
    String? url;
    final storageRef = FirebaseStorage.instance.ref('Adds/$ImageName');
    await storageRef.putFile(ImagePath);
    url = await storageRef.getDownloadURL();
    Map NewImage={
      'ImageUrl':url,
      'PrudactName':PrudactName,
      'TybePrudact':TybePrudact,
    };
    await Image.removeAt(Index);
    Image.insert(Index, NewImage);
    final DocumentReference myDocumentRef =await FirebaseFirestore.instance.collection('Pohto add').doc(documant_Name);
    myDocumentRef.update({
      'Images': Image,
    });
    Timer(Duration(seconds: 3), () {showSnackBar(context: context, text: 'تم تعديل الصورة بنجاح', colors: Colors.green);});
  }

  addNewImage({required ImageName,required ImagePath,required String DocName}) async {
    String? url;
    final storageRef = FirebaseStorage.instance.ref('Adds/$ImageName');
    await storageRef.putFile(ImagePath);
    url = await storageRef.getDownloadURL();



    final DocumentReference myDocumentRef = FirebaseFirestore.instance.collection('Pohto add').doc(DocName);
    myDocumentRef.update({
      'Images': FieldValue.arrayUnion([url]),
    });
  }

  RemoveImage({required List Image,required int Index,required BuildContext context,required String DocName}) async {


    Image.removeAt(Index);
    final DocumentReference myDocumentRef = FirebaseFirestore.instance.collection('Pohto add').doc(DocName);
    myDocumentRef.update({
      'Images':Image,
    });
    print('Remove Done');
    showSnackBar(context: context, text: 'Image Deleted', colors:Colors.red);
  }

  UploadWelvomeImage({required String ImageName,required ImagePath}) async {

    String? url;
    final storageRef = FirebaseStorage.instance.ref('Adds/$ImageName');
    await storageRef.putFile(ImagePath);
    url = await storageRef.getDownloadURL();
    final DocumentReference myDocumentRef = FirebaseFirestore.instance.collection('Pohto add').doc('WelcomePage');
    myDocumentRef.update({
      'Image1':url,
    });
    print('Done');
  }

  AddImageToFireBase({required ImageName,required ImagePath,required String DocName,required int TybePrudact,required String PrudactName,required BuildContext context}) async {
    String? url;
    final storageRef = FirebaseStorage.instance.ref('Adds/$ImageName');
    await storageRef.putFile(ImagePath);
    url = await storageRef.getDownloadURL();

    Map<String, dynamic> newMap = {
      'ImageUrl': url,
      'TybePrudact': TybePrudact,
      'PrudactName': PrudactName,
    };

    final DocumentReference myDocumentRef = FirebaseFirestore.instance.collection('Pohto add').doc(DocName);
    myDocumentRef.update({
      'Images': FieldValue.arrayUnion([newMap]),
    });
    showSnackBar(context: context, text: 'تم ارسال الصورة بنجاح', colors: Colors.green);
  }
}