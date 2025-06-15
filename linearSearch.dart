import 'dart:io';

final directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1],           [0, 1],
    [1, -1],  [1, 0],  [1, 1],
];

// Function to check if the word can be found starting from a given position in a specific direction
bool checkWord(List<List<String>> grid, int startRow, int startCol, int dirRow, int dirCol, int rows, int cols, String word) {
    for (int k = 0; k < word.length; k++) {
      int newRow = startRow + dirRow * k;
      int newCol = startCol + dirCol * k;

	// Stay inside the grid boundaries
    if (newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols) {
      return false;
    }

    if (grid[newRow][newCol] != word[k]) {
      return false;
    }
  }

  return true;
}

// Function to search for occurrences of XMAS
int searchOccurrences(List<List<String>> grid, int rows, int cols) {
    int count = 0;
    String target = "XMAS";

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        for (var dir in directions) {
          if (checkWord(grid, i, j, dir[0], dir[1], rows, cols, target)) {
            count++;
          }
        }
      }
    }

    return count;
}

void main(List<String> args) async {

    if (args.isEmpty) {
      print('Usage: dart main.dart <filename>');
      exit(1);
    }

    final filename = args[0];
    final file = File(filename);

    if (!await file.exists()) {
    print('Error: File "$filename" not found.');
    exit(1);
    }

    final lines = await file.readAsLines();

    // Convert lines to a grid of characters
    List<List<String>> grid = lines.map((line) => line.split('')).toList();

    // grid 140x140
    // the number of rows is 140
    final int numberOfRows = grid.length;
    // the number of columns is 140 in the input, the same for all rows
    final int numberOfColumns = grid[0].length;

    final int totalOccurrences = searchOccurrences(grid, numberOfRows, numberOfColumns);
    print('Total occurrences of the sequence "XMAS": $totalOccurrences');
}
