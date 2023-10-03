import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late bool _isPressed;
  late Widget _animatedModalBarrier;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _isPressed = false;

    ColorTween _colorTween = ColorTween(
      begin: Colors.orangeAccent.withOpacity(0.5),
      end: Colors.blueGrey.withOpacity(0.5),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _colorAnimation = _colorTween.animate(_animationController);

    _animatedModalBarrier = AnimatedModalBarrier(
      color: _colorAnimation,
      dismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Modal Barrier Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  width: 250.0,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                        ),
                        child: const Text("Click"),
                        onPressed: () {
                          setState(() {
                            _isPressed = true;
                          });
                          _animationController.reset();
                          _animationController.forward();
                          Future.delayed(const Duration(seconds: 3), () {
                            setState(() {
                              _isPressed = false;
                            });
                          });
                        },
                      ),
                      if (_isPressed) _animatedModalBarrier,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
