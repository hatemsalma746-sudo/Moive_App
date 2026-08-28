import 'package:flutter/material.dart';
import 'package:moive_app/model/movies_details/movie_details.dart';
import 'package:moive_app/services/details_model.dart';
import 'package:moive_app/services/suggestion_services.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/box_item_widget.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';

import '../model/moive_suggetion/movies.dart';

class MoviesDetails extends StatefulWidget {
  const MoviesDetails({super.key});

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  late int movieId;
  late Future<MovieDetails> movieDetails;
  late Future<List<Movies>> movieSuggestions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments;

    movieId = args as int;

    movieDetails = DetailsModel.getMovieDetails(movieId);
    movieSuggestions = SuggestionService.getMovieSuggestions(movieId);
  }

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    return Scaffold(
      body: FutureBuilder<MovieDetails>(
        future: movieDetails,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(movieId);
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.white),
              )
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Data'),
            );
          }
          final movie = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                Container(
                  height: height*0.81,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        movie.largeCoverImage ?? AppImages.imageNotFount,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: height*0.81,
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                      colors: [
                        AppColors.blackGradient,
                        AppColors.blackColor3,
                        AppColors.blackColor,
                      ]),),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width*0.03
                    ),
                      child: Column(
                        spacing: 20,
                        children: [
                          SizedBox(height: height*0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 30,
                                    color: AppColors.whiteColor,
                                  )
                              ),
                              IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(
                                    Icons.bookmark_border,
                                    size: 30,
                                    color: AppColors.whiteColor,
                                  )
                              )
                            ],
                          ),
                          Spacer(),
                          Image.asset(AppImages.playImage),
                          Spacer(),
                          Text(
                            movie.title ?? '',
                            style: AppStyles.headers,
                          ),
                          Text(
                            movie.year.toString(),
                            style: AppStyles.bold20grey,
                          ),
                          CustomElevatedButton(
                              onPressed: (){

                              },
                              backgroundColor: AppColors.redColor,
                              foregroundColor: AppColors.whiteColor,
                              text: 'Watch',
                              borderColor: AppColors.redColor,
                              textColor: AppColors.whiteColor
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height*0.02,
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width*0.03
                    ),
                    child: Column(
                      spacing: 15,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            BoxItemWidget(text: '20',icon: Icons.favorite,),
                            BoxItemWidget(text: '80',icon: Icons.access_time_filled,),
                            BoxItemWidget(text: '7.6',icon: Icons.star,),
                          ],
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(movie.largeScreenshotImage1!)),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(movie.largeScreenshotImage2!)),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(movie.largeScreenshotImage3!)),
                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Similar',
                            style: AppStyles.headers,
                          ),
                        ),

                        FutureBuilder<List<Movies>>(
                          future: movieSuggestions,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              SizedBox(height: height * 0.04);
                            }
                            final suggestions = snapshot.data ?? [];

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: suggestions.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                final suggestion = suggestions[index];

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.network(
                                          suggestion.mediumCoverImage ??
                                              suggestion.smallCoverImage ??
                                              AppImages.imageNotFount,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.01,
                                            vertical: height * 0.01,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Color(0xFFF6BD00),
                                                size: 16,
                                              ),
                                              SizedBox(width: width * 0.02),
                                              Text(
                                                suggestion.rating
                                                    ?.toStringAsFixed(1) ??
                                                    '0.0',
                                                style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: height * 0.04),
                        Align(alignment: Alignment.centerLeft,
                          child: Text(
                            'Summary', style: AppStyles.descriptions,),
                        ),
                        Align(alignment: Alignment.centerLeft,
                          child: Text(movie.descriptionFull ?? '',
                            style: AppStyles.login,),
                        ),
                        SizedBox(height: height * 0.04),
                        Align(alignment: Alignment.centerLeft,
                          child: Text('Cast', style: AppStyles.headers,),
                        ),
                        Column(
                          spacing: height * 0.01,
                          children: [
                            for (int i = 0; i < (movie.cast?.length ?? 0); i++)
                              Container(width: double.infinity,
                                margin:
                                EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.blackColor3,
                                  borderRadius: BorderRadius.circular(16),),
                                child: Row(children:
                                [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      movie.cast![i].urlSmallImage ??
                                          AppImages.imageNotFount,
                                      width: width * 0.22,
                                      height: height * 0.11,
                                      fit: BoxFit.cover, errorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(AppImages.ironMan,
                                        width: width * 0.22,
                                        height: height * 0.11,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(movie.cast![i].name ?? '',
                                        style: AppStyles.smallWhiteText,),
                                      SizedBox(height: height * 0.01),
                                      Text(movie.cast![i].characterName ?? '',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 14,),
                                      ),
                                    ],
                                  ),
                                  ),
                                ],
                                ),
                              ),
                          ],
                        ),
                        Align(alignment: Alignment.centerLeft,
                          child: Text('Genres', style: AppStyles.headers,),
                        ), Wrap(spacing: 10, runSpacing: 10, children:
                        [ for (final genre in (movie.genres ?? []))
                          Container(padding:
                          EdgeInsets.symmetric(
                            horizontal: width * 0.01, vertical: height * 0.01,
                          ),
                            decoration: BoxDecoration(
                              color: AppColors.blackColor3,
                              borderRadius: BorderRadius.circular(12),),
                            child: Text(genre,
                              style:
                              TextStyle(
                                color: AppColors.whiteColor, fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

          );
        },
      ),
    );
  }
}