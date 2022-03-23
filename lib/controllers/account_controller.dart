import 'dart:convert';
import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/data-old/models/call_details/call_details.dart';
import 'package:xchange/data-old/services-old/call_service.dart';

import 'package:rxdart/rxdart.dart' as rx;
import 'package:xchange/data/repository/contact_repository.dart';

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
    log('onInit ${LocalStorage.userDetail.val}');
    if (LocalStorage.userDetail.val.isNotEmpty) {
      final userFromStorage = jsonDecode(LocalStorage.userDetail.val);
      userDetails.value =
          UserDetails.fromJson(userFromStorage as Map<String, dynamic>);
    }
    getFormattedNumber();
    // getRegisteredUserContacts();
    getUserContactv();
    super.onInit();
  }

  getUserContactv() async {
    ContactRepository().loadContacts();
  }

  Future<void> getFormattedNumber() async {
    final p =
        await NumberParser.getNumberDetails(userDetails.value.phoneNumber!);
    log('Paresed Phone Number $p');
    parsedPhoneNumber.value = p['international'];
    log('Parsed Phone Numbersss ${parsedPhoneNumber.value}');
  }

  navigateToChat(UserDetails user) {
    currentChat = user;
    Get.toNamed(Routes.chat,
        arguments: {'match': MatchDetails(users: [], uid: '')});
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

  getNewMessages() {}

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

  Stream<List<dynamic>> combineStream() {
    return rx.CombineLatestStream.list([
      _firestoreService
          .getCurrentlyMatchedUserStream(userDetails.value.currentChatrooms),
      _firestoreService.getUsersDetail(userDetails.value.friendList).map(
          (event) => event
              .map((e) => e.nameInContact = getUserContactName(e.phoneNumber!))
              .toList()),
    ]);
  }

  Stream<QuerySnapshot<CallDetails>> getCallStream() =>
      _callService.listenForCall(userDetails.value.uid);
}
