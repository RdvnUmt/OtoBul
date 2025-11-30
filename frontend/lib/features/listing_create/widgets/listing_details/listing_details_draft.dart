import 'package:flutter/material.dart';

import 'listing_details_types.dart';

class ListingDetailsDraft extends ChangeNotifier {
  // -------- Genel --------
  IlanTipi ilanTipi = IlanTipi.satilik;
  KimdenTipi kimden = KimdenTipi.sahibinden;
  bool kredi = false;
  bool takas = false;

  final TextEditingController priceCtrl = TextEditingController();

  // -------- Emlak --------
  final TextEditingController m2BrutCtrl = TextEditingController();
  final TextEditingController m2NetCtrl = TextEditingController();
  String tapuDurumu = 'Kat Mülkiyeti';

  // Arsa
  String? imarDurumu;
  final TextEditingController adaNoCtrl = TextEditingController();
  final TextEditingController parselNoCtrl = TextEditingController();
  final TextEditingController paftaNoCtrl = TextEditingController();
  final TextEditingController kaksEmsalCtrl = TextEditingController();
  final TextEditingController gabariCtrl = TextEditingController();

  // Yerleşke
  String odaSayisi = '2+1';
  final TextEditingController binaYasiCtrl = TextEditingController();
  final TextEditingController bulunduguKatCtrl = TextEditingController();
  final TextEditingController katSayisiCtrl = TextEditingController();
  String isitma = 'Doğalgaz';
  bool otopark = false;

  // Konut
  final TextEditingController banyoSayisiCtrl = TextEditingController();
  String mutfakTipi = 'Kapalı';
  bool balkon = false;
  bool asansor = false;
  bool esyali = false;
  String kullanimDurumu = 'Boş';
  bool siteIcinde = false;
  final TextEditingController siteAdiCtrl = TextEditingController(text: '');
  final TextEditingController aidatCtrl = TextEditingController(text: '0');

  // Turistik
  final TextEditingController apartSayisiCtrl = TextEditingController();
  final TextEditingController yatakSayisiTesisCtrl = TextEditingController();
  final TextEditingController acikAlanCtrl = TextEditingController();
  final TextEditingController kapaliAlanCtrl = TextEditingController();
  bool? zeminEtudu;
  String? yapiDurumu;

  // Devre Mülk
  String devreDonem = 'Yaz';

  // -------- Vasıta --------
  final TextEditingController markaNameCtrl = TextEditingController();
  final TextEditingController seriIsmiCtrl = TextEditingController();
  final TextEditingController modelIsmiCtrl = TextEditingController();
  final TextEditingController modelYiliCtrl = TextEditingController();
  final TextEditingController menseiCtrl = TextEditingController();

  String yakit = 'Dizel';
  String vites = 'Düz';
  String aracDurumu = 'İkinci El';

  final TextEditingController kmCtrl = TextEditingController();
  final TextEditingController motorGucuCtrl = TextEditingController();
  final TextEditingController motorHacmiCtrl = TextEditingController();
  final TextEditingController renkCtrl = TextEditingController();

  String garanti = 'Yok';
  bool agirHasar = false;
  String plakaUyruk = 'TR';

  // Otomobil
  int kasaTipi = 1;
  int cekis = 1;

  // Motosiklet
  int zamanlamaTipi = 1;
  int sogutma = 1;
  final TextEditingController silindirSayisiCtrl = TextEditingController();

  // Karavan
  int karavanTuru = 1;
  int karavanTipi = 1;
  final TextEditingController yatakSayisiKaravanCtrl = TextEditingController();

  // Tır
  int kabin = 1;
  final TextEditingController lastikYuzdeCtrl = TextEditingController();
  final TextEditingController yatakSayisiTirCtrl = TextEditingController();
  bool dorse = false;

  // -------- Setters (notify) --------
  void setIlanTipi(IlanTipi v) {
    ilanTipi = v;
    notifyListeners();
  }

  void setKimden(KimdenTipi v) {
    kimden = v;
    notifyListeners();
  }

  void setKredi(bool v) {
    kredi = v;
    notifyListeners();
  }

  void setTakas(bool v) {
    takas = v;
    notifyListeners();
  }

