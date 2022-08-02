#! /bin/bash
. /usr/lib/openfoam/openfoam2112/etc/bashrc

cd movingBody
rm -r constant/polyMesh
rm -r 0
rm -r processor*

blockMesh
surfaceFeatureExtract
snappyHexMesh -overwrite
renumberMesh -overwrite
topoSet
transformPoints -rotate-angle '((0 1 0) -10)'
transformPoints -translate '(0 0 0.04)'

cd ..

#---------------

cd background
rm -r constant/polyMesh
rm -r 0
rm -r processor*

blockMesh
mergeMeshes . ../movingBody -overwrite
topoSet

cp -r 0.orig 0
setFields
