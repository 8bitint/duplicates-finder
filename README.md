# Duplicates Finder

A seeker of duplicate files.

## Installation

A Ruby interpreter is required to run this project. [Bundler](https://bundler.io) is recommended to install gem dependencies.

To install dependencies and run the tests:

```
bundle install
bundle exec rake
```

## Usage

The executable `find-duplicates` (in the `bin` directory) will scan the current working directory for duplicate files and write these to stdout. 

An optional parameter can be used to specify the directory to be scanned:

```
Usage: find-duplicates [options]
    -h, --help                       Show this help message
    -d, --directory=DIRECTORY        Directory to scan
```


The following...

`./bin/find-duplicates -d ~/Downloads`

... is equivalent to:
```
cd ~/Downloads
$PROJECT_HOME/bin/find-duplicates
``` 


## License

This project is released under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
