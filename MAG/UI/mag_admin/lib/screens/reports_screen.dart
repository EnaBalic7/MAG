import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:mag_admin/providers/user_provider.dart';
import 'package:mag_admin/widgets/circular_progress_indicator.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/line_chart.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

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
  late Future<List<UserRegistrationData>> userRegistrationDataFuture;
  late UserProvider _userProvider;
  int days = 29;
  bool pastYear = false;
  bool pastWeek = false;
  double? bottomInterval = 1;
  final ScreenshotController _screenshotController = ScreenshotController();
  Text userChartText = Text("");
  pw.Text userChartTextForPdf = pw.Text("");

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    userRegistrationDataFuture = _userProvider.getUserRegistrations(days);
    generateUserChartText();

    super.initState();
  }

  void generateUserChartText() {
    userChartText = Text(
      "This is where I will interpret above portrayed data. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      textAlign: TextAlign.justify,
    );
    userChartTextForPdf = pw.Text(
        "This is where I will interpret above portrayed data. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        textAlign: pw.TextAlign.justify,
        style: pw.TextStyle(color: PdfColor.fromHex("#C0B9FF")));
  }

  Future<void> exportToPdf() async {
    //Get font
    final fontData = await File(
            'C:\\Users\\Ena\\GitHub\\MAG\\MAG\\UI\\mag_admin\\assets\\fonts\\calibri-regular.ttf')
        .readAsBytes();
    final ttfFont = pw.Font.ttf(fontData.buffer.asByteData());

    //Get device pixel ratio
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    //Get user registration chart image
    ui.Image? capturedImage =
        await _screenshotController.captureAsUiImage(pixelRatio: pixelRatio);
    ByteData? byteData =
        await capturedImage?.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          pageTheme: pw.PageTheme(
            margin: pw.EdgeInsets.zero,
            buildBackground: (context) {
              return pw.Container(
                height: double.infinity,
                width: double.infinity,
                color: PdfColor.fromHex("#1E1C40"),
              );
            },
          ),
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Container(
                width: 700,
                child: pw.Column(children: [
                  pw.Image(
                    pw.MemoryImage(pngBytes),
                    width: 700,
                  ),
                  userChartTextForPdf
                ]),
              ),
            );
          }),
    );

    final filePath = await FilePicker.platform.saveFile(
      fileName: 'Report - ${DateFormat('MMM d, y').format(DateTime.now())}.pdf',
      allowedExtensions: ['pdf'],
    );

    if (filePath != null) {
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
    }
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
        showFloatingActionButton: true,
        floatingActionButtonIcon: buildPdfIcon(48),
        floatingButtonOnPressed: () async {
          await exportToPdf();
        },
        floatingButtonTooltip: "Export to .pdf",
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              buildFilterButtons(),
              FutureBuilder(
                future: userRegistrationDataFuture,
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

                    return Screenshot(
                        controller: _screenshotController,
                        child: buildRegistrationChart(data));
                  }
                },
              ),
              const SizedBox(height: 20),
              buildLineChartInterpretation(),
            ],
          ),
        ));
  }

  Widget buildLineChartInterpretation() {
    return Column(
      children: [
        SizedBox(width: 900, child: userChartText),
      ],
    );
  }

  Row buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientButton(
          onPressed: () {
            setState(() {
              userRegistrationDataFuture =
                  _userProvider.getUserRegistrations(364, groupByMonths: true);
              days = 364;
              pastYear = true;
              pastWeek = false;
              bottomInterval = 1;
            });
          },
          width: 110,
          height: 30,
          gradient: Palette.buttonGradient,
          borderRadius: 50,
          child: const Text("Past year",
              style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 20),
        GradientButton(
          onPressed: () {
            setState(() {
              userRegistrationDataFuture =
                  _userProvider.getUserRegistrations(29);
              days = 29;
              bottomInterval = 1;
              pastYear = false;
              pastWeek = false;
            });
          },
          width: 110,
          height: 30,
          gradient: Palette.buttonGradient,
          borderRadius: 50,
          child: const Text("Past month",
              style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 20),
        GradientButton(
          onPressed: () {
            setState(() {
              userRegistrationDataFuture =
                  _userProvider.getUserRegistrations(6);
              days = 6;
              bottomInterval = 1;
              pastYear = false;
              pastWeek = true;
            });
          },
          width: 110,
          height: 30,
          gradient: Palette.buttonGradient,
          borderRadius: 50,
          child: const Text("Past week",
              style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Center buildRegistrationChart(List<UserRegistrationData> data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            SizedBox(
              width: 1100,
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
                        axisNameWidget: Text("Past ${days + 1} days",
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
                                  .map((element) =>
                                      DateFormat('MMM, y', 'en_US')
                                          .format(element.date!))
                                  .toList();
                            }

                            if (pastWeek == true) {
                              timeLabels = data
                                  .map((element) =>
                                      DateFormat('MMM d, y, EEEE', 'en_US')
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
