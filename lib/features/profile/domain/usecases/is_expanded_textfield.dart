bool isExpandedTextfield(String field) {
  switch (field) {
    case 'description':
      return true;
    case 'requirements':
      return true;
    case 'benefits':
      return true;
    default:
      return false;
  }
}
