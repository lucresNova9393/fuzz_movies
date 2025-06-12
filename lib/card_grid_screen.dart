import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:popup_menu_plus/popup_menu_plus.dart';

import '../widgets/auto_refresh.dart';
import '../home1.dart';

class CardGridScreen extends StatefulWidget {
  const CardGridScreen({Key? key}) : super(key: key);

  @override
  State<CardGridScreen> createState() => _CardGridScreenState();
}

class _CardGridScreenState extends State<CardGridScreen> {
  PopupMenu? menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();
  GlobalKey btnKey4 = GlobalKey();
  GlobalKey btnKey5 = GlobalKey();

  void onClickMenu(PopUpMenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void onShow() {
    print('Menu is show');
  }
  @override
  Widget build(BuildContext context) {
    var columnCount = 3;

    return AutoRefresh(
      duration: const Duration(milliseconds: 30000),
      child: Scaffold(
        appBar: AppBar(

          title: GestureDetector(

              child: const Text("Fuzz Movies")),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.comment),
              tooltip: 'Comments',
              onPressed: () {},
            ), //IconButton
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search Movies',
              onPressed: () {},
            ), //IconButton
          ], //<Widget>[]
          backgroundColor: Colors.deepPurple,
          elevation: 50.0,
          leading: IconButton(
            key: btnKey4,
            icon: const Icon(Icons.menu),
            tooltip: 'Movie sections',
            onPressed: listMenu,
          ),
          // systemOverlayStyle: SystemUiOverlayStyle.light,
        ),

        body: SafeArea(
          child: Expanded(
            child: AnimationLimiter(
              child: GridView.count(
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: columnCount,
                children: List.generate(
                  36,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: columnCount,
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: const ScaleAnimation(
                        scale: 0.5,
                        child: FadeInAnimation(
                          child: Home1(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void listMenu() {
    PopupMenu menu = PopupMenu(
        context: context,
        config: MenuConfig.forList(
            border: BorderConfig(width: 2, color: Colors.black)),
        items: [
          // MenuItem.forList(
          //     title: 'Copy', image: Image.asset('assets/copy.png')),
          PopUpMenuItem.forList(
              title: 'Fuzz Holly',
              image:
              const Icon(Icons.home, color: Color(0xFF181818), size: 20)),
          PopUpMenuItem.forList(
              title: 'Fuzz Nolly',
              image:
              const Icon(Icons.mail, color: Color(0xFF181818), size: 20)),
          PopUpMenuItem.forList(
              title: 'Fuzz Bolly',
              image:
              const Icon(Icons.power, color: Color(0xFF181818), size: 20)),
          PopUpMenuItem.forList(
              title: 'Fuzz Others',
              image: const Icon(Icons.settings,
                  color: Color(0xFF181818), size: 20)),
          PopUpMenuItem.forList(
              title: 'Music',
              image: const Icon(Icons.music_note, color: Color(0xFF181818), size: 20)),
          PopUpMenuItem.forList(
              title: '18+',
              image: const Icon(Icons.no_adult_content, color: Color(0xFF181818), size: 20)),
        ],
        onClickMenu: onClickMenu,
        onShow: onShow,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey4);
  }
}

