import 'package:get/get.dart';

import '../services/SEARCH/search_api_service.dart';

class SearchStateController extends GetxController {

  // instant variables
  String _selectedPracticeArea = "";
  final List<String> _practiceAreas = [
    "Alternative Dispute Resolution (ARD)",
    "Corporate",
    "Finance",
    "Litigation",
    "Oil and Gas",
  ];
  String _country = "";
  dynamic _yearOfCall = "";
  String _state = "";
  String _lga = "";
  bool _isLoading = false;
  String _keyword = "";
  List<dynamic> _searchedList = [];

  // getters
  List get practiceAreas => _practiceAreas;
  String get selectedPracticeArea => _selectedPracticeArea;
  dynamic get yearOfCall => _yearOfCall;
  String get country => _country;
  String get state => _state;
  String get lga => _lga;
  String get keyword=> _keyword;
  bool get isLoading => _isLoading;
  List<dynamic> get searchedList => _searchedList;

  // setters
  updateSelectedPracticeArea(value) {
    _selectedPracticeArea = value;
    update();
  }
  updateYearOfCall(value) {
    _yearOfCall = value;
    update();
  }
  updateCountry(value) {
    _country = value;
    update();
  }
  updateState(value) {
    _state = value;
    update();
  }
  updateLGA(value) {
    _lga = value;
    update();
  }
  updateKeyword(value) {
    _keyword = value;
    update();
  }
  updateIsLoading(value) {
    _isLoading = value;
    update();
  }
  updateSearchedList(value) {
    _searchedList = value;
    update();
  }

  Future<void> searchForLawyers() async{
    updateIsLoading(true);

    var response = await SearchApiService.searchForLawyerService(_country, _yearOfCall, _selectedPracticeArea, _state, lga, "name");
    var responseData = response!.data;
    print(responseData);

    if(responseData["data"] != []){
      updateIsLoading(false);
      updateSearchedList(responseData["data"]);
    } else {
      updateIsLoading(false);

    }


    update();
  }
}