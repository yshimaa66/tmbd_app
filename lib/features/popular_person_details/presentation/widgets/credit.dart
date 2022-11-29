import 'package:flutter/material.dart';
import 'package:tmdb_app/features/popular_person_details/domain/entities/cast_entity.dart';
import 'credit_cast.dart';

class CreditWidget extends StatelessWidget {
  final List<CastEntity>? castsEntity;
  const CreditWidget({Key? key, required this.castsEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return castsEntity!.isNotEmpty?
    GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => CreditCastWidget(castEntity: castsEntity?[index]),
        childCount: castsEntity?.length ?? 0,
      ),
    ):const Center(
      child: Text("Nothing Found",
        style: TextStyle(color: Colors.grey,fontSize: 12),),
    );
  }
}
