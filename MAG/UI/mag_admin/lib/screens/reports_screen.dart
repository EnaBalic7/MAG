import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:mag_admin/models/popular_anime_data.dart';
import 'package:mag_admin/providers/anime_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:mag_admin/providers/user_provider.dart';
import 'package:mag_admin/widgets/circular_progress_indicator.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../models/popular_genres_data.dart';
import '../models/registration_data.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/genre_provider.dart';
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
  late Future<SearchResult<User>> _userFuture;
  late UserProvider _userProvider;
  int totalUsers = 0;
  int days = 29;
  bool pastYear = false;
  bool pastWeek = false;
  double? bottomInterval = 1;
  final ScreenshotController _screenshotController = ScreenshotController();
  Text userChartText = Text("");
  pw.Text userChartTextForPdf = pw.Text("");

  late AnimeProvider _animeProvider;
  List<String> animeTitles = [];
  late Future<List<PopularAnimeData>> popularAnimeDataFuture;
  List<PopularAnimeData> popularAnimeData = [];

  late GenreProvider _genreProvider;
  List<String> genreTitles = [];
  late Future<List<PopularGenresData>> popularGenresDataFuture;
  List<PopularGenresData> popularGenresData = [];

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    userRegistrationDataFuture = _userProvider.getUserRegistrations(days);
    _userFuture = _userProvider.get();
    getTotalusers();
    generateUserChartText();

    _animeProvider = context.read<AnimeProvider>();
    getPopularAnimeData();

    _genreProvider = context.read<GenreProvider>();
    getPopularGenresData();

    super.initState();
  }

  void getPopularGenresData() async {
    popularGenresData = await _genreProvider.getMostPopularGenres();
    popularGenresDataFuture = Future.value(popularGenresData);

    for (var genre in popularGenresData) {
      genreTitles.add(genre.genreName!);
    }
  }

  void getPopularAnimeData() async {
    popularAnimeData = await _animeProvider.getMostPopularAnime();
    popularAnimeDataFuture = Future.value(popularAnimeData);

    for (var anime in popularAnimeData) {
      animeTitles.add(anime.animeTitleEN!);
    }
  }

  void getTotalusers() async {
    var users = await _userFuture;

    setState(() {
      totalUsers = users.count;
    });
  }

  void generateUserChartText() {
    userChartText = Text(
      "This is where I will interpret above portrayed data. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      textAlign: TextAlign.justify,
    );
    userChartTextForPdf = pw.Text(
        "This is where I will interpret above portrayed data. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        textAlign: pw.TextAlign.justify,
        style: pw.TextStyle(color: PdfColor.fromHex("#C0B9FF"), fontSize: 11));
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

    final ByteData logoByteData =
        await rootBundle.load("assets/images/logoFilled.png");
    final Uint8List logoBytes = logoByteData.buffer.asUint8List();

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          pageTheme: pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.zero,
            buildBackground: (context) {
              return pw.Container(
                height: double.infinity,
                width: double.infinity,
                color: PdfColor.fromHex("#0C0B1E"), // 0C0B1E - midnightPurple
              );
            },
          ),
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Container(
                width: 700,
                padding: const pw.EdgeInsets.all(30),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(children: [
                        pw.Header(
                          level: 1,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  width: 0, style: pw.BorderStyle.none)),
                          child: pw.Column(children: [
                            pw.Row(children: [
                              pw.Image(pw.MemoryImage(logoBytes), width: 80),
                              pw.SizedBox(width: 78),
                              pw.Text(
                                  'Report - ${DateFormat('MMM d, y').format(DateTime.now())}',
                                  style: pw.TextStyle(
                                      color: PdfColor.fromHex("#C0B9FF"),
                                      fontSize: 22)),
                            ]),
                            pw.Container(
                                width: 900,
                                height: 1,
                                color: PdfColor.fromHex("#C0B9FF")),
                          ]),
                        ),
                        pw.Image(
                          pw.MemoryImage(pngBytes),
                          width: 760,
                        ),
                        pw.SizedBox(height: 20),
                        pw.Column(children: [
                          pw.Text("Total number of registered users:",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromHex("#C0B9FF"))),
                          pw.Text("$totalUsers",
                              style: pw.TextStyle(
                                  color: PdfColor.fromHex("#99FFFF"),
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold))
                        ]),
                        pw.SizedBox(height: 20),
                        userChartTextForPdf,
                      ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Footer(
                              title: pw.Text(
                                "1",
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#C0B9FF")),
                              ),
                            )
                          ]),
                    ]),
              ),
            );
          }),
    );

    final filePath = await FilePicker.platform.saveFile(
      dialogTitle: "Choose where to save report",
      fileName: 'Report - ${DateFormat('MMM d, y').format(DateTime.now())}.pdf',
      allowedExtensions: ['pdf'],
      type: FileType.custom,
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
              buildTotalUsers(),
              const SizedBox(height: 20),
              buildLineChartInterpretation(),
              const SizedBox(height: 20),
              buildPopularAnimeChart(),
              const SizedBox(height: 20),
              buildAnimeBarChartInterpretation(),
              const SizedBox(height: 20),
              buildPopularGenresChart(),
              const SizedBox(height: 20),
              buildAnimeBarChartInterpretation(),
            ],
          ),
        ));
  }

  Widget buildTotalUsers() {
    return Column(
      children: [
        const Text("Total number of registered users:",
            style: TextStyle(fontSize: 20)),
        Text("$totalUsers",
            style: const TextStyle(
                color: Palette.teal, fontSize: 30, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget buildPopularGenresChart() {
    final List<int> popularityValues = [];
    for (var item in popularGenresData) {
      popularityValues.add(item.usersWhoLikeIt!);
    }

    return Center(
        child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(children: [
        SizedBox(
          width: 1100,
          height: 500,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(enabled: true),
              barGroups: List.generate(
                5,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: popularityValues[index].toDouble(),
                      gradient: Palette.gradientList[index],
                      width: 35,
                    ),
                  ],
                ),
              ),
              gridData: FlGridData(
                  show: true, drawVerticalLine: true, verticalInterval: 1),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(axisNameWidget: const Text("")),
                leftTitles: AxisTitles(axisNameWidget: const Text("")),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 100,
                    showTitles: true,
                    getTitlesWidget: ((value, meta) {
                      if (value.toInt() >= 0 &&
                          value.toInt() < genreTitles.length) {
                        return Container(
                          width: 150,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  genreTitles[value.toInt()],
                                  softWrap: true,
                                  textAlign: ui.TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Text('');
                    }),
                  ),
                ),
                topTitles: AxisTitles(
                  axisNameSize: 30,
                  axisNameWidget: const Text(
                    "Top 5 most popular genres",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
              borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Palette.teal.withOpacity(0.5),
                    width: 2,
                  )),
            ),

            swapAnimationDuration:
                const Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
      ]),
    ));
  }

  Widget buildAnimeBarChartInterpretation() {
    return Column(
      children: [
        SizedBox(
          width: 900,
          child: FutureBuilder<List<PopularAnimeData>>(
            future: _animeProvider.getMostPopularAnime(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MyProgressIndicator(); // Loading state
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Error state
              } else {
                // Data loaded successfully
                var animeData = snapshot.data!;

                return Text(
                  "The most popular anime on this app thus far is ${animeData[0].animeTitleEN} (${animeData[0].animeTitleJP}) with a score ${animeData[0].score.toString()} and a total of ${animeData[0].numberOfRatings.toString()} rating(s). \n \n The following are: \n ${animeData[1].animeTitleEN} (${animeData[1].animeTitleJP}) with a score ${animeData[1].score.toString()} and a total of ${animeData[1].numberOfRatings.toString()} rating(s), \n ${animeData[2].animeTitleEN} (${animeData[2].animeTitleJP}) with a score ${animeData[2].score.toString()} and a total of ${animeData[2].numberOfRatings.toString()} rating(s), \n ${animeData[3].animeTitleEN} (${animeData[3].animeTitleJP}) with a score ${animeData[3].score.toString()} and a total of ${animeData[3].numberOfRatings.toString()} rating(s), \n ${animeData[4].animeTitleEN} (${animeData[4].animeTitleJP}) with a score ${animeData[4].score.toString()} and a total of ${animeData[4].numberOfRatings.toString()} rating(s).",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
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

  Widget buildPopularAnimeChart() {
    final List<int> popularityValues = [5, 4, 3, 2, 1];
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(children: [
        SizedBox(
          width: 1100,
          height: 500,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(enabled: false),
              barGroups: List.generate(
                5,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: popularityValues[index].toDouble(),
                      gradient: Palette.gradientList[index],
                      width: 35,
                    ),
                  ],
                ),
              ),
              gridData: FlGridData(
                  show: true, drawVerticalLine: true, verticalInterval: 1),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(axisNameWidget: const Text("")),
                leftTitles: AxisTitles(axisNameWidget: const Text("")),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 100,
                    showTitles: true,
                    getTitlesWidget: ((value, meta) {
                      if (value.toInt() >= 0 &&
                          value.toInt() < animeTitles.length) {
                        return Container(
                          width: 150,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  animeTitles[value.toInt()],
                                  softWrap: true,
                                  textAlign: ui.TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Text('');
                    }),
                  ),
                ),
                topTitles: AxisTitles(
                  axisNameSize: 30,
                  axisNameWidget: const Text(
                    "Top 5 most popular anime",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
              borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Palette.teal.withOpacity(0.5),
                    width: 2,
                  )),
            ),

            swapAnimationDuration:
                const Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
      ]),
    ));
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
                      topTitles: AxisTitles(
                          axisNameSize: 30,
                          axisNameWidget: const Text(
                            "Number of registered users in time",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          )),
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
