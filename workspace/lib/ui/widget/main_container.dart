import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:workspace/data/remote/response/Status.dart';

Widget mainContainer({AppBar? appBar,  required Widget body, Status? loadingStatus}){

  return Scaffold(
    appBar: appBar,
    body: ModalProgressHUD(
      progressIndicator: Container(
        width: 80, height: 80, padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: const CircularProgressIndicator(color: Colors.blue,),
      ),
      inAsyncCall: loadingStatus == Status.LOADING,
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // keyboard hide when touch empty area
          child: body),),
  );
}