import 'package:cloud_firestore/cloud_firestore.dart';

class PrudactDataMarket{
  int IdPrudact,TybePrudact,Count_Quantity,Count_requests;
  double Discount,Prise;
  final String Name,ImageUrl,PrudactsDetals,IdMainCollection,IdMarket;
  final List Opitions;

  PrudactDataMarket(
      {
        required this.Count_Quantity,
        required this.Count_requests,
        required this.Opitions,
      required this.TybePrudact,
      required this.Name,
      required this.Discount,
      required this.ImageUrl,
      required this.IdPrudact,
      required this.PrudactsDetals,
      required this.Prise,
      required this.IdMainCollection,
      required this.IdMarket});

  Map<String, dynamic> Convert2Map(){
    return {
      'Count_requests':Count_requests,
      'Count_Quantity':Count_Quantity,
      'TybePrudact':TybePrudact,
      'Name':Name,
      'ImageUrl':ImageUrl,
      'IdPrudact':IdPrudact,
      'PrudactsDetals':PrudactsDetals,
      'Prise':Prise,
      'Discount':Discount,
      'IdMainCollection':IdMainCollection,
      'IdMarket':IdMarket,
      'Opitions':Opitions
    };
  }



  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PrudactDataMarket(
        Count_requests:snapshot['Count_requests'],
        Count_Quantity:snapshot['Count_Quantity'],
        TybePrudact:snapshot['TybePrudact'],
        PrudactsDetals:snapshot['PrudactsDetals'],
        ImageUrl: snapshot['ImageUrl'],
        Name: snapshot["Name"],
        Discount:snapshot['Discount'],
        IdPrudact: snapshot["IdPrudact"],
        Prise: snapshot['Prise'],
        IdMainCollection:snapshot['IdMainCollection'],
        IdMarket:snapshot['IdMarket'],
        Opitions:snapshot['Opitions']
    );
  }





}