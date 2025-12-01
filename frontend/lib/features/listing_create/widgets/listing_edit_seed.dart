import '/core/models/listing_model.dart' as models;

import 'listing_address_draft.dart';
import 'listing_create_models.dart';
import 'listing_details/listing_details_draft.dart';
import 'listing_details/listing_details_types.dart';

class ListingEditSeed {
  ListingEditSeed({
    required this.ilanId,
    required this.mainCategory,
    required this.vasitaCategory,
    required this.emlakCategory,
    required this.title,
    required this.description,
    required this.priceText,
    required this.kimdenDb,
    required this.details,
    required this.address,
    this.ilanTipiDb = 1, // 1 satilik, 2 kiralik
    this.kredi = false,
    this.takas = false,
  });

  final String ilanId;

  final ListingMainCategory mainCategory;
  final ListingVasitaCategory? vasitaCategory;
  final ListingEmlakCategory? emlakCategory;

  final String title;
  final String description;
  final String priceText;

  /// KimdenTipi.dbValue: 1 sahibinden, 2 galeriden
  final int kimdenDb;

  /// IlanTipi.dbValue: 1 satilik, 2 kiralik
  final int ilanTipiDb;

  final bool kredi;
  final bool takas;

  /// Listing.details (mock / backend map)
  final Map<String, dynamic> details;

  /// DB uyumlu adres seed’i: ulke, sehir, ilce, mahalle, cadde, sokak, bina_no, daire_no, posta_kodu
  final Map<String, dynamic> address;

  static ListingEditSeed? tryParse(Object? extra) {
    if (extra == null) return null;

    if (extra is models.Listing) {
      return ListingEditSeed.fromListing(extra);
    }

    if (extra is Map<String, dynamic>) {
      final id = (extra['id'] ?? extra['ilan_id'])?.toString();
      if (id == null) return null;

      // mümkün olduğunca yakala
      final cat = (extra['category'] ?? extra['kategori'] ?? 'vasita').toString().toLowerCase().trim();
      final sub = (extra['subCategory'] ?? extra['alt_kategori'] ?? 'otomobil').toString().toLowerCase().trim();

      final main = (cat == 'emlak') ? ListingMainCategory.emlak : ListingMainCategory.vasita;
      final e = main == ListingMainCategory.emlak ? _emlakFromSub(sub) : null;
      final v = main == ListingMainCategory.vasita ? _vasitaFromSub(sub) : null;

      final priceAny = extra['price'] ?? extra['fiyat'] ?? 0;
      final priceText = (priceAny is num) ? _numToCleanString(priceAny) : priceAny.toString();

      final rawAddress = extra['address'] ?? extra['adres'] ?? const {};
      final addressMap = rawAddress is Map<String, dynamic> ? rawAddress : const <String, dynamic>{};

      return ListingEditSeed(
        ilanId: id,
        mainCategory: main,
        vasitaCategory: v,
        emlakCategory: e,
        title: (extra['title'] ?? extra['baslik'] ?? '').toString(),
        description: (extra['description'] ?? extra['aciklama'] ?? '').toString(),
        priceText: priceText,
        kimdenDb: _readInt(extra['kimdenDb'] ?? extra['kimden'] ?? 1, fallback: 1),
        ilanTipiDb: _readInt(extra['ilanTipiDb'] ?? extra['ilanTipi'] ?? 1, fallback: 1),
        kredi: (extra['kredi'] ?? extra['kredi_uygun'] ?? false) == true,
        takas: (extra['takas'] ?? extra['takas_var'] ?? false) == true,
        details: Map<String, dynamic>.from(extra['details'] ?? const {}),
        address: _normalizeAddressMap(Map<String, dynamic>.from(addressMap)),
      );
    }

    return null;
  }

