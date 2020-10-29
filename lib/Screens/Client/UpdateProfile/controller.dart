import 'package:dio/dio.dart';
import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/prefs.dart';
import 'package:path/path.dart';

import 'model.dart';

class ClientUpdateProfileController {
  ServerGate _serverGate = ServerGate();
  ClientUpdateProfileModel _model = ClientUpdateProfileModel();

  Future<CustomResponse> updateProfile(
      {String name,
      String email,
      String phone,
      int cityId,
      dynamic img}) async {
    Map<String, dynamic> headers = await headersMap();
    CustomResponse response = await _serverGate.postData(
      url: 'user/update/profile',
      body: {
        "email": email,
        "image": img == null
            ? null
            : MultipartFile.fromFileSync(img.path,
                filename: basename(img.path)),
        "name": name,
        "city_id": cityId,
        "phone": phone,
      },
      headers: headers,
    );
    if (response.success) {
      _model = ClientUpdateProfileModel.fromJson(response.response.data);
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
