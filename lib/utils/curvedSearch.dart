// Function to look around the current position in the grid
int lookAround(
  List<List<String>> grid,
  int i,
  int j,
  int numberOfRows,
  int numberOfColumns,
  String char,
) {
  String nextChar;

  switch (char) {
    case 'X':
      nextChar = 'M';
      break;
    case 'M':
      nextChar = 'A';
      break;
    case 'A':
      nextChar = 'S';
      break;
    case 'S':
      return 1; // Found the full sequence
    default:
      return 0;
  }

  final directions = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1],
  ];

  int total = 0;

  for (var dir in directions) {
    int newRow = i + dir[0];
    int newCol = j + dir[1];

    // Stay inside the grid boundaries
    if (newRow >= 0 &&
        newRow < numberOfRows &&
        newCol >= 0 &&
        newCol < numberOfColumns &&
        grid[newRow][newCol] == nextChar) {
      total += lookAround(
        grid,
        newRow,
        newCol,
        numberOfRows,
        numberOfColumns,
        nextChar,
      );
    }
  }

  return total;
}

// Function to search for occurrences of XMAS
int searchOccurences(
  List<List<String>> grid,
  int numberOfRows,
  int numberOfColumns,
) {
  int occurrences = 0;

  for (int i = 0; i < numberOfRows; i++) {
    for (int j = 0; j < numberOfColumns; j++) {
      if (grid[i][j] == 'X') {
        occurrences += lookAround(
          grid,
          i,
          j,
          numberOfRows,
          numberOfColumns,
          'X',
        );
      }
    }
  }

  return occurrences;
}

int runCurvedSearchFromString(String data) {
  // Split the input data into lines and remove empty lines
  final lines = data.split('\n').where((l) => l.trim().isNotEmpty).toList();

  // Convert lines to a grid of characters
  List<List<String>> grid = lines.map((line) => line.trim().split('')).toList();

  final int numberOfRows = grid.length;
  final int numberOfColumns = grid[0].length;

  return searchOccurences(grid, numberOfRows, numberOfColumns);
}
