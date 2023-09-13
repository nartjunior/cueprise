import 'dart:convert';

import 'package:cueprise/model/meme_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  List<MemeModel> memes = [];
  var index = 0;

  @override
  void initState() {
    super.initState();
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
    if (memes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("MEMES"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            memes[index].name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Center(
            child: Image.network(memes[index].url),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    index++;
                    setState(() {});
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  splashColor: Colors.teal.withOpacity(0.3),
                  label: const Text("Next"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
