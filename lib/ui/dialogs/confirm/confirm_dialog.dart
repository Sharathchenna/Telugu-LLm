import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'confirm_dialog_model.dart';

class ConfirmDialog extends StackedView<ConfirmDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    ConfirmDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: kcBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        request.title ?? 'Telugu Corpus AI!!',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Divider(),
                      if (request.description != null) ...[
                        verticalSpaceSmall,
                        Text(
                          request.description!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>
                      completer(DialogResponse<bool>(confirmed: false)),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: kcBlueVeryLightColor,
                      ),
                    ),
                    child: Text(
                      request.secondaryButtonTitle!,
                      style: GoogleFonts.montserrat(
                          color: kcPrimaryBlueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                horizontalSpaceMedium,
                InkWell(
                  onTap: () => completer(DialogResponse<bool>(confirmed: true)),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kcPrimaryBlueColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      request.mainButtonTitle!,
                      style: GoogleFonts.montserrat(
                          color: kcBackgroundColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  ConfirmDialogModel viewModelBuilder(BuildContext context) =>
      ConfirmDialogModel();
}
