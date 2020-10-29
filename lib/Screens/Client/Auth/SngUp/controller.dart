import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/user_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientSignUpController {
  ServerGate _serverGate = ServerGate();

  Future<CustomResponse> userRegister({
    String name,
    String email,
    String phone,
    int cityId,
    String password,
  }) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    Map<String, dynamic> headers = await headersMapWithFcm();
    CustomResponse response = await _serverGate.postData(
      url: 'user/register',
      body: {
        "fcm_token": _pref.getString("msgToken"),
        "email": email,
        "password": password,
        "password_confirmation": password,
        "name": name,
        "city_id": cityId,
        "phone": phone,
      },
      headers: headers,
    );

    return response;
  }
}
