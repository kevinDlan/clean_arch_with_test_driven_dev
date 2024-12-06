import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/features/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.userNameController});
  final TextEditingController userNameController;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: "username"),
              ),
              // TextField(
              //   decoration: InputDecoration(labelText: "Created At"),
              // ),
              // TextField(
              //   decoration: InputDecoration(labelText: "Avatar"),
              // )
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  String name = userNameController.text.trim();
                  context.read<AuthenticationCubit>().createUser(
                        name: name,
                        createdAt: DateTime.now().toString(),
                        avatar:
                            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/626.jpg",
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Create user'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
