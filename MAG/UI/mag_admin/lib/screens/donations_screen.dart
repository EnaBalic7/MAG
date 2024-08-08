import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/master_screen.dart';
import '../models/donation.dart';
import '../models/search_result.dart';
import '../providers/donation_provider.dart';
import '../utils/colors.dart';
import '../widgets/donation_cards.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  late final DonationProvider _donationProvider;
  int page = 0;
  int pageSize = 30;

  final Map<String, dynamic> _filter = {
    "NewestFirst": true,
  };

  @override
  void initState() {
    _donationProvider = context.read<DonationProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      titleWidget: const Row(
        children: [
          Icon(Icons.credit_card_rounded, color: Palette.lightPurple),
          SizedBox(width: 5),
          Text("Donations"),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            DonationCards(
              fetchDonations: fetchDonations,
              fetchPage: fetchPage,
              filter: _filter,
              page: page,
              pageSize: pageSize,
            ),
          ],
        ),
      ),
    );
  }

  Future<SearchResult<Donation>> fetchDonations() {
    return _donationProvider.get(filter: {
      ..._filter,
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }

  Future<SearchResult<Donation>> fetchPage(Map<String, dynamic> filter) {
    return _donationProvider.get(filter: filter);
  }
}
