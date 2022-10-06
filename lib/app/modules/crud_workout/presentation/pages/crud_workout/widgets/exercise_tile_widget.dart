import 'package:fit_training_clean/app/core/modules/workout/domain/entities/exercise_entity.dart';
import 'package:flutter/material.dart';

class ExerciseTileWidget extends StatelessWidget {
  final ExerciseEntity exercise;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const ExerciseTileWidget({
    Key? key,
    required this.exercise,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        exercise.name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        "${exercise.numberSeries} x ${exercise.numberRepetitions} ${exercise.weight.isEmpty ? "" : exercise.weight}",
        style: const TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.white),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
