import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/donation_provider.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/pagination_buttons.dart';
import '../models/donation.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../utils/util.dart';

typedef FetchPage = Future<SearchResult<Donation>> Function(
    Map<String, dynamic> filter);

// ignore: must_be_immutable
class DonationCards extends StatefulWidget {
  final Future<SearchResult<Donation>> Function() fetchDonations;
  final FetchPage fetchPage;
  Map<String, dynamic> filter;
  int page;
  int pageSize;

  DonationCards({
    super.key,
    required this.fetchDonations,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
  });

  @override
  State<DonationCards> createState() => _DonationCardsState();
}

class _DonationCardsState extends State<DonationCards> {
  late Future<SearchResult<Donation>> _donationFuture;
  final ScrollController _scrollController = ScrollController();
  late final DonationProvider _donationProvider;

  int totalItems = 0;

  @override
  void didUpdateWidget(covariant DonationCards oldWidget) {
    if (widget.filter != oldWidget.filter) {
      _donationFuture = widget.fetchDonations();
      setTotalItems();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _donationProvider = context.read<DonationProvider>();
    _donationFuture = widget.fetchDonations();

    setTotalItems();

    _donationProvider.addListener(() {
      _reloadData();
      setTotalItems();
    });

    super.initState();
  }

  void _reloadData() {
    if (mounted) {
      setState(() {
        _donationFuture = widget.fetchDonations();
      });
    }
  }

  void setTotalItems() async {
    var donationResult = await _donationFuture;
    if (mounted) {
      setState(() {
        totalItems = donationResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchResult<Donation>>(
        future: _donationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var donationList = snapshot.data!.result;

            if (donationList.isEmpty) {
              return Text(
                "No donations found..",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Palette.lightPurple.withOpacity(0.8)),
              );
            }
            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: _buildDonationCards(donationList),
                    ),
                    MyPaginationButtons(
                      page: widget.page,
                      pageSize: widget.pageSize,
                      totalItems: totalItems,
                      fetchPage: fetchPage,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await widget.fetchPage({
        ...widget.filter,
        "Page": "$requestedPage",
        "PageSize": "${widget.pageSize}",
      });

      if (mounted) {
        setState(() {
          _donationFuture = Future.value(result);
          widget.page = requestedPage;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        showErrorDialog(context, e);
      }
    }
  }

  List<Widget> _buildDonationCards(List<Donation> donationList) {
    return List.generate(
      donationList.length,
      (index) => _buildDonationCard(donationList[index]),
    );
  }

  Widget _buildDonationCard(Donation donation) {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width * 0.4;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: Palette.menuGradient),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "${donation.amount} BAM",
            style: const TextStyle(
                color: Palette.white, fontWeight: FontWeight.w500),
          ),
          Text(DateFormat('MMM d, y').format(donation.dateDonated!),
              style: const TextStyle(
                  color: Palette.white, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}
