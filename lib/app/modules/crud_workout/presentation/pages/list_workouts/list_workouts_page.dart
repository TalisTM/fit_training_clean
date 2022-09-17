import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/list_workouts/list_workouts_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListWorkoutsPage extends StatefulWidget {
  const ListWorkoutsPage({Key? key}) : super(key: key);

  @override
  State<ListWorkoutsPage> createState() => _ListWorkoutsPageState();
}

class _ListWorkoutsPageState extends State<ListWorkoutsPage> {
  final ListWorkoutsStore store = Modular.get<ListWorkoutsStore>();

  late List<WorkoutEntity> workouts;

  @override
  void initState() {
    super.initState();

    workouts = store.authStore.user!.workouts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar treinos"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: workouts.length,
              itemBuilder: (_, index) {
                return Text(workouts[index].name);
              },
            ),
            CustomElevatedButton(
              label: "Adicionar treino",
              onPressed: store.onAddWorkout
            )
          ],
        ),
      ),
    );
  }
}
