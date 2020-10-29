import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ForgetPasswordController {
  Future<CustomResponse> client({
    String phone,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'user/forget/password',
      body: {
        "mobile": phone,
      },
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> provider({
    String phone,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'driver/forget/password',
      body: {
        "mobile": phone,
      },
      headers: headers,
    );

    return response;
  }
}
