import 'dart:io';

import 'package:myarcher_enterprise/core/models/objects/gallery_model.dart';

class PickedImage{
  bool isPicker;
  GalleryModel? url;
  File? image;

  PickedImage({required this.isPicker, this.url, this.image});
}