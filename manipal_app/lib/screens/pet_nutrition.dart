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
            //SizedBox(height: 20),
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
                  MaterialPageRoute(
                      builder: (context) => IngredientInputScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                // Setting the shape of the button to be a rounded rectangle
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                backgroundColor:
                    Colors.transparent, // This ensures the gradient is visible
              ).copyWith(
                // Adding the gradient using decoration
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation:
                    MaterialStateProperty.all(0), // Optional: remove elevation
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
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        const Text(
                          "Pet Breed",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFieldInput(
                                      hintText: 'Enter ingredient ${index + 1}',
                                      textEditingController:
                                          _ingredientControllers[index],
                                      textInputType: TextInputType.text,
                                    ),
                                    SizedBox(height: 24),
                                  ],
                                )),
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
                            builder: (context) => LoadingScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    // Setting the shape of the button to be a rounded rectangle
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    backgroundColor: Colors
                        .transparent, // This ensures the gradient is visible
                  ).copyWith(
                    // Adding the gradient using decoration
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(
                        0), // Optional: remove elevation
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
        MaterialPageRoute(builder: (context) => RecipeScreen()),
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
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String recipeName = '';
  String cookingMethod = '';
  String recipeImage = '';

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  Future<void> fetchRecipe() async {
    // Replace with your actual API endpoint
    // final response =
    //     await http.get(Uri.parse('https://your-api-endpoint.com/recipe'));

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   setState(() {
    //     recipeName = data['recipe_name'];
    //     cookingMethod = data['cooking_method'];
    //     recipeImage = data['recipe_image'];
    //   });
    // } else {
    //   // Handle error
    //   print('Failed to fetch recipe');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Pet Recipe')),
      body: SingleChildScrollView(
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
            Color.fromARGB(255, 156, 219, 166), // Start color
            Color.fromARGB(255, 226, 249, 205), // End color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(19), // Rounded corners
      ),
      child: this,
    );
  }
}