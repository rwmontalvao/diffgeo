# diffgeo

This program compute curvature and torsion for PDB files

## How to compile

First install `dub` and `dmd`, then use the commands bellow

```
git clone https://github.com/rwmontalvao/diffgeo.git 
cd ./diffgeo
dub build --build=release --compiler=dmd
```

## How to use

```
./diffgeo --id 2lj5 --cores 4 --verbose
```
