import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '/core/theme/colors.dart';
import '/core/models/listing_model.dart';
import '/core/services/auth_service.dart';
import '/core/services/favorite_service.dart';
import '/shared/app_footer.dart';

class ListingDetailScreen extends StatelessWidget {
  final Listing? listing;

  const ListingDetailScreen({super.key, this.listing});

  static final AuthService _authService = AuthService();
  static final FavoriteService _favoriteService = FavoriteService();

  /// HashCode -> string kısaysa substring patlamasın diye güvenli 8 hane üretir
  String _safeShortId(Object id) {
    final s = id.hashCode.abs().toString();
    if (s.length >= 8) return s.substring(0, 8);
    return s.padLeft(8, '0');
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,###', 'tr_TR');
    return '${formatter.format(price)} TL';
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy', 'tr_TR').format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (listing == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: 16),
              Text(
                'İlan bulunamadı',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Ana Sayfaya Dön'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildContent(context, listing!)),
          const SliverToBoxAdapter(child: AppFooter()),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Listing listing) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton(context),
          const SizedBox(height: 24),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sol taraf: Başlık (açıklama dahil), Görsel
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleCard(listing),
                      const SizedBox(height: 16),
                      Expanded(child: _buildImage(listing)),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                // Sağ taraf: İlan Detayları, Favori Butonu
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildDetailsCard(listing)),
                      const SizedBox(height: 16),
                      _buildFavoriteButton(context, listing),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'İlanlara Dön',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleCard(Listing listing) {
    final listingNo = _safeShortId(listing.id);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sol: Başlık, Fiyat, Açıklama
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listing.title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF0F6FC),
                  ),
                ),
                const Divider(color: Color(0xFF30363D), height: 10),
                const SizedBox(height: 10),
                Text(
                  'Açıklama',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF0F6FC),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  listing.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.6,
                    color: const Color(0xFFC9D1D9),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _formatPrice(listing.price),
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFFF6B6B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Sağ: İlan No, Adres, Tarih
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'İlan No: $listingNo',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF8B949E),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Color(0xFF8B949E),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${listing.city} / ${listing.district}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF8B949E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Color(0xFF8B949E),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(listing.createdAt),
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF8B949E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Listing listing) {
    return Container(
      constraints: const BoxConstraints(minHeight: 300),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF30363D)),
        image: DecorationImage(
          image: NetworkImage(listing.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, Listing listing) {
    return InkWell(
      onTap: () async {
        final user = _authService.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Favorilere eklemek için lütfen giriş yapın.')),
          );
          return;
        }

        final ilanId = int.tryParse(listing.id) ?? 0;
        if (ilanId == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('İlan ID geçersiz, favorilere eklenemedi.'), backgroundColor: Colors.red),
          );
          return;
        }

        final ok = await _favoriteService.addFavorite(
          ilanId: ilanId,
          kullaniciId: user.kullaniciId,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ok ? 'Favorilere eklendi.' : 'Favorilere eklenemedi.'),
            backgroundColor: ok ? Colors.green : Colors.red,
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFD97706), Color(0xFFB45309)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 20, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Favorilere Ekle',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// İlan detayları kartı (sağ tarafta)
  Widget _buildDetailsCard(Listing listing) {
    final isVehicle = listing.category == 'vasita';
    final details = isVehicle
        ? _getVehicleDetailItems(listing)
        : _getPropertyDetailItems(listing);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'İlan Detayları',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF0F6FC),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFF30363D), height: 4),
          const SizedBox(height: 10),
          Expanded(child: _buildTwoColumnDetails(details)),
        ],
      ),
    );
  }

  /// İki sütunlu detay gösterimi
  Widget _buildTwoColumnDetails(List<MapEntry<String, String>> details) {
    final leftColumn = <MapEntry<String, String>>[];
    final rightColumn = <MapEntry<String, String>>[];

    for (int i = 0; i < details.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(details[i]);
      } else {
        rightColumn.add(details[i]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: leftColumn
                .map((e) => _buildDetailRow(e.key, e.value))
                .toList(),
          ),
        ),
        const Divider(color: Color(0xFF30363D), height: 10),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: rightColumn
                .map((e) => _buildDetailRow(e.key, e.value))
                .toList(),
          ),
        ),
      ],
    );
  }

  List<MapEntry<String, String>> _getVehicleDetailItems(Listing listing) {
    final d = listing.details;
    final listingNo = _safeShortId(listing.id);
    final items = <MapEntry<String, String>>[];

    items.add(MapEntry('İlan No', listingNo));
    items.add(MapEntry('İlan Tarihi', _formatDate(listing.createdAt)));
    if (d['markaName'] != null) items.add(MapEntry('Marka', d['markaName']));
    if (d['seriIsmi'] != null) items.add(MapEntry('Seri', d['seriIsmi']));
    if (d['modelIsmi'] != null) items.add(MapEntry('Model', d['modelIsmi']));
    if (d['modelYili'] != null)
      items.add(MapEntry('Model Yılı', d['modelYili'].toString()));
    if (d['mensei'] != null) items.add(MapEntry('Menşei', d['mensei']));
    if (d['km'] != null)
      items.add(
        MapEntry(
          'Kilometre',
          '${NumberFormat('#,###', 'tr_TR').format(d['km'])} km',
        ),
      );
    if (d['yakit'] != null) items.add(MapEntry('Yakıt Tipi', d['yakit']));
    if (d['vites'] != null) items.add(MapEntry('Vites', d['vites']));
    if (d['motorHacmi'] != null)
      items.add(MapEntry('Motor Hacmi', '${d['motorHacmi']} cc'));
    if (d['motorGucu'] != null)
      items.add(MapEntry('Motor Gücü', '${d['motorGucu']} hp'));
    if (d['renk'] != null) items.add(MapEntry('Renk', d['renk']));
    if (d['aracDurumu'] != null)
      items.add(MapEntry('Araç Durumu', d['aracDurumu']));
    items.add(MapEntry('Kimden', listing.sellerType));
    items.add(
      MapEntry('Ağır Hasar Kaydı', d['agirHasar'] == true ? 'Var' : 'Yok'),
    );
    items.add(MapEntry('Garanti', d['garanti'] ?? 'Garantisi Yok'));
    items.add(MapEntry('Plaka / Uyruk', d['plakaUyruk'] ?? 'Türkiye'));
    items.add(MapEntry('Takas', listing.takas ? 'Yapılır' : 'Yapılmaz'));
    items.add(
      MapEntry(
        'Kredi Uygunluğu',
        listing.krediUygunlugu ? 'Uygun' : 'Uygun Değil',
      ),
    );
    if (d['kasaTipi'] != null) items.add(MapEntry('Kasa Tipi', d['kasaTipi']));
    if (d['cekis'] != null) items.add(MapEntry('Çekiş', d['cekis']));
    if (d['silindirSayisi'] != null)
      items.add(MapEntry('Silindir Sayısı', d['silindirSayisi'].toString()));
    if (d['sogutma'] != null) items.add(MapEntry('Soğutma', d['sogutma']));
    if (d['yatakSayisiKaravan'] != null && listing.subCategory == 'karavan')
      items.add(MapEntry('Yatak Sayısı', d['yatakSayisiKaravan'].toString()));
    if (d['karavanTuru'] != null)
      items.add(MapEntry('Karavan Türü', d['karavanTuru']));
    if (d['karavanTipi'] != null)
      items.add(MapEntry('Karavan Tipi', d['karavanTipi']));
    if (d['kabin'] != null) items.add(MapEntry('Kabin', d['kabin']));
    if (d['lastikYuzde'] != null)
      items.add(MapEntry('Lastik Durumu', '%${d['lastikYuzde']}'));
    if (d['dorse'] != null)
      items.add(MapEntry('Dorse', d['dorse'] == true ? 'Var' : 'Yok'));
    if (d['yatakSayisiTir'] != null && listing.subCategory == 'tir')
      items.add(MapEntry('Yatak Sayısı', d['yatakSayisiTir'].toString()));

    return items;
  }

  List<MapEntry<String, String>> _getPropertyDetailItems(Listing listing) {
    final d = listing.details;
    final listingNo = _safeShortId(listing.id);
    final items = <MapEntry<String, String>>[];

    items.add(MapEntry('İlan No', listingNo));
    items.add(MapEntry('İlan Tarihi', _formatDate(listing.createdAt)));
    if (d['m2Brut'] != null)
      items.add(MapEntry('m² (Brüt)', '${d['m2Brut']} m²'));
    if (d['m2Net'] != null) items.add(MapEntry('m² (Net)', '${d['m2Net']} m²'));
    if (d['tapuDurumu'] != null)
      items.add(MapEntry('Tapu Durumu', d['tapuDurumu']));
    // Konut / Yerleşke detayları
    if (d['odaSayisi'] != null)
      items.add(MapEntry('Oda Sayısı', d['odaSayisi'].toString()));
    if (d['binaYasi'] != null)
      items.add(MapEntry('Bina Yaşı', '${d['binaYasi']} yaşında'));
    if (d['bulunduguKat'] != null)
      items.add(MapEntry('Bulunduğu Kat', '${d['bulunduguKat']}. Kat'));
    if (d['katSayisi'] != null)
      items.add(MapEntry('Kat Sayısı', d['katSayisi'].toString()));
    if (d['isitma'] != null) items.add(MapEntry('Isıtma', d['isitma']));
    if (d['banyoSayisi'] != null)
      items.add(MapEntry('Banyo Sayısı', d['banyoSayisi'].toString()));
    if (d['mutfakTipi'] != null)
      items.add(MapEntry('Mutfak Tipi', d['mutfakTipi']));
    if (d['otopark'] != null)
      items.add(MapEntry('Otopark', d['otopark'] == true ? 'Var' : 'Yok'));
    if (d['asansor'] != null)
      items.add(MapEntry('Asansör', d['asansor'] == true ? 'Var' : 'Yok'));
    if (d['balkon'] != null)
      items.add(MapEntry('Balkon', d['balkon'] == true ? 'Var' : 'Yok'));
    if (d['esyali'] != null)
      items.add(MapEntry('Eşyalı', d['esyali'] == true ? 'Evet' : 'Hayır'));
    if (d['kullanimDurumu'] != null)
      items.add(MapEntry('Kullanım Durumu', d['kullanimDurumu']));
    if (d['siteIcinde'] != null)
      items.add(
        MapEntry('Site İçinde', d['siteIcinde'] == true ? 'Evet' : 'Hayır'),
      );
    if (d['siteAdi'] != null && d['siteAdi'] != '')
      items.add(MapEntry('Site Adı', d['siteAdi']));
    if (d['aidat'] != null && d['aidat'] > 0)
      items.add(MapEntry('Aidat', '${d['aidat']} TL'));
    // Arsa detayları
    if (d['imarDurumu'] != null)
      items.add(MapEntry('İmar Durumu', d['imarDurumu']));
    if (d['adaNo'] != null)
      items.add(MapEntry('Ada No', d['adaNo'].toString()));
    if (d['parselNo'] != null)
      items.add(MapEntry('Parsel No', d['parselNo'].toString()));
    if (d['paftaNo'] != null)
      items.add(MapEntry('Pafta No', d['paftaNo'].toString()));
    if (d['kaksEmsal'] != null)
      items.add(MapEntry('Kaks (Emsal)', d['kaksEmsal']));
    if (d['gabari'] != null) items.add(MapEntry('Gabari', d['gabari']));
    // Turistik Tesis detayları
    if (d['apartSayisi'] != null && d['apartSayisi'] > 0)
      items.add(MapEntry('Apart Sayısı', d['apartSayisi'].toString()));
    if (d['yatakSayisi'] != null)
      items.add(MapEntry('Yatak Sayısı', d['yatakSayisi'].toString()));
    if (d['acikAlanM2'] != null)
      items.add(MapEntry('Açık Alan', '${d['acikAlanM2']} m²'));
    if (d['kapaliAlanM2'] != null)
      items.add(MapEntry('Kapalı Alan', '${d['kapaliAlanM2']} m²'));
    if (d['zeminEtudu'] != null)
      items.add(
        MapEntry('Zemin Etüdü', d['zeminEtudu'] == true ? 'Var' : 'Yok'),
      );
    if (d['yapiDurumu'] != null)
      items.add(MapEntry('Yapı Durumu', d['yapiDurumu']));
    // Devre Mülk detayları
    if (d['devreDonem'] != null) items.add(MapEntry('Dönem', d['devreDonem']));
    items.add(MapEntry('Kimden', listing.sellerType));
    items.add(MapEntry('Takas', listing.takas ? 'Yapılır' : 'Yapılmaz'));
    items.add(
      MapEntry(
        'Kredi Uygunluğu',
        listing.krediUygunlugu ? 'Uygun' : 'Uygun Değil',
      ),
    );

    return items;
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF8B949E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFC9D1D9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
