import 'package:cueprise/main.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: const Text(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  'Account Sing-up',
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: const Text(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  'Become a member and enjoy Cueprise services and benefits',
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: const Text(
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  'Email Adress',
                ),
              ),
              const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'johndoe@gmail.com',
                    hintStyle: TextStyle(
                        fontSize: 20.0,),
                  ),
                  textInputAction: TextInputAction.next),
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: const Text(
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  'Full Name',
                ),
              ),
              const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'John Smith',
                  ),
                  textInputAction: TextInputAction.next),
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: const Text(
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  'Phone number',
                ),
              ),
              const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'e.g. 080556688899',
                  ),
                  textInputAction: TextInputAction.next),
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: const Text(
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  'Password',
                ),
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscured,
                focusNode: textFieldFocusNode,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  hintText: "**********",
                  isDense: true,
                  // Reduces height a bit
                  border: InputBorder.none,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggleObscured,
                      child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
              buildRegisterButton(),
              Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Theme.of(context).colorScheme.background,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                          fit: BoxFit.cover),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 4.0),
                        child: Text(
                          "Sign up with Google",
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    child: Text(
                      'Sign in here',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 100,
      backgroundColor: Theme.of(context).primaryColor,
      leading: buildBackButton(context),
      toolbarHeight: 80,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.ac_unit),
          SizedBox(width: 5), // give it width
          Text('cueprise')
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            })
      ],
    );
  }

  ElevatedButton buildBackButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        Icons.arrow_circle_left,
        color: Colors.white,
        size: 40,
      ),
      label: const Text(''),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Container buildRegisterButton() {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Text(
          'Register',
        ),
      ),
    );
  }

}
