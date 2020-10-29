import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class AppInfoController {
  Future<CustomResponse> gatAppInfo({String url}) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.getData(
      url: 'user/$url',
      headers: headers,
    );

    return response;
  }
}
