import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/graph_bloc/graph_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/pages/graph/companent_graph/entity_data_graph.dart';
import 'package:plutocart/src/pages/graph/companent_graph/filter_graph.dart';
import 'package:plutocart/src/popups/setting_popup.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
  ];

  @override
  void initState() {
    context.read<GoalBloc>().add(GetGoalByAccountId(0));
    context.read<DebtBloc>().add(GetDebtByAccountId(0));
    context.read<GraphBloc>().add(GetGraph(1));
    print(context.read<GraphBloc>().state.graphList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 16),
              Container(
                height: 300, // Adjust height as needed
                child: SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries<SalesData, String>>[
                      DoughnutSeries<SalesData, String>(
                          dataSource: data,
                          xValueMapper: (SalesData data, _) => data.year,
                          yValueMapper: (SalesData data, _) => data.sales,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true),
                    ]),
              ),
              Container(
                child: Column(
                  children: [
                    BlocBuilder<GraphBloc, GraphState>(
                      builder: (context, state) {
                        return Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.06,
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                width: 1.5,
                                color: Color(0xFF15616D),
                              )),
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
                                "${state.graphList['totalAmount']}฿",
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
                  return Column(
                    children: List.generate(state.graphList.length, (index) {
                      print("check graph list number  : ${index}");
                      print(
                          "check graph list : ${state.graphList['graphStatementList']['graphTransactionCategory']['transactionCategory']['nameTransactionCategory']}");
                      return Text(
                          "${state.graphList['graphStatementList']['graphTransactionCategory']['transactionCategory']['nameTransactionCategory']}");
                    }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
