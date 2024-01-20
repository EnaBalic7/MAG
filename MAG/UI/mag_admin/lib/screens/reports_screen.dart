import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mag_admin/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/registration_data.dart';
import '../utils/colors.dart';
import '../widgets/master_screen.dart';

import '../utils/icons.dart';

class ReportsScreen extends StatefulWidget {
  ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late List<UserRegistrationData> userRegistrationData = [];
  late UserProvider _userProvider;
  int days = 29;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _getUserRegistrationData();

    super.initState();
  }

  void _getUserRegistrationData() async {
    userRegistrationData = await _userProvider.getUserRegistrations(days);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        titleWidget: Row(
          children: [
            buildReportsIcon(28),
            const SizedBox(width: 5),
            const Text("Reports"),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Container(
                  width: 1000,
                  height: 500,
                  child: LineChart(
                    LineChartData(
                        gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            verticalInterval: 1),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                              axisNameWidget: const Text(
                                  "Number of registered users",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              axisNameSize: 20),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Text("Past $days days",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            axisNameSize: 20,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 80,
                              interval: 1,
                              getTitlesWidget: ((value, meta) {
                                List<String> customDates = userRegistrationData
                                    .map((element) => DateFormat('MMM d, y')
                                        .format(element.date!))
                                    .toList();

                                // Ensure the value is an integer
                                int index = value.toInt() + 1;

                                // Check if the index is within the range of customDates
                                if (index >= 1 && index < customDates.length) {
                                  return RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      customDates[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                }

                                return Container();
                              }),
                            ),
                          ),
                          rightTitles:
                              AxisTitles(axisNameWidget: const Text("")),
                          topTitles: AxisTitles(axisNameWidget: const Text("")),
                        ),
                        borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Palette.teal.withOpacity(0.5),
                              width: 2,
                            )),
                        minX: 0,
                        maxX: userRegistrationData.length.toDouble() - 1,
                        minY: 0,
                        maxY: _getMaxYValue(),
                        lineBarsData: [
                          LineChartBarData(
                            gradient: Palette.buttonGradientReverse,
                            spots: _getSpots(),
                            isCurved: true,
                            barWidth: 4,
                            preventCurveOverShooting: true,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: true),
                            shadow: const Shadow(
                                color: Palette.teal, blurRadius: 30),
                            dotData: FlDotData(show: true),
                          )
                        ]),

                    swapAnimationDuration:
                        const Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  List<FlSpot> _getSpots() {
    return userRegistrationData.asMap().entries.map((entry) {
      return FlSpot(
          entry.key.toDouble(), entry.value.numberOfUsers!.toDouble());
    }).toList();
  }

  double _getMaxYValue() {
    return userRegistrationData.isNotEmpty
        ? userRegistrationData
            .map((entry) => entry.numberOfUsers!.toDouble())
            .reduce((a, b) => a > b ? a : b)
        : 1.0;
  }
}
