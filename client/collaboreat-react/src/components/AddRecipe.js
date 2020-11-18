import React, { useState, useEffect, useContext } from 'react';
import {useParams, useHistory, Link} from 'react-router-dom';
import { Multiselect } from 'multiselect-react-dropdown';

import AuthContext from './AuthContext';
import Errors from './Errors';

export default function AddRecipe() {
  const [recipeName, setRecipeName] = useState('');
  const [recipeDescription, setRecipeDescription] = useState('');
  const [recipeStory, setRecipeStory] = useState('');
  const [recipeCookTime, setRecipeCookTime] = useState('');
  const [mealTypeId, setMealTypeId] = useState(1);
  const [recipeIngredients, setRecipeIngredients] = useState('');
  const [recipeSteps, setRecipeSteps] = useState('');
  const [imageUrl, setImageUrl] = useState('');
  const [errors, setErrors] = useState([]);

  const [recipeHealthInfo, setRecipeHealthInfo] = useState([]);
  const [selected, setSelected] = useState([]);

  const recipeId = 0;
  const recipeRating = 0;
  const recipeDate = 0;
  const auth = useContext(AuthContext);
  const history = useHistory();

  const options=[
    {name: 'Gluten Free', id: 1},
    {name: 'Sugar Free', id: 2},
    {name: 'Vegetarian', id: 3},
    {name: 'Vegan', id: 4}
  ];
  const handleAddSubmit = (event) => {
    event.preventDefault();

    fetch('http://localhost:8080/recipe/add', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        recipeId,
        recipeName,
        recipeStory,
        recipeDescription,
        recipeIngredients,
        recipeCookTime,
        recipeSteps,
        recipeDate,
        recipeRating,
        userId: auth.appUser.userId,
        mealTypeId,
        imageUrl
      })
    })
    .then (response => {
      if (response.status === 201) {
        console.log('Success!');
        response.json().then(data => {
          console.log(data);
          console.log(selected);
        var i;
        const selectedHealthInfo = selected.selected;
        for( i = 0; i < selectedHealthInfo.length; i++ ){
          console.log(selectedHealthInfo[i]);
          fetch('http://localhost:8080/recipe/healthInfo', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              recipeId: data.recipeId,
              healthInfo: {healthInfoId: selectedHealthInfo[i].id,
                          healthInfoName: selectedHealthInfo[i].name}
            })
          })
          .then(response => {
            if (response.status === 400) {
              response.json().then(data => {
                setErrors([data]);
              })
            }
          }) 
        }
        history.push(`/`);
        });
    } else if (response.status === 400) {
        console.log('Errors!');
        response.json().then(data => {
        setErrors([data]);
        });
    } else {
        console.log('Oops... not sure what happened here :(');
        setErrors(['Oops... not sure what happened here :(']);
    }
    })
  }

  const addHealthInfoBridge = (healthInfoObj) => {
    healthInfoObj.preventDefault();
    fetch('http://localhost:8080/recipe/healthInfo', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        recipeId,
        healthInfoObj
      })
    });
  }

  
  return (
    <>
      <h2>Add a Recipe</h2>
      <Errors errors={errors} />
      <form onSubmit={handleAddSubmit}>
      <div>
        <label htmlFor="recipeName">Recipe Name:  </label>
        <input id="recipeName" value={recipeName} 
          onChange={(event) => setRecipeName(event.target.value)} type="text" placeholder="Name that Recipe!" />
      </div>
      <div>
        <label htmlFor="recipeDescription">Recipe Description:  </label>
        <input id="recipeDescription" value={recipeDescription} 
          onChange={(event) => setRecipeDescription(event.target.value)} type="text" placeholder="Describe that recipe!" />
      </div>
      <div>
        <label htmlFor="recipeStory">Recipe Story:  </label>
        <input id="recipeStory" value={recipeStory} 
          onChange={(event) => setRecipeStory(event.target.value)} type="text" placeholder="Tell other collaborEaters about this recipe" />
      </div>
      <div>
        <label htmlFor="recipeCookTime">Cook Time:  </label>
        <input id="recipeCookTime" value={recipeCookTime} 
          onChange={(event) => setRecipeCookTime(event.target.value)} type="text" placeholder="How long does it take it make?" />
      </div>
      <div>
        <label htmlFor="recipeIngredients">Recipe Ingredients:  </label>
        <textarea id="recipeIngredients" value={recipeIngredients} 
          onChange={(event) => setRecipeIngredients(event.target.value)} type="text" placeholder="List your ingredients with a new line for each" />
      </div>
      <div>
        <label htmlFor="recipeSteps">Recipe Steps:  </label>
        <textarea id="recipeSteps" value={recipeSteps} 
          onChange={(event) => setRecipeSteps(event.target.value)} type="text" placeholder="List your steps with a new line for each" />
      </div>
      <div>
        <label htmlFor="imageUrl">Link to Image:  </label>
        <textarea id="imageUrl" value={imageUrl} 
          onChange={(event) => setImageUrl(event.target.value)} type="text" placeholder="Add a link to a picture for your recipe" />
      </div>
      <div>
        <label htmlFor="mealType">Select a Meal Type:  </label>
        <select id="mealType" value={mealTypeId} onChange={(event) => setMealTypeId(event.target.value)}>
          <option value="1">Breakfast</option>
          <option value="2">Brunch</option>
          <option value="3">Desert</option>
          <option value="4">Dinner</option>
          <option value="5">Entree</option>
          <option value="6">Lunch</option>
          <option value="7">Side</option>
          <option value="8">Snack</option>
        </select>
      </div>
      <div>
      <label>Select Health Info:  </label>
      <Multiselect 
        options={options}
        selected={selected}
        onSelect={(selected) => setSelected({selected})} // Function will trigger on select event
        onRemove={(selected) => setSelected({selected})} // Function will trigger on remove event
        displayValue="name" // Property name to display in the dropdown options
        />
      </div>
        <button type="submit">Add Recipe</button>
        <Link to={"/"}>Cancel</Link>
      </form>
    </>
  )
}