# Code Challenge 3

![License](https://img.shields.io/github/license/komidore64/code-challenge3)
![GitHub repo size](https://img.shields.io/github/repo-size/komidore64/code-challenge3)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/komidore64/code-challenge3/tests)

## Assignment

Please write a Ruby app that uses the [Github Jobs
API](https://jobs.github.com/api) to help show programming language trends
across the following cities:

| Cities        | Languages   |
| ------------- | ----------- |
| Boston        | Java        |
| San Francisco | C#          |
| Los Angeles   | Python      |
| Denver        | Swift       |
| Boulder       | Objective-C |
| Chicago       | Ruby        |
| New York      | Kotlin      |
| Raleigh       | Go          |
|               | C++         |
|               | JavaScript  |

Program guidelines:
- all work done in a git repository
- unit tests
- README

The app should present following information:

```
Boston:
  - Python: 25%
  - Ruby: 10%
  - C++: 10%
  - Kotlin:  5%
San Francisco:
  - Javascript: 35%
  - Python: 10%
  - Ruby: 15%
```

That can be read as "In Boston, 25% of all current programming jobs refer to
Python". The numbers above are made up but your program should be able to give
us some indication of programming language trends across those cities based on
the information source from GitHub Jobs.

Also, add a *README* with the follow questions documented and answered.
- challenges you ran into
- areas of the code you are most proud of
- areas of the code you are least proud of
- trade-offs you made and why
- next areas of focus to move this towards production

This exercise should take you no more than 6 hours, if it does please just
commit what you've completed.

## Notes

### 10,000 foot view

What we're wanting to do at a high-level:

1. Pull the interested data from the API
2. Analyze what we received
3. Present output

Maybe that's too high-level! That sounds extremely simple at face value.

#### Step one

Search all permutations of cities with programming languages. Really all we
need to store is the number of listings we find for each city-language
combination.

#### Step two

What's our total (all languages for one city)? This is how we'll get our
percentage values.

#### Step three

Print one city at a time while looping over all the languages found for that
area.

## Design

Here at the beginning, I'm mostly just imagining two classes, but one that
really does most of the heavy lifting.

### API

This class will provide a nice and simple interface for making our web
requests.

### Processor

This class is expected to do most of the grunt work. It will ask the API class
to make requests, analyze the results, and finally print them to `stdout`.

If we wanted to get _really fancy_, we could parallelize our API requests and
data processing, but honestly that feels like over-engineering for this code
challenge. Please see my
[code-challenge2](https://github.com/komidore64/code-challenge2) if you're
interested in how I'd handle something like this with a pool and workers model.
:wink:
