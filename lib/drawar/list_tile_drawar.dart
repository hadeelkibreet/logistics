import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileDrawar extends StatefulWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;

  const ListTileDrawar(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  State<ListTileDrawar> createState() => _ListTileDrawarState();
}

class _ListTileDrawarState extends State<ListTileDrawar> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: widget.icon,
        title: Text(
          widget.text,
          style: TextStyle(fontSize: 18.sp),
          textAlign: TextAlign.start,
        ),
        onTap: widget.onPressed);
  }
}
