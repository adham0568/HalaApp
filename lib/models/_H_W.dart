
import 'package:flutter/material.dart';

class SizeFix{
  double W({required BuildContext context}){
    return  MediaQuery.of(context).size.width;
  }

  double H({required BuildContext context}){
    return  MediaQuery.of(context).size.height;
  }
}