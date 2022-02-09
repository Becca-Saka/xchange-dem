import 'package:xchange/barrel.dart';

class StartUp extends StatefulWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  bool isUserLoggedIn = false;

  checkLogin() async {
    final isLoggedIn = await AuthenticationService().checkLogin();
    if (isLoggedIn) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Image.asset('assets/images/Splash.png'),
        ),
      ),
    );
  }
}
