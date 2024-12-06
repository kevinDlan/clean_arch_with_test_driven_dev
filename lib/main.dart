import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/core/services/injection_container.dart';
import 'package:tdd_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_app/features/authentication/presentation/screens/home_screen.dart';

import 'core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: MaterialApp(
        title: 'TDD App',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}

// https://mockapi.io/projects/672fd27c66e42ceaf15ecc10
// https://docs.flutter.dev/perf/impeller
