import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/search_bloc_cubit.dart';
import 'package:github_app/utils/config_constants.dart';
import 'package:github_app/widgets/empty_list_widget.dart';
import 'package:github_app/widgets/error_widget.dart';
import 'package:github_app/widgets/content_data_widget.dart';
import 'package:github_app/widgets/query_empty_widget.dart';
import 'package:github_app/widgets/shimmer_loading_widget.dart';

class ResultSearchWidget extends StatefulWidget {
  @override
  State<ResultSearchWidget> createState() => _ResultSearchWidgetState();
}

class _ResultSearchWidgetState extends State<ResultSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBlocCubit, SearchBlocState>(
      builder: (context, state) {
        if (state.query.isEmpty) {
          return QueryEmptyWidget();
        }

        if (state.isLoadingFirstAttempt) {
          return ShimmerLoadingWidget();
        }

        if (state.isErrorFirstAttempt) {
          return ErrorStateWidget(
            errorMessage: state.errorFirstAttempt,
            onPressed: () {
              BlocProvider.of<SearchBlocCubit>(context).reload();
            },
          );
        }

        if (state.data.length == 1 && state.data[0]["list"].length == 0) {
          return EmptyListWidget();
        }

        if (state.optionType == OptionTypeConstant.WITH_INDEX && state.isLoadingWithIndex) {
          return ShimmerLoadingWidget();
        }

        if (state.optionType == OptionTypeConstant.WITH_INDEX && state.isErrorWithIndex) {
          String errorMessage = state.errorWithIndex;
          return ErrorStateWidget(
            errorMessage: errorMessage,
            onPressed: () {
              BlocProvider.of<SearchBlocCubit>(context).requestDataWithIndex();
            },
          );
        }

        return ContentDataWidget();
      },
    );
  }
}
