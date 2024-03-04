class FilterStatus {
  List<Map<String, dynamic>> listTypeStatus = [];

  Map<String, dynamic> statusAll = {
    'statusType': 1,
    'typeName': 'All',
  };
  Map<String, dynamic> statusInprogress = {
    'statusType': 2,
    'typeName': 'In progress',
  };
  Map<String, dynamic> statusComplete = {
    'statusType': 3,
    'typeName': 'Complete',
  };


  FilterStatus._privateConstructor() {
    listTypeStatus.add(statusAll);
    listTypeStatus.add(statusInprogress);
    listTypeStatus.add(statusComplete);
  }

  static final FilterStatus _instance =
      FilterStatus._privateConstructor();

  factory FilterStatus() {
    return _instance;
  }
}
