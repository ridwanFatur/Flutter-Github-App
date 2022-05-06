import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/search_bloc_cubit.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/config_constants.dart';
import 'package:github_app/utils/size_responsive_helper.dart';
import 'package:github_app/widgets/options_type_widget.dart';
import 'package:github_app/widgets/panel_pagination.dart';
import 'package:github_app/widgets/result_search_widget.dart';
import 'package:github_app/widgets/search_text_field.dart';
import 'package:github_app/widgets/search_type_widget.dart';
import 'dart:async';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: "Press back again to close",
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          floatingActionButton: BlocBuilder<SearchBlocCubit, SearchBlocState>(
            builder: (context, state) {
              if (state.optionType == OptionTypeConstant.LAZY_LOADING &&
                  state.query.isNotEmpty &&
                  !state.isLoadingFirstAttempt &&
                  !state.isErrorFirstAttempt &&
                  state.data.isNotEmpty) {
                return FloatingActionButton(
                  elevation: 10,
                  onPressed: () async {
                    _scrollController.animateTo(
                      0,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  },
                  backgroundColor: state.searchType == SearchTypeConstant.ISSUES
                      ? Colors.white
                      : kColorPrimary,
                  child: Icon(
                    Icons.arrow_upward,
                    color: state.searchType == SearchTypeConstant.ISSUES
                        ? kColorPrimary
                        : Colors.white,
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          body: SafeArea(
            child: Stack(
              children: [
                NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxScrolled) {
                    return <Widget>[
                      textSearchWidget(),
                      optionsSectionWidget(),
                    ];
                  },
                  body: ResultSearchWidget(),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: PanelPagination(
                    listWidget: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Testing"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar textSearchWidget() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      toolbarHeight: Responsive.textSearchHeight(context),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SearchTextField(
          controller: _searchTextController,
          hintText: "Search",
          onChanged: (value) {
            if (_debounce?.isActive ?? false) {
              _debounce?.cancel();
            }

            _debounce = Timer(const Duration(milliseconds: 500), () {
              BlocProvider.of<SearchBlocCubit>(context).changeQuery(value);
            });
          },
        ),
      ),
    );
  }

  SliverAppBar optionsSectionWidget() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      toolbarHeight: Responsive.optionsSectionHeight(context),
      title: SizedBox(
        width: double.infinity,
        height: Responsive.optionsSectionHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchTypeWidget(),
            SizedBox(height: 10),
            OptionsTypeWidget(),
          ],
        ),
      ),
    );
  }
}
