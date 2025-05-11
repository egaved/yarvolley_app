import 'package:flutter/material.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class ListAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<String> teamNames;
  final Function(int) onTeamSelected;

  const ListAppBar({
    super.key,
    required this.teamNames,
    required this.onTeamSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ListAppBarState createState() => ListAppBarState();
}

class ListAppBarState extends State<ListAppBar> {
  int _selectedTeamIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      titleSpacing: 0,
      title: SizedBox(
        height: kToolbarHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.teamNames.length,
          itemBuilder: (context, index) {
            final isSelected = index == _selectedTeamIndex;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedTeamIndex = index);
                widget.onTeamSelected(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: isSelected ? Colors.blue[700] : null,
                child: Text(
                  widget.teamNames[index],
                  style: TextStyle(
                    fontFamily: 'AppCommonFont',
                    fontSize: 20,
                    color: isSelected ? Colors.white : Colors.grey[300],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
