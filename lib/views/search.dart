import 'package:flutter/material.dart';
import 'package:mynews/data/api_repository.dart';
import 'package:mynews/model/headline_model.dart';
import 'package:mynews/views/favorite.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<Headlines>? _searchResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            title: const Text('Search'),
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Politics, Sports, etc.',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _searchResults = getArticlesFromQuery(value);
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<Headlines>(
            future: _searchResults,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                    child: Text('Error: ${snapshot.error}'));
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      var newsCardTile = snapshot.data!.articles![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: NewsCardTile(
                          title: newsCardTile.title ?? '',
                          description: newsCardTile.description ?? '',
                          imageUrl: newsCardTile.urlToImage ?? '',
                        ),
                      );
                    },
                    childCount: snapshot.data?.totalResults?.toInt() ?? 0,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
