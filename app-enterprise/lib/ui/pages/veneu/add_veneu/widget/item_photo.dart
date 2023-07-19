import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myarcher_enterprise/core/models/picked_image.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';

class ItemPhoto extends StatelessWidget {
  final PickedImage data;
  final Function onClick;
  final Function onDelete;
  final Function onPhotoClicked;
  final bool isEditable;
  const ItemPhoto({Key? key, required this.data, required this.onClick, required this.onDelete, required this.onPhotoClicked, required this.isEditable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (data.isPicker) ? InkWell(
      child: SvgPicture.asset(Assets.icons.icAddPhoto, width: wValue(75), height: wValue(70), fit: BoxFit.fill,),
      onTap: (){
        onClick();
      },
    ) : SizedBox(
      width: wValue(75), height: wValue(75),
      child: Stack(
        children: [
          Positioned(bottom: 0, left: 0,child: InkWell(
            child: (data.image != null) ? Image.file(data.image!, width: wValue(70), height: wValue(70), fit: BoxFit.cover,) :
            Image.network(data.url!.file ?? "", width: wValue(70), height: wValue(70), fit: BoxFit.cover,),
            onTap: (){
              onPhotoClicked();
            },
          ),),
          if(isEditable) Positioned(right: 0, top: 0,child: InkWell(
            child: SvgPicture.asset(Assets.icons.icCloseCircle, width: wValue(15),),
            onTap: (){
              onDelete();
            },
          ),),
        ],
      ),
    );
  }
}
