import 'dart:convert';
import 'dart:developer';
import 'package:xchange/barrel.dart';

class AccountController extends GetxController {
  final AuthenticationService _authenticationService = AuthenticationService();
  Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  RxList<UserDetails> usersInChat = <UserDetails>[].obs;

  UserDetails currentChat = UserDetails();

  logout() async {
    await _authenticationService
        .logout()
        .whenComplete(() => Get.offAllNamed(Routes.LOGIN));
  }

  getUsersInDatabase() async {
    final data = await FirebaseFirestore.instance.collection('Users').get();
    if (data.docs.isNotEmpty) {
      usersInChat.value =
          data.docs.map((e) => UserDetails.fromJson(e.data())).toList();
      log('users in chat: ${usersInChat}');
      usersInChat
          .removeWhere((element) => element.uid == userDetails.value.uid);
    }
  }

  @override
  void onInit() {
    final userFromStorage = jsonDecode(LocalStorage.userDetail.val);
    log('user from storage: $userFromStorage');
    userDetails.value =
        UserDetails.fromJson(userFromStorage as Map<String, dynamic>);
    getUsersInDatabase();
    super.onInit();
  }

  navigateToChat(UserDetails user) {
    currentChat = user;
    Get.toNamed(Routes.CHAT, arguments: {
      'match': MatchDetails(users: [], isNew: {}, uid: '')
    });
  }
}
