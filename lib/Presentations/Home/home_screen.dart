import 'package:ecomerce/App/constants.dart';
import 'package:ecomerce/Presentations/Common/stateRenderer/state_rederer.dart';
import 'package:ecomerce/Presentations/Home/Provider/home_provider.dart';
import 'package:ecomerce/Presentations/resources/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home_screen extends StatefulWidget {
  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  void getToken() async {
    constants.token = await FirebaseAuth.instance.currentUser!.getIdToken();
  }

  late homeProvider _homeProvider;
  late Future getData;
  @override
  void initState() {
    getToken();
    _homeProvider = Provider.of(context, listen: false);
    getData = _homeProvider.allCatData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 200,
        backgroundColor: Colors.red,
        title: Container(
          height: 150,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: ColorManager.primery,
                height: 150,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
                future: getData,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // WidgetsBinding.instance.addPostFrameCallback(
                    //   (_) {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return StateRenderer(
                    //               stateRendererType:
                    //                   StateRendererType.POPUP_LOADING_STATE,
                    //               message: 'Please Wait');
                    //         });
                    //   },
                    // );
                    return Container();
                  } else {
                    // Navigator.of(context).pop();
                    return Center(
                      child: Text('done'),
                    );
                  }
                })),
          ],
        ),
      ),
    );
  }
}
