import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workspace/data/remote/response/ApiResponse.dart';
import 'package:workspace/models/accountList/accounts_main.dart';
import 'package:workspace/ui/accounts/account_list_screen_vm.dart';

import 'account_repo_test.mocks.dart';

void main() {
  late MockAccountRepoTest accountRepo;
  late AccountListScreenVM viewModel;
  late File file;

  setUpAll(() {
    accountRepo = MockAccountRepoTest();
    viewModel = AccountListScreenVM();
    file = File("test_resources/account_list.json");
  });

  group("AccountScreen ViewModel Test", () {

    test("test fetchData for repository", () async {
      final model = AccountsMain();
      when(accountRepo.fetchAccountList()).thenAnswer((_) async {
        return model;
      });

      final resp = await accountRepo.fetchAccountList();
      viewModel.accountMain.data = resp;

      expect(viewModel.accountMain.data, model);
    });

    test("test searchByName", () async {
      final json = jsonDecode(await file.readAsString());
      final res =  AccountsMain.fromJSON(json);
      viewModel.setAccountMain(ApiResponse.completed(res));
      viewModel.searchByName("Flutter developer");
      expect(viewModel.foundAccountList[0].name, "Flutter developer");
    });

    test("test filterByStateCode", () async {
      final json = jsonDecode(await file.readAsString());
      final res =  AccountsMain.fromJSON(json);
      viewModel.setAccountMain(ApiResponse.completed(res));

      viewModel.filterByStateCode(3);
      expect(viewModel.foundAccountList, viewModel.accountMain.data!.accountList);

      viewModel.filterByStateCode(1);
      expect(viewModel.foundAccountList[0].accountNumber, "3011");
    });
  });
}