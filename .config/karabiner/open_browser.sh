#!/bin/bash

open -b $(defbro | grep "*" | cut -d' ' -f2)
