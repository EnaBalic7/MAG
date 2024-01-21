import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:mag_admin/providers/user_provider.dart';
import 'package:mag_admin/widgets/circular_progress_indicator.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
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
  late Future<List<UserRegistrationData>> _userRegistrationDataFuture;
  late UserProvider _userProvider;
  int days = 29;
  bool pastYear = false;
  double? bottomInterval = 1;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _userRegistrationDataFuture = _userProvider.getUserRegistrations(days);
    _getUserRegistrationData();

    super.initState();
  }

  void _getUserRegistrationData() async {}

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
      child: Column(
        children: [
          FutureBuilder(
            future: _userRegistrationDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MyProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<UserRegistrationData> data =
                    (snapshot.data as List<UserRegistrationData>);

                data.forEach((data) {
                  // Convert dates to local time zone
                  data.date = data.date?.toLocal();
                });

                return _buildRegistrationChart(data);
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                onPressed: () {
                  setState(() {
                    _userRegistrationDataFuture =
                        _userProvider.getUserRegistrations(364);
                    days = 364;
                    pastYear = true;
                    bottomInterval = null;
                  });
                },
                width: 150,
                height: 30,
                gradient: Palette.buttonGradient,
                borderRadius: 50,
                child: const Text("Past year"),
              ),
              const SizedBox(width: 20),
              GradientButton(
                onPressed: () {
                  setState(() {
                    _userRegistrationDataFuture =
                        _userProvider.getUserRegistrations(29);
                    days = 29;
                    bottomInterval = 1;
                    pastYear = false;
                  });
                },
                width: 150,
                height: 30,
                gradient: Palette.buttonGradient,
                borderRadius: 50,
                child: const Text("Past month"),
              ),
              const SizedBox(width: 20),
              GradientButton(
                onPressed: () {
                  setState(() {
                    _userRegistrationDataFuture =
                        _userProvider.getUserRegistrations(6);
                    days = 6;
                    bottomInterval = 1;
                    pastYear = false;
                  });
                },
                width: 150,
                height: 30,
                gradient: Palette.buttonGradient,
                borderRadius: 50,
                child: const Text("Past week"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Center _buildRegistrationChart(List<UserRegistrationData> data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            SizedBox(
              width: 1500,
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
                        axisNameWidget: const Text("Number of registered users",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        axisNameSize: 22,
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 25,
                          interval: 1,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameWidget: Text("Past ${days + 1} day(s)",
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        axisNameSize: 20,
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 80,
                          interval: bottomInterval,
                          getTitlesWidget: ((value, meta) {
                            List<String> timeLabels = data
                                .map((element) => DateFormat('MMM d, y')
                                    .format(element.date!))
                                .toList();

                            if (pastYear == true) {
                              timeLabels = data
                                  .map((element) => DateFormat('MMM', 'en_US')
                                      .format(element.date!))
                                  .toList();
                            }

                            // Ensure the value is an integer
                            int index = value.toInt();

                            // Check if the index is within the range of customDates
                            if (index >= 0 && index < timeLabels.length) {
                              return RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  timeLabels[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }

                            return Container();
                          }),
                        ),
                      ),
                      rightTitles: AxisTitles(axisNameWidget: const Text("")),
                      topTitles: AxisTitles(axisNameWidget: const Text("")),
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: Palette.teal.withOpacity(0.5),
                          width: 2,
                        )),
                    minX: 0,
                    maxX: data.length.toDouble() - 1,
                    minY: 0,
                    maxY: _getMaxYValue(data),
                    lineBarsData: [
                      LineChartBarData(
                        gradient: Palette.buttonGradientReverse,
                        spots: _getSpots(data),
                        isCurved: true,
                        barWidth: 4,
                        preventCurveOverShooting: true,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Palette.teal.withOpacity(0.3),
                        ),
                        shadow:
                            const Shadow(color: Palette.teal, blurRadius: 30),
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
    );
  }

  List<FlSpot> _getSpots(List<UserRegistrationData> data) {
    return data.asMap().entries.map((entry) {
      return FlSpot(
          entry.key.toDouble(), entry.value.numberOfUsers!.toDouble());
    }).toList();
  }

  double _getMaxYValue(List<UserRegistrationData> data) {
    return data.isNotEmpty
        ? data
            .map((entry) => entry.numberOfUsers!.toDouble())
            .reduce((a, b) => a > b ? a : b)
        : 1.0;
  }
}
