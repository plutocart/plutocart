import 'package:flutter/material.dart';

class FilterGraph extends StatefulWidget {
  const FilterGraph({Key? key}) : super(key: key);

  @override
  _FilterGraphState createState() => _FilterGraphState();
}

class _FilterGraphState extends State<FilterGraph> {
  List<Color>? sectionList;
  List<Color>? textColorList;
  @override
  void initState() {
    textColorList = [Colors.white, Color(0xFF15616D)];
    sectionList = [Color(0xFF15616D), Colors.white];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.5, color: Color(0XFF15616D)),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.44,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    animationDuration: Duration.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: sectionList![0] == Color(0xFF15616D)
                          ? BorderRadius.circular(20.0)
                          : BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                    ),
                    backgroundColor: sectionList![0],
                  ),
                  onPressed: () {
                    setState(() {
                      sectionList = [
                        Color(0xFF15616D),
                        Colors.white,
                      ];
                      textColorList = [
                        Colors.white,
                        Color(0xFF15616D),
                      ];
                    });
                  },
                  child: Text(
                    "income",
                    style: TextStyle(
                        color: textColorList![0],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.451,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    animationDuration: Duration.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: sectionList![1] == Color(0xFF15616D)
                          ? BorderRadius.circular(20.0)
                          : BorderRadius.circular(20.0),
                    ),
                    backgroundColor: sectionList![1],
                  ),
                  onPressed: () {
                    setState(() {
                      sectionList = [
                        Colors.white,
                        Color(0xFF15616D),
                      ];
                      textColorList = [
                        Color(0xFF15616D),
                        Colors.white,
                      ];
                    });
                  },
                  child: Text(
                    "Expense",
                    style: TextStyle(
                        color: textColorList![1],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  )),
            ),
          ])),
    );
  }
}