  factory ListingEditSeed.fromListing(models.Listing l) {
    final cat = (l.category).toLowerCase().trim(); // 'emlak' | 'vasita'
    final sub = (l.subCategory).toLowerCase().trim(); // 'konut' | 'arsa' | 'otomobil' ...

    final main = (cat == 'emlak') ? ListingMainCategory.emlak : ListingMainCategory.vasita;

    final e = main == ListingMainCategory.emlak ? _emlakFromSub(sub) : null;
    final v = main == ListingMainCategory.vasita ? _vasitaFromSub(sub) : null;

    // Daha dayanıklı: listing_model field'ları varsa onları kullan, yoksa sellerType'tan sez
    final dl = l as dynamic;

    final int kimdenResolved = (() {
      try {
        final k = dl.kimden;
        final db = k?.dbValue;
        if (db is int) return db;
      } catch (_) {}
      final st = (l.sellerType).toLowerCase();
      return st.contains('sahib') ? 1 : 2;
    })();

    final int ilanTipiResolved = (() {
      try {
        final it = dl.ilanTipi;
        final db = it?.dbValue;
        if (db is int) return db;
      } catch (_) {}
      // fallback: details veya default
      final d = l.details;
      final v = d['ilanTipiDb'] ?? d['ilanTipi'];
      if (v != null) return _readInt(v, fallback: 1);
      return 1;
    })();

    final bool krediResolved = (() {
      try {
        final k = dl.krediUygunlugu;
        if (k is bool) return k;
      } catch (_) {}
      final v = l.details['kredi'] ?? l.details['krediUygunlugu'];
      return v == true;
    })();

    final bool takasResolved = (() {
      try {
        final t = dl.takas;
        if (t is bool) return t;
      } catch (_) {}
      final v = l.details['takas'];
      return v == true;
    })();

    final priceText = _numToCleanString(l.price);

    // Address seed: Listing.address varsa onu kullan; yoksa city/district/location
    final address = <String, dynamic>{};
    final a = l.address;
    if (a != null) {
      address['ulke'] = a.ulke;
      address['sehir'] = a.sehir;
      address['ilce'] = a.ilce;
      address['mahalle'] = a.mahalle;
      address['cadde'] = a.cadde;
      address['sokak'] = a.sokak;
      address['bina_no'] = a.binaNo;
      address['daire_no'] = a.daireNo;
      address['posta_kodu'] = a.postaKodu;
    }

    // fallbacks (DB alanları)
    address.putIfAbsent('ulke', () => 'TR');
    address.putIfAbsent('sehir', () => l.city);
    address.putIfAbsent('ilce', () => l.district);
    // location UI kısayolu -> en yakın DB alanı: mahalle
    address.putIfAbsent('mahalle', () => l.location);

    return ListingEditSeed(
      ilanId: l.id,
      mainCategory: main,
      vasitaCategory: v,
      emlakCategory: e,
      title: l.title,
      description: l.description,
      priceText: priceText,
      kimdenDb: kimdenResolved,
      ilanTipiDb: ilanTipiResolved,
      kredi: krediResolved,
      takas: takasResolved,
      details: Map<String, dynamic>.from(l.details),
      address: _normalizeAddressMap(address),
    );
  }

  void applyTo({
    required ListingDetailsDraft detailsDraft,
    required ListingAddressDraft addressDraft,
    required dynamic titleCtrl, // TextEditingController
    required dynamic descCtrl, // TextEditingController
  }) {
    // Genel textler
    titleCtrl.text = title;
    descCtrl.text = description;
    detailsDraft.priceCtrl.text = priceText;

    // ilanTipi/kredi/takas/kimden
    detailsDraft.setIlanTipi(ilanTipiDb == 2 ? IlanTipi.kiralik : IlanTipi.satilik);
    detailsDraft.setKredi(kredi);
    detailsDraft.setTakas(takas);
    detailsDraft.setKimden(kimdenDb == 2 ? KimdenTipi.galeriden : KimdenTipi.sahibinden);

    final a = _normalizeAddressMap(address);

    // Adres (zorunlu: ulke/sehir/ilce)
    addressDraft.setCountry((a['ulke'] ?? 'TR').toString());
    addressDraft.ilCtrl.text = (a['sehir'] ?? '').toString();
    addressDraft.ilceCtrl.text = (a['ilce'] ?? '').toString();

    // Opsiyonel DB alanları
    addressDraft.mahalleCtrl.text = (a['mahalle'] ?? '').toString();
    addressDraft.caddeCtrl.text = (a['cadde'] ?? '').toString();
    addressDraft.sokakCtrl.text = (a['sokak'] ?? '').toString();

    addressDraft.binaNoCtrl.text = _toIntStringOrEmpty(a['bina_no']);
    addressDraft.daireNoCtrl.text = _toIntStringOrEmpty(a['daire_no']);
    addressDraft.postaKoduCtrl.text = _toIntStringOrEmpty(a['posta_kodu']);

    // Detaylar
    if (mainCategory == ListingMainCategory.emlak) {
      _applyPropertyDetails(detailsDraft);
    } else {
      _applyVehicleDetails(detailsDraft);
    }

    addressDraft.notifyListeners();
    detailsDraft.notifyListeners();
  }

