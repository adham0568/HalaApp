import 'dart:io';
import 'dart:math';
import 'package:adminhala/Page/AuthPages/AddLocation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename, url;
import '../../models/SnackBar.dart';
import 'AuthFireBase.dart';
import 'LogInPage.dart';

class SingUpPage extends StatefulWidget {
  bool LocationAdd;
  double Lat;
  double Long;
  SingUpPage({Key? key,required this.Lat,required this.Long,required this.LocationAdd}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}
bool waiting=false;
bool Showpass1=true;
File? imgPath,imgPath1;
String? imgName1,imgName;
final name=TextEditingController();
final username=TextEditingController();
final marketname=TextEditingController();
final emailaddress=TextEditingController();
final pass=TextEditingController();
final PhoneMarket=TextEditingController();
final _formKey = GlobalKey<FormState>();
List<String> City = [
  "الخليل",
  "نابلس",
  "طولكرم",
  "يطا",
  "جنين",
  "البيرة",
  "دورا",
  "رام الله",
  "الظاهرية",
  "قلقيلية",
  "بيت لحم",
  "طوباس",
  "سلفيت",
  "بيت جالا",
  'بيت ساحور'
];
List<String> Tybe = [
  'شورما',
  'اسماك',
  'افطار',
  'برجر',
  'بيتزا',
  'حلويات',
  'مناقيش',
  'طبخ منزلي',
  'مشروبات',
  'مكسرات',
  'مخبوزات',
  'ملحمة',
  'صيدلية',
];
int? TybeMarket;
int? selectedTextIndex;
class _SingUpPageState extends State<SingUpPage> {
  String _token='';

  OpenStdyo() async {

    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try{if(pickedImg !=null){setState(() {imgPath=File(pickedImg.path);imgName = basename(pickedImg.path);int random = Random().nextInt(9999999);int random1=Random().nextInt(9999999);
    imgName = "$random$random1$imgName";});
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }
  OpenStdyo2() async {

    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try{if(pickedImg !=null){setState(() {imgPath1=File(pickedImg.path);imgName1 = basename(pickedImg.path);int random = Random().nextInt(9999999);int random1=Random().nextInt(9999999);
    imgName1 = "$random$random1$imgName1";});
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }
  @override
  void initState() {

    var fbm=FirebaseMessaging.instance;
    fbm.getToken().then((token){
      print('===================================================');
      _token=_token;
      print('===================================================');

    });
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
              child: Container(
                margin: const EdgeInsets.only(left: 30,right: 30,top: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            OpenStdyo();
                            print(imgName);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.grey),
                            child: imgPath==null? const Center(child: Text('صورة شعار المطعم')) :CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(imgPath!),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            OpenStdyo2();
                            print(imgName1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.grey),
                            child: imgPath1==null? const Center(child: Text('صورة غلاف للمطعم')) :CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(imgPath1!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: marketname,
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold),
                        hintText: 'اسم المطعم',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.fastfood),
                        prefixIconColor: Colors.grey.shade900,
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: name,
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold),
                        hintText: 'الاسم الشخصي',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.account_circle),
                        prefixIconColor: Colors.grey.shade900,
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      validator: (email) {return email!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))?  null: "أدخل بريد الكتروني صالح";},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailaddress,
                      style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                      //النص الذي سيتم ادخاله
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintText:'البريد الالكتروني' ,
                        hintStyle: TextStyle(color: Colors.grey.shade900),
                        prefixIcon:  const Icon(Icons.email),
                        prefixIconColor: Colors.grey.shade900,
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: PhoneMarket,
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold),
                        hintText: 'تلفون المطعم',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.fastfood),
                        prefixIconColor: Colors.grey.shade900,
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: pass,
                      validator: (value) {return  value!.length<8 ? "ادخل كلمة مرور اكثر من 8 احرف" : null;},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                      obscureText: Showpass1,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintStyle:
                        TextStyle(
                            color: Colors.grey.shade900, fontWeight: FontWeight.bold),
                        hintText: 'كلمة المرور',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(Icons.password,color: Colors.grey.shade900,),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              Showpass1 = !Showpass1;
                            });
                          },
                          icon: Showpass1
                              ? Icon(
                            Icons.visibility_off,
                            color: Colors.grey.shade900,
                          )
                              : Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        prefixIconColor: const Color.fromRGBO(0, 175, 162, 10),
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('* اختار المدينة الموجود فيها متجرك',style: TextStyle(color: Colors.red),),
                    DropdownButtonFormField<int>(
                      value: selectedTextIndex,
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedTextIndex = newValue;
                          print(selectedTextIndex);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'اختر المدينة',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      items: City.asMap().entries.map<DropdownMenuItem<int>>(
                            (MapEntry<int, String> entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key + 1,
                            child: Text(entry.value),
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(height: 25,),
                    const Text('* اختار المدينة الموجود فيها متجرك',style: TextStyle(color: Colors.red),),
                    DropdownButtonFormField<int>(
                      value: selectedTextIndex,
                      onChanged: (int? newValue) {
                        setState(() {
                          TybeMarket = newValue;
                          print(TybeMarket);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: '*اختار تصنيف مطعمك او متجرك',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      items: Tybe.asMap().entries.map<DropdownMenuItem<int>>(
                            (MapEntry<int, String> entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key ,
                            child: Text(entry.value),
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(height: 25,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const LocationPage(),));
                    },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child: const Text('تحديد احداثيات المطعم',style: TextStyle(color: Colors.white),),),
                    const SizedBox(height: 25,),
                    widget.LocationAdd? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey)),
                        onPressed: ()  async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              waiting=true;
                            });
                            print(imgName);
                            print(imgName1);
                            await AuthMethods().SingUp(
                                Token: _token,
                                imgpath1:imgPath1 ,
                                ImageProfile: imgName1!,
                                imgName: imgName,
                                imgPath: imgPath,
                                context: context,
                                imagePath: 'AdminDataImage',
                                Name: name.text,
                                Location: selectedTextIndex!,
                                NameMarket: marketname.text,
                                Email: emailaddress.text,
                                Password: pass.text,
                                Offar: 0,
                                Dateadded: DateTime.now(),
                                PhoneMarket: int.parse(PhoneMarket.text),
                                TybeMarket: TybeMarket!,
                                Lat: widget.Lat,
                                Long: widget.Long,
                            );
                            setState(() {
                              waiting=false;
                            });
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LogIn()),(Route<dynamic> route) => false,);
                          } else{showSnackBar(context: context,text: 'الرجاء التحقق من البيانات المدخلة',colors: Colors.red);}
                        },
                        child:waiting? const CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.white,valueColor: AlwaysStoppedAnimation(Color.fromRGBO(0, 175, 162, 10)),)
                            :const Text(
                          'SingUp',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        )):Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Do Have Account?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogIn()));
                            },
                            child: const Text(
                              'تسجيل الدخول الان',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ))
                      ],
                    ),
                    ElevatedButton(onPressed: (){print(TybeMarket);}, child: const Text('Test'))
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}







