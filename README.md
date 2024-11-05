# flutter_androssy_kits

Collection of androssy_widgets with advanced styling and customization.

#### INIT INSTANCE
```dart
void main() {
  Androssy.init(
    cachedNetworkImageBuilder: (context, config) {
      return CachedNetworkImage(imageUrl: config.imageUrl);
    },
    svgImageBuilder: (context, config) {
      switch (config.source) {
        case AndrossyContentSource.asset:
          return SvgPicture.asset(config.assetName);
        case AndrossyContentSource.file:
          return SvgPicture.file(config.file);
        case AndrossyContentSource.memory:
          return SvgPicture.memory(config.bytes);
        case AndrossyContentSource.network:
          return SvgPicture.network(config.url);
        case AndrossyContentSource.string:
          return SvgPicture.string(config.string);
      }
    },
  );
  // ...
}
```