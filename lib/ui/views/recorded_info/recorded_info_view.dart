import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'recorded_info_viewmodel.dart';

class RecordedInfoView extends StackedView<RecordedInfoViewModel> {
  const RecordedInfoView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RecordedInfoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  RecordedInfoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecordedInfoViewModel();
}
