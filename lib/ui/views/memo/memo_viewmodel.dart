import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class MemoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final hiveService = locator<HiveService>();

  void navigateBack() => _navigationService.back();

  Iterable<Recording>? _recordingList;
  Timer? _timer;

  Iterable<Recording> get recordingList {
    // _recordingList?.toList().sort((a, b) =>
    //     DateTime.parse(b.created).compareTo(DateTime.parse(a.created)));
    return _recordingList!;
  }

  MemoViewModel() {
    _recordingList = hiveService.getSavedRecordings();
  }

  Future<Iterable<Recording>> getRecordings() async =>
      hiveService.getSavedRecordings();

  Future<void> refreshItems() async {
    _recordingList = hiveService.getSavedRecordings();
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

  Future<void> getTimeStatusUpdate() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      var recordBox = await Hive.openBox<Recording>(recordingBox);
      _recordingList?.toList().sort((a, b) =>
          DateTime.parse(b.created).compareTo(DateTime.parse(a.created)));
      _recordingList = recordBox.values;
      // _recordingList?.toList().sort((a, b) =>
      //     DateTime().  .parse(b.created).compareTo(DateTime.parse(a.created)));
      // if (recordBox.isOpen) {
      //   await recordBox.close();
      // }
      rebuildUi();
    });
  }

  @override
  void dispose() async {
    _timer!.cancel();
    await hiveService.initAll();
    super.dispose();
  }
}
