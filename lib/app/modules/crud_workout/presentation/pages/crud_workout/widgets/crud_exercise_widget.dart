import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/components/custom_textfield.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/exercise_entity.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/crud_workout/widgets/crud_exercise_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CrudExerciseWidget extends StatefulWidget {
  final ExerciseEntity? exercise;
  const CrudExerciseWidget({
    Key? key,
    this.exercise,
  }) : super(key: key);

  @override
  State<CrudExerciseWidget> createState() => _CrudExerciseWidgetState();
}

class _CrudExerciseWidgetState extends State<CrudExerciseWidget> {
  CrudExerciseStore store = Modular.get<CrudExerciseStore>();

  late final TextEditingController nameController;
  late final TextEditingController numberRepetitionsController;
  late final TextEditingController weightController;

  @override
  void initState() {
    super.initState();

    if (widget.exercise != null) {
      store.setExercise(widget.exercise!);
    } else {
      store.setExercise(
        ExerciseEntity(
          name: "",
          hasChecked: false,
          hasDone: false,
          numberRepetitions: "",
          numberSeries: 3,
          weight: "",
        ),
      );
    }
    nameController = TextEditingController(text: store.exercise.name);
    numberRepetitionsController = TextEditingController(text: store.exercise.numberRepetitions);
    weightController = TextEditingController(text: store.exercise.weight);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: store.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Exercício",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CustomTextfield(
                controller: nameController,
                onChanged: store.setName,
                validator: store.validatorName,
                labelText: "nome",
                hintText: "Ex: supino reto",
                padding: const EdgeInsets.only(top: 15, bottom: 10),
              ),
              const Text(
                "Quantidade de séries",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.indeterminate_check_box_rounded,
                        color: Theme.of(context).primaryColor),
                    onPressed: store.onReduceNumberSeries,
                  ),
                  Observer(builder: (context) {
                    return Text(
                      store.exercise.numberSeries.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                  IconButton(
                    icon: Icon(Icons.add_box_rounded, color: Theme.of(context).primaryColor),
                    onPressed: store.onAddNumberSeries,
                  ),
                ],
              ),
              CustomTextfield(
                controller: numberRepetitionsController,
                onChanged: store.setNumberRepetitions,
                validator: store.validatorNumberRepetitions,
                labelText: "Repetições",
                hintText: "Ex: 8-12",
              ),
              CustomTextfield(
                controller: weightController,
                onChanged: store.setweight,
                validator: store.validatorweight,
                labelText: "peso (opcional)",
                hintText: "Ex: 12",
                padding: const EdgeInsets.only(top: 15, bottom: 15),
              ),
              CustomElevatedButton(
                label: widget.exercise != null ? "Editar" : "Adicionar",
                onPressed: store.onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
