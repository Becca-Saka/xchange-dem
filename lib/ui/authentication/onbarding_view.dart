import 'package:xchange/barrel.dart';

class OnboardingView extends GetView<AuthenticationController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
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
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w100)),
                      const Spacer(),
                      authButtons(
                        'Create Account',
                        onTap: () => controller.navigateToPhonePage(true),
                        isButtonEnabled: controller.isButtonEnable.value,
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () => controller.navigateToPhonePage(false),
                        child: Text('Login',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                                color: appColor.withOpacity(0.5))),
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
            ));
          }),
        ),
      ),
    );
  }
}
