import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../viewmodel/viewModel.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  showLoading(BuildContext context, String message, bool isDismissible) async =>
      await  ViewModel.showProgress(context, message, isDismissible);

  hideLoading() async => await  ViewModel.hideProgress();
}
