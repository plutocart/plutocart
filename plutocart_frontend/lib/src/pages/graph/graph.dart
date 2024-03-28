import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/graph_bloc/graph_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/pages/graph/companent_graph/entity_data_graph.dart';
import 'package:plutocart/src/pages/graph/companent_graph/filter_graph.dart';
import 'package:plutocart/src/popups/setting_popup.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  bool? toggleOther;
  double? totalOther;
  List<GraphData> data = [];
  @override
  void initState() {
    toggleOther = false;
    context.read<GoalBloc>().add(GetGoalByAccountId(0));
    context.read<DebtBloc>().add(GetDebtByAccountId(0));
    context.read<TransactionBloc>().add(GetTransactionList(0, 0, 0));
    context.read<GraphBloc>().add(GetGraph(1));
    context.read<GraphBloc>().stream.listen((event) {
      context.read<GraphBloc>().add(GetGraph(event.updateTypeGraph));
    });
    print("Check Data graph : ${data}");

    data = [];
    int size = context.read<GraphBloc>().state.graphList.length <= 5
        ? context.read<GraphBloc>().state.graphList.length
        : 5;
    for (int i = 0; i <= size; i++) {
      data.add(GraphData(
          context.read<GraphBloc>().state.graphList['graphStatementList']
              ['${i}']['transactionCategory']['nameTransactionCategory'],
          context.read<GraphBloc>().state.graphList['graphStatementList']
              ['${i}']['totalInTransactionCategory'],
          context.read<GraphBloc>().state.graphList['graphStatementList']
              ['${i}']['transactionCategory']['colorGraph']));
    }
    data.add(GraphData(
        "Other",
        context.read<GraphBloc>().state.graphList['totalAmountOther'],
        "0XFF989898"));

    context.read<GraphBloc>().stream.listen((event) {
      data = [];
      int size = context.read<GraphBloc>().state.graphList.length <= 5
          ? context.read<GraphBloc>().state.graphList.length
          : 5;
      for (int i = 0; i <= size; i++) {
        data.add(GraphData(
            context.read<GraphBloc>().state.graphList['graphStatementList']
                ['${i}']['transactionCategory']['nameTransactionCategory'],
            context.read<GraphBloc>().state.graphList['graphStatementList']
                ['${i}']['totalInTransactionCategory'],
            context.read<GraphBloc>().state.graphList['graphStatementList']
                ['${i}']['transactionCategory']['colorGraph']));
      }
      data.add(GraphData(
          "Other",
          context.read<GraphBloc>().state.graphList['totalAmountOther'],
          "0XFF989898"));

      context.read<GraphBloc>().add(ResetGraphAnalysic());
    });
    super.initState();

    print("Check color : ${data[0].color}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphBloc, GraphState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.getLoading == GraphStatus.loading,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Graph",
                        style: TextStyle(
                          color: Color(0xFF15616D),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Image.asset(
                          "assets/icon/icon_launch.png",
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          SettingPopUp(state.accountRole, state.email, context);
                        },
                        icon: Icon(Icons.settings),
                        color: Color(0xFF15616D),
                      );
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.white10,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FilterGraph(),
                    state.graphList['graphStatementList'].length > 3
                        ? SizedBox(height: 15)
                        : SizedBox.shrink(),
                    context
                                .read<GraphBloc>()
                                .state
                                .graphList['graphStatementList']
                                .length ==
                            0
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icon/icon_launch.png'),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 157),
                                    child: Text("No record",
                                        style: TextStyle(
                                            color: Color(0xFF15616D),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Roboto")),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Stack(
                              children: [
                                SfCircularChart(
                                    legend: Legend(
                                        isVisible: true,
                                        position: LegendPosition.bottom,
                                        overflowMode:
                                            LegendItemOverflowMode.wrap,
                                        alignment: ChartAlignment.center),
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    series: <CircularSeries<GraphData, String>>[
                                      DoughnutSeries<GraphData, String>(
                                          dataSource: data,
                                          dataLabelMapper: (datum, index) {
                                            return '${double.parse(((data[index].totalInTransactionCategory / state.graphList['totalAmount']) * 100).toStringAsFixed(2))}%';
                                          },
                                          xValueMapper: (GraphData data, _) =>
                                              data.transactionCategoryName,
                                          yValueMapper: (GraphData data, _) =>
                                              double.parse(
                                                  ((data.totalInTransactionCategory /
                                                              state.graphList[
                                                                  'totalAmount']) *
                                                          100)
                                                      .toStringAsFixed(2)),
                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                          ),
                                          animationDuration: 500,
                                          enableTooltip: true,
                                          pointColorMapper:
                                              (GraphData data, _) =>
                                                  Color(int.parse(data.color))),
                                    ]),
                                Center(
                                  child: Padding(
                                    padding: state
                                                .graphList['graphStatementList']
                                                .length >
                                            3
                                        ? const EdgeInsets.only(bottom: 70)
                                        : const EdgeInsets.only(bottom: 40),
                                    child: Text(
                                      "${state.updateTypeGraph == 1 ? "Income" : "Expense"}",
                                      style: TextStyle(
                                        color: Color(0xFF15616D),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto",
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(
                                                0.3), // Shadow color and opacity
                                            offset: Offset(
                                                2, 2), // Shadow position (X,Y)
                                            blurRadius: 2, // Shadow blur radius
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Column(
                        children: [
                          BlocBuilder<GraphBloc, GraphState>(
                            builder: (context, state) {
                              return Container(
                                constraints: BoxConstraints(
                                    minHeight:
                                        MediaQuery.of(context).size.height *
                                            0.06,
                                    minWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0XFF15616D),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                  color: Colors.white, // Background color
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total amount",
                                      style: TextStyle(
                                        color: Color(0XFF1A9CB0),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      "${NumberFormat("#,##0.00").format(state.graphList['totalAmount'])} ฿",
                                      style: TextStyle(
                                        color: Color(0XFF15616D),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    BlocBuilder<GraphBloc, GraphState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: List.generate(
                                state.graphList['graphStatementList'].length <=
                                        5
                                    ? state
                                        .graphList['graphStatementList'].length
                                    : 5, (index) {
                              String nameCategory =
                                  state.graphList['graphStatementList']
                                          ["${index}"]['transactionCategory']
                                      ['nameTransactionCategory'];

                              String color =
                                  state.graphList['graphStatementList']
                                          ["${index}"]['transactionCategory']
                                      ['colorGraph'];
                              print("check color graph : ${int.parse(color)}");

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0XFF15616D),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                    color: Colors.white, // Background color
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color:
                                                      Color(int.parse(color)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                "${nameCategory}",
                                                style: TextStyle(
                                                  color: Color(0XFF15616D),
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${NumberFormat("#,##0.00").format(state.graphList['graphStatementList']['${index}']['totalInTransactionCategory'])} ฿",
                                          style: TextStyle(
                                            color: Color(0XFF15616D),
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                    state.graphList['graphStatementListOther'].length == 0
                        ? SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                toggleOther = !toggleOther!;
                              });
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: toggleOther == false
                                      ? MediaQuery.of(context).size.height *
                                          0.07
                                      : null,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0XFF15616D),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                    color: Colors.white, // Background color
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: toggleOther == true ? 10 : 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              toggleOther == true
                                                  ? CrossAxisAlignment.start
                                                  : CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFF989898),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    "Other",
                                                    style: TextStyle(
                                                      color: Color(0XFF15616D),
                                                      fontSize: 16,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            toggleOther == false
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        "${NumberFormat("#,##0.00").format(state.graphList['totalAmountOther'])} ฿",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0XFF15616D),
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: Icon(Icons
                                                              .expand_more_outlined))
                                                    ],
                                                  )
                                                : SizedBox.shrink()
                                          ],
                                        ),
                                        toggleOther == true
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16),
                                                child: Container(
                                                  height: 1,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  decoration: ShapeDecoration(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            Color(0XFF898989),
                                                      ),
                                                      borderRadius: BorderRadius
                                                          .zero, // หรือกำหนดรูปแบบได้ตามที่ต้องการ
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                        toggleOther == true
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: List.generate(
                                                          state
                                                              .graphList[
                                                                  'graphStatementListOther']
                                                              .length, (index) {
                                                        int i = index + 5;
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 16,
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "${state.graphList['graphStatementListOther']["${i}"]['transactionCategory']['nameTransactionCategory']}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0XFF707070),
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    "${((state.graphList['graphStatementListOther']["${i}"]['totalInTransactionCategory'] / state.graphList['totalAmount']) * 100).toStringAsFixed(2)}%",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0XFF707070),
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                "${NumberFormat("#,##0.00").format(state.graphList['graphStatementListOther']['${i}']['totalInTransactionCategory'])} ฿",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0XFF15616D),
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  height: 0,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              backgroundColor:
                                                                  Color(
                                                                      0XFF15616D)),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Close",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height: 0,
                                                            ),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
