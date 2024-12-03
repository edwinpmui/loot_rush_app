### App architecture makes sense (e.g. views/view models/models)
Views:
- CollectionView
  - This view contains a list of all the picture collections, and the number of pieces the user currently has for each collection
- HomeView
  - The view for the home screen. It contains brief instructions, a start button (Rush), and a collection button to view collections
- LootView
  - This view is the lootbox view. The user first clicks the mystery box, and then clicks the floating puzzle piece, which tells the user if a new piece is unlocked and send them to PictureView
- PictureView
  - This is a view accessible through CollectionView. It shows a grid overlay of the actual image, and squares in the grid disappear as pieces are discovered, uncovering the picture
- RushView
  - This is the view with the map, displaying route options, how close the user is to the picked route, and picking new routes

ViewModels:
- PictureViewModel
  - Handles the generation of the pieces collected for the image so that PictureView renders the right grid and CollectionView displays the correct numbers
- RushViewModel
  - Handles getting current rush location, other location managers, detecting if the user is close to a route, and generating routes at random

Models:
- Picture
  - Contains info about the picture, like id, name, numCollected, rows, cols, etc.
- Route, Location
  - Contains info about coordinates of Route destinations

### Course Concept 1
We used data persistence to store the picture pieces collected

### Course Concept 2
We used Core Location to track user location and enable users to finish routes
