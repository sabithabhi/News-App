import 'package:flutter/material.dart';
import 'package:mynews/data/api_repository.dart';
import 'package:mynews/views/news.dart';

class CategoryNews extends StatelessWidget {
  final String title;
  const CategoryNews({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
            future: getArticlesFromQuery(title),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var newsCardTile = snapshot.data!.articles![index];
                    return NewsCardTile(
                      content: newsCardTile.content ?? '',
                      title: newsCardTile.title ?? '',
                      description: newsCardTile.description ?? '',
                      imageUrl: newsCardTile.urlToImage ?? '',
                    );
                  },
                );
              }
            },
          ),
        )),
      ),
    );
  }
}

class NewsCardTile extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  const NewsCardTile({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => News(
              title: title,
              description: content,
              imageUrl: imageUrl,
            ),
          ),
        ),
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl,
                  height: 100, width: 100, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                );
              }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
