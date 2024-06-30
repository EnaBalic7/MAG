import 'package:flutter/material.dart';
import 'package:mag_user/providers/club_provider.dart';
import 'package:mag_user/providers/club_user_provider.dart';
import 'package:mag_user/widgets/circular_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../utils/util.dart';

class JoinClubButton extends StatefulWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final LinearGradient? gradient;
  final Widget? child;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingBottom;
  final double? contentPaddingLeft;
  final double? contentPaddingRight;
  final double? contentPaddingTop;
  final double? contentPaddingBottom;
  final bool? hideBorder;
  final int userId;
  final int clubId;

  const JoinClubButton({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.gradient,
    this.child,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.contentPaddingLeft,
    this.contentPaddingRight,
    this.contentPaddingTop,
    this.contentPaddingBottom,
    this.hideBorder = false,
    required this.clubId,
    required this.userId,
  }) : super(key: key);

  @override
  State<JoinClubButton> createState() => _JoinClubButtonState();
}

class _JoinClubButtonState extends State<JoinClubButton> {
  bool _isJoined = false;
  bool _isLoading = true;
  bool _isOwner = false;
  late final ClubUserProvider _clubUserProvider;
  late final ClubProvider _clubProvider;

  @override
  void initState() {
    super.initState();
    _clubUserProvider = context.read<ClubUserProvider>();
    _clubProvider = context.read<ClubProvider>();

    _checkMembershipStatus();
    _checkOwnershipStatus();
  }

  void _checkOwnershipStatus() async {
    bool isOwner = await checkUserOwnership(widget.userId, widget.clubId);
    setState(() {
      _isOwner = isOwner;
      _isLoading = false;
    });
  }

  Future<bool> checkUserOwnership(int userId, int clubId) async {
    var club = await _clubProvider.get(filter: {"ClubId": "$clubId"});

    if (club.count == 1 && club.result.single.ownerId == userId) {
      return true;
    }

    return false;
  }

  void _checkMembershipStatus() async {
    bool isJoined = await checkUserMembership(widget.userId, widget.clubId);
    setState(() {
      _isJoined = isJoined;
    });
  }

  Future<bool> checkUserMembership(int userId, int clubId) async {
    var clubUserObj = await _clubUserProvider
        .get(filter: {"UserId": "$userId", "ClubId": "$clubId"});

    if (clubUserObj.count == 1) {
      return true;
    }

    return false;
  }

  void _handleButtonPress() async {
    setState(() {
      _isLoading = true;
    });

    if (_isJoined == true && _isOwner == false) {
      await leaveClub(widget.userId, widget.clubId);
    } else if (_isJoined == false) {
      await joinClub(widget.userId, widget.clubId);
    } else if (_isJoined == true && _isOwner == true) {
      showConfirmationDialog(
          context,
          const Icon(Icons.warning_rounded, color: Palette.lightRed, size: 55),
          const Text(
            "Are you sure you want to delete your club, all its posts and comments?",
            textAlign: TextAlign.center,
          ), () async {
        try {
          await _clubProvider.delete(widget.clubId);
        } on Exception catch (e) {
          showErrorDialog(context, e);
        }
      });
    }

    setState(() {
      _isJoined = !_isJoined;
      _isLoading = false;
    });
  }

  Future<void> joinClub(int userId, int clubId) async {
    var clubUserInsert = {
      "clubId": clubId,
      "userId": userId,
    };
    await _clubUserProvider.insert(clubUserInsert);
  }

  Future<void> leaveClub(int userId, int clubId) async {
    var clubUserObj = await _clubUserProvider
        .get(filter: {"UserId": "$userId", "ClubId": "$clubId"});

    if (clubUserObj.count == 1) {
      await _clubUserProvider.delete(clubUserObj.result[0].id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.only(
          left: widget.paddingLeft!,
          right: widget.paddingRight!,
          top: widget.paddingTop!,
          bottom: widget.paddingBottom!,
        ),
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(widget.width!, widget.height!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            ),
          ),
          child: const MyProgressIndicator(
            width: 10,
            height: 10,
            strokeWidth: 2,
            color: Palette.white,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: widget.paddingLeft!,
        right: widget.paddingRight!,
        top: widget.paddingTop!,
        bottom: widget.paddingBottom!,
      ),
      child: ElevatedButton(
        onPressed: _handleButtonPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(widget.width!, widget.height!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            border: (widget.hideBorder == false)
                ? Border.all(color: Palette.lightPurple.withOpacity(0.3))
                : null,
            gradient: _buildGradient(),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            child: _buildChild(),
          ),
        ),
      ),
    );
  }

  Widget? _buildChild() {
    if (_isJoined == true && _isOwner == false) {
      return const Text("Joined",
          style: TextStyle(fontWeight: FontWeight.w500));
    } else if (_isOwner == true) {
      return const Text("Delete",
          style: TextStyle(fontWeight: FontWeight.w500));
    } else {
      return widget.child;
    }
  }

  LinearGradient? _buildGradient() {
    if (_isJoined == true && _isOwner == false) {
      return Palette.navGradient2;
    } else if (_isOwner == true) {
      return Palette.redGradient;
    } else {
      return widget.gradient;
    }
  }
}
