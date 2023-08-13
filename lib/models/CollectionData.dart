import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionData{
  final String Name;
  final String ImageUrl;
  final String IdCollection;
  final String UidAdmin;
  CollectionData({required this.Name,required this.ImageUrl,required this.IdCollection,required this.UidAdmin});






  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'ImageUrl':ImageUrl,
      'IdCollection':IdCollection,
      'UidAdmin':UidAdmin,
    };
  }




  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CollectionData(
      UidAdmin:snapshot['UidAdmin'],
      ImageUrl: snapshot['ImageUrl'],
      Name: snapshot["Name"],
      IdCollection: snapshot["IdCollection"],

    );
  }





}