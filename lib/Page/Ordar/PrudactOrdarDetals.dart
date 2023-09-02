import 'package:flutter/material.dart';

class PrudactOrdarDetals extends StatefulWidget {
  Map Prudact;
  PrudactOrdarDetals({Key? key,required this.Prudact}) : super(key: key);

  @override
  State<PrudactOrdarDetals> createState() => _PrudactOrdarDetalsState();
}

class _PrudactOrdarDetalsState extends State<PrudactOrdarDetals> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Text('تفاصيل الطلب',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 35),),
              Container(
                  color: Colors.white,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: w/20,right: w/20,bottom:w/25 ,top:w/25 ),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black,width: 1)),
                          margin: EdgeInsets.only(bottom: h/40,left: w/30,right: w/30),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //
                                      Text(widget.Prudact['items'][index]['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/22,color: Colors.black),),
                                      Text(' : ${index+1}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/22,color: Colors.black),)
                                    ],
                                  )),
                              ListView.builder(itemBuilder: (context, index1) => Container(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: w/15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.Prudact['items'][index]['Opitions'][index1]['subOptions'][widget.Prudact['items'][index]['OpitionSelected'][index1]]['optionName']
                                        ,style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w100),
                                      ),
                                      Text(widget.Prudact['items'][index]['Opitions'][index1]['mainOption'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red),),

                                    ],
                                  ),
                                ),
                              ),physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount:widget.Prudact['items'][index]['Opitions'].length ,)
                            ],
                          ),
                        ),
                      ],
                    )
                    ,itemCount: widget.Prudact['items'].length,shrinkWrap: true),
              ),
            ],
          ),
        ),
      )    );
  }
}