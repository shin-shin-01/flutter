import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/services/data.dart';

/// API Service
class FirebaseAPIService {
  final _auth = servicesLocator<AuthService>();
  final _config = servicesLocator<ConfigurationService>();
  final _data = servicesLocator<DataService>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  /// storage に保存
  Future<String> uploadImage(int wish_id, File file) async {
    await _initialization;

    final FirebaseStorage storage = FirebaseStorage.instance;

    final timestamp = DateTime.now();
    // wish id 以下に その wish の画像を作成する
    // ex.) ./wish_id/2020.jpeg
    Reference ref = storage.ref('${wish_id}/${timestamp}');

    final metadata = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = ref.putFile(File(file.path), metadata);

    final imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }
}
