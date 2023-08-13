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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.Prudact['items'][index]['Name']+'${index+1}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black45),),
                        ListView.builder(itemBuilder: (context, index1) => Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(widget.Prudact['items'][index]['Opitions'][index1]['mainOption'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red),),
                              ListView.builder(itemBuilder: (context, index2) =>Container(
                                child: widget.Prudact['items'][index]['Opitions'][index1]['subOptions'][index2]['add']?
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.teal,width: 3)),
                                    margin: EdgeInsets.only(left: 150,right: 50),
                                    child: Center(child: Text( widget.Prudact['items'][index]['Opitions'][index1]['subOptions'][index2]['optionName'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)))
                                    :
                                Text(''),
                              ),physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount:widget.Prudact['items'][index]['Opitions'][index1]['subOptions'].length ,)
                            ],
                          ),
                        ),physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount:widget.Prudact['items'][index]['Opitions'].length ,)
                      ],
                    ),
                  ),
                ],
              )
              ,itemCount: widget.Prudact['items'].length,shrinkWrap: true),
        ),
      )    );
  }
}
