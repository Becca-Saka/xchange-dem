import 'package:xchange/app/barrel.dart';
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
        backgroundColor: Colors.white,
        floatingActionButton:  FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appColor.withOpacity(0.04),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                        prefixIcon: const Icon(Coolicons.search),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: appColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: controller.usersInChat.length,
                    itemBuilder: (context, index) {
                      final user = controller.usersInChat[index];
                      return InkWell(
                        onTap: () => controller.navigateToChat(user),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: appColor.withOpacity(0.2),
                                    child: user.imageUrl != null
                                        ? Image.network(user.imageUrl!,
                                            fit: BoxFit.cover)
                                        : Center(
                                            child: Text(user.nameInContact!
                                                .substring(0, 1))),
                                  )),
                              const SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${user.nameInContact}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  const SizedBox(height: 10),
                                  Text('${user.phoneNumber}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[200],
                      thickness: 1,
                    ),
                  )),
                ],
              ),
            )));
  }
}
