import 'package:ars_corpia/constants/variables.dart';
import 'package:ars_corpia/logic/database_logic.dart';
import 'package:ars_corpia/objects/about.dart';
import 'package:ars_corpia/pages/view_reviewer.dart';
import 'package:flutter/material.dart';

class AboutReviewers extends StatefulWidget {
  const AboutReviewers({Key? key}) : super(key: key);

  @override
  State<AboutReviewers> createState() => _AboutReviewersState();
}

class _AboutReviewersState extends State<AboutReviewers> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About' , style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder(builder: (context , snapshot) {
        if (snapshot.hasData) {
          Set<List<About>> set = snapshot.data;
          List<About> abouts = set.first;
          if (abouts.isEmpty) {
            return const Center(child: Text('There are currently no artists or any other influences'),);
          }else{
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context , index) {
                  return GestureDetector(
                    onTap: () {
                      // go to view reviewer
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewAboutReviewer(about: abouts[index])));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                      elevation: 8,
                      shadowColor: shadowColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image
                          Expanded(flex: 3, child: Image.network(abouts[index].networkImage)),
                          // Name
                          Expanded(child: Text(abouts[index].name , maxLines: 3, overflow: TextOverflow.ellipsis,)),
                          // short description
                          Expanded(child: Text(abouts[index].description , maxLines: 2, overflow: TextOverflow.ellipsis,))

                        ],
                      ),
                    ),
                  );
                },
              itemCount: abouts.length,
            );
          }
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
        future: DatabaseLogic.getAbouts(),),
    );
  }
}
