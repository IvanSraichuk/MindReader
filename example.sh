#!/bin/bash
# set -euo pipefail

################################################################################
julia -e 'using Pkg; Pkg.activate(\".\"); Pkg.instantiate(); '
julia --project --input chb01_01.edf --inputDir ./   --addDir ./ --annotation chb01-summary.txt --annotDir ./

# iterate on patient directories
for patient in $( command find ./data/* -type f )
do
  # identify annotation file
  annotation=$( command find "${patient}" -name '*summary.txt' -type f  )

  # iterate on recordings
  for edf in $( command find "${patient}" -name '*edf' -type f )
  do

    # echo input file
    echo "EDF: ${${edf//*\/}/.edf/}"

    julia \
      --project \
      " ./src/ReadMind.jl" \
      --input "${edf//*\/}" \
      --inputDir "${patient}/" \
      --params "Parameters.jl" \
      --paramsDir "./src/" \
      --annotation "${annotation//*\/}" \
      --annotDir "${patient}/" \
      --outDir "./" \
      --additional "annotationCalibrator.jl,fileReaderXLSX.jl" \
      --addDir "./" 
  done
done

################################################################################
