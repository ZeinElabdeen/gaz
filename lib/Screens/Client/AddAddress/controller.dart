import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class ClientAddressesController {
  Future<CustomResponse> addNewAddress(
      {double lat,
      double long,
      String type,
      String details,
      String nearPlace,
      String flatNumber}) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate
        .postData(url: 'user/add/address', headers: headers, body: {
      "lat": lat,
      "long": long,
      "type": type,
      "number": flatNumber,
      "details": details,
      "near_place": nearPlace
    });

    return response;
  }

  Future<CustomResponse> editAddress(
      {double lat,
      double long,
      int addressId,
      String type,
      String details,
      String nearPlace,
      String flatNumber}) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate
        .postData(url: 'user/update/address', headers: headers, body: {
      "address_id": addressId,
      "lat": lat,
      "long": long,
      "type": type,
      "number": flatNumber,
      "details": details,
      "near_place": nearPlace
    });

    return response;
  }

  Future<CustomResponse> getSingleAddress({int addressId}) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.postData(
      url: 'user/get/address',
      body: {"address_id": addressId},
      headers: headers,
    );

    return response;
  }
}
