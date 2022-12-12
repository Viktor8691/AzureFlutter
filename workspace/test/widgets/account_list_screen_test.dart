import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workspace/data/remote/response/ApiResponse.dart';
import 'package:workspace/models/accountList/accounts_main.dart';
import 'package:workspace/ui/accounts/account_list_screen.dart';
import 'package:workspace/ui/accounts/account_list_screen_vm.dart';

void main() {

  late AccountListScreenVM viewModel;
  late File file;
  late dynamic json;
  late AccountsMain res;

  setUpAll(() async {
    HttpOverrides.global = null;
    file = File("test_resources/account_list.json");
    json = jsonDecode(file.readAsStringSync());
    res = AccountsMain.fromJSON(json);
  });

  Widget createWidgetForTesting({Widget? child}) {
    return MaterialApp(home: child);
  }

  void init() {
    viewModel = AccountListScreenVM();
    viewModel.setAccountMain(ApiResponse.completed(res));
  }

  testWidgets("ListView test", (tester) async {

    init();

    await tester.pumpWidget(createWidgetForTesting(child: AccountListScreen.fromTest(viewModel, false)));

    final listView = find.byKey(const ValueKey("listview"));
    final listViewItem = find.byKey(const ValueKey("listviewItem_4"));

    await tester.dragUntilVisible(listViewItem, listView, const Offset(0, 500), duration: const Duration(seconds: 2));
    expect(listViewItem, findsOneWidget);
  });

  testWidgets("Gridview test", (tester) async {

    init();

    await tester.pumpWidget(createWidgetForTesting(child: AccountListScreen.fromTest(viewModel, true,)));

    final gridView = find.byKey(const ValueKey("girdView"));
    final gridViewItem = find.byKey(const ValueKey("gridViewItem_4"));

    await tester.dragUntilVisible(gridViewItem, gridView, const Offset(0, 500), duration: const Duration(seconds: 2));
    expect(gridViewItem, findsOneWidget);
  });
}