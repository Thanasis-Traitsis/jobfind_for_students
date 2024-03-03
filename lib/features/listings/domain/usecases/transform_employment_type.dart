String transformEmploymentType(String job) {
  return job == 'internship'
        ? 'Πρακτική Άσκηση'
        : job == 'full_time'
            ? 'Πλήρης Απασχόληση'
            : 'Ημιαπασχόληση';
}