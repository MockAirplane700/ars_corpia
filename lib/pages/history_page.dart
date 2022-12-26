import 'package:ars_corpia/constants/variables.dart';
import 'package:ars_corpia/logic/database_logic.dart';
import 'package:ars_corpia/objects/cart_item.dart';
import 'package:ars_corpia/objects/marker.dart';
import 'package:ars_corpia/pages/view_marker.dart';
import 'package:ars_corpia/widgets/custom_search_delegate.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History' , style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          }, icon: const Icon(Icons.search))
        ],
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder(builder: (context , snapshot) {
        if (snapshot.hasData) {
          List<CartItem> items = snapshot.data;
          if (items.isEmpty) {
            return const Center(child: Text('There are no previously checked out items'),);
          }else{
            return ListView.builder(
                itemBuilder: (context , index) {
                  List networkImages = items[index].marker.images;
                  Marker marker = items[index].marker;
                  List<String> result = [];
                  for (var value in networkImages) {
                    if (value != ''){
                      result.add(value);
                    }
                  }
                 
                  if (result.isNotEmpty){
                    marker.add(result);
                  }else{
                    marker.add(['https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg','https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg']);
                  }
                  return Card(
                    shadowColor: shadowColor,
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                    child: ListTile(
                      leading: Image.network(marker.images[0] ?? 'https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg'),
                      title: Text(items[index].marker.name , maxLines: 2,overflow: TextOverflow.ellipsis,),
                      subtitle: Text('CAD\$${items[index].total}'),
                      trailing:  Text(items[index].quantity.toString()),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMarker(marker: marker)));
                      },
                    ),
                  );
                }, itemCount: items.length,);
          }
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
        future: DatabaseLogic.getHistory(),),

    );
  }
}
