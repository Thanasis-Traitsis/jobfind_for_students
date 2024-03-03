part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class UploadImageButtonPressed extends ImageEvent {
  final File image;

  const UploadImageButtonPressed({
    required this.image,
  });

  @override
  List<Object> get props => [
        image,
      ];

  @override
  String toString() => 'Upload Image Button Pressed (Image: $image)';
}
