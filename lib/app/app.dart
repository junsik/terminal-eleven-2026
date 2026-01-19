// 앱 진입점

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes.dart';
import '../presentation/widgets/retro_theme.dart';

class MudSoccerApp extends ConsumerWidget {
  const MudSoccerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'MUD 축구',
      debugShowCheckedModeBanner: false,
      theme: RetroTheme.darkTheme,
      routerConfig: router,
    );
  }
}
