import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';

class SettingsView extends GetView<AccountController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: SizedBox(
                width: 60,
                height: 600,
                child: profileAvatar(controller.userDetails.value.imageUrl,
                    controller.userDetails.value.userName!,
                    radius: 60),
              ),
              title: Text('Settings',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
              subtitle: Text('${controller.userDetails.value.phoneNumber}',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
              onTap: () {
                // Navigator.pushNamed(context, '/settings');
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  _listItem(
                    Coolicons.user,
                    'Account',
                    () {
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  _listItem(
                    Coolicons.message_circle,
                    'Chat',
                    () {},
                  ),
                  _listItem(
                    Coolicons.sun,
                    'Appearance',
                    () {},
                  ),
                  _listItem(
                    Coolicons.notification,
                    'Notifications',
                    () {},
                  ),
                  _listItem(
                    Icons.security,
                    'Privacy',
                    () {},
                  ),
                  _listItem(
                    Coolicons.folder,
                    'Data',
                    () {},
                  ),
                  _listItem(
                    Coolicons.help_circle_outline,
                    'Help',
                    () {},
                  ),
                  _listItem(
                    Coolicons.mail,
                    'Invite your friends',
                    () {},
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: controller.logout, child: const Text('Logout')),
          ],
        ),
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
}
