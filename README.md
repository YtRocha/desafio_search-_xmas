# xmas_search

This project searches for the number of occurrences of the word Xmas in a txt file

## How to use

After starting the application, select the resolution algorithm (curved search or linear search) and then choose which of the two files you want to analyze. After selecting, click "Run Search".

## Difference between algorithms

### Linear Search

The linear search goes through all valid directions when finding any X, as long as the letters match the word xmas. However, this search follows the same direction for all letters.

### Curved Search

The curved search, upon discovering any X, looks around it, in all valid directions, looking for the next letter (M) in adjacent positions, if it finds it, it looks for the next letter (A) in the same way and, finally, the letter (S), thus considering the word as curved. It is worth noting that, for example, several Ms can be found adjacent to the X, the curved search also considers these cases as one more occurrence, if the word is completed.

## Files Path

the search algorithms are in the folder ./lib/utils and the input files are in the folder ./assets
