# flutter_androssy_kits

Collection of androssy_widgets with advanced styling and customization.

#### INIT INSTANCE
```dart
void main() {
  Androssy.init(
    textConverter: (context, value) {
      return "This is translated value [$value]";
    },
    cachedNetworkImageBuilder: (context, config) {
      return CachedNetworkImage(imageUrl: config.imageUrl);
    },
    svgBuilder: (context, config) {
      switch (config.source) {
        case AndrossySvgSource.asset:
          return SvgPicture.asset(config.assetName);
        case AndrossySvgSource.file:
          return SvgPicture.file(config.file);
        case AndrossySvgSource.memory:
          return SvgPicture.memory(config.bytes);
        case AndrossySvgSource.network:
          return SvgPicture.network(config.url);
        case AndrossySvgSource.string:
          return SvgPicture.string(config.string);
      }
    },
  );
  // ...
}
```