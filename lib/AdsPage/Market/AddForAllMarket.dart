import 'package:adminhala/AdsPage/Market/AddNewAds.dart';
import 'package:adminhala/AdsPage/Market/MyAds.dart';
import 'package:flutter/material.dart';

class AddMarket extends StatefulWidget {
  const AddMarket({Key? key}) : super(key: key);

  @override
  State<AddMarket> createState() => _AddMarketState();
}

class _AddMarketState extends State<AddMarket> {
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
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
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50,bottom: 50),
        child: Center(
          child: Column(
            children: [
             InkWell(
               onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAddsMarket(),));
               },
               child: Container(
                 width: w*0.9,
                 height: h/10,
                 decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(3),bottomRight:  Radius.circular(3),
                       bottomLeft:  Radius.circular(15),topRight: Radius.circular(15),),
                   gradient: LinearGradient(
                     begin: Alignment.topRight,
                     end: Alignment.bottomLeft,
                     colors: [
                       Colors.tealAccent,
                       Colors.teal
                     ]
                   )
                 ),
                 child: Center(child: Text('إضافة اعلان',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/14,color: Colors.white),)),
               ),
             ),
              SizedBox(height: h/30,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAdd(),));
                },
                child: Container(
                  width: w*0.9,
                  height: h/10,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(3),bottomRight:  Radius.circular(3),
                        bottomLeft:  Radius.circular(15),topRight: Radius.circular(15),),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.tealAccent,
                            Colors.teal
                          ]
                      )
                  ),
                  child: Center(child: Text('إعلانتي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/14,color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
