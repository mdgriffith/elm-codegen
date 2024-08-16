#!/bin/bash


rm -rf play
mkdir play
cd play

node ../bin/elm-codegen init
node ../bin/elm-codegen run
