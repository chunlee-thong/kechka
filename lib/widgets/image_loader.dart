import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget loading;
  final Widget error;
  final double width;
  final double height;
  final double radius;
  const ImageLoader({
    Key key,
    @required this.imageUrl,
    this.fit = BoxFit.cover,
    this.loading,
    this.error,
    this.width,
    this.height,
    this.radius = 0.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: JinWidget.radius(),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width ?? null,
          height: height ?? null,
          fit: fit,
          errorWidget: (context, err, obj) {
            if (error != null) return error;
            return Icon(Icons.error_outline);
          },
          placeholder: (context, data) {
            if (loading != null) return loading;
            return JinWidget.platformLoadingWidget();
          },
        ),
      ),
    );
  }
}
