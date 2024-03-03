List getFilterList(
  String role,
  List filterList,
) {
  var list = [];

  if (role == 'business') {
    for (var i = 0; i < filterList.length; i++) {
      if (filterList[i]['businessAccount'] == true) {
        list.add(filterList[i]['filter']);
      }
    }
    return list;
  } else {
    for (var i = 0; i < filterList.length; i++) {
      list.add(filterList[i]['filter']);
    }
    return list;
  }
}
