import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:workspace/models/accountList/accounts_main.dart';
import 'package:workspace/ui/accounts/account_list_screen_vm.dart';
import 'package:workspace/ui/widget/main_container.dart';

//ignore: must_be_immutable
class AccountListScreen extends HookWidget {

  var _viewModel =  AccountListScreenVM();
  var _isGrid = false;

  AccountListScreen({Key? key}) : super(key: key);

  AccountListScreen.fromTest(AccountListScreenVM viewModel, bool isGrid, {Key? key}) : super(key: key) {
   _viewModel = viewModel;
   _isGrid = isGrid;
  }

  @override
  Widget build(BuildContext context) {

    var isGrid = useState(_isGrid);

    useEffect(() {
      _viewModel.fetchAccountList();
      return null;
    }, const[]);

    AppBar getAppBar() {
      return AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TextField(onChanged: (text) {
          _viewModel.searchByName(text);
        },),
        actions: [
          PopupMenuButton(
              icon:  const Icon(Icons.filter_alt, color: Colors.black,),
              itemBuilder: (BuildContext context) => <PopupMenuEntry> [
                PopupMenuItem(child: const ListTile(title: Text("All")), onTap: () {
                  _viewModel.filterByStateCode(3);
                },),
                PopupMenuItem(child: const ListTile(title: Text("Active")), onTap: () {
                  _viewModel.filterByStateCode(0);
                },),
                PopupMenuItem(child: const ListTile(title: Text("InActive")), onTap: () {
                  _viewModel.filterByStateCode(1);
                },),
              ],
          ),
          IconButton(onPressed: () {
            isGrid.value = false;
          }, icon: const Icon(Icons.view_list, color: Colors.black,),),
          IconButton(onPressed: () {
            isGrid.value = true;
          }, icon: const Icon(Icons.grid_view, color: Colors.black,),),
        ],
      );
    }

    Widget getGridViewItem(Account item, int position) {
      return Padding(
        key: Key("gridViewItem_$position"),
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network("https://picsum.photos/250?image=9"),
              const SizedBox(height: 10,),
              Text("Title: ${item.name}"),
              const SizedBox(height: 5,),
              Text("Account Number: ${item.accountNumber}"),
              Text("State Code: ${item.statecode == 0 ? "Active" : "InActive"}"),
              Text("Address 1: ${item.primaryAddress}")
            ],
          ),
        ),
      );
    }

    Widget showAccountsInGridView(List<Account> accountList){
      return AlignedGridView.count(
          key: const Key("girdView"),
          crossAxisCount: 2,
          itemCount: accountList.length,
          itemBuilder: (context, position) {
            return getGridViewItem(accountList[position], position);
          });
    }

    Widget getListViewItem(Account item, int position) {
      return Padding(
        key: Key("listviewItem_$position"),
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network("https://picsum.photos/250?image=9", width: 100, height: 80, fit: BoxFit.fill ,),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title: ${item.name}"),
                    const SizedBox(height: 5,),
                    Text("Account Number: ${item.accountNumber}"),
                    Text("State Code: ${item.statecode == 0 ? "Active" : "InActive"}"),
                    Text("Address 1: ${item.primaryAddress}")
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget showAccountsInListView(List<Account> accountList){
      return ListView.builder(
        key: const Key("listview"),
          itemCount: accountList.length,
          itemBuilder: (context, position){
            return getListViewItem(accountList[position], position);
          });
    }

    return ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: Consumer<AccountListScreenVM>(builder: (context, viewModel, _ ) {
          return mainContainer(
              appBar: getAppBar(),
              loadingStatus: viewModel.accountMain.status,
              body: isGrid.value ? showAccountsInGridView(viewModel.foundAccountList) :
              showAccountsInListView(viewModel.foundAccountList)
          );
        }));
  }
}