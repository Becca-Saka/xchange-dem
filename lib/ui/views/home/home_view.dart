import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';

class HomeView extends GetView<AccountController> {
  const HomeView({Key? key}) : super(key: key);
  // bool isSmall = false, isMedium = false, isLarge = false;

  @override
  Widget build(BuildContext context) {
    // isSmall = MySize.isSmall(context);
    // isMedium = MySize.isMedium(context);
    // isLarge = MySize.isLarge(context);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Get.toNamed(Routes.contactlist);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: controller.userDetails.value.currentChatrooms.isNotEmpty &&
              controller.userDetails.value.friendList.isNotEmpty
          ? StreamBuilder<List<dynamic>>(
              stream: controller.combineStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Column(
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
                              child: UserListItem(
                                title: user.nameInContact!,
                                subtitle: user.phoneNumber,
                                imageUrl: user.imageUrl,
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
                  );
                }
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              })
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset('assets/images/svg/put_no.svg',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.3),
                ),
                Text('No users in chat',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ],
            ),

      // body: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Obx(
      //       () => controller.usersInChat.isNotEmpty
      // ? Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Container(
      //         height: 50,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: appColor.withOpacity(0.04),
      //         ),
      //         child: TextField(
      //           decoration: InputDecoration(
      //             hintText: 'Search',
      //             hintStyle: const TextStyle(
      //                 fontWeight: FontWeight.w600, fontSize: 14),
      //             prefixIcon: const Icon(Coolicons.search),
      //             enabledBorder: const OutlineInputBorder(
      //               borderSide:
      //                   BorderSide(color: Colors.transparent),
      //             ),
      //             border: OutlineInputBorder(
      //               borderSide: BorderSide(
      //                   color: appColor.withOpacity(0.1)),
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 15,
      //       ),
      //       Expanded(
      //           child: ListView.separated(
      //         itemCount: controller.usersInChat.length,
      //         itemBuilder: (context, index) {
      //           final user = controller.usersInChat[index];
      //           return InkWell(
      //             onTap: () => controller.navigateToChat(user),
      //             child: Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   vertical: 8, horizontal: 10),
      //               child: Row(
      //                 children: [
      //                   ClipRRect(
      //                       borderRadius: BorderRadius.circular(15),
      //                       child: Container(
      //                         width: 50,
      //                         height: 50,
      //                         color: appColor.withOpacity(0.2),
      //                         child: user.imageUrl != null
      //                             ? Image.network(user.imageUrl!,
      //                                 fit: BoxFit.cover)
      //                             : Center(
      //                                 child: Text(user
      //                                     .nameInContact!
      //                                     .substring(0, 1))),
      //                       )),
      //                   const SizedBox(width: 15),
      //                   Column(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     crossAxisAlignment:
      //                         CrossAxisAlignment.start,
      //                     children: [
      //                       Text('${user.nameInContact}',
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.w600,
      //                               fontSize: 16)),
      //                       const SizedBox(height: 10),
      //                       Text('${user.phoneNumber}',
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.w400,
      //                               fontSize: 12)),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //         separatorBuilder: (context, index) => Divider(
      //           color: Colors.grey[200],
      //           thickness: 1,
      //         ),
      //       )),
      //     ],
      //   )
      //           : Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Center(
      //                 child: SvgPicture.asset('assets/images/svg/put_no.svg',
      //                     fit: BoxFit.cover,
      //                     width: MediaQuery.of(context).size.width * 0.4,
      //                     height: MediaQuery.of(context).size.height * 0.3),
      //               ),

      //                   Text('No users in chat',
      //                       style: const TextStyle(
      //                           fontWeight: FontWeight.w600, fontSize: 16)),
      //             ],
      //           ),
      //     ))
    );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem({
    Key? key,
    required this.title,
    this.subtitle,
    this.imageUrl,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 50,
              height: 50,
              color: appColor.withOpacity(0.2),
              child: imageUrl != null
                  ? Image.network(imageUrl!, fit: BoxFit.cover)
                  : Center(child: Text(title.substring(0, 1))),
            )),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            Visibility(
              visible: subtitle != null,
              child: Text('$subtitle',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }
}
