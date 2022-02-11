import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xchange/barrel.dart';
import 'package:xchange/services/local_storage_service.dart';
import 'package:xchange/services/location_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetStorage box = GetStorage();
  Future<void> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      showLoadingDialogWithText(msg: 'Signing up,');

      User? user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        // final url = await saveProfileImage(path, user.uid);

        // log('$url');
        //TODO: save user profile image

        await saveUserData(
          email,
          name,
          user.uid,
        );
        await getUserData();
        Get.close(1);
      }
    } on FirebaseAuthException catch (e) {
      Get.close(1);
      log('$e');
      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
    } catch (e) {
      Get.close(1);
      print(e);
    }
  }

  Future<void> saveUserData(
    String email,
    String name,
    String userId,
  ) async {
    UserDetails userDetails = UserDetails(
      email: email,
      userName: name,
      currentMatches: [],
      currentDeck: [],
      lat: null,
      long: null,
      uid: userId,
    );

    await firestore
        .collection("Users")
        .doc(userDetails.uid)
        .set(userDetails.toJson());
  }

  Future<void> getUserData() async {
    final uid = auth.currentUser!.uid;
    final userDetails = await firestore.collection("Users").doc(uid).get();
    LocalStorage.userDetail.val = jsonEncode(userDetails.data());
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingDialogWithText(msg: 'Logging in,');
      User? user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        await getUserData();
        Get.close(1);
        Get.offNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      Get.close(1);
      log('$e');

      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
    }
  }

  Future<bool> checkLogin() async {
    bool isLoggedIn = false;
    try {
      await auth.currentUser!.reload();
      User? user = auth.currentUser;
      if (user != null) {
        isLoggedIn = true;
        await getUserData();
        log('user is logged in');
      } else {
        isLoggedIn = false;
      }
    } catch (e) {
      log(' ERROR $e');
      isLoggedIn = false;
    }
    return isLoggedIn;
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingDialogWithText(msg: 'Sending Passord reset link');

      await auth.sendPasswordResetEmail(email: email);
      Get.close(1);
      successSnackbar(
          msg: 'Check your email for reset password link',
          title: 'Password Reset Email sent');
    } on FirebaseAuthException catch (e) {
      Get.close(1);
      log('$e');
      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
    } catch (e) {
      Get.close(1);
      print(e);
    }
  }

  Future<String> saveProfileImage(String path, String id) async {
    storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child('User\'s')
        .child(id)
        .child('${Timestamp.now().microsecondsSinceEpoch}');

    final storage.UploadTask uploadTask = storageReference.putFile(File(path));
    final storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

  Future<void> updateUserLocation() async {
    final uid = auth.currentUser!.uid;
    try {
      final pos = await determinePosition();
      await firestore.collection("Users").doc(uid).update({
        'lat': pos.latitude,
        'long': pos.longitude,
      });
      getUserData();
      Get.offNamed(Routes.EXP);
    } catch (e) {
      errorSnackbar(msg: '$e');
    }
  }

  Stream<UserDetails> getUserStream() {
    return firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((event) => UserDetails.fromJson(event.data()!));
  }

  // Future<void> login(String email, String password) async {
  //   try {
  //     showLoadingDialogWithText(msg: 'Logging in,');
  //     User? user = (await auth.signInWithEmailAndPassword(
  //             email: email, password: password))
  //         .user;
  //     if (user != null) {
  //       await getUserData();
  //       Get.close(1);
  //       Get.offNamed('/home');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     Get.close(1);
  //     log('$e');

  //     final errorMessage = getMessageFromErrorCode(e);
  //     errorSnackbar(msg: errorMessage);
  //   }
  // }

  Future<void> sendForgotPassword(String email) async {
    try {
      showLoadingDialogWithText(msg: 'Sending email');
      await auth.sendPasswordResetEmail(email: email);
      Get.close(1);
      Get.snackbar(
        'Email Sent',
        'Please check your email for a link password reset your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue[700],
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      Get.close(1);
      log('$e');

      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
    }
  }

  //TODO: Remove

  Future<void> loginSamp() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: 'first@example.com', password: '1234567');
      log('logged in');
    } on FirebaseAuthException catch (e) {
      Get.close(1);
      log('$e');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> deleteImageFromStorage(String url) async {
    storage.Reference storageReference =
        storage.FirebaseStorage.instance.refFromURL(url);
    await storageReference.delete();
  }

  Future<void> updateUserData(UserDetails userDetails,
      {bool imageUpdated = false,
      bool profileImageUpdated = false,
      String? path,
      required Map<int, String> images}) async {
    //TODO: Update user data
    // if (imageUpdated) {
    //   log(' image updated');
    //   for (MapEntry<int, String> image in images.entries) {
    //     final value = image.value;
    //     final key = image.key;
    //     if (!userDetails.imageList.contains(value)) {
    //       log('it doesnt contain in list');
    //       final url = await saveProfileImage(value, userDetails.uid!);

    //       log('$url');
    //       if (userDetails.imageList.asMap().containsKey(key)) {
    //         if (userDetails.imageList[key]
    //             .toLowerCase()
    //             .contains('firebasestorage.googleapis.com')) {
    //           log('to delete');
    //           await deleteImageFromStorage(userDetails.imageList[key]);
    //         }
    //         log('updated imaged list: current ${userDetails.imageList[key]}, new $url');
    //         userDetails.imageList[key] = url;
    //       } else {
    //         userDetails.imageList.add(url);
    //         log('just added to imamge list');
    //       }

    //       log('${userDetails.imageList}');
    //     }
    //   }
    // }
    // if (profileImageUpdated) {
    //   log('profile image updated');
    //   String url;
    //   if (!userDetails.imageList.contains(path) &&
    //       images.entries.where((e) => e.value == path).isNotEmpty) {
    //     final indexInList =
    //         images.entries.firstWhere((e) => e.value == path).key;
    //     url = userDetails.imageList[indexInList];

    //     log('profile image updated here ');
    //     log('image to replce ${images.entries.firstWhere((element) => element.value == path).value}');
    //   } else {
    //     url = path!;
    //     log('profile image updated here xo');
    //   }

    //   userDetails.imageUrl = url;
    // }
    // log('yes i am here');
    // userDetails.lastMatchedTime = userDetails.lastMatchedTime;
    // await firestore
    //     .collection("Users")
    //     .doc(userDetails.uid)
    //     .update(userDetails.toJson())
    //     .whenComplete(() => log('i am complete'));
  }

  Future<void> updateUserDataOther(UserDetails userDetails) async {
    await firestore
        .collection("Users")
        .doc(userDetails.uid)
        .update(userDetails.toJson())
        .whenComplete(() => log('i am complete'));
  }

  Future<void> logout() async {
    try {
      // showLoadingDialogWithText(msg: 'Logging in,');

      await auth.signOut().whenComplete(() {
        box.erase();
        Get.offAllNamed(Routes.onboarding);
      });
    } on FirebaseAuthException catch (e) {
      Get.close(1);
      log('$e');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> deleteAccount({String? password}) async {
    try {
      //Todo delete account
      // showLoadingDialogWithText(msg: 'Logging in,');

      // final currentUser = Get.find<AuthController>().currentUser.value;
      // AuthCredential? credential;
      // if (!providerIsFacebook()) {
      //   credential = EmailAuthProvider.credential(
      //       email: currentUser.email!, password: password!);
      // } else {
      //   final accessToken = await FacebookAuth.instance.accessToken;
      //   credential = FacebookAuthProvider.credential(accessToken!.token);
      //   log("here token ${accessToken.token}");
      // }

      // await auth.currentUser!.reauthenticateWithCredential(credential);
      // final uid = currentUser.uid;
      // HttpsCallable callable =
      //     FirebaseFunctions.instance.httpsCallable('recursiveDeleteUser');
      // callable.call({
      //   'path': uid,
      //   'currentMatches': currentUser.currentMatches,
      //   'currentDeck': currentUser.currentDeck,
      // });
      // await auth.currentUser!.delete().whenComplete(() {
      //   box.erase();
      //   Get.deleteAll();
      //   Get.offAllNamed(Routes.LOGIN);
      // });
    } on FirebaseAuthException catch (e) {
      Get.close(1);
      log('$e');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> verifyPhoneNumber(String text,
      {required Function(String verificationId) onCodeSent}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) {
          log('verification completed');
          log('credential: $credential');
          auth.signInWithCredential(credential).then((UserCredential result) {
            log('result: $result');
            Get.offAllNamed(Routes.LOGIN);
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          log('verification failed');
          log('exception: $exception');
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          log('code sent');
          log('verificationId: $verificationId');
          log('forceResendingToken: $forceResendingToken');
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log('code auto retrieval timeout');
          log('verificationId: $verificationId');
        },
      );
    } on FirebaseAuthException catch (e) {
      log('$e');
      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> verifyOTP(
      String verificationId, String codeSent) async {
    try {
      return await auth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: codeSent));
    } on FirebaseAuthException catch (e) {
      log('$e');
      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> saveUser(
      String name, UserCredential userCredential, String? path, String countryCode) async {
    try {
      User user = userCredential.user!;
      UserDetails userDetails = UserDetails(
        userName: name,
        currentMatches: [],
        currentDeck: [],
        lat: null,
        long: null,
        uid: user.uid,
        phoneNumber: user.phoneNumber,
        countryCode: countryCode
      );
      if (path != null && path != '') {
        log('path is not null$path');
        userDetails.imageUrl = await saveProfilePicture(path, user.uid);
      }

      await firestore
          .collection("Users")
          .doc(userDetails.uid)
          .set(userDetails.toJson());
      await getUser();
    } catch (e) {
      log('$e');
    }
  }
  Future<String> saveProfilePicture(String path, String id) async {
    storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child('User\'s')
        .child(id)
        .child('${Timestamp.now().microsecondsSinceEpoch}');

    final storage.UploadTask uploadTask = storageReference.putFile(File(path));
    final storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }
  

  Future<bool> getUser() async {
    bool exist = false;
    try {
      final uid = auth.currentUser!.uid;
      final userDetails = await firestore.collection("Users").doc(uid).get();
      if (userDetails.exists) {
        LocalStorage.clearBoxes();
        LocalStorage.userDetail.val = jsonEncode(userDetails.data());
        log('saved ${LocalStorage.userDetail.val}');
        exist = true;
      } else {
        exist = false;
      }
    } catch (e) {
      log('$e');
    }
    return exist;
  }

  Future<bool> checkLoginn() async {
    bool isLoggedIn = false;
    try {
      await auth.currentUser!.reload();
      User? user = auth.currentUser;
      if (user != null) {
        isLoggedIn = true;
        await getUser();
        log('user is logged in');
      } else {
        isLoggedIn = false;
      }
    } catch (e) {
      log(' ERROR $e');
      isLoggedIn = false;
    }
    return isLoggedIn;
  }
}

String getMessageFromErrorCode(FirebaseAuthException e) {
  String msg;
  switch (e.code) {
    case "INVALID-VERIFICATION-CODE":
    case "invalid-verification-code":
      msg = "Code is invalid. Please try again.";
      break;
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      msg = "Email already used. Go to login page.";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      msg = "Wrong email/password combination.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      msg = "No user found with this email.";
      break;
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      msg = "User disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      msg = "Too many requests to log into this account.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      msg = "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      msg = "Email address is invalid.";
      break;
    default:
      msg = "Login failed. Please try again.";
      break;
  }
  return msg;
}
