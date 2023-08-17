import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences preferences;

  static const _top_1 = 'top_1';

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static Future setTop1(int score) async => preferences.setInt(_top_1, score);

  int? getTop1() => preferences.getInt(_top_1);

  static Future ifNull() async {
    if (UserPreferences().getTop1() == null) {
      await UserPreferences.setTop1(0);
    }
  }
}