  void setTapuDurumu(String v) {
    tapuDurumu = v;
    notifyListeners();
  }

  void setImarDurumu(String? v) {
    imarDurumu = v;
    notifyListeners();
  }

  void setOdaSayisi(String v) {
    odaSayisi = v;
    notifyListeners();
  }

  void setIsitma(String v) {
    isitma = v;
    notifyListeners();
  }

  void setOtopark(bool v) {
    otopark = v;
    notifyListeners();
  }

  void setMutfakTipi(String v) {
    mutfakTipi = v;
    notifyListeners();
  }

  void setBalkon(bool v) {
    balkon = v;
    notifyListeners();
  }

  void setAsansor(bool v) {
    asansor = v;
    notifyListeners();
  }

  void setEsyali(bool v) {
    esyali = v;
    notifyListeners();
  }

  void setKullanimDurumu(String v) {
    kullanimDurumu = v;
    notifyListeners();
  }

  void setSiteIcinde(bool v) {
    siteIcinde = v;

    // DB çakışması önlemi: NOT NULL alanlar null gitmesin
    if (!siteIcinde) {
      siteAdiCtrl.text = '';
      aidatCtrl.text = '0';
    }
    notifyListeners();
  }

  void setZeminEtudu(bool? v) {
    zeminEtudu = v;
    notifyListeners();
  }

  void setYapiDurumu(String? v) {
    yapiDurumu = v;
    notifyListeners();
  }

  void setDevreDonem(String v) {
    devreDonem = v;
    notifyListeners();
  }

  void setYakit(String v) {
    yakit = v;
    notifyListeners();
  }

  void setVites(String v) {
    vites = v;
    notifyListeners();
  }

  void setAracDurumu(String v) {
    aracDurumu = v;
    notifyListeners();
  }

  void setGaranti(String v) {
    garanti = v;
    notifyListeners();
  }

  void setAgirHasar(bool v) {
    agirHasar = v;
    notifyListeners();
  }

  void setPlakaUyruk(String v) {
    plakaUyruk = v;
    notifyListeners();
  }

  void setKasaTipi(int v) {
    kasaTipi = v;
    notifyListeners();
  }

  void setCekis(int v) {
    cekis = v;
    notifyListeners();
  }

  void setZamanlamaTipi(int v) {
    zamanlamaTipi = v;
    notifyListeners();
  }

  void setSogutma(int v) {
    sogutma = v;
    notifyListeners();
  }

  void setKaravanTuru(int v) {
    karavanTuru = v;
    notifyListeners();
  }

  void setKaravanTipi(int v) {
    karavanTipi = v;
    notifyListeners();
  }

  void setKabin(int v) {
    kabin = v;
    notifyListeners();
  }

  void setDorse(bool v) {
    dorse = v;
    notifyListeners();
  }

  @override
  void dispose() {
    priceCtrl.dispose();

    m2BrutCtrl.dispose();
    m2NetCtrl.dispose();

    adaNoCtrl.dispose();
    parselNoCtrl.dispose();
    paftaNoCtrl.dispose();
    kaksEmsalCtrl.dispose();
    gabariCtrl.dispose();

    binaYasiCtrl.dispose();
    bulunduguKatCtrl.dispose();
    katSayisiCtrl.dispose();

    banyoSayisiCtrl.dispose();
    siteAdiCtrl.dispose();
    aidatCtrl.dispose();

    apartSayisiCtrl.dispose();
    yatakSayisiTesisCtrl.dispose();
    acikAlanCtrl.dispose();
    kapaliAlanCtrl.dispose();

    markaNameCtrl.dispose();
    seriIsmiCtrl.dispose();
    modelIsmiCtrl.dispose();
    modelYiliCtrl.dispose();
    menseiCtrl.dispose();

    kmCtrl.dispose();
    motorGucuCtrl.dispose();
    motorHacmiCtrl.dispose();
    renkCtrl.dispose();

    silindirSayisiCtrl.dispose();
    yatakSayisiKaravanCtrl.dispose();

    lastikYuzdeCtrl.dispose();
    yatakSayisiTirCtrl.dispose();

    super.dispose();
  }
}
