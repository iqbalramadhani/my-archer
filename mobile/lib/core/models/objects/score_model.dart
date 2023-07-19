class ScoreModel {
  List<dynamic>? one;
  List<dynamic>? two;
  List<dynamic>? three;
  List<dynamic>? four;
  List<dynamic>? five;
  List<dynamic>? six;

  ScoreModel(this.one, this.two, this.three, this.four, this.five, this.six);

  ScoreModel.none();

  ScoreModel.fromJson(Map<String, dynamic> json)
      : one = json['1'],
        two = json['2'],
        three = json['3'],
        four = json['4'],
        five = json['5'],
        six = json['6'];

  Map<String, dynamic> toJson() =>
      {'1': one, '2': two, '3': three, '4': four, '5': five, '6': six};
}
