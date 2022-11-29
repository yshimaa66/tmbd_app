import 'package:flutter/material.dart';
import 'credit_cast.dart';

class CreditWidget extends StatelessWidget {
  final List<dynamic>? casts;
  const CreditWidget({Key? key, required this.casts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return casts!.isNotEmpty?
    GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => CreditCastWidget(casts: casts?[index]),
        childCount: casts?.length ?? 0,
      ),
    ):const Center(
      child: Text("Nothing Found",
        style: TextStyle(color: Colors.grey,fontSize: 12),),
    );
  }
}
