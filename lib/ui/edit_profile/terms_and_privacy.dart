import 'package:xchange/barrel.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class TermsAndPrivacy extends StatefulWidget {
  final String content;
  const TermsAndPrivacy({Key? key, required this.content}) : super(key: key);

  @override
  State<TermsAndPrivacy> createState() => _TermsAndPrivacyState();
}

class _TermsAndPrivacyState extends State<TermsAndPrivacy> {
  bool isPageloaded = false;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('${widget.content}'),
          bottom: !isPageloaded
              ? PreferredSize(
                  preferredSize: Size.fromHeight(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : null),
      // body: WebView(
      //   onPageStarted: (String u) {
      //     setState(() {
      //       isPageloaded = false;
      //     });
      //   },
      //   onPageFinished: (String u) {
      //     setState(() {
      //       isPageloaded = true;
      //     });
      //   },
      //   onProgress: (int p) {
      //     setState(() {
      //       progress = p.toDouble();
      //     });
      //   },
      //   gestureNavigationEnabled: true,
      //   initialUrl: widget.content,
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
