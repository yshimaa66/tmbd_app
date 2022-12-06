import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/features/popular_person_image_view/presentation/bloc/popular_person_image_view_bloc.dart';
import 'package:tmdb_app/shared/toast.dart';

class PopularPersonImageViewScreen extends StatelessWidget {
  final String? imageUrl;

  PopularPersonImageViewScreen({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late PopularPersonImageViewBloc popularPersonImageViewBloc;
    return BlocProvider<PopularPersonImageViewBloc>(
      create: (context) => PopularPersonImageViewBloc()..add(Prepare()),
      child:
          BlocConsumer<PopularPersonImageViewBloc, PopularPersonImageViewState>(
              listener: (context, state) async {},
              builder: (context, state) {
                popularPersonImageViewBloc =
                    BlocProvider.of<PopularPersonImageViewBloc>(context);
                return Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          // if(state.photoDownloadProgress==-1) {
                          popularPersonImageViewBloc
                              .add(RequestDownload("${imageUrl}"));
                          // }else{
                          //   showToastMessage('Photo Downloading...', Colors.red);
                          // }
                        },
                        icon: const Icon(Icons.download),
                      ),
                    ],
                  ),
                  body: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      imageUrl: "${imageUrl}",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
    );
  }
}
