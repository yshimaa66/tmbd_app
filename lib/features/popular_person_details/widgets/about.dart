import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tmdb_app/features/popular_person_details/data/models/popular_person_details.dart';
import 'package:tmdb_app/features/popular_persons/data/models/popular_person/popular_person.dart';
import 'package:tmdb_app/features/popular_person_details/widgets/text_container.dart';

class AboutWidget extends StatelessWidget {
  final PopularPersonDetails popularPersonDetails;
  const AboutWidget({Key? key, required this.popularPersonDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (popularPersonDetails.name != null)
            ListTile(
              subtitle: Text("${popularPersonDetails.name}"),
              title: const Text("Name"),
            ),
          if (popularPersonDetails.name != null) const Divider(),
          if (popularPersonDetails.birthday != null)
            ListTile(
              subtitle: Text("${popularPersonDetails.birthday}"),
              title: const Text("Birthday"),
            ),
          if (popularPersonDetails.birthday != null) const Divider(),
          if (popularPersonDetails.placeOfBirth != null)
            ListTile(
              subtitle: Text("${popularPersonDetails.placeOfBirth}"),
              title: const Text("From/Address"),
            ),
          if (popularPersonDetails.placeOfBirth != null) const Divider(),
          if (popularPersonDetails.alsoKnownAs?.isNotEmpty == true)
            ListTile(
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: List.generate(
                    popularPersonDetails.alsoKnownAs?.length ?? 0,
                    (index) => CustomTextContainer(
                      text: "${popularPersonDetails.alsoKnownAs?[index]}",
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              title: const Text("Also Known As"),
            ),
          if (popularPersonDetails.alsoKnownAs?.isNotEmpty == true) const Divider(),
          if (popularPersonDetails.biography != null)
            ListTile(
              subtitle: ReadMoreText(
                "${popularPersonDetails.biography}",
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
