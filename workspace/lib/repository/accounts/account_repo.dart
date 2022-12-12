import 'package:workspace/data/remote/network/api_end_points.dart';
import 'package:workspace/data/remote/network/base_api_service.dart';
import 'package:workspace/data/remote/network/network_api_service.dart';
import 'package:workspace/models/accountList/accounts_main.dart';

abstract class AccountRepo {
  Future<AccountsMain> fetchAccountList();
}

class AccountRepoImp implements AccountRepo {

  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<AccountsMain> fetchAccountList() async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints().getAccountList);
      final jsonData = AccountsMain.fromJSON(response);
      return jsonData;
    }catch (e) {
      rethrow;
    }
  }
}