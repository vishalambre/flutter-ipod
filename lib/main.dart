import 'package:flutter/material.dart';
import 'package:flutter_ipod/Card.dart';

const imageArray = [
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/1.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/2.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/3.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/4.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/5.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/6.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/7.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/8.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/9.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/10.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/11.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/12.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/13.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/14.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/15.png",
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/model/16.png",
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: SafeArea(
          child: Ipod(),
        ),
      ),
    );
  }
}

class Ipod extends StatefulWidget {
  @override
  _IpodState createState() => _IpodState();
}

class _IpodState extends State<Ipod> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0.0;
  static const double RADIUS = 150.0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
      });
    });
  }

  void _panHandler(DragUpdateDetails details) {
    bool isRight = details.localPosition.dx > RADIUS;
    bool isLeft = !isRight;
    bool isUp = details.localPosition.dy < RADIUS;
    bool isDown = !isUp;

    bool isPanUp = details.delta.dy < 0.0;
    bool isPanLeft = details.delta.dx < 0.0;
    bool isPanDown = !isPanUp;
    bool isPanRight = !isPanLeft;

    double vScrollOffset = (isRight && isPanDown) || (isLeft && isPanUp)
        ? details.delta.distance
        : details.delta.distance * -1;

    double hScrollOffset = (isUp && isPanRight) || (isDown && isPanLeft)
        ? details.delta.distance
        : details.delta.distance * -1;

    _pageController.jumpTo(_pageController.offset +
        (vScrollOffset + hScrollOffset) * (details.delta.distance * 0.2));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageArray.length,
            itemBuilder: (context, index) {
              return AlbumCard(_currentPage, index);
            },
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onPanUpdate: _panHandler,
              child: Container(
                width: RADIUS * 2,
                height: RADIUS * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: Colors.black,
                ),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 200));
                      },
                      child: Container(
                        padding: EdgeInsets.all(32),
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.fast_forward,
                          size: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pageController.previousPage(
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 200));
                      },
                      child: Container(
                        padding: EdgeInsets.all(32),
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.fast_rewind,
                          size: 40,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(32),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Menu",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(32),
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                        Icons.play_arrow,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
