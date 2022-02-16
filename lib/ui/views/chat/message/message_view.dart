import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/chat_controller.dart';

class MessageView extends GetView<ChatController> {
  const MessageView({Key? key}) : super(key: key);

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
              title: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await Future.delayed(const Duration(milliseconds: 120));
                      controller.goBack();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${controller.currentChat.nameInContact}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    controller.dialVideoCall();
                  },
                  icon: const Icon(Icons.videocam_outlined,
                      color: Colors.black, size: 25),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined,
                      color: Colors.black, size: 25),
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
                Padding(
                    padding: EdgeInsets.only(
                      bottom: MySize.yMargin(10),
                    ),
                    child: controller.matchDetails.value != null
                        ? StreamBuilder(
                            stream: controller.getMessageStream(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Message>> snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                controller.updateIsRead();
                                return GroupedListView<Message, DateTime>(
                                  reverse: true,
                                  elements: snapshot.data!,
                                  order: GroupedListOrder.DESC,
                                  floatingHeader: true,
                                  groupBy: (Message element) => DateTime(
                                    controller
                                        .parseTimeStamp(element.time)
                                        .year,
                                    controller
                                        .parseTimeStamp(element.time)
                                        .month,
                                    controller.parseTimeStamp(element.time).day,
                                    controller
                                        .parseTimeStamp(element.time)
                                        .year,
                                    controller
                                        .parseTimeStamp(element.time)
                                        .hour,
                                  ),
                                  groupHeaderBuilder: (Message element) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          controller.readTimeStampDaysOnly(element.time),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 11),
                                        ),
                                      ),
                                    );
                                  },
                                  itemComparator: (Message element1,
                                          Message element2) =>
                                      controller
                                          .parseTimeStamp(element1.time)
                                          .compareTo(controller
                                              .parseTimeStamp(element2.time)),
                                  itemBuilder: (_, Message element) =>
                                      Container(
                                    padding: const EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
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
                                          crossAxisAlignment:
                                              element.senderId ==
                                                      controller.currentUser.uid
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: element.senderId ==
                                                        controller
                                                            .currentUser.uid
                                                    ? MySize.xMargin(3)
                                                    : 0,
                                                right: element.senderId ==
                                                        controller
                                                            .currentUser.uid
                                                    ? MySize.xMargin(3)
                                                    : 0,
                                              ),
                                              child: Text(
                                                DateFormat.Hm().format(
                                                    controller.parseTimeStamp(
                                                        element.time)),
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
                                                              MySize.yMargin(
                                                                  25),
                                                          width: MySize.xMargin(
                                                              60),
                                                          child: Image.network(
                                                            element.imageUrl!,
                                                            fit: BoxFit.cover,
                                                          )),
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: (element
                                                                  .senderId ==
                                                              controller
                                                                  .currentUser
                                                                  .uid
                                                          ? appColor
                                                          : appGrey),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
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
                                return _buildNoMessageScreen();
                              }
                            },
                          )
                        : _buildNoMessageScreen()),
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
                            child: const Icon(
                              Coolicons.plus,
                              size: 30,
                            )),
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
                            child: Transform.scale(
                              scale: 0.8,
                              child: const Icon(
                                Icons.send,
                                size: 30,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  SingleChildScrollView _buildNoMessageScreen() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MySize.yMargin(60),
                width: MySize.xMargin(80),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/svg/no_message.svg',
                    height: MySize.yMargin(30),
                    width: MySize.xMargin(50),
                    // fit: BoxFit.,
                  ),
                ),
              ),
              Text(
                'No messages yet',
                style: TextStyle(
                    color: Colors.black, fontSize: MySize.textSize(4)),
              ),
            ]),
      ),
    );
  }
}
