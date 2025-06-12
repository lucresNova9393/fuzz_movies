import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

class Tile extends StatelessWidget {
  final String title;
  final _movieStream = Supabase.instance.client.from('fuzz_holly').stream( ['id']).order('id', ascending: false).execute();

   Tile(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      StreamBuilder<List<Map<String,dynamic>>>(
        stream: _movieStream,
        builder: (context, snapshot) {
          final movies = snapshot.data!;
          return DynamicHeightGridView(
            builder: (BuildContext context, int index) { 
              return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          Colors.primaries[Random().nextInt(Colors.primaries.length)],
                        ],
                      )));
            },
            itemCount: movies.length,
            crossAxisCount: 5,
          );
        }
      ),
      Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.end,
                )
              ])),
    ]);
  }
}
