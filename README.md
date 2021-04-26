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

## Reflections

I ran out of time before I could write as many tests as I was wanting, though I
do have a successfully working solution.

While this solution solves the presented problem, looking back on what I've
created, I'm not particularly happy with it. I don't believe I quietly thought
about the problem long enough before jumping in which resulted in a few spots
being more difficult than they should've been to work out.

The time limit stressed me out more than I expected. That was surprising.

### Challenges

The biggest challenge I ran into was trying to do too much with the `Processor`
class. Looking back, I believe it would've been much better to define a
resource class or two that knew how to deal with their own chunks of logic as
opposed to the `Processor` knowing how to do _everything_ with raw hashes. It
got conceptually complex quickly, and I lost a lot of time having to go over
the logic in my head multiple times.

### Highlights

It's a tiny little class that doesn't do all that much, but I'm honestly most
proud of the `API` class that I've created here. It has one task and it does it
well.

### Trade offs

I made the assumption that I'd be able to keep nested hashes straight in my
head, but ended up not being able to. That was a poor trade-off :smile:

### Moving Forward

The next steps for `code-challenge3` would be for me to add a `DataEntry` class
or similar. This would house the payload of one web request for a location and
programming language. The `DataEntry` would provide some utility methods and
attribute readers.

After that I would change the data model from a hash of hashes into a flat
array of `DataEntry` objects. This would let me write a number of convenience
methods for filtering that array based on location and/or programming language.

These described changes would make maintenance of the `Processor` easier
because there's less direct logic against primitives in your face. Visually
there would be more method calls on higher level objects as opposed to direct
manipulation of hashes and hashes of hashes.

## How to run it

This solution assumes [RVM](https://rvm.io) is present.

```sh
git clone https://github.com/komidore64/code-challenge3.git
cd code-challenge3
bundle install


# tests
bundle exec rake test

# rubocop
bundle exec rake lint

# run it
bundle exec bin/code-challenge3
```

help output:

```
$ bundle exec bin/code-challenge3 --help
USAGE: code-challenge3 [OPTIONS]
        --base-url URL               Scheme and hostname of the server to request.
                                     (default: https://jobs.github.com)
        --url-path PATH              Path to request from the server.
                                     (default: /positions.json)
        --locations LOCATIONS        Comma-seperated list of locations to check for job listings.
                                     (default: Boston, San Francisco, Los Angeles, Denver, Boulder,
                                     Chicago, New York, Raleigh)
        --languages LANGUAGES        Comma-seperated list of programming languages to search for.
                                     (default: Java, C#, Python, Swift, Objective-C, Ruby, Kotlin,
                                     Go, C++, JavaScript)
        --log-level LEVEL            Set the log level. [debug, info, warn]
                                     (default: warn)
```

## Interesting tidbits

```
$ tree -a -I .git
.
├── bin
│   └── code-challenge3
├── .github
│   └── workflows
│       └── ruby.yml
├── lib
│   ├── code_challenge3
│   │   ├── api.rb
│   │   ├── cli.rb
│   │   ├── logging.rb
│   │   └── processor.rb
│   └── code_challenge3.rb
├── test
│   ├── fixtures
│   │   ├── boston_cpp.json
│   │   ├── boston_csharp.json
│   │   ├── boston_go.json
│   │   ├── boston_java.json
│   │   ├── boston_javascript.json
│   │   ├── boston_kotlin.json
│   │   ├── boston_objectivec.json
│   │   ├── boston_python.json
│   │   ├── boston_ruby.json
│   │   ├── boston_swift.json
│   │   └── positions.json
│   ├── api_test.rb
│   ├── processor_test.rb
│   └── test_helper.rb
├── Gemfile
├── Gemfile.lock
├── LICENSE
├── Rakefile
├── README.md
├── .rubocop.yml
├── .ruby-gemset
└── .ruby-version

7 directories, 29 files
```

```
$ git ls-files | grep -v -e LICENSE | xargs wc -l
    43 .github/workflows/ruby.yml
    18 .rubocop.yml
     1 .ruby-gemset
     1 .ruby-version
    35 Gemfile
    79 Gemfile.lock
   273 README.md
    43 Rakefile
    35 bin/code-challenge3
    21 lib/code_challenge3.rb
    48 lib/code_challenge3/api.rb
   118 lib/code_challenge3/cli.rb
    36 lib/code_challenge3/logging.rb
   133 lib/code_challenge3/processor.rb
    65 test/api_test.rb
    28 test/fixtures/boston_cpp.json
     1 test/fixtures/boston_csharp.json
    54 test/fixtures/boston_go.json
    41 test/fixtures/boston_java.json
    41 test/fixtures/boston_javascript.json
     3 test/fixtures/boston_kotlin.json
     3 test/fixtures/boston_objectivec.json
    54 test/fixtures/boston_python.json
     1 test/fixtures/boston_ruby.json
     3 test/fixtures/boston_swift.json
   652 test/fixtures/positions.json
   100 test/processor_test.rb
    24 test/test_helper.rb
  1954 total
```
