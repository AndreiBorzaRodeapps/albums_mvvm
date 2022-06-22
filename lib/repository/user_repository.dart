import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserRepository {
  static const userPrefString = 'user';

  Stream<UserModel?> fetchLocalUser() {
    return SharedPreferences.getInstance().then((prefs) {
      final String? data = prefs.getString(userPrefString);
      return data == null ? null : UserModel.fromJson(data);
    }).asStream();
  }

  Stream<void> setLocalUser(UserModel? user) {
    return SharedPreferences.getInstance().then(
      (prefs) {
        if (user != null) {
          prefs.setString(userPrefString, user.toJson());
        } else {
          prefs.remove(userPrefString);
        }
      },
    ).asStream();
  }
}
