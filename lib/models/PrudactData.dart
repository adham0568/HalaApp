import 'package:cloud_firestore/cloud_firestore.dart';

class PrudactData{
  int TybePrudact,IdPrudact,Discount,Prise;
  final String Name,ImageUrl,PrudactsDetals,IdCollection,IdMainCollection,IdMarket;
  final List Opitions;

  PrudactData({required this.Opitions,required this.TybePrudact,required this.Name,required this.Discount,required this.ImageUrl,required this.IdPrudact,required this.PrudactsDetals,required this.Prise,required this.IdMainCollection,required this.IdCollection,required this.IdMarket});






  Map<String, dynamic> Convert2Map(){
    return {
      'TybePrudact':TybePrudact,
      'Name':Name,
      'ImageUrl':ImageUrl,
      'IdPrudact':IdPrudact,
      'PrudactsDetals':PrudactsDetals,
      'Prise':Prise,
      'Discount':Discount,
      'IdMainCollection':IdMainCollection,
      'IdCollection':IdCollection,
      'IdMarket':IdMarket,
      'Opitions':Opitions
    };
  }



  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PrudactData(
      TybePrudact:snapshot['TybePrudact'],
      PrudactsDetals:snapshot['PrudactsDetals'],
      ImageUrl: snapshot['ImageUrl'],
      Name: snapshot["Name"],
      Discount:snapshot['Discount'],
      IdPrudact: snapshot["IdPrudact"],
      Prise: snapshot['Prise'],
      IdMainCollection:snapshot['IdMainCollection'],
      IdCollection:snapshot['IdCollection'],
      IdMarket:snapshot['IdMarket'],
      Opitions:snapshot['Opitions']
    );
  }





}