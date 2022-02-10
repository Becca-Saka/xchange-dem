import 'dart:developer';
import 'dart:io';
import 'package:xchange/barrel.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:xchange/controllers/account_controller.dart';

class FirestoreService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final messagecollection = FirebaseFirestore.instance.collection("Messages");
  final firestoreInstance = FirebaseFirestore.instance;
  final usercollection = FirebaseFirestore.instance.collection("Users");
  final deckcollection = FirebaseFirestore.instance.collection("Decks");

  Future<void> removeMatch(
      UserDetails removeUser, MatchDetails matchDetails) async {
    //TODO remove match from user
    // final AuthController _controller = Get.find();
    // final currentUser = _controller.currentUser.value;
    // removeUser.currentMatches!.remove(currentUser.uid!);
    // removeUser.currentDeck!.remove(matchDetails.uid);
    // removeUser.noOfCurrentMatches = removeUser.currentDeck!.length;

    // currentUser.currentMatches!.remove(removeUser.uid!);
    // currentUser.currentDeck!.remove(matchDetails.uid);
    // currentUser.noOfCurrentMatches = currentUser.currentDeck!.length;
    // await FirebaseFirestore.instance.runTransaction(
    //   (transaction) async {
    //     transaction
    //         .update(usercollection.doc(currentUser.uid), currentUser.toJson())
    //         .update(usercollection.doc(removeUser.uid), removeUser.toJson());
    //   },
    // );
    // HttpsCallable callable =
    //     FirebaseFunctions.instance.httpsCallable('recursiveDeleteDeck');
    // await callable.call({'path': 'Decks/${matchDetails.uid}'});
  }

  Future updateIsNew(MatchDetails matchDetails) async {
    final AuthController _controller = Get.find();
    matchDetails.isNew![_controller.currentUser.value.uid!] = false;
    await deckcollection.doc(matchDetails.uid).update({
      'isNew': matchDetails.isNew,
    });
  }

  Future<List<MatchDetails>> getCurrentlyMatchedUser() async {
    final AuthController _controller = Get.find();
    return await deckcollection
        .where('uid', whereIn: _controller.currentUser.value.currentDeck)
        .get()
        .then((value) =>
            value.docs.map((e) => MatchDetails.fromJson(e.data())).toList());
  }

  Stream<List<MatchDetails>> getCurrentlyMatchedUserStream() {
    final AuthController _controller = Get.find();
    final currentDeck = _controller.currentUser.value.currentDeck ??
        AppRepo.currentUser.currentDeck;
    return deckcollection
        .where('uid', whereIn: currentDeck)
        .snapshots()
        .map((event) => event.docs.map((e) {
              final json = e.data();
              final MatchDetails match = MatchDetails(
                uid: json['uid'] as String,
                isNew: Map<String, bool>.from(json['isNew'] as Map),
                messageId: json['messageId'] as String?,
                timeMatched: json['timeMatched'],
                users: (json['users'] as List<dynamic>)
                    .map((e) => e as String)
                    .toList(),
                recentMessageTime: json['recentMessageTime'],
                unReadMessagesList:
                    (json['${_controller.currentUser.value.uid}Unread']
                            as List<dynamic>?)
                        ?.map((e) => e as String)
                        .toList(),
                recentmessage: json['recentmessage'] as String?,
              );
              return match;
            }).toList());
  }

  Stream<List<UserDetails>> getUsersDetail() {
    final AuthController _controller = Get.find();
    final currentMatches = _controller.currentUser.value.currentMatches ??
        AppRepo.currentUser.currentMatches;
    return usercollection.where('uid', whereIn: currentMatches).snapshots().map(
        (event) =>
            event.docs.map((e) => UserDetails.fromJson(e.data())).toList());
  }

  Future<List<UserDetails>> getUsersSingleDetail(List<String> userIds) async {
    final user = await usercollection.where('uid', whereIn: userIds).get();
    return user.docs.map((e) => UserDetails.fromJson(e.data())).toList();
  }

  Future<String> saveChatImage(String path, String id) async {
    storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child('Decks')
        .child(id)
        .child('Chats')
        .child('${Timestamp.now().microsecondsSinceEpoch}');

    final storage.UploadTask uploadTask = storageReference.putFile(File(path));
    final storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

  Future<void> updateReadMessage(String uid) async {
    final AuthController _controller = Get.find();
    final currentUser = _controller.currentUser.value;
    await deckcollection.doc(uid).update(
      {
        '${currentUser.uid}Unread': [],
        'isRead': true,
        'unReadCount': 0,
      },
    );
  }

  Future<MatchDetails> createChat(String id, UserDetails current) async {
    final doc = deckcollection.doc();

    final message = MatchDetails(
      uid: doc.id,
      users: [current.uid!, id],
    );

    current.currentDeck!.add(doc.id);
    await doc
        .set(
          message.toJson(),
        )
        .whenComplete(() async => await usercollection.doc(current.uid).update(
              {'currentDeck': FieldValue.arrayUnion(current.currentDeck!)},
            ).whenComplete(() async => await usercollection.doc(id).update(
                  {
                    'currentDeck': FieldValue.arrayUnion([doc.id])
                  },
                )));

    return message;
  }

  Future<MatchDetails> sendMessage(
      String message, MatchDetails? chatDetails, UserDetails userToMessage,
      {bool hasImage = false, String? imagePath}) async {
    final AccountController _controller = Get.find();
    final currentUser = _controller.userDetails.value;
    MatchDetails matchDetails;
    String key;
    if (chatDetails == null) {
      matchDetails = await createChat(userToMessage.uid!, currentUser);
      key = matchDetails.uid!;
    } else {
      key = chatDetails.uid!;
      matchDetails = chatDetails;
    }

    var docs = deckcollection.doc(key);
    final chatDoc = docs.collection('Chats').doc();

    final messageDetail = Message(
        uid: chatDoc.id,
        senderId: currentUser.uid,
        message: message,
        isImage: hasImage,
        time: FieldValue.serverTimestamp());
    if (hasImage) {
      messageDetail.imageUrl = await saveChatImage(imagePath!, chatDoc.id);
    }
    log('messageDetail: ${matchDetails.messageId} currentUser: ${currentUser.uid}');
    final otherUser =
        matchDetails.users!.firstWhere((element) => element != currentUser.uid);
    log('currrent to send $otherUser ${currentUser.uid}');
    final chatDetailsJson = {
      'messageId': currentUser.uid,
      'recentmessage': message,
      'recentMessageTime': FieldValue.serverTimestamp(),
      '$otherUser\Unread': FieldValue.arrayUnion([
        chatDoc.id,
      ]),
    };

    await chatDoc
        .set(messageDetail.toJson())
        .whenComplete(() async => await docs.update(
              chatDetailsJson,
            ));
    //TODO: Send message notification
    // .whenComplete(() {
    // if (userToMessage.recieveMessageNotification == true &&
    //     userToMessage.recieveMessageNotification) {
    //   HttpsCallable callable =
    //       FirebaseFunctions.instance.httpsCallable('sendNewMessageAlert');
    //   callable.call({
    //     'path': userToMessage.fcmToken,
    //     'name': userToMessage.name,
    //   });
    // }
    //   return;
    // });

    return matchDetails;
  }

  Stream<List<Message>> getMessage(String uid) {
    return deckcollection
        .doc(uid)
        .collection('Chats')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromJson(e.data())).toList())
        .asBroadcastStream();
  }

  Future<List<Message>> getFirstMessage(String uid) async {
    final mes = await deckcollection.doc(uid).collection('Chats').get();
    return mes.docs.map((e) => Message.fromJson(e.data())).toList();
  }

  Future<void> blockUser(
      UserDetails removeUser, MatchDetails matchDetails) async {
    //TODO: block user
    // final AuthController _controller = Get.find();

    // _controller.currentUser.value.blockedUsers.add(removeUser.uid!);
    // await removeMatch(removeUser, matchDetails);
  }

  Future<List<UserDetails>> checkUsersInDataBase(List<String> phone) async {
    final user =
        await usercollection.where('phoneNumber', whereIn: phone).get();
    return user.docs.map((e) {
      final users =UserDetails.fromJson(e.data());
      users.inContact = true;
      return users;
    }).toList();
  }
}
