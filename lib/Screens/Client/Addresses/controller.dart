import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';

ServerGate _serverGate = ServerGate();

class AddressesController {
  Future<CustomResponse> getAddresses() async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.getData(
      url: 'user/get/addresses',
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> deleteAddress({
    int id,
  }) async {
    Map<String, dynamic> headers = await headersMap();

    CustomResponse response = await _serverGate.postData(
        url: 'user/delete/address', headers: headers, body: {"address_id": id});

    return response;
  }

  Future<CustomResponse> editAddress(
      {int addressId,
      double lat,
      double long,
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
      "near_place": nearPlace,
    });

    return response;
  }
}
