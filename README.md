[![Build Status](https://travis-ci.org/jordantcox/com.phantomdata.Monocle.png)](https://travis-ci.org/jordantcox/com.phantomdata.Monocle) [![Code Climate](https://codeclimate.com/repos/528c31de56b102694a000b6a/badges/4c2a2c4332c0d99f4d23/gpa.png)](https://codeclimate.com/repos/528c31de56b102694a000b6a/feed)

# Monocle

A simple datalogger that provides a full API for pushing and retrieving data as well as an attractive primary web interface.

## Running

The following environment variables need to be set either through the environment or through a .env file in the root:
- M_SECRET_TOKEN = The session storage secret token; make one up.

If making changes; be sure to hookup the test script pre-commit:
    `ln -s ./test.sh .git/hooks/pre-commit`
