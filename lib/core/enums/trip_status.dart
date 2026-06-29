enum TripStatus {
  draft(
    label: 'Bozza',
    color: 0xFF9E9E9E,
  ),
  planned(
    label: 'Pianificato',
    color: 0xFF2196F3,
  ),
  ongoing(
    label: 'In corso',
    color: 0xFF4CAF50,
  ),
  completed(
    label: 'Concluso',
    color: 0xFF673AB7,
  );

  final String label;
  final int color;

  const TripStatus({
    required this.label,
    required this.color,
  });
}