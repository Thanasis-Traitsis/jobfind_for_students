String transformUserRole(String role) {
  switch (role) {
    case 'user':
      return 'Φοιτητής';
    case 'old_student':
      return 'Απόφοιτος';
    case 'business':
      return 'Επιχείρηση';
    case 'secretary':
      return 'Γραμματεία';
    default:
      return 'Διαχειριστής';
  }
}