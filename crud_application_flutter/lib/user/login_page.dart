

import 'dart:convert';

import 'package:crud_application_flutter/app_constant/app_theme.dart';
import 'package:crud_application_flutter/crud_app_page.dart';
import 'package:crud_application_flutter/user/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formfield = GlobalKey<FormState>();
  
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 
  bool passToggle = true;


 FocusNode emailFiled=FocusNode();
  FocusNode userNameFiled=FocusNode();
  FocusNode passwordField=FocusNode();

  // Function to make the API call for login
  Future<void> loginUser() async {
    final url = Uri.parse('http://localhost:9000/user/login');

    // Prepare your request body data
    final Map<String, dynamic> requestBody = {
      
       'userName': userNameController.text,
      'email': emailController.text,
      'mpin': passwordController.text,
     
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 201) {
        print('API call successful. User logged in successfully.');
        // Handle success
              
   
final userData=jsonDecode(response.body);
final id=userData['data']['_id'];
print('UserData:$id');
print(response.body);

        // You can add logic here to navigate to the next screen after successful login
         Navigator.push(context, MaterialPageRoute(builder: (context) =>CrudPage(userId: id,)));
      
      } else {
        print('API call failed with status code: ${response.statusCode}');
        // Handle error
      }
    } catch (error) {
      print('Error during API call: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formfield,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ),
                  
                  SizedBox(height: 25,),
                  CircleAvatar(
                    radius: 50,
                    
                  ),
                 
                  SizedBox(height: 25,),
                  TextFormField(
                    focusNode: userNameFiled,
                    keyboardType: TextInputType.text,
                      controller: userNameController,
                    decoration: InputDecoration(
                      labelText: "User Name",
                      hintText: "Enter user name",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_2_outlined, color: Colors.black,),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter user name";
                      }
                     
                     
                      return null;
                    },
                    onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailFiled);
                          },          
                    
                  ),
                   SizedBox(height: 25,),
                  TextFormField(
                    focusNode: emailFiled,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.black,),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                          return "Enter a valid email address";
                      }
                    },
                    onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passwordField);
                          },          
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    focusNode: passwordField,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    obscureText: passToggle,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black,),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      else{
                        if(value.length<6 || value.length>8){
                          return "Password Should be between 6 to 9 characters";
                        }
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () async {
                      if (_formfield.currentState!.validate()) {
                        // Call the loginUser function to make the API call for login
                        await loginUser();

                        // Clear controllers after successful login
                        emailController.clear();
                        userNameController.clear();
                        passwordController.clear();

                        // ... clear other controllers
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>CrudPage()));
                            loginUser();
                            // You can add logic here to navigate to the next screen after successful login
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUpPage(),));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
