import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/providers/donation_provider.dart';
import 'package:mag_user/providers/payment_intent_provider.dart';
import 'package:mag_user/utils/util.dart';
import 'package:mag_user/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widgets/form_builder_text_field.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final GlobalKey<FormBuilderState> _donationFormKey =
      GlobalKey<FormBuilderState>();
  late final PaymentIntentProvider _paymentIntentProvider;
  late final DonationProvider _donationProvider;

  @override
  void initState() {
    _paymentIntentProvider = context.read<PaymentIntentProvider>();
    _donationProvider = context.read<DonationProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTop(),
        _buildBottom(),
      ],
    );
  }

  Widget _buildTop() {
    return Column(
      children: [
        const Text("Support the developers!", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        FormBuilder(
          key: _donationFormKey,
          child: MyFormBuilderTextField(
            labelText: "Amount",
            name: "amount",
            fillColor: Palette.textFieldPurple.withOpacity(0.5),
            height: 43,
            borderRadius: 50,
            keyboardType: TextInputType.number,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field cannot be empty.";
              } else if (val != "" && !digitsOnly(val)) {
                return "Enter digits only.";
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        GradientButton(
            onPressed: () {
              // Implement donating
            },
            width: 100,
            height: 30,
            gradient: Palette.buttonGradient,
            borderRadius: 50,
            child: const Text("Donate",
                style: TextStyle(fontWeight: FontWeight.w500))),
      ],
    );
  }
}

Widget _buildBottom() {
  return Text("Show all user's donations");
}
