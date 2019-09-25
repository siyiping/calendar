import 'package:flutter/material.dart';

const int kRealPage = 100000000000000000;
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

class MonthContainer extends StatefulWidget {

  final List<Widget> items;
  final int initialPage;
  final double height;
  final PageUpdateCallBack pageUpdateCallBack;
  final PageController pageController;

  MonthContainer({
      Key key,
      this.initialPage:0,
      this.height,
      this.pageUpdateCallBack,
      }):pageController = new PageController(
        initialPage: initialPage + kRealPage,
      ),
        items = [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
        super(key: key) {
          kAutoMinPage = 0.0;
          kAutoMaxPage = (items.length * 2).toDouble();
        }

  @override
  _MonthContainerState createState() => new _MonthContainerState();
}

typedef void PageUpdateCallBack(int index);

class _MonthContainerState extends State<MonthContainer> {

  int currentPage;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener((){
      if (widget.pageController.page == kAutoMinPage ||
          widget.pageController.page == kAutoMaxPage) {
          widget.pageController.position.setPixels(MediaQuery.of(context).size.width * kRealPage);
      }
    });
    currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 25,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text("一",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("二",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("三",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("四",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("五",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("六",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("日",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

       Container(
         color: Colors.white,
         margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 3),
         height: 200,
         child: PageView.builder(
           itemCount: kRealPage,
           itemBuilder: (context, int i) {
             final int index = _getRealIndex(i, kRealPage, widget.items.length);
             return widget.items[index];
           },
           onPageChanged: (int index){
             currentPage = _getRealIndex(index, kRealPage, widget.items.length);
             if (widget.pageUpdateCallBack != null) widget.pageUpdateCallBack(currentPage);
           },
           controller: widget.pageController,
         ),
       )
        ],
    );
  }
}