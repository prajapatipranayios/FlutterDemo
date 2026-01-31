
import 'package:api_app/models/meme_model.dart';
import 'package:api_app/services/meme_service.dart';
import 'package:api_app/widgets/meme_card.dart';
import 'package:flutter/material.dart';

class MemeHomePage extends StatefulWidget {
  const MemeHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MemeHomePageState();
}

class _MemeHomePageState extends State<MemeHomePage> {
  List<Meme> memes = [];
  bool isLoading = true;
  Color backgroundColor = Colors.deepPurple;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMemes();
  }

  Future<void> fetchMemes() async {
    final fetchMemes = await MemeService.fetchMemes(context);
    setState(() {
      memes = fetchMemes ?? [];
      isLoading = false;
    });
  }

  void updatedBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Meme App'),
        centerTitle: true,
        backgroundColor: backgroundColor.withOpacity(0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                backgroundColor.withOpacity(0.8),
                backgroundColor.withOpacity(0.4),
              ],
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator(),)
            : memes.isEmpty
              ? Center(child: Text('No Memes found'),)
              : ListView.builder(
                  itemCount: memes.length,
                  itemBuilder: (context, index) {
                    final meme = memes[index];
                    return MemeCard(
                      title: meme.title,
                      imageUrl: meme.url,
                      ups: meme.ups,
                      postLink: meme.postLink,
                      // onColorExtrected: (col) {
                      //   updatedBackgroundColor()
                      // },
                      onColorExtrected: updatedBackgroundColor,
                    );
                  }
                )
        ,
      ),
    );
  }
}