import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';

class SettingsView extends GetView<AccountController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: profileAvatar(controller.userDetails.value.imageUrl,
                        controller.userDetails.value.userName!,
                        radius: 60),
                  ),
                  title: Text('${controller.userDetails.value.userName}',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                  subtitle: Text('${controller.parsedPhoneNumber}',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                  onTap: () {
                    // Navigator.pushNamed(context, '/settings');
                  },
                ),
              )),
          Expanded(
            child: ListView(
              children: [
                _listItem(
                  Coolicons.user,
                  'Account',
                  showComingSoonSnackBar,
                ),
                _listItem(
                  Coolicons.message_circle,
                  'Chat',
                  showComingSoonSnackBar,
                ),
                _listItem(
                  Coolicons.sun,
                  'Appearance',
                  showComingSoonSnackBar,
                ),
                _listItem(
                  Coolicons.notification_outline,
                  'Notifications',
                  showComingSoonSnackBar,
                ),
                _listItem(
                  Icons.security_outlined,
                  'Privacy',
                  showComingSoonSnackBar,
                ),
                _listItem(
                  Coolicons.folder,
                  'Data',
                  showComingSoonSnackBar,
                ),
                _listItem(
                  Coolicons.help_circle_outline,
                  'Help',
                  showComingSoonSnackBar,
                ),
                _listItem(
                  Coolicons.mail,
                  'Invite your friends',
                  showComingSoonSnackBar,
                ),
              ],
            ),
          ),
          TextButton(onPressed: controller.logout, child: const Text('Logout')),
        ],
      ),
    );
  }

  ListTile _listItem(IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
    );
  }

  showComingSoonSnackBar() {
   Get.showSnackbar(const GetSnackBar(
     message: 'This feature is coming soon',
      duration: Duration(seconds: 2),
    ))
   ;
  }
}
