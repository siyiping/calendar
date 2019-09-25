import 'package:flutter/material.dart';
import 'dart:async';

int kRealPage;
double kAutoMaxPage;
double kAutoMinPage;

int _calcIndex(int input, int source) {
  final int result = input % source;
  return result < 0 ? source + result : result;
}

int _getRealIndex(int position, int base, int length) {
  final int offset = position - base;
  return _calcIndex(offset, length);
}

typedef void UpdatePageCallback(int index);

class InfinitySlider extends StatefulWidget {
  final int initialPage;
  final List<Widget> items;
  final bool autoPlay;
  final Duration interval;
  final Curve transCurve;
  final Duration transDuration;
  final double height;
  final PageController pageController;
  final UpdatePageCallback updateCallback;

  InfinitySlider({
    Key key,
    this.height: 120,
    this.initialPage: 0,
    this.autoPlay: true,
    this.interval: const Duration(seconds: 2),
    this.transDuration: const Duration(milliseconds: 800),
    this.transCurve: Curves.fastOutSlowIn,
    this.updateCallback,
  })  : pageController = new PageController(
    initialPage: kRealPage + initialPage,
  ),
        items = [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amber,
                  child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
        super(key: key) {
    kRealPage = items.length;
    kAutoMinPage = 0.0;
    kAutoMaxPage = (items.length * 2).toDouble();
  }

  @override
  _InfinitySliderState createState() => _InfinitySliderState();

  Future<void> nextPage({Duration duration, Curve curve}) {
    return pageController.nextPage(duration: duration, curve: curve);
  }

  Future<void> previousPage({Duration duration, Curve curve}) {
    return pageController.previousPage(duration: duration, curve: curve);
  }
}

class _InfinitySliderState extends State<InfinitySlider> {
  int currentPage;
  Timer timer;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      if (widget.pageController.page == kAutoMinPage ||
          widget.pageController.page == kAutoMaxPage) {
        widget.pageController.position
            .setPixels(MediaQuery.of(context).size.width * kRealPage);
      }
    });
    currentPage = widget.initialPage;
    if (widget.autoPlay) {
      timer = new Timer.periodic(widget.interval, (_) {
        widget.nextPage(
            duration: widget.transDuration, curve: widget.transCurve);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: PageView.builder(
        itemBuilder: (BuildContext context, int i) {
          final int index = _getRealIndex(i, kRealPage, widget.items.length);
          return widget.items[index];
        },
        controller: widget.pageController,
        onPageChanged: (int index) {

        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}