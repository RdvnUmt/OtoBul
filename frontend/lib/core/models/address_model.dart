/// Adres modeli
class Address {
  final int? adresId;
  final String? ulke;
  final String? sehir;
  final String? ilce;
  final String? mahalle;
  final String? cadde;
  final String? sokak;
  final String? binaNo;
  final String? daireNo;
  final String? postaKodu;
  final String? olusturmaTarihi;
  final String? guncellemeTarihi;

  Address({
    this.adresId,
    this.ulke,
    this.sehir,
    this.ilce,
    this.mahalle,
    this.cadde,
    this.sokak,
    this.binaNo,
    this.daireNo,
    this.postaKodu,
    this.olusturmaTarihi,
    this.guncellemeTarihi,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      adresId: json['adres_id'],
      ulke: json['ulke'],
      sehir: json['sehir'],
      ilce: json['ilce'],
      mahalle: json['mahalle'],
      cadde: json['cadde'],
      sokak: json['sokak'],
      binaNo: json['bina_no'],
      daireNo: json['daire_no'],
      postaKodu: json['posta_kodu'],
      olusturmaTarihi: json['olusturulma_tarihi'],
      guncellemeTarihi: json['guncellenme_tarihi'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    
    if (adresId != null) map['adres_id'] = adresId;
    if (ulke != null) map['ulke'] = ulke;
    if (sehir != null) map['sehir'] = sehir;
    if (ilce != null) map['ilce'] = ilce;
    if (mahalle != null) map['mahalle'] = mahalle;
    if (cadde != null) map['cadde'] = cadde;
    if (sokak != null) map['sokak'] = sokak;
    if (binaNo != null) map['bina_no'] = binaNo;
    if (daireNo != null) map['daire_no'] = daireNo;
    if (postaKodu != null) map['posta_kodu'] = postaKodu;
    if (olusturmaTarihi != null) map['olusturulma_tarihi'] = olusturmaTarihi;
    if (guncellemeTarihi != null) map['guncellenme_tarihi'] = guncellemeTarihi;
    
    return map;
  }

  /// Adres özeti (gösterim için)
  String get summary {
    final parts = <String>[];
    if (ilce != null && ilce!.isNotEmpty) parts.add(ilce!);
    if (sehir != null && sehir!.isNotEmpty) parts.add(sehir!);
    if (ulke != null && ulke!.isNotEmpty) parts.add(ulke!);
    
    return parts.isEmpty ? 'Adres bilgisi yok' : parts.join(', ');
  }

  /// Tam adres metni
  String get fullAddress {
    final parts = <String>[];
    if (mahalle != null && mahalle!.isNotEmpty) parts.add('$mahalle Mah.');
    if (cadde != null && cadde!.isNotEmpty) parts.add('$cadde Cad.');
    if (sokak != null && sokak!.isNotEmpty) parts.add('$sokak Sok.');
    if (binaNo != null && binaNo!.isNotEmpty) parts.add('No: $binaNo');
    if (daireNo != null && daireNo!.isNotEmpty) parts.add('D: $daireNo');
    if (ilce != null && ilce!.isNotEmpty) parts.add(ilce!);
    if (sehir != null && sehir!.isNotEmpty) parts.add(sehir!);
    if (ulke != null && ulke!.isNotEmpty) parts.add(ulke!);
    if (postaKodu != null && postaKodu!.isNotEmpty) parts.add(postaKodu!);
    
    return parts.isEmpty ? 'Adres bilgisi yok' : parts.join(' ');
  }

  Address copyWith({
    int? adresId,
    String? ulke,
    String? sehir,
    String? ilce,
    String? mahalle,
    String? cadde,
    String? sokak,
    String? binaNo,
    String? daireNo,
    String? postaKodu,
    String? olusturmaTarihi,
    String? guncellemeTarihi,
  }) {
    return Address(
      adresId: adresId ?? this.adresId,
      ulke: ulke ?? this.ulke,
      sehir: sehir ?? this.sehir,
      ilce: ilce ?? this.ilce,
      mahalle: mahalle ?? this.mahalle,
      cadde: cadde ?? this.cadde,
      sokak: sokak ?? this.sokak,
      binaNo: binaNo ?? this.binaNo,
      daireNo: daireNo ?? this.daireNo,
      postaKodu: postaKodu ?? this.postaKodu,
      olusturmaTarihi: olusturmaTarihi ?? this.olusturmaTarihi,
      guncellemeTarihi: guncellemeTarihi ?? this.guncellemeTarihi,
    );
  }
}
