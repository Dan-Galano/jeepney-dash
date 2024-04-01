const List<Song> songs = [
  Song('folk-music.mp3', 'Folk Music', artist: 'bertz'),
  Song('free_run.mp3', 'Carinosa', artist: 'TAD'),
  Song('tinikling.mp3', 'tinikling', artist: 'Spring Spring'),
];

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
