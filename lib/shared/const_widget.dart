import 'dart:io';import 'package:xchange/barrel.dart';

//Defining sizes
Widget heightOne() {
  return SizedBox(
    height: MySize.yMargin(1),
  );
}

Widget widthOne() {
  return SizedBox(
    width: MySize.xMargin(1),
  );
}

Widget heightTwo() {
  return SizedBox(
    height: MySize.yMargin(2),
  );
}

Widget widthTwo() {
  return SizedBox(
    width: MySize.xMargin(2),
  );
}

Widget heightMin({double size = 3}) {
  return SizedBox(
    height: MySize.yMargin(size),
  );
}

Widget heightMini({double size = 15}) {
  return SizedBox(height: size);
}
Widget widthMini({double size = 15}) {
  return SizedBox(
    width: size,
  );
}

Widget widthMin({double size = 3}) {
  return SizedBox(
    width: MySize.xMargin(size),
  );
}

Widget customTextField(
    {required hintText,
    required controller,
    TextInputType? textInputType,
    bool isEnabled = true,
    Function()? onTap,
    Function(String)? onSubmitted,
    Function(String)? onChanged,
    bool isLast = false}) {
  return SizedBox(
    height: MySize.yMargin(2.8),
    child: TextFormField(
      maxLines: 1,
      enableInteractiveSelection: isEnabled,
      onTap: isEnabled == false ? onTap : null,
      textInputAction: isLast ? null : TextInputAction.next,
      controller: controller,
      keyboardType: textInputType,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      style: TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle:
              TextStyle(height: 1, letterSpacing: 0.2, color: apptextGrey)),
    ),
  );
}

Widget authButton(String text,
    {Function()? onTap,
    double height = 50.0,
    double fontSize = 17.0,
    bool isButtonEnabled = false,
    bool isFacebook = false}) {
  return Container(
    width: double.infinity,
    height: height,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: isFacebook
              ? Color(0xFF4267B2)
              : (isButtonEnabled ? appRed : appRed.withOpacity(0.5)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onTap,
      child: Text(text,
          style: TextStyle(
              letterSpacing: 1.2,
              color: Colors.white,
              fontFamily: 'League Spartan',
              fontSize: fontSize)),
    ),
  );
}

Widget authButtons(String text,
    {Function()? onTap,
    double height = 50.0,
    double fontSize = 14.0,
    bool isButtonEnabled = false,
    bool isFacebook = false}) {
  return Container(
    width: double.infinity,
    height: height,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: isFacebook
              ? Color(0xFF4267B2)
              : (isButtonEnabled ? appRed : appRed.withOpacity(0.5)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onTap,
      child: Text(text,
          style: TextStyle(
              letterSpacing: 1.2,
              color: Colors.white,
              fontFamily: 'League Spartan',
              fontSize: fontSize)),
    ),
  );
}

Widget appHeader(double deckSize, double peopleSize) {
  return Column(
    children: [
      Text(
        'The Deck',
        style:
            TextStyle(color: appRed, fontFamily: 'Chewy', fontSize: deckSize),
      ),
      heightOne(),
      Text(
        'COLLECT PEOPLE',
        style: TextStyle(
            letterSpacing: 1.5,
            color: Colors.black,
            height: 1,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            fontSize: peopleSize),
      ),
    ],
  );
}

bool useCheckInternet() {
  bool hasInternet = false;

  if (Platform.isAndroid) {
    hasInternet = ConnectionUtil.instance.hasConnection;
  } else {
    hasInternet = true;
  }

  return hasInternet;
}

String personPlaceholder = 'assets/images/person.png';
Widget profilePicture(String? image) {
  return FancyShimmerImage(
    errorWidget: Image.asset(
      personPlaceholder,
      fit: BoxFit.cover,
    ),
    imageUrl: image!,
    boxFit: BoxFit.cover,
  );
}

Widget backButton({Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      height: MySize.xMargin(0.2),
      width: MySize.xMargin(15),
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.contain,
        width: 5,
        height: 2,
      ),
    ),
  );
}
