DateTime day() {
  return DateTime.now().hour >= 18
      ? DateTime.now().add(const Duration(days: 1))
      : DateTime.now();
}

today() {
  return day().weekday == DateTime.now().weekday;
}
