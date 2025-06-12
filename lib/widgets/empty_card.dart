import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final double? width;
  final double? height;

  const EmptyCard({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      width: width,
      height: height,
      child: ListView(
        physics: ScrollPhysics(),
        children:[
          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),
            child: Container(
                width: width,
                height:height,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network('https://image.tmdb.org/t/p/w1280/ec50pMNyIshL0blt1q8dUEbIa2G.jpg'),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment:Alignment.center,child: Text('You re cordially invited. ',style: TextStyle(fontSize: h*.02),)),
              )),

            ],
          ),
        ]
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
    );
  }
}
