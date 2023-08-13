import 'package:adminhala/Page/Ordar/PrudactOrdarDetals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/OrdarProvider.dart';
import '../../models/FireBaseStatemant.dart';

class OrdarDetals extends StatefulWidget {
  int hight1;
  Map DataOrdar;
  Map DataOrdarDetals;
  String Name;
  OrdarDetals({Key? key,required this.DataOrdar,required this.hight1,required this.Name,required this.DataOrdarDetals}) : super(key: key);

  @override
  State<OrdarDetals> createState() => _OrdarDetalsState();
}
FireBase FireServices=FireBase();
double? HightContener;

List<bool> DoneOrNot = [];class _OrdarDetalsState extends State<OrdarDetals> {
  @override
  void initState() {
    DoneOrNot = List<bool>.filled(widget.DataOrdar['items'].length, false);
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    List<dynamic> displayedItems = [];
    for (var item in widget.DataOrdar['items']) {
      var isItemDisplayed = displayedItems
          .where((displayedItem) => displayedItem['IdPrudact'] == item['IdPrudact'])
          .isEmpty;
      if (isItemDisplayed) {
        displayedItems.add(item);
      }
    }
    double containerHeight = displayedItems.length * 300.0;
    setState(() {
      if(displayedItems.length<3){containerHeight=displayedItems.length * 800.0;}
      else if(displayedItems.length>3 &&displayedItems.length<5){HightContener=displayedItems.length * 500.0;}
      else if(displayedItems.length>5){HightContener=displayedItems.length * 350.0;}    });
    final _Provaider = Provider.of<Ordars>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Images/logowelcome.png'),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: LinearGradient(
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
            Image.asset('assets/Images/logowelcome.png',height: 160,),
            InkWell(
              splashColor: Colors.teal,
              borderRadius:BorderRadius.only(
                topLeft: Radius.circular(50.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(50.0),
                topRight: Radius.circular(10.0),
              ) ,
              child: Container(
                  padding: EdgeInsets.all(7),
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 25,right: 25,bottom: 50),
                  height:containerHeight,//displayedItems.length.isOdd?containerHeight= displayedItems.length * 500.0:containerHeight= displayedItems.length * 300.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(100.0),
                        topRight: Radius.circular(5),
                      ),
                      //78/246/123
                      //80/181/248
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
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(100.0),
                                  topRight: Radius.circular(5),
                                ),
                                //78/246/123
                                //80/181/248
                                color: Colors.deepOrange
                            ),
                            height: 300,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('حالة الطلب',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                                ElevatedButton(onPressed: () async {
                                  await FireServices.OrdarState(ordarid: widget.DataOrdar['orderID'],State:2);
                                }, child: Text('قيد التحضير',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),),
                                ElevatedButton(onPressed: () async {
                                 await FireServices.OrdarState(ordarid: widget.DataOrdar['orderID'],State:3);
                                }, child: Text('على الطريق',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo)),),
                                ElevatedButton(onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Container(
                                          color: Colors.white,
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('هل تم تسليم الطلب للتوصيل؟',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: [
                                                 ElevatedButton(onPressed: () async {
                                                   await FireServices.TotalPrifitUpdate(Prise:widget.DataOrdar['totalPrice']);
                                                   await FireServices.OrdarDoneUpdate();
                                                   await FireServices
                                                       .sendListToFirestore(
                                                       Uid: widget.DataOrdar['User'],
                                                       IdOrdar: widget.DataOrdar['orderID'],
                                                       prise:widget.DataOrdar['totalPrice'],
                                                       Prudact:widget.DataOrdar['items']);
                                                   await FireServices.OrdarState(ordarid: widget.DataOrdar['orderID'],State:4);
                                                   Navigator.pop(context);
                                                 }, child: Text('نعم',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),),
                                                 ElevatedButton(onPressed: ()  {
                                                   Navigator.pop(context);
                                                 }, child: Text('لا',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),),

                                               ],
                                             )
                                            ],
                                          ),
                                        ),
                                      )
                                    );
                                  }, child: Text('الطلب مكتمل',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                SizedBox(height: 40,)
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.Name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text('المنتجات', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
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
                                  height: 120,
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white54,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 120,
                                              child: Image.network(currentItem['ImageUrl'],fit: BoxFit.contain,)),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(currentItem['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              widget.DataOrdar['items'].length>0 ?ElevatedButton(onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => PrudactOrdarDetals(Prudact: widget.DataOrdarDetals),));
                                              },
                                                child:Text('تفاصيل'),
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                              ):
                                             ElevatedButton(onPressed: (){
                                               setState(() {
                                                 DoneOrNot[index] = !DoneOrNot[index];
                                               });
                                             }, child:Text(DoneOrNot[index]?' جاهز':'تم'),
                                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(DoneOrNot[index]?Colors.green:Colors.red)),
                                             ),
                                              Text('الكمية: $duplicateItemsCount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
                                              Text('${currentItem['Prise']*duplicateItemsCount} ₪', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),

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

                      Text(widget.DataOrdar['totalPrice'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
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
