import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:ulomobile_project/constants.dart';

class IntroPage extends StatefulWidget {
  final String image;
  final String title;
  final String content;
  const IntroPage({Key key, this.image, this.title, this.content})
      : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              fit: BoxFit.cover,
              image: AssetImage(widget.image))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'images/ulo_logo.png',
                width: 150,
              ),
            ),
          ),
          Spacer(),
          ShowUpAnimation(
            delayStart: Duration(seconds: 1),
            animationDuration: Duration(milliseconds: 500),
            direction: Direction.horizontal,
            offset: -0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
            ),
          ),
          ShowUpAnimation(
            delayStart: Duration(seconds: 1),
            animationDuration: Duration(seconds: 2),
            direction: Direction.horizontal,
            offset: -0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.content,
                textAlign: TextAlign.center,
                style: contentStyle,
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
