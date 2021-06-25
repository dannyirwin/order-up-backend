# Order Up!

Find the patterns and play with friends online! This is the front end of a
project to go with
[this fronted.](https://github.com/dannyirwin/order-up-frontend)

## Summary

Order Up is a clone of the popular game card game, Set. You are an employee of
an unusual cafe and have to trow together orders for customers. These orders,
represented by cards, have strict rules to them. Each card has 4 attributes:
Color, Fill/Shading, Number of items, and Item Type. A valid order consists of 3
cards where each attribute across the cards is either all teh same or all
different.

This is the first full backend I've built and it incorporates ActionCable to
support live online multiplayer via websockets.

<img src="./src/images/ValidExamples.png" alt="Valid Examples" height="300px"><img
src="./src/images/InvalidExamples.png" alt="Invalid Examples" height="300px">

## Technologies

<img src="https://assets-global.website-files.com/5d9bc5d562ffc2869b470941/5e1f8bd1dc3c511ea5a28a56_icon-rect-tech.png" alt="React Logo" height="126"><img src="https://upload.wikimedia.org/wikipedia/commons/6/61/HTML5_logo_and_wordmark.svg" alt="HTML Logo" height="126">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png" alt="Javascript Logo" height="126">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/CSS.3.svg/730px-CSS.3.svg.png" alt="CSS Logo" height="126">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://www.edureka.co/blog/wp-content/uploads/2019/02/What-is-Ruby-on-Rails-1.png" alt="CSS Logo" height="126">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://fuzati.com/wp-content/uploads/2016/12/Ruby-Logo-300x209.png" alt="CSS Logo" height="126">

## Features

- Full game cycle: Games persist over multiple sessions, can start new games,
  and handles all logic required to play.
- Online multiplayer updates across all users games when changes are made
- Colorblind Mode for accessability.
- Unique username generated for each user.

## Code Snippets

This is the code is used to generate and shuffle new decks of cards.

```javascript
const generateNewDeck = () => {
  const deck = [];
  const shapes = ['shape-1', 'shape-2', 'shape-3'];
  const colors = ['color-1', 'color-2', 'color-3'];
  const counts = [1, 2, 3];
  const fills = ['fill-1', 'fill-2', 'fill-3'];
  let cardId = 1;
  shapes.forEach(shape => {
    colors.forEach(color => {
      counts.forEach(count => {
        fills.forEach(fill => {
          [
            ...deck,
            {
              id: cardId,
              color: color,
              count: count,
              shape: shape,
              fill: fill
            }
          ];
          cardId++;
        });
      });
    });
  });
  return deck;
};

const shuffleDeck = deck => {
  var currentIndex = deck.length,
    randomIndex;
  while (0 !== currentIndex) {
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;
    [deck[currentIndex], deck[randomIndex]] = [
      deck[randomIndex],
      deck[currentIndex]
    ];
  }
  return deck;
};
```

## Feature Wishlist

- While the app is currently deployed on Heroku, the there are still problems
  upgrading to websockets
- User Sign-in and authentication
- User can host a new game with a unique ID or us and ID to specify which game
  to join.
- In-game text chat.
- Store long term game data for leaderboards etc.

## Reach out

#### Want to get get in touch or see more of my work?

[Github Homepage](https://github.com/dannyirwin)

[Email Me](https://github.com/dannyirwin)

[Linkedin](https://www.linkedin.com/in/itsdanielirwin/)
