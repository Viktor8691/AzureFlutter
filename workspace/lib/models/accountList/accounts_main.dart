class AccountsMain {

  AccountsMain({this.accountList = const []});

  List<Account> accountList;

  factory AccountsMain.fromJSON(Map<String, dynamic> json) => AccountsMain(
    accountList: json['value'] == null ? [] : List<Account>.from(json["value"].map((x) => Account.fromJSON(x))),
  );
}

class Account {
  String? name;
  String? accountNumber;
  int? statecode;
  String? primaryAddress;

  Account({this.name, this.accountNumber, this.statecode, this.primaryAddress});

  factory Account.fromJSON(Map<String, dynamic> json) => Account (
    name: json['name'] ?? "",
    accountNumber: json['accountnumber'] ?? "",
    statecode: json['statecode'] ?? -1,
    primaryAddress: json['address1_stateorprovince'] ?? ""
  );
}