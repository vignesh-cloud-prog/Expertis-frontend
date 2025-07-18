import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/BMCommonCardModel.dart';
import '../utils/BMColors.dart';

class BMSingleImageScreen extends StatefulWidget {
  BMCommonCardModel element;

  BMSingleImageScreen({super.key, required this.element});

  @override
  _BMSingleImageScreenState createState() => _BMSingleImageScreenState();
}

class _BMSingleImageScreenState extends State<BMSingleImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.element.image),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {}, // fallback handled below
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: radius(100),
                color: context.cardColor,
              ),
              padding: const EdgeInsets.all(12),
              child: Image.asset('images/x.png',
                  height: 16, fit: BoxFit.cover, color: bmPrimaryColor),
            ).onTap(() {
              finish(context);
            }),
            Container(
              decoration: BoxDecoration(
                borderRadius: radius(100),
                color: context.cardColor,
              ),
              padding: const EdgeInsets.all(8),
              child: widget.element.liked!
                  ? const Icon(Icons.favorite, color: bmPrimaryColor)
                  : const Icon(Icons.favorite_outline, color: bmPrimaryColor),
            ).onTap(() {
              widget.element.liked = !widget.element.liked!;
              setState(() {});
            }, borderRadius: radius(100)),
          ],
        ),
      ),
    );
  }
}
