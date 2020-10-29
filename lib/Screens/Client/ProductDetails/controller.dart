import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ProductDetailsController {
  Future<CustomResponse> getData({int id}) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();

    CustomResponse response = await _serverGate.postData(
        url: 'user/product', headers: headers, body: {"product_id": id});

    return response;
  }
}