  void _applyPropertyDetails(ListingDetailsDraft d) {
    // ✅ yeni key'ler: m2Brut, m2Net, tapuDurumu, isitma...
    // 🔁 eski fallback: grossM2, netM2, deedStatus, heating...

    final gross = _pick(details, ['m2Brut', 'grossM2', 'area']);
    final net = _pick(details, ['m2Net', 'netM2', 'area']);

    _setTextIfNotNull(d.m2BrutCtrl, gross);
    _setTextIfNotNull(d.m2NetCtrl, net);

    final room = _pickString(details, ['odaSayisi', 'roomCount']);
    if (_isNotEmpty(room)) {
      d.setOdaSayisi(_normalizeRoom(room!));
    }

    _setTextIfNotNull(d.binaYasiCtrl, _pick(details, ['binaYasi', 'buildingAge']));
    _setTextIfNotNull(d.bulunduguKatCtrl, _pick(details, ['bulunduguKat', 'floor']));
    _setTextIfNotNull(d.katSayisiCtrl, _pick(details, ['katSayisi', 'totalFloors']));

    final isitmaRaw = _pickString(details, ['isitma', 'heating']);
    final isitmaNorm = _normalizeIsitma(isitmaRaw);
    if (_isNotEmpty(isitmaNorm) && _inAllowed(isitmaNorm!, _isitmaAllowed)) {
      d.setIsitma(isitmaNorm);
    }

    final tapuRaw = _pickString(details, ['tapuDurumu', 'deedStatus']);
    final tapuNorm = _normalizeTapu(tapuRaw);
    if (_isNotEmpty(tapuNorm) && _inAllowed(tapuNorm!, _tapuAllowed)) {
      d.setTapuDurumu(tapuNorm);
    }

    final hasParking = _pick(details, ['otopark', 'hasParking']);
    if (hasParking is bool) d.setOtopark(hasParking);

    // Konut alanları
    final asansor = _pick(details, ['asansor', 'hasElevator']);
    if (asansor is bool) d.setAsansor(asansor);

    final esyali = _pick(details, ['esyali', 'isFurnished']);
    if (esyali is bool) d.setEsyali(esyali);

    final banyo = _pick(details, ['banyoSayisi']);
    _setTextIfNotNull(d.banyoSayisiCtrl, banyo);

    final mutfakRaw = _pickString(details, ['mutfakTipi']);
    if (_isNotEmpty(mutfakRaw)) {
      final v = _normalizeMutfak(mutfakRaw!);
      if (_inAllowed(v!, _mutfakAllowed)) d.setMutfakTipi(v);
    }

    final balkon = _pick(details, ['balkon']);
    if (balkon is bool) d.setBalkon(balkon);

    final kullanimRaw = _pickString(details, ['kullanimDurumu']);
    if (_isNotEmpty(kullanimRaw)) {
      final v = _normalizeKullanim(kullanimRaw!);
      if (_inAllowed(v, _kullanimAllowed)) d.setKullanimDurumu(v);
    }

    // Site içinde: önce flag, sonra ctrl'ler (setSiteIcinde false ise ctrl'leri sıfırlıyor)
    final siteIcinde = _pick(details, ['siteIcinde']);
    if (siteIcinde is bool) d.setSiteIcinde(siteIcinde);

    if (d.siteIcinde) {
      final siteAdi = _pickString(details, ['siteAdi']);
      if (_isNotEmpty(siteAdi)) d.siteAdiCtrl.text = siteAdi!;
      final aidat = _pick(details, ['aidat']);
      if (aidat != null) d.aidatCtrl.text = _toIntString(aidat);
    }

    // Arsa alanları (yeni + eski)
    final imarRaw = _pickString(details, ['imarDurumu', 'zoningStatus']);
    if (_isNotEmpty(imarRaw)) {
      final v = _normalizeImar(imarRaw!);
      if (v == null) {
        d.setImarDurumu(null);
      } else if (_inAllowed(v, _imarAllowed)) {
        d.setImarDurumu(v);
      } else {
        d.setImarDurumu(null);
      }
    }

    _setTextIfNotNull(d.adaNoCtrl, _pick(details, ['adaNo', 'blockNo']));
    _setTextIfNotNull(d.parselNoCtrl, _pick(details, ['parselNo', 'parcelNo']));
    _setTextIfNotNull(d.paftaNoCtrl, _pick(details, ['paftaNo', 'sheetNo']));

    final kaks = _pick(details, ['kaksEmsal', 'floorAreaRatio']);
    if (kaks != null) d.kaksEmsalCtrl.text = kaks.toString();

    final gabari = _pick(details, ['gabari']);
    if (gabari != null) d.gabariCtrl.text = gabari.toString();

    // Turistik alanları
    _setTextIfNotNull(d.apartSayisiCtrl, _pick(details, ['apartSayisi']));
    _setTextIfNotNull(d.yatakSayisiTesisCtrl, _pick(details, ['yatakSayisi', 'bedCount']));
    _setTextIfNotNull(d.acikAlanCtrl, _pick(details, ['acikAlanM2', 'openArea']));
    _setTextIfNotNull(d.kapaliAlanCtrl, _pick(details, ['kapaliAlanM2', 'closedArea']));

    final zemin = _pick(details, ['zeminEtudu']);
    if (zemin is bool || zemin == null) d.setZeminEtudu(zemin as bool?);

    final yapiRaw = _pickString(details, ['yapiDurumu']);
    if (_isNotEmpty(yapiRaw)) {
      final v = _normalizeYapiDurumu(yapiRaw!);
      if (v == null) {
        d.setYapiDurumu(null);
      } else if (_inAllowed(v, _yapiAllowed)) {
        d.setYapiDurumu(v);
      }
    }

    // Devre mülk
    final devreRaw = _pickString(details, ['devreDonem', 'period']);
    if (_isNotEmpty(devreRaw)) {
      final v = _normalizeDevreDonem(devreRaw!);
      if (_inAllowed(v, _devreAllowed)) d.setDevreDonem(v);
    }
  }

