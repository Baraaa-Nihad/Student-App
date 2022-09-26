import 'package:eschool/app/routes.dart';
import 'package:eschool/cubits/appConfigurationCubit.dart';
import 'package:eschool/cubits/authCubit.dart';
import 'package:eschool/ui/widgets/errorContainer.dart';
import 'package:eschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<AppConfigurationCubit>().fetchAppConfiguration();
    });
  }

  void navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 1));
    if (context.read<AuthCubit>().state is Unauthenticated) {
      Navigator.of(context).pushReplacementNamed(Routes.auth);
    } else {
      Navigator.of(context).pushReplacementNamed(
          (context.read<AuthCubit>().state as Authenticated).isStudent
              ? Routes.home
              : Routes.parentHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppConfigurationCubit, AppConfigurationState>(
        listener: (context, state) {
          if (state is AppConfigurationFetchSuccess) {
            navigateToNextScreen();
          }
        },
        builder: (context, state) {
          if (state is AppConfigurationFetchFailure) {
            return Center(
              child: ErrorContainer(
                  onTapRetry: () {
                    context
                        .read<AppConfigurationCubit>()
                        .fetchAppConfiguration();
                  },
                  errorMessageCode: UiUtils.getErrorMessageFromErrorCode(
                      context, state.errorMessage)),
            );
          }
          return Center(
              child: SvgPicture.asset(UiUtils.getImagePath("appLogo.svg")));
        },
      ),
    );
  }
}
