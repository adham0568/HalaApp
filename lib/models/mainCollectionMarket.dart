import 'package:cloud_firestore/cloud_firestore.dart';

class MainCollectionMarket{
  final String Name,IdPrudactMainCollection,Image,UidAdmin;
  final List Produacts;
  MainCollectionMarket({required this.Produacts,required this.Name,required this.IdPrudactMainCollection,required this.Image,required this.UidAdmin});






  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'Image':Image,
      'IdPrudactMainCollection':IdPrudactMainCollection,
      'UidAdmin':UidAdmin,
      'Produacts':Produacts,
    };
  }




  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MainCollectionMarket(
      Produacts: snapshot['products'],
      UidAdmin:snapshot['UidAdmin'],
      Image:snapshot['Image'],
      Name: snapshot["Name"],
      IdPrudactMainCollection: snapshot["IdPrudactMainCollection"],
    );
  }





}