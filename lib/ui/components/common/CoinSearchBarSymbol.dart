import 'package:flutter/material.dart';

class SearchBarSymbol extends StatelessWidget {
  Function? searchListener;

  SearchBarSymbol({Key? key, this.searchListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 50,
      child: Card(
        color: Colors.white70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: TextFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            contentPadding: EdgeInsets.only(left: 10),
          ),
          onChanged: (text) {
            if (text.isNotEmpty) {
              searchListener?.call(text);
            }
          },
        ),
      ),
    );
  }
}
