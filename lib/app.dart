import 'package:db_helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pizza_repo/pizza_repo.dart';

import 'blocs/blocs.dart';
import 'constants/app.dart' as const_app;
import 'constants/routes.dart' as const_routes;
import 'l10n/l10n.dart';
import 'screen_router.dart';
import 'themes/themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PizzaRepoImpl(DBHelperImpl()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AdminBloc(
              context.read<PizzaRepoImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) => PizzaBloc(
              context.read<AdminBloc>(),
              context.read<PizzaRepoImpl>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: const_app.appName,
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ru', ''),
            Locale('en', ''),
          ],
          navigatorKey: ScreenRouter.inst.navigatorKey,
          onGenerateInitialRoutes: (_) => [
            ScreenRouter.inst.navigate(
              const RouteSettings(name: const_routes.home),
            ),
          ],
          onGenerateRoute: ScreenRouter.inst.navigate,
        ),
      ),
    );
  }
}
