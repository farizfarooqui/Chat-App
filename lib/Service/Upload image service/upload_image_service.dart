import 'package:image_picker/image_picker.dart';

class UploadImage {
  String path = '';

  //selecting image
  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    print(file?.path);
    if (file!.path.isNotEmpty) {
      path = file.path;
    }
  }

  //uploading image to firebase storage
}
