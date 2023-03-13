import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../providers/model_provider.dart';

void showLoadingDialog(
  BuildContext context,
) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final appProvider = context.read<AppProvider>();
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Consumer<ModelProvider>(builder: (context, value, child) {
              // If the loading it true then it will show the circular progressbar
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // If loading is false then this code will show the list of todo item

              return ValueListenableBuilder(
                valueListenable: appProvider.modelValueNotifier,
                builder: (context, _, __) => SizedBox(
                  height: 400,
                  width: 400,
                  child: ListView.builder(
                    itemCount: value.models.length,
                    itemBuilder: (context, index) {
                      final model = value.models[index];
                      return InkWell(
                        onTap: () {
                          appProvider.addValueToModel = model.id;
                          Navigator.pop(context);
                          print(appProvider.modelValueNotifier.value);
                        },
                        child: ListTile(
                          title: Text(
                            model.id,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        );
      });
}
