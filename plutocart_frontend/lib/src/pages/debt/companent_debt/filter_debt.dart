import 'package:flutter/material.dart';

class FilterDebt extends StatefulWidget {
  const FilterDebt({Key? key}) : super(key: key);

  @override
  _FilterDebtState createState() => _FilterDebtState();
}
class _FilterDebtState extends State<FilterDebt> {

    List<Color>? sectionList ;
   List<Color>? textColorList ;

   @override
  void initState() {
        sectionList = [Colors.white  , Color(0xFF15616D) , Color(0xFF15616D) ];
        textColorList = [Color(0xFF15616D), Colors.white  , Colors.white ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
             color: Color(0xFF15616D),
          border: Border.all(width: 1.5, color: Color(0XFF15616D)),
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.2,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                   animationDuration: Duration.zero,
                  shape: RoundedRectangleBorder(
                   borderRadius: sectionList![0] == Colors.white ? BorderRadius.circular(20.0) : BorderRadius.only(topLeft: Radius.circular(20) , bottomLeft: Radius.circular(20)),
                  ),
                  backgroundColor: sectionList![0],
                ),
                onPressed: () {
                  setState(() {
                    sectionList = [Colors.white  , Color(0xFF15616D) , Color(0xFF15616D) ];
                  textColorList = [Color(0xFF15616D), Colors.white  , Colors.white ];
                  });
                },
                child: Text(
                  "All",
                  style: TextStyle(
                      color: textColorList![0],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                )),
          ),
          Container(
               height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                   animationDuration: Duration.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: sectionList![1] == Colors.white ? BorderRadius.circular(20.0) : BorderRadius.zero,
                  ),
                  backgroundColor: sectionList![1],
                ),
                onPressed: () {
                 setState(() {
                    sectionList = [Color(0xFF15616D)  , Colors.white , Color(0xFF15616D) ];
                  textColorList = [Colors.white ,  Color(0xFF15616D)  , Colors.white ];
                 });
                },
                child: Text(
                  "In progress",
                  style: TextStyle(
                       color: textColorList![1],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                )),
          ),
          Container(
                height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.2915,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                   animationDuration: Duration.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: sectionList![2] == Colors.white ? BorderRadius.circular(20.0) : BorderRadius.only(bottomRight: Radius.circular(20) , topRight: Radius.circular(20)),
                  ),
                 backgroundColor: sectionList![2],
                ),
                onPressed: () {
                   setState(() {
                  sectionList = [Color(0xFF15616D)  , Color(0xFF15616D), Colors.white  ];
                  textColorList = [Colors.white ,  Colors.white   , Color(0xFF15616D) ];
                 });
                },
                child: Text(
                  "Complete",
                  style: TextStyle(
                       color: textColorList![2],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                )),
          )
        ],
      ),
    );
  }
}
