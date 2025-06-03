import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/presentation/widgets/match_item.dart';

class MatchesTab extends StatefulWidget {
  const MatchesTab({super.key});

  @override
  MatchesTabState createState() => MatchesTabState();
}

class MatchesTabState extends State<MatchesTab> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchCubit, MatchState>(
      builder: (context, state) {
        if (state is MatchInitial || state is MatchLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MatchLoaded) {
          return Container(
            decoration: BoxDecoration(color: const Color(0xFFDBE1FF)),
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: state.matches.length,
              itemBuilder: (context, index) {
                final match = state.matches[index];
                return MatchItem(
                  match: match,
                  firstTeamName:
                      state.teamNames[match.firstTeamId] ??
                      'Неизвестная команда',
                  secondTeamName:
                      state.teamNames[match.secondTeamId] ??
                      'Неизвестная команда',
                );
              },
            ),
          );
        } else if (state is MatchError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Неизвестное состояние'));
      },
    );
  }
}
