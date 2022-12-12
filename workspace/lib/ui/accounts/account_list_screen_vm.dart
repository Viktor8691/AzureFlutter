import 'package:workspace/data/remote/response/ApiResponse.dart';
import 'package:workspace/data/remote/response/Status.dart';
import 'package:workspace/models/accountList/accounts_main.dart';
import 'package:workspace/repository/accounts/account_repo.dart';
import 'package:workspace/ui/base/base_view_model.dart';

class AccountListScreenVM extends BaseViewModel {

  final _myRepo = AccountRepoImp();
  ApiResponse<AccountsMain> accountMain = ApiResponse.loading();
  List<Account> foundAccountList = [];

  @override
  void init() {}

  void setAccountMain(ApiResponse<AccountsMain> response){
    accountMain = response;
    if (response.status == Status.COMPLETED) {
      foundAccountList.addAll(accountMain.data!.accountList);
    }

    notifyListeners();
  }

  void searchByName(String accountName){
    foundAccountList.clear();
    if (accountName.isEmpty){
      foundAccountList.addAll(accountMain.data!.accountList);
    }else {
      for (var element in accountMain.data!.accountList) {
        if (element.name!.toLowerCase().contains(accountName.toLowerCase())){
          foundAccountList.add(element);
        }
      }
    }

    notifyListeners();
  }

  void filterByStateCode(int stateCode){
    foundAccountList.clear();
    if (stateCode == 3){
      foundAccountList.addAll(accountMain.data!.accountList);
    }else {
      for (var element in accountMain.data!.accountList) {
        if (element.statecode == stateCode){
          foundAccountList.add(element);
        }
      }
    }

    notifyListeners();
  }

  Future<void> fetchAccountList() async{
    setAccountMain(ApiResponse.loading());
    _myRepo
        .fetchAccountList()
        .then((value) => setAccountMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => setAccountMain(ApiResponse.error(error.toString())));
  }
}