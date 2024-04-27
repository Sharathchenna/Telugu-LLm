import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'chip_item_model.dart';

class ChipItem extends StackedView<ChipItemModel> {
  final String label;
  final Color selectedColor;
  final String imagePath;

  const ChipItem(
      {required this.label,
      required this.selectedColor,
      required this.imagePath,
      super.key});

  @override
  Widget builder(
    BuildContext context,
    ChipItemModel viewModel,
    Widget? child,
  ) {
    return FittedBox(
      child: FlexiChip(
        label: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Image.asset(
          imagePath,
          height: 24,
          width: 24,
          fit: BoxFit.cover,
        ),
        style: FlexiChipStyle.when(
          enabled: FlexiChipStyle.outlined(),
          selected: FlexiChipStyle.filled(
            color: selectedColor,
          ),
        ),
        onPressed: viewModel.changeInSelection,
        selected: viewModel.isSelected,
      ),
    );
  }

  @override
  ChipItemModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChipItemModel();
}
