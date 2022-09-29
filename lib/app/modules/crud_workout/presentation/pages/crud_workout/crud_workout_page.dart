import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/components/custom_textfield.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/exercise_entity.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/crud_workout/crud_workout_store.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/crud_workout/widgets/crud_exercise_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CrudWorkoutPage extends StatefulWidget {
  const CrudWorkoutPage({Key? key}) : super(key: key);

  @override
  State<CrudWorkoutPage> createState() => _CrudWorkoutPageState();
}

class _CrudWorkoutPageState extends State<CrudWorkoutPage> {
  final CrudWorkoutStore store = Modular.get<CrudWorkoutStore>();

  late final TextEditingController nameController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    if (Modular.args.data != null) {
      store.setWorkout(Modular.args.data);
    }

    nameController = TextEditingController(text: store.workout.name);
    contentController = TextEditingController(text: store.workout.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (context) {
            return Text(store.workout.name == "" ? "Treino" : store.workout.name);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: store.key,
          child: Column(
            children: [
              CustomTextfield(
                controller: nameController,
                onChanged: store.setName,
                validator: store.validatorName,
                labelText: "nome",
                hintText: "Ex: Treino A",
                padding: const EdgeInsets.only(top: 15, bottom: 10),
              ),
              CustomTextfield(
                controller: contentController,
                onChanged: store.setContent,
                validator: store.validatorContent,
                labelText: "Descrição",
                hintText: "Ex: Peito",
                padding: const EdgeInsets.only(top: 10, bottom: 10),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: store.workout.exercises.length,
                itemBuilder: (_, index) {
                  ExerciseEntity exercise = store.workout.exercises[index];
                  return Text(
                    exercise.name,
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
              CustomElevatedButton.outlined(
                label: "Adicionar exercicio",
                onPressed: _addExercise,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        label: Modular.args.data != null ? "Editar treino" : "Adicionar treino",
        onPressed: () => store.onPressed(context),
      ),
    );
  }

  Future<void> _addExercise() async {
    var result = await showDialog(
      context: context,
      builder: (context) => const CrudExerciseWidget(),
    );

    if (result != null) {
      store.workout.exercises.add(result);
    }
  }
}
