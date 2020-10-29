import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/prefs.dart';
import 'package:master/Helpers/user_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

ClientSignInModel _model = ClientSignInModel();
ServerGate serverGate = ServerGate();

class ClientSignInController {
  Future<CustomResponse> userSignIn({
    String phone,
    String password,
  }) async {
    Map<String, dynamic> headers = await headersMapWithFcm();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    CustomResponse response = await serverGate.postData(
      url: 'user/login',
      body: {
        "mobile": phone,
        "password": password,
        "fcm_token": _pref.getString("msgToken"),
      },
      headers: headers,
    );

    if (response.success) {
      _model = ClientSignInModel.fromJson(response.response.data);
      Prefs.setString("mobile", _model.data.phone);
      Prefs.setBool("isAuth", true);
      Prefs.setString("userType", "client");
      Prefs.setString("token", "Bearer " + _model.data.token);
      Prefs.setString("email", _model.data.email);
      Prefs.setString("name", _model.data.name);
      Prefs.setInt("cityId", _model.data.cityId);
      Prefs.setInt("id", _model.data.id);
      Prefs.setString("city", _model.data.cityName);
      Prefs.setString("profile", _model.data.image);
    }

    return response;
  }
}
