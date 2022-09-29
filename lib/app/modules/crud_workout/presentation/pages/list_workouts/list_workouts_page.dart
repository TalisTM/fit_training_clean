import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/list_workouts/list_workouts_store.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/list_workouts/widgets/workout_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListWorkoutsPage extends StatefulWidget {
  const ListWorkoutsPage({Key? key}) : super(key: key);

  @override
  State<ListWorkoutsPage> createState() => _ListWorkoutsPageState();
}

class _ListWorkoutsPageState extends State<ListWorkoutsPage> {
  final ListWorkoutsStore store = Modular.get<ListWorkoutsStore>();

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
            Observer(builder: (context) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: store.workouts.length,
                itemBuilder: (_, index) {
                  WorkoutEntity workout = store.workouts[index];

                  return WorkoutTileWidget(
                    name: workout.name,
                    content: workout.content,
                    onTap: () {
                      store.onEditWorkout(index);
                    },
                    onDelete: () {
                      store.onDelete(index);
                    },
                  );
                },
              );
            }),
            CustomElevatedButton(label: "Adicionar treino", onPressed: store.onAddWorkout)
          ],
        ),
      ),
    );
  }
}
