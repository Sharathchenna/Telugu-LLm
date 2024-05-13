import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';

import 'draggable_sheet_model.dart';

class DraggableSheet extends StackedView<DraggableSheetModel> {
  final bool isOpen;
  final VoidCallback onClose;
  final Widget childWidget;

  const DraggableSheet(
      {super.key,
      required this.isOpen,
      required this.onClose,
      required this.childWidget});

  @override
  Widget builder(
    BuildContext context,
    DraggableSheetModel viewModel,
    Widget? child,
  ) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isOpen
            ? screenHeight(context) * 0.26
            : screenHeight(context) * 0.035,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Expanded(
          child: Column(
            children: [
              GestureDetector(
                onTap: onClose,
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Container(
                      width: 40,
                      height: 30,
                      color: kcTextDarkColor,
                      child: isOpen
                          ? const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: kcBackgroundColor,
                              size: 30,
                            )
                          : const Icon(
                              Icons.arrow_drop_up_sharp,
                              color: kcBackgroundColor,
                              size: 30,
                            ),
                    )),
              ),
              Expanded(
                child: Container(color: Colors.black45, child: childWidget),
              ),
            ],
          ),
        ));
  }

  @override
  DraggableSheetModel viewModelBuilder(
    BuildContext context,
  ) =>
      DraggableSheetModel();
}
