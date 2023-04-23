import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_chat/ui/base_view.dart';
import 'package:nearby_chat/ui/components/primary_button.dart';
import 'package:nearby_chat/ui/screens/client.dart';
import 'package:nearby_chat/ui/screens/server.dart';
import 'package:nearby_chat/ui/screens/settings.dart';
import 'package:nearby_chat/viewmodels/home_viewmodel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeViewModel _model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Chat'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const Settings());
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: BaseView<HomeViewModel>(
          onModelReady: (model) => {_model = model, _model.getUsername()},
          builder: (context, model, child) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                        onPressed: () {
                          Get.to(() => const Server());
                        },
                        buttonTitle: 'Server'),
                    PrimaryButton(
                        onPressed: () {
                          _model.getServerAddress().then((value) => {
                                if (value != null)
                                  {Get.to(() => Client(ipAddress: value))}
                              });
                        },
                        buttonTitle: 'Client'),
                  ],
                ),
              )),
    );
  }
}
