import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ClientCategoryProductsController {
  Future<CustomResponse> getData({int categoryId}) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.postData(
        url: 'user/products',
        headers: headers,
        body: {"category_id": categoryId});

    return response;
  }
}
