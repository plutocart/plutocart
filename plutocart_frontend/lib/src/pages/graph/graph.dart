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
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilterGraph(),
            SizedBox(height: 16),
            Container(
                height: 300, // Adjust height as needed
                child: SfCircularChart(
                    legend: Legend(isVisible: true , overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries<SalesData, String>>[
                      DoughnutSeries<SalesData, String>(
                          dataSource: data,
                          xValueMapper: (SalesData data, _) => data.year,
                          yValueMapper: (SalesData data, _) =>data.sales,
                          dataLabelSettings:DataLabelSettings(isVisible: true ) , 
                          enableTooltip: true),
                    ]),
                    ),
          ],
        ),
      ),
    );
  }
}


