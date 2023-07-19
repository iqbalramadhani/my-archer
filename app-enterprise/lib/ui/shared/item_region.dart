import 'package:flutter/material.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemRegion extends StatelessWidget {
  final RegionModel data;
  final Function onClick;
  const ItemRegion({Key? key, required this.data, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data.name}",
            style: regularTextFont.copyWith(fontSize: fontSize(12)),
          ),
          hSpace(5),
          const Divider(),
        ],
      ),
      onTap: () {
        onClick(data);
      },
    );
  }
}
