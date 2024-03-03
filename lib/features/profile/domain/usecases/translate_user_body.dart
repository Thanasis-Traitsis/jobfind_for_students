String translateListBody(String text) {
  switch (text) {
    case 'first_name':
      return 'Όνομα';
    case 'last_name':
      return 'Επώνυμο';
    case 'father_name':
      return 'Πατρώνυμο';
    case 'mother_name':
      return 'Μητρώνυμο';

    case 'address':
      return 'Διεύθυνση';
    case 'postal_code':
      return 'Ταχυδρομικός Κώδικας';
    case 'city':
      return 'Πόλη';
    case 'county':
      return 'Νομός';
    case 'mobile_phone':
      return 'Κινητό τηλέφωνο';
    case 'telephone':
      return 'Σταθερό τηλέφωνο';
    case 'course':
      return 'Ειδικότητα';

    case 'company':
      return 'Επωνυμία';
    case 'distinctive_title':
      return 'Διακριτικός Τίτλος';
    case 'company_description':
      return 'Περιγραφή Εταιρείας';
    case 'occupation':
      return 'Επάγγελμα';
    case 'afm':
      return 'Α.Φ.Μ.';
    case 'doy':
      return 'Δ.Ο.Υ.';

    default:
      return 'Email';
  }
}
