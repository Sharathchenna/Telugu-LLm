import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item_model.dart';

class ChipItem extends StackedView<ChipItemModel> {
  final String label;
  final String id;
  final String imagePath;

  const ChipItem(
      {required this.id,
      required this.label,
      required this.imagePath,
      super.key});

  @override
  Widget builder(
    BuildContext context,
    ChipItemModel viewModel,
    Widget? child,
  ) {
    return FittedBox(
      key: const ValueKey(true),
      child: FlexiChip(
        label: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: FlexiChipStyle.outlined(),
        leading: Image.asset(
          imagePath,
          height: 24,
          width: 24,
          fit: BoxFit.cover,
        ),
        onPressed: () => viewModel.toggleChipCard(id),
      ),
    );
  }

  @override
  ChipItemModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChipItemModel();
}
