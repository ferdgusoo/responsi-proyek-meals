import 'package:flutter/material.dart';
import 'package:responsi/api_data_source.dart';
import 'package:responsi/model/model_meals.dart';
import 'package:responsi/detail_details.dart';

class PageListMeals extends StatefulWidget {
  final String ModelCategories;
  const PageListMeals({super.key, required this.ModelCategories});

  @override
  State<PageListMeals> createState() => _PageListMeals();
}

class _PageListMeals extends State<PageListMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        title: Text(widget.ModelCategories),
      ),

        body: FutureBuilder(
          future: ApiDataSource.instance.getMeals(widget.ModelCategories),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR'),
              );
            }
            if (snapshot.hasData) {
              Meal meal  = Meal.fromJson(snapshot.data!);
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: meal.meals?.length,
                  itemBuilder: (context, int index) {
                    final Meals? meals = meal.meals?[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetails(idMeals: '${meals?.idMeal}')));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.brown.shade900
                          )
                        ),
                        color: Colors.brown.shade100,
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Image.network(
                                  '${meals?.strMealThumb}',
                                  height: 140,
                                  width: 150,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                '${meals?.strMeal}',
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.deepOrange[900]),
            );
          },
        ),
    );
  }



}