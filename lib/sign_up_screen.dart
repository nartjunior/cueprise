import 'dart:async';

import 'package:cueprise/main.dart';
import 'package:cueprise/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late FormProvider _formProvider;
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
    _formProvider = Provider.of<FormProvider>(context);
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
              TextFormField(
                  onChanged: _formProvider.validateEmail,
                  decoration: InputDecoration(
                    errorText: _formProvider.email.error,
                    errorMaxLines: 3,
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'johndoe@gmail.com',
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                    ),
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
              TextFormField(
                  onChanged: _formProvider.validateName,
                  decoration: InputDecoration(
                    errorText: _formProvider.name.error,
                    errorMaxLines: 3,
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
              TextFormField(
                  onChanged: _formProvider.validatePhone,
                  decoration: InputDecoration(
                    errorText: _formProvider.phone.error,
                    errorMaxLines: 3,
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
              TextFormField(
                onChanged: _formProvider.validatePassword,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscured,
                focusNode: textFieldFocusNode,
                decoration: InputDecoration(
                  errorText: _formProvider.password.error,
                  errorMaxLines: 3,
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
              Consumer<FormProvider>(builder: (context, model, child) {
                return Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (model.validate) {
                        showLoaderDialog(context);
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => WelcomeScreen(),
                            ),
                          );
                        });
                      } else {
                        Widget okButton = TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: const Text("Register"),
                          content: const Text("You have to fill all the fiels properly."),
                          actions: [
                            okButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text('Register'),
                  ),
                );
              }),
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
                  ),
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
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.ac_unit),
          SizedBox(width: 5), // give it width
          Text('cueprise')
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(MyApp.themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              var isDark = MyApp.themeNotifier.value == ThemeMode.dark;
              if (isDark) {
                MyApp.themeNotifier.value = ThemeMode.light;
                prefs?.setBool('isDark', false);
              } else {
                MyApp.themeNotifier.value = ThemeMode.dark;
                prefs?.setBool('isDark', true);
              }
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
