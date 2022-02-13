import 'dart:io';
import 'package:xchange/barrel.dart';
export 'package:image_cropper/image_cropper.dart';

class ImageService extends StatelessWidget {
  final bool isSignUp;
  const ImageService({Key? key, this.isSignUp = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: MySize.yMargin(15),
      width: MySize.xMargin(80),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    pickImage(isCamera: true);
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Take photo',
                        style: TextStyle(
                            height: 1.5, fontFamily: 'Poppins', fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Choose from Gallery',
                        style: TextStyle(
                            height: 1.5, fontFamily: 'Poppins', fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  pickImage({bool isCamera = false}) async {
    final ImagePicker _picker = ImagePicker();
    showLoadingDialog();
    final XFile? image = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 30,
        preferredCameraDevice: CameraDevice.front);
    if (image != null) {
      final result = await _cropFile(image.path);

      Get.close(1);
      Get.back(result: result ?? image.path);
    } else {
      Get.close(2);
    }
  }

  Future<String?> _cropFile(String image) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: image,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
      // aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Adjust the image size',
          toolbarColor: appColor,
          hideBottomControls: isSignUp ? true : false,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: isSignUp ? true : false),
    );
    if (croppedFile != null) {
      return croppedFile.path;
    }
    return null;
  }
}
