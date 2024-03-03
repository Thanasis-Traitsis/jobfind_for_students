String transformExperienceToString(int? exp) {
  if (exp == null || exp == 0) {
    return 'Δεν απαιτείται';
  } else if (exp == 1) {
    return '$exp χρόνος προϋπηρεσία';
  }
  return '$exp χρόνια προϋπηρεσία';
}
