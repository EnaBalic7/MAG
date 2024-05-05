import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/providers/genre_provider.dart';
import 'package:mag_user/widgets/form_builder_filter_chip.dart';
import 'package:provider/provider.dart';

import '../models/genre.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/master_screen.dart';

class ExploreScreen extends StatefulWidget {
  final int selectedIndex;
  const ExploreScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<SearchResult<Genre>> _genreFuture;
  late final GenreProvider _genreProvider;
  final _exploreFormKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _genreProvider = context.read<GenreProvider>();
    _genreFuture = _genreProvider.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      selectedIndex: widget.selectedIndex,
      showNavBar: true,
      showProfileIcon: false,
      activateSearch: true,
      showSearch: true,
      title: "Explore",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGenres(), // Genres section
          Expanded(
            child: Text(""), // Search results section
          ),
        ],
      ),
    );
  }

  Widget _buildGenres() {
    return FutureBuilder<SearchResult<Genre>>(
        future: _genreFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var genres = snapshot.data!.result;
            return FormBuilder(
              key: _exploreFormKey,
              child: MyFormBuilderFilterChip(
                name: 'genres',
                options: [
                  ...genres
                      .map(
                        (genre) => FormBuilderFieldOption(
                          value: genre.id.toString(),
                          child: Text(genre.name!,
                              style: const TextStyle(
                                  color: Palette.midnightPurple)),
                        ),
                      )
                      .toList(),
                ],
              ),
            );
          }
        });
  }
}
