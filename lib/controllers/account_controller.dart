import 'dart:convert';
import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/barrel.dart';

class AccountController extends GetxController {
  final AuthenticationService _authenticationService = AuthenticationService();
  Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  RxList<UserDetails> usersInChat = <UserDetails>[].obs;
  List<Contact>? userContact;
  UserDetails currentChat = UserDetails();
  final ContactService _contactService = ContactService();
  final FirestoreService _firestoreService = FirestoreService();
  @override
  void onInit() {
    final userFromStorage = jsonDecode(LocalStorage.userDetail.val);
    userDetails.value =
        UserDetails.fromJson(userFromStorage as Map<String, dynamic>);
    getUsersInDatabase();
    getRegisteredUserContacts();
    super.onInit();
  }

  getUsersInDatabase() async {
    final data = await FirebaseFirestore.instance.collection('Users').get();
    if (data.docs.isNotEmpty) {
      usersInChat.value =
          data.docs.map((e) => UserDetails.fromJson(e.data())).toList();
      // log('users in chat: ${usersInChat}');
      usersInChat
          .removeWhere((element) => element.uid == userDetails.value.uid);
    }
  }

  getRegisteredUserContacts() async {
    final userContacts = await _contactService.getContactFromPhone();
    log('user contact: $userContact');
    if (userContacts != null) {
      userContacts.removeWhere((element) => element.phones == null);
      userContact = userContacts;
      final phoneNumbers = userContacts
          .map((e) {
            log('name: ${e.displayName}');
            return e.phones![0].value!.removeAllWhitespace;
          })
          .toList();
      log('phone numbers: $phoneNumbers');
      final result = await _firestoreService.checkUsersInDataBase(phoneNumbers);
      usersInChat.value = [...usersInChat, ...result];
      log('result: $result');
    }
  }

  navigateToChat(UserDetails user) {
    currentChat = user;
    Get.toNamed(Routes.CHAT,
        arguments: {'match': MatchDetails(users: [], isNew: {}, uid: '')});
  }

  logout() async {
    await _authenticationService
        .logout()
        .whenComplete(() => Get.offAllNamed(Routes.LOGIN));
  }
}
