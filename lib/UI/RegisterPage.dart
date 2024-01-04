import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_test/UI/LoginPage.dart';
import 'package:rakshak_test/Firebase/auth_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:rakshak_test/Firebase/firestore_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _password.dispose();
    _confirmPass.dispose();
    _email.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),

          //Logo
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                backgroundImage: AssetImage('Assets/Images/logo.png'),
              ),
            ),
          ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: const TextSpan(
                  text: 'GET STARTED!',
                  style: TextStyle(
                    fontFamily: "BebasNeue",
                    fontSize: 32,
                    color: Colors.black
                  ),
                )),
              ),

              const SizedBox(height: 10),

          Align(
            alignment: Alignment.center,
            child: RichText(
                text: const TextSpan(
                  text: 'Digital Security for your Physical Self',
                  style: TextStyle(
                    fontFamily: "BebasNeue",
                      fontSize: 20,
                      color: Colors.black
                  ),
                )),
          ),

              const SizedBox(height: 20),

              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                 children: [

                   TextFormField(
                     validator: (value){
                       if (value!.isEmpty) {
                         return 'Enter your Name!!!';
                       }
                        if(value.split(' ').length==1){
                          return 'Enter your full name';
                        }
                       return null;
                     },
                     controller: _name,
                     decoration: InputDecoration(
                       filled: true,
                         fillColor: Colors.grey[200],
                         hintText: 'Enter Name',
                         labelText: 'Name',
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15))),
                   ),

                   const SizedBox(height: 10),

                   TextFormField(
                     controller: _email,
                     decoration: InputDecoration(
                       fillColor: Colors.grey[200],
                         filled: true,
                         hintText: 'Enter Email',
                         labelText: 'Email',
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15))),
                     validator: (value){
                       bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);

                       if(value.isEmpty){
                         return "Enter email!!!!";
                       }

                       if(emailValid == false){
                         return "Email format wrong!!!";
                       }

                       else{
                         return null;
                       }
                     },
                   ),

                   const SizedBox(height: 10),

                   TextFormField(
                     obscureText: _isPasswordHidden,
                     decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.grey[200],
                         suffixIcon: IconButton(
                           onPressed: (){
                             setState(() {
                               _isPasswordHidden = !_isPasswordHidden;
                             });
                           },
                           icon: Icon(
                             _isPasswordHidden? Icons.visibility_off : Icons.visibility
                           ),
                         ),
                         hintText: 'Enter Password',
                         labelText: 'Password',
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15))),
                     validator: (value) {
                       if(value!.isEmpty){
                         return "Enter Password!!!";
                       }

                       else if(value.length<8){
                         return "Password should be at least 8 characters long!!!";
                       }

                       else{
                         return null;
                       }
                     } ,
                     controller: _password,
                   ),

                   const SizedBox(height: 10),

                   TextFormField(
                     controller: _confirmPass,
                     validator: (value){
                       if(value!.isEmpty){
                         return "Re-Enter Password!!!";
                       }

                     else if(value != _password.text){
                       return "Confirm Password must be same as Password!!!";
                       }

                     else{
                       return null;
                       }
                     },
                     obscureText: _isConfirmPasswordHidden,
                     decoration: InputDecoration(
                       fillColor: Colors.grey[200],
                       filled: true,
                         suffixIcon: IconButton(
                           onPressed: (){
                             setState(() {
                               _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                             });
                           },
                           icon: Icon(
                               _isConfirmPasswordHidden? Icons.visibility_off : Icons.visibility
                           ),
                         ),
                         hintText: 'Confirm Password',
                         labelText: 'Confirm Password',
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15))),
                   ),

                  const SizedBox(height: 10),

                   //Register Button
                  _loading? const CircularProgressIndicator() : ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.deepPurple,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                       fixedSize:const Size(350, 50)
                     ),
                       onPressed: () async{
                       setState(() {
                         _loading = true;
                       });
                          if (_formKey.currentState!.validate()){
                            User? result =  await AuthService().register(_email.text, _password.text,context);

                            await FirestoreService().insertNote(_name.text, _email.text, _password.text, _confirmPass.text);

                            if(result!= null){
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                      (route) => false
                              );
                            }
                          }

                          setState(() {
                            _loading = false;
                          });
                       },
                       child:const Text(
                         'Register',
                       )
                   ),

                   const SizedBox(height: 20),

                   //OR
                   const Row(
                     children: [
                       Expanded(
                         child: Divider(
                           indent: 50,
                           endIndent: 5,
                           thickness: 1,
                           color: Colors.black,
                         ),
                       ),

                       Text("OR"),

                       Expanded(
                         child: Divider(
                           indent: 5,
                           endIndent: 50,
                           thickness: 1,
                           color: Colors.black,
                         ),
                       )
                     ],
                   ),

                   const SizedBox(height: 15),

                  _loading? const CircularProgressIndicator() : SignInButton(
                       Buttons.Google,
                       text: "Continue with Google",
                       onPressed: () async{
                         setState(() {
                           _loading = true;
                         });

                         await AuthService().signInWithGoogle();

                         // ignore: use_build_context_synchronously
                         Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(builder: (context) => const LoginPage()),
                                 (route) => false
                         );

                         setState(() {
                           _loading = false;
                         });
                       },
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10)
                     ),
                       ),

                 ],
                )
              ),
        ],
      ),
            ),
          )),
    );
  }
}
