#!/usr/bin/env bash
source=${BASH_SOURCE[0]}
source=$(dirname $source)
$source/springer_bin/bin/springer $@
