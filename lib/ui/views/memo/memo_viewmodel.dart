import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class MemoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _hiveService = locator<HiveService>();

  void navigateBack() => _navigationService.back();

  Future<Iterable<Recording>> getRecordings() async =>
      _hiveService.getSavedRecordings();

  Future<void> refreshItems() async {
    await getRecordings();
    rebuildUi();
  }

  Widget getStatusIcon(String status) => status == uploading
      ? const Icon(
          Icons.cloud_upload,
          color: kcPrimaryBlueColor,
          size: 20,
        )
      : status == onCloud
          ? const Icon(
              Icons.cloud_done,
              color: kcSuccessColor,
              size: 20,
            )
          : const Icon(
              Icons.cloud_off,
              color: kcMediumGrey,
              size: 20,
            );
}
