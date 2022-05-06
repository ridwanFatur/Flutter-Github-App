import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/search_bloc_cubit.dart';
import 'package:github_app/utils/config_constants.dart';
import 'package:github_app/widgets/search_section_chip.dart';

class SearchTypeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBlocCubit, SearchBlocState>(
        builder: (context, state) {
      int indexSearchType = state.searchType;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SearchSectionChip(
              onPressed: () {
                BlocProvider.of<SearchBlocCubit>(context).changeSearchType(SearchTypeConstant.USER);
              },
              isActive: indexSearchType == SearchTypeConstant.USER,
              title: "User",
            ),
            SearchSectionChip(
              onPressed: () {
                BlocProvider.of<SearchBlocCubit>(context).changeSearchType(SearchTypeConstant.ISSUES);
              },
              isActive: indexSearchType == SearchTypeConstant.ISSUES,
              title: "Issues",
            ),
            SearchSectionChip(
              onPressed: () {
                BlocProvider.of<SearchBlocCubit>(context).changeSearchType(SearchTypeConstant.REPOSITORIES);
              },
              isActive: indexSearchType == SearchTypeConstant.REPOSITORIES,
              title: "Repositories",
            ),
          ],
        ),
      );
    });
  }
}
