import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onButtonPress;
  final Color color, txtColor;
  final double btnWidth,border;
  

  const RoundedButton({
    Key key,
    this.text,
    this.onButtonPress,
    this.color = Colors.blue,
    this.txtColor = Colors.white, 
    this.btnWidth, 
    this.border = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: btnWidth, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border),
        child: TextButton(
            style: TextButton.styleFrom(
              primary: txtColor,
              backgroundColor: color,
              padding: EdgeInsets.all(15),
              textStyle: TextStyle(fontSize: 20),
            ),
            onPressed: onButtonPress,
            child: Text(
              text,
            )),
      ),
    );
  }
}
