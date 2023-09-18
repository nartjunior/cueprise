import 'dart:async';
import 'package:cueprise/persistence.dart';
import 'package:cueprise/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'number_text_input_formatter.dart';
import 'form_provider.dart';
import 'package:cueprise/app_text_field.dart';
import 'model/user.dart';
import 'my_app_bar.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late FormProvider _formProvider;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  late bool isMyButtonEnabled;
  final _mobileFormatter = NumberTextInputFormatter();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: const MyAppBar(),
          body: buildForm(context),
        );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
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

  Route _createRoute() {
    return PageRouteBuilder<SlideTransition>(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween<Offset>(begin: const Offset(0.5, 1.0), end: Offset.zero);
        var curveTween = CurveTween(curve: Curves.fastOutSlowIn);

        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: child,
        );
      },
    );
  }

  Widget buildForm(BuildContext context) {
    _formProvider = Provider.of<FormProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              'Account Sing-up',
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
            AppTextField(
              errorText: _formProvider.email.error,
              onChanged: _formProvider.validateEmail,
              hintText: 'johndoe@gmail.com',
              title: 'Email Address',
              nextAction: TextInputAction.next,
            ),
            AppTextField(
              onChanged: _formProvider.validateName,
              errorText: _formProvider.name.error,
              hintText: 'John Smith',
              title: 'Full Name',
              nextAction: TextInputAction.next,
            ),
            AppTextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                _mobileFormatter,
              ],
              keyboardType: TextInputType.phone,
              errorText: _formProvider.phone.error,
              onChanged: _formProvider.validatePhone,
              hintText: '033732838383',
              title: "Phone Number",
              nextAction: TextInputAction.next,
            ),
            AppTextField(
              errorText: _formProvider.password.error,
              onChanged: _formProvider.validatePassword,
              toggleObscured: _toggleObscured,
              obscureText: _obscured,
              keyboardType: TextInputType.visiblePassword,
              hintText: '**********',
              title: 'Password',
              nextAction: TextInputAction.done,
              suffixIcon2: _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
            ),
            Consumer<FormProvider>(builder: (context, model, child) {
              return Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Persistence.saveUser(User(
                      email: _formProvider.email.value.toString(),
                      name: _formProvider.name.value.toString(),
                      phoneNumber: _formProvider.phone.value.toString(),
                    ));
                    if (model.validate) {
                      showLoaderDialog(context);
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context, rootNavigator: true).pop();
                        Navigator.of(context).push<void>(_createRoute());
                      });
                    } else {
                      Widget okButton = TextButton(
                        child: const Text("OK"),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Theme.of(context).colorScheme.onBackground,
                    side: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network('http://pngimg.com/uploads/google/google_PNG19635.png', fit: BoxFit.cover),
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
                    style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary),
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
    );
  }
}
