import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'sucess_sheet_model.dart';

class SuccessSheet extends StackedView<SucessSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const SuccessSheet({
    super.key,
    required this.completer,
    required this.request,
  });

  @override
  Widget builder(
    BuildContext context,
    SucessSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.check_box_rounded,
              color: kcSuccessColor,
            ),
            Text(
              request.description!,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
            GestureDetector(
              onTap: () => SheetResponse(confirmed: true),
              child: const Icon(
                Icons.close_outlined,
                color: kcBackgroundColor,
              ),
            )
          ],
        ));
  }

  @override
  SucessSheetModel viewModelBuilder(BuildContext context) => SucessSheetModel();
}
