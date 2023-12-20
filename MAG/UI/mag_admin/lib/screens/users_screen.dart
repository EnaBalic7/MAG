import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/providers/role_provider.dart';
import 'package:mag_admin/providers/user_provider.dart';
import 'package:mag_admin/providers/user_role_provider.dart';
import 'package:mag_admin/screens/user_detail_screen.dart';
import 'package:mag_admin/widgets/form_builder_dropdown.dart';
import 'package:mag_admin/widgets/form_builder_switch.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';
import '../models/role.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../models/user_profile_picture.dart';
import '../models/user_role.dart';
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
  TextEditingController _userController = TextEditingController();
  final _userRoleFormKey = GlobalKey<FormBuilderState>();
  late RoleProvider _roleProvider;
  late Future<SearchResult<Role>> _roleFuture;
  late UserRoleProvider _userRoleProvider;
  late Future<SearchResult<UserRole>> _userRoleFuture;
  Map<String, dynamic> _userRoleInitialValue = {};

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _userFuture = _userProvider.get(filter: {"ProfilePictureIncluded": "true"});

    _roleProvider = context.read<RoleProvider>();
    _roleFuture = _roleProvider.get();

    _userRoleProvider = context.read<UserRoleProvider>();
    _userRoleFuture = _userRoleProvider.get();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    var data = _userProvider.get(filter: {
      "FTS": _userController.text,
      "ProfilePictureIncluded": "true"
    });

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
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Image.memory(
              imageFromBase64String(user.profilePicture!.profilePicture!),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                child: _buildPopupMenu(user),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 0),
                      child: Row(
                        children: [
                          Icon(Icons.person,
                              size: 20, color: Palette.lightPurple),
                          SizedBox(width: 3),
                          Text("${user.firstName} ${user.lastName}",
                              style: TextStyle(
                                  color: Palette.lightPurple, fontSize: 16)),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
                      child: Row(
                        children: [
                          buildCalendarIcon(20),
                          SizedBox(width: 3),
                          Text(DateFormat('MMM d, y').format(user.dateJoined!),
                              style: TextStyle(
                                  color: Palette.lightPurple, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showOverlayForm(BuildContext context, User user) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: Palette.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 1,
          //width: MediaQuery.of(context).size.width * 1,
          child: Stack(
            children: [
              _buildOverlayForm(context, user),
              Positioned(
                left: 190,
                top: 25,
                child: Image.asset(
                  "assets/images/animeWitch.png",
                  width: 400,
                ),
              ),
              Positioned(
                right: 350,
                bottom: 40,
                child: Image.asset(
                  "assets/images/cauldron.png",
                  width: 200,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverlayForm(BuildContext context, User user) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Palette.lightPurple.withOpacity(0.2)),
              color: Palette.darkPurple,
            ),
            padding: EdgeInsets.all(16.0),
            width: 500.0,
            height: 650.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close_rounded))
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.memory(
                        imageFromBase64String(
                            user.profilePicture!.profilePicture!),
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    Text("${user.username}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                FormBuilder(
                  key: _userRoleFormKey,
                  initialValue: _userRoleInitialValue,
                  child: Column(
                    children: [
                      FutureBuilder<SearchResult<Role>>(
                          future: _roleFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return Text('No roles available');
                            } else {
                              // Data loaded successfully
                              var roles = snapshot.data!;

                              List<DropdownMenuItem<String>> dropdownItems =
                                  roles.result
                                      .map((role) => DropdownMenuItem<String>(
                                            value: role.id.toString(),
                                            child: Text(role.name!),
                                          ))
                                      .toList();

                              return MyFormBuilderDropdown(
                                  name: "roleId",
                                  labelText: "Role",
                                  fillColor:
                                      Palette.lightPurple.withOpacity(0.1),
                                  dropdownColor: Palette.disabledControl,
                                  height: 50,
                                  borderRadius: 50,
                                  items: dropdownItems);
                            }
                          }),
                      MyFormBuilderSwitch(
                        name: "canParticipateInClubs",
                        title: Text(
                          "Club participation",
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          "Allows the user to create clubs, make posts and comments",
                          style: TextStyle(
                              color: Palette.lightPurple.withOpacity(0.5)),
                        ),
                      ),
                      MyFormBuilderSwitch(
                        name: "canReview",
                        title: Text(
                          "Reviewing",
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          "Allows the user to leave reviews for anime series",
                          style: TextStyle(
                              color: Palette.lightPurple.withOpacity(0.5)),
                        ),
                      ),
                      MyFormBuilderSwitch(
                        name: "canAskQuestions",
                        title: Text(
                          "Help section participation",
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          "Allows the user to ask administrator(s) questions",
                          style: TextStyle(
                              color: Palette.lightPurple.withOpacity(0.5)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GradientButton(
                  width: 100,
                  height: 30,
                  borderRadius: 50,
                  gradient: Palette.buttonGradient,
                  onPressed: () async {
                    _userRoleFormKey.currentState?.saveAndValidate();
                    var request =
                        Map.from(_userRoleFormKey.currentState!.value);
                    try {
                      var userRole = await _userRoleProvider
                          .get(filter: {"UserId": "${user.id}"});
                      await _userRoleProvider.update(userRole.result.single.id!,
                          request: request);
                      showInfoDialog(
                          context,
                          Icon(Icons.task_alt,
                              color: Palette.lightPurple, size: 50),
                          Text(
                            "Updated successfully!",
                            textAlign: TextAlign.center,
                          ));
                    } on Exception catch (e) {
                      showErrorDialog(context, e);
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenu(User user) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
      ),
      icon: Icon(Icons.more_vert_rounded),
      splashRadius: 1,
      constraints: BoxConstraints(minWidth: 10),
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
            title: Text("See details",
                style: TextStyle(color: Palette.lightPurple)),
            subtitle: Text("See more information about this user",
                style: TextStyle(color: Palette.lightPurple.withOpacity(0.5))),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetailScreen(user: user)));
            },
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightPurple.withOpacity(0.1),
            leading: Icon(
              Icons.settings_suggest_rounded,
              color: Palette.lightPurple,
              size: 24,
            ),
            title: Text("User permissions",
                style: TextStyle(color: Palette.lightPurple)),
            subtitle: Text("Manage user's role and permissions",
                style: TextStyle(color: Palette.lightPurple.withOpacity(0.5))),
            onTap: () async {
              try {
                // Show loading indicator while fetching data
                showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                SearchResult<UserRole> result = await _userRoleProvider.get(
                  filter: {"UserId": "${user.id}", "RoleIncluded": "true"},
                );

                Navigator.pop(context); //Closes loading indicator dialog

                if (result.result.isEmpty) {
                } else {
                  UserRole userRole = result.result.single;

                  _userRoleInitialValue = {
                    "canReview": userRole.canReview,
                    "canAskQuestions": userRole.canAskQuestions,
                    "canParticipateInClubs": userRole.canParticipateInClubs,
                    "roleId": "${userRole.roleId}"
                  };

                  _showOverlayForm(context, user);
                }
              } on Exception catch (e) {
                showErrorDialog(context, e);
              }
            },
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title: Text("Delete", style: TextStyle(color: Palette.lightRed)),
            subtitle: Text("Delete permanently",
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
