#!/bin/sh

git submodule update --init
hugo --gc --minify

