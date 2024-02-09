import 'package:crud_application_flutter/crud_app_page.dart';
import 'package:crud_application_flutter/user/login_page.dart';
import 'package:crud_application_flutter/user/signup_page.dart';
import 'package:crud_application_flutter/user_table.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     //home: SignUpPage(),
      //home:CrudPage(),
      home: UserListPage()
    );
  }
}