import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'memo_detail_viewmodel.dart';

class MemoDetailView extends StackedView<MemoDetailViewModel> {
  final String id;

  const MemoDetailView({required this.id, super.key});

  @override
  Widget builder(
    BuildContext context,
    MemoDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  MemoDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MemoDetailViewModel();
}
