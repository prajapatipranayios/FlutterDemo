
class OBQuestion {
  final String id;
  final String titleKey;
  final String? subtitleKey;
  final String? renderer; // e.g. "city", "identity", "meal", "medical"
  final List<OBOption> options;

  OBQuestion({
    required this.id,
    required this.titleKey,
    this.subtitleKey,
    this.renderer,
    this.options = const [],
  });
}

class OBOption {
  final String id;
  final String labelKey;
  final String? group; // for meal/diet/allergy/medical grouping

  OBOption({
    required this.id,
    required this.labelKey,
    this.group,
  });
}
