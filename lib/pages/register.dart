import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isloading = false;

  Future<void> registerUser() async {
    setState(() {
      isloading = true;
    });

    Map<String, dynamic> dataUser = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "age": ageController.text,
      "email": emailController.text,
    };

    var uri = Uri.parse("https://dummyjson.com/users/add");
    try {
      var respon = await http.post(uri, body: jsonEncode(dataUser),
        headers: {"Content-Type": "application/json"},
      );

      if (respon.statusCode == 200 || respon.statusCode == 201) {
        var data = jsonDecode(respon.body);

        // Tampilkan snackBar sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Berhasil daftar : ${data['firstName']}")),
        );

        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacementNamed(context, "/todolist");
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Register gagal!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 18,
          children: [
            Text(
              "REGISTER",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isloading ? null : registerUser,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: isloading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
