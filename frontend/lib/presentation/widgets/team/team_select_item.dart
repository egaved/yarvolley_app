import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/logic/cubits/team_select_cubit.dart';
import 'package:yarvolley_app/presentation/dto/team_dto.dart';
import 'package:yarvolley_app/presentation/theme/images.dart';
import 'package:yarvolley_app/presentation/widgets/subscribe_button.dart';

class TeamSelectListItem extends StatelessWidget {
  final TeamDisplay team;

  const TeamSelectListItem({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamSelectCubit, TeamSelectState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is TeamSelectLoaded) {
          isFavorite = state.favoriteTeamIds.contains(team.id);
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            // color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 5,
              bottom: 5,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 50, width: 50, child: noLogoIcon),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      team.name,
                      style: const TextStyle(
                        fontFamily: 'AppCommonFont',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SubscribeButton(
                  condition: isFavorite,
                  onPressed: () {
                    context.read<TeamSelectCubit>().toggleFavorite(team.id);
                    // .then(
                    //   (_) => context.read<TeamCubit>().loadFavoriteTeams(),
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
