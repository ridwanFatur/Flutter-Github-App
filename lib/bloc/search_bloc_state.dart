part of 'search_bloc_cubit.dart';

class SearchBlocState extends Equatable {
  final String query;
  final int optionType;
  final int searchType;
  final int currentTopPage;
  final int currentBottomPage;
  final int totalPage;
  final bool isLoadingFirstAttempt;
  final bool isLoadingTopPagination;
  final bool isLoadingBottomPagination;
  final bool isErrorFirstAttempt;
  final bool isErrorTopPagination;
  final bool isErrorBottomPagination;
  final List data;
  final String errorFirstAttempt;
  final String errorTopPagination;
  final String errorBottomPagination;
  final int showedPageNumber;
  final bool isLoadingWithIndex;
  final bool isErrorWithIndex;
  final String errorWithIndex;

  SearchBlocState({
    this.query = "",
    this.optionType = 0,
    this.searchType = 0,
    this.currentTopPage = 1,
    this.currentBottomPage = 1,
    this.totalPage = 1,
    this.isLoadingFirstAttempt = false,
    this.isLoadingTopPagination = false,
    this.isLoadingBottomPagination = false,
    this.isErrorFirstAttempt = false,
    this.isErrorTopPagination = false,
    this.isErrorBottomPagination = false,
    this.data = const [],
    this.errorFirstAttempt = "",
    this.errorTopPagination = "",
    this.errorBottomPagination = "",
    this.showedPageNumber = 1,
    this.isLoadingWithIndex = false,
    this.isErrorWithIndex = false,
    this.errorWithIndex = "",
  });

  SearchBlocState copyWith({
    String? query,
    int? optionType,
    int? searchType,
    int? currentTopPage,
    int? currentBottomPage,
    int? totalPage,
    bool? isLoadingFirstAttempt,
    bool? isLoadingTopPagination,
    bool? isLoadingBottomPagination,
    bool? isErrorFirstAttempt,
    bool? isErrorTopPagination,
    bool? isErrorBottomPagination,
    List? data,
    String? errorFirstAttempt,
    String? errorTopPagination,
    String? errorBottomPagination,
    int? showedPageNumber,
    bool? isLoadingWithIndex,
    bool? isErrorWithIndex,
    String? errorWithIndex,
  }) {
    return SearchBlocState(
      query: query ?? this.query,
      optionType: optionType ?? this.optionType,
      searchType: searchType ?? this.searchType,
      currentTopPage: currentTopPage ?? this.currentTopPage,
      currentBottomPage: currentBottomPage ?? this.currentBottomPage,
      totalPage: totalPage ?? this.totalPage,
      isLoadingFirstAttempt:
          isLoadingFirstAttempt ?? this.isLoadingFirstAttempt,
      isLoadingTopPagination:
          isLoadingTopPagination ?? this.isLoadingTopPagination,
      isLoadingBottomPagination:
          isLoadingBottomPagination ?? this.isLoadingBottomPagination,
      isErrorFirstAttempt: isErrorFirstAttempt ?? this.isErrorFirstAttempt,
      isErrorTopPagination: isErrorTopPagination ?? this.isErrorTopPagination,
      isErrorBottomPagination:
          isErrorBottomPagination ?? this.isErrorBottomPagination,
      data: data ?? this.data,
      errorFirstAttempt: errorFirstAttempt ?? this.errorFirstAttempt,
      errorTopPagination: errorTopPagination ?? this.errorTopPagination,
      errorBottomPagination:
          errorBottomPagination ?? this.errorBottomPagination,
      showedPageNumber: showedPageNumber ?? this.showedPageNumber,
      isLoadingWithIndex: isLoadingWithIndex ?? this.isLoadingWithIndex,
      errorWithIndex: errorWithIndex ?? this.errorWithIndex,
      isErrorWithIndex: isErrorWithIndex ?? this.isErrorWithIndex,
    );
  }

  @override
  List<Object> get props => [
        query,
        optionType,
        searchType,
        currentTopPage,
        currentBottomPage,
        totalPage,
        isLoadingFirstAttempt,
        isLoadingTopPagination,
        isLoadingBottomPagination,
        isErrorFirstAttempt,
        isErrorTopPagination,
        isErrorBottomPagination,
        data,
        errorFirstAttempt,
        errorTopPagination,
        errorBottomPagination,
        showedPageNumber,
        errorWithIndex,
        isErrorWithIndex,
        isLoadingWithIndex,
      ];
}
