import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'config/navigation_bar/bloc/navigation_bloc.dart';
import 'config/routes/routes.dart';
import 'config/theme/app_theme.dart';
import 'core/utils/routes_utils.dart';
import 'features/applicants_list/presentation/applicants_list_bloc/applicants_list_bloc.dart';
import 'features/auth/data/models/user_model.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'features/auth/presentation/major_id_bloc/major_id_bloc.dart';
import 'features/favourite/data/repositories/favourite_repositories_impl.dart';
import 'features/favourite/presentation/favourite_bloc/favourite_bloc.dart';
import 'features/job_details/presentation/job_details_bloc/job_details_bloc.dart';
import 'features/listings/data/repositories/job_card_repositories_impl.dart';
import 'features/listings/data/repositories/job_repositories_impl.dart';
import 'features/listings/presentation/job_bloc/job_bloc.dart';
import 'features/listings/presentation/job_card_bloc/job_card_bloc.dart';
import 'features/login/data/repositories/login_repositories_impl.dart';
import 'features/login/presentation/login_bloc/login_bloc.dart';
import 'features/new_listing/data/repositories/new_listings_repositories_impl.dart';
import 'features/new_listing/presentation/new_listing_bloc/new_listing_bloc.dart';
import 'features/profile/data/repositories/profile_repositories_impl.dart';
import 'features/profile/presentation/edit_account_bloc/edit_account_bloc.dart';
import 'features/profile/presentation/image_bloc/image_bloc.dart';
import 'features/profile/presentation/request_degree_bloc/request_degree_bloc.dart';
import 'features/profile/presentation/resume_bloc/resume_bloc.dart';
import 'features/signup/data/repositories/signup_repositories_impl.dart';
import 'features/signup/presentation/signup_bloc/signup_bloc.dart';
import 'features/user_listings/data/repositories/user_listing_repositories_impl.dart';
import 'features/user_listings/presentation/user_listing_bloc/user_listing_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('user');

  final loginRepositoriesImpl = LoginRepositoriesImpl();
  final signupRepositoriesImpl = SignupRepositoriesImpl();
  final authRepositoriesImpl = AuthRepositoriesImpl();
  final jobRepositoriesImpl = JobRepositoriesImpl();
  final jobCardRepositoriesImpl = JobCardRepositoriesImpl();
  final favRepositoriesImpl = FavouriteRepositoriesImpl();
  final userListingRepositoriesImpl = UserListingRepositoriesImpl();
  final profileRepositoriesImpl = ProfileRepositoriesImpl();
  final newListingsRepositoriesImpl = NewListingsRepositoriesImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepo: authRepositoriesImpl,
            loginRepo: loginRepositoriesImpl,
            signupRepo: signupRepositoriesImpl,
          )..add(AppStarted()),
        ),
        BlocProvider<MajorIdBloc>(
          create: (context) {
            return MajorIdBloc(
              authRepo: authRepositoriesImpl,
            );
          },
        ),
        BlocProvider<LoginBloc>(
          create: (context) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            return LoginBloc(
              loginRepositoriesImpl: loginRepositoriesImpl,
              authBloc: authBloc,
            );
          },
        ),
        BlocProvider<SignupBloc>(
          create: (context) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            return SignupBloc(
              signupRepositoriesImpl: signupRepositoriesImpl,
              authBloc: authBloc,
            );
          },
        ),
        BlocProvider<NavigationBloc>(
          create: (context) {
            return NavigationBloc()
              ..add(
                NavigationButtonPressed(
                  page: PAGES.home.screenName,
                ),
              );
          },
        ),
        BlocProvider<JobBloc>(
          create: (context) {
            return JobBloc(
              jobRepo: jobRepositoriesImpl,
            )..add(GetRecentJobs());
          },
        ),
        BlocProvider<JobCardBloc>(
          create: (context) {
            return JobCardBloc(
              jobCardRepo: jobCardRepositoriesImpl,
            );
          },
        ),
        BlocProvider<FavouriteBloc>(
          create: (context) {
            return FavouriteBloc(
              favRepo: favRepositoriesImpl,
            );
          },
        ),
        BlocProvider<JobDetailsBloc>(
          create: (context) {
            return JobDetailsBloc();
          },
        ),
        BlocProvider<UserListingBloc>(
          create: (context) {
            return UserListingBloc(
              userListingRepo: userListingRepositoriesImpl,
            );
          },
        ),
        BlocProvider<ApplicantsListBloc>(
          create: (context) {
            return ApplicantsListBloc(
              userListingRepo: userListingRepositoriesImpl,
            );
          },
        ),
        BlocProvider<EditAccountBloc>(
          create: (context) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            return EditAccountBloc(
              profileRepositoriesImpl: profileRepositoriesImpl,
              authBloc: authBloc,
            );
          },
        ),
        BlocProvider<NewListingBloc>(
          create: (context) {
            return NewListingBloc(
              newListingsRepositoriesImpl: newListingsRepositoriesImpl,
            );
          },
        ),
        BlocProvider<RequestDegreeBloc>(
          create: (context) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            return RequestDegreeBloc(
              profileRepositoriesImpl: profileRepositoriesImpl,
              authBloc: authBloc,
              authRepo: authRepositoriesImpl,
            );
          },
        ),
        BlocProvider<ResumeBloc>(
          create: (context) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            return ResumeBloc(
              profileRepositoriesImpl: profileRepositoriesImpl,
              authRepo: authRepositoriesImpl,
              authBloc: authBloc,
            );
          },
        ),
        BlocProvider<ImageBloc>(
          create: (context) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            return ImageBloc(
              profileRepositoriesImpl: profileRepositoriesImpl,
              authRepo: authRepositoriesImpl,
              authBloc: authBloc,
            );
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();
    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldKey,
      title: 'New Project',
      routerConfig: AppRouter(
        scaffoldMessengerKey: scaffoldKey,
        rootNavigatorKey: rootNavigatorKey,
        shellNavigatorKey: shellNavigatorKey,
      ).router,
      theme: AppTheme().lightTheme,
    );
  }
}
