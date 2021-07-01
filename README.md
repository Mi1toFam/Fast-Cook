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
Fast Cook allows users to search for recipes based on all the ingredients they have at their disposal. The app plans to prioritize certain ingredients over others for users to have the best experience (example: prioritizing chicken over bread crumbs for Chicken Alfredo). The app also plans to filter recipes based on how long it takes each recipe to be prepared. The app will also allow users to save recipes by being able to sign into an account.

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
* App will rank ingredients in each recipe based on how important they are to the final product
* User can search and scroll through multiple recipes given the ingredients and max ready time that they type in
* User can select recipe to bring up full detailed view of recipe
* User can see percentage match to each recipe, based on rankings made by the app for ingredients
* User can save recipes they find appealing

**Optional Nice-to-have Stories**

* User can filter recipes based on *several* dietary restrictions (examples: vegetarian/vegan, dairy, red meat, Vitamin C, etc.)
* User can click a link to a video of explaining the recipe
* User can filter recipes based on cuisine (example: chinese, pub, indian, italian, etc.)

### 2. Screen Archetypes

* Login / Register - User signs up or logs into their account
    * User can create a new account and login
* Filter - User can search for recipes based on parameters
    * User can type as many ingredients as they have
    * User can type the maximum ready time they want for a recipe
    * App will rank ingredients in each recipe based on how important they are to the final product (this happens more on the backend)
* Stream - User can scroll through recipes in a table view
    * User can search and scroll through multiple recipes given the ingredients and max ready time that they type in
    * User can see percentage match to each recipe, based on rankings made by the app for ingredients
* Detail - User can view the full details of a recipe.
    * User can select recipe to bring up full detailed view of recipe
    * User can see percentage match to each recipe, based on rankings made by the app for ingredients
* Saved Recipes - User can view their saved recipes
    * User can save recipes they find appealing
* Settings - User can configure app options

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search
* Saved Recipes

**Flow Navigation** (Screen to Screen)

* Search
    * Recipes
       * Details
* Saved Recipes
    * Details

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
