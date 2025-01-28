
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Events
abstract class GalleryEvent {}

class FetchGallery extends GalleryEvent {}


class LoadGalleryData extends GalleryEvent {
   String? serviceId;

  LoadGalleryData(this.serviceId, );

  @override
  List<Object> get props => [serviceId!];
}

