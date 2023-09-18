import 'dart:convert';

import 'package:cueprise/model/meme_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_animate/flutter_animate.dart';
import 'profile_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> with TickerProviderStateMixin {
  List<MemeModel> memes = [];
  var index = 0;
  late AnimationController _titleAnimController;
  late AnimationController _memeAnimController;

  @override
  void initState() {
    super.initState();
    _titleAnimController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _memeAnimController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    fetchMemes().then((data) => {
          setState(() {
            memes = data;
          })
        });
  }

  Future<List<MemeModel>> fetchMemes() async {
    var url = await http.get(Uri.parse("https://api.imgflip.com/get_memes"));
    if (url.statusCode == 200) {
      final fetchedItems = json.decode(url.body);
      List<MemeModel> memes = [];
      for (var memeItem in fetchedItems['data']['memes']) {
        MemeModel item = MemeModel.fromJson(memeItem);
        memes.add(item);
      }
      return memes;
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    _titleAnimController.forward(from: 0);
    _memeAnimController.forward(from: 0);
    if (memes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("MEMES"), actions: [
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          child: const Icon(Icons.person),
        ),
      ]),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            memes[index].name,
            style: Theme.of(context).textTheme.titleLarge,
          ).animate(controller: _titleAnimController).slideY(begin: -10, duration: const Duration(milliseconds: 600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Image.network(memes[index].url, height: 200),
              ).animate(controller: _memeAnimController).fadeIn().flip(duration: const Duration(milliseconds: 500)),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          if (index == 0) {
                            Widget okButton = TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            );
                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              content: const Text("You can't go lower."),
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
                          } else {
                            index--;
                          }
                          setState(() {});
                        },
                        child: const SizedBox(
                          width: 120,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                // <-- Icon
                                Icons.arrow_back,
                                size: 24.0,
                              ),
                              Text('Previous'), // <-- Text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          index++;
                          setState(() {});
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Next'),
                            Icon(
                              Icons.arrow_forward,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
