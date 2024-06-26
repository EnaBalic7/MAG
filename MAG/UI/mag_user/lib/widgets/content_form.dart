import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/providers/comment_provider.dart';
import 'package:mag_user/providers/post_provider.dart';
import 'package:mag_user/widgets/form_builder_text_field.dart';
import 'package:mag_user/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

import '../models/club.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../utils/colors.dart';
import '../utils/util.dart';

class ContentForm extends StatefulWidget {
  final Post? post;
  final Club? club;
  const ContentForm({Key? key, this.post, this.club})
      : assert(post != null || club != null,
            "Either post or club must be provided."),
        assert(!(post != null && club != null),
            "Only one of post or club can be provided."),
        super(key: key);

  @override
  State<ContentForm> createState() => _ContentFormState();
}

class _ContentFormState extends State<ContentForm> {
  final GlobalKey<FormBuilderState> _contentFormKey =
      GlobalKey<FormBuilderState>();
  late final CommentProvider _commentProvider;
  late final PostProvider _postProvider;

  @override
  void initState() {
    _commentProvider = context.read<CommentProvider>();
    _postProvider = context.read<PostProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(17),
      alignment: Alignment.center,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Palette.darkPurple,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Palette.lightPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: FormBuilder(
          key: _contentFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (widget.club != null)
                    ? const Text("Write your post:")
                    : const Text("Write your comment:"),
                const SizedBox(height: 10),
                MyFormBuilderTextField(
                  name: "content",
                  minLines: 5,
                  fillColor: Palette.textFieldPurple.withOpacity(0.3),
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.multiline,
                  borderRadius: 15,
                  errorBorderRadius: 15,
                  validator: (val) {
                    return _buildValidator(val);
                  },
                ),
                const SizedBox(height: 10),
                GradientButton(
                  onPressed: () async {
                    if (_contentFormKey.currentState?.saveAndValidate() ==
                        true) {
                      var content = _contentFormKey
                          .currentState?.fields["content"]?.value;

                      try {
                        if (widget.club != null) {
                          var post = {
                            "clubId": widget.club!.id,
                            "userId": LoggedUser.user!.id,
                            "content": content,
                            "likesCount": 0,
                            "dislikesCount": 0,
                            "datePosted": DateTime.now().toIso8601String(),
                          };

                          await _postProvider.insert(post);
                        } else {
                          var comment = {
                            "postId": widget.post!.id,
                            "userId": LoggedUser.user!.id,
                            "content": content,
                            "likesCount": 0,
                            "dislikesCount": 0,
                            "dateCommented": DateTime.now().toIso8601String(),
                          };

                          await _commentProvider.insert(comment);
                        }
                      } on Exception catch (e) {
                        showErrorDialog(context, e);
                      }

                      Navigator.of(context).pop();
                    }
                  },
                  width: 80,
                  height: 28,
                  borderRadius: 50,
                  gradient: Palette.buttonGradient,
                  child: const Text("Submit",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _buildValidator(String? val) {
    if (val != null && val.isNotEmpty && !isValidReviewText(val)) {
      return "Some special characters are not allowed.";
    } else if (val != null && val.isNotEmpty && val.length > 500) {
      return "Exceeded character limit: ${val.length}/500";
    }
    return null;
  }
}