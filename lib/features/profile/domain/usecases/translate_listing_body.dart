String translateListingBody(String listing) {
  switch (listing) {
    case 'title':
      return 'Τίτλος';
    case 'description':
      return 'Περιγραφή';
    case 'requirements':
      return 'Απαραίτητα Προσόντα';
    case 'benefits':
      return 'Παροχές';
    case 'employment_type':
      return 'είδος απασχόλησης';
    case 'experience':
      return 'Χρόνια προϋπηρεσίας';
    default:
      return 'Πανεπιστήμια';
  }
}
