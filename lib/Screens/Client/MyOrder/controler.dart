import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ClientOrdersController {
  Future<CustomResponse> getCurrentOrders() async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.getData(
      url: 'user/orders/pending',
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> getFinishedOrders() async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.getData(
      url: 'user/orders/delivered',
      headers: headers,
    );

    return response;
  }
}
