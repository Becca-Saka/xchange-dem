import 'package:xchange/barrel.dart';

class ContactView extends GetView<AuthenticationController> {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                      backgroundColor: appColor.withOpacity(0.2),
                      child: SvgPicture.asset('assets/images/svg/search.svg',
                          height: 120, width: 120, fit: BoxFit.contain))),
              const SizedBox(height: 60),
              const Text('Address Book Sync',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text(
                  'This app needs access to your contacts to help you connect with friends and family',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100)),
              const Spacer(),
              authButtons(
                'Sync Contacts',
                onTap: controller.requestContactPermission,
                isButtonEnabled: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
