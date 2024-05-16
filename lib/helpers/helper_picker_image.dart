import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper._init();
  static final ImagePickerHelper instance = ImagePickerHelper._init();

  final ImagePicker imagePicker = ImagePicker();

  Future<String?> pickImageFromCamera() async =>
      (await imagePicker.pickImage(source: ImageSource.camera))?.path;

  Future<String?> pickImageFromGallery() async =>
      (await imagePicker.pickImage(source: ImageSource.gallery))?.path;
}
