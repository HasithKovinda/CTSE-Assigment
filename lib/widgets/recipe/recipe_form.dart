import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecipeForm extends StatefulWidget {
  final void Function(
    String title,
    String description,
    String ingredients,
  ) recipeBtn;
  const RecipeForm({super.key, required this.recipeBtn});

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _ingredients = '';
  void recipeSubmit() {
    final _isValid = _formKey.currentState!.validate();

    if (_isValid) {
      _formKey.currentState!.save();
      //close the keyboard by after submit the from
      FocusScope.of(context).unfocus();
      widget.recipeBtn(_title, _description, _ingredients);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                    key: const ValueKey('Recipe title'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Recipe title contain at least 4 characters';
                      } else {
                        return null;
                      }
                    },
                    decoration:
                        const InputDecoration(label: Text('Recipe title')),
                    onSaved: (newValue) => _title = newValue as String),
                TextFormField(
                  key: const ValueKey('recipe description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description for a recipe';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(label: Text('Recipe Description')),
                  onSaved: (newValue) => _description = newValue as String,
                ),
                TextFormField(
                  key: const ValueKey('recipe ingredients'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a ingredients for a recipe';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(label: Text('Recipe Ingredients')),
                  onSaved: (newValue) => _description = newValue as String,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: recipeSubmit,
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text('Create New Recipe'),
                ),
              ],
            )),
      )),
    ));
  }
}
