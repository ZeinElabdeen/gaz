import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class SearchController {
  Future<CustomResponse> getData({String keyWord}) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();

    CustomResponse response = await _serverGate
        .postData(url: 'user/search', headers: headers, body: {"key": keyWord});

    return response;
  }
}
