import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/toast_snack_bar.dart';

class ImageService {
  Future<String?> uploadImage(String imageFile, {String? fileName}) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('https://api.cloudinary.com/v1_1/deldnmfon/image/upload'));

          fileName ??= "image_${DateTime.now().millisecondsSinceEpoch}";

      request.fields
          .addAll({'upload_preset': 'hyvirtnn', 'api_key': '695157996344396', 'public_id': fileName});
      request.files.add(await http.MultipartFile.fromPath('file', imageFile));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        // AppSnackBar.success("Image Uploaded");
        return jsonMap['url'];
      } else {
        AppSnackBar.error("Something went wrong to upload image");
        return null;
      }
    } catch (e) {
      AppSnackBar.error("Failed to upload image: $e");
      return null;
    }
  }
}
