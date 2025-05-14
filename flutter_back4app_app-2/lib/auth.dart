
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'home.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  String _error = '';

  void _login() async {
    final user = ParseUser(_username.text.trim(), _password.text.trim(), null);
    var response = await user.login();

    if (response.success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      setState(() => _error = response.error?.message ?? 'Login failed');
    }
  }

  void _signup() async {
    final user = ParseUser(_username.text.trim(), _password.text.trim(), null);
    var response = await user.signUp();

    if (response.success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      setState(() => _error = response.error?.message ?? 'Signup failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login / Signup')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: _username, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: _password, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _login, child: Text('Login')),
            ElevatedButton(onPressed: _signup, child: Text('Sign Up')),
            if (_error.isNotEmpty) Text(_error, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
