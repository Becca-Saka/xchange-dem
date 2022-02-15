import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';

class GroupChatsView extends GetView<AccountController> {
  const GroupChatsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:   Container(
        alignment: Alignment.center,
        child: const Text(
          "Groups",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),      
    );
  }
}