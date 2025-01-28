// States
import 'package:power_washer/model/gallery_model.dart';

abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final GalleryModel galleryModel;

  GalleryLoaded(this.galleryModel);
}

class GalleryError extends GalleryState {
  final String message;

  GalleryError(this.message);
}