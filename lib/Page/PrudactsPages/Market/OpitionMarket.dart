import 'package:adminhala/Page/PrudactsPages/AddPrudactWithDeatels.dart';
import 'package:adminhala/Page/PrudactsPages/Market/PrudactWithOpitionsMarket.dart';
import 'package:flutter/material.dart';

class OptionsMarket extends StatefulWidget {
  Map Data_From_Main_Collection;

  OptionsMarket({required this.Data_From_Main_Collection});

  @override
  State<OptionsMarket> createState() => _OptionsMarketState();
}

class _OptionsMarketState extends State<OptionsMarket> {
  List<Map<String, dynamic>> mainList = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController optionNameController = TextEditingController();
  final TextEditingController optionPriceController = TextEditingController();

  void addOption() {
    String optionName = optionNameController.text;
    int optionPrice = int.tryParse(optionPriceController.text) ?? 0;

    if (optionName.isNotEmpty && optionPrice >= 0) {
      setState(() {
        Map<String, dynamic> newOption = {
          'Id':0,
          'mainOption': nameController.text,
          'subOptions': [
            {
              'optionName': optionName,
              'optionPrice': optionPrice,
              'add':false,
            },
          ],
        };
        mainList.add(newOption);
        optionNameController.clear();
        optionPriceController.clear();
        nameController.clear();
      });
    }
  }

  void addOptionData() {
    String optionName = optionNameController.text;
    int optionPrice = int.tryParse(optionPriceController.text) ?? 0;

    if (optionName.isNotEmpty && optionPrice >= 0) {
      setState(() {
        mainList.last['subOptions'].add({
          'optionName': optionName,
          'optionPrice': optionPrice,
          'add':false,
        });
        optionNameController.clear();
        optionPriceController.clear();
      });
    }
  }

  void addMainList() {
    setState(() {
      mainList.add({
        'mainOption': nameController.text,
        'subOptions': [],
      });
      nameController.clear();
    });
  }

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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 50,right: 50,bottom: 20,top: 20),
            child:Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'اسم الخيار الرئيسي',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    hintText: 'مثلا الحجم',
                    hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: optionNameController,
                  decoration: InputDecoration(labelText: 'الاختيار',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    hintText: 'مثلا كبير',
                    hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: optionPriceController,
                  decoration: InputDecoration(labelText: 'سعر هذا الاختيار',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    hintText: 'مثلا 35',
                    hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
              ],
            ) ,
          ),
          Container(
            margin: EdgeInsets.only(left:30,right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: addOption,
                  child: Text('إضافة خيار جديد',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
                ),
                ElevatedButton(
                  onPressed: addOptionData,
                  child: Text('خيار فرعي',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
                SizedBox(width: 20,),

              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mainList.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${index + 1}',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      Text(
                        mainList[index]['mainOption'],
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Container(
                                  height: 100,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('هل انت متأكد من حذف اختيار (${mainList[index]['mainOption']})'),
                                      Container(
                                        margin: EdgeInsets.only(left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'لا',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  mainList.removeAt(index);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'نعم',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: mainList[index]['subOptions'].length,
                      itemBuilder: (context, subIndex) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${subIndex + 1}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              Text(
                                mainList[index]['subOptions'][subIndex]['optionName'],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    mainList[index]['subOptions'].removeAt(subIndex);
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'سعر الاختيار: ${mainList[index]['subOptions'][subIndex]['optionPrice']}',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: (){print(mainList);},
            child: Text('Test'),
          ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PrudactWithOpitionsMarket(
                  Data_From_Main_Collection: widget.Data_From_Main_Collection, Opitions: mainList),));
            },
            child: Container(
              margin: EdgeInsets.only(left: 50,right: 50,bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(56, 95, 172, 1),
                        Color.fromRGBO(1, 183, 168, 1)
                      ]
                  )),
              child: Center(child: Text("التالي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),)),
            ),
          ),
          ElevatedButton(onPressed: (){print(mainList);}, child: Text('Test'))
        ],
      ),
    );
  }
}
