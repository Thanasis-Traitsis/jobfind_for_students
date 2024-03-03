import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/custom_adaptive_dialog.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/usecases/boolean_is_company.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../../auth/presentation/widgets/complete_account/first_step.dart';
import '../widgets/job_listings_cards_container.dart';
import '../widgets/more_buttons_container.dart';
import '../widgets/profile_page_header.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const ProfileScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = Hive.box<UserModel>('user').get('userModel');

    onLogoutButtonPressed() {
      showAdaptiveDialog(
        context: context,
        builder: (context) {
          return CustomAdaptiveDialog(
            context: context,
            heading: 'Έξοδος',
            text: 'Είστε σίγουρος ότι θέλετε να αποσυνδεθείτε;',
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutButtonPressed());
            },
          );
        },
      );
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: ColorsConst.white,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      padding,
                    ),
                    child: Column(
                      children: [
                        ProfilePageHeader(
                          context: context,
                          user: user!,
                          scaffoldMessengerKey: scaffoldMessengerKey,
                        ),
                        user.complete!['profile']
                            ? Container()
                            : Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: gap / 2),
                                padding: const EdgeInsets.all(padding),
                                decoration: BoxDecoration(
                                  color: ColorsConst.lightgreyColor
                                      .withOpacity(.2),
                                  border: Border.all(
                                    color: ColorsConst.lightgreyColor,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(borderRadius),
                                  ),
                                ),
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return FirstStep(
                                        context: context,
                                        completedProfileStep:
                                            user.complete!['profile'],
                                        completedResume: state
                                                is AuthAuthenticated
                                            ? state.user!.resume_path != null &&
                                                state.user!.resume_path != ''
                                            : false,
                                        completedImage: state
                                                is AuthAuthenticated
                                            ? state.user!.avatar_path != null &&
                                                state.user!.avatar_path != ''
                                            : user.avatar_path != null &&
                                                user.avatar_path != '',
                                        profileScreen: true,
                                        isStudent: user.role! == 'user' ||
                                            user.role! == 'old_student');
                                  },
                                ),
                              ),
                        JobListingsCardsContainer(
                          context: context,
                          isCompany: booleanIsCompany(user.role),
                        ),
                        const SizedBox(
                          height: gap,
                        ),
                        MoreButtonsContainer(
                          context: context,
                          logoutPressed: onLogoutButtonPressed,
                          role: user.role!,
                          scaffoldMessengerKey: scaffoldMessengerKey,
                          isCompany: booleanIsCompany(user.role),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
