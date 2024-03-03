part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageFailure extends ImageState {
  final String message;

  const ImageFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Image Failure(message: $message)';
}

class ImageSuccess extends ImageState {
  final String message;
  final String image;

  const ImageSuccess({
    required this.message,
    required this.image,
  });

  @override
  List<Object> get props => [message, image];

  @override
  String toString() => 'Image Success(message: $message, image: $image)';
}
