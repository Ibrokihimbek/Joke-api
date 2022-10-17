import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/models/jokes_list_model.dart';
import 'package:news/models/jokes_model.dart';
import 'package:http/http.dart' as http;

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Future<Jokes?> getData() async {
    String url = "https://v2.jokeapi.dev/joke/Any?amount=50&safe-mode";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      return Jokes.fromjson(json);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Jokes?>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<Jokes?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                Jokes? jokes = snapshot.data;
                return JokesWidget(jokes?.jockesList);
              }
            }
            return Container(
              child: const Center(
                child: Text(
                  "Nimdir xatolik bor",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  PageController pageController = PageController();

  Widget JokesWidget(List<JockesList>? jokesList) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            getData();
          });
        },
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.97,
                  width: double.infinity,
                  child: Image.network(
                    "https://w0.peakpx.com/wallpaper/1013/378/HD-wallpaper-adventure-time-adventure-time-cartoon-face-funny-happy-toon.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.97,
                  color: Colors.black.withOpacity(0.4),
                  width: double.infinity,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "ID: ${jokesList?[index].id ?? 'No'}",
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Category: ${jokesList?[index].category ?? 'No'}",
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Divider(
                        thickness: 2,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        jokesList?[index].setup ?? "No",
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        jokesList?[index].delivery ?? "No",
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        jokesList?[index].joke ?? "No",
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
