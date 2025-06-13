import 'dart:io';

final directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1],           [0, 1],
    [1, -1],  [1, 0],  [1, 1],
];

bool checkWord(List<List<String>> grid, int startRow, int startCol, int dirRow, int dirCol, int rows, int cols, String word) {
    for (int k = 0; k < word.length; k++) {
      int newRow = startRow + dirRow * k;
      int newCol = startCol + dirCol * k;

    if (newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols) {
      return false;
    }

    if (grid[newRow][newCol] != word[k]) {
      return false;
    }
  }

  return true;
}

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

    List<List<String>> grid = lines.map((line) => line.split('')).toList();

    final int numberOfRows = grid.length;
    final int numberOfColumns = grid[0].length;

    final int totalOccurrences = searchOccurrences(grid, numberOfRows, numberOfColumns);
    print('Total occurrences of the sequence "XMAS": $totalOccurrences');
}
