import 'package:ars_corpia/constants/functions.dart';
import 'package:ars_corpia/constants/variables.dart';
import 'package:ars_corpia/logic/cart_items_bloc.dart';
import 'package:ars_corpia/objects/marker.dart';
import 'package:ars_corpia/widgets/custom_search_delegate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ViewMarker extends StatefulWidget {
  final Marker marker;

  const ViewMarker({Key? key , required this.marker}) : super(key: key);

  @override
  State<ViewMarker> createState() => _ViewMarkerState();
}

class _ViewMarkerState extends State<ViewMarker> {
  int quantity = 1;

  void _increment () {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 1 ) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    List<Widget> widgets = [];
    for (var value in widget.marker.images) {
      widgets.add(
        Image.network(value)
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Marker' , style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          }, icon: const Icon(Icons.search))
        ],
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // name of product
            Text(widget.marker.name),
            // image slider
            CarouselSlider(
                items: widgets,
                options: CarouselOptions(
                  autoPlay: true
                )
            ),
            // price <==> share
            Row(
              children: [
                Expanded(child: Text('CAD\$${widget.marker.price.toStringAsFixed(2)}')),
                Expanded(child: IconButton(onPressed: (){
                  Share.share(widget.marker.link);
                }, icon: const Icon(Icons.share)))
              ],
            ),
            // description
            Card(
              shadowColor: shadowColor,
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
              child: Padding(padding: EdgeInsets.all(height/80) , child: Text(widget.marker.description),),
            ),
            // quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: _increment, icon: const Icon(Icons.add)),
                Text(quantity.toString()),
                IconButton(onPressed: _decrement, icon: const Icon(Icons.remove)),
              ],
            ),
            // add to cart
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){
                  //add to cart
    //       'id' : id,
    //       'name' : marker.name,
    //       'description':marker.description,
    //       'images':getString(marker.images),
    //     'price':marker.price,
    //     'link':marker.link,
    //     'quantity': quantity,
    //     'total' : total
    // };
                  double total = widget.marker.price * quantity;
                  bloc.addToCart({
                    'name' : widget.marker.name,
                    'description' : widget.marker.description,
                    'asin' : widget.marker.asin,
                    'link' : widget.marker.link,
                    'price' : widget.marker.price,
                    'images' : getString(widget.marker.images),
                    'total' : total,
                    'quantity' : quantity
                  }, context);
                }, child: const Text('Add to cart')))
              ],
            )
          ],
        ),
      ),
    );
  }
}
