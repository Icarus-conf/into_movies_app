import 'package:flutter/material.dart';
import 'package:into_movies/components/text_format.dart';
import 'package:into_movies/model/movie_model.dart';
import 'package:into_movies/services/api_config.dart';
import 'package:into_movies/services/api_service.dart';
import 'package:into_movies/widgets/discovery.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212529),
        title: const PoppinsText(
          text: 'IntoMovies',
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: PoppinsText(
                      text: 'Discovery',
                      fontS: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Discovery(
                          imagePath:
                              '${ApiConfig.imageBaseUrl}${snapshot.data![index].posterPath}',
                          title: snapshot.data![index].title,
                          voteAverage: snapshot.data![index].voteAverage
                              .toInt()
                              .toString(),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

// Image.network('${ApiConfig.imageBaseUrl}${snapshot.data![index].posterPath}');
