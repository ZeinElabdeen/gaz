import 'package:master/Helpers/CustomWidgets/user_token.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/prefs.dart';
import 'package:master/Screens/Mutual/Auth/AccountActivation/client_model.dart';
import 'package:master/Screens/Mutual/Auth/AccountActivation/provider_model.dart';

ClientAccountActivationModel _clientAccountActivationModel =
    ClientAccountActivationModel();
ServerGate _serverGate = ServerGate();

class AccountActivationController {
  Future<CustomResponse> resendClientCode({
    String phone,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'user/send/code',
      body: {
        "mobile": phone,
      },
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> resendProviderCode({
    String phone,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'driver/send/code',
      body: {
        "mobile": phone,
      },
      headers: headers,
    );

    return response;
  }

  Future<CustomResponse> clientAccountActivation({
    String code,
    String phone,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'user/active',
      body: {
        "code": code,
        "phone": phone
        //  "type": Platform.isAndroid ? "android" : "ios",
        //   "device_token": await Prefs.getStringF("msgToken"),
      },
      headers: headers,
    );

    if (response.success) {
      _clientAccountActivationModel =
          ClientAccountActivationModel.fromJson(response.response.data);
      Prefs.setString("mobile", _clientAccountActivationModel.data.phone);
      Prefs.setBool("isAuth", true);
      Prefs.setString("userType", "client");
      Prefs.setString(
          "token", "Bearer " + _clientAccountActivationModel.data.token);
      Prefs.setString("email", _clientAccountActivationModel.data.email);
      Prefs.setString("name", _clientAccountActivationModel.data.name);
      Prefs.setInt("cityId", _clientAccountActivationModel.data.cityId);
      Prefs.setInt("id", _clientAccountActivationModel.data.id);
      Prefs.setString("city", _clientAccountActivationModel.data.cityName);
      Prefs.setString("profile", _clientAccountActivationModel.data.image);
    }

    return response;
  }

  Future<CustomResponse> providerAccountActivation({
    String code,
    String phone,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await _serverGate.postData(
      url: 'driver/active',
      body: {
        "code": code,
        "phone": phone
        //  "type": Platform.isAndroid ? "android" : "ios",
        //   "device_token": await Prefs.getStringF("msgToken"),
      },
      headers: headers,
    );

    if (response.success) {
      _providerAccountActivationModel =
          ProviderAccountActivationModel.fromJson(response.response.data);
      Prefs.setString("mobile", _providerAccountActivationModel.data.phone);
      Prefs.setBool("isAuth", true);
      Prefs.setString("userType", "provider");
      Prefs.setString(
          "token", "Bearer " + _providerAccountActivationModel.data.token);
      Prefs.setString("email", _providerAccountActivationModel.data.email);
      Prefs.setString("name", _providerAccountActivationModel.data.name);
      Prefs.setInt("cityId", _providerAccountActivationModel.data.cityId);
      Prefs.setInt("id", _providerAccountActivationModel.data.id);
      Prefs.setString("city", _providerAccountActivationModel.data.cityName);
      Prefs.setString("profile", _providerAccountActivationModel.data.image);
    }

    return response;
  }

  ProviderAccountActivationModel _providerAccountActivationModel =
      ProviderAccountActivationModel();
}
