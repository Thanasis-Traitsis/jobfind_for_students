// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/navigation_bar/bloc/navigation_bloc.dart';
import '../../../../config/navigation_bar/scaffold_with_navbar.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/usecases/listen_to_connectivity.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../listings/presentation/job_bloc/job_bloc.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../auth_bloc/auth_bloc.dart';
import 'home_screen.dart';
import 'major_id_screen.dart';

class AuthScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const AuthScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    listenToConnectivity(
      scaffoldKey: scaffoldMessengerKey,
      context: context,
    );

    return Material(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            BlocProvider.of<JobBloc>(context).add(
              GetRecentJobs(),
            );

            BlocProvider.of<NavigationBloc>(context).add(
              NavigationButtonPressed(
                page: PAGES.home.screenPath,
              ),
            );
            return ScaffoldWithNavBar(
              location: PAGES.home.screenPath,
              child: HomeScreen(
                scaffoldMessengerKey: scaffoldMessengerKey,
              ),
            );
          }
          if (state is AuthUnauthenticated) {
            return LoginScreen(
              scaffoldMessengerKey: scaffoldMessengerKey,
            );
          }
          if (state is AuthUniversity) {
            return MajorIdScreen(
              scaffoldMessengerKey: scaffoldMessengerKey,
            );
          }
          if (state is AuthLoading) {
            return Scaffold(
              body: Center(
                child: Transform.scale(
                  scale: 1.2,
                  child: CustomLoading(
                    ColorsConst.primaryColor,
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Transform.scale(
                scale: 1.2,
                child: CustomLoading(
                  ColorsConst.primaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
