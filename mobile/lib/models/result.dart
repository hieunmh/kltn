class Result {
  final int evaluate;
  final String explain;

  Result({
    required this.evaluate, 
    required this.explain
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      evaluate: json['evaluate'] is int ? json['evaluate'] : int.parse(json['evaluate'].toString()),
      explain: json['explain']?.toString() ?? '',
    );
  }
}