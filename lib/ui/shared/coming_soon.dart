import 'package:flutter/material.dart';
import 'package:xchange/app/barrel.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              'assets/images/svg/under_construction.svg',
              semanticsLabel: 'Coming Soon',
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          const SizedBox(height: 35),
          const Text(
            'Coming Soon. Available in the next version',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}