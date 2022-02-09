import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:xchange/barrel.dart';
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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(
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
              Expanded(
                child: Center(
                  child: Text(
                    '${controller.currentChat.name}',
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
              ),
              // InkWell(
              //   onTap: controller.navigateToViewUser,
              //   child: Container(
              //       height: isSmall
              //           ? 24
              //           : isMedium
              //               ? 28
              //               : 30,
              //       width: isSmall
              //           ? 24
              //           : isMedium
              //               ? 28
              //               : 30,
              //       child: ClipRRect(
              //           borderRadius: BorderRadius.circular(50),
              //           child: Hero(
              //               tag: 'picture',
              //               child: profilePicture(
              //                   controller.currentChat.imageUrl)))),
              // ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            //TODO:Fix Height
            Padding(
                padding: EdgeInsets.only(
                  bottom: MySize.yMargin(10),
                ),
                child: StreamBuilder(
                  // initialData: controller.messages,
                  stream: controller.getMessageStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Message>> snapshot) {
                        return Text('${snapshot.data}');
                    // if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    //   controller.updateIsRead();
                    //   return GroupedListView<Message, DateTime>(
                    //    reverse: true,
                    //     elements: snapshot.data!,
                    //     order: GroupedListOrder.DESC,
                    //     floatingHeader: true,
                    //     groupBy: (Message element) => DateTime(
                    //       controller.parseTimeStamp(element.time).year,
                    //       controller.parseTimeStamp(element.time).month,
                    //       controller.parseTimeStamp(element.time).day,
                    //       controller.parseTimeStamp(element.time).year,
                    //       controller.parseTimeStamp(element.time).hour,
                    //     ),
                    //     //  groupSeparatorBuilder: (DateTime element) => Center(
                    //     //     child: Text(
                    //     //   controller.readTimeStampDaysOnly(element.toString()),
                    //     //   style: TextStyle(
                    //     //       fontWeight: FontWeight.w500,
                    //     //       fontFamily: 'Poppins',
                    //     //       color: Colors.black,
                    //     //       fontSize: 11.sp),
                    //     // )),
                    //     groupHeaderBuilder: (Message element) {
                    //       return Center(
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //           child: Text(
                    //             '${controller.readTimeStampDaysOnly(element.time)}',
                    //             style: const TextStyle(
                    //                 fontWeight: FontWeight.w500,
                    //                 fontFamily: 'Poppins',
                    //                 color: Colors.black,
                    //                 fontSize: 11),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     itemComparator: (Message element1, Message element2) =>
                    //         controller.parseTimeStamp(element1.time).compareTo(
                    //             controller.parseTimeStamp(element2.time)),
                    //     itemBuilder: (_, Message element) => Container(
                    //       padding: const EdgeInsets.only(
                    //           left: 14, right: 14, top: 10, bottom: 10),
                    //       child: Align(
                    //         alignment:
                    //             (element.senderId != controller.currentUser.uid
                    //                 ? Alignment.topLeft
                    //                 : Alignment.topRight),
                    //         child: Container(
                    //           margin: EdgeInsets.only(
                    //             left: element.senderId ==
                    //                     controller.currentUser.uid
                    //                 ? MySize.xMargin(25)
                    //                 : MySize.xMargin(5),
                    //             right: element.senderId ==
                    //                     controller.currentUser.uid
                    //                 ? MySize.xMargin(5)
                    //                 : MySize.xMargin(25),
                    //           ),
                    //           child: Column(
                    //             crossAxisAlignment: element.senderId ==
                    //                     controller.currentUser.uid
                    //                 ? CrossAxisAlignment.end
                    //                 : CrossAxisAlignment.start,
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Padding(
                    //                 padding: EdgeInsets.only(
                    //                   left: element.senderId ==
                    //                           controller.currentUser.uid
                    //                       ? MySize.xMargin(3)
                    //                       : 0,
                    //                   right: element.senderId ==
                    //                           controller.currentUser.uid
                    //                       ? MySize.xMargin(3)
                    //                       : 0,
                    //                 ),
                    //                 child: Text(
                    //                   '${DateFormat.Hm().format(controller.parseTimeStamp(element.time))}',
                    //                   textAlign: TextAlign.end,
                    //                   style: TextStyle(
                    //                       fontWeight: FontWeight.w500,
                    //                       fontFamily: 'Poppins',
                    //                       color: Colors.black,
                    //                       fontSize: isLarge
                    //                           ? 18
                    //                           : isSmall
                    //                               ? 8
                    //                               : 10),
                    //                 ),
                    //               ),
                    //               element.isImage!
                    //                   ? GestureDetector(
                    //                       onTap: () {
                    //                         controller
                    //                             .navigateToViewImage(element);
                    //                       },
                    //                       child: Hero(
                    //                         tag: 'image',
                    //                         child: SizedBox(
                    //                             height: MySize.yMargin(25),
                    //                             width: MySize.xMargin(60),
                    //                             child: Image.network(
                    //                               element.imageUrl!,
                    //                               fit: BoxFit.cover,
                    //                             )),
                    //                       ),
                    //                     )
                    //                   : Container(
                    //                       decoration: BoxDecoration(
                    //                         borderRadius:
                    //                             BorderRadius.circular(14),
                    //                         color: (element.senderId ==
                    //                                 controller.currentUser.uid
                    //                             ? appRed
                    //                             : appGrey),
                    //                       ),
                    //                       padding: const EdgeInsets.all(12),
                    //                       child: Text(
                    //                         element.message!,
                    //                         style: TextStyle(
                    //                             color: (element.senderId ==
                    //                                     controller
                    //                                         .currentUser.uid
                    //                                 ? Colors.white
                    //                                 : Colors.black),
                    //                             fontWeight: FontWeight.bold,
                    //                             fontFamily: 'Poppins',
                    //                             fontSize: isLarge
                    //                                 ? 21
                    //                                 : isSmall
                    //                                     ? 12
                    //                                     : 14),
                    //                       ),
                    //                     ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // } else  {
                    //   return SingleChildScrollView(
                    //     child: Center(
                    //       child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             SizedBox(
                    //                 height: MySize.yMargin(60),
                    //                 width: MySize.xMargin(80),
                    //                 child: SvgPicture.asset(
                    //                   'assets/images/nomessage.svg',
                    //                   height: MySize.yMargin(60),
                    //                   width: MySize.xMargin(80),
                    //                   fit: BoxFit.scaleDown,
                    //                 )),
                    //             Text(
                    //               'No messages yet',
                    //               style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: MySize.textSize(4)),
                    //             ),
                    //           ]),
                    //     ),
                    //   );
                    // } 
                  },
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
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
    );
  }
}

// class ChatView extends GetView<ChatController> {
//   ChatView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           elevation: 1,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white,
//           title: Row(
//             children: [
//               IconButton(
//                 onPressed: () async {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                   await Future.delayed(Duration(milliseconds: 120));
//                   controller.goBack();
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_ios_sharp,
//                   color: Colors.black,
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     '${controller.currentChat.name}',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16.sp,
//                         letterSpacing: 0.5,
//                         fontFamily: 'League Spartan',
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: controller.navigateToViewUser,
//                 child: Container(
//                     height: 28.w,
//                     width: 28.w,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: Hero(
//                             tag: 'picture',
//                             child: profilePicture(
//                                 controller.currentChat.imageUrl)))),
//               ),
//             ],
//           ),
//         ),
//         body: Stack(
//           children: <Widget>[
//             Padding(
//                 padding: EdgeInsets.only(
//                   bottom: MySize.yMargin(10.h),
//                 ),
//                 child: StreamBuilder(
//                   stream: controller.chatMessages.stream,
//                   builder: (BuildContext context,
//                       AsyncSnapshot<List<Message>> snapshot) {
//                     if (snapshot.hasData && snapshot.data!.length != 0) {
//                       controller.updateIsRead();
//                       return GroupedListView<Message, DateTime>(
//                         reverse: true,
//                         elements: snapshot.data!,
//                         order: GroupedListOrder.DESC,
//                         floatingHeader: true,
//                         groupBy: (Message element) => DateTime(
//                           controller.parseTimeStamp(element.time).year,
//                           controller.parseTimeStamp(element.time).month,
//                           controller.parseTimeStamp(element.time).day,
//                           controller.parseTimeStamp(element.time).year,
//                           controller.parseTimeStamp(element.time).hour,
//                         ),
//                         //  groupSeparatorBuilder: (DateTime element) => Center(
//                         //     child: Text(
//                         //   controller.readTimeStampDaysOnly(element.toString()),
//                         //   style: TextStyle(
//                         //       fontWeight: FontWeight.w500,
//                         //       fontFamily: 'Poppins',
//                         //       color: Colors.black,
//                         //       fontSize: 11.sp),
//                         // )),
//                         groupHeaderBuilder: (Message element) {
//                           return Center(
//                             child: Text(
//                               '${controller.readTimeStampDaysOnly(element.time)}',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Poppins',
//                                   color: Colors.black,
//                                   fontSize: 11.sp),
//                             ),
//                           );
//                         },
//                         itemComparator: (Message element1, Message element2) =>
//                             controller.parseTimeStamp(element1.time).compareTo(
//                                 controller.parseTimeStamp(element2.time)),
//                         itemBuilder: (_, Message element) => Container(
//                           padding: EdgeInsets.only(
//                               left: 14, right: 14, top: 10, bottom: 10),
//                           child: Align(
//                             alignment:
//                                 (element.senderId != controller.currentUser.uid
//                                     ? Alignment.topLeft
//                                     : Alignment.topRight),
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                 left: element.senderId ==
//                                         controller.currentUser.uid
//                                     ? MySize.xMargin(25.w)
//                                     : MySize.xMargin(5.w),
//                                 right: element.senderId ==
//                                         controller.currentUser.uid
//                                     ? MySize.xMargin(5.w)
//                                     : MySize.xMargin(25.w),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: element.senderId ==
//                                         controller.currentUser.uid
//                                     ? CrossAxisAlignment.end
//                                     : CrossAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                       left: element.senderId ==
//                                               controller.currentUser.uid
//                                           ? MySize.xMargin(3.w)
//                                           : 0,
//                                       right: element.senderId ==
//                                               controller.currentUser.uid
//                                           ? MySize.xMargin(3.w)
//                                           : 0,
//                                     ),
//                                     child: Text(
//                                       '${DateFormat.Hm().format(controller.parseTimeStamp(element.time))}',
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontFamily: 'Poppins',
//                                           color: Colors.black,
//                                           fontSize: 10.sp),
//                                     ),
//                                   ),
//                                   element.isImage!
//                                       ? GestureDetector(
//                                           onTap: () {
//                                             controller
//                                                 .navigateToViewImage(element);
//                                           },
//                                           child: Hero(
//                                             tag: 'image${element.imageUrl}',
//                                             child: SizedBox(
//                                                 height: MySize.yMargin(25.h),
//                                                 width: MySize.xMargin(60.w),
//                                                 child: profilePicture(
//                                                   element.imageUrl!,
//                                                 )),
//                                           ),
//                                         )
//                                       : Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                             color: (element.senderId ==
//                                                     controller.currentUser.uid
//                                                 ? appRed
//                                                 : appGrey),
//                                           ),
//                                           padding: EdgeInsets.all(12),
//                                           child: Text(
//                                             element.message!,
//                                             style: TextStyle(
//                                                 color: (element.senderId ==
//                                                         controller
//                                                             .currentUser.uid
//                                                     ? Colors.white
//                                                     : Colors.black),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: 'Poppins',
//                                                 fontSize: 14.sp),
//                                           ),
//                                         ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     } else if (snapshot.hasData && snapshot.data!.length == 0) {
//                       return SingleChildScrollView(
//                         child: Container(
//                           child: Center(
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                       height: MySize.yMargin(60.h),
//                                       width: MySize.xMargin(80.w),
//                                       child: SvgPicture.asset(
//                                         'assets/images/nomessage.svg',
//                                         height: MySize.yMargin(60.h),
//                                         width: MySize.xMargin(80.w),
//                                         fit: BoxFit.scaleDown,
//                                       )),
//                                   Text(
//                                     'No messages yet',
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 17.sp),
//                                   ),
//                                 ]),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 )),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
//                 height: MySize.yMargin(9.h),
//                 margin: EdgeInsets.symmetric(horizontal: 11),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: appGrey),
//                     )),
//                 child: Row(
//                   children: <Widget>[
//                     InkWell(
//                       onTap: () {
//                         controller.openImageLocationDialog();
//                       },
//                       child: SizedBox(
//                           height: 25.w,
//                           width: 25.w,
//                           child: Image.asset(
//                             'assets/images/Plus.png',
//                             cacheHeight: 25,
//                             cacheWidth: 25,
//                           )),
//                     ),
//                     widthMin(),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: appGrey.withOpacity(0.4),
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 8,
//                           ),
//                           child: TextField(
//                             controller: controller.chat,
//                             autofocus: false,
//                             decoration: InputDecoration(
//                                 hintText: "Write message...",
//                                 hintStyle: TextStyle(color: Colors.black54),
//                                 border: InputBorder.none),
//                           ),
//                         ),
//                       ),
//                     ),
//                     widthMin(),
//                     InkWell(
//                       onTap: controller.sendMessage,
//                       child: SizedBox(
//                           height: 32.w,
//                           width: 32.w,
//                           child: Center(
//                             child: Image.asset(
//                               'assets/images/Send.png',
//                               cacheHeight: 36,
//                               cacheWidth: 36,
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class ChatView extends GetView<ChatController> {
//   ChatView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isSmall = MySize.isSmall(context);
//     bool isMedium = MySize.isMedium(context);
//     bool isLarge = MySize.isLarge(context);
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           elevation: 1,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white,
//           title: Row(
//             children: [
//               IconButton(
//                 onPressed: () async {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                   await Future.delayed(Duration(milliseconds: 120));
//                   controller.goBack();
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_ios_sharp,
//                   color: Colors.black,
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     '${controller.currentChat.name}',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: isSmall
//                             ? 12
//                             : isMedium
//                                 ? 16
//                                 : 18,
//                         letterSpacing: 0.5,
//                         fontFamily: 'League Spartan',
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: controller.navigateToViewUser,
//                 child: Container(
//                     height: isSmall
//                         ? 24
//                         : isMedium
//                             ? 28
//                             : 30,
//                     width: isSmall
//                         ? 24
//                         : isMedium
//                             ? 28
//                             : 30,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: Hero(
//                             tag: 'picture',
//                             child: profilePicture(
//                                 controller.currentChat.imageUrl)))),
//               ),
//             ],
//           ),
//         ),
//         body: Stack(
//           children: <Widget>[
//             //TODO:Fix Height
//             Padding(
//                 padding: EdgeInsets.only(
//                   bottom: MySize.yMargin(10),
//                   //  isLarge
//                   //     ? 120
//                   //     : isSmall
//                   //         ? 40
//                   //         : 70
//                 ),
//                 child: StreamBuilder(
//                   // initialData: controller.messages,
//                   stream: controller.chatMessages.stream,
//                   builder: (BuildContext context,
//                       AsyncSnapshot<List<Message>> snapshot) {
//                     if (snapshot.hasData && snapshot.data!.length != 0) {
//                       controller.updateIsRead();
//                       return GroupedListView<Message, DateTime>(
//                         reverse: true,
//                         elements: snapshot.data!,
//                         order: GroupedListOrder.DESC,
//                         floatingHeader: true,
//                         groupBy: (Message element) => DateTime(
//                           controller.parseTimeStamp(element.time).year,
//                           controller.parseTimeStamp(element.time).month,
//                           controller.parseTimeStamp(element.time).day,
//                           controller.parseTimeStamp(element.time).year,
//                         ),
//                         groupSeparatorBuilder: (DateTime element) => Center(
//                             child: Text(
//                           controller.readTimeStampDaysOnly(element.toString()),
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Poppins',
//                               color: Colors.black,
//                               fontSize: isLarge
//                                   ? 18
//                                   : isSmall
//                                       ? 9
//                                       : 11),
//                         )),
//                         itemComparator: (Message element1, Message element2) =>
//                             controller.parseTimeStamp(element1.time).compareTo(
//                                 controller.parseTimeStamp(element2.time)),
//                         itemBuilder: (_, Message element) => Container(
//                           padding: EdgeInsets.only(
//                               left: 14, right: 14, top: 10, bottom: 10),
//                           child: Align(
//                             alignment:
//                                 (element.senderId != controller.currentUser.uid
//                                     ? Alignment.topLeft
//                                     : Alignment.topRight),
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                 left: element.senderId ==
//                                         controller.currentUser.uid
//                                     ? MySize.xMargin(25)
//                                     : MySize.xMargin(5),
//                                 right: element.senderId ==
//                                         controller.currentUser.uid
//                                     ? MySize.xMargin(5)
//                                     : MySize.xMargin(25),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: element.senderId ==
//                                         controller.currentUser.uid
//                                     ? CrossAxisAlignment.end
//                                     : CrossAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                       left: element.senderId ==
//                                               controller.currentUser.uid
//                                           ? MySize.xMargin(3)
//                                           : 0,
//                                       right: element.senderId ==
//                                               controller.currentUser.uid
//                                           ? MySize.xMargin(3)
//                                           : 0,
//                                     ),
//                                     child: Text(
//                                       '${DateFormat.Hm().format(controller.parseTimeStamp(element.time))}',
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontFamily: 'Poppins',
//                                           color: Colors.black,
//                                           fontSize: isLarge
//                                               ? 18
//                                               : isSmall
//                                                   ? 8
//                                                   : 10),
//                                     ),
//                                   ),
//                                   element.isImage!
//                                       ? GestureDetector(
//                                           onTap: () {
//                                             controller
//                                                 .navigateToViewImage(element);
//                                           },
//                                           child: Hero(
//                                             tag: 'image',
//                                             child: SizedBox(
//                                                 height: MySize.yMargin(25),
//                                                 width: MySize.xMargin(60),
//                                                 child: Image.network(
//                                                   element.imageUrl!,
//                                                   fit: BoxFit.cover,
//                                                 )),
//                                           ),
//                                         )
//                                       : Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                             color: (element.senderId ==
//                                                     controller.currentUser.uid
//                                                 ? appRed
//                                                 : appGrey),
//                                           ),
//                                           padding: EdgeInsets.all(12),
//                                           child: Text(
//                                             element.message!,
//                                             style: TextStyle(
//                                                 color: (element.senderId ==
//                                                         controller
//                                                             .currentUser.uid
//                                                     ? Colors.white
//                                                     : Colors.black),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: 'Poppins',
//                                                 fontSize: isLarge
//                                                     ? 21
//                                                     : isSmall
//                                                         ? 12
//                                                         : 14),
//                                           ),
//                                         ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     } else if (snapshot.hasData && snapshot.data!.length == 0) {
//                       return SingleChildScrollView(
//                         child: Container(
//                           child: Center(
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                       height: MySize.yMargin(60),
//                                       width: MySize.xMargin(80),
//                                       child: SvgPicture.asset(
//                                         'assets/images/nomessage.svg',
//                                         height: MySize.yMargin(60),
//                                         width: MySize.xMargin(80),
//                                         fit: BoxFit.scaleDown,
//                                       )),
//                                   Text(
//                                     'No messages yet',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: MySize.textSize(4)),
//                                   ),
//                                 ]),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 )),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
//                 height: MySize.yMargin(9),
//                 margin: EdgeInsets.symmetric(horizontal: isSmall ? 5 : 11),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: appGrey),
//                     )),
//                 child: Row(
//                   children: <Widget>[
//                     InkWell(
//                       onTap: () {
//                         controller.openImageLocationDialog();
//                       },
//                       child: SizedBox(
//                           height: isSmall
//                               ? 20
//                               : isLarge
//                                   ? 30
//                                   : 25,
//                           width: isSmall
//                               ? 20
//                               : isLarge
//                                   ? 30
//                                   : 25,
//                           child: Image.asset(
//                             'assets/images/Plus.png',
//                             cacheHeight: 25,
//                             cacheWidth: 25,
//                           )),
//                     ),
//                     widthMin(),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: appGrey.withOpacity(0.4),
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 8,
//                           ).copyWith(
//                             top: isSmall ? 10 : 0,
//                             // bottom: 5,
//                           ),
//                           child: TextField(
//                             controller: controller.chat,
//                             autofocus: false,
//                             decoration: InputDecoration(
//                                 hintText: "Write message...",
//                                 hintStyle: TextStyle(color: Colors.black54),
//                                 border: InputBorder.none),
//                           ),
//                         ),
//                       ),
//                     ),
//                     widthMin(),
//                     InkWell(
//                       onTap: controller.sendMessage,
//                       child: SizedBox(
//                           height: isSmall
//                               ? 20
//                               : isLarge
//                                   ? 37
//                                   : 32,
//                           width: isSmall
//                               ? 20
//                               : isLarge
//                                   ? 37
//                                   : 32,
//                           child: Center(
//                             child: Image.asset(
//                               'assets/images/Send.png',
//                               cacheHeight: 36,
//                               cacheWidth: 36,
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
