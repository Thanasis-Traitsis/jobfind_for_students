String translateEmploymentType(String? emplType) {
   switch (emplType) {
    case 'Ημιαπασχόληση':
      return 'part_time';
    case 'Πλήρης Απασχόληση':
      return 'full_time';
    case 'Πρακτική Άσκηση':
      return 'internship';
    default:
      return '';
  }
}