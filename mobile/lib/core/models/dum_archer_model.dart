
import 'package:my_archery/core/models/shoots_record_model.dart';

class DumArcherModel{
  int? id;
  String? name;
  String? session;
  String? category;
  int? distance;
  List<ShootsRecordModel>? shoots;


  DumArcherModel(this.id, this.name, this.session, this.category, this.distance, this.shoots);

  DumArcherModel.data();
}