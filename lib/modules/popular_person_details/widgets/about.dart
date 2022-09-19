import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tmdb_app/models/popular_person/popular_person.dart';
import 'package:tmdb_app/modules/popular_person_details/widgets/text_container.dart';

class AboutWidget extends StatelessWidget {
  final PopularPerson popularPerson;
  const AboutWidget({Key? key, required this.popularPerson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (popularPerson.name != null)
            ListTile(
              subtitle: Text("${popularPerson.name}"),
              title: const Text("Name"),
            ),
          if (popularPerson.name != null) const Divider(),
          if (popularPerson.birthday != null)
            ListTile(
              subtitle: Text("${popularPerson.birthday}"),
              title: const Text("Birthday"),
            ),
          if (popularPerson.birthday != null) const Divider(),
          if (popularPerson.placeOfBirth != null)
            ListTile(
              subtitle: Text("${popularPerson.placeOfBirth}"),
              title: const Text("From/Address"),
            ),
          if (popularPerson.placeOfBirth != null) const Divider(),
          if (popularPerson.alsoKnownAs?.isNotEmpty == true)
            ListTile(
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: List.generate(
                    popularPerson.alsoKnownAs?.length ?? 0,
                    (index) => CustomTextContainer(
                      text: "${popularPerson.alsoKnownAs?[index]}",
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              title: const Text("Also Known As"),
            ),
          if (popularPerson.alsoKnownAs?.isNotEmpty == true) const Divider(),
          if (popularPerson.biography != null)
            ListTile(
              subtitle: ReadMoreText(
                "${popularPerson.biography}",
                trimLines: 4,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: '  READ MORE',
                trimExpandedText: '  READ LESS',
                moreStyle: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                ),
                lessStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.redAccent,
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
