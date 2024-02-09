import 'package:flutter/material.dart';
import 'package:into_movies/components/text_format.dart';

class Discovery extends StatelessWidget {
  final String title;
  final String imagePath;
  final String voteAverage;
  const Discovery({
    super.key,
    required this.title,
    required this.imagePath,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imagePath,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: PoppinsText(
              text: title,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.ellipsis,
              fontS: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              maxLines: 2,
            ),
          ),
          PoppinsText(
            text: 'Rating: $voteAverage',
            fontS: 14,
            fontWeight: FontWeight.w600,
            color: Colors.amber,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
