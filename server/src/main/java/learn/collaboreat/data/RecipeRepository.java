package learn.collaboreat.data;

import learn.collaboreat.models.Recipe;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface RecipeRepository {

    List<Recipe> findAll();

    Recipe findById(int recipeId);

    List<Recipe> findByDate();

    Recipe add(Recipe recipe);

    boolean update(Recipe recipe);

    @Transactional
    boolean deleteById(int recipeId);
}
