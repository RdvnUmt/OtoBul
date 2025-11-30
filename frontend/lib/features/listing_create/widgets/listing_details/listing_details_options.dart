import 'listing_details_types.dart';

class ListingDetailsOptions {
  static const kasaTipleri = <LabeledInt>[
    LabeledInt(1, 'Sedan'),
    LabeledInt(2, 'Hatchback'),
    LabeledInt(3, 'SUV'),
    LabeledInt(4, 'Station'),
    LabeledInt(5, 'Coupe'),
  ];

  static const cekisTipleri = <LabeledInt>[
    LabeledInt(1, 'Önden Çekiş'),
    LabeledInt(2, 'Arkadan Çekiş'),
    LabeledInt(3, '4x4'),
  ];

  static const zamanlamaTipleri = <LabeledInt>[
    LabeledInt(1, 'Zincir'),
    LabeledInt(2, 'Kayış'),
    LabeledInt(3, 'Kardan'),
  ];

  static const sogutmalar = <LabeledInt>[
    LabeledInt(1, 'Hava'),
    LabeledInt(2, 'Sıvı'),
    LabeledInt(3, 'Yağ'),
  ];

  static const karavanTurleri = <LabeledInt>[
    LabeledInt(1, 'Çekme'),
    LabeledInt(2, 'Motokaravan'),
  ];

  static const karavanTipleri = <LabeledInt>[
    LabeledInt(1, 'Standart'),
    LabeledInt(2, 'Lüks'),
    LabeledInt(3, 'Off-road'),
  ];

  static const kabinTipleri = <LabeledInt>[
    LabeledInt(1, 'Alçak Tavan'),
    LabeledInt(2, 'Yüksek Tavan'),
    LabeledInt(3, 'Çift Yataklı'),
  ];
}
