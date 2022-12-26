import 'package:ars_corpia/constants/functions.dart';
import 'package:ars_corpia/constants/variables.dart';
import 'package:ars_corpia/objects/about.dart';
import 'package:ars_corpia/widgets/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewAboutReviewer extends StatefulWidget {
  final About about;
  const ViewAboutReviewer({Key? key , required this.about}) : super(key: key);

  @override
  State<ViewAboutReviewer> createState() => _ViewAboutReviewerState();
}

class _ViewAboutReviewerState extends State<ViewAboutReviewer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About' , style: TextStyle(color: textColor),),
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
            // Image
            Image.network(widget.about.networkImage),
            // name <==> share button
            Row(
              children: [
                Expanded(child: Text(widget.about.name)),
                Expanded(child: IconButton(onPressed: () {}, icon: const Icon(Icons.share),))
              ],
            ),
            // description
            Card(
              shadowColor: shadowColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
              elevation: 8,
              child: Text(widget.about.description),
            ),
            // social networks and website
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // instagram
                Expanded(child: IconButton(onPressed: () {
                  launchWebSiteUrl(widget.about.instagram);
                }, icon: const FaIcon(FontAwesomeIcons.instagram))),
                // facebook
                Expanded(child: IconButton(onPressed: () {
                  launchWebSiteUrl(widget.about.facebook);
                }, icon: const FaIcon(FontAwesomeIcons.facebook))),
                // twitter
                Expanded(child: IconButton(onPressed: () {
                  launchWebSiteUrl(widget.about.twitter);
                }, icon: const FaIcon(FontAwesomeIcons.twitter))),
                // youtube
                Expanded(child: IconButton(onPressed: () {
                  launchWebSiteUrl(widget.about.youtube);
                }, icon: const FaIcon(FontAwesomeIcons.youtube))),
                // tiktok
                Expanded(child: IconButton(onPressed: () {
                  launchWebSiteUrl(widget.about.tiktok);
                }, icon: const FaIcon(FontAwesomeIcons.tiktok))),
                // website
                Expanded(child: IconButton(onPressed: () {
                  launchWebSiteUrl(widget.about.website);
                }, icon: const FaIcon(FontAwesomeIcons.globe))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
