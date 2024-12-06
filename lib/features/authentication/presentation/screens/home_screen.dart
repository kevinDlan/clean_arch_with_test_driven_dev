import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_app/features/authentication/presentation/widgets/loader_widget.dart';

import '../widgets/add_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController userNameTextFieldController =
      TextEditingController();

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              // context.read<AuthenticationCubit>().createUser(
              //     name: "Kevin KONE", createdAt: DateTime.now().toString(), avatar: "avatar");
              await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => AddUserDialog(
                  userNameController: userNameTextFieldController,
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add User"),
          ),
          body: state is GettingUser
              ? const LoaderWidget(message: "Fetching Users")
              : state is CreatingUser
                  ? const LoaderWidget(message: "Creating users")
                  : state is UserLoaded
                      ? Center(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              return ListTile(
                                leading: Image.network(user.avatar),
                                title: Text(user.name),
                                subtitle: Text(
                                  user.createdAt.substring(10),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
        );
      },
    );
  }
}
