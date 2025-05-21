import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shose_store/service/userService/providers.dart';


class Login extends ConsumerStatefulWidget{
  const Login({super.key});

  @override
  ConsumerState createState() => _LoginState();
}
class _LoginState extends ConsumerState<Login>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //TODO: add build
  @override
  Widget build(BuildContext context) {
    final userDao = ref.watch(userDaoProvider);
    return Scaffold(

    );
  }
  
}