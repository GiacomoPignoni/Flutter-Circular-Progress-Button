import 'dart:async';
import 'package:flutter/material.dart';

typedef Future<Null> OnAnimationComplete();

class CircularProgressButton extends StatefulWidget {
  CircularProgressButton ({
    Key key, 
    @required this.text,
    this.color,
    this.textStyle,
    this.circularProgressIndicatorColor,
    this.width,
    @required this.onAnimationComplete
  }) : super (key: key);

  final String text;
  final Color color;
  final TextStyle textStyle;
  final Color circularProgressIndicatorColor;
  final double width;
  final OnAnimationComplete onAnimationComplete;

  _StateCircularProgressButton createState() => _StateCircularProgressButton();
}

class _StateCircularProgressButton extends State<CircularProgressButton> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );
    _animationController.addListener((){
		  setState((){});

      if(_animationController.isCompleted) {
        widget.onAnimationComplete().then((dynamic) {
          _animationController.reverse();
        });
      }    
	  });
  }

  @override
  build(BuildContext context) {
    animation = Tween(begin: (widget.width != null) ? widget.width : 300.0, end: 50.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease
      )
    );

    return GestureDetector(
      child: Container(
        constraints: BoxConstraints.loose(Size((widget.width != null) ? widget.width : 300.0, 50.0)),
        width: animation.value,
        decoration: BoxDecoration(
          color: (widget.color != null) ? widget.color : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25.0)
        ),
        child: Center( 
          child: (animation.value > 65) 
          ? Text(
            widget.text,
            style: (widget.textStyle != null) ? widget.textStyle : Theme.of(context).textTheme.button
          )
          : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(
            (widget.circularProgressIndicatorColor != null)
            ? widget.circularProgressIndicatorColor
            : Colors.white
          ))
        )
      ),
      onTap: () => _animationController.forward(),
    );
  }
}