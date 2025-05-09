import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/data/domain/match.dart';
import 'package:yarvolley_app/presentation/theme/images.dart';

class MatchItem extends StatelessWidget {
  final Match match;
  final String firstTeamName;
  final String secondTeamName;

  const MatchItem({
    super.key,
    required this.match,
    required this.firstTeamName,
    required this.secondTeamName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchCubit, MatchState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(62, 0, 0, 0),
                offset: const Offset(0, 4),
                blurRadius: 4.0,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Команда 1
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      noLogoIcon,
                      const SizedBox(height: 4),
                      Text(
                        firstTeamName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                // Счёт
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${match.firstTeamScore ?? " - "} : ${match.secondTeamScore ?? " - "}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${match.date.day}.${match.date.month}.${match.date.year} ${match.date.hour}:${match.date.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Команда 2
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      noLogoIcon,
                      const SizedBox(height: 4),
                      Text(
                        secondTeamName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
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
