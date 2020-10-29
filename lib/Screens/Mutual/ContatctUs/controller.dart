import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ContactUsController {
  Future<CustomResponse> getData() async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.getData(
      url: 'user/contact',
      headers: headers,
    );

    return response;
  }
}
