import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:into_movies/components/text_format.dart';
import 'package:into_movies/model/movie_model.dart';
import 'package:into_movies/pages/movie_details.dart';
import 'package:into_movies/services/api_config.dart';
import 'package:into_movies/services/api_service.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  late Future<List<Movie>> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Image.network(
                      '${ApiConfig.imageBaseUrl}${snapshot.data![_current].posterPath}',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.grey.shade50.withOpacity(1),
                              Colors.grey.shade50.withOpacity(1),
                              Colors.grey.shade50.withOpacity(1),
                              Colors.grey.shade50.withOpacity(1),
                              Colors.grey.shade50.withOpacity(0.0),
                              Colors.grey.shade50.withOpacity(0.0),
                              Colors.grey.shade50.withOpacity(0.0),
                              Colors.grey.shade50.withOpacity(0.0),
                            ])),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 500.0,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.70,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        carouselController: _carouselController,
                        items: snapshot.data!.map((movie) {
                          var data = snapshot.data![_current];
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MovieDetails.routeName,
                                    arguments: data,
                                  );
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 320,
                                            width: 250,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Image.network(
                                              '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: 200,
                                            child: PoppinsText(
                                              text: data.title,
                                              fontS: 18,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          // rating
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: 200,
                                            child: PoppinsText(
                                              text: data.overview,
                                              color: Colors.grey[500],
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            opacity: _current ==
                                                    snapshot.data!
                                                        .indexOf(movie)
                                                ? 1.0
                                                : 0.0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: SizedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      data.voteAverage
                                                          .toInt()
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors
                                                              .grey.shade600),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: SpinKitSquareCircle(
                color: Colors.blueGrey,
              ),
            );
          }),
    );
  }
}
