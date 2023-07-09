
import 'package:flutter/material.dart';

class TurnPage{

  static pushScreen(BuildContext context, Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }


}