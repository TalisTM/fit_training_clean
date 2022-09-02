import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  final UserEntity user;
  final VoidCallback logout;
  const AppBarHomeWidget({Key? key, required this.user, required this.logout}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(300);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(300),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          color: Theme.of(context).primaryColor,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(user.photoUrl, height: 50),
                        ),
                        const SizedBox(width: 15),
                        Text.rich(
                          TextSpan(
                            text: "Olá, ",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout_outlined),
                      onPressed: logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
