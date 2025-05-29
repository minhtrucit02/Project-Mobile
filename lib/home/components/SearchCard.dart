import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget{
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Looking for shoes',
          border: InputBorder.none,
        ),
        // onSubmitted:() {},
        // _onSearchSubmitted,
      ),
    );
  }

}