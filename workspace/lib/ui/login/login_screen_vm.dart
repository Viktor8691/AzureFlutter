import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:workspace/data/local/common.dart';
import 'package:workspace/ui/base/base_view_model.dart';

class LoginScreenVM extends BaseViewModel {

  final flutterWebviewPlugin = FlutterWebviewPlugin();

  final authUrl = 'https://login.microsoftonline.com/common/oauth2/authorize';
  final resource = 'https://org253660e9.api.crm4.dynamics.com';
  final responseType = 'token';
  final clientID = '551ecb06-db36-40af-aa38-a8d11bea4747';
  final scope = 'user.read';
  final redirectURL = 'https://mohammad_app_redirect_url.com';

  String token = "";

  @override
  void init() {}

  void setToken(String toke){
    token = toke;
    accessToken = token;
    notifyListeners();
  }

  void login(){
    String url = '$authUrl?resource=$resource&response_type=$responseType&client_id=$clientID&scope=$scope&redirect_uri=$redirectURL&sso_reload=true';

    flutterWebviewPlugin.launch(url, clearCache: false, clearCookies: false);
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains('https://mohammad_app_redirect_url.com/#access_token')){
        final temp = url.split('=')[1];
        final token = temp.split('&')[0];

        setToken(token);

        flutterWebviewPlugin.close();
      }
    });
  }
}