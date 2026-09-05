import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/services/movie_service.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_text_field.dart';

import '../../model/movies_list/movies.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String queryTerm = '';

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.045,
        ),
        child: Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                setState(() {
                  queryTerm = value ?? '';
                });
              },
              borderColor: AppColors.greyColor,
              filled: true,
              fillColor: AppColors.greyColor,
              hintText: AppLocalizations.of(context)!.search,
              hintStyle: AppStyles.login,
              preIcon: ImageIcon(
                AssetImage(AppImages.searchIcon),
                color: AppColors.whiteColor,
              ),
            ),

            SizedBox(height: height * 0.02),
            Expanded(
              child: queryTerm.isEmpty
                  ? Image.asset(AppImages.empty)
                  : FutureBuilder<List<Movies>>(
                future: MovieService.searchMoviesByQueryTerm(queryTerm),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellowColor,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final movies = snapshot.data ?? [];

                  if (movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'No movies found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: movies.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              movie.mediumCoverImage ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            top: height * 0.01,
                            left: width * 0.01,
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
                              children: [
                                Text(
                                  movie.rating?.toStringAsFixed(1) ?? '0',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Icon(
                                  Icons.star,
                                  color: AppColors.yellowColor,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
