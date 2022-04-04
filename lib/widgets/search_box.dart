import 'package:flutter/material.dart';
import 'package:notes_app/model/search_query_state.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchQuery searchQuery = context.watch<SearchQuery>();
    return Card(
      elevation: 1,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => searchQuery.changeQuery(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16.0),
                hintText: "Search your notes",
              ),
            ),
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.black45,
          )
        ],
      ),
    );
  }
}