  void _applyVehicleDetails(ListingDetailsDraft d) {
    // ✅ yeni key'ler: markaName, seriIsmi, modelIsmi, modelYili, yakit, vites...
    // 🔁 eski fallback: brand, model (seri), year, fuel, gear...

    final brand = _pickString(details, ['markaName', 'brand']);
    final series = _pickString(details, ['seriIsmi', 'model']); // eskide model=seri
    final modelName = _pickString(details, ['modelIsmi']);

    if (_isNotEmpty(brand)) d.markaNameCtrl.text = brand!;
    if (_isNotEmpty(series)) d.seriIsmiCtrl.text = series!;

    // model ismi yeni key varsa direkt; yoksa title'dan çıkar
    if (_isNotEmpty(modelName)) {
      d.modelIsmiCtrl.text = modelName!;
    } else {
      d.modelIsmiCtrl.text = _extractModelTrimmed(title, brand, series);
    }

    _setTextIfNotNull(d.modelYiliCtrl, _pick(details, ['modelYili', 'year']));
    _setTextIfNotNull(d.kmCtrl, _pick(details, ['km']));
    _setTextIfNotNull(d.motorGucuCtrl, _pick(details, ['motorGucu', 'enginePower']));
    _setTextIfNotNull(d.motorHacmiCtrl, _pick(details, ['motorHacmi', 'engineVolume']));
    final renk = _pickString(details, ['renk', 'color']);
    if (_isNotEmpty(renk)) d.renkCtrl.text = renk!;

    final mensei = _pickString(details, ['mensei']);
    if (_isNotEmpty(mensei)) d.menseiCtrl.text = mensei!;

    final yakitRaw = _pickString(details, ['yakit', 'fuel']);
    final yakitNorm = _normalizeFromAllowed(yakitRaw, _yakitAllowed);
    if (_isNotEmpty(yakitNorm)) d.setYakit(yakitNorm!);

    final vitesRaw = _pickString(details, ['vites', 'gear']);
    final vitesNorm = _normalizeFromAllowed(vitesRaw, _vitesAllowed);
    if (_isNotEmpty(vitesNorm)) d.setVites(vitesNorm!);

    final durumRaw = _pickString(details, ['aracDurumu', 'condition']);
    final durumNorm = _normalizeFromAllowed(durumRaw, _aracDurumuAllowed);
    if (_isNotEmpty(durumNorm)) d.setAracDurumu(durumNorm!);

    final garantiRaw = _pickString(details, ['garanti']);
    final garantiNorm = _normalizeFromAllowed(garantiRaw, _garantiAllowed);
    if (_isNotEmpty(garantiNorm)) d.setGaranti(garantiNorm!);

    final plaka = _pickString(details, ['plakaUyruk']);
    if (_isNotEmpty(plaka) && _inAllowed(plaka!, _plakaAllowed)) {
      d.setPlakaUyruk(plaka);
    }

    final agirHasar = _pick(details, ['agirHasar', 'agirHasarKaydi']);
    if (agirHasar is bool) d.setAgirHasar(agirHasar);

    // Alt kategoriler (int id)
    final kasaTipi = _pick(details, ['kasaTipi']);
    if (kasaTipi != null) d.setKasaTipi(_readInt(kasaTipi, fallback: d.kasaTipi));

    final cekis = _pick(details, ['cekis']);
    if (cekis != null) d.setCekis(_readInt(cekis, fallback: d.cekis));

    final zamanlama = _pick(details, ['zamanlamaTipi']);
    if (zamanlama != null) d.setZamanlamaTipi(_readInt(zamanlama, fallback: d.zamanlamaTipi));

    final sogutma = _pick(details, ['sogutma']);
    if (sogutma != null) d.setSogutma(_readInt(sogutma, fallback: d.sogutma));

    _setTextIfNotNull(d.silindirSayisiCtrl, _pick(details, ['silindirSayisi', 'cylinderCount']));

    final karavanTuru = _pick(details, ['karavanTuru']);
    if (karavanTuru != null) d.setKaravanTuru(_readInt(karavanTuru, fallback: d.karavanTuru));

    final karavanTipi = _pick(details, ['karavanTipi']);
    if (karavanTipi != null) d.setKaravanTipi(_readInt(karavanTipi, fallback: d.karavanTipi));

    _setTextIfNotNull(d.yatakSayisiKaravanCtrl, _pick(details, ['yatakSayisiKaravan', 'bedCount']));

    final kabin = _pick(details, ['kabin']);
    if (kabin != null) d.setKabin(_readInt(kabin, fallback: d.kabin));

    _setTextIfNotNull(d.lastikYuzdeCtrl, _pick(details, ['lastikYuzde', 'tireCondition']));
    _setTextIfNotNull(d.yatakSayisiTirCtrl, _pick(details, ['yatakSayisiTir', 'bedCount']));

    final dorse = _pick(details, ['dorse', 'hasTrailer']);
    if (dorse is bool) d.setDorse(dorse);
  }

