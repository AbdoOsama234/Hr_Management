import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/idea_model.dart';
import 'ideas_state.dart';

class IdeasCubit extends Cubit<IdeasState> {
  IdeasCubit() : super(IdeasInitial());

  final List<IdeaModel> _ideas = [];
  static IdeasCubit get(BuildContext context) => context.read<IdeasCubit>();

  Future<void> loadIdeas() async {
    emit(IdeasLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    if (_ideas.isEmpty) {
      emit(IdeasEmpty());
    } else {
      emit(IdeasLoaded(List.from(_ideas)));
    }
  }

  Future<void> addIdea({
    required DateTime date,
    required String ideaExplain,
    required String ideaLink,
    File? ideaFile,
    required IdeaType type,
  }) async {
    final newIdea = IdeaModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: date,
      ideaExplain: ideaExplain,
      ideaLink: ideaLink,
      ideaFile: ideaFile,
      status: IdeaStatus.pending,
      type: type,
    );

    _ideas.insert(0, newIdea);

    emit(IdeasLoaded(List.from(_ideas)));
  }

  Future<void> updateIdea({
    required String id,
    required DateTime date,
    required String ideaExplain,
    required String ideaLink,
    File? ideaFile,
    required IdeaType type,
  }) async {
    final index = _ideas.indexWhere((idea) => idea.id == id);
    if (index != -1) {
      _ideas[index] = _ideas[index].copyWith(
        date: date,
        ideaExplain: ideaExplain,
        ideaLink: ideaLink,
        ideaFile: ideaFile,
        type: type,
      );
      emit(IdeasLoaded(List.from(_ideas)));
    }
  }

  Future<void> deleteIdea(String id) async {
    _ideas.removeWhere((idea) => idea.id == id);
    if (_ideas.isEmpty) {
      emit(IdeasEmpty());
    } else {
      emit(IdeasLoaded(List.from(_ideas)));
    }
  }
}
