List addAcademiaListings({
  required List parentList,
  required Map childList,
  required int value,
  required List returnList,
  bool isMajor = false,
}) {
  for (var i = 0; i < childList[parentList[value]].length; i++) {
    returnList.add(
      isMajor
          ? childList[parentList[value]][i]
          : childList[parentList[value]][i]['name'],
    );
  }

  return returnList;
}

List removeAcademiaListings({
  required List parentList,
  required Map childList,
  required int value,
  required List returnList,
  bool isMajor = false,
}) {
  for (var i = 0; i < childList[parentList[value]].length; i++) {
    returnList.remove(
      isMajor
          ? childList[parentList[value]][i]
          : childList[parentList[value]][i]['name'],
    );
  }

  return returnList;
}
