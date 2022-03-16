import 'dart:developer';
import 'dart:io';
import 'package:xchange/app/barrel.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:xchange/controllers/account_controller.dart';

class FirestoreService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final messagecollection = FirebaseFirestore.instance.collection("Messages");
  final firestoreInstance = FirebaseFirestore.instance;
  final usercollection = FirebaseFirestore.instance.collection("Users");
  final privateChatCollection =
      FirebaseFirestore.instance.collection("Private Chatroom");
  final publicChatcollection =
      FirebaseFirestore.instance.collection("Public Chatroom");

  // Future<List<MatchDetails>> getCurrentlyMatchedUser() async {
  //   // final AuthController _controller = Get.find();
  //   return await privateChatCollection
  //       .where('uid', whereIn: ['_controller.currentUser.value.currentChatrooms'])
  //       .get()
  //       .then((value) =>
  //           value.docs.map((e) => MatchDetails.fromJson(e.data())).toList());
  // }

  Stream<List<MatchDetails>> getCurrentlyMatchedUserStream(
      List<String> currentChatrooms) {
    
    return privateChatCollection
        .where('uid', whereIn: currentChatrooms)
        .snapshots()
        .map((event) => event.docChanges.map((e) {
              final json = e.doc.data()!;
              final MatchDetails match = MatchDetails(
                uid: json['uid'] as String,
                messageId: json['messageId'] as String?,
                users: (json['users'] as List<dynamic>)
                    .map((e) => e as String)
                    .toList(),
                recentMessageTime: json['recentMessageTime'],
                unReadMessagesList:
                    (json['{_controller.currentUser.value.uid}Unread']
                            as List<dynamic>?)
                        ?.map((e) => e as String)
                        .toList(),
                recentmessage: json['recentmessage'] as String?,
              );
              return match;
            }).toList());
  }

  Stream<List<UserDetails>> getUsersDetail(List<String> friendList) {
    
    return usercollection.where('uid', whereIn: friendList).snapshots().map(
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
        .child('Chatrooms/$id/${Timestamp.now().microsecondsSinceEpoch}');

    final storage.UploadTask uploadTask = storageReference.putFile(File(path));
    final storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

  Future<void> updateReadMessage(String uid, String userid) async {
    // final AuthController _controller = Get.find();
    // final currentUser = _controller.currentUser.value;
    await privateChatCollection.doc(uid).update(
      {
        '${userid}Unread': [],
        'isRead': true,
        'unReadCount': 0,
      },
    );
  }

  Future<MatchDetails> createChat(String id, UserDetails current) async {
    final doc = privateChatCollection.doc();

    final message = MatchDetails(
      uid: doc.id,
      users: [current.uid!, id],
    );

    current.currentChatrooms.add(doc.id);
    await doc
        .set(
          message.toJson(),
        )
        .whenComplete(() async => await usercollection.doc(current.uid).update(
              {
                'currentChatrooms':
                    FieldValue.arrayUnion(current.currentChatrooms)
              },
            ).whenComplete(() async => await usercollection.doc(id).update(
                  {
                    'currentChatrooms': FieldValue.arrayUnion([doc.id])
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

    var docs = privateChatCollection.doc(key);
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
      '${otherUser}Unread': FieldValue.arrayUnion([
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
    return privateChatCollection
        .doc(uid)
        .collection('Chats')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromJson(e.data())).toList())
        .asBroadcastStream();
  }

  Future<List<Message>> getFirstMessage(String uid) async {
    final mes = await privateChatCollection.doc(uid).collection('Chats').get();
    return mes.docs.map((e) => Message.fromJson(e.data())).toList();
  }

  Stream<List<Message>> getNewChatroom(String uid) {
    return privateChatCollection
        .where('users', arrayContains: uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromJson(e.data())).toList())
        .asBroadcastStream();
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
      final users = UserDetails.fromJson(e.data());
      users.inContact = true;
      return users;
    }).toList();
  }
}
