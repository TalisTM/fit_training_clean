import 'package:flutter/material.dart';

class AbstractDatasWidget extends StatelessWidget {
  final int amountDone;
  final VoidCallback edit;
  const AbstractDatasWidget({Key? key, required this.amountDone, required this.edit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            color: Theme.of(context).primaryColor,
          ),
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          height: 60,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text(
                  "EDITAR",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {},
              ),
              Text(
                "$amountDone Feitos",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
