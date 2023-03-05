import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/recipe_provider.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({
    super.key,
  });

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  var isLoading = false;

  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<RecipeProvider>(context).fetchRecipes().then((_) {});
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final recepies = Provider.of<RecipeProvider>(context);
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        child: ListView.builder(
            itemCount: recepies.allRecipes.length,
            itemBuilder: (context, index) {
              return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('title'),
                          Text(
                            recepies.allRecipes[index].title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Description'),
                          Text(recepies.allRecipes[index].description,
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Text('ingredients'),
                      Text(recepies.allRecipes[index].ingredients,
                          style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.pink,
                                onPrimary: Colors.white,
                                padding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text('Update'),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      )
                    ],
                  ));
            }));
  }
}
