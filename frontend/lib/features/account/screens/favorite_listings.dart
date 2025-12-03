// features/account/screens/favorite_listings.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '/core/theme/colors.dart';
import '/core/models/listing_model.dart';
import '/core/services/auth_service.dart';
import '/core/services/favorite_service.dart';
import '/shared/widgets/listing_card.dart';

/// Gerçek favori sayfası - backend'den favorileri çeker
class FavoriteListingsScreen extends StatefulWidget {
  const FavoriteListingsScreen({super.key});

  @override
  State<FavoriteListingsScreen> createState() => _FavoriteListingsScreenState();
}

class _FavoriteListingsScreenState extends State<FavoriteListingsScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  final AuthService _authService = AuthService();

  bool _isLoading = true;
  String? _errorMessage;
  List<Listing> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final user = _authService.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Favorileri görmek için lütfen giriş yapın.';
      });
      return;
    }

    try {
      final favorites = await _favoriteService.getFavoriteListingsForUser(user.kullaniciId);
      setState(() {
        _favorites = favorites;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Favoriler yüklenirken bir hata oluştu.';
      });
    }
  }

  Future<void> _toggleFavorite(Listing listing) async {
    final user = _authService.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Favorilere eklemek için lütfen giriş yapın.')),
      );
      return;
    }

    final ilanId = int.tryParse(listing.id) ?? 0;
    if (ilanId == 0) return;

    final isAlreadyFavorite = _favorites.any((l) => l.id == listing.id);
    bool ok;

    if (isAlreadyFavorite) {
      ok = await _favoriteService.removeFavorite(
        ilanId: ilanId,
        kullaniciId: user.kullaniciId,
      );
    } else {
      ok = await _favoriteService.addFavorite(
        ilanId: ilanId,
        kullaniciId: user.kullaniciId,
      );
    }

    if (!mounted) return;

    if (ok) {
      await _loadFavorites();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Favori işlemi başarısız oldu.'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _errorMessage!,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return FavoriteListingsPage(
      favorites: _favorites,
      onFavoriteTap: _toggleFavorite,
    );
  }
}

class FavoriteListingsPage extends StatelessWidget {
  final List<Listing> favorites;

  /// Kartın kendisine tıklanınca (detaya gitmek gibi)
  final ValueChanged<Listing>? onListingTap;

  /// Yıldız ikonuna tıklanınca (favoriden çıkar / toggle)
  final ValueChanged<Listing>? onFavoriteTap;

  final titleColor = const Color(
    0xFF102030,
  ); // koyu lacivert (profil sayfasıyla uyumlu)
  const FavoriteListingsPage({
    super.key,
    required this.favorites,
    this.onListingTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    // AccountShell zaten Scaffold sağlıyor. Burada Scaffold KULLANMIYORUZ.
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Başlık (header değil)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7FB),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(.12),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.star_rounded,
                          color: AppColors.accent,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Favorilerim',
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                                color: titleColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${favorites.length} ilan',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: titleColor.withOpacity(.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                if (favorites.isEmpty)
                  const _EmptyFavorites()
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // scroll AccountRightPane’de
                    itemCount: favorites.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final listing = favorites[i];

                      final onTap = onListingTap != null
                          ? () => onListingTap!(listing)
                          : () => context.go(
                                '/ilan-detay/${listing.id}',
                                extra: listing,
                              );

                      return ListingCard(
                        listing: listing,
                        onTap: onTap,
                        onFavoriteTap: onFavoriteTap == null
                            ? null
                            : () => onFavoriteTap!(listing),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star_border_rounded,
            color: AppColors.textTertiary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Henüz favori ilan eklemedin.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
