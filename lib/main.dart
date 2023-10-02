import 'package:adminhala/Provider/OrdarProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Page/AuthPages/LogInPage.dart';
import 'Page/HomePage.dart';
import 'models/SnackBar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){return Ordars();}),
      ],
      child: MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: CircularProgressIndicator(color: Colors.white,));}
            else if (snapshot.hasError) {return showSnackBar(context: context, text: 'Error 404', colors: Colors.red);}
            else if (snapshot.hasData) {return const HomePage();}
            else { return const LogIn();}
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
