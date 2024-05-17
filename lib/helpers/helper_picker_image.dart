import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper._init();
  static final ImagePickerHelper instance = ImagePickerHelper._init();

  final ImagePicker imagePicker = ImagePicker();

  Future<String?> pickImageFromCamera({int imageQuality = 50}) async =>
      (await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      ))
          ?.path;

  Future<String?> pickImageFromGallery({int imageQuality = 50}) async =>
      (await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      ))
          ?.path;
}
