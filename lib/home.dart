import 'package:flutter/material.dart';
import 'api_data_source.dart';
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
          future: ApiDataSource.instance.loadCategories(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              ModelCategories categories = ModelCategories.fromJson(snapshot.data);
              return _buildSuccessSection(categories);
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

  Widget _buildSuccessSection(ModelCategories data) {
    return ListView.builder(
        itemCount: data.categories!.length,
        itemBuilder: (BuildContext context, int index) {
          return _BuildItemUsers(data.categories![index]);
        });
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemUsers(Categories Categories) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageListMeals(),
          ),
        );
      },
      child: Card(
        color: Colors.brown[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.network(Categories.strCategoryThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(Categories.strCategory!, style: TextStyle(fontSize: 15,),)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 400,
                    child: Text(Categories.strCategoryDescription!, style: TextStyle(fontSize: 15,),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}