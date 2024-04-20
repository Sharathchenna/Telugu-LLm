import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'chip_item_model.dart';

class ChipItem extends StackedView<ChipItemModel> {
  const ChipItem({super.key});

  @override
  Widget builder(
    BuildContext context,
    ChipItemModel viewModel,
    Widget? child,
  ) {
    return FlexiChip(
      label: Text(
        "Fables",
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Image.asset(
        "assets/icons/book_open.png",
        height: 24,
        width: 24,
        fit: BoxFit.cover,
      ),
      style: FlexiChipStyle.when(
        enabled: FlexiChipStyle.outlined(),
        selected: FlexiChipStyle.filled(
          color: Color(0xFFE5BC52),
        ),
      ),
      onPressed: () {},
      selected: false,
    );
  }

  @override
  ChipItemModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChipItemModel();
}
