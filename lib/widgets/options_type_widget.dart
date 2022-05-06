import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/search_bloc_cubit.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/config_constants.dart';
import 'package:github_app/utils/helper_math.dart';
import 'package:github_app/utils/size_responsive_helper.dart';

class OptionsTypeWidget extends StatefulWidget {
  @override
  State<OptionsTypeWidget> createState() => _OptionsTypeWidgetState();
}

class _OptionsTypeWidgetState extends State<OptionsTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBlocCubit, SearchBlocState>(
        builder: (context, state) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            itemOptionType(
              state.optionType == OptionTypeConstant.LAZY_LOADING,
              "Lazy Loading",
              () {
                BlocProvider.of<SearchBlocCubit>(context)
                    .changeOptionType(OptionTypeConstant.LAZY_LOADING);
              },
            ),
            itemOptionType(
              state.optionType == OptionTypeConstant.WITH_INDEX,
              "With Index",
              () {
                int? selectedPage;
                double minY = double.infinity;

                if (state.data.isNotEmpty) {
                  for (var item in state.data) {
                    GlobalKey key = item["key"];
                    int page = item["page"];
                    RenderBox box =
                        key.currentContext!.findRenderObject() as RenderBox;
                    Offset position = box.localToGlobal(Offset.zero);
                    double y = position.dy;

                    double centerVal = HelperMath.getCenterVal(
                      y,
                      Responsive.heightCentralSize(context),
                    );
                    if (centerVal < minY) {
                      minY = centerVal;
                      selectedPage = page;
                    }
                  }
                }

                BlocProvider.of<SearchBlocCubit>(context).changeOptionType(
                  OptionTypeConstant.WITH_INDEX,
                  selectedPage: selectedPage,
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget itemOptionType(bool isActive, String title, VoidCallback onPressed) {
    return Expanded(
      child: Material(
        color: isActive ? kColorPrimary : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          onTap: () {
            onPressed();
          },
          child: SizedBox(
            height: double.infinity,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : kColorPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
