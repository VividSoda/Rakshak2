import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String name, String email, String password, String confirmPass) async{
    try{
      await firestore.collection('users').add({
        "name" : name,
        "email" : email,
        "password" : password,
        "confirm password" : confirmPass,
      }
      );
    }

    catch(e){
      return null;
    }
}
}