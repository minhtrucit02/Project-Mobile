import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDao extends ChangeNotifier{
  String errorMsg = "An error has occurred";
  final auth = FirebaseAuth.instance;

  //TODO: add helper methods
  bool isLoggedIn(){
    return auth.currentUser != null;
  }

  String? userId(){
    return auth.currentUser?.uid;
  }

  String? email(){
    return auth.currentUser?.email;
  }

  //TODO: add signup
  Future<String?> signup(String email,String password) async{
      try{
        await auth.createUserWithEmailAndPassword(
            email: email,
            password: password);
        notifyListeners();
        return null;
      } on FirebaseAuthException catch (e){
        if(email.isEmpty){
          errorMsg = "Email is blank. ";
        } else if(password.isEmpty){
          errorMsg = "Password is empty. ";
        } else if(e.code =='week-password'){
          errorMsg ="The password provide is too week";
        } else if(e.code == 'email-already-in-use'){
          errorMsg = "The account already exits for that email";
        }
        return errorMsg;
      } catch (e){
        log(e.toString());
        return e.toString();
      }
  }

  //TODO: add Login
  Future<String? >login(String email, String password) async{
    try{
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e){
      if(email.isEmpty){
        errorMsg = "Email is blank.";
      } else if(password.isEmpty){
        errorMsg = "Password is blank.";
      } else if(e.code == "invalid-email"){
        errorMsg == "INVALID_LOGIN_CREDENTIALS.";
      } else if(e.code=='user-not-found'){
        errorMsg == "No user found for that email.";
      } else if(e.code == "wrong-password"){
        errorMsg = "Wrong password provider for that user.";
      }
    }
  }

  //TODO: add logout
  void logout() async{
    await auth.signOut();
    notifyListeners();
  }

}