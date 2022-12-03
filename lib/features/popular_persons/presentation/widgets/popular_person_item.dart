import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/core/API/end_points.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/pages/popular_person_details.dart';
import 'package:tmdb_app/features/popular_persons/domain/entities/popular_person_entity.dart';
import 'package:tmdb_app/shared/navigation.dart';
import 'package:tmdb_app/utilities/index.dart';

class PopularPersonItem extends StatelessWidget {
  final PopularPersonEntity? popularPerson;

  const PopularPersonItem({Key? key, required this.popularPerson})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(
          context,
          PopularPersonDetailsScreen(
            personId: popularPerson!.id??-1,
            name: popularPerson!.name??"",
          )),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: EndPoints.imageUrl(
                    "${popularPerson?.profilePath}"),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 0.5),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.center,
                stops: const [0, 1],
                end: Alignment.bottomCenter,
              ),
            ),
            margin: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  title: Text(
                    "${popularPerson?.name}",
                    style: customTextStyleTitle,
                  ),
                  subtitle: Text(
                    "${popularPerson?.knownForDepartment}",
                    style: customTextStyleSubtitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
