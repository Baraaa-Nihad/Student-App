import 'package:eschool/cubits/resultsCubit.dart';
import 'package:eschool/data/repositories/studentRepository.dart';
import 'package:eschool/ui/widgets/resultsContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildResultsScreen extends StatelessWidget {
  final int childId;
  const ChildResultsScreen({Key? key, required this.childId}) : super(key: key);

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<ResultsCubit>(
              create: (context) => ResultsCubit(StudentRepository()),
              child:
                  ChildResultsScreen(childId: routeSettings.arguments as int),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResultsContainer(
        childId: childId,
      ),
    );
  }
}
