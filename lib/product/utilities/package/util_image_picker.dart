import 'package:image_picker/image_picker.dart';

class UtilImagePicker {
  final _picker = ImagePicker();
  Future<XFile?> pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
