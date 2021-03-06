package learn.collaboreat.models;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.PositiveOrZero;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Recipe {

    private int recipeId;
    @NotBlank(message = "Recipe name is required.")
    private String recipeName;
    @NotBlank(message = "Recipe story is required.")
    private String recipeStory;
    @NotBlank(message = "Recipe description is required.")
    private String recipeDescription;
    @NotBlank(message = "Recipe ingredients are required.")
    private String recipeIngredients;
    @PositiveOrZero(message = "Recipe Cook Time must be zero or positive.")
    private int recipeCookTime;
    @NotBlank(message = "Recipe steps are required.")
    private String recipeSteps;
    private LocalDate recipeDate;
    @PositiveOrZero(message = "Recipe Rating must be zero or positive.")
    private double recipeRating;
    @PositiveOrZero(message = "User ID must be zero or positive.")
    private int userId; // foreign key
    @PositiveOrZero(message = "Meal Type ID must be zero or positive.")
    private int mealTypeId; //foreign key
    private List<RecipeHealthInfo> healthInfo = new ArrayList<>();

    private String imageUrl;

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public List<RecipeHealthInfo> getHealthInfo() {
        return healthInfo;
    }

    public void setHealthInfo(List<RecipeHealthInfo> healthInfo) {
        this.healthInfo = healthInfo;
    }

    public int getRecipeId() {
        return recipeId;
    }

    public void setRecipeId(int recipeId) {
        this.recipeId = recipeId;
    }

    public String getRecipeName() {
        return recipeName;
    }

    public void setRecipeName(String recipeName) {
        this.recipeName = recipeName;
    }

    public String getRecipeStory() {
        return recipeStory;
    }

    public void setRecipeStory(String recipeStory) {
        this.recipeStory = recipeStory;
    }

    public String getRecipeDescription() {
        return recipeDescription;
    }

    public void setRecipeDescription(String recipeDescription) {
        this.recipeDescription = recipeDescription;
    }

    public String getRecipeIngredients() {
        return recipeIngredients;
    }

    public void setRecipeIngredients(String recipeIngredients) {
        this.recipeIngredients = recipeIngredients;
    }

    public int getRecipeCookTime() {
        return recipeCookTime;
    }

    public void setRecipeCookTime(int recipeCookTime) {
        this.recipeCookTime = recipeCookTime;
    }

    public String getRecipeSteps() {
        return recipeSteps;
    }

    public void setRecipeSteps(String recipeSteps) {
        this.recipeSteps = recipeSteps;
    }

    public LocalDate getRecipeDate() {
        return recipeDate;
    }

    public void setRecipeDate(LocalDate recipeDate) {
        this.recipeDate = recipeDate;
    }

    public double getRecipeRating() {
        return recipeRating;
    }

    public void setRecipeRating(double recipeRating) {
        this.recipeRating = recipeRating;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMealTypeId() {
        return mealTypeId;
    }

    public void setMealTypeId(int mealTypeId) {
        this.mealTypeId = mealTypeId;
    }




}
