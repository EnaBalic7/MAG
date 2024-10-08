import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/club_user_provider.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/join_club_button.dart';
import '../widgets/master_screen.dart';
import '../widgets/separator.dart';
import '../models/club.dart';
import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/club_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/content_form.dart';
import '../widgets/post_cards.dart';

class ClubDetailScreen extends StatefulWidget {
  final Club club;
  final int selectedIndex;

  const ClubDetailScreen({
    super.key,
    required this.club,
    required this.selectedIndex,
  });

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  late final ClubUserProvider _clubUserProvider;
  late final ClubProvider _clubProvider;
  late final PostProvider _postProvider;
  late final UserProvider _userProvider;

  int page = 0;
  int pageSize = 20;

  Map<String, dynamic> _filter = {};

  @override
  void initState() {
    _clubUserProvider = context.read<ClubUserProvider>();
    _clubProvider = context.read<ClubProvider>();
    _postProvider = context.read<PostProvider>();
    _userProvider = context.read<UserProvider>();

    _filter = {
      "ClubId": widget.club.id,
      "NewestFirst": "true",
      "CommentsIncluded": "true",
    };

    _clubUserProvider.addListener(() {
      _updateMemberCount();
    });
    super.initState();
  }

  void _updateMemberCount() async {
    var club = await _clubProvider.get(filter: {"ClubId": "${widget.club.id}"});
    if (mounted) {
      setState(() {
        widget.club.memberCount = club.result.single.memberCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double coverWidth = screenSize.width;
    return MasterScreenWidget(
      showProfileIcon: false,
      selectedIndex: widget.selectedIndex,
      title: widget.club.name,
      showNavBar: false,
      showBackArrow: true,
      showFloatingActionButton: true,
      floatingButtonOnPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return ContentForm(club: widget.club);
            });
      },
      floatingActionButtonIcon: const Icon(
        Icons.post_add_rounded,
        size: 28,
        color: Palette.white,
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          ClipRRect(
              child: Image.memory(
            imageFromBase64String(widget.club.cover!.cover!),
            width: coverWidth,
            height: 200,
            fit: BoxFit.cover,
          )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text("${widget.club.name}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Created: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Palette.lightPurple)),
                      TextSpan(
                        text: DateFormat('MMM d, y')
                            .format(widget.club.dateCreated!),
                        style: const TextStyle(color: Palette.lightPurple),
                      ),
                    ],
                  ),
                ),
                JoinClubButton(
                  clubId: widget.club.id!,
                  userId: LoggedUser.user!.id!,
                  width: 70,
                  height: 23,
                  gradient: Palette.buttonGradient,
                  borderRadius: 50,
                  child: const Text("Join",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Palette.white)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Row(
              children: [
                Expanded(child: Text("${widget.club.description}")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    buildUsersIcon(18),
                    const SizedBox(width: 5),
                    Text("${widget.club.memberCount}")
                  ],
                ),
                _buildClubOwner()
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: MySeparator(width: coverWidth),
          ),
          PostCards(
            selectedIndex: widget.selectedIndex,
            page: page,
            pageSize: pageSize,
            fetchPosts: fetchPosts,
            fetchPage: fetchPage,
            filter: _filter,
          ),
        ]),
      ),
    );
  }

  Row _buildClubOwner() {
    return Row(
      children: [
        Tooltip(message: "Club owner", child: buildCrownIcon(14)),
        const SizedBox(width: 8),
        FutureBuilder<SearchResult<User>>(
            future: _userProvider.get(filter: {"Id": "${widget.club.ownerId}"}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Palette.lightPurple,
                  highlightColor: Palette.white,
                  child: Container(
                    child: const SizedBox(
                      width: 100,
                      height: 11,
                    ).asGlass(),
                  ).asGlass(
                      clipBorderRadius: BorderRadius.circular(4),
                      tintColor: Palette.lightPurple),
                );

                // Loading state
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Error state
              } else {
                // Data loaded successfully
                var user = snapshot.data!;

                if (user.count == 1) {
                  return Tooltip(
                      message: "Club owner",
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          "${user.result.single.username}",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ));
                }
                return const Text("Owner not found");
              }
            }),
      ],
    );
  }

  Future<SearchResult<Post>> fetchPosts() {
    return _postProvider.get(filter: {
      ..._filter,
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }

  Future<SearchResult<Post>> fetchPage(Map<String, dynamic> filter) {
    return _postProvider.get(filter: filter);
  }
}
