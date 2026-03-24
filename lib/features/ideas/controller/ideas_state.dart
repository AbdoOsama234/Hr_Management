import '../data/models/idea_model.dart';

abstract class IdeasState {}

class IdeasInitial extends IdeasState {}

class IdeasLoading extends IdeasState {}

class IdeasEmpty extends IdeasState {}

class IdeasError extends IdeasState {
  final String message;
  IdeasError(this.message);
}

class IdeasLoaded extends IdeasState {
  final List<IdeaModel> ideas;

  IdeasLoaded(this.ideas);
}
