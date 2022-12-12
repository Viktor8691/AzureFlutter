import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspace/ui/accounts/account_list_screen.dart';
import 'package:workspace/ui/login/login_screen_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final viewModel = LoginScreenVM();

  @override
  void initState() {
    super.initState();
    viewModel.login();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: Consumer<LoginScreenVM> (builder: (context, viewModel, _) {
        if (viewModel.token.isNotEmpty){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AccountListScreen()));
          });
        }
        return const Scaffold();
      },),
    );
  }
}