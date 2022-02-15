import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class NumberParser {
  static final FlutterLibphonenumber _flutterLibphonenumber =
      FlutterLibphonenumber();

  static Future<FormatPhoneResult?> getFormattedNumber(
      String countryCode, String phoneNumber) async {
    final countries = await _flutterLibphonenumber.getAllSupportedRegions();

    CountryWithPhoneCode? countryWithPhoneCode;
    final ff = countries.values
        .where((element) => element.countryCode == countryCode)
        .toList();
    if (ff.isNotEmpty) {
      countryWithPhoneCode = ff.first;
    }
    return await _flutterLibphonenumber.getFormattedParseResult(
      phoneNumber,
      countryWithPhoneCode!,
    );
  }

  static Future<Map<String, dynamic>?> getNumberDetails(String number,
      {String? region}) async {
    var result;
    try {
      await _flutterLibphonenumber.init();
      if (number.startsWith('+')) {
        result = await _flutterLibphonenumber.parse(
          number,
        );
      } else {
        result =
            await _flutterLibphonenumber.parse(number, region: region ?? 'NG');
      }
      // JsonEncoder encoder = const JsonEncoder.withIndent('  ');

      // final parsedData = encoder.convert(result);
      // log('parsed data: $parsedData');
      // log('$result');
    } on PlatformException catch (e) {
      if (e.code == 'InvalidNumber') {
        log('Invalid number: $number');
      }
    }
    return result;
  }
}
