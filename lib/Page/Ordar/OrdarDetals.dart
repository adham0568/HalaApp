import 'package:adminhala/Page/Ordar/PrudactOrdarDetals.dart';
import 'package:adminhala/models/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../Provider/OrdarProvider.dart';
import '../../models/FireBaseStatemant.dart';

class OrdarDetals extends StatefulWidget {
  Map DataAdmin;
  int hight1;
  Map DataOrdarDetals,DataOrdar;
  String Name;
  OrdarDetals({Key? key,required this.DataAdmin,required this.DataOrdar,required this.hight1,required this.Name,required this.DataOrdarDetals}) : super(key: key);

  @override
  State<OrdarDetals> createState() => _OrdarDetalsState();
}
class _OrdarDetalsState extends State<OrdarDetals> {
  int decimalPlaces =1;
List finalItems=[];
  NumberOfrepetitions(){
   List Items= widget.DataOrdar['items'];
    Map ItemsValue={};
    for(int i=0;i<Items.length;i++){
      if(ItemsValue.containsKey(Items[i]['IdPrudact'])){ItemsValue[Items[i]['IdPrudact']] += 1;}
      else{ItemsValue[Items[i]['IdPrudact']]=1;}
    }
    ItemsValue.forEach((key, value) {
      finalItems.add({'ID':key,'Count':value});
    });
    print(finalItems);
  }



