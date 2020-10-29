import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class UpdatePasswordController {
  Future<CustomResponse> postData({
    String urlType,
    String oldPassword,
    String newPassword,
    String passwordConfirmation,
  }) async {
    Map<String, dynamic> headers = await headersMap();
    CustomResponse response = await _serverGate.postData(
      url: '$urlType/update/password',
      body: {
        "old_password": oldPassword,
        "password": newPassword,
        "password_confirmation": passwordConfirmation
      },
      headers: headers,
    );

    return response;
  }
}
