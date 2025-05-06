import 'package:flutter/material.dart';
import 'package:yarvolley_app/appearance/theme/colors.dart';
import 'package:yarvolley_app/domain/league.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

class LeagueItem extends StatefulWidget {
  final League league;
  // final VoidCallback onSubscribe;
  final PreferencesService favoriteService;
  final VoidCallback onFavoriteChanged;

  const LeagueItem({
    super.key,
    required this.league,
    required this.favoriteService,
    required this.onFavoriteChanged,
  });

  @override
  State<LeagueItem> createState() => _LeagueItemState();
}

class _LeagueItemState extends State<LeagueItem> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    _isFavorite = await widget.favoriteService.isLeagueFavorite(
      widget.league.id,
    );
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await widget.favoriteService.removeLeague(widget.league.id);
    } else {
      await widget.favoriteService.addLeague(widget.league.id);
    }
    await _checkIfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.league.name,
                style: TextStyle(
                  fontFamily: 'AppCommonFont',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _toggleFavorite();
                widget.onFavoriteChanged();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isFavorite ? secondaryColor : primaryColor, // Цвет кнопки
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.only(left: 8, right: 8),
              ),
              child: Text(
                _isFavorite ? 'Отписаться' : 'Подписаться',
                style: const TextStyle(
                  fontFamily: 'AppCommonFont',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
