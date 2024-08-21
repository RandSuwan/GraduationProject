import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NecklacePage extends StatefulWidget {
  const NecklacePage({super.key});

  @override
  State<NecklacePage> createState() => _NecklacePageState();
}

class _NecklacePageState extends State<NecklacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://lottie.host/b8701adc-a937-49f6-bcd3-3662c41fdf4f/z3Wvn5oOay.json',
            width: 100),
      ),
    );
  }
}
