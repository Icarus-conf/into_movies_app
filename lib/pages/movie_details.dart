import 'package:flutter/material.dart';
import 'package:into_movies/components/text_format.dart';

import 'package:into_movies/model/movie_model.dart';
import 'package:into_movies/services/api_config.dart';

class MovieDetails extends StatelessWidget {
  static const String routeName = 'MovieDetails';
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: 600,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${ApiConfig.imageBaseUrl}${data.posterPath}'),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: PoppinsText(
                              text: data.title,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PoppinsText(
                            text:
                                'Rating: ${data.voteAverage.toInt().toString()}',
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(25),
              child: PoppinsText(text: data.overview),
            ),
          ],
        ),
      ),
    );
  }
}
