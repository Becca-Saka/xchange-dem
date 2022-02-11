import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';

class HomeView extends GetView<AccountController> {
  HomeView({Key? key}) : super(key: key);
  bool isSmall = false, isMedium = false, isLarge = false;

  @override
  Widget build(BuildContext context) {
    isSmall = MySize.isSmall(context);
    isMedium = MySize.isMedium(context);
    isLarge = MySize.isLarge(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: profileAvatar(controller.userDetails.value.imageUrl,
                controller.userDetails.value.userName!),
          ),
          title: const Text(
            'Xchange',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Navigator.pushNamed(context, '/notifications');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.usersInChat.length,
                        itemBuilder: (context, index) {
                          final user = controller.usersInChat[index];
                          return ListTile(
                            leading: profileAvatar(
                                user.imageUrl, user.nameInContact!),
                            title: Text('${user.nameInContact}'),
                            subtitle: Text('${user.phoneNumber}'),
                            onTap: () => controller.navigateToChat(user),
                          );
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: controller.logout, child: const Text('Logout')),
                  ],
                ),
              )),
        ));
  }
}
