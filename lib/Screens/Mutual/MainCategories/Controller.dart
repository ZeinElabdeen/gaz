import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class MainCategoryController {
// Cities

  Future<CustomResponse> getCities() async {
    Map<String, dynamic> headers = await headersMapWithoutToken();

    CustomResponse response =
        await _serverGate.getData(url: 'user/cities', headers: headers);

    return response;
  }
}
