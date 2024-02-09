
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String id;
  final String userName;
  final String displayName;
  final String password;

  User({
    required this.id,
    required this.userName,
    required this.displayName,
    required this.password,
  });
}

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User>? users; // Make users nullable to handle initial null state

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  /*Future<void> fetchUserDetails() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:9000/userTable/getAllUserData'));
      if (response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          users = data.map((userJson) => User(
            id: userJson['data']['userDetailsList']['id'],
            userName: userJson['data']['userDetailsList']['userName'],
            displayName: userJson['data']['userDetailsList']['displayName'],
            password: userJson['data']['userDetailsList']['password'],
          )).toList();
        });
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      // Handle the error gracefully (e.g., show an error message to the user)
    }
  }
*/
Future<void> fetchUserDetails() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:9000/userTable/getAllUserData'));
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> userDetailsList = responseData['data']['userDetailsList'];
      setState(() {
        users = userDetailsList.map((userJson) => User(
          id: userJson['id'],
          userName: userJson['userName'],
          displayName: userJson['displayName'],
          password: userJson['password'],
        )).toList();
      });
    } else {
      throw Exception('Failed to load user details');
    }
  } catch (e) {
    print('Error fetching user details: $e');
    // Handle the error gracefully (e.g., show an error message to the user)
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child: Text('User Details')),
      ),
      body: users == null
          ? Center(child: CircularProgressIndicator())
          : _buildUserTable(),
    );
  }

  Widget _buildUserTable() {
    return SingleChildScrollView(
     // scrollDirection: Axis.vertical,
      child:Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black45,
              width: 1.0
            )
          ),
          child: DataTable(
                  columns: [
            DataColumn(label: Text('ID')),
        DataColumn(label: Text('User Name')),
        DataColumn(label: Text('Display Name')),
        DataColumn(label: Text('Password')),
        DataColumn(label: Text('Actions')),
      ],
      rows: users!.map((user) => DataRow(cells: [
        DataCell(Text(user.id.toString())),
        DataCell(Text(user.userName)),
        DataCell(Text(user.displayName)),
        DataCell(Text(user.password)),
        DataCell(Row(
          children: [
            IconButton(
              color: Colors.yellow,
              icon: Icon(Icons.edit),
              onPressed: () {
                // Implement edit action
                // For example, you can navigate to an edit screen with user data
              },
            ),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () {
                // Implement delete action
                // For example, you can show a confirmation dialog and delete the user if confirmed
              },
            ),
          ],
        )),
      ])).toList(),
    ) ,
        ),
      ),
    );
  }
}
