import 'package:eschool/app/routes.dart';
import 'package:eschool/cubits/studentSubjectsCubit.dart';
import 'package:eschool/data/models/student.dart';
import 'package:eschool/data/repositories/parentRepository.dart';
import 'package:eschool/ui/widgets/borderedProfilePictureContainer.dart';
import 'package:eschool/ui/widgets/customBackButton.dart';
import 'package:eschool/ui/widgets/customShimmerContainer.dart';
import 'package:eschool/ui/widgets/errorContainer.dart';
import 'package:eschool/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool/ui/widgets/shimmerLoaders/subjectsShimmerLoadingContainer.dart';
import 'package:eschool/ui/widgets/shimmerLoadingContainer.dart';
import 'package:eschool/ui/widgets/studentSubjectsContainer.dart';
import 'package:eschool/utils/labelKeys.dart';
import 'package:eschool/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChildDetailsScreen extends StatefulWidget {
  final Student student;
  const ChildDetailsScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<ChildDetailsScreen> createState() => _ChildDetailsScreenState();

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<ChildSubjectsCubit>(
              create: (context) => ChildSubjectsCubit(ParentRepository()),
              child: ChildDetailsScreen(
                student: routeSettings.arguments as Student,
              ),
            ));
  }
}

class _ChildDetailsScreenState extends State<ChildDetailsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ChildSubjectsCubit>().fetchChildSubjects(widget.student.id);
    });
    super.initState();
  }

  Widget _buildAppBar() {
    return Align(
        alignment: Alignment.topCenter,
        child: ScreenTopBackgroundContainer(
          padding: EdgeInsets.all(0),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Stack(
              children: [
                //Bordered circles
                PositionedDirectional(
                  top: MediaQuery.of(context).size.width * (-0.15),
                  start: MediaQuery.of(context).size.width * (-0.225),
                  child: Container(
                    padding:
                        EdgeInsetsDirectional.only(end: 20.0, bottom: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.1)),
                          shape: BoxShape.circle),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.1)),
                        shape: BoxShape.circle),
                    width: MediaQuery.of(context).size.width * (0.6),
                    height: MediaQuery.of(context).size.width * (0.6),
                  ),
                ),

                //bottom fill circle
                PositionedDirectional(
                  bottom: MediaQuery.of(context).size.width * (-0.15),
                  end: MediaQuery.of(context).size.width * (-0.15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.1),
                        shape: BoxShape.circle),
                    width: MediaQuery.of(context).size.width * (0.4),
                    height: MediaQuery.of(context).size.width * (0.4),
                  ),
                ),
                CustomBackButton(
                  topPadding: MediaQuery.of(context).padding.top +
                      UiUtils.appBarContentTopPadding,
                ),
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top +
                            UiUtils.appBarContentTopPadding,
                        left: 10,
                        right: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BorderedProfilePictureContainer(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  Routes.studentProfile,
                                  arguments: widget.student);
                            },
                            heightAndWidthPercentage: 0.16,
                            boxConstraints: boxConstraints,
                            imageUrl: widget.student.image),
                        SizedBox(
                          height: boxConstraints.maxHeight * (0.045),
                        ),
                        Text(widget.student.getFullName(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: boxConstraints.maxHeight * (0.0125),
                        ),
                        Text(
                            "${UiUtils.getTranslatedLabel(context, classKey)} - ${widget.student.classSectionName}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 11.0),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          heightPercentage: UiUtils.appBarBiggerHeightPercentage,
        ));
  }

  Widget _buildInformationShimmerLoadingContainer() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
        left: MediaQuery.of(context).size.width *
            UiUtils.screenContentHorizontalPaddingInPercentage,
        right: MediaQuery.of(context).size.width *
            UiUtils.screenContentHorizontalPaddingInPercentage,
      ),
      height: 80,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Row(
          children: [
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: boxConstraints.maxWidth * (0.225),
            )),
            SizedBox(
              width: boxConstraints.maxWidth * (0.025),
            ),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              width: boxConstraints.maxWidth * (0.475),
            )),
            Spacer(),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: boxConstraints.maxWidth * (0.035),
              height: boxConstraints.maxWidth * (0.07),
              width: boxConstraints.maxWidth * (0.07),
            )),
            SizedBox(
              width: boxConstraints.maxWidth * (0.035),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMenuContainer(
      {required String iconPath,
      required String title,
      Object? arguments,
      required String route}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.of(context).pushNamed(route, arguments: arguments);
        },
        child: Container(
          height: 80,
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 60,
                  child: SvgPicture.asset(iconPath),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.225),
                      borderRadius: BorderRadius.circular(15.0)),
                  width: boxConstraints.maxWidth * (0.225),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.025),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.475),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 17.5,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 22.5,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.035),
                ),
              ],
            );
          }),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1.0,
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              )),
        ),
      ),
    );
  }

  Widget _buildInformationAndMenu() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (0.075)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              UiUtils.getTranslatedLabel(context, informationKey),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * (0.025),
          ),
          _buildMenuContainer(
              route: Routes.childAssignments,
              arguments: {
                "childId": widget.student.id,
                "subjects": context
                    .read<ChildSubjectsCubit>()
                    .getSubjectsForAssignmentContainer()
              },
              iconPath: UiUtils.getImagePath("assignment_icon_parent.svg"),
              title: UiUtils.getTranslatedLabel(context, assignmentsKey)),
          _buildMenuContainer(
              route: Routes.childTeachers,
              arguments: widget.student.id,
              iconPath: UiUtils.getImagePath("attendance_icon.svg"),
              title: UiUtils.getTranslatedLabel(context, teachersKey)),
          _buildMenuContainer(
              route: Routes.childAttendance,
              arguments: widget.student.id,
              iconPath: UiUtils.getImagePath("attendance_icon.svg"),
              title: UiUtils.getTranslatedLabel(context, attendanceKey)),
          _buildMenuContainer(
              route: Routes.childTimeTable,
              arguments: widget.student.id,
              iconPath: UiUtils.getImagePath("timetable_icon.svg"),
              title: UiUtils.getTranslatedLabel(context, timeTableKey)),
          _buildMenuContainer(
              route: Routes.holidays,
              iconPath: UiUtils.getImagePath("holiday_icon.svg"),
              title: UiUtils.getTranslatedLabel(context, holidaysKey)),
        ],
      ),
    );
  }

  Widget _buildSubjectsAndInformationsContainer() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarBiggerHeightPercentage)),
      child: BlocBuilder<ChildSubjectsCubit, ChildSubjectsState>(
        builder: (context, state) {
          if (state is ChildSubjectsFetchSuccess) {
            return Column(
              children: [
                StudentSubjectsContainer(
                  subjects: context.read<ChildSubjectsCubit>().getSubjects(),
                  subjectsTitleKey: subjectsKey,
                  childId: widget.student.id,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.025),
                ),
                _buildInformationAndMenu(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.025),
                ),
              ],
            );
          }
          if (state is ChildSubjectsFetchFailure) {
            return Center(
              child: ErrorContainer(
                errorMessageCode: state.errorMessage,
                onTapRetry: () {
                  context
                      .read<ChildSubjectsCubit>()
                      .fetchChildSubjects(widget.student.id);
                },
              ),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * (0.025),
              ),
              SubjectsShimmerLoadingContainer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * (0.025),
              ),
              ...List.generate(UiUtils.defaultShimmerLoadingContentCount,
                      (index) => index)
                  .map((e) => _buildInformationShimmerLoadingContainer())
                  .toList(),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildSubjectsAndInformationsContainer(),
          _buildAppBar(),
        ],
      ),
    );
  }
}
