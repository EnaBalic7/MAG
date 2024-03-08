import 'package:flutter/material.dart';
import 'package:mag_user/widgets/numeric_step_button.dart';

import '../utils/colors.dart';

class NebulaForm extends StatefulWidget {
  const NebulaForm({Key? key}) : super(key: key);

  @override
  State<NebulaForm> createState() => _NebulaFormState();
}

class _NebulaFormState extends State<NebulaForm> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
        child: const NumericStepButton(
          minValue: 0,
          maxValue: 1000,
        ),
      ),
    );
  }
}
