import 'package:xchange/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';

class HomeView extends GetView<AccountController> {
  HomeView({Key? key}) : super(key: key);
  double _aspectRatio = 0.0;
  bool isSmall = false, isMedium = false, isLarge = false;

  @override
  Widget build(BuildContext context) {
    isSmall = MySize.isSmall(context);
    isMedium = MySize.isMedium(context);
    isLarge = MySize.isLarge(context);
    var _crossAxisSpacing = 20;
    var _screenWidth = MySize.xMargin(100);
    var _crossAxisCount = 3;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight =
        MySize.yMargin(isSmall ? 19 : (isMedium ? 19 * 1.1 : 19 * 1.3));
    _aspectRatio = _width / cellHeight;
    var gridViewHeight = (cellHeight * 2) + (_crossAxisSpacing * 1.8);

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    heightMin(),
                    // appHeader(MySize.scaledSize(isSmall, isMedium, 45),
                    //     MySize.scaledSize(isSmall, isMedium, 10)),
                    // heightMin(size: 9),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.usersInChat.length,
                        itemBuilder: (context, index) {
                          final user = controller.usersInChat[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: user.imageUrl != null
                                  ? NetworkImage(user.imageUrl!)
                                  : null,
                              child: user.imageUrl == null
                                  ? Text(user.nameInContact!.substring(0, 1)):null,
                            ),
                            title: Text('${user.nameInContact}'),
                            subtitle: Text('${user.phoneNumber}'),
                            onTap: () => controller.navigateToChat(user),
                          );
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: controller.logout, child: Text('Logout')),
                  ],
                ),
              )),
        ));
  }
}
