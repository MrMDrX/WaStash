import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wastash/repositories/status_repository.dart';

class SavedStatusCubit extends Cubit<SavedStatusState> {
  SavedStatusCubit() : super(SavedStatusLoading()) {
    loadSavedStatuses();
  }

  Future<void> loadSavedStatuses() async {
    try {
      emit(SavedStatusLoading());
      final files = await StatusRepository.getSavedStatusFiles();
      emit(SavedStatusLoaded(files));
    } catch (e) {
      emit(SavedStatusError(e.toString()));
    }
  }
}

abstract class SavedStatusState {}

class SavedStatusLoading extends SavedStatusState {}

class SavedStatusLoaded extends SavedStatusState {
  final List<String> files;
  SavedStatusLoaded(this.files);
}

class SavedStatusError extends SavedStatusState {
  final String message;
  SavedStatusError(this.message);
}
