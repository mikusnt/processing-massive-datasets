# Processing of Massive Datasets - Short Course
__Exercise 1__
### Useful links:
[Course website](http://www.cs.put.poznan.pl/kdembczynski/lectures/pmds-sc/)
[uniqe_tracks.zip](http://www.cs.put.poznan.pl/kdembczynski/lectures/data/unique_tracks.zip)
[triplets_sample_20p.zip](http://www.cs.put.poznan.pl/kdembczynski/lectures/data/triplets_sample_20p.zip)
Before running scripts you need to add above files into `original/` directory.
### Setup
Statistics (task 2):
```
$ time ./statistics.sh
```
Data translation (task 4):
```
$ time ./prapare_files.sh
```
Serial and parallel queries with output to `.txt` (task 5):
```
$ time ./all_serial.sh
$ time ./all_parallel.sh
```
