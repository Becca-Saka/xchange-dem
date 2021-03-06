import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:xchange/app/barrel.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class AuthenticationService {
  static AuthenticationService get to => Get.put(AuthenticationService());
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetStorage box = GetStorage();

//TODO:add loading indicator

  Future<void> verifyPhoneNumber(String text,
      {required Function(String verificationId, {int? token}) onCodeSent,
      required Function() onError,
      int? resendToken}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: text,
        timeout: const Duration(seconds: 60),
        forceResendingToken: resendToken,
        verificationCompleted: (AuthCredential credential) {},
        verificationFailed: (FirebaseAuthException exception) {
          final errorMessage = getMessageFromErrorCode(exception);
          errorSnackbar(msg: errorMessage);
          onError();

          log('Error ${exception}');
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          onCodeSent(
            verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          onCodeSent(
            verificationId,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
      log('Error ${e}');
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> verifyOTP(
    String verificationId,
    String codeSent, {
    required Function() onError,
  }) async {
    try {
      return await auth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: codeSent));
    } on FirebaseAuthException catch (e) {
      log('$e');
      final errorMessage = getMessageFromErrorCode(e);
      errorSnackbar(msg: errorMessage);
      onError();
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUser(String name, UserCredential userCredential,
      String? path, String countryCode) async {
    try {
      User user = userCredential.user!;
      UserDetails userDetails = UserDetails(
          userName: name,
          friendList: [],
          currentChatrooms: [],
          lat: null,
          long: null,
          uid: user.uid,
          phoneNumber: user.phoneNumber,
          countryCode: countryCode);
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

  Future<bool> getUser({bool authStarted = false}) async {
    bool exist = false;
    try {
      final uid = auth.currentUser!.uid;
      final userDetails = await firestore.collection("Users").doc(uid).get();
      if (userDetails.exists) {
        LocalStorage.clearBoxes();
        LocalStorage.userDetail.val = jsonEncode(userDetails.data());
        LocalStorage.authenticationStarted.val = authStarted;
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

  Future<bool> checkLogin() async {
    log('checking login');
    bool isLoggedIn = false;
    try {
      User? user = auth.currentUser;
      log('user is ${user}');
      if (user != null) {
        IdTokenResult tokenResult = await user.getIdTokenResult(true);
        log('tokenResult ${tokenResult.token}');
        if (tokenResult.token != null) {
          isLoggedIn = true;
          // LocalStorage.userLoggedIn.val = true;
        }
      } else {
        isLoggedIn = false;
      }
    } catch (e) {
      log(' ERROR $e');
      isLoggedIn = false;
    }

    LocalStorage.userLoggedIn.val = isLoggedIn;
    return isLoggedIn;
  }

  Future<void> logout() async {
    try {
      await auth.signOut().whenComplete(() {
        LocalStorage.clearBoxes();
        Get.offAllNamed(Routes.root);
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
      msg = "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      msg = "Email address is invalid.";
      break;
    default:
      msg = "Something went wrong. Please try again.";
      break;
  }
  return msg;
}
