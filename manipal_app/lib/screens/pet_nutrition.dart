import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/components/text_field_input.dart';




class PetNutritionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 234, 234, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie.json',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Create custom pet recipes with 5 home ingredients by Chef Woofles!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Get Started'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IngredientInputScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                backgroundColor: Colors.transparent,
              ).copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0),
              ),
            ).buildGradient(),
          ],
        ),
      ),
    );
  }
}

class IngredientInputScreen extends StatefulWidget {
  @override
  _IngredientInputScreenState createState() => _IngredientInputScreenState();
}

class _IngredientInputScreenState extends State<IngredientInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _breedController = TextEditingController();
  final List<TextEditingController> _ingredientControllers =
      List.generate(5, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text(
                  'Pet Recipe Details',
                  style: TextStyle(color: Colors.black, fontSize: 35),
                ),
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.darkGreen),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        const Text(
                          "Pet Breed",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextFieldInput(
                          hintText: 'Enter your pet\'s breed',
                          textEditingController: _breedController,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(height: 24),
                        ...List.generate(
                          5,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ingredient ${index + 1}",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              TextFieldInput(
                                hintText: 'Enter ingredient ${index + 1}',
                                textEditingController: _ingredientControllers[index],
                                textInputType: TextInputType.text,
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Text('Generate Recipe'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingScreen(
                            breed: _breedController.text,
                            ingredients: _ingredientControllers
                                .map((controller) => controller.text)
                                .where((ingredient) => ingredient.isNotEmpty)
                                .toList(),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    backgroundColor: Colors.transparent,
                  ).copyWith(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ).buildGradient(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  final String breed;
  final List<String> ingredients;

  LoadingScreen({required this.breed, required this.ingredients});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeScreen(
            breed: widget.breed,
            ingredients: widget.ingredients,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/loading_animation.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  final String breed;
  final List<String> ingredients;

  RecipeScreen({required this.breed, required this.ingredients});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String recipeName = '';
  String cookingMethod = '';
  String recipeImage = '';
  String note = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  Future<void> fetchRecipe() async {
    final url = Uri.parse('https://ee12-2409-40c0-105f-b7a7-fc45-b070-b299-6bf7.ngrok-free.app/predict_pet_food');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'breed': widget.breed,
      'ingredients': widget.ingredients.join(' ')
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          recipeName = data['recipe_name'];
          cookingMethod = data['cooking_method'];
          note = data['note'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch recipe');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch recipe. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Pet Recipe')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipeName,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  if (recipeImage.isNotEmpty)
                    Image.network(recipeImage,
                        height: 200, width: double.infinity, fit: BoxFit.cover),
                  SizedBox(height: 20),
                  Text('Cooking Method:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(cookingMethod),
                  SizedBox(height: 20),
                  Text('Note:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(note),
                ],
              ),
            ),
    );
  }
}

extension GradientElevatedButton on ElevatedButton {
  Widget buildGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 156, 219, 166),
            Color.fromARGB(255, 226, 249, 205),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(19),
      ),
      child: this,
    );
  }
}
