import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/league.dart';
import 'package:yarvolley_app/logic/cubits/league_cubit.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class LeagueItem extends StatelessWidget {
  final League league;

  const LeagueItem({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeagueCubit, LeagueState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is LeagueLoaded) {
          isFavorite = state.favoriteLeagueIds.contains(league.id);
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 5,
              bottom: 5,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    league.name,
                    style: const TextStyle(
                      fontFamily: 'AppCommonFont',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<LeagueCubit>().toggleFavorite(league.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFavorite ? secondaryColor : primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                  ),
                  child: Text(
                    isFavorite ? 'Отписаться' : 'Подписаться',
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
      },
    );
  }
}
