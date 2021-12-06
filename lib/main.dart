void main() {
  List<List<String>> seating = generateInitialSeating();
  while (completeSeatingRound(seating)){}
  print(occupiedSeatsOf(seating));
}

int occupiedSeatsOf(List<List<String>> seating) {
  int occupiedSeats = 0;
  seating.forEach((row) {
    row.forEach((seat) {
      if (seat == '#') occupiedSeats++;
    });
  });
  return occupiedSeats;
}

bool completeSeatingRound(List<List<String>> seating) {
  List<void Function()> seatingAlterations = [];
  for (int i = 0; i < seating.length; i++) {
    for (int j = 0; j < seating[0].length; j++) {
      if (seating[i][j] == '.') continue;
      bool occupied = isOccupied(seating, i, j);
      int adjacentOccupiedSeats = numberOfAdjacentOccupiedSeats(seating, i, j);
      if (!occupied && adjacentOccupiedSeats == 0) {
        seatingAlterations.add(() {
          seating[i][j] = '#';
        });
      } else if (occupied && adjacentOccupiedSeats >= 4) {
        seatingAlterations.add(() {
          seating[i][j] = 'L';
        });
      }
    }
  }
  seatingAlterations.forEach((alteration) => alteration());
  return seatingAlterations.length > 0;
}

int numberOfAdjacentOccupiedSeats(List<List<String>> seating, int i, int j) {
  int occupiedSeats = 0;
  for (int a = i - 1; a <= i + 1; a++) {
    for (int b = j - 1; b <= j + 1; b++) {
      if (a == i && b == j) continue;
      if (a >= 0 && b >= 0 && a < seating.length && b < seating[0].length) {
        if (isOccupied(seating, a, b)) occupiedSeats++;
      }
    }
  }
  return occupiedSeats;
}

bool isOccupied(List<List<String>> seating, int i, int j) {
  return seating[i][j] == '#';
}

List<List<String>> generateInitialSeating() {
  return [
    ['L', '.', 'L', 'L', '.', 'L', 'L', '.', 'L', 'L'],
    ['L', 'L', 'L', 'L', 'L', 'L', 'L', '.', 'L', 'L'],
    ['L', '.', 'L', '.', 'L', '.', '.', 'L', '.', '.'],
    ['L', 'L', 'L', 'L', '.', 'L', 'L', '.', 'L', 'L'],
    ['L', '.', 'L', 'L', '.', 'L', 'L', '.', 'L', 'L'],
    ['L', '.', 'L', 'L', 'L', 'L', 'L', '.', 'L', 'L'],
    ['.', '.', 'L', '.', 'L', '.', '.', '.', '.', '.'],
    ['L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L'],
    ['L', '.', 'L', 'L', 'L', 'L', 'L', 'L', '.', 'L'],
    ['L', '.', 'L', 'L', 'L', 'L', 'L', '.', 'L', 'L'],
  ];
}