  // ---------- helpers ----------

  static ListingEmlakCategory _emlakFromSub(String sub) {
    if (sub.contains('konut')) return ListingEmlakCategory.konut;
    if (sub.contains('arsa')) return ListingEmlakCategory.arsa;
    if (sub.contains('turistik')) return ListingEmlakCategory.turistik;
    if (sub.contains('devre')) return ListingEmlakCategory.devreMulk;
    return ListingEmlakCategory.konut;
  }

  static ListingVasitaCategory _vasitaFromSub(String sub) {
    if (sub.contains('otomobil')) return ListingVasitaCategory.otomobil;
    if (sub.contains('motosiklet')) return ListingVasitaCategory.motosiklet;
    if (sub.contains('karavan')) return ListingVasitaCategory.karavan;
    if (sub.contains('tir') || sub.contains('tır')) return ListingVasitaCategory.tir;
    return ListingVasitaCategory.otomobil;
  }

  static Map<String, dynamic> _normalizeAddressMap(Map<String, dynamic> a) {
    final out = Map<String, dynamic>.from(a);

    // camelCase -> snake_case
    if (out.containsKey('binaNo') && !out.containsKey('bina_no')) out['bina_no'] = out['binaNo'];
    if (out.containsKey('daireNo') && !out.containsKey('daire_no')) out['daire_no'] = out['daireNo'];
    if (out.containsKey('postaKodu') && !out.containsKey('posta_kodu')) out['posta_kodu'] = out['postaKodu'];

    // alternatif anahtarlar
    if (out.containsKey('country') && !out.containsKey('ulke')) out['ulke'] = out['country'];
    if (out.containsKey('city') && !out.containsKey('sehir')) out['sehir'] = out['city'];
    if (out.containsKey('district') && !out.containsKey('ilce')) out['ilce'] = out['district'];

    return out;
  }

