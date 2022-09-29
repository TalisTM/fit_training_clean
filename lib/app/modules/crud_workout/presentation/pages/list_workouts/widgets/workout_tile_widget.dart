import 'package:flutter/material.dart';

class WorkoutTileWidget extends StatelessWidget {
  final String name;
  final String content;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const WorkoutTileWidget({
    Key? key,
    required this.name,
    required this.content,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        content,
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
