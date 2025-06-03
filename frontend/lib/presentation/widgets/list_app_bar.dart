import 'package:flutter/material.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class ListAppBar<T> extends StatefulWidget implements PreferredSizeWidget {
  final List<T> items;
  final String Function(T) nameGetter;
  final Function(T) onSelected;
  final Widget Function() selectScreenBuilder;
  final VoidCallback? onSelectScreenPopped;

  const ListAppBar({
    super.key,
    required this.items,
    required this.nameGetter,
    required this.onSelected,
    required this.selectScreenBuilder,
    this.onSelectScreenPopped,
  });

  @override
  State<ListAppBar<T>> createState() => ListAppBarState<T>();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ListAppBarState<T> extends State<ListAppBar<T>> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      titleSpacing: 0,
      title: SizedBox(
        height: kToolbarHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = index);
                widget.onSelected(item);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.nameGetter(item),
                  style: TextStyle(
                    fontFamily: 'AppCommonFont',
                    fontSize: 20,
                    color:
                        isSelected
                            ? Colors.white
                            : const Color.fromARGB(255, 109, 109, 109),
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.selectScreenBuilder(),
              ),
            ).then((_) {
              if (widget.onSelectScreenPopped != null) {
                widget.onSelectScreenPopped!();
              }
            });
          },
        ),
      ],
    );
  }
}
