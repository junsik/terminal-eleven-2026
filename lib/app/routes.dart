// 라우팅 설정

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/providers.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/training/training_screen.dart';
import '../presentation/match/match_screen.dart';
import '../presentation/summary/summary_screen.dart';
import '../presentation/career/career_screen.dart';
import '../presentation/lobby/lobby_screen.dart';
import '../presentation/inbox/inbox_screen.dart';
import '../presentation/standings/standings_screen.dart';

/// GoRouter Provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'lobby',
        builder: (context, state) => const LobbyScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/training',
        name: 'training',
        builder: (context, state) => const TrainingScreen(),
      ),
      GoRoute(
        path: '/match',
        name: 'match',
        builder: (context, state) => const MatchScreen(),
      ),
      GoRoute(
        path: '/summary',
        name: 'summary',
        builder: (context, state) => const SummaryScreen(),
      ),
      GoRoute(
        path: '/career',
        name: 'career',
        builder: (context, state) => const CareerScreen(),
      ),
      GoRoute(
        path: '/inbox',
        name: 'inbox',
        builder: (context, state) => const InboxScreen(),
      ),
      GoRoute(
        path: '/standings',
        name: 'standings',
        builder: (context, state) => const StandingsScreen(),
      ),
    ],
    redirect: (context, state) {
      // 게임 상태에 따른 리다이렉트
      final container = ProviderScope.containerOf(context, listen: false);
      final gameState = container.read(gameStateProvider);

      if (gameState == null && state.matchedLocation != '/') {
        return '/';
      }

      return null;
    },
  );
});
