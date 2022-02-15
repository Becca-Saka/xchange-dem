import 'package:xchange/app/barrel.dart';

class ConstDialogs {
  static void showNumberVerificationDialog(
      {required String title,
      String? content,
      required String number,
      Widget? contentReplacement,
      Function()? onPressed,
      String? buttonText}) {
    final isInvalid = title == 'Invalid number';
    Get.defaultDialog(
      title: title,
      radius: 5,
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          .copyWith(top: 20),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ).copyWith(
        top: 10,
      ),
      titleStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            isInvalid
                ? 'The number you specified above is invalid'
                : 'Is the phone number above correct?',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Edit number',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: appColor),
                    )),
                Visibility(visible: !isInvalid, child: const Spacer()),
                Visibility(
                  visible: !isInvalid,
                  child: InkWell(
                      onTap: (){
                        Get.back();
                        onPressed!();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: appColor),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
