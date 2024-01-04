import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_test/UI/Home.dart';
import 'package:rakshak_test/UI/LoginPage.dart';
import 'package:rakshak_test/UI/RegisterPage.dart';
import 'package:rakshak_test/Firebase/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot){
          if(snapshot.hasData){
            return const HomePage();
          }
          
          return const MyHomePage(title: "Rakshak");
          })
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                backgroundImage: AssetImage('Assets/Images/logo.png'),
              ),
          ),
         const SizedBox(height: 30),

         RichText(
              text: const TextSpan(
                  text: 'WELCOME TO RAKSHAK!',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Colors.black,
                    fontSize: 32,
                  )
              )
          ),

          const SizedBox(height: 7),

          const Text(
            'Your Safety made simpler',
            style: TextStyle(
             color: Colors.black,
              fontSize: 20,
            )
          ),

          const SizedBox(height: 50),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              fixedSize:const Size.fromWidth(300)
            ),
              onPressed: (){
                Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => const LoginPage())
                );
              },
              child: const Text('LOG IN'),
          ),

          const SizedBox(height: 20),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.deepPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              fixedSize: const Size.fromWidth(300),
              side: const BorderSide(color: Colors.deepPurple)
            ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage())
                );
              },
              child: const Text('REGISTRATION')
          )
        ],
      )),
    );
  }
}
