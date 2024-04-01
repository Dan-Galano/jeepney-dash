const gameLevels = <GameLevel>[
  (
    number: 1,
    winScore: 3,
    canSpawnTall: false,
  ),
  (
    number: 2,
    winScore: 3,
    canSpawnTall: false,
  ),
  (
    number: 3,
    winScore: 3,
    canSpawnTall: true,
  ),
];

typedef GameLevel = ({
  int number,
  int winScore,
  bool canSpawnTall,
});
