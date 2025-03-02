import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_with_provider_practice/utils/utils.dart';
import 'package:rest_api_with_provider_practice/view_model/home_view_model.dart';
import 'package:rest_api_with_provider_practice/view_model/user_view_model.dart';

import '../data/response/status.dart';
import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Movies",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              userPreference.removeUser().then((value) {
                Navigator.pushReplacementNamed(context, RoutesName.login);
              });
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => homeViewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, values, _) {
              switch (values.moviesList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator(),);
                case Status.SUCCESS:
                  if (values.moviesList.data == null || values.moviesList.data!.movies == null) {
                    return const Center(child: Text("No Movies Available"));
                  }
                  return ListView.builder(
                    itemCount: values.moviesList.data!.movies!.length,
                    itemBuilder: (context, index) {
                      final movie = values.moviesList.data!.movies![index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            movie.posterurl.toString(),
                            errorBuilder: (context, error, stack) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                child: const Icon(Icons.error, size: 40, color: Colors.deepPurpleAccent,),
                              );
                            },
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            movie.title ?? "No Title",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(movie.year ?? "Unknown Year"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.avgRatingCalculate(movie.ratings!).toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.star, color: Colors.amber,),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                case Status.ERROR:
                  return Center(child: Text(values.moviesList.message.toString()),);
                default:
                  return const Center(child: Text("Something went wrong"),);
              }
            },
          ),
        ),
      ),
    );
  }
}
