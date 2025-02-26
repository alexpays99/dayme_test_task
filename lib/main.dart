import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/http_service.dart';
import 'core/theme/app_theme.dart';
import 'features/game/data/repositories/game_repository.dart';
import 'features/game/presentation/bloc/game/game_bloc.dart';
import 'features/game/presentation/bloc/game/game_event.dart';
import 'features/game/presentation/screens/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Обирай Серцем',
      theme: AppTheme.light,
      home: RepositoryProvider(
        create: (context) => GameRepository(
          httpService: HttpService(),
        ),
        child: BlocProvider(
          create: (context) => GameBloc(
            context.read<GameRepository>(),
          )..add(LoadGame()),
          child: const GameScreen(),
        ),
      ),
    );
  }
}
