import 'package:flutter/material.dart';
import 'package:moive_app/model/movies_list/movies.dart';
import 'package:moive_app/services/movie_service.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/movie_card.dart';

class ExplorePage extends StatefulWidget {
  final String? selectedGenre;

  const ExplorePage({super.key, this.selectedGenre});

  @@override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Movies> movies = [];
  Set<String> genres = {};
  String? selectedGenre;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final result = await MovieService.fetchMovies();
      setState(() {
        movies = result;
        getAllGenres();
        if (widget.selectedGenre != null &&
            genres.contains(widget.selectedGenre)) {
          selectedGenre = widget.selectedGenre;
        } else if (genres.isNotEmpty) {
          selectedGenre = genres.first;
        }
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void getAllGenres() {
    genres.clear();
    for (final movie in movies) {
      genres.addAll(movie.genres ?? []);
    }
  }

  Future<void> selectGenre(String genre) async {
    setState(() {
      selectedGenre = genre;
      isLoading = true;
    });
    try {
      final result = await MovieService.fetchMovies(genre: genre);
      setState(() {
        movies = result;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final genreList = genres.toList();
    double width = context.width;
    double height = context.height;
    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.yellowColor,
          ),
        ),
      );
    }
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.06,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genreList.length,
              itemBuilder: (context, index) {
                final genre = genreList[index];
                final isSelected = selectedGenre == genre;
                return GestureDetector(
                  onTap: () {
                    selectGenre(genre);
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: width * 0.06,
                      right: width * 0.02,
                    ),

                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.01
                    ),
                    decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.yellowColor
                            : AppColors.blackColor,

                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.yellowColor)
                    ),
                    child: Center(
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.blackColor
                              : AppColors.yellowColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              padding:
              EdgeInsets.all(10),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount:
              movies.length,
              itemBuilder:
                  (context, index) {
                final movie =
                movies[index];
                return MovieCard(movie: movie);
              },
            ),
          ),
        ],
      ),
    );
  }
}