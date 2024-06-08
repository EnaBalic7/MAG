import 'package:flutter/material.dart';
import 'package:mag_user/providers/club_user_provider.dart';
import 'package:mag_user/widgets/circular_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

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
  final Widget? updateChild;
  final LinearGradient? updateGradient;
  final int userId;
  final int clubId;

  JoinClubButton({
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
    this.updateChild,
    this.updateGradient,
    required this.clubId,
    required this.userId,
  }) : super(key: key);

  @override
  State<JoinClubButton> createState() => _JoinClubButtonState();
}

class _JoinClubButtonState extends State<JoinClubButton> {
  bool _isJoined = false;
  bool _isLoading = true;
  late final ClubUserProvider _clubUserProvider;

  @override
  void initState() {
    super.initState();
    _clubUserProvider = context.read<ClubUserProvider>();

    _checkMembershipStatus();
  }

  void _checkMembershipStatus() async {
    bool isJoined = await checkUserMembership(widget.userId, widget.clubId);
    setState(() {
      _isJoined = isJoined;
      _isLoading = false;
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

    if (_isJoined) {
      await leaveClub(widget.userId, widget.clubId);
    } else {
      await joinClub(widget.userId, widget.clubId);
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
            gradient: _isJoined && widget.updateGradient != null
                ? widget.updateGradient
                : widget.gradient,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            child: _isJoined && widget.updateChild != null
                ? widget.updateChild
                : widget.child,
          ),
        ),
      ),
    );
  }
}
