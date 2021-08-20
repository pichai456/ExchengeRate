import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MoneyBox extends StatelessWidget {
  // const MoneyBox({Key? key}) : super(key: key);
  String _title;
  double _amount;
  Color _color;
  double _size;

  MoneyBox(this._title, this._amount, this._color, this._size);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        height: _size,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: new BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey, blurRadius: 10, offset: Offset(0, 10), spreadRadius: 3),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  _title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                NumberFormat('#,###.##').format(_amount),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ));
  }
}
