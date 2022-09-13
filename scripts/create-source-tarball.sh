#!/usr/bin/env bash

workdir=destiny-$(git describe)-src

# This is a workaround until dart_wormhole_william is removed as a submodule
# Once dart_wormhole_william is no longer a submodule, `git archive` should suffice
(rm -rfv $workdir; mkdir $workdir; cd $workdir; git clone .. . --recursive; find . -name .git -exec rm -rf {} \+)

tar -cf $workdir{.tar,}
gzip $workdir.tar
