import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/app_colors.dart';

import 'reward_container_model.dart';

class RewardContainer extends StackedView<RewardContainerModel> {
  final IconData iconData;
  final String reward;
  final String footeText;

  const RewardContainer({
    required this.iconData,
    required this.reward,
    required this.footeText,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    RewardContainerModel viewModel,
    Widget? child,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(0, -1),
          child: Container(
            width: 80,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: const Color(0xFF696969),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(
                    iconData,
                    color: kcMediumGrey,
                    size: 20,
                  ),
                  Text(
                    reward,
                    style: GoogleFonts.montserrat(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
          child: Text(
            footeText,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  @override
  RewardContainerModel viewModelBuilder(
    BuildContext context,
  ) =>
      RewardContainerModel();
}
