import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseChat{

  Future<void> ChateOpen({required String DocumantName}) async {
    int waiting;
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SupportData').doc(DocumantName).get();
    waiting=snapshot.data()!['Waiting'];
    }
    catch(e){print(e);}
    CollectionReference ChatState = FirebaseFirestore.instance.collection('SupportData');
    Map<String, dynamic> WaitingState = {'Waiting': 0,};
    ChatState
        .doc(DocumantName)
        .update(WaitingState)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث حالة  المحادثة');
  }

  SendMassege({required String massege,required int Which,required List Massage,required String DocumantName}) async {
    CollectionReference AddDocumant =FirebaseFirestore.instance.collection('SupportData');
    Map<String, dynamic> DataMassege = {'Massege':massege,'Which':Which};
    Massage.add(DataMassege);
    AddDocumant
        .doc(DocumantName)
        .update(
      {'Massege':Massage},)
        .then((value) => print("MassegeSent"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الرسالة');
  }
}