import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'list_meals.dart';
import 'list_meals.dart';
import 'model/model_categories.dart';

class PageListCategories extends StatefulWidget {
  const PageListCategories({super.key});

  @override
  State<PageListCategories> createState() => _PageListCategories();
}

class _PageListCategories extends State<PageListCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        title: Text("MEALS CATEGORIES"),
      ),
      body: _buildListCategoriesBody(),
    );
  }

  Widget _buildListCategoriesBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.getCategories(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              ModelCategories category = ModelCategories.fromJson(snapshot.data!);
              return ListView.builder(
                  itemCount: category.categories?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var categories = category.categories?[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PageListMeals(ModelCategories: '${categories?.strCategory}'),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.brown.shade900
                              )
                          ),
                          color: Colors.brown.shade100,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                Image.network(
                                  '${categories?.strCategoryThumb}',
                                  height: 150,
                                  width: 150,
                                ),
                                Text(
                                  '${categories?.strCategory}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(
                                    '${categories?.strCategoryDescription}', style: TextStyle(backgroundColor:
                                  Colors.brown.shade900, color: Colors.brown.shade100),
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              );
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


  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}