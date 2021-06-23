import 'package:flutter/material.dart';
import 'package:kanban_board/app_style/app_style.dart';

class CustomButton extends StatelessWidget {
  final Function () onTap;
  final String title;

  const CustomButton({Key? key, required this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppStyle().mainColor),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          splashColor: Colors.black54,
          onTap: onTap,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.all(14),
            child: Text(title, style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
