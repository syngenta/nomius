# Nomius — bulk domain & package name availability checker

- [Description](#description)
- [Ratio](#ratio)
- [Installation](#installation)
  - [Ruby gem](#ruby-gem)
  - [Docker image](#docker-image)
- [Usage](#usage)
  - [Basic usage](#basic-usage)
  - [Built-in help](#built-in-help)
  - [Using TXT file as input](#using-txt-file-as-input)
  - [Using CSV file as input](#using-csv-file-as-input)
  - [Using CSV file as input and output](#using-csv-file-as-input-and-output)
- [Using as a Ruby library](#using-as-a-ruby-library)
- [Contributing](#contributing)
- [Notes](#notes)

## Description

`nomius` takes a list of names as input and check domain name (`.com`, `.org`) and package name (RubyGems, PyPi, NPMjs, etc.) availability.

The very basic usage example:

```shell
user@home:~$ nomius biochem biochemio biochemus

┌───────────┬──────┬──────┬────┬────────┬─────┬─────┬─────┐
│ Name      │ .com │ .org │ GH │ Docker │ npm │ pip │ gem │
├───────────┼──────┼──────┼────┼────────┼─────┼─────┼─────┤
│ biochem   │  ❌  │  ❌  │ ❌ │   ❌   │ ✅  │ ✅  │ ✅  │
│ biochemio │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
│ biochemus │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
└───────────┴──────┴──────┴────┴────────┴─────┴─────┴─────┘
```

- `nomius` is a console utility. Could be installed & used as:
  - [Ruby gem](#ruby-gem) (Ruby 2.6+);
  - [Docker image](#docker-image).
- Availability checks supported:
  - domain name (`.com`,`.org`);
  - [RubyGems](https://rubygems.org/) package name;
  - [PyPi](https://pypi.org/) package name;
  - [NPMjs](https://www.npmjs.com/) package name;
  - [GitHub](https://github.com/) user/org name;
  - [DockerHub](https://hub.docker.com/) user/org name.
- Input is a name, list of names or CSV file with a list of names.
- Output is a table with check results for each name. You could choose output to console or CSV file.

## Ratio

For example, you have created a new biochemistry project. Now you need to find a short and memorable name, with a domain and package name available to register.

You may brainstorm dozens of names (or use a script to generate hundreds of names in different combinations):

```txt
liber, chimeia, bchem, chemb, biochem, chembio, biochemio, biochemus
```

Now you need to filter this list to names that have a domain name and package name available to register. But in popular domain zones (`.com`, `.org`) most of the short and memoizable names are already registered. Also, a good package name may be hard to find, especially if you want the name to be available across different languages and package managers.

Manually checking all those names to have available domains (`.com`, `.org`) and package names (`pip`, `npm`, `gem`) is a tedious manual task.

`nomius` will check all your names in a minute 🚀

```shell
user@home:~$ nomius liber chimeia bchem chemb biochem chembio biochemio biochemus

┌───────────┬──────┬──────┬────┬────────┬─────┬─────┬─────┐
│ Name      │ .com │ .org │ GH │ Docker │ npm │ pip │ gem │
├───────────┼──────┼──────┼────┼────────┼─────┼─────┼─────┤
│ bchem     │  ❌  │  ❌  │ ❌ │   ✅   │ ✅  │ ✅  │ ✅  │
│ biochem   │  ❌  │  ❌  │ ❌ │   ❌   │ ✅  │ ✅  │ ✅  │
│ biochemio │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
│ biochemus │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
│ chemb     │  ❌  │  ✅  │ ❌ │   ✅   │ ✅  │ ✅  │ ✅  │
│ chembio   │  ❌  │  ❌  │ ❌ │   ✅   │ ✅  │ ✅  │ ✅  │
│ chimeia   │  ❌  │  ❌  │ ❌ │   ✅   │ ✅  │ ✅  │ ✅  │
│ liber     │  ❌  │  ❌  │ ❌ │   ❌   │ ❌  │ ❌  │ ✅  │
└───────────┴──────┴──────┴────┴────────┴─────┴─────┴─────┘
```

## Installation

### Ruby gem

```shell
# Install nomius gem.
user@home:~$ gem install nomius

# Run nomius.
user@home:~$ nomius biochem

┌─────────┬──────┬──────┬────┬────────┬─────┬─────┬─────┐
│ Name    │ .com │ .org │ GH │ Docker │ npm │ pip │ gem │
├─────────┼──────┼──────┼────┼────────┼─────┼─────┼─────┤
│ biochem │  ❌  │  ❌  │ ❌ │   ❌   │ ✅  │ ✅  │ ✅  │
└─────────┴──────┴──────┴────┴────────┴─────┴─────┴─────┘
```

### Docker image

All the options are the same as for the Ruby gem.

> Docker image is not published yet. But you could build it yourself.

```shell
# 1. Clone the repository.
user@home:~$ git clone git@github.com:syngenta/nomius.git
user@home:~$ cd nomius

# 2. Build the Docker image.
user@home:~$ docker build -t nomius .

# 3. Run the Docker container.
user@home:~$ docker run -t --rm nomius biochem

┌─────────┬──────┬──────┬────┬────────┬─────┬─────┬─────┐
│ Name    │ .com │ .org │ GH │ Docker │ npm │ pip │ gem │
├─────────┼──────┼──────┼────┼────────┼─────┼─────┼─────┤
│ biochem │  ❌  │  ❌  │ ❌ │   ❌   │ ✅  │ ✅  │ ✅  │
└─────────┴──────┴──────┴────┴────────┴─────┴─────┴─────┘
```

## Usage

### Basic usage

```shell
# Run nomius with a list of names to check.
user@home:~$ nomius biochem biochemio biochemus

┌───────────┬──────┬──────┬────┬────────┬─────┬─────┬─────┐
│ Name      │ .com │ .org │ GH │ Docker │ npm │ pip │ gem │
├───────────┼──────┼──────┼────┼────────┼─────┼─────┼─────┤
│ biochem   │  ❌  │  ❌  │ ❌ │   ❌   │ ✅  │ ✅  │ ✅  │
│ biochemio │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
│ biochemus │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
└───────────┴──────┴──────┴────┴────────┴─────┴─────┴─────┘
```

### Built-in help

```shell
# Run built-in help.
user@home:~$ nomius --help

Usage: nomius [OPTIONS] [NAMES...]

Nomius — bulk domain & package name availability checker.

Options:
  -h, --help           Print usage
  -i, --input string   Input file. Could be:
                       - TXT with each name on a separate line;
                       - CSV file with 2 columns: "name","comment" ("comment"
                       is optional).

  -o, --output string  Output CSV file
  -s, --silent         Print less output
      --version        Print version

Examples:
  Basic usage
  Check "firstname" and "othername" names.
    $ nomius firstname othername

  Usage with a TXT file
    $ nomius --input names.txt
  or
    $ cat names.txt | nomius
  or
    $ nomius < names.txt

  Usage with a CSV file
    $ nomius --input names.csv

  Usage with a CSV file and output to a CSV file
    $ nomius --input names.csv --output results.csv
```

### Using TXT file as input

Use a TXT file with each name on a separate line.
Wrap strings in quotes if it contains any non-alphanumeric characters.

```txt
biochem
biochemio
biochemus
```

```shell
user@home:~$ nomius --input names.txt

┌───────────┬──────┬──────┬────┬────────┬─────┬─────┬─────┐
│ Name      │ .com │ .org │ GH │ Docker │ npm │ pip │ gem │
├───────────┼──────┼──────┼────┼────────┼─────┼─────┼─────┤
│ biochem   │  ❌  │  ❌  │ ❌ │   ❌   │ ✅  │ ✅  │ ✅  │
│ biochemio │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
│ biochemus │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │
└───────────┴──────┴──────┴────┴────────┴─────┴─────┴─────┘
```

Also, you could use shell pipe:

```shell
user@home:~$ cat names.txt | nomius
# or
user@home:~$ nomius < names.txt
```

### Using CSV file as input

Input CSV file with 2 columns: _name_, _comment_.
_Name_ is required, _comment_ is optional:

```CSV
biochem,"short of bio+chemistry"
biochemio,"short of biochemistry + fancy ending"
biochemus,"short of biochemistry + fancy ending"
```

```shell
user@home:~$ nomius --input names.csv

┌───────────┬──────┬──────┬────┬────────┬─────┬─────┬─────┬──────────────────────────────────────┐
│ Name      │ .com │ .org │ GH │ Docker │ npm │ pip │ gem │ Comment                              │
├───────────┼──────┼──────┼────┼────────┼─────┼─────┼─────┼──────────────────────────────────────┤
│ biochem   │  ❌  │  ❌  │ ❌ │   ❌   │ ✅  │ ✅  │ ✅  │ short of bio+chemistry               │
│ biochemio │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │ short of biochemistry + fancy ending │
│ biochemus │  ✅  │  ✅  │ ✅ │   ✅   │ ✅  │ ✅  │ ✅  │ short of biochemistry + fancy ending │
└───────────┴──────┴──────┴────┴────────┴─────┴─────┴─────┴──────────────────────────────────────┘
```

### Using CSV file as input and output

```shell
user@home:~$ nomius --input names.csv --output results.csv
```

Output in `results.csv` CSV file:

```csv
Name,Comment,bchem.com,bchem.org,GitHub.com,hub.docker.com,NPMjs.com,PyPi.org,RubyGems.org
biochem,short of bio+chemistry,-,-,-,-,+,+,+
biochemio,short of biochemistry + fancy ending,+,+,+,+,+,+,+
biochemus,short of biochemistry + fancy ending,+,+,+,+,+,+,+
```

## Using as a Ruby library

`nomius` is designed to be a CLI tool, but you could use it as a Ruby library.

```shell
# Install nomius gem.
user@home:~$ gem install nomius
```

```ruby
require 'nomius'

# Run all checks:
results = Nomius::BulkChecker.check(
  names: ["biochem", "biochemio", "biochemus"]
)

# Run only specific checks:
results = Nomius::BulkChecker.check(
  names: ["biochem", "biochemio", "biochemus"],
  detectors: [Nomius::Detector::DomainComDetector]
)

# Run with verbose logger:
results = Nomius::BulkChecker.check(
  names: ["biochem", "biochemio", "biochemus"],
  logger: Nomius::Logger::Verbose.new
)

# Use names with comments
names = [
  Nomius::Name.new(name: "biochem", comment: 'short of bio+chemistry'),
  Nomius::Name.new(name: "biochemio", comment: 'short of biochemistry + fancy ending')
]
results = Nomius::BulkChecker.check(names: names)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/syngenta/nomius](https://github.com/syngenta/nomius).

Please, check our [Contribution guide](CONTRIBUTING.md) for more details.

This project adheres to the [Code of Conduct](CODE_OF_CONDUCT.md). We pledge to act and interact in ways that contribute to an open, welcoming, diverse, inclusive, and healthy community.

## Notes

- `nomius` uses DNS and WHOIS checks to verify domain name availability. Results may not be 100% precise.
