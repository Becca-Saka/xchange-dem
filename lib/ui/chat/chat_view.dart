import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/ui/chat/call/call_view.dart';
import 'package:xchange/ui/chat/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmall = MySize.isSmall(context);
    bool isMedium = MySize.isMedium(context);
    bool isLarge = MySize.isLarge(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Obx(
          () => Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 1,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await Future.delayed(const Duration(milliseconds: 120));
                  controller.goBack();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.black,
                ),
              ),
              title: Row(
                children: [
                  profileAvatar(controller.currentChat.imageUrl,
                      controller.currentChat.nameInContact!),
                  const SizedBox(width: 8),
                  Text(
                    '${controller.currentChat.nameInContact}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmall
                            ? 12
                            : isMedium
                                ? 16
                                : 18,
                        letterSpacing: 0.5,
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(JoinChannelVideo());
                  },
                  icon: const Icon(
                    Icons.video_call_rounded,
                    color: Colors.black, size: 30
                  ),
                ),
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(
                    Icons.phone_rounded,
                    color: Colors.black, size: 30
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.black,
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text(
                            'Delete Chat',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: isSmall
                                    ? 12
                                    : isMedium
                                        ? 16
                                        : 18,
                                letterSpacing: 0.5,
                                fontFamily: 'League Spartan',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ];
                    })
              ],
            ),
            body: Stack(
              children: <Widget>[
                //TODO:Fix Height
                Padding(
                    padding: EdgeInsets.only(
                      bottom: MySize.yMargin(10),
                    ),
                    child: controller.matchDetails.value != null
                        ? StreamBuilder(
                            // initialData: controller.messages,
                            stream: controller.getMessageStream(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Message>> snapshot) {
                             
                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                controller.updateIsRead();
                                return GroupedListView<Message, DateTime>(
                                  reverse: true,
                                  elements: snapshot.data!,
                                  order: GroupedListOrder.DESC,
                                  floatingHeader: true,
                                  groupBy: (Message element) => DateTime(
                                    controller.parseTimeStamp(element.time).year,
                                    controller.parseTimeStamp(element.time).month,
                                    controller.parseTimeStamp(element.time).day,
                                    controller.parseTimeStamp(element.time).year,
                                    controller.parseTimeStamp(element.time).hour,
                                  ),
                                  //  groupSeparatorBuilder: (DateTime element) => Center(
                                  //     child: Text(
                                  //   controller.readTimeStampDaysOnly(element.toString()),
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w500,
                                  //       fontFamily: 'Poppins',
                                  //       color: Colors.black,
                                  //       fontSize: 11.sp),
                                  // )),
                                  groupHeaderBuilder: (Message element) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          '${controller.readTimeStampDaysOnly(element.time)}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 11),
                                        ),
                                      ),
                                    );
                                  },
                                  itemComparator:
                                      (Message element1, Message element2) =>
                                          controller
                                              .parseTimeStamp(element1.time)
                                              .compareTo(controller
                                                  .parseTimeStamp(element2.time)),
                                  itemBuilder: (_, Message element) => Container(
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14, top: 10, bottom: 10),
                                    child: Align(
                                      alignment: (element.senderId !=
                                              controller.currentUser.uid
                                          ? Alignment.topLeft
                                          : Alignment.topRight),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: element.senderId ==
                                                  controller.currentUser.uid
                                              ? MySize.xMargin(25)
                                              : MySize.xMargin(5),
                                          right: element.senderId ==
                                                  controller.currentUser.uid
                                              ? MySize.xMargin(5)
                                              : MySize.xMargin(25),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: element.senderId ==
                                                  controller.currentUser.uid
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: element.senderId ==
                                                        controller.currentUser.uid
                                                    ? MySize.xMargin(3)
                                                    : 0,
                                                right: element.senderId ==
                                                        controller.currentUser.uid
                                                    ? MySize.xMargin(3)
                                                    : 0,
                                              ),
                                              child: Text(
                                                '${DateFormat.Hm().format(controller.parseTimeStamp(element.time))}',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: isLarge
                                                        ? 18
                                                        : isSmall
                                                            ? 8
                                                            : 10),
                                              ),
                                            ),
                                            element.isImage!
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .navigateToViewImage(
                                                              element);
                                                    },
                                                    child: Hero(
                                                      tag: 'image',
                                                      child: SizedBox(
                                                          height:
                                                              MySize.yMargin(25),
                                                          width: MySize.xMargin(60),
                                                          child: Image.network(
                                                            element.imageUrl!,
                                                            fit: BoxFit.cover,
                                                          )),
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(14),
                                                      color: (element.senderId ==
                                                              controller
                                                                  .currentUser.uid
                                                          ? appColor
                                                          : appGrey),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(12),
                                                    child: Text(
                                                      element.message!,
                                                      style: TextStyle(
                                                          color: (element
                                                                      .senderId ==
                                                                  controller
                                                                      .currentUser
                                                                      .uid
                                                              ? Colors.white
                                                              : Colors.black),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Poppins',
                                                          fontSize: isLarge
                                                              ? 21
                                                              : isSmall
                                                                  ? 12
                                                                  : 14),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SingleChildScrollView(
                                  child: Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: MySize.yMargin(60),
                                              width: MySize.xMargin(80),
                                              child: SvgPicture.asset(
                                                'assets/images/nomessage.svg',
                                                height: MySize.yMargin(60),
                                                width: MySize.xMargin(80),
                                                fit: BoxFit.scaleDown,
                                              )),
                                          Text(
                                            'No messages yet',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MySize.textSize(4)),
                                          ),
                                        ]),
                                  ),
                                );
                              }
                           
                            },
                          )
                        : SingleChildScrollView(
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: MySize.yMargin(60),
                                        width: MySize.xMargin(80),
                                        child: SvgPicture.asset(
                                          'assets/images/nomessage.svg',
                                          height: MySize.yMargin(60),
                                          width: MySize.xMargin(80),
                                          fit: BoxFit.scaleDown,
                                        )),
                                    Text(
                                      'No messages yet',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MySize.textSize(4)),
                                    ),
                                  ]),
                            ),
                          )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                    height: MySize.yMargin(9),
                    margin: EdgeInsets.symmetric(horizontal: isSmall ? 5 : 11),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: appGrey),
                        )),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            controller.openImageLocationDialog();
                          },
                          child: SizedBox(
                              height: isSmall
                                  ? 20
                                  : isLarge
                                      ? 30
                                      : 25,
                              width: isSmall
                                  ? 20
                                  : isLarge
                                      ? 30
                                      : 25,
                              child: Image.asset(
                                'assets/images/Plus.png',
                                cacheHeight: 25,
                                cacheWidth: 25,
                              )),
                        ),
                        widthMin(),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: appGrey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ).copyWith(
                                top: isSmall ? 10 : 0,
                                // bottom: 5,
                              ),
                              child: TextField(
                                controller: controller.chat,
                                autofocus: false,
                                decoration: const InputDecoration(
                                    hintText: "Write message...",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        widthMin(),
                        InkWell(
                          onTap: controller.sendMessage,
                          child: SizedBox(
                              height: isSmall
                                  ? 20
                                  : isLarge
                                      ? 37
                                      : 32,
                              width: isSmall
                                  ? 20
                                  : isLarge
                                      ? 37
                                      : 32,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/Send.png',
                                  cacheHeight: 36,
                                  cacheWidth: 36,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
