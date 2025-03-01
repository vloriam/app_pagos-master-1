import 'package:flutter/material.dart';
import 'auth_google.dart';
import 'model/firebase_user.dart';

class HomeGoogleSignIn extends StatefulWidget {
  const HomeGoogleSignIn({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<HomeGoogleSignIn> {
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();

  @override
  void initState() {
    super.initState();
    _user.user(_auth.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: Center(
        child: _user.uid != null ? _logged() : _login(),
      ),
    );
  }

  ElevatedButton _login() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.login),
      label: const Text('Log in'),
      onPressed: () async {
        await _auth.signInGoogle();
        setState(() {
          _user.user(_auth.user);
        });
      },
    );
  }

  Column _logged() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(_user.imageUrl!),
        ),
        Text(_user.name!),
        Text(_user.email!),
        ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text('Log out'),
          onPressed: () async {
            await _auth.signOutGoogle();
            setState(() {
              _user.user(_auth.user);
            });
          },
        ),
      ],
    );
  }
}