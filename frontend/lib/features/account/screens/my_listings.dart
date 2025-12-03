// features/account/screens/my_listings.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '/core/models/listing_model.dart';
import '/core/theme/colors.dart';
import '/core/services/auth_service.dart';
import '/core/services/listing_service.dart';
import '/shared/widgets/listing_card.dart';

/// Gerçek backend'den kullanıcının ilanlarını çeken screen
class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  final ListingService _listingService = ListingService();
  final AuthService _authService = AuthService();

  bool _isLoading = true;
  String? _errorMessage;
  List<Listing> _myListings = [];

  @override
  void initState() {
    super.initState();
    _loadMyListings();
  }

  Future<void> _loadMyListings() async {
    final user = _authService.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'İlanlarınızı görmek için lütfen giriş yapın.';
      });
      return;
    }

    try {
      final listings = await _listingService.getUserListings(user.kullaniciId);
      setState(() {
        _myListings = listings;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'İlanlar yüklenirken bir hata oluştu.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
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

    return MyListingsPage(
      myListings: _myListings,
      onEditTap: (listing) => context.push('/ilan-ver', extra: listing),
    );
  }
}

class MyListingsPage extends StatelessWidget {
  final List<Listing> myListings;

  final ValueChanged<Listing>? onListingTap;
  final ValueChanged<Listing>? onFavoriteTap;
  final ValueChanged<Listing>? onEditTap;

  const MyListingsPage({
    super.key,
    this.myListings = const [],
    this.onListingTap,
    this.onFavoriteTap,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    // Light background üzerinde okunaklı tonlar (AppColors'ın beyaza yakın olduğu durumlar için)
    const titleColor = Color(0xFF0F172A); // slate-900
    const mutedColor = Color(0xFF475569); // slate-600
    const faintColor = Color(0xFF94A3B8); // slate-400

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
                // Sayfa başlığı (header değil)
                Row(
                  children: [
                    Icon(Icons.list_alt_rounded, color: AppColors.accent, size: 26),
                    const SizedBox(width: 10),
                    Text(
                      'İlanlarım',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: titleColor, // ✅ koyu renk
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(height: 1, color: AppColors.border.withOpacity(0.6)),
                const SizedBox(height: 16),

                if (myListings.isEmpty)
                  _EmptyMyListings(
                    titleColor: titleColor,
                    mutedColor: mutedColor,
                    faintColor: faintColor,
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // scroll AccountRightPane’de
                    itemCount: myListings.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final listing = myListings[i];

                      final onTap = onListingTap != null
                          ? () => onListingTap!(listing)
                          : () => context.go(
                                '/ilan-detay/${listing.id}',
                                extra: listing,
                              );

                      // ✅ Default edit davranışı:
                      // - backend gelmeden extra ile Listing taşıyoruz
                      // - backend gelince aynı akışta listing.id kullanılır
                      final onEdit = onEditTap != null
                          ? () => onEditTap!(listing)
                          : () => context.push('/ilan-ver', extra: listing);

                      return _ListingRowWithEdit(
                        listing: listing,
                        onTap: onTap,
                        onFavoriteTap: onFavoriteTap == null ? null : () => onFavoriteTap!(listing),
                        onEditTap: onEdit,
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

class _ListingRowWithEdit extends StatelessWidget {
  final Listing listing;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onEditTap;

  const _ListingRowWithEdit({
    required this.listing,
    this.onTap,
    this.onFavoriteTap,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 980;

        final editButton = _EditButton(
          onTap: onEditTap ?? () {},
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListingCard(
                  listing: listing,
                  onTap: onTap,
                  onFavoriteTap: onFavoriteTap,
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: editButton,
              ),
            ],
          );
        }

        // Dar ekranda: buton altta
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListingCard(
              listing: listing,
              onTap: onTap,
              onFavoriteTap: onFavoriteTap,
            ),
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: editButton),
          ],
        );
      },
    );
  }
}

class _EditButton extends StatelessWidget {
  final VoidCallback onTap;
  const _EditButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Icon(Icons.edit_rounded, size: 20, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _EmptyMyListings extends StatelessWidget {
  final Color titleColor;
  final Color mutedColor;
  final Color faintColor;

  const _EmptyMyListings({
    required this.titleColor,
    required this.mutedColor,
    required this.faintColor,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: h * 0.55),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.post_add_rounded, size: 54, color: faintColor),
            const SizedBox(height: 14),
            Text(
              'Henüz hiç ilanınız yok.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: titleColor, // ✅ koyu
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hemen ilan verin ve yayınlayın.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: mutedColor, // ✅ koyu gri
              ),
            ),
          ],
        ),
      ),
    );
  }
}
