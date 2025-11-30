enum IlanTipi {
  satilik(1, 'Satılık'),
  kiralik(2, 'Kiralık');

  const IlanTipi(this.dbValue, this.label);
  final int dbValue;
  final String label;
}

enum KimdenTipi {
  sahibinden(1, 'Sahibinden'),
  galeriden(2, 'Galeriden');

  const KimdenTipi(this.dbValue, this.label);
  final int dbValue;
  final String label;
}

/// DB’de INT tutulan alanlar için geçici id-label map.
/// Backend’de gerçek mapping gelince burası kesinleşir.
class LabeledInt {
  const LabeledInt(this.id, this.label);
  final int id;
  final String label;
}
