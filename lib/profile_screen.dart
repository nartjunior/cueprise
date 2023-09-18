import 'package:cueprise/persistence.dart';
import 'package:cueprise/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = Persistence.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user?.email}'),
            Text('Name: ${user?.name}'),
            Text('Phone: ${user?.phoneNumber}'),
            ElevatedButton(
              onPressed: () {
                Persistence.deleteUser();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
