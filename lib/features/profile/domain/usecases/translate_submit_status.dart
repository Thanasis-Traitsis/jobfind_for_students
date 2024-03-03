String translateSubmitStatus(String? status) {
  switch (status) {
    case 'approved':
      return 'Η αίτησή σας εγκρίθηκε.';
    case 'denied':
      return 'Η αίτησή σας απορρίφθηκε.';
    case 'pending':
      return 'Η αίτησή σας εκκρεμεί.';
    default:
      return '';
  }
}

bool transformSubmitStatus(String? status) {
  switch (status) {
    case 'approved':
      return false;
    case 'denied':
      return false;
    case null:
      return false;
    default:
      return true;
  }
}
