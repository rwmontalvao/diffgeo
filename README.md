# diffgeo

This program computes curvature, torsion and writhing number for PDB files.

## How to compile

First install `dub` and `dmd`, then use the commands bellow

```
git clone https://github.com/rwmontalvao/diffgeo.git 
cd ./diffgeo
dub build --build=release --compiler=dmd
```

## Usage

```
diffgeo --pdbpath input/2lj5.pdb --threads 4 --outCsvPath ./my.csv
```

- `--pdbPath`: path of input PDB file
- `--threads`: number of threads
- `--outCsvPath`: path of output CSV file (default: ./filename.csv)
- `-h` or `--help`: show help information.