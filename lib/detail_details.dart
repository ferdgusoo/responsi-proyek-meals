import 'package:flutter/material.dart';
import 'package:responsi/api_data_source.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/model_details.dart';

class PageDetails extends StatefulWidget {
  final String idMeals;
  const PageDetails({super.key, required this.idMeals});

  @override
  State<PageDetails> createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        title: Text('Meal Details', style: TextStyle(color: Colors.brown.shade700),),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: ApiDataSource.instance.getDetailMeals(widget.idMeals),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR'),
              );
            }
            if (snapshot.hasData) {
              Detail detail = Detail.fromJson(snapshot.data!);
              return ListView.builder(
                itemCount: detail.meals?.length,
                itemBuilder: (BuildContext context, int index) {
                  var details = detail.meals?[index];
                  return Column(
                    children: [
                      Image.network(
                        '${details?.strMealThumb}',
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${details?.strMeal}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 22, backgroundColor: Colors.brown.shade900, color: Colors.brown.shade100
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Category: ${details?.strCategory}', style: TextStyle(fontSize: 18),),
                          Text('Area: ${details?.strArea}', style: TextStyle(fontSize: 18),)
                        ],
                      ),

                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ingredients', style: TextStyle( fontSize: 20, backgroundColor:
                          Colors.brown.shade900, color: Colors.brown.shade100),),
                          Text('${details?.strIngredient1}'),
                          Text('${details?.strIngredient2}'),
                          Text('${details?.strIngredient3}'),
                          Text('${details?.strIngredient4}'),
                          Text('${details?.strIngredient5}'),
                          Text('${details?.strIngredient6}'),
                          Text('${details?.strIngredient7}'),
                          Text('${details?.strIngredient8}'),
                          Text('${details?.strIngredient9}'),
                          Text('${details?.strIngredient10}'),
                          Text('${details?.strIngredient11}'),
                          Text('${details?.strIngredient12}'),
                          SizedBox(height: 15),
                          Text('Instructions', style: TextStyle(fontSize: 20, backgroundColor:
                          Colors.brown.shade900, color: Colors.brown.shade100),),
                          Text('${details?.strInstructions}')


                        ],

                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown[100],
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          launchURL(details?.strYoutube ?? '');
                        },
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(height: 5),
                            Icon(
                              Icons.play_arrow,
                              color: Colors.brown.shade800,
                            ),

                            Text(" Watch Tutorial", style: TextStyle(color: Colors.brown.shade800)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.brown[200]),
            );
          },
        ),
      ),
    );
  }

  Future<void> launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
    }
  }
}

