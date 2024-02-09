

import 'dart:convert';

import 'package:crud_application_flutter/app_constant/app_theme.dart';
import 'package:crud_application_flutter/crud_app_page.dart';
import 'package:crud_application_flutter/user/login_page.dart';
import 'package:crud_application_flutter/user/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class CrudPage extends StatefulWidget {
  final  String userId;

  const CrudPage({
    required this.userId, 
    Key? key}) : super(key: key);

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {

  final _formfield = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  //final passwordController = TextEditingController();
  final phoneNumberController=TextEditingController();
 
  bool passToggle = true;


 FocusNode emailFiled=FocusNode();
  FocusNode userNameFiled=FocusNode();
  //FocusNode passwordField=FocusNode();
  FocusNode phoneNumberField=FocusNode();

//[A]-----API Function For Fetch Data
 
  Future<void> fetchUserDetails() async {
    final url = Uri.parse('http://localhost:9000/user/getOneUserDetails/${widget.userId}');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Parse the response data
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Update form fields with the retrieved data
        setState(() {
          userNameController.text = responseData['data']['userName'];
          emailController.text = responseData['data']['email'];
          //passwordController.text = responseData['data']['password'];
          // Update other controllers as needed
        });
      } else {
        print('API call failed with status code: ${response.statusCode}');
        // Handle error
      }
    } catch (error) {
      print('Error during API call: $error');
      // Handle error
    }
  }
//[B]-----API Function For Add PhoneNumber

Future<void> addPhoneNumber() async {
    final url = Uri.parse('http://localhost:9000/user/add/${widget.userId}');
    final Map<String, dynamic> requestBody = {
        'phoneNumber': phoneNumberController.text,
    };

    try {
        final response = await http.put(
            url,
            body: jsonEncode(requestBody),
            headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
            print('API call successful. Phone number added successfully.');
            // Handle success
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
  void initState() {
    super.initState();
    // Fetch user details when the widget is first created
    fetchUserDetails();
  }

  //[C]-----API Function For Fetch Data
 
  Future<void> fetchUserPhoneNumberDetails() async {
    final url = Uri.parse('http://localhost:9000/user/getOneUserDetails/${widget.userId}');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Parse the response data
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Update form fields with the retrieved data
        setState(() {
         // userNameController.text = responseData['data']['userName'];
          //emailController.text = responseData['data']['email'];
          phoneNumberController.text = responseData['data']['phoneNumber'];
          // Update other controllers as needed
        });
      } else {
        print('API call failed with status code: ${response.statusCode}');
        // Handle error
      }
    } catch (error) {
      print('Error during API call: $error');
      // Handle error
    }
  }
  //[D]-----API Function For Update All User Details

Future<void> updateAllUserDetails() async {
    final url = Uri.parse('http://localhost:9000/user/update/${widget.userId}');
    final Map<String, dynamic> requestBody = {
      'userName': userNameController.text,
      'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
    };

    try {
        final response = await http.put(
            url,
            body: jsonEncode(requestBody),
            headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
            print('API call successful. updated all user details successfully.');
            // Handle success
        } else {
            print('API call failed with status code: ${response.statusCode}');
            // Handle error
        }
    } catch (error) {
        print('Error during API call: $error');
        // Handle error
    }
}
//[E]-----API Function For Delete One User Details
Future<void> deleteOneUserDetails() async {
    final url = Uri.parse('http://localhost:9000/user/deleteUserDetails/${widget.userId}');

    try {
        final response = await http.delete(
            url,
            headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 201) {
            print('API call successful. User deleted successfully.');
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
            // Handle success
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
                      "CRUD Application",
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
                            FocusScope.of(context).requestFocus(phoneNumberField);
                          },          
                  ),
                  SizedBox(height: 25,),
                  /*TextFormField(
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
                     onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(phoneNumberField);
                          },          
                  ),
                */
                   SizedBox(height: 25,),
                  TextFormField(
                    focusNode:phoneNumberField,
                    keyboardType: TextInputType.visiblePassword,
                    controller: phoneNumberController,
                    obscureText: passToggle,
                    decoration: InputDecoration(
                      labelText: "PhoneNumber",
                      hintText: "Enter your phone number",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.android_outlined, color: Colors.black,),
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
                        return "Enter Phone Number";
                      }
                      /*else{
                        if(value.length==10 ){
                          return "PhoneNumber Should be of 10 digit";
                        }
                      }*/
                      return null;
                    },
                  ),
                  SizedBox(height: 50,),
                  InkWell(
                    onTap: () async {
                      if (_formfield.currentState!.validate()) {
                        // Call the loginUser function to make the API call for login
                        //await loginUser();

                        // Clear controllers after successful login
                      //  emailController.clear();
                        //userNameController.clear();
                       // passwordController.clear();

                        // ... clear other controllers
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: GestureDetector(
                          
                           // loginUser();
                            // You can add logic here to navigate to the next screen after successful login
                            onTap: () async {
                     if (_formfield.currentState!.validate()) {
                     // Call the addPhoneNumber function to make the API call for adding phone number
                    await addPhoneNumber();

                   // Clear controllers after successful addition
                       // phoneNumberController.clear();
                       }

                          },
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                           fetchUserPhoneNumberDetails();
                            // You can add logic here to navigate to the next screen after successful login
                          },
                          child: Text(
                            "Read",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                   // SizedBox(width: 30,),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                           updateAllUserDetails();
                            // You can add logic here to navigate to the next screen after successful login
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                   // SizedBox(width: 30,),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                           deleteOneUserDetails();

                     // Clear controllers after successful deletion
                         emailController.clear();
                         userNameController.clear();
                        phoneNumberController.clear();
                            // You can add logic here to navigate to the next screen after successful login
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                      ],
                    )
                  ),
                ]  
              ),
            ),
          ),
        ),
      ),
    );
  }
}
