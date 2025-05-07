import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildDivider(){
  return  Column(
    children: [
      SizedBox(width: 10,),
      Text("|",style: TextStyle(color: Colors.grey),),
      SizedBox(width: 10,),
    ],
  );
}