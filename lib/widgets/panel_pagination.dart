import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/search_bloc_cubit.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/config_constants.dart';

class PanelPagination extends StatefulWidget {
  final List<Widget> listWidget;
  PanelPagination({required this.listWidget});

  @override
  State<PanelPagination> createState() => _PanelPaginationState();
}

class _PanelPaginationState extends State<PanelPagination>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> animationRotate;
  late bool openPanel;

  @override
  void initState() {
    super.initState();
    openPanel = false;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationRotate =
        Tween<double>(begin: 0, end: pi / 2).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void setOpen() {
    if (!openPanel) {
      animationController.forward();
      openPanel = true;
      setState(() {});
    }
  }

  void setClose() {
    if (openPanel) {
      animationController.reverse();
      openPanel = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBlocCubit, SearchBlocState>(
      buildWhen: (previousState, state) {
        return true;
      },
      builder: (BuildContext context, state) {
        return Material(
          elevation: 10,
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1.0,
            axis: Axis.vertical,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardPagination(
                    "1",
                    onPressed: () {
                      BlocProvider.of<SearchBlocCubit>(context)
                          .changeShowedPageNumber(1);
                    },
                    isShowed: state.showedPageNumber - 2 >= 1,
                  ),
                  cardPagination(
                    "...",
                    isShowed: state.showedPageNumber - 2 > 1,
                  ),
                  cardPagination(
                    "${state.showedPageNumber - 1}",
                    onPressed: () {
                      BlocProvider.of<SearchBlocCubit>(context)
                          .changeShowedPageNumber(state.showedPageNumber - 1);
                    },
                    isShowed: state.showedPageNumber > 1,
                  ),
                  cardPagination(
                    "${state.showedPageNumber}",
                    isShowed: true,
                    isCurrentPage: true,
                  ),
                  cardPagination(
                    "${state.showedPageNumber + 1}",
                    onPressed: () {
                      BlocProvider.of<SearchBlocCubit>(context)
                          .changeShowedPageNumber(state.showedPageNumber + 1);
                    },
                    isShowed: state.showedPageNumber + 1 < state.totalPage,
                  ),
                  cardPagination(
                    "...",
                    isShowed: state.showedPageNumber + 2 < state.totalPage,
                  ),
                  cardPagination(
                    "${state.totalPage}",
                    onPressed: () {
                      BlocProvider.of<SearchBlocCubit>(context)
                          .changeShowedPageNumber(state.totalPage);
                    },
                    isShowed: state.showedPageNumber != state.totalPage,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {
        if (state.optionType == OptionTypeConstant.LAZY_LOADING) {
          setClose();
        } else if (state.optionType == OptionTypeConstant.WITH_INDEX) {
          if (state.query.isNotEmpty &&
              !state.isLoadingFirstAttempt &&
              !state.isErrorFirstAttempt &&
              state.data.isNotEmpty) {
            setOpen();
          } else {
            setClose();
          }
        }
      },
    );
  }

  Widget cardPagination(String caption,
      {VoidCallback? onPressed, required bool isShowed, bool? isCurrentPage}) {
    if (isShowed) {
      double cardSize = (MediaQuery.of(context).size.width - 40) / 7;
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: cardSize,
        color: isCurrentPage != null ? kColorPrimary : Colors.white,
        constraints: BoxConstraints(
          minHeight: 50,
        ),
        child: InkWell(
          onTap: onPressed,
          splashFactory: InkRipple.splashFactory,
          child: Center(
            child: Text(
              caption,
              style: TextStyle(
                fontSize: 16,
                color: isCurrentPage != null ? Colors.white : kColorPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
