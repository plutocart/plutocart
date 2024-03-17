class FilterMonth {
  List<Map<String, dynamic>> listTypeMonth = [];

  Map<String, dynamic> FilterMonth1 = {
    'keyMonth': 1,
    'typeName': 'JAN.',
  };
  Map<String, dynamic> FilterMonth2 = {
    'keyMonth': 2,
    'typeName': 'FEB.',
  };
  Map<String, dynamic> FilterMonth3 = {
    'keyMonth': 3,
    'typeName': 'MAR.',
  };
   Map<String, dynamic> FilterMonth4 = {
    'keyMonth': 4,
    'typeName': 'ARP.',
  };
   Map<String, dynamic> FilterMonth5 = {
    'keyMonth': 5,
    'typeName': 'MAY.',
  };
   Map<String, dynamic> FilterMonth6 = {
    'keyMonth': 6,
    'typeName': 'JUN.',
  };
   Map<String, dynamic> FilterMonth7 = {
    'keyMonth': 7,
    'typeName': 'JUL.',
  };
   Map<String, dynamic> FilterMonth8 = {
    'keyMonth': 8,
    'typeName': 'AUG.',
  };
   Map<String, dynamic> FilterMonth9 = {
    'keyMonth': 9,
    'typeName': 'SEP.',
  };
   Map<String, dynamic> FilterMonth10 = {
    'keyMonth': 10,
    'typeName': 'OCT.',
  };
   Map<String, dynamic> FilterMonth11 = {
    'keyMonth': 11,
    'typeName': 'NOV.',
  };
  Map<String, dynamic> FilterMonth12 = {
    'keyMonth': 12,
    'typeName': 'DEC.',
  };


  FilterMonth._privateConstructor() {
    listTypeMonth.add(FilterMonth1);
    listTypeMonth.add(FilterMonth2);
    listTypeMonth.add(FilterMonth3);
    listTypeMonth.add(FilterMonth4);
    listTypeMonth.add(FilterMonth5);
    listTypeMonth.add(FilterMonth6);
    listTypeMonth.add(FilterMonth7);
    listTypeMonth.add(FilterMonth8);
    listTypeMonth.add(FilterMonth9);
    listTypeMonth.add(FilterMonth10);
    listTypeMonth.add(FilterMonth11);
    listTypeMonth.add(FilterMonth12);
  }

  static final FilterMonth _instance =
      FilterMonth._privateConstructor();

  factory FilterMonth() {
    return _instance;
  }
}
