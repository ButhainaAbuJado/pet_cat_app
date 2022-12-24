import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_cats_app/model/user_model.dart';

class StorageService {
  static Future<String> uploadProfilePicture(String url, File imageFile) async {
    File? image = await compressImage(imageFile);
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('images/users/userProfile_${UserModel.shared.userId}.jpg')
        .putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<File?> compressImage(File image) async {
    final tempDirection = await getTemporaryDirectory();
    final path = tempDirection.path;
    File? compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_${UserModel.shared.userId}.jpg',
      quality: 70,
    );
    return compressedImage;
  }

  static Future<void> deleteProfileImage() async {
    await FirebaseStorage.instance
        .ref()
        .child('images/users/userProfile_${UserModel.shared.userId}.jpg').delete();
  }
}
