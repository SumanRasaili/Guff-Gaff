import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final commonFirebaseStorageProvider =
    Provider<CommonFirebaseStorageRepository>((ref) {
  return CommonFirebaseStorageRepository(
      firebaseStorage: FirebaseStorage.instance);
});

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase(
      {required String ref, required File file}) async {
    UploadTask task = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await task;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
