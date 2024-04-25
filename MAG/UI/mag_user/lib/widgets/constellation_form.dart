import 'package:flutter/material.dart';

import '../models/anime.dart';
import '../utils/colors.dart';

class ConstellationForm extends StatefulWidget {
  final Anime anime;
  const ConstellationForm({Key? key, required this.anime}) : super(key: key);

  @override
  State<ConstellationForm> createState() => _ConstellationFormState();
}

class _ConstellationFormState extends State<ConstellationForm> {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text("Add "),
                  Text("${widget.anime.titleEn}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text(" to selected Stars:"),
                ],
              ),
            ],
          ),
        ));
  }
}
