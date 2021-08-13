Original App Design Project
===

# Fast Cook

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Fast Cook allows users to quickly search for the best recipes based on all the materials they have at their disposal. The app also plans to filter recipes based on how long it takes each recipe to be prepared, along with certain dietary restrictions. The app will also allow users to save recipes by being able to sign into an account.

### App Evaluation

- **Category:** Food & Drink
- **Mobile:** Although primary uses of this app are at home, you would be able to use this wherever you may be staying, whether it be a vacation or a friend's place. The conveinence of this app is being able to find recipes in a short notice.
- **Story:** We aim to increase the quality of meals for people by making the decision process of recipies easier on them.
- **Market:** This app is for individuals who need well-prepared meals at unexpected times. This can range from families to college students to even event coordinators.
- **Habit:** Users wanting to increase the quality of their daily meals and maintain a healthy diet could find themselves using this app frequently. 
- **Scope:** Technically speaking, the scope for this app is fairly reasonable, but allowing the user experience to be as sublime as desired will be exceptionally challenging.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a new account and login
* User can type as many ingredients as they have
* User can type the maximum ready time they want for a recipe
* User can input whether they are vegan/vegetarian
* User can search and scroll through multiple recipes given the restrictions above
* User can select recipe to bring up full detailed view of recipe
* User can save recipes they find appealing to their profile

**Optional Nice-to-have Stories**

* User can filter recipes based on *several* dietary restrictions (examples: dairy, red meat, Vitamin C, etc.)
* User can click a link to a video of explaining the recipe
* User can save searches that they perform to their profile
* User can filter recipes based on cuisine (example: chinese, pub, indian, italian, etc.)
* User can change parts of their profile after creating an account (profile picture, change username, and other settings)

### 2. Screen Archetypes

* Login / Register - User signs up or logs into their account
    * User can create a new account and login
* Filter - User can search for recipes based on parameters
    * User can do a standard search for recipes by name 
    * User can type as many ingredients as they have
    * User can type the maximum ready time they want for a recipe
    * User can select whether they are vegan/vegetarian
* Stream - User can scroll through recipes in a table view
    * User can search and scroll through multiple recipes 
* Detail - User can view the full details of a recipe.
    * User can select recipe to bring up full detailed view of recipe
    * Details include name, servings, ready time, instructions, and ingredients
* Saved Recipes - User can view their saved recipes
    * User can save recipes they find appealing to their profile.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search
* Profile

**Flow Navigation** (Screen to Screen)

* Search
    * Ingredients
    * Recipes
       * Details
* Profile
    * Details

### Demo

https://user-images.githubusercontent.com/65626248/129395027-98bc1112-893b-4a1c-b1ad-dbffddf56768.mp4

## Schema 

### Models
**Recipe**

| Property | Type   | Description             |
| -------- | ------ | ----------------------- |
|  name        |    String    | The name of the recipe.                   |
|   ingredients       |    Array    |          A list of all the ingredients used in the recipe.               |
|     diet     |    String    |               A dietary restriction that the recipe must be suitable for.           |
|   readyTime   | Number | An estimate of how long it will take to cook the recipe. |
### Networking
* Recipes Screen
   * (Read/GET) Retrieve all recipes from API upon request.                                                                                                     <img width="898" alt="Screen Shot 2021-07-09 at 12 16 31 PM" src="https://user-images.githubusercontent.com/65626248/125108343-ef159600-e0af-11eb-8183-1ff77f66955c.png">
* Saved Recipes Screen
   * (Read/Get) Query all saved recipes where user is author.                                                                                                   <img width="609" alt="Screen Shot 2021-07-09 at 12 11 46 PM" src="https://user-images.githubusercontent.com/65626248/125108568-31d76e00-e0b0-11eb-9acd-4046cd696f26.png">


