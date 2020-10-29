import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ResetPasswordController {
  Future<CustomResponse> client({
    String phone,
    String code,
    String password,
    String passwordConfirmation,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'user/reset/password',
      body: {
        "mobile": phone,
        "code": code,
        "password": password,
        "password_confirmation": passwordConfirmation
      },
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> provider({
    String phone,
    String code,
    String password,
    String passwordConfirmation,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'driver/reset/password',
      body: {
        "mobile": phone,
        "code": code,
        "password": password,
        "password_confirmation": passwordConfirmation
      },
      headers: headers,
    );

    return response;
  }
}
