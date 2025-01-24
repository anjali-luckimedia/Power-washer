/*
abstract class NoteEvent {}

class EditNoteEvent extends NoteEvent {
  final String noteId;
  final String title;
  final String content;

  EditNoteEvent({required this.noteId, required this.title, required this.content});
}
*/

import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UserEditProfileEvent extends Equatable {
  const UserEditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileButtonPressed extends UserEditProfileEvent {

  final String name;
  final String email;
  final String phone;
   File? image;

   EditProfileButtonPressed(

      {
        required this.name,
      required this.email,
      required this.phone,
         this.image,});

  @override
  List<Object> get props => [name, email, phone,];
}
