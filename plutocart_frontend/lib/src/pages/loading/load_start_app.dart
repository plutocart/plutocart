import 'package:flutter/material.dart';

class LoadStartApp extends StatefulWidget {
  const LoadStartApp({Key? key}) : super(key: key);

  @override
  _LoadStartAppState createState() => _LoadStartAppState();
}

class _LoadStartAppState extends State<LoadStartApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageAnimation;
  late Animation<double> _firstContainerAnimation;
  late Animation<double> _secondContainerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _firstContainerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.25, 0.75, curve: Curves.easeInOut),
      ),
    );

    _secondContainerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _startAnimation();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _firstContainerAnimation.value,
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: ShapeDecoration(
                            color: Color(0xFF15616D),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.only(bottomRight: Radius.elliptical(186, 187)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Opacity(
                      opacity: _imageAnimation.value,
                      child: Image(
                        image: AssetImage('assets/icon/logo_loading_icon.png'),
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ),
                    Opacity(
                      opacity: _secondContainerAnimation.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.2914,
                            decoration: ShapeDecoration(
                              color: Color(0xFF15616D),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.elliptical(600, 600)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
