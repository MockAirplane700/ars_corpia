import 'package:ars_corpia/constants/variables.dart';
import 'package:ars_corpia/logic/database_logic.dart';
import 'package:ars_corpia/logic/search_logic.dart';
import 'package:ars_corpia/objects/marker.dart';
import 'package:ars_corpia/pages/view_marker.dart';
import 'package:ars_corpia/widgets/custom_navigation_drawer.dart';
import 'package:ars_corpia/widgets/custom_search_delegate.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home' , style: TextStyle(color: textColor),),
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
          Set<List<Marker>> set = snapshot.data;
          List<Marker> markers = set.first;
          SearchLogic.setSearch(markers);
          // List<Marker> markers = snapshot.data;
          if (markers.isEmpty) {
            return const Center(child: Text('There are no markers present'),);
          }else{
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context , index) {
                  return GestureDetector(
                    onTap: () {
                      //go to the relevant page
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMarker(marker: markers[index])));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                      color: cardBackgroundColor,
                      elevation: 8,
                      shadowColor: shadowColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Image
                          Expanded(flex: 3, child: Image.network(markers[index].images[0])),
                          // name
                          Expanded(child: Text(markers[index].name , maxLines: 2,)),
                          // price
                          Expanded(child: Row(
                            children: [
                              Text('CAD\$${markers[index].price.toString()}' , style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              itemCount: markers.length,
            );
          }//end if else
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }//end if-else
      }, future: DatabaseLogic.getMarkers(),),
      drawer: const CustomDrawer(),
    );
  }
}
