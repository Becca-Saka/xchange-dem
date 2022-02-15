import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/ui/shared/custom_navbar.dart';
import 'package:xchange/ui/views/chat/call/call_layout.dart';

import 'group_chats_view.dart';
import 'home_view.dart';
import 'settings_view.dart';

class MainView extends GetView<AccountController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallLayout(
        scaffold: Obx(() => Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                'UniPing',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: getBody(),
            bottomNavigationBar: _buildBottomBar())));
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      selectedIndex: controller.currentIndex.value,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => controller.onIndexChanged(index),
      items: <MyBottomNavBarItem>[
        MyBottomNavBarItem(
          icon: const Icon(Coolicons.group),
          title: const Text('Groups'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        MyBottomNavBarItem(
          icon: const Icon(Coolicons.message_circle),
          title: const Text('Chats'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        MyBottomNavBarItem(
          icon: const Icon(Coolicons.more_horizontal),
          title: const Text(
            'Settings ',
          ),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      GroupChatsView(),
      HomeView(),
      SettingsView(),
    ];
    return IndexedStack(
      index: controller.currentIndex.value,
      children: pages,
    );
  }
}
