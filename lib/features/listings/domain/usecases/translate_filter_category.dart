String translateFilterCategory(String filter) {
  switch (filter) {
    case 'Παλαιότερα - Πρόσφατα':
      return 'oldest';
    case 'Της ειδικότητάς μου':
      return 'by_user_major';
    case 'Περισσότερες προβολές':
      return 'most_viewed';
    case 'Περισσότερες αιτήσεις':
      return 'most_applied';
    default:
      return 'recent';
  }
}
