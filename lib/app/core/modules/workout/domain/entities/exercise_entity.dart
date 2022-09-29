class ExerciseEntity {
  final String name;
  final int numberSeries;
  final String numberRepetitions;
  final String weight;
  final bool hasChecked;
  final bool hasDone;

  ExerciseEntity({
    required this.name,
    required this.numberSeries,
    required this.numberRepetitions,
    required this.weight,
    required this.hasChecked,
    required this.hasDone,
  });

  ExerciseEntity copyWith({
    String? name,
    int? numberSeries,
    String? numberRepetitions,
    String? weight,
    bool? hasChecked,
    bool? hasDone,
  }) {
    return ExerciseEntity(
      name: name ?? this.name,
      numberSeries: numberSeries ?? this.numberSeries,
      numberRepetitions: numberRepetitions ?? this.numberRepetitions,
      weight: weight ?? this.weight,
      hasChecked: hasChecked ?? this.hasChecked,
      hasDone: hasDone ?? this.hasDone,
    );
  }
}