  FireBase FireServices=FireBase();
  double? HightContener;
  List<bool> DoneOrNot = [];
  double CalculatedPrise(){
    double prise=0;
    for(int i=0;i<widget.DataOrdar['items'].length;i++){
      double priseforindexprudact= widget.DataOrdar['items'][i]['Prise'];
     prise+=priseforindexprudact;
    }
    return prise;
  }
  @override
  void initState() {
    CalculatedPrise();
    DoneOrNot = List<bool>.filled(widget.DataOrdar['items'].length, false);
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    NumberOfrepetitions();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    List<dynamic> displayedItems = [];
    for (var item in widget.DataOrdar['items']) {
      var isItemDisplayed = displayedItems
          .where((displayedItem) => displayedItem['IdPrudact'] == item['IdPrudact'])
          .isEmpty;
      if (isItemDisplayed) {
        displayedItems.add(item);
      }
    }
    final Provaider = Provider.of<Ordars>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Images/logowelcome.png'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ]
          )),
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              splashColor: Colors.teal,
              borderRadius:BorderRadius.only(
                topLeft: Radius.circular(w/10),
                bottomLeft: Radius.circular(w/30),
                bottomRight: Radius.circular(w/10),
                topRight: Radius.circular(w/30),
              ) ,
              child: Container(
                  padding: EdgeInsets.only(bottom: w/7,right: w/50,left: w/50,top: w/50),
                  width: double.infinity,
                  margin: EdgeInsets.only(left: h/50,right: h/50,bottom: h/50,top: h/50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(w/30),
                        bottomLeft: Radius.circular(w/30),
                        bottomRight: Radius.circular(w/5),
                        topRight: Radius.circular(w/30),
                      ),
                      color: Colors.black54
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(w/30),
                                  bottomLeft: Radius.circular(w/30),
                                  bottomRight: Radius.circular(w/5),
                                  topRight: Radius.circular(w/30),
                                ),
                                //78/246/123
                                //80/181/248
                                color: Colors.deepOrange
                            ),
                            height: h/2.5,
                            width: w/2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('حالة الطلب',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/20,color: Colors.white),),
                                ElevatedButton(onPressed: () async {
                                  await FireServices.OrdarState(ordarid: widget.DataOrdar['orderID'],State:2);
                                },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)), child: Text('قيد التحضير',style: TextStyle(fontSize: w/20,fontWeight: FontWeight.bold),),),
                                ElevatedButton(onPressed: () async {
                                 await FireServices.OrdarState(ordarid: widget.DataOrdar['orderID'],State:3);
                                },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo)), child: Text('على الطريق',style: TextStyle(fontSize: w/20,fontWeight: FontWeight.bold)),),
                                ElevatedButton(onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Container(
                                          color: Colors.white,
                                          height: h/4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('هل تم تسليم الطلب للتوصيل؟',style: TextStyle(fontSize: w/20,fontWeight: FontWeight.bold),),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: [
                                                 ElevatedButton(onPressed: () async {
                                                   await FireServices.UpDateCount_requests(Items:finalItems);
                                                   await FireServices.TotalPrifitUpdate(Prise:widget.DataOrdar['totalPrice']);
                                                   await FireServices.OrdarDoneUpdate();
                                                   await FireServices.sendListToFirestore(
                                                       NameUser:widget.DataOrdar['NameUser'] ,
                                                       Uid: widget.DataOrdar['User'],
                                                       IdOrdar: widget.DataOrdar['orderID'],
                                                       prise:widget.DataOrdar['totalPrice'],
                                                       Prudact:widget.DataOrdar['items']);
                                                   await FireServices.OrdarState(ordarid: widget.DataOrdar['orderID'],State:4);
                                                   SendToDelivary().sendOrdarToDelivary(
                                                       PriseOrdar: widget.DataOrdar['totalPrice'],
                                                       OrdarId: widget.DataOrdar['orderID'],
                                                       NameUser: widget.DataOrdar['NameUser'],
                                                       items:widget.DataOrdar['items'],
                                                       MarketName: widget.DataAdmin['Name'],
                                                       MarketLocation:GeoPoint(widget.DataAdmin['Lat'],widget.DataAdmin['Long']) as GeoPoint, //error ,
                                                       UserLocation:GeoPoint(widget.DataOrdar['UserLat'], widget.DataOrdar['UserLng']) as GeoPoint,
                                                       City: 12,location: LatLng(32.3230019, 35.3689003));
                                                   Navigator.pop(context);
                                                 },
                                                   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)), child: Text('نعم',style: TextStyle(fontSize: w/20,fontWeight: FontWeight.bold)),),
                                                 ElevatedButton(onPressed: ()  {
                                                   Navigator.pop(context);
                                                 },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)), child: Text('لا',style: TextStyle(fontSize: w/20,fontWeight: FontWeight.bold)),),

                                               ],
                                             )
                                            ],
                                          ),
                                        ),
                                      )
                                    );
                                  },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child: Text('الطلب مكتمل',style: TextStyle(fontSize: w/20,fontWeight: FontWeight.bold)),),
                                const SizedBox(height: 40,)
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.Name,style: TextStyle(fontSize: w/19,fontWeight: FontWeight.bold,color: Colors.white),),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text('المنتجات', style: TextStyle(fontSize: w/18, fontWeight: FontWeight.bold, color: Colors.white)),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.DataOrdar['items'].length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var currentItem = widget.DataOrdar['items'][index];

                              // فحص ما إذا كان المنتج تم عرضه بالفعل
                              var isProductDisplayed = widget.DataOrdar['items']
                                  .sublist(0, index)
                                  .where((item) => item['IdPrudact'] == currentItem['IdPrudact'])
                                  .isEmpty;

                              // حساب عدد المنتجات المتماثلة للمنتج الحالي
                              var duplicateItemsCount = widget.DataOrdar['items']
                                  .where((item) => item['IdPrudact'] == currentItem['IdPrudact'])
                                  .length;

                              // عرض المنتج وعدد المنتجات المتماثلة إذا كان المنتج لم يتم عرضه بالفعل
                              if (isProductDisplayed) {
                                return Container(
                                  height: h/5.2,
                                  margin: const EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left: w/30, right: w/30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(w/20),
                                    color: Colors.white54,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: w/3,
                                              child: Image.network(currentItem['ImageUrl'],fit: BoxFit.contain,)),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(currentItem['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/25, color: Colors.white)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              widget.DataOrdar['items'].length>0 ?ElevatedButton(onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => PrudactOrdarDetals(Prudact: widget.DataOrdarDetals),));
                                              },
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                                child:Text('تفاصيل',style: TextStyle(fontSize: w/25),),
                                              ):
                                             ElevatedButton(onPressed: (){
                                               setState(() {
                                                 DoneOrNot[index] = DoneOrNot[index];
                                               });
                                             },
                                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(DoneOrNot[index]?Colors.green:Colors.red)), child:Text(DoneOrNot[index]?' جاهز':'تم'),
                                             ),
                                              Text('الكمية: $duplicateItemsCount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/25, color: Colors.red)),
                                              Text('${CalculatedPrise().toStringAsFixed(decimalPlaces)} ₪', style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/25, color: Colors.red)),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // إعادة واجهة فارغة إذا تم عرض المنتج بالفعل
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),

                      Text(widget.DataOrdar['totalPrice'],style: TextStyle(fontSize: w/18,fontWeight: FontWeight.bold,color: Colors.white),),
                    ],
                  )
              ),
            ),

          ],
        ),
      ),
    );
  }
}
