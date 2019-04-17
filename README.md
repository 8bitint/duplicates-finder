# Duplicates Finder

A seeker of duplicate files.

## Installation

A Ruby (2.3 or greater) interpreter is required to run this project. [Bundler](https://bundler.io) is recommended to install gem dependencies.

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

## Design notes
Duplicates are identified by performing two passes over the files within the search directory.

In the first pass, files are grouped by their size. Groups containing two or more files are considered duplication 
candidates requiring closer inspection in the second pass. Groups that contain only a single file are immediately 
discounted. 

In the second pass, if a candidate group contains exactly two files then their contents are compared. In all 
other cases (i.e., more than two files), a digest is calculated for each file in the group. Although this is considerably 
slower than byte stream content comparison, it has the advantage of handling any number of duplications using only Ruby's 
native data structures. In this case, the digest is used as a key into Ruby's native hash map. 

The digest that has been used is MD5. It is statistically unlikely enough to have collisions for the purpose of 
file de-duplication if the number of file is less than 
[2^64](https://crypto.stackexchange.com/questions/12677/strength-of-md5-in-finding-duplicate-files).)


## License

This project is released under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
