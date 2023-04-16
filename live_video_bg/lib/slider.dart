import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

class SliderCarousel extends StatefulWidget {
  const SliderCarousel({super.key});

  @override
  State<SliderCarousel> createState() => _SliderCarouselState();
}

class _SliderCarouselState extends State<SliderCarousel> {
  late PageController _pageController;
  int activePage = 1;

  List<String> images = [
    'assets/p1.jpg',
    'assets/p2.jpg',
    'assets/p3.jpg',
    'assets/p4.jpg',
  ];

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    super.initState();
  }

  AnimatedContainer slider(images, pagePosition, active, align) {
    log('PageP: $pagePosition \n ActiveNum: $activePage \n active: $active');
    double margin = active ? 10 : 20;

    return AnimatedContainer(
      alignment: align,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      // padding: const EdgeInsets.all(2),
      // margin: EdgeInsets.all(margin),
      child: Container(
        color: Colors.red,
        height: 300,
        width: 300,
        child: Image.asset(
          images[pagePosition],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.amber,
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              pageSnapping: true,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                log('Calling before');
                Alignment align = pagePosition > activePage
                    ? const Alignment(-6.0, 0.0)
                    : pagePosition < activePage
                        ? const Alignment(6.0, 0.0)
                        : const Alignment(0.0, 0.5);
                log('Calling after--> $align');

                return slider(images, pagePosition, active, align);
              }),
        ),
      ),
    );
  }
}
