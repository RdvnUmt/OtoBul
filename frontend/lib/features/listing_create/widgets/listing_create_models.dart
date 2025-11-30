enum ListingMainCategory {
  vasita,
  emlak;

  String get label {
    switch (this) {
      case ListingMainCategory.vasita:
        return 'Vasıta';
      case ListingMainCategory.emlak:
        return 'Emlak';
    }
  }
}

enum ListingVasitaCategory {
  otomobil,
  motosiklet,
  karavan,
  tir;

  String get label {
    switch (this) {
      case ListingVasitaCategory.otomobil:
        return 'Otomobil';
      case ListingVasitaCategory.motosiklet:
        return 'Motosiklet';
      case ListingVasitaCategory.karavan:
        return 'Karavan';
      case ListingVasitaCategory.tir:
        return 'Tır';
    }
  }
}

enum ListingEmlakCategory {
  konut,
  arsa,
  turistik,
  devreMulk;

  String get label {
    switch (this) {
      case ListingEmlakCategory.konut:
        return 'Konut';
      case ListingEmlakCategory.arsa:
        return 'Arsa';
      case ListingEmlakCategory.turistik:
        return 'Turistik Tesis';
      case ListingEmlakCategory.devreMulk:
        return 'Devre Mülk';
    }
  }
}
