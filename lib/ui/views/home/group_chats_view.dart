import 'package:xchange/app/barrel.dart';
import 'package:xchange/controllers/account_controller.dart';
import 'package:xchange/ui/shared/coming_soon.dart';

class GroupChatsView extends GetView<AccountController> {
  const GroupChatsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComingSoon();
  }
}