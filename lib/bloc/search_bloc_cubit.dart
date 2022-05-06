import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_app/services/issues_api_service.dart';
import 'package:github_app/services/repository_api_service.dart';
import 'package:github_app/services/users_api_service.dart';
import 'package:github_app/utils/config_constants.dart';

part 'search_bloc_state.dart';

class SearchBlocCubit extends Cubit<SearchBlocState> {
  SearchBlocCubit()
      : super(
          SearchBlocState(),
        );

  void requestDataFirstAttempt() async {
    emit(state.copyWith(
      isLoadingFirstAttempt: true,
      isLoadingTopPagination: false,
      isLoadingBottomPagination: false,
      isErrorFirstAttempt: false,
      isErrorTopPagination: false,
      isErrorBottomPagination: false,
      currentTopPage: state.showedPageNumber,
      currentBottomPage: state.showedPageNumber,
      errorFirstAttempt: "",
      errorTopPagination: "",
      errorBottomPagination: "",
      errorWithIndex: "",
      isErrorWithIndex: false,
      isLoadingWithIndex: false,
      data: [],
    ));

    late var response;
    if (state.searchType == SearchTypeConstant.USER) {
      //User
      response = await UsersApiService().getData(
        query: state.query,
        page: state.showedPageNumber,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.ISSUES) {
      //Issues
      response = await IssuesApiService().getData(
        query: state.query,
        page: state.showedPageNumber,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.REPOSITORIES) {
      response = await RepositoryApiService().getData(
        query: state.query,
        page: state.showedPageNumber,
        pageSize: 10,
      );
    }

    if (response["success"]) {
      int totalCount = response["data"]["total_count"];
      List items = response["data"]["items"];
      int totalPage = totalCount ~/ 10 + 1;

      emit(state.copyWith(
        isLoadingFirstAttempt: false,
        currentTopPage: state.showedPageNumber,
        currentBottomPage: state.showedPageNumber,
        totalPage: totalPage,
        data: [
          {
            "list": items,
            "page": state.showedPageNumber,
            "key": GlobalKey(),
          }
        ],
      ));
    } else {
      emit(state.copyWith(
        isLoadingFirstAttempt: false,
        isErrorFirstAttempt: true,
        errorFirstAttempt: response["message"],
      ));
    }
  }

  void reload() async {
    requestDataFirstAttempt();
  }

  void changeQuery(String query) async {
    if (state.query != query) {
      emit(state.copyWith(
        query: query,
        showedPageNumber: 1,
      ));
      if (state.query.isNotEmpty) {
        requestDataFirstAttempt();
      }
    }
  }

  void reloadTopPagination() {
    requestDataTopPagination();
  }

  void loadTopPagination() {
    if (state.currentTopPage > 1 &&
        !state.isLoadingTopPagination &&
        !state.isErrorTopPagination &&
        state.optionType == OptionTypeConstant.LAZY_LOADING) {
      emit(state.copyWith(
        currentTopPage: state.currentTopPage - 1,
      ));
      requestDataTopPagination();
    }
  }

  void requestDataTopPagination() async {
    emit(state.copyWith(
      isLoadingTopPagination: true,
      isErrorTopPagination: false,
      errorTopPagination: "",
    ));

    late var response;
    if (state.searchType == SearchTypeConstant.USER) {
      //User
      response = await UsersApiService().getData(
        query: state.query,
        page: state.currentTopPage,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.ISSUES) {
      //Issues
      response = await IssuesApiService().getData(
        query: state.query,
        page: state.currentTopPage,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.REPOSITORIES) {
      response = await RepositoryApiService().getData(
        query: state.query,
        page: state.currentTopPage,
        pageSize: 10,
      );
    }

    if (response["success"]) {
      List items = response["data"]["items"];
      List newList = List.from(state.data);
      newList.insert(0, {
        "page": state.currentTopPage,
        "list": items,
        "key": GlobalKey(),
      });

      emit(state.copyWith(
        isLoadingTopPagination: false,
        data: newList,
      ));
    } else {
      emit(state.copyWith(
        isLoadingTopPagination: false,
        isErrorTopPagination: true,
        errorTopPagination: response["message"],
      ));
    }
  }

  void reloadBottomPagination() {
    requestDataBottomPagination();
  }

  void loadBottomPagination() {
    if (state.currentBottomPage < state.totalPage &&
        !state.isLoadingBottomPagination &&
        !state.isErrorBottomPagination &&
        state.optionType == OptionTypeConstant.LAZY_LOADING) {
      emit(state.copyWith(
        currentBottomPage: state.currentBottomPage + 1,
      ));
      requestDataBottomPagination();
    }
  }

  void requestDataBottomPagination() async {
    if (state.optionType == OptionTypeConstant.LAZY_LOADING) {}
    emit(state.copyWith(
      isLoadingBottomPagination: true,
      isErrorBottomPagination: false,
      errorBottomPagination: "",
    ));

    late var response;
    if (state.searchType == SearchTypeConstant.USER) {
      //User
      response = await UsersApiService().getData(
        query: state.query,
        page: state.currentBottomPage,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.ISSUES) {
      //Issues
      response = await IssuesApiService().getData(
        query: state.query,
        page: state.currentBottomPage,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.REPOSITORIES) {
      response = await RepositoryApiService().getData(
        query: state.query,
        page: state.currentBottomPage,
        pageSize: 10,
      );
    }

    if (response["success"]) {
      List items = response["data"]["items"];
      List newList = List.from(state.data);
      newList.add({
        "page": state.currentBottomPage,
        "list": items,
        "key": GlobalKey(),
      });
      emit(state.copyWith(
        isLoadingBottomPagination: false,
        data: newList,
      ));
    } else {
      emit(state.copyWith(
        isLoadingBottomPagination: false,
        isErrorBottomPagination: true,
        errorBottomPagination: response["message"],
      ));
    }
  }

  void changeOptionType(int optionType, {int? selectedPage}) {
    if (optionType != state.optionType) {
      if (optionType == OptionTypeConstant.WITH_INDEX) {
        emit(state.copyWith(
          optionType: optionType,
          errorWithIndex: "",
          isErrorWithIndex: false,
          isLoadingWithIndex: false,
          errorFirstAttempt: "",
          isErrorFirstAttempt: false,
          isLoadingFirstAttempt: false,
        ));

        if (state.data.isNotEmpty && selectedPage != null) {
          changeShowedPageNumber(selectedPage);
        } else {
          changeShowedPageNumber(state.showedPageNumber);
        }
      } else if (optionType == OptionTypeConstant.LAZY_LOADING) {
        List newList = List.from(state.data);
        newList = newList.where((element) {
          return element["page"] == state.showedPageNumber;
        }).toList();

        if (newList.isEmpty) {
          emit(
            state.copyWith(
              optionType: optionType,
              data: [],
              currentBottomPage: state.showedPageNumber,
              currentTopPage: state.showedPageNumber,
              errorBottomPagination: "",
              isErrorBottomPagination: false,
              isLoadingBottomPagination: false,
              errorTopPagination: "",
              isErrorTopPagination: false,
              isLoadingTopPagination: false,
            ),
          );

          if (state.query.isNotEmpty) {
            requestDataFirstAttempt();
          }
        } else {
          emit(
            state.copyWith(
              optionType: optionType,
              data: newList,
              currentBottomPage: state.showedPageNumber,
              currentTopPage: state.showedPageNumber,
              errorBottomPagination: "",
              isErrorBottomPagination: false,
              isLoadingBottomPagination: false,
              errorTopPagination: "",
              isErrorTopPagination: false,
              isLoadingTopPagination: false,
            ),
          );
        }
      }
    }
  }

  void changeSearchType(int searchType) {
    if (searchType != state.searchType) {
      emit(state.copyWith(
        searchType: searchType,
        showedPageNumber: 1,
      ));
      if (state.query.isNotEmpty) {
        requestDataFirstAttempt();
      }
    }
  }

  void changeShowedPageNumber(int pageNumber) {
    if (state.optionType == OptionTypeConstant.WITH_INDEX) {
      bool isLoadedPage = false;
      for (var item in state.data) {
        int page = item["page"];
        if (page == pageNumber) {
          isLoadedPage = true;
        }
      }

      if (!isLoadedPage) {
        emit(state.copyWith(showedPageNumber: pageNumber));
        if (state.query.isNotEmpty) {
          requestDataWithIndex();
        }
      } else {
        emit(state.copyWith(
          showedPageNumber: pageNumber,
          errorWithIndex: "",
          isLoadingWithIndex: false,
          isErrorWithIndex: false,
        ));
      }
    }
  }

  void requestDataWithIndex() async {
    emit(state.copyWith(
      errorWithIndex: "",
      isLoadingWithIndex: true,
      isErrorWithIndex: false,
    ));

    late var response;
    if (state.searchType == SearchTypeConstant.USER) {
      //User
      response = await UsersApiService().getData(
        query: state.query,
        page: state.showedPageNumber,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.ISSUES) {
      //Issues
      response = await IssuesApiService().getData(
        query: state.query,
        page: state.showedPageNumber,
        pageSize: 10,
      );
    } else if (state.searchType == SearchTypeConstant.REPOSITORIES) {
      response = await RepositoryApiService().getData(
        query: state.query,
        page: state.showedPageNumber,
        pageSize: 10,
      );
    }

    if (response["success"]) {
      List items = response["data"]["items"];
      List newList = List.from(state.data);
      newList.add({
        "page": state.showedPageNumber,
        "list": items,
        "key": GlobalKey(),
      });
      emit(state.copyWith(
        isLoadingWithIndex: false,
        data: newList,
      ));
    } else {
      emit(state.copyWith(
        isLoadingWithIndex: false,
        isErrorWithIndex: true,
        errorWithIndex: response["message"],
      ));
    }
  }
}
