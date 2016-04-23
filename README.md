# Eigenlayouts

An investigation of web layouts through image data. Pulls down website homepage
via PhantomJS for later processing. 

## Requirements

* Docker
* GNU Make

## Retrieving images

To retrieve the images, you'll first need to download a corpus of domains. A
good corpus to start from would be the list of top sites from Alexa. 

To run, seed your list of domains as a directory full of dummy files with

    make mkdomains
    
Once that finishes, you should run:

    make -i

to start pulling down domain data serially. To run multiple jobs at one time,
run:

    make -i -jN

where `N` is the number of jobs run at time. 
