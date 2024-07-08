import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/main.dart';
import 'package:swaram_ai/services/network_service.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

class MyAppBarModel extends ReactiveViewModel {
  final networkService = locator<NetworkService>();
  final _navigationService = locator<NavigationService>();
  bool isEnglish = false;
  Locale? _locale;
  bool _isEnglish = true;
  Box settingsBox = Hive.box('settings');

  MyAppBarModel() {
    _isEnglish = settingsBox.get('isEnglish', defaultValue: true);
    if (_isEnglish) {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('te'));
    }
  }

  void setLocale(Locale locale) {
    _locale = locale;
  }

  void toggleLanguage(BuildContext context) {
    if (_isEnglish) {
      MainApp.setLocale(context, const Locale('te'));
      settingsBox.put('isEnglish', false);
    } else {
      MainApp.setLocale(context, const Locale('en'));
      settingsBox.put('isEnglish', true);
    }
    _isEnglish = !_isEnglish; // Toggle the flag after setting the locale
  }

  @override
  List<ListenableServiceMixin> get listenableServices {
    return [networkService];
  }

  void navigateBack() => _navigationService.back();
  void navigateToDashboardScreen() => _navigationService.back();
  void navigateToMemoScreen() => _navigationService.navigateToMemoView();
  void navigateToDashboardView() {
    _navigationService.back();
  }

  void navigateToProfileScreen() {
    _navigationService.navigateToProfileView();
  }

  Widget get popupMenu => PopupMenuButton(
        icon: const Icon(
          Icons.menu,
          color: kcPrimaryBlueColor,
        ),
        color: kcVeryBlueLightColor,
        onSelected: (value) {
          switch (value) {
            case 0:
              navigateBack();
              break;
            case 1:
              navigateToDashboardScreen();
              break;
            case 2:
              navigateToMemoScreen();
              break;
            // case 3:
            //   navigateToProfileScreen();
            //   break;
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              value: 0,
              child: ListTile(
                title: Text("Close"),
                leading: Icon(Icons.close_rounded),
                // close the menu
              ),
            ),
            const PopupMenuItem(
              value: 1,
              child: ListTile(
                title: Text("Dashboard"),
                leading: Icon(Icons.dashboard_rounded),
              ),
            ),
            const PopupMenuItem(
              value: 2,
              child: ListTile(
                title: Text("Recordings"),
                leading: Icon(Icons.save),
              ),
            ),
            // const PopupMenuItem(
            //   value: 3,
            //   child: ListTile(
            //     title: Text("Profile"),
            //     leading: Icon(Icons.person_rounded),
            //   ),
            // ),
          ];
        },
      );

  Widget get networkWidget => AnimatedCrossFade(
      firstChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_done_rounded,
            size: 16,
            color: kcVeryBlueLightColor,
            shadows: List.generate(
              10,
              (index) => const Shadow(
                blurRadius: 1.5,
                color: kcPrimaryBlueColor,
              ),
            ),
          ),
          verticalSpaceTiny,
          Text(
            "Online",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: kcPrimaryBlueColor,
            ),
          ),
        ],
      ),
      secondChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 16,
            color: kcDarkGreyColor,
          ),
          verticalSpaceTiny,
          Text(
            "Offline",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: kcDarkGreyColor,
            ),
          ),
        ],
      ),
      crossFadeState: networkService.hasConnection
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 600));

  @override
  void dispose() {
    networkService.cancel();
    super.dispose();
  }
}
