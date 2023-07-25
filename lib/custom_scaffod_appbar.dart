import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/rendering.dart' show ScrollDirection;

import 'package:ephemeral_state_manager/ephemeral_state_manager.dart';
import 'package:shared_widgets/shared_widgets.dart';

import './checkbox_with_text.dart';

class CustomScaffodAppBar extends StatefulWidget {
  const CustomScaffodAppBar({
    super.key,
    required this.body,
  }); 

  final Widget Function(ScrollController) body;

  @override
  State<CustomScaffodAppBar> createState() => _CustomScaffodAppBarState();
}

// double _currentScrollIndex = 0.0;

class _CustomScaffodAppBarState extends State<CustomScaffodAppBar> {

  final ScrollController scrollController = ScrollController(initialScrollOffset: 0.0);

  late final ValueState<double> animationHeight;

  final double appBarHeight = kToolbarHeight;//56.0;
  bool appBarIsOpen = true;
  
  bool filterFrameisOpen = false;
  double filterFrameHeight = 0.0;

  final List<CheckBoxState> checkBoxs = List.generate(eventType.length, (i) {
    return CheckBoxState(
      label: eventType[i], 
      status: ValueState<bool>(false)
    );
  });

  void cleanFilter(){
    for(CheckBoxState checkBoxState in checkBoxs ){
      if(checkBoxState.status.value){
        checkBoxState.status.value = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    animationHeight = ValueState(
      appBarIsOpen 
      ? appBarHeight
      : 0.0
    );

    scrollController.addListener(() {

      // _currentScrollIndex = scrollController.offset;
      //// print('ScrollPosition is: $_currentScrollIndex');//type is double
  
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {//down
        if (!appBarIsOpen) {
          // print('opening');
          appBarIsOpen = true;
          animationHeight.value = filterFrameisOpen 
            ? appBarHeight + filterFrameHeight
            : appBarHeight;
        }
      } else {//up
        if (appBarIsOpen) {
          // print('closing');
          appBarIsOpen = false;
          animationHeight.value = 0.0;
        }
      }

    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          StatusBarSpacer(
            color: theme.appBarTheme.backgroundColor 
          ),
          StateSetterBuilder<double>(
            valueStateSetter: animationHeight,
            builder: (context, height) {
              return AnimatedContainer(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 400),
                curve: Curves.linear,
                width: double.infinity,
                height: height,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ColoredBox(
                        color: theme.appBarTheme.backgroundColor!,
                        child: SizedBox(
                          height: appBarHeight,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Capoeirando',
                                  style: theme.appBarTheme.titleTextStyle
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      tooltip: 'Adicionar evento',
                                      splashColor: Colors.transparent,
                                      onPressed: (){

                                      },
                                      icon: const Icon(CupertinoIcons.add)
                                    ),
                                    const SizedBox(width: 10.0),
                                    IconButton(
                                      tooltip: 'Criar live',
                                      splashColor: Colors.transparent,
                                      onPressed: (){

                                      }, 
                                      icon: const Icon(CupertinoIcons.dot_radiowaves_left_right),
                                    ),
                                    const SizedBox(width: 10.0),
                                    AnimatedIconBuilder(
                                      tooltip: 'Filtrar eventos',
                                      icon: const Icon(CupertinoIcons.search),
                                      trasitionIcon: const Icon(CupertinoIcons.clear),
                                      //CupertinoIcons.search
                                      //CupertinoIcons.chevron_down
                                      //CupertinoIcons.line_horizontal_3_decrease
                                      splashColor: Colors.transparent,
                                      onPressed: (value){
                                        if (filterFrameisOpen) {
                                          animationHeight.value = appBarHeight;
                                          filterFrameisOpen = false;
                                        } else {
                                          animationHeight.value = 
                                            appBarHeight + filterFrameHeight;
                                          filterFrameisOpen = true;
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      WidgetSizeAfterRender(
                        afterRendering: (size){
                          filterFrameHeight = size.height;
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: ColoredBox(
                            color: theme.primaryColor,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Wrap(
                                    spacing: 5.0,
                                    runSpacing: 1.0,
                                    children: List<Widget>.generate(eventType.length, (i) {
                                      return CheckBoxWithText(
                                        label: eventType[i], 
                                        status: checkBoxs[i].status,
                                      );
                                    }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FilledButton(
                                          onPressed: (){
                                            // Chamar a CupertinoModalpopup
                                          }, 
                                          child: Text(
                                            'Filtrar',
                                            style: theme.appBarTheme.titleTextStyle?.copyWith(
                                              fontSize: 20.0
                                            )
                                          )
                                        ),
                                        FilledButton(
                                          onPressed: cleanFilter, 
                                          child: Text(
                                            'Limpar',
                                            style: theme.appBarTheme.titleTextStyle?.copyWith(
                                              fontSize: 20.0
                                            )
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            }
          ),

          widget.body(scrollController),

        ],
      ),
    );
  }

}

final List<String> eventType = List.unmodifiable([
    'Roda',
    'Roda de papoeira',
    'Curso',
    'Jogos',
    'Sarau',
    'Aulão',
    'Aulão online',
    'Podcast',
    'Palestra',
    'Festival',
    'Simpósio',
    'Workshop',
    'Batizado e troca de cordas',
    'Apresentação',
    'Jongo',
    'Samba de roda',
  ]);

