import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/providers/user_provider.dart';
import 'package:mag_admin/screens/user_detail_screen.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../models/user_profile_picture.dart';
import '../providers/user_profile_picture_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import 'package:intl/intl.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UserProvider _userProvider;
  late Future<SearchResult<User>> _userFuture;
  late UserProfilePictureProvider _userProfilePictureProvider;
  TextEditingController _userController = TextEditingController();

  @override
  void initState() {
    _userProfilePictureProvider = context.read<UserProfilePictureProvider>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
    _userFuture = _userProvider.get();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Row(
        children: [
          buildUsersIcon(24),
          SizedBox(width: 5),
          Text("Users"),
        ],
      ),
      showSearch: true,
      onSubmitted: _search,
      controller: _userController,
      child: FutureBuilder<SearchResult<User>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var userList = snapshot.data!.result;
            return SingleChildScrollView(
              child: Center(
                child: Wrap(
                  children: _buildUserCards(userList),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _search(String searchText) async {
    var data = _userProvider.get(filter: {'fts': _userController.text});

    setState(() {
      _userFuture = data;
    });
  }

  List<Widget> _buildUserCards(List<User> userList) {
    return List.generate(
      userList.length,
      (index) => _buildUserCard(userList[index]),
    );
  }

  Widget _buildUserCard(User user) {
    return Container(
      width: 200,
      height: 280,
      margin: EdgeInsets.only(top: 20, left: 20, right: 0, bottom: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
      child: FutureBuilder<UserProfilePicture>(
          future: _userProfilePictureProvider.getById(user.profilePictureId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('No profile picture available');
            } else {
              // Data loaded successfully
              var profilePicture = snapshot.data!;

              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.memory(
                      imageFromBase64String(profilePicture.profilePicture!),
                      width: 200,
                      height: 170,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 35, right: 0, top: 5),
                            child: Text(
                              user.username!,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 0, right: 0, bottom: 0),
                        child: _buildPopupMenu(user, profilePicture),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 8, left: 0, right: 0, bottom: 0),
                              child: Row(
                                children: [
                                  Icon(Icons.person,
                                      size: 20, color: Palette.lightPurple),
                                  SizedBox(width: 3),
                                  Text("${user.firstName} ${user.lastName}",
                                      style: TextStyle(
                                          color: Palette.lightPurple,
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 5, left: 0, right: 0, bottom: 0),
                              child: Row(
                                children: [
                                  buildCalendarIcon(20),
                                  SizedBox(width: 3),
                                  Text(
                                      DateFormat('MMM d, y')
                                          .format(user.dateJoined!),
                                      style: TextStyle(
                                          color: Palette.lightPurple,
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }

  Widget _buildPopupMenu(User user, UserProfilePicture picture) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
      ),
      icon: Icon(Icons.more_vert_rounded),
      splashRadius: 1,
      padding: EdgeInsets.zero,
      color: Color.fromRGBO(50, 48, 90, 1),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightPurple.withOpacity(0.1),
            leading:
                Icon(Icons.text_snippet_rounded, color: Palette.lightPurple),
            title: Text('See details',
                style: TextStyle(color: Palette.lightPurple)),
            subtitle: Text('See more information about this user',
                style: TextStyle(color: Palette.lightPurple.withOpacity(0.5))),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetailScreen(
                      user: user, profilePicture: picture.profilePicture)));
            },
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title: Text('Delete', style: TextStyle(color: Palette.lightRed)),
            subtitle: Text('Delete permanently',
                style: TextStyle(color: Palette.lightRed.withOpacity(0.5))),
            onTap: () {
              showConfirmationDialog(
                  context,
                  Icon(Icons.warning_rounded,
                      color: Palette.lightRed, size: 55),
                  Text("Are you sure you want to delete this user?"), () async {
                //Implement user delete
                /*await _genreAnimeProvider.deleteByAnimeId(anime.id!);
                _animeProvider.delete(anime.id!);*/
              });
            },
          ),
        ),
      ],
    );
  }
}
