import 'package:flutter/material.dart';
import 'package:responsi/api_data_source.dart';
import 'package:responsi/model/model_categories.dart';
import 'package:responsi/model/model_details.dart';
import 'package:responsi/model/model_meals.dart';
import 'package:responsi/detail_details.dart';


class PageListMeals extends StatefulWidget {
  const PageListMeals({super.key});

  @override
  State<PageListMeals> createState() => _PageListMeals();
}

class _PageListMeals extends State<PageListMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        title: Text(" LIST"),
      ),
      body: _buildListMealsBody(),
    );
  }

  Widget _buildListMealsBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadMeals(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              ModelMeals meals = ModelMeals.fromJson(snapshot.data);
              return _buildSuccessSection(meals);
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildSuccessSection(ModelMeals data) {
    return ListView.builder(
        itemCount: data.meals!.length,
        itemBuilder: (BuildContext context, int index) {
          return _BuildItemReports(data.meals![index]);
        });
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemReports(Meals ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageDetailDetails(details: Meals),
        ),
      ),
      child: Card(
        color: Colors.brown[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 120,
              child: Image.network(Meals.strMealThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 150,
                    child: Text(Meals.strMeal!))
              ],
            ),
          ],
        ),
      ),
    );



  }
}