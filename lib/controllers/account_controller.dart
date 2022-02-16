import 'dart:convert';
import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/data/models/call_details/call_details.dart';
import 'package:xchange/data/services/call_service.dart';

class AccountController extends GetxController {
  final AuthenticationService _authenticationService = AuthenticationService();
  Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  RxList<UserDetails> usersInChat = <UserDetails>[].obs;
  List<Contact>? userContact;
  UserDetails currentChat = UserDetails();
  final ContactService _contactService = ContactService();
  final FirestoreService _firestoreService = FirestoreService();
  RxInt currentIndex = 1.obs;
  RxString parsedPhoneNumber = ''.obs;
  final CallService _callService = CallService();
  @override
  void onInit() {
    final userFromStorage = jsonDecode(LocalStorage.userDetail.val);
    userDetails.value =
        UserDetails.fromJson(userFromStorage as Map<String, dynamic>);
    getFormattedNumber();
    getRegisteredUserContacts();
    super.onInit();
  }

  Future<void> getFormattedNumber() async {
    final p =
        await NumberParser.getNumberDetails(userDetails.value.phoneNumber!);
    log('Paresed Phone Number $p');
    parsedPhoneNumber.value = p!['international'];
    log('Parsed Phone Numbersss ${parsedPhoneNumber.value}');
  }

  navigateToChat(UserDetails user) {
    currentChat = user;
    Get.toNamed(Routes.CHAT,
        arguments: {'match': MatchDetails(users: [], isNew: {}, uid: '')});
  }

  logout() async {
    await _authenticationService.logout();
  }

  Future<void> getRegisteredUserContacts() async {
    final phoneNumbers = await _contactService.getContactNumbers();
    if (phoneNumbers.isNotEmpty) {
      final result = await _firestoreService.checkUsersInDataBase(phoneNumbers);
      result.removeWhere((element) => element.uid == userDetails.value.uid);
      result.map((e) {
        e.nameInContact = getUserContactName(e.phoneNumber!);
      }).toList();
      usersInChat.value = [...usersInChat, ...result];
    }
  }

  String getUserContactName(String phoneNumber) {
    if (_contactService.userContacts != null) {
      final contactName = _contactService.mappedUserContacts
          .where((element) => phoneNumber == element['number'])
          .toList();
      if (contactName.isNotEmpty) {
        return contactName.first['name'];
      }
      return phoneNumber;
    } else {
      return phoneNumber;
    }
  }

  onIndexChanged(int index) {
    currentIndex.value = index;
  }

  @override
  onClose() {
    _callService.stopAgora();
    super.onClose();
  }

  Stream<QuerySnapshot<CallDetails>> getCallStream() =>
      _callService.listenForCall(userDetails.value.uid);
}
