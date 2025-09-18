import 'package:flutter/material.dart';

/// Base class (abstract) for all content types
abstract class ContentItem {
  final String data;
  const ContentItem(this.data);

  Widget build(BuildContext context);
}

/// Text content implementation
class TextItem extends ContentItem {
  const TextItem(String data) : super(data);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: const TextStyle(fontSize: 16));
  }
}

/// Image content implementation
class ImageItem extends ContentItem {
  const ImageItem(String data) : super(data);

  @override
  Widget build(BuildContext context) {
    return Image.network(data);
  }
}

/// Example for adding a new type (Video)
class VideoItem extends ContentItem {
  const VideoItem(String data) : super(data);

  @override
  Widget build(BuildContext context) {
    // Replace with your preferred video player widget
    return Container(
      color: Colors.black,
      height: 200,
      alignment: Alignment.center,
      child: const Icon(Icons.play_arrow, color: Colors.white, size: 50),
    );
  }
}

/// Display widget for a list of content
class ContentDisplay extends StatelessWidget {
  final List<ContentItem> items;
  const ContentDisplay(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: items.map((item) => item.build(context)).toList());
  }
}
