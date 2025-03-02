import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        message: message,
        padding: EdgeInsets.all(15),
        positionOffset: 20,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 80),
        borderRadius: BorderRadius.circular(12),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        reverseAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        flushbarPosition: FlushbarPosition.TOP,
        isDismissible: true,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
  }

  static void changeFocusNode(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static double avgRatingCalculate(List<int> ratings){
    var sum = 0;
    for(int i=0;i<ratings.length;i++){
      sum += ratings[i];
    }
    return double.parse((sum/ratings.length).toStringAsFixed(1));
  }

}