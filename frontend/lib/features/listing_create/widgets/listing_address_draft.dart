import 'package:flutter/material.dart';

class ListingAddressDraft extends ChangeNotifier {
  String country = 'TR';

  final ilCtrl = TextEditingController();
  final ilceCtrl = TextEditingController();

  // DB: ADRES alanları (opsiyonel)
  final mahalleCtrl = TextEditingController();
  final caddeCtrl = TextEditingController();
  final sokakCtrl = TextEditingController();

  final binaNoCtrl = TextEditingController();
  final daireNoCtrl = TextEditingController();
  final postaKoduCtrl = TextEditingController();

  void setCountry(String v) {
    country = v;
    notifyListeners();
  }

  @override
  void dispose() {
    ilCtrl.dispose();
    ilceCtrl.dispose();

    mahalleCtrl.dispose();
    caddeCtrl.dispose();
    sokakCtrl.dispose();

    binaNoCtrl.dispose();
    daireNoCtrl.dispose();
    postaKoduCtrl.dispose();

    super.dispose();
  }
}
