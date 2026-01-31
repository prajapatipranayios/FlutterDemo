import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator_master/palette_generator_master.dart';

class MemeCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int ups;
  final String postLink;
  final Function(Color) onColorExtrected;

  const MemeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.ups,
    required this.postLink,
    required this.onColorExtrected,
  });

  @override
  State<StatefulWidget> createState() => _MemeCardState();
}


class _MemeCardState extends State<MemeCard> {
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    extractColor();
  }

  Future<void> extractColor() async {
    final paletteGenerator = await PaletteGeneratorMaster.fromImageProvider(
      CachedNetworkImageProvider(widget.imageUrl),
    );

    setState(() {
      backgroundColor = paletteGenerator.dominantColor?.color ?? Colors.white;
    });
    widget.onColorExtrected(backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor.withOpacity(0.8),
              backgroundColor.withOpacity(0.4),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),

              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ups: ${widget.ups}',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),

                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Link ${widget.postLink}')),
                      );
                    },
                    child: Text('View Post', style: TextStyle(
                      color: Colors.deepPurple,
                    ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
