import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:workspace/models/accountList/accounts_main.dart';
import 'package:workspace/repository/accounts/account_repo.dart';

import 'account_repo_test.mocks.dart';

class AccountRepoTest extends Mock implements AccountRepo{}

@GenerateMocks([AccountRepoTest])
void main() async {
  late MockAccountRepoTest accountRepo;

  setUpAll(() {
    accountRepo = MockAccountRepoTest();
  });

  group("account repo test", () {
    test("test ==> fetchData", () async {
      final model = AccountsMain();
      when (accountRepo.fetchAccountList()).thenAnswer((_) async {
        return model;
      });

      final res = await accountRepo.fetchAccountList();

      expect(res, isA<AccountsMain>());
      expect(res, model);
    });

    test("test fetchData thorws Exception", () {
      when(accountRepo.fetchAccountList()).thenAnswer((_) async{
        throw Exception();
      });

      final res = accountRepo.fetchAccountList();
      expect(res, throwsException);
    });
  });
}