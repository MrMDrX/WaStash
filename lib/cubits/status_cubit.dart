import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wastash/repositories/status_repository.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit() : super(StatusLoading()) {
    loadStatuses();
  }

  Future<void> loadStatuses() async {
    try {
      emit(StatusLoading());
      final files = await StatusRepository.getStatusFiles();
      emit(StatusLoaded(files));
    } catch (e) {
      emit(StatusError(e.toString()));
    }
  }
}

// Status states
abstract class StatusState {}

class StatusLoading extends StatusState {}

class StatusLoaded extends StatusState {
  final List<String> files;
  StatusLoaded(this.files);
}

class StatusError extends StatusState {
  final String message;
  StatusError(this.message);
}
