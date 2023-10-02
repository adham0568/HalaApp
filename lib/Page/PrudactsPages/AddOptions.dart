import 'package:adminhala/Page/PrudactsPages/AddPrudactWithDeatels.dart';
import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  Map data_Collection;
  Map Data_From_Main_Collection;

  Options({super.key, required this.data_Collection,required this.Data_From_Main_Collection});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 50,right: 50,bottom: 20,top: 20),
            child:Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'اسم الخيار الرئيسي',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    hintText: 'مثلا الحجم',
                    hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: optionNameController,
                  decoration: const InputDecoration(labelText: 'الاختيار',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    hintText: 'مثلا كبير',
                    hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: optionPriceController,
                  decoration: const InputDecoration(labelText: 'سعر هذا الاختيار',
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
            margin: const EdgeInsets.only(left:30,right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: addOption,
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
                  child: const Text('إضافة خيار جديد',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                ElevatedButton(
                  onPressed: addOptionData,
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: const Text('خيار فرعي',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                const SizedBox(width: 20,),

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
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      Text(
                        mainList[index]['mainOption'],
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      const SizedBox(width: 8),
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
                                        margin: const EdgeInsets.only(left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                              ),
                                              child: const Text(
                                                'لا',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  mainList.removeAt(index);
                                                });
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                              ),
                                              child: const Text(
                                                'نعم',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mainList[index]['subOptions'].length,
                      itemBuilder: (context, subIndex) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${subIndex + 1}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              Text(
                                mainList[index]['subOptions'][subIndex]['optionName'],
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    mainList[index]['subOptions'].removeAt(subIndex);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'سعر الاختيار: ${mainList[index]['subOptions'][subIndex]['optionPrice']}',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
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
            child: const Text('Test'),
          ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PrudactWithOpitions(
                  data_Collection: widget.data_Collection, Data_From_Main_Collection: widget.Data_From_Main_Collection, Opitions: mainList),));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 50,right: 50,bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(56, 95, 172, 1),
                        Color.fromRGBO(1, 183, 168, 1)
                      ]
                  )),
              child: const Center(child: Text("التالي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),)),
            ),
          ),
          ElevatedButton(onPressed: (){print(mainList);}, child: const Text('Test'))
        ],
      ),
    );
  }
}
