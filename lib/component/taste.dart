import 'package:flutter/material.dart';

int kRealPage = 1000000000;
double kAutoMaxPage;
double kAutoMinPage;

class Taste extends StatefulWidget {

  final PageController pageController;
  final int initialPage;
  final List<Widget> items;
  final UpdatePageCallback updateCallback;

  Taste({
    Key key,
    this.initialPage: 0,
    this.updateCallback,}):
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
        pageController = new PageController(initialPage: kRealPage + initialPage),
        super(key: key) {
          kRealPage = items.length;
          kAutoMinPage = 0.0;
          kAutoMaxPage = (items.length * 2).toDouble();
        }

  @override
  _TasteState createState() => new _TasteState();
}

typedef void UpdatePageCallback(int index);

class _TasteState extends State<Taste> {

  int currentPage;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener((){
      if (widget.pageController.page == 0 ||
          widget.pageController.page == 6) {
        widget.pageController.position.setPixels(MediaQuery.of(context).size.width * kRealPage);
      }
    });
    currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: PageView.builder(
        itemCount: 1000000000000,
        itemBuilder: (BuildContext context, int i) {
          final int index = _getRealIndex(i, kRealPage, widget.items.length);
          return widget.items[index];
        },
        controller: widget.pageController,
        onPageChanged: (int index) {
          currentPage = _getRealIndex(index, kRealPage, widget.items.length);
          if (widget.updateCallback != null) widget.updateCallback(currentPage);
        },
      ),
    );
  }

  int _calcIndex(int input, int source) {
    final int result = input % source;
    return result < 0 ? source + result : result;
  }

  int _getRealIndex(int position, int base, int length) {
    final int offset = position - base;
    return _calcIndex(offset, length);
  }
}