import 'dart:math';

import 'package:ars_corpia/constants/functions.dart';
import 'package:ars_corpia/objects/about.dart';
import 'package:ars_corpia/objects/cart_item.dart';
import 'package:ars_corpia/objects/marker.dart';
import 'package:ars_corpia/objects/review.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static late Database _database;

  // 'id' : id,
  // 'name' : marker.name,
  // 'description':marker.description,
  // 'images':getString(marker.images),
  // 'price':marker.price,
  // 'link':marker.link,
  // 'quantity': quantity,
  // 'total' : total
  
  static Future openDb() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), "orderHistory.ddb"),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE history(id INTEGER PRIMARY KEY autoincrement, "
                  "name TEXT,description TEXT,images TEXT, price TEXT, link TEXT,quantity INTEGER,total TEXT )"
          );
        }
    );
    return _database;
  }//end open DB

  static Future insertItem(CartItem history) async{
    await openDb();
    try {
      return await _database.insert('history', history.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }catch (error) {
      throw Exception(error.toString());
    }//end try-catch
  }//end insert item

  static Future<List<CartItem>> getItems() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('history');

    return List.generate(maps.length, (index){
      return CartItem(
          id: maps[index]['id'], 
          marker: Marker(
              name: maps[index]['name'], description: maps[index]['description'], 
              images: getImages(maps[index]['images']) , 
              price:maps[index]['price'] , link: maps[index]['link'], asin: maps[index]['asin']),
          quantity: maps[index]['quantity'], 
          total: maps[index]['total'],
      );
    }).toList();
  }//end get items

  static Future fakePersistenceMarkers() async {
    return Future(() => {
      [
        Marker(name: 'Ohuhu 40 Color Alcohol Markers, Dual Nibs Art Marker Pens for Adults Coloring, Highlighter Sketch Markers for Drawing, Alcohol-Based Markers, 1 Colorless Blender, Permanent Markers Kids Pen Gift',
            description: '\nBrand	Ohuhu\nInk colour	Black\nSurface recommendation	Cardboard\nNumber of pieces	40\nStyle	Unique,Fine'
                'About this item /nDOUBLE TIPPED MARKERS: Broad and fine twin tips for precise highlighting and underlining, for drawing with both thin and thick lines. Allows you to create various styles, sketches and patterns with ease/n40 VIBRANT UNIQUE COLORS + 1 COLORLESS BLENDER: The highly pigmented and vibrant markers are built to last against fading, and blend beautifully for added dimension to your artwork/nFAST DRYING MARKERS: Easily layer and mix different colors without worrying about smudges and blotches/nHIGH QUALITY ART MARKER SET: Marker pens are highly pigmented, allowing you to color in at least 984ft. worth of drawings/nCOLOR-CODED CAPS, BONUS CASE, GREAT MOTHERS\' DAY GIFT IDEA: The color-coded caps allow for ease in organization and use in identifying colors; And also, these marker pen set is equipped with a beautiful black carrying case for ease in travelling and storing',
            images:[
              'https://m.media-amazon.com/images/I/713R6rn1I9L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61WfHAYodNL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71HCkXmH4gL._AC_SX355_.jpg',
              'https://m.media-amazon.com/images/I/81rvhp0NCaL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71+UFN5yn2L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/81P40tgbqHL._AC_SY355_.jpg'

            ],
            price: 29.99,
            link: 'https://amzn.to/3C1PYr4', asin: 'B07DL5BR39') ,
        Marker(name: 'Ohuhu Markers Water-Based Double Tipped 60 Colors Art Markers for Kids Adults Coloring Calligraphy Drawing Sketching Bullet Journal, 59 Unique Colors + 1 Colorless Blender, Chisel & Brush Dual Tips',
            description: '\nBrand	Ohuhu\nRecommended uses for product	Drawing\nSurface recommendation	Plastic\nNumber of pieces	60\nStyle	Unique,Elegant\n\n\n'
                'About this item\nBRUSH & CHISEL, DOUBLE-TIP, DOUBLE THE FUN: Not only can you blend colors together, but you have greater control over the line widths thanks to the dual tips. Get elegant arcs, wavy lines and calligraphic effects with the brush tip, then fill in large sections with the broad tip.\nWATER-BASED, NON-TOXIC & ORDORLESS INK: Your health first! The non-toxic, water-based and odorless ink are safe to use and the quick-drying ink doesn’t bleed through the paper.\n59 VIBRANT COLORS + 1 COLORLESS BLENDER: Take your art beyond the ordinary with the Ohuhu 60-color water-based double-tip marker set, which includes 59 color markers and 1 colorless blender and a storage bucket that allows you to fuse colors together in a whole new way. Get highly expressive, watercolor-esque effects for your landscapes, manga, rawings, sketching, calligraphy, coloring, crafting, highlighting, journaling, doodling, lettering, card making, shading or any style you choose!\nCOLOR-CODED CAPS & COLOR SWATCH INCLUDED: Stay organized and keep your creative flow going thanks to each cap being marked with its color and corresponding number color. Before drawing, you also can paint your own color swatch for reference. Stay organized while you work and keep your hand from cramping up by using the round pen holder.\nBONUS CASE, GREAT GIFT IDEA: Know someone that makes art or DIY crafts? This is an excellent gift choice for those creatives in your life. And also, these marker pen set is equipped with a beautiful plastic case for ease in travelling and storing. (Note: When drawing with the colorless blender, use heavy-weight watercolor paper to avoid scratching, peeling of the paper, ripped paper, warped paper, and unwanted color variation)',
            images: [
              'https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71KTY7lOPiL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61qreGqUIlL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71Q6nkXmP+L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71aN8NCBXfL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71TeONndaHL._AC_SX355_.jpg'
            ],
            price: 34.99,
            link: 'https://amzn.to/3jqWelF', asin: 'B092Z2BLD2')
      ]
    });
  }

  static Future fakePersistenceReviews() async {
    return Future(() => {[
      Review(
          youtube: 'https://youtu.be/FpOjRVkyCAM', markers: [
            // THESE ARE NOT THE MARKERS IN THE VIDEO
        Marker(name: 'Ohuhu 40 Color Alcohol Markers, Dual Nibs Art Marker Pens for Adults Coloring, Highlighter Sketch Markers for Drawing, Alcohol-Based Markers, 1 Colorless Blender, Permanent Markers Kids Pen Gift',
            description: '\nBrand	Ohuhu\nInk colour	Black\nSurface recommendation	Cardboard\nNumber of pieces	40\nStyle	Unique,Fine'
                'About this item /nDOUBLE TIPPED MARKERS: Broad and fine twin tips for precise highlighting and underlining, for drawing with both thin and thick lines. Allows you to create various styles, sketches and patterns with ease/n40 VIBRANT UNIQUE COLORS + 1 COLORLESS BLENDER: The highly pigmented and vibrant markers are built to last against fading, and blend beautifully for added dimension to your artwork/nFAST DRYING MARKERS: Easily layer and mix different colors without worrying about smudges and blotches/nHIGH QUALITY ART MARKER SET: Marker pens are highly pigmented, allowing you to color in at least 984ft. worth of drawings/nCOLOR-CODED CAPS, BONUS CASE, GREAT MOTHERS\' DAY GIFT IDEA: The color-coded caps allow for ease in organization and use in identifying colors; And also, these marker pen set is equipped with a beautiful black carrying case for ease in travelling and storing',
            images:[
              'https://m.media-amazon.com/images/I/713R6rn1I9L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61WfHAYodNL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71HCkXmH4gL._AC_SX355_.jpg',
              'https://m.media-amazon.com/images/I/81rvhp0NCaL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71+UFN5yn2L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/81P40tgbqHL._AC_SY355_.jpg'

            ],
            price: 29.99,
            link: 'https://amzn.to/3C1PYr4', asin: 'B07DL5BR39') ,
        Marker(name: 'Ohuhu Markers Water-Based Double Tipped 60 Colors Art Markers for Kids Adults Coloring Calligraphy Drawing Sketching Bullet Journal, 59 Unique Colors + 1 Colorless Blender, Chisel & Brush Dual Tips',
            description: '\nBrand	Ohuhu\nRecommended uses for product	Drawing\nSurface recommendation	Plastic\nNumber of pieces	60\nStyle	Unique,Elegant\n\n\n'
                'About this item\nBRUSH & CHISEL, DOUBLE-TIP, DOUBLE THE FUN: Not only can you blend colors together, but you have greater control over the line widths thanks to the dual tips. Get elegant arcs, wavy lines and calligraphic effects with the brush tip, then fill in large sections with the broad tip.\nWATER-BASED, NON-TOXIC & ORDORLESS INK: Your health first! The non-toxic, water-based and odorless ink are safe to use and the quick-drying ink doesn’t bleed through the paper.\n59 VIBRANT COLORS + 1 COLORLESS BLENDER: Take your art beyond the ordinary with the Ohuhu 60-color water-based double-tip marker set, which includes 59 color markers and 1 colorless blender and a storage bucket that allows you to fuse colors together in a whole new way. Get highly expressive, watercolor-esque effects for your landscapes, manga, rawings, sketching, calligraphy, coloring, crafting, highlighting, journaling, doodling, lettering, card making, shading or any style you choose!\nCOLOR-CODED CAPS & COLOR SWATCH INCLUDED: Stay organized and keep your creative flow going thanks to each cap being marked with its color and corresponding number color. Before drawing, you also can paint your own color swatch for reference. Stay organized while you work and keep your hand from cramping up by using the round pen holder.\nBONUS CASE, GREAT GIFT IDEA: Know someone that makes art or DIY crafts? This is an excellent gift choice for those creatives in your life. And also, these marker pen set is equipped with a beautiful plastic case for ease in travelling and storing. (Note: When drawing with the colorless blender, use heavy-weight watercolor paper to avoid scratching, peeling of the paper, ripped paper, warped paper, and unwanted color variation)',
            images: [
              'https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71KTY7lOPiL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61qreGqUIlL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71Q6nkXmP+L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71aN8NCBXfL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71TeONndaHL._AC_SX355_.jpg'
            ],
            price: 34.99,
            link: 'https://amzn.to/3jqWelF', asin: 'B092Z2BLD2')
      ],
          name: '\$120 vs \$750 MARKER ART | Which is WORTH IT..? | BOWSER',
          description: 'Comparison between two markers by ACDC art attack taken from youtube',
          image: '', sponsorNames: ['G-Fuel'], sponsorCodes: ['https://gfuel.ly/3NtxD9Q']),
      Review(
          youtube: 'https://youtu.be/FpOjRVkyCAM', markers: [
        // THESE ARE NOT THE MARKERS IN THE VIDEO
        Marker(name: 'Ohuhu 40 Color Alcohol Markers, Dual Nibs Art Marker Pens for Adults Coloring, Highlighter Sketch Markers for Drawing, Alcohol-Based Markers, 1 Colorless Blender, Permanent Markers Kids Pen Gift',
            description: '\nBrand	Ohuhu\nInk colour	Black\nSurface recommendation	Cardboard\nNumber of pieces	40\nStyle	Unique,Fine'
                'About this item /nDOUBLE TIPPED MARKERS: Broad and fine twin tips for precise highlighting and underlining, for drawing with both thin and thick lines. Allows you to create various styles, sketches and patterns with ease/n40 VIBRANT UNIQUE COLORS + 1 COLORLESS BLENDER: The highly pigmented and vibrant markers are built to last against fading, and blend beautifully for added dimension to your artwork/nFAST DRYING MARKERS: Easily layer and mix different colors without worrying about smudges and blotches/nHIGH QUALITY ART MARKER SET: Marker pens are highly pigmented, allowing you to color in at least 984ft. worth of drawings/nCOLOR-CODED CAPS, BONUS CASE, GREAT MOTHERS\' DAY GIFT IDEA: The color-coded caps allow for ease in organization and use in identifying colors; And also, these marker pen set is equipped with a beautiful black carrying case for ease in travelling and storing',
            images:[
              'https://m.media-amazon.com/images/I/713R6rn1I9L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61WfHAYodNL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71HCkXmH4gL._AC_SX355_.jpg',
              'https://m.media-amazon.com/images/I/81rvhp0NCaL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71+UFN5yn2L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/81P40tgbqHL._AC_SY355_.jpg'

            ],
            price: 29.99,
            link: 'https://amzn.to/3C1PYr4', asin: 'B07DL5BR39') ,
        Marker(name: 'Ohuhu Markers Water-Based Double Tipped 60 Colors Art Markers for Kids Adults Coloring Calligraphy Drawing Sketching Bullet Journal, 59 Unique Colors + 1 Colorless Blender, Chisel & Brush Dual Tips',
            description: '\nBrand	Ohuhu\nRecommended uses for product	Drawing\nSurface recommendation	Plastic\nNumber of pieces	60\nStyle	Unique,Elegant\n\n\n'
                'About this item\nBRUSH & CHISEL, DOUBLE-TIP, DOUBLE THE FUN: Not only can you blend colors together, but you have greater control over the line widths thanks to the dual tips. Get elegant arcs, wavy lines and calligraphic effects with the brush tip, then fill in large sections with the broad tip.\nWATER-BASED, NON-TOXIC & ORDORLESS INK: Your health first! The non-toxic, water-based and odorless ink are safe to use and the quick-drying ink doesn’t bleed through the paper.\n59 VIBRANT COLORS + 1 COLORLESS BLENDER: Take your art beyond the ordinary with the Ohuhu 60-color water-based double-tip marker set, which includes 59 color markers and 1 colorless blender and a storage bucket that allows you to fuse colors together in a whole new way. Get highly expressive, watercolor-esque effects for your landscapes, manga, rawings, sketching, calligraphy, coloring, crafting, highlighting, journaling, doodling, lettering, card making, shading or any style you choose!\nCOLOR-CODED CAPS & COLOR SWATCH INCLUDED: Stay organized and keep your creative flow going thanks to each cap being marked with its color and corresponding number color. Before drawing, you also can paint your own color swatch for reference. Stay organized while you work and keep your hand from cramping up by using the round pen holder.\nBONUS CASE, GREAT GIFT IDEA: Know someone that makes art or DIY crafts? This is an excellent gift choice for those creatives in your life. And also, these marker pen set is equipped with a beautiful plastic case for ease in travelling and storing. (Note: When drawing with the colorless blender, use heavy-weight watercolor paper to avoid scratching, peeling of the paper, ripped paper, warped paper, and unwanted color variation)',
            images: [
              'https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71KTY7lOPiL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61qreGqUIlL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71Q6nkXmP+L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71aN8NCBXfL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71TeONndaHL._AC_SX355_.jpg'
            ],
            price: 34.99,
            link: 'https://amzn.to/3jqWelF', asin: 'B092Z2BLD2')
      ],
          name: '\$120 vs \$750 MARKER ART | Which is WORTH IT..? | BOWSER',
          description: 'Comparison between two markers by ACDC art attack taken from youtube',
          image: '', sponsorNames: ['G-Fuel'], sponsorCodes: ['https://gfuel.ly/3NtxD9Q']),
      Review(
          youtube: 'https://youtu.be/FpOjRVkyCAM', markers: [
        // THESE ARE NOT THE MARKERS IN THE VIDEO
        Marker(name: 'Ohuhu 40 Color Alcohol Markers, Dual Nibs Art Marker Pens for Adults Coloring, Highlighter Sketch Markers for Drawing, Alcohol-Based Markers, 1 Colorless Blender, Permanent Markers Kids Pen Gift',
            description: '\nBrand	Ohuhu\nInk colour	Black\nSurface recommendation	Cardboard\nNumber of pieces	40\nStyle	Unique,Fine'
                'About this item /nDOUBLE TIPPED MARKERS: Broad and fine twin tips for precise highlighting and underlining, for drawing with both thin and thick lines. Allows you to create various styles, sketches and patterns with ease/n40 VIBRANT UNIQUE COLORS + 1 COLORLESS BLENDER: The highly pigmented and vibrant markers are built to last against fading, and blend beautifully for added dimension to your artwork/nFAST DRYING MARKERS: Easily layer and mix different colors without worrying about smudges and blotches/nHIGH QUALITY ART MARKER SET: Marker pens are highly pigmented, allowing you to color in at least 984ft. worth of drawings/nCOLOR-CODED CAPS, BONUS CASE, GREAT MOTHERS\' DAY GIFT IDEA: The color-coded caps allow for ease in organization and use in identifying colors; And also, these marker pen set is equipped with a beautiful black carrying case for ease in travelling and storing',
            images:[
              'https://m.media-amazon.com/images/I/713R6rn1I9L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61WfHAYodNL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71HCkXmH4gL._AC_SX355_.jpg',
              'https://m.media-amazon.com/images/I/81rvhp0NCaL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71+UFN5yn2L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/81P40tgbqHL._AC_SY355_.jpg'

            ],
            price: 29.99,
            link: 'https://amzn.to/3C1PYr4', asin: 'B07DL5BR39') ,
        Marker(name: 'Ohuhu Markers Water-Based Double Tipped 60 Colors Art Markers for Kids Adults Coloring Calligraphy Drawing Sketching Bullet Journal, 59 Unique Colors + 1 Colorless Blender, Chisel & Brush Dual Tips',
            description: '\nBrand	Ohuhu\nRecommended uses for product	Drawing\nSurface recommendation	Plastic\nNumber of pieces	60\nStyle	Unique,Elegant\n\n\n'
                'About this item\nBRUSH & CHISEL, DOUBLE-TIP, DOUBLE THE FUN: Not only can you blend colors together, but you have greater control over the line widths thanks to the dual tips. Get elegant arcs, wavy lines and calligraphic effects with the brush tip, then fill in large sections with the broad tip.\nWATER-BASED, NON-TOXIC & ORDORLESS INK: Your health first! The non-toxic, water-based and odorless ink are safe to use and the quick-drying ink doesn’t bleed through the paper.\n59 VIBRANT COLORS + 1 COLORLESS BLENDER: Take your art beyond the ordinary with the Ohuhu 60-color water-based double-tip marker set, which includes 59 color markers and 1 colorless blender and a storage bucket that allows you to fuse colors together in a whole new way. Get highly expressive, watercolor-esque effects for your landscapes, manga, rawings, sketching, calligraphy, coloring, crafting, highlighting, journaling, doodling, lettering, card making, shading or any style you choose!\nCOLOR-CODED CAPS & COLOR SWATCH INCLUDED: Stay organized and keep your creative flow going thanks to each cap being marked with its color and corresponding number color. Before drawing, you also can paint your own color swatch for reference. Stay organized while you work and keep your hand from cramping up by using the round pen holder.\nBONUS CASE, GREAT GIFT IDEA: Know someone that makes art or DIY crafts? This is an excellent gift choice for those creatives in your life. And also, these marker pen set is equipped with a beautiful plastic case for ease in travelling and storing. (Note: When drawing with the colorless blender, use heavy-weight watercolor paper to avoid scratching, peeling of the paper, ripped paper, warped paper, and unwanted color variation)',
            images: [
              'https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71KTY7lOPiL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61qreGqUIlL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71Q6nkXmP+L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71aN8NCBXfL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71TeONndaHL._AC_SX355_.jpg'
            ],
            price: 34.99,
            link: 'https://amzn.to/3jqWelF', asin: 'B092Z2BLD2')
      ],
          name: '\$120 vs \$750 MARKER ART | Which is WORTH IT..? | BOWSER',
          description: 'Comparison between two markers by ACDC art attack taken from youtube',
          image: '', sponsorNames: ['G-Fuel'], sponsorCodes: ['https://gfuel.ly/3NtxD9Q']),
      Review(
          youtube: 'https://youtu.be/FpOjRVkyCAM', markers: [
        // THESE ARE NOT THE MARKERS IN THE VIDEO
        Marker(name: 'Ohuhu 40 Color Alcohol Markers, Dual Nibs Art Marker Pens for Adults Coloring, Highlighter Sketch Markers for Drawing, Alcohol-Based Markers, 1 Colorless Blender, Permanent Markers Kids Pen Gift',
            description: '\nBrand	Ohuhu\nInk colour	Black\nSurface recommendation	Cardboard\nNumber of pieces	40\nStyle	Unique,Fine'
                'About this item /nDOUBLE TIPPED MARKERS: Broad and fine twin tips for precise highlighting and underlining, for drawing with both thin and thick lines. Allows you to create various styles, sketches and patterns with ease/n40 VIBRANT UNIQUE COLORS + 1 COLORLESS BLENDER: The highly pigmented and vibrant markers are built to last against fading, and blend beautifully for added dimension to your artwork/nFAST DRYING MARKERS: Easily layer and mix different colors without worrying about smudges and blotches/nHIGH QUALITY ART MARKER SET: Marker pens are highly pigmented, allowing you to color in at least 984ft. worth of drawings/nCOLOR-CODED CAPS, BONUS CASE, GREAT MOTHERS\' DAY GIFT IDEA: The color-coded caps allow for ease in organization and use in identifying colors; And also, these marker pen set is equipped with a beautiful black carrying case for ease in travelling and storing',
            images:[
              'https://m.media-amazon.com/images/I/713R6rn1I9L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61WfHAYodNL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71HCkXmH4gL._AC_SX355_.jpg',
              'https://m.media-amazon.com/images/I/81rvhp0NCaL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71+UFN5yn2L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/81P40tgbqHL._AC_SY355_.jpg'

            ],
            price: 29.99,
            link: 'https://amzn.to/3C1PYr4', asin: 'B07DL5BR39') ,
        Marker(name: 'Ohuhu Markers Water-Based Double Tipped 60 Colors Art Markers for Kids Adults Coloring Calligraphy Drawing Sketching Bullet Journal, 59 Unique Colors + 1 Colorless Blender, Chisel & Brush Dual Tips',
            description: '\nBrand	Ohuhu\nRecommended uses for product	Drawing\nSurface recommendation	Plastic\nNumber of pieces	60\nStyle	Unique,Elegant\n\n\n'
                'About this item\nBRUSH & CHISEL, DOUBLE-TIP, DOUBLE THE FUN: Not only can you blend colors together, but you have greater control over the line widths thanks to the dual tips. Get elegant arcs, wavy lines and calligraphic effects with the brush tip, then fill in large sections with the broad tip.\nWATER-BASED, NON-TOXIC & ORDORLESS INK: Your health first! The non-toxic, water-based and odorless ink are safe to use and the quick-drying ink doesn’t bleed through the paper.\n59 VIBRANT COLORS + 1 COLORLESS BLENDER: Take your art beyond the ordinary with the Ohuhu 60-color water-based double-tip marker set, which includes 59 color markers and 1 colorless blender and a storage bucket that allows you to fuse colors together in a whole new way. Get highly expressive, watercolor-esque effects for your landscapes, manga, rawings, sketching, calligraphy, coloring, crafting, highlighting, journaling, doodling, lettering, card making, shading or any style you choose!\nCOLOR-CODED CAPS & COLOR SWATCH INCLUDED: Stay organized and keep your creative flow going thanks to each cap being marked with its color and corresponding number color. Before drawing, you also can paint your own color swatch for reference. Stay organized while you work and keep your hand from cramping up by using the round pen holder.\nBONUS CASE, GREAT GIFT IDEA: Know someone that makes art or DIY crafts? This is an excellent gift choice for those creatives in your life. And also, these marker pen set is equipped with a beautiful plastic case for ease in travelling and storing. (Note: When drawing with the colorless blender, use heavy-weight watercolor paper to avoid scratching, peeling of the paper, ripped paper, warped paper, and unwanted color variation)',
            images: [
              'https://m.media-amazon.com/images/I/71+iFy+CcuL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71KTY7lOPiL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/61qreGqUIlL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71Q6nkXmP+L._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71aN8NCBXfL._AC_SY355_.jpg',
              'https://m.media-amazon.com/images/I/71TeONndaHL._AC_SX355_.jpg'
            ],
            price: 34.99,
            link: 'https://amzn.to/3jqWelF', asin: 'B092Z2BLD2')
      ],
          name: '\$120 vs \$750 MARKER ART | Which is WORTH IT..? | BOWSER',
          description: 'Comparison between two markers by ACDC art attack taken from youtube',
          image: '', sponsorNames: ['G-Fuel'], sponsorCodes: ['https://gfuel.ly/3NtxD9Q']),
    ]});
  }

  static Future fakePersistenceAboutReviewers() async {
    return Future(() => {[
      // AC DC Art attack
      About(
          name: 'ACDC art attack.',
          description: 'Dogs - Ducks - Drawings - FUN. I just Want to have fun!\nHey Sub Scribbles and Viewers... I\'m Anthony or as you know me ADCArtAttack. I\'m here to both advance my skills and if I can help you in the best way I know, to improve our art skills together.... Always love suggestions so never stop them coming :).\nDrawing for me is a passion and I\'m extremely enthusiastic about it.\nFollow me on other social media for more art updates as well as quality photos :)\n\nFor business ONLY related - hello@adcartattack.com',
          networkImage: 'https://firebasestorage.googleapis.com/v0/b/coupons-are-us.appspot.com/o/acdc%20art%20attack.jpg?alt=media&token=429e1c48-af60-480b-be96-7ae198f318e8', website: 'https://www.sizibamthandazo.dev',
          instagram: 'https://www.instagram.com/adcartattack/', tiktok: 'https://www.tiktok.com', facebook: 'https://www.facebook.com',
          twitter: 'https://twitter.com/ADCARTATTACK', youtube: 'https://www.youtube.com/@ADCArtAttack'),
      // Mikey mega mega
      About(
          name: 'Mikey mega mega',
          description: 'Artist who makes anime how to draw tutorial videos as well as fanart! Anything art based from the sketchbook to digital, as well as digital drawing tablet reviews',
          networkImage: 'https://firebasestorage.googleapis.com/v0/b/coupons-are-us.appspot.com/o/mikey%20mega%20mega.jpg?alt=media&token=88c0c5aa-8a17-4f69-9e1f-8e7c9065ebc4',
          website: 'https://www.sizibamthandazo.dev', instagram: 'https://www.instagram.com/mikeymegamega/',
          tiktok: 'https://www.tiktok.com',
          facebook: 'https://www.facebook.com/mikeymegamega', twitter: 'https://twitter.com/mikeymegamega',
          youtube: 'https://www.youtube.com/@mikeymegamega'),
    ]});
  }
}