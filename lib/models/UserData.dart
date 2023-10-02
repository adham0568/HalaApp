
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminData{
  double Lat,Long;
  String Name,NameMarket,EmailAddress,Password,Logo,Uid,ImageProfile,Token;
  DateTime DataAdded;
  int Offar,TybeMarket,PhoneMarket,Location;
  AdminData(
      {
        required this.EmailAddress,
        required this.Name,
        required this.Password,
        required this.NameMarket,
        required this.Logo,
        required this.Uid,
        required this.DataAdded,
        required this.Offar,
        required this.Location,
        required this.PhoneMarket,
        required this.TybeMarket,
        required this.ImageProfile,
        required this.Lat,
        required this.Long,
        required this.Token,
      });

  //convert data frome AdminData to  Map<String,Object>


  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'Username':NameMarket,
      'EmailAddress':EmailAddress,
      'Password':Password,
      'ProfileImage':Logo,
      'Uid':Uid,
      'DataAdded':DataAdded,
      'Offar':Offar,
      'Location':Location,
      'PhoneMarket':PhoneMarket,
      'TybeMarket':TybeMarket,
      'ImageProfile':ImageProfile,
      'Lat':Lat,
      'Long':Long,
      'Token':Token,
    };
  }

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AdminData(
      Token: snapshot['Token'],
      ImageProfile:snapshot['ImageProfile'],
      EmailAddress: snapshot["EmailAddress"],
      Name: snapshot["Name"],
      Password: snapshot["Password"],
      Logo: snapshot["Logo"],
      Uid: snapshot["Uid"],
      NameMarket: snapshot["NameMarket"],
      DataAdded: snapshot["DataAdded"],
      Offar: snapshot["Offar"],
      Location: snapshot["Location"],
      PhoneMarket:snapshot['PhoneMarket'],
      TybeMarket:snapshot['TybeMarket'],
      Lat:snapshot['Lat'],
      Long: snapshot['Long']
    );
  }



}