  static String _toIntStringOrEmpty(Object? v) {
    if (v == null) return '';
    final s = v.toString().trim();
    if (s.isEmpty) return '';
    final n = int.tryParse(s);
    return n?.toString() ?? '';
  }

  static Object? _pick(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      if (m.containsKey(k) && m[k] != null) return m[k];
    }
    return null;
  }

  static String? _pickString(Map<String, dynamic> m, List<String> keys) {
    final v = _pick(m, keys);
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }

  static void _setTextIfNotNull(dynamic ctrl, Object? v) {
    if (v == null) return;
    ctrl.text = _toIntString(v);
  }

  static String _toIntString(Object v) {
    if (v is int) return v.toString();
    if (v is double) {
      if (v % 1 == 0) return v.toInt().toString();
      return v.toString();
    }
    final s = v.toString().trim();
    final n = num.tryParse(s.replaceAll(',', '.'));
    if (n == null) return s;
    return _numToCleanString(n);
  }

  static int _readInt(Object v, {required int fallback}) {
    if (v is int) return v;
    if (v is double) return v.toInt();
    final s = v.toString().trim();
    return int.tryParse(s) ?? fallback;
  }

  static bool _isNotEmpty(String? s) => s != null && s.trim().isNotEmpty;

  static bool _inAllowed(String value, List<String> allowed) =>
      allowed.any((a) => a.toLowerCase().trim() == value.toLowerCase().trim());

  static String? _normalizeFromAllowed(String? value, List<String> allowed) {
    if (!_isNotEmpty(value)) return null;
    final v = value!.trim();

    for (final a in allowed) {
      if (a.toLowerCase().trim() == v.toLowerCase().trim()) return a;
    }

    final low = v.toLowerCase();
    if (allowed == _vitesAllowed) {
      if (low.contains('manuel')) return 'Düz';
      if (low.contains('otomatik')) return 'Otomatik';
    }
    if (allowed == _aracDurumuAllowed) {
      if (low.contains('2')) return 'İkinci El';
      if (low.contains('sıf')) return 'Sıfır';
    }
    return null;
  }

  static String _normalizeRoom(String raw) => raw.replaceAll(' ', '');

  static String? _normalizeIsitma(String? raw) {
    if (!_isNotEmpty(raw)) return null;
    final s = raw!.trim();
    final low = s.toLowerCase();

    if (low.contains('doğalgaz') && low.contains('kombi')) return 'Doğalgaz';
    if (low.contains('kombi')) return 'Kombi';
    if (low.contains('merkezi')) return 'Merkezi';
    if (low.contains('soba')) return 'Soba';
    if (low.contains('klima')) return 'Klima';
    if (low.contains('yerden')) return 'Yerden Isıtma';
    if (low.contains('belirtil')) return 'Belirtilmemiş';

    return s;
  }

  static String? _normalizeTapu(String? raw) {
    if (!_isNotEmpty(raw)) return null;
    final s = raw!.trim();
    final low = s.toLowerCase();

    if (low.contains('kat') && low.contains('mülkiyet')) return 'Kat Mülkiyeti';
    if (low.contains('kat') && low.contains('irtif')) return 'Kat İrtifakı';
    if (low.contains('hiss')) return 'Hisseli Tapu';
    if (low.contains('müst') || low.contains('must')) return 'Müstakil Tapu';
    if (low.contains('belirtil')) return 'Belirtilmemiş';

    return s;
  }

  static String? _normalizeImar(String raw) {
    final s = raw.trim();
    final low = s.toLowerCase();

    if (low.contains('seçil') || low.contains('sec')) return null;

    if (low.contains('konut')) return 'Konut';
    if (low.contains('ticari')) return 'Ticari';
    if (low.contains('sanayi')) return 'Sanayi';
    if (low.contains('tarla')) return 'Tarla';
    if (low.contains('imarsız') || low.contains('imarsiz')) return 'İmarsız';
    if (low.contains('imarlı') || low.contains('imarli')) return 'İmarlı';

    return null;
  }

  static String? _normalizeMutfak(String raw) {
    final s = raw.trim();
    final low = s.toLowerCase();
    if (low.contains('amerikan')) return 'Amerikan';
    if (low.contains('aç') || low.contains('ac')) return 'Açık';
    if (low.contains('kap')) return 'Kapalı';
    if (low.contains('belirtil')) return 'Belirtilmemiş';
    return s;
  }

  static String _normalizeKullanim(String raw) {
    final s = raw.trim();
    final low = s.toLowerCase();
    if (low.contains('kiracı') || low.contains('kiraci') || low.contains('kirac')) return 'Kiracı Oturuyor';
    if (low.contains('mal') && low.contains('sah')) return 'Mal Sahibi Oturuyor';
    if (low.contains('boş') || low.contains('bos')) return 'Boş';
    if (low.contains('belirtil')) return 'Belirtilmemiş';
    return s;
  }

  static String? _normalizeYapiDurumu(String raw) {
    final s = raw.trim();
    final low = s.toLowerCase();
    if (low.contains('sıf') || low.contains('sif')) return 'Sıfır';
    if (low.contains('ikin')) return 'İkinci El';
    if (low.contains('yapım') || low.contains('yapim')) return 'Yapım Aşamasında';
    if (low.contains('ruhsat')) return 'Ruhsatlı';
    return s;
  }

  static String _normalizeDevreDonem(String raw) {
    final s = raw.trim();
    final low = s.toLowerCase();
    if (low.contains('yaz')) return 'Yaz';
    if (low.contains('kış') || low.contains('kis')) return 'Kış';
    if (low.contains('bahar')) return 'Bahar';
    if (low.contains('sonbah')) return 'Sonbahar';
    if (low.contains('haft')) return 'Haftalık';
    if (low.contains('ayl')) return 'Aylık';
    return s;
  }

  static String _extractModelTrimmed(String title, String? brand, String? series) {
    var s = title.trim();

    if (_isNotEmpty(brand)) {
      final b = brand!.trim();
      if (s.toLowerCase().startsWith(b.toLowerCase())) {
        s = s.substring(b.length).trim();
      }
    }

    if (_isNotEmpty(series)) {
      final m = series!.trim();
      if (s.toLowerCase().startsWith(m.toLowerCase())) {
        s = s.substring(m.length).trim();
      }
    }

    return s;
  }

  static String _numToCleanString(num n) {
    if (n % 1 == 0) return n.toInt().toString();
    return n
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

  // ---- allowed sets (UI dropdown listeleri ile aynı olmalı) ----
  static const _isitmaAllowed = <String>[
    'Doğalgaz',
    'Kombi',
    'Merkezi',
    'Soba',
    'Klima',
    'Yerden Isıtma',
    'Belirtilmemiş',
  ];

  static const _tapuAllowed = <String>[
    'Kat Mülkiyeti',
    'Kat İrtifakı',
    'Hisseli Tapu',
    'Müstakil Tapu',
    'Belirtilmemiş',
  ];

  static const _imarAllowed = <String>[
    'İmarlı',
    'İmarsız',
    'Konut',
    'Ticari',
    'Sanayi',
    'Tarla',
  ];

  static const _mutfakAllowed = <String>[
    'Kapalı',
    'Açık',
    'Amerikan',
    'Belirtilmemiş',
  ];

  static const _kullanimAllowed = <String>[
    'Boş',
    'Kiracı Oturuyor',
    'Mal Sahibi Oturuyor',
    'Belirtilmemiş',
  ];

  static const _yapiAllowed = <String>[
    'Sıfır',
    'İkinci El',
    'Yapım Aşamasında',
    'Ruhsatlı',
  ];

  static const _devreAllowed = <String>[
    'Yaz',
    'Kış',
    'Bahar',
    'Sonbahar',
    'Haftalık',
    'Aylık',
  ];

  static const _yakitAllowed = <String>[
    'Benzin',
    'Dizel',
    'LPG',
    'Hibrit',
    'Elektrik',
  ];

  static const _vitesAllowed = <String>[
    'Düz',
    'Otomatik',
    'Yarı Otomatik',
  ];

  static const _aracDurumuAllowed = <String>[
    'Sıfır',
    'İkinci El',
  ];

  static const _garantiAllowed = <String>[
    'Yok',
    'Var',
    'Üretici',
    'Yetkili Servis',
  ];

  static const _plakaAllowed = <String>['TR', 'DE', 'NL'];
}
