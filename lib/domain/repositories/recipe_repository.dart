import 'package:kitchen_confidant/domain/entities/recipe.dart';

abstract class RecipeRepository {
  // We send the list of pantry item names to get a recipe
  Future<Recipe> getAiRecipe(List<String> ingredients);
}
