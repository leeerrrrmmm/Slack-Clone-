import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ProfilePhotoService is the service that handles the profile photo. */
class ProfilePhotoService {
  static const _key = 'profile_photo_path';

  /// Gets the saved profile photo from the shared preferences.
  static Future<File?> getSavedPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_key);
    if (path == null) return null;

    final file = File(path);

    return await file.exists() ? file : null;
  }

  /// Picks and saves the profile photo from the gallery.
  static Future<File?> pickAndSavePhoto() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return null;

    final dir = await getApplicationDocumentsDirectory();
    final savedFile = await File(
      picked.path,
    ).copy('${dir.path}/profile_photo.jpg');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, savedFile.path);

    return savedFile;
  }
}
