import 'package:flutter/material.dart';

import '../utils/colors.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;

  final ValueChanged<int>? onChanged;

  const NumericStepButton({
    Key? key,
    this.minValue = 0,
    this.maxValue = 10,
    this.onChanged,
  }) : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove_rounded,
              color: Palette.lightPurple,
            ),
            iconSize: 32.0,
            color: Palette.lightPurple,
            onPressed: () {
              setState(() {
                if (counter > widget.minValue) {
                  counter--;
                }
                // widget.onChanged(counter);
              });
            },
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5,
              bottom: 5,
            ),
            decoration: BoxDecoration(
                color: Palette.buttonPurple2,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              '$counter',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Palette.lightPurple,
                fontSize: 18.0,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add_rounded,
              color: Palette.lightPurple,
            ),
            iconSize: 32.0,
            color: Palette.lightPurple,
            onPressed: () {
              setState(() {
                if (counter < widget.maxValue) {
                  counter++;
                }
                //widget.onChanged(counter);
              });
            },
          ),
        ],
      ),
    );
  }
}
