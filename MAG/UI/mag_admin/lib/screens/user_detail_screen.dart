import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/widgets/master_screen.dart';

import '../models/user.dart';

class UserDetailScreen extends StatefulWidget {
  User? user;
  UserDetailScreen({Key? key, this.user}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        child: Text("Username: ${widget.user?.username}"));
  }
}
