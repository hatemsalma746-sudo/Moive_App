import 'package:flutter/material.dart';
import 'package:moive_app/model/movies_list/movies.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/screen_utils.dart';

class MovieCard extends StatefulWidget {
  final Movies movie;

  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.moviesDetails,
          arguments: widget.movie.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                widget.movie.mediumCoverImage ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.greyColor,
                    child: Icon(
                      Icons.movie,
                      color: AppColors.whiteColor,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: height * 0.01,
              left: height * 0.01,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01,
                  vertical: height * 0.004,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blackColor2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: AppColors.yellowColor, size: 13),
                    SizedBox(width: 3),
                    Text(
                      widget.movie.rating?.toStringAsFixed(1) ?? '0.0',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
