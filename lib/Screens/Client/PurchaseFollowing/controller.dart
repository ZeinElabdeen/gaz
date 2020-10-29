import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class PurchaseFollowingController {
  Future<CustomResponse> getData() async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.getData(
      url: 'user/continue/shopping',
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> confirmOrder(
      {int addressId, String date, String time}) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.postData(
        url: 'user/create/order',
        headers: headers,
        body: {"address_id": addressId, "date": "2020-8-15", "time": "10:00"});

    return response;
  }
}
