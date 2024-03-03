class ErrorModel {
  final Map<String, List<String>> _errors;

  ErrorModel(this._errors);

  Map<String, List<String>> get errors {
    return _errors;
  }

  void addError(String field, String errorMessage) {
    if (_errors.containsKey(field)) {
      _errors[field]!.add(errorMessage);
    } else {
      _errors[field] = [errorMessage];
    }
  }

  void clearErrors() {
    _errors.clear();
  }

  bool hasErrors() {
    return _errors.isNotEmpty;
  }
}
