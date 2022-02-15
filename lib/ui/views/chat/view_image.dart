import 'package:xchange/app/barrel.dart';

class ViewImage extends StatelessWidget {
  const ViewImage(
      {Key? key, required this.url, required this.sentBy, required this.time})
      : super(key: key);
  final String url;
  final String sentBy;
  final String time;

  @override
  Widget build(BuildContext context) {
    bool isLarge = MySize.isLarge(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$sentBy',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isLarge
                      ? 14
                      :  12,
                  letterSpacing: 0.5,
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '$time',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isLarge
                      ? 14
                      :  11,
                  letterSpacing: 0.5,
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
            tag: 'image',
            child: Center(
              child: Image.network(
                url,
                fit: BoxFit.contain,
              ),
            )),
      ),
    );
  }
}

// class ViewImage extends StatelessWidget {
//   const ViewImage(
//       {Key? key, required this.url, required this.sentBy, required this.time})
//       : super(key: key);
//   final String url;
//   final String sentBy;
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     bool isLarge = MySize.isLarge(context);
//     bool isSmall = MySize.isSmall(context);
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         centerTitle: false,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '$sentBy',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12.sp,
//                   letterSpacing: 0.5,
//                   fontFamily: 'League Spartan',
//                   fontWeight: FontWeight.w500),
//             ),
//             Text(
//               '$time',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 11.sp,
//                   letterSpacing: 0.5,
//                   fontFamily: 'League Spartan',
//                   fontWeight: FontWeight.w400),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Hero(
//             tag: 'image$url',
//             child: Center(
//               child: Image.network(
//                 url,
//                 fit: BoxFit.contain,
//               ),
//             )),
//       ),
//     );
//   }
// }

// class ViewImage extends StatelessWidget {
//   const ViewImage(
//       {Key? key, required this.url, required this.sentBy, required this.time})
//       : super(key: key);
//   final String url;
//   final String sentBy;
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     bool isLarge = MySize.isLarge(context);
//     bool isSmall = MySize.isSmall(context);
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '$sentBy',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: isLarge
//                       ? 14
//                       : isSmall
//                           ? 8
//                           : 12,
//                   letterSpacing: 0.5,
//                   fontFamily: 'League Spartan',
//                   fontWeight: FontWeight.w500),
//             ),
//             Text(
//               '$time',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: isLarge
//                       ? 14
//                       : isSmall
//                           ? 6
//                           : 11,
//                   letterSpacing: 0.5,
//                   fontFamily: 'League Spartan',
//                   fontWeight: FontWeight.w400),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Hero(
//             tag: 'image',
//             child: Center(
//               child: Image.network(
//                 url,
//                 fit: BoxFit.contain,
//               ),
//             )),
//       ),
//     );
//   }
// }
