FROM julia:latest
LABEL author="Ivan Sraichuk" 
#install required packages
RUN mkdir /code
WORKDIR /code
COPY . /code
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate(); '
#CMD  ["julia", "-e", "print(\"Hell0\")"]

#CMD  ["julia", "--project", "./src/ReadMind.jl", "--input", "chb01_01.edf", "--inputDir", "./","--params", "Parameters.jl", "--paramsDir", "./src/", "--outDir", "./"]
