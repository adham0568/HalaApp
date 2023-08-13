import 'package:adminhala/AdsPage/AddsDetals.dart';
import 'package:adminhala/AdsPage/AddNewImage.dart';
import 'package:adminhala/AdsPage/WelcomePage.dart';
import 'package:flutter/material.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({Key? key}) : super(key: key);

  @override
  State<AdsPage> createState() => _AdsPageState();
}
//page 1
class _AdsPageState extends State<AdsPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        margin: EdgeInsets.only(top: 50,bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detal(NameDocumant: 'E9gjtaIUHghyU0jneZZA'),));

              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.purple,
                            Colors.red
                          ]
                      )
                  ),
                  child: Center(
                    child: Text(
                      'Hala Market Add 1',style: TextStyle(
                        fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detal(NameDocumant: 'HalaMarketAdd2'),));

              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.purple,
                            Colors.red
                          ]
                      )
                  ),
                  child: Center(
                    child: Text(
                      'Hala Market Add 2',style: TextStyle(
                        fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detal(NameDocumant: 'HomePage',),));
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.purple,
                            Colors.blueGrey
                          ]
                      )
                  ),
                  child: Center(
                    child: Text(
                      'Home Page Add 1',style: TextStyle(
                        fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detal(NameDocumant: 'HomePageAdd2',),));

              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.purple,
                            Colors.blueGrey
                          ]
                      )
                  ),
                  child: Center(
                    child: Text(
                      'Home Page Add 2',style: TextStyle(
                        fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detal(NameDocumant: 'Rusturantadd',),));
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.teal,
                            Colors.greenAccent
                          ]
                      )
                  ),
                  child: Center(
                    child: Text(
                      'Rusturant Add',style: TextStyle(
                        fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),));
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.yellow,
                            Colors.red
                          ]
                      )
                  ),
                  child: Center(
                    child: Text(
                      'Welcome Page Image',style: TextStyle(
                        fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
