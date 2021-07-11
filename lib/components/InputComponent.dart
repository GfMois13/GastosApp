import 'package:flutter/material.dart';
import 'package:gastos/styles/Styles.dart';

class UIinputText extends StatefulWidget {
  final String? text;
  final String title;
  final IconData icon;
  final TextEditingController? controller;
  final bool? isPassword;

  const UIinputText(
      {Key? key,
      required this.text,
      required this.title,
      required this.icon,
      this.controller,
      this.isPassword})
      : super(key: key);

  @override
  _UIinputTextState createState() => _UIinputTextState();
}

class _UIinputTextState extends State<UIinputText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: inputTitleStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF6CA8F1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            obscureText: widget.isPassword ?? false,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                widget.icon,
                color: Colors.white,
              ),
              hintText: widget.text,
              hintStyle: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
