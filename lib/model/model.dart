class MediaItem {
  final String title;
  final String type;
  final String url;
  final String? thumbnailUrl;
  final String? artist;

  MediaItem({
    required this.title,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.artist,
  });
}
