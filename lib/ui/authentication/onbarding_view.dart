import 'package:xchange/barrel.dart';

class OnboardingView extends GetView<AuthenticationController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200,
                    width: 200,
                    child: CircleAvatar(
                        backgroundColor: appColor.withOpacity(0.2),
                        child: SvgPicture.asset(
                            'assets/images/svg/search.svg',
                            height: 120,
                            width: 120,
                            fit: BoxFit.contain))),
                const SizedBox(height: 60),
                const Text('Let\'s get started',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 5),
                const Text(
                    'Connect easily with your family and friends over countries',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
                const Spacer(),
                authButtons(
                  'Create Account',
                  onTap: () => controller.navigateToPhonePage(true),
                  isButtonEnabled: true,
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () => controller.navigateToPhonePage(false),
                  child: Text('Login',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          color: appColor.withOpacity(0.5))),
                ),
                const SizedBox(height: 35),
              ],
            ),
        ),
      ),
    );
  }
}
