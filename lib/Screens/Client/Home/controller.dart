import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ClientHomeController {
  Future<CustomResponse> getData() async {
    Map<String, dynamic> headers = await headersMapWithoutToken();

    CustomResponse response = await _serverGate.getData(
      url: 'user/home',
      headers: headers,
    );

    return response;
  }
}
