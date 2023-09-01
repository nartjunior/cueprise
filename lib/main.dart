import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<MyApp> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cueprise',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: buildBackButton(context),
          toolbarHeight: 80,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.ac_unit),
              SizedBox(width: 5), // give it width
              Text('cueprise')
            ],
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(20),
    child: new SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
            child: Text(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              'Account Sing-up',
            ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                style: TextStyle(
                  fontSize: 18,
                ),
                'Become a member and enjoy Cueprise services and benefits',
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 15),
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                'Email Adress',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color.fromARGB(255, 240, 244, 247),
                hintText: 'johndoe@gmail.com',
                hintStyle: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 141, 144, 151) ),
              ),
                textInputAction: TextInputAction.next
            ),
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 15),
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                'Full Name',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color.fromARGB(255, 240, 244, 247),
                hintText: 'John Smith',
                hintStyle: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 141, 144, 151) ),
              ),
                textInputAction: TextInputAction.next
            ),
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 15),
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                'Phone number',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color.fromARGB(255, 240, 244, 247),
                hintText: 'e.g. 080556688899',
                hintStyle: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 141, 144, 151) ),
              ),
                textInputAction: TextInputAction.next
            ),
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 15),
              child: Text(
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
          floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
          hintText: "**********",
        filled: true,
        fillColor: Color.fromARGB(255, 240, 244, 247),
      isDense: true,  // Reduces height a bit
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
        color: Color.fromARGB(255, 141, 144, 151)    ),
    ),
    ),
    ),
    ),
            Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 25, bottom: 10),
    child: ElevatedButton(
    child: const Text('Register'),
    onPressed: () {
    },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),

      ),
    ),

    ),

            Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            fit:BoxFit.cover
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text("Sign up with Google",),
                        ) ],
                    ),
                    onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(
                        width: 2,
                        color: Colors.deepPurple,
                      )),
                ),
            ),
            Row(
              children: <Widget>[
                const Text('Already have an account?',
                style: TextStyle(fontSize: 16),),
                TextButton(
                  child: const Text(
                    'Sign in here',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),


    ],
          ),
      ),
      ),
      ),
    );
  }

  ElevatedButton buildBackButton(BuildContext context) {
    return ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_circle_left, size: 40,),
          label: Text(''),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        );
  }
}


