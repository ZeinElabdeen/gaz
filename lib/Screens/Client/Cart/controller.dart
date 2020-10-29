import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class CartController {
  Future<CustomResponse> getCartData() async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.getData(
      url: 'user/get/cart',
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> addToCart({int productId, int quantity}) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.postData(
        url: 'user/add/to/cart',
        headers: headers,
        body: {"product_id": productId, "quantity": quantity});

    return response;
  }

  Future<CustomResponse> deleteFromCart({
    int productId,
  }) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.postData(
        url: 'user/delete/form/cart',
        headers: headers,
        body: {"product_id": productId});

    return response;
  }
}
