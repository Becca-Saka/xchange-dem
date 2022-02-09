import 'package:xchange/barrel.dart';
import 'package:xchange/ui/chat/chat_controller.dart';

class ViewUser extends GetView {
  ViewUser({Key? key}) : super(key: key);

  final ChatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isSmall = MySize.isSmall(context);
    bool isMedium = MySize.isMedium(context);
    bool isLarge = MySize.isLarge(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: controller.goBack,
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
        title: Text(
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
        actions: [
          PopupMenuButton(
              icon:
                  Icon(Icons.more_horiz, color: Colors.black), // add this line
              itemBuilder: (_) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        child: Container(
                            width: 100,
                            // height: 30,
                            child: Text(
                              "Block",
                              style: TextStyle(color: Colors.red),
                            )),
                        value: '1'),
                  ],
              onSelected: (index) async {
                controller.showConfirmationDialog();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'picture',
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Obx(() => FancyShimmerImage(
                            imageUrl: controller.currentImage.value,
                            boxFit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
              ),
            // heightMin(size: 5),
            // SizedBox(
            //   height: MySize.yMargin(15),
            //   child: ListView.builder(
            //       itemCount: controller.currentChat.imageList.length,
            //       physics: NeverScrollableScrollPhysics(),
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (BuildContext context, int index) {
            //         final image = controller.currentChat.imageList[index];
            //         return Padding(
            //           padding: EdgeInsets.only(
            //               left: index == 0
            //                   ? 0
            //                   : isSmall
            //                       ? 6
            //                       : 8),
            //           child: InkWell(
            //             onTap: () {
            //               controller.changeImage(image);
            //             },
            //             child: SizedBox(
            //               width: MySize.xMargin(isLarge ? 22 : 19),
            //               height: MySize.yMargin(18),
            //               child: Card(
            //                 elevation: 2,
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(15)),
            //                 child: ClipRRect(
            //                   borderRadius: BorderRadius.circular(15),
            //                   child: FancyShimmerImage(
            //                     imageUrl: image,
            //                     boxFit: BoxFit.cover,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       }),
            // )
          
          ],
        ),
      ),
    );
  }


}
