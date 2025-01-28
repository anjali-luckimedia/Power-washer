abstract class SearchEvent {}

class LoadSearchData extends SearchEvent {
  final String? searchText;
  final String? miles;
  final String? rating;

  LoadSearchData(this.searchText, this.miles, this.rating);
}
