import 'package:flutter/material.dart';

class utility {
  static void openCustomDialog(context,int i) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          contentPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4D4D4D),
                width: 1,
              ),
              color: Colors.black
            ),
            child:Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5),
                  (i==2)?const Text(
                    '🥳Good Game Bruv🥳',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ):const RotatedBox(quarterTurns: 2,child: Text(
                            '🥳Good Game Bruv🥳',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          )),
                ],
              ),
            ),
          ),
        );
      },
    );
    
  }
  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
