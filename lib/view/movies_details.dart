import 'package:flutter/material.dart';
import 'package:moive_app/model/movies_details/movie_details.dart';
import 'package:moive_app/services/details_model.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/box_item_widget.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';

class MoviesDetails extends StatefulWidget {
  const MoviesDetails({super.key});

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  late int movieId;
  late Future<MovieDetails> movieDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments;

    movieId = args as int;

    movieDetails = DetailsModel.getMovieDetails(movieId);
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
              ),
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