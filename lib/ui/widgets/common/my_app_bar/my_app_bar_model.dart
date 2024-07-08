import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.router.dart';
import 'package:swaram_ai/services/network_service.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

class MyAppBarModel extends ReactiveViewModel {
  final networkService = locator<NetworkService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices {
    return [networkService];
  }

  void navigateToMemoScreen() => _navigationService.navigateToMemoView();
  void navigateToDashboardView()  {
    _navigationService.replaceWithDashboardView();
  }
  void navigateToProfileScreen() {
    _navigationService.navigateToProfileView();
  }

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
