import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/search_bloc_cubit.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/config_constants.dart';
import 'package:github_app/utils/size_responsive_helper.dart';
import 'package:github_app/widgets/error_widget.dart';
import 'package:github_app/widgets/issue_item_widget.dart';
import 'package:github_app/widgets/repository_item_widget.dart';
import 'package:github_app/widgets/user_item_widget.dart';

class ContentDataWidget extends StatefulWidget {
  @override
  State<ContentDataWidget> createState() => ContentDataWidgetState();
}

class ContentDataWidgetState extends State<ContentDataWidget> {
  Key centerKey = ValueKey('center-list');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBlocCubit, SearchBlocState>(
        builder: (context, state) {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          final maxScroll = scrollNotification.metrics.maxScrollExtent;
          final minScroll = scrollNotification.metrics.minScrollExtent;

          final currentScroll = scrollNotification.metrics.pixels;

          if (currentScroll == maxScroll) {
            BlocProvider.of<SearchBlocCubit>(context).loadBottomPagination();
            return true;
          }

          if (currentScroll == minScroll) {
            BlocProvider.of<SearchBlocCubit>(context).loadTopPagination();
            return true;
          }

          
          return false;
        },
        child: CustomScrollView(
          center: centerKey,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return topPaginationWidget(state);
                },
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: listTopPaginationWidget(state),
                  );
                },
                childCount: 1,
              ),
            ),
            SliverList(
              key: centerKey,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return Column(
                      children: listBottomPaginationWidget(state),
                    );
                  } else if (index == 1) {
                    return bottomPaginationWidget(state);
                  } else {
                    return state.optionType == OptionTypeConstant.WITH_INDEX
                        ? SizedBox(height: Responsive.paddingBottomContentData(context))
                        : SizedBox(height: 0);
                  }
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget bottomPaginationWidget(SearchBlocState state) {
    if (state.optionType == OptionTypeConstant.WITH_INDEX) {
      return SizedBox();
    }

    if (state.isErrorBottomPagination) {
      String errorMessage = state.errorBottomPagination;
      return ErrorStateWidget(
        errorMessage: errorMessage,
        onPressed: () {
          BlocProvider.of<SearchBlocCubit>(context).reloadBottomPagination();
        },
      );
    }

    if (state.currentBottomPage < state.totalPage &&
        state.isLoadingBottomPagination) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: CircularProgressIndicator(
            color: kColorPrimary,
          ),
        ),
      );
    } else {
      return SizedBox(height: 30);
    }
  }

  Widget topPaginationWidget(SearchBlocState state) {
    if (state.optionType == OptionTypeConstant.WITH_INDEX) {
      return SizedBox();
    }

    if (state.isErrorTopPagination) {
      String errorMessage = state.errorTopPagination;
      return ErrorStateWidget(
        errorMessage: errorMessage,
        onPressed: () {
          BlocProvider.of<SearchBlocCubit>(context).reloadTopPagination();
        },
      );
    }

    if (state.currentTopPage > 1) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: CircularProgressIndicator(
            color: kColorPrimary,
          ),
        ),
      );
    } else {
      return SizedBox(height: 10);
    }
  }

  List<Widget> listTopPaginationWidget(SearchBlocState state) {
    return List.generate(
      state.data.length,
      (index) {
        var mapData = state.data[index];
        int page = mapData["page"];
        List items = mapData["list"];
        GlobalKey key = mapData["key"];

        if (state.optionType == OptionTypeConstant.LAZY_LOADING && page < state.showedPageNumber) {
          // Lazy Loading
          return Column(
            key: key,
            children: List.generate(items.length, (index) {
              return pageItemRender(state, items, index);
            }),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  List<Widget> listBottomPaginationWidget(SearchBlocState state) {
    return List.generate(
      state.data.length,
      (index) {
        var mapData = state.data[index];
        int page = mapData["page"];
        List items = mapData["list"];
        GlobalKey key = mapData["key"];

        if (state.optionType == OptionTypeConstant.WITH_INDEX && state.showedPageNumber == page) {
          //With Index
          return Column(
            key: key,
            children: List.generate(items.length, (index) {
              return pageItemRender(state, items, index);
            }),
          );
        } else if (state.optionType == OptionTypeConstant.LAZY_LOADING && page >= state.showedPageNumber) {
          // Lazy Loading
          return Column(
            key: key,
            children: List.generate(items.length, (index) {
              return pageItemRender(state, items, index);
            }),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget pageItemRender(SearchBlocState state, var items, index) {
    if (state.searchType == SearchTypeConstant.USER) {
      return UserItemWidget(info: items[index]);
    } else if (state.searchType == SearchTypeConstant.ISSUES) {
      return IssueItemWidget(info: items[index]);
    } else if (state.searchType == SearchTypeConstant.REPOSITORIES) {
      return RepositoryItemWidget(info: items[index]);
    }

    return SizedBox();
  }
}
