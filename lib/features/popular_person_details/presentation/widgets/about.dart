import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/popular_person_details_entity.dart';
import 'package:tmdb_app/features/popular_person_details/presentation/widgets/text_container.dart';

class AboutWidget extends StatelessWidget {
  final PopularPersonDetailsEntity popularPersonDetailsEntity;
  const AboutWidget({Key? key, required this.popularPersonDetailsEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (popularPersonDetailsEntity.name != null)
            ListTile(
              subtitle: Text("${popularPersonDetailsEntity.name}"),
              title: const Text("Name"),
            ),
          if (popularPersonDetailsEntity.name != null) const Divider(),
          if (popularPersonDetailsEntity.birthday != null)
            ListTile(
              subtitle: Text("${popularPersonDetailsEntity.birthday}"),
              title: const Text("Birthday"),
            ),
          if (popularPersonDetailsEntity.birthday != null) const Divider(),
          if (popularPersonDetailsEntity.placeOfBirth != null)
            ListTile(
              subtitle: Text("${popularPersonDetailsEntity.placeOfBirth}"),
              title: const Text("From/Address"),
            ),
          if (popularPersonDetailsEntity.placeOfBirth != null) const Divider(),
          if (popularPersonDetailsEntity.alsoKnownAs?.isNotEmpty == true)
            ListTile(
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: List.generate(
                    popularPersonDetailsEntity.alsoKnownAs?.length ?? 0,
                    (index) => CustomTextContainer(
                      text: "${popularPersonDetailsEntity.alsoKnownAs?[index]}",
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              title: const Text("Also Known As"),
            ),
          if (popularPersonDetailsEntity.alsoKnownAs?.isNotEmpty == true) const Divider(),
          if (popularPersonDetailsEntity.biography != null)
            ListTile(
              subtitle: ReadMoreText(
                "${popularPersonDetailsEntity.biography}",
                trimLines: 4,
                trimMode: TrimMode.Line,
                trimCollapsedText: '  READ MORE',
                trimExpandedText: '  READ LESS',
                moreStyle: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                ),
                lessStyle: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                  fontWeight: FontWeight.normal,
                ),
              ),
              title: const Text("Biography"),
            ),
        ],
      ),
    );
  }
}
