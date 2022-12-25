import 'package:ars_corpia/logic/search_logic.dart';
import 'package:ars_corpia/pages/view_marker.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate{
  int indexValue = 0;
  final List _list = SearchLogic.getMarkers();

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear)
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) =>IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
  );

  @override
  Widget buildResults(BuildContext context) => _list.isNotEmpty ? ListTile(
    leading: Image.network(_list[indexValue].networkImage),
    title: Text(_list[indexValue].name, maxLines: 2,overflow: TextOverflow.ellipsis,),
    subtitle: Text(_list[indexValue].price.toString()),
    onTap: () {
      //go the view coupon page
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMarker(marker: _list[indexValue])));
    },
  ) : ListTile(title: Center(child: Text('Could not find $query')),) ;

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = _list.where((item) {
      final itemNameComparison = item.name.toLowerCase();
      final input = query.toLowerCase();
      return itemNameComparison.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        if (suggestions.isEmpty){
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Data not currently available please wait')
            ],
          ),);
        }else{
          return ListTile(
            leading: Image.network(suggestions[index].images[0]),
            title: Text(suggestions[index].name , maxLines: 2,overflow: TextOverflow.ellipsis,),
            subtitle: Text(suggestions[index].price.toString()),
            onTap: () {
              query = suggestions[index].name;
              showResults(context);
            },
          );
        }
      },
      itemCount: suggestions.length,
    );
  }

}