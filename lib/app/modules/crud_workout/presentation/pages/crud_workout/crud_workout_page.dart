import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/exercise_entity.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/crud_workout/crud_workout_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CrudWorkoutPage extends StatefulWidget {
  const CrudWorkoutPage({Key? key}) : super(key: key);

  @override
  State<CrudWorkoutPage> createState() => _CrudWorkoutPageState();
}

class _CrudWorkoutPageState extends State<CrudWorkoutPage> {
  final CrudWorkoutStore store = Modular.get<CrudWorkoutStore>();

  @override
  void initState() {
    super.initState();

    if (Modular.args.data != null) {
      store.setWorkout(Modular.args.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Treino tal..."),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: store.workout.exercises.length,
              itemBuilder: (_, index) {
                ExerciseEntity exercise = store.workout.exercises[index];
                return Text(exercise.name);
              },
            ),
            CustomElevatedButton(
              label: "Adicionar exercicio",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
