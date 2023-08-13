import 'package:cloud_firestore/cloud_firestore.dart';

class MainCollectionData{
  final String Name,IdPrudactMainCollection,IdCollection,Image;
  MainCollectionData({required this.Name,required this.IdPrudactMainCollection,required this.IdCollection,required this.Image});






  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'Image':Image,
      'IdCollection':IdCollection,
      'IdPrudactMainCollection':IdPrudactMainCollection,
    };
  }




  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MainCollectionData(
      Image:snapshot['Image'],
      Name: snapshot["Name"],
      IdCollection:snapshot['IdCollection'],
        IdPrudactMainCollection: snapshot["IdPrudactMainCollection"],
    );
  }





}