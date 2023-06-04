import 'package:go_router/go_router.dart';
import 'package:hive_db_demo/model/note.dart';
import 'package:hive_db_demo/screen/screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'noteScreen',
            name: 'noteScreen',
            builder: (context, state) => NoteScreen(note: state.extra as Note?,),
          ),
        ],
      ),
    ],
  );
}
