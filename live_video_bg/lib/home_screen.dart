import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController controller;
  bool isPlaying = true;
  List<String> images = [
    'assets/p1.jpg',
    'assets/p2.jpg',
    'assets/p3.jpg',
    'assets/p4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/sv2.mp4')
      ..initialize().then((_) {
        controller.play();
        controller.setLooping(true);
        setState(() {});
      }).onError((error, stackTrace) {
        log("Error: $error");
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: SizedBox(
                width: mq.width,
                height: mq.height,
                child: VideoPlayer(controller),
              ),
            ),
            Positioned(
              left: mq.width * 0.03,
              top: mq.height * .01,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.triangle,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            Positioned(
              right: mq.width * 0.03,
              top: mq.height * .01,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.gift,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            Positioned(
              left: mq.width * 0.25,
              top: mq.height * .05,
              child: const Text(
                'Flutter Dev',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            Positioned(
              left: mq.width * 0.05,
              top: mq.height * .22,
              child: const Text(
                'Good Morning, Khan',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: mq.width,
                height: 400,
                decoration: const BoxDecoration(
                  color: Colors.amberAccent,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.amberAccent,
                        offset: Offset(0.0, -15.0),
                        blurRadius: 20.0,
                        spreadRadius: 25.0),
                  ],
                ),
              ),
            ),
            Positioned(
              top: mq.width * 0.56,
              child: SizedBox(
                width: mq.width,
                height: 350.0,
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 350,
                  ),
                  items: images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Container(
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              // margin:
                              //     const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  i,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const ListTile(
                              leading: CircleAvatar(
                                radius: 25.0,
                                child: Icon(
                                  CupertinoIcons.person,
                                  size: 30,
                                ),
                              ),
                              title: Text(
                                'The Glow Within',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text('Marcellus Sherpard'),
                            )
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          if (isPlaying) {
            controller.pause();
            isPlaying = false;
            setState(() {});
          } else {
            controller.play();

            isPlaying = true;
            setState(() {});
          }
        }),
      ),
    );
  }
}
