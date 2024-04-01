import '../level_selection/levels.dart';
import '../style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

/// This dialog is shown when a level is completed.
///
/// It shows what time the level was completed in and if there are more levels
/// it lets the user go to the next level, or otherwise back to the level
/// selection screen.
class GameWinDialog extends StatelessWidget {
  const GameWinDialog({
    super.key,
    required this.level,
    required this.levelCompletedIn,
  });

  /// The properties of the level that was just finished.
  final GameLevel level;

  /// How many seconds that the level was completed in.
  final int levelCompletedIn;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Center(
      child: NesContainer(
        width: 420,
        height: 400,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (levelCompletedIn > 200 && level.number == 2) ...[
              Text(
                'You completed level ${level.number} with $levelCompletedIn points. Level 3 unlocked!',
                textAlign: TextAlign.center,
              ),
            ] else if (levelCompletedIn < 200 && level.number == 2) ...[
              Text(
                'You completed level ${level.number} with $levelCompletedIn points.Earn at least 200 points to reach level 3.',
                textAlign: TextAlign.center,
              ),
            ] else if (levelCompletedIn >= 100 && level.number == 1) ...[
              Text(
                'You completed level ${level.number} with $levelCompletedIn points. Level 2 unlocked!',
                textAlign: TextAlign.center,
              ),
            ] else if (levelCompletedIn < 100 && level.number == 1) ...[
              Text(
                'You completed level ${level.number} with $levelCompletedIn points. Earn at least 100 points to reach level 2.',
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Text(
                'You finished level ${level.number} with $levelCompletedIn points',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 16),
            if ((levelCompletedIn >= 100 && level.number == 1) ||
                (levelCompletedIn > 200 && level.number == 2)) ...[
              NesButton(
                onPressed: () {
                  context.go('/play/session/${level.number + 1}');
                },
                type: NesButtonType.primary,
                child: const Text('Next level'),
              ),
              const SizedBox(height: 16),
            ],
            NesButton(
              onPressed: () {
                context.go('/play');
              },
              type: NesButtonType.normal,
              child: const Text('Level selection'),
            ),
          ],
        ),
      ),
    );
  }
}
