import 'package:shared_preferences/shared_preferences.dart';

class HostelIdPreferences {
  static const _hostelIdKey = "HOSTEL_ID";

  static Future<void> saveHostelId(String id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_hostelIdKey, id);
  }

  static Future<String?> getHostelId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_hostelIdKey);
  }
  
}
