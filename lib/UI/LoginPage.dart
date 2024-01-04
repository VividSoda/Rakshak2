import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_test/Firebase/auth_service.dart';
import 'package:rakshak_test/UI/ForgotPassword.dart';

import 'Home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
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
                          text: 'Rakshak Log In!',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontFamily: "BebasNeue"
                          )
                      )
                  ),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                                filled: true,
                                hintText: 'Enter your email address',
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                            ),
                          controller: _email,
                          validator: (value){
                            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);

                              if (value.isEmpty){
                                return "Enter email!!!!";
                              }

                              else if(emailValid == false){
                                return "Email format wrong!!!";
                              }

                              else{
                                return null;
                              }
                          },
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller: _password,
                          obscureText: _isPasswordHidden,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                hintText: 'Enter password',
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    }
                                    );
                                  },

                                  icon: Icon(
                                      _isPasswordHidden? Icons.visibility_off : Icons.visibility
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                )
                            ),

                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter Password";
                            }

                            else{
                              return null;
                            }
                          },
                        ),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue
                            ),
                              onPressed: (){
                                  Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => const ForgotPasswordPage())
                                  );
                          },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )),
                        ),

                        const SizedBox(height: 5),

                        _loading? const CircularProgressIndicator() : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                fixedSize: const Size(350, 50)
                            ),
                            onPressed: () async{
                              setState(() {
                                _loading = true;
                              });
                              if (_formKey.currentState!.validate()){

                              }

                              User? result = await AuthService().login(_email.text, _password.text, context);

                              if(result!=null){
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomePage()),
                                        (route) => false
                                );
                              }

                              setState(() {
                                _loading = false;
                              });
                            },
                            child: const Text("LOG IN")
                        ),

                      ],
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
