import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';
import 'package:swaram_ai/ui/common/ui_helpers.dart';
import 'package:swaram_ai/ui/widgets/common/primary_button/primary_button.dart';

import 'category_detail_model.dart';

class CategoryDetail extends StackedView<CategoryDetailModel> {
  const CategoryDetail({super.key});

  @override
  Widget builder(
    BuildContext context,
    CategoryDetailModel viewModel,
    Widget? child,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceTiny,
        PrimaryButton(
          onTapHandler: viewModel.toggleCard,
          iconData: Icons.arrow_back_ios_new,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(
                "assets/icons/book_open.png",
              ),
            ),
            horizontalSpaceSmall,
            Text(
              "Fables",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: kcTextDarkColor),
            ),
          ],
        ),
        SizedBox(
          height: screenHeightFraction(context, dividedBy: 3),
          child: SingleChildScrollView(
            child: Text(
              "Fables are short stories with animals as characters, teaching moral lessons. They're easy to understand and often have a clear message about how to behave. These stories have been passed down through generations and across cultures, teaching valuable lessons about honesty, perseverance, and wisdom. Most famous examples are, tales like \"The Tortoise and the Hare\" and \"The Boy Who Cried Wolf.",
              overflow: TextOverflow.clip,
              maxLines: null,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  CategoryDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoryDetailModel();
}
