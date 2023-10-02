import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../models/SnackBar.dart';
import '../../models/UserData.dart';
import '../HomePage.dart';
import 'LogInPage.dart';
import 'SingUp.dart';


class AuthMethods{
  Future<dynamic> SingUp(
      {required imgName,
        required imgPath,
        required imgpath1,
        required BuildContext context
        , required String imagePath,
        required String Name,
        required int Location,
        required String NameMarket,
        required String Email,
        required String Password,
        required int Offar,
        required DateTime Dateadded,
        required int PhoneMarket,
        required int TybeMarket,
        required String ImageProfile,
        required double Lat,
        required double Long,
        required String Token
      })
  async {
    TybeMarket==null?TybeMarket=0:null;

    String? url;
    final storageRef = FirebaseStorage.instance.ref('$imagePath/$imgName');
    await storageRef.putFile(imgPath);
    /*UploadTask uploadTask = storageRef.putData(imgPath);
    TaskSnapshot snap = await uploadTask;
     url = await snap.ref.getDownloadURL();*///اكواد عرض الصورة على المتصفح
    url = await storageRef.getDownloadURL();
    String? url1;
    final storageRef1 = FirebaseStorage.instance.ref('$imgpath1/$ImageProfile');
    await storageRef1.putFile(imgpath1);
    /*UploadTask uploadTask = storageRef.putData(imgPath);
    TaskSnapshot snap = await uploadTask;
     url = await snap.ref.getDownloadURL();*///اكواد عرض الصورة على المتصفح
    url1 = await storageRef1.getDownloadURL();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      CollectionReference users = FirebaseFirestore.instance.collection('AdminData');

      CollectionReference SaleData= FirebaseFirestore.instance.collection('SalesData');
        Map<String, dynamic> SaleDATA ={
          'OrdarCancel':0,
          'OrdarDone':0,
          'TotalCnceldPrice':0,
          'TotalDiscount':0,
          'TotalPrifit':0,
          'Uid':credential.user!.uid,
        };
      SaleData
          .doc(credential.user!.uid)
          .set(SaleDATA)
          .then((value) => print("SalesDataAdded"))
          .catchError((error) => print("Failed to add user: $error"));




      AdminData usersss = AdminData(
        Token: Token,
        Lat: Lat,
        Long:Long ,
        ImageProfile: url1,
        PhoneMarket: PhoneMarket,
        DataAdded:Dateadded ,
        Location:Location ,
        NameMarket:NameMarket ,
        Offar:Offar ,
        Password: Password,
        Name: Name,
        EmailAddress: Email,
        Logo: url,
        Uid: credential.user!.uid,
        TybeMarket: TybeMarket,
      );



      showSnackBar(context: context, text: 'تم انشاء الحساب بنجاح',colors: Colors.green);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LogIn(context)));
          emailaddress.text = '';
          pass.text = '';
          name.text = '';
          username.text = '';
      users
          .doc(credential.user!.uid)
          .set(usersss.Convert2Map())

          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));


      /*==================================================================*/
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return AdminData.convertSnap2Model(snap);
  }







  LogIn( BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text
      );
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomePage()));
      emailAddress.text='';
      password.text='';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context: context, text: 'الحساب غير موجود',colors: Colors.red);
      } else if (e.code == 'wrong-password') {
        showSnackBar(context: context, text: 'الرجاء التحقق من كلمة المرور',colors: Colors.red);
      }
    }
  }

  void signOut(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    showSnackBar(text: 'تم تسجيل الخروج بنجاح!',colors: Colors.red,context: context);
  }

}



