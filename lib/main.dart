import 'package:flutter/material.dart';

import './events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData.light();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,

        appBarTheme: themeData.appBarTheme.copyWith(

          elevation: 0,        

          titleTextStyle: const TextStyle(
            color: Colors.white, 
            fontSize: 25, 
          ),
          
          backgroundColor: Colors.deepPurpleAccent, /// [Colors.red];,

          iconTheme: themeData.iconTheme.copyWith(
            color: Colors.white,
            size: 25.0
          ),

          actionsIconTheme: themeData.iconTheme.copyWith(
              color: Colors.white,
              size: 25.0
          ),
        ),

        buttonTheme: themeData.buttonTheme.copyWith(
          buttonColor: Colors.deepPurpleAccent,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        ),

        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent),
            alignment: Alignment.center
          )
        ),

        iconTheme: themeData.iconTheme.copyWith(
          color: Colors.white,
          size: 25.0
        ),

        // Funciona apenas se usar a Material 3
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(Colors.white),
            iconSize: MaterialStatePropertyAll(25.0),
            overlayColor: MaterialStatePropertyAll(Colors.transparent),//é semelhante a uma splashColor
            // backgroundColor: MaterialStatePropertyAll(Colors.red),
          )
        ),

        scaffoldBackgroundColor: Colors.white, 
        primaryColor: Colors.teal,
        splashColor: Colors.amber,

        checkboxTheme: CheckboxThemeData(
          checkColor: const MaterialStatePropertyAll(Colors.teal),
          fillColor: const MaterialStatePropertyAll(Colors.deepPurpleAccent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),

      ),
      home: const Events(),
    );
  }
}













/*

class Events extends StatefulWidget {
  const Events({super.key});
  @override
  State<Events> createState() => _EventsState();
}


double _currentScrollIndex = 0.0;

class _EventsState extends State<Events> {

  final ScrollController scrollController = ScrollController(initialScrollOffset: _currentScrollIndex);

  final AppBarController appBarController  = AppBarController();

  late final ValueState<double> animationHeight;

  @override
  void initState() {
    super.initState();

    animationHeight = ValueState(
      appBarController.appBarIsOpen 
      ? appBarController.appBarHeight
      : 0.0
    );

    scrollController.addListener(() {

      _currentScrollIndex = scrollController.offset;
      //// print('ScrollPosition is: $_currentScrollIndex');//type is double
  
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {//down
        if (!appBarController.appBarIsOpen) {
          // print('opening');
          appBarController.appBarIsOpen = true;
          animationHeight.value = appBarController.filterFrameisOpen 
            ? appBarController.appBarHeight + appBarController.filterFrameHeight
            : appBarController.appBarHeight;
        }
      } else {//up
        if (appBarController.appBarIsOpen) {
          // print('closing');
          appBarController.appBarIsOpen = false;
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
          SpacerPaddingTop(
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
                          height: appBarController.appBarHeight,
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
                                        if (appBarController.filterFrameisOpen) {
                                          animationHeight.value = appBarController.appBarHeight;
                                          appBarController.filterFrameisOpen = false;
                                        } else {
                                          animationHeight.value = 
                                            appBarController.appBarHeight + appBarController.filterFrameHeight;
                                          appBarController.filterFrameisOpen = true;
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
                          appBarController.filterFrameHeight = size.height;
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
                                        status: appBarController.checkBoxs[i].status,
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
                                          onPressed: appBarController.cleanFilter, 
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

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0.1, bottom: 15.0),
              controller: scrollController,
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 100,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index){
                return Container(
                  alignment: Alignment.center,
                  height: 300.0,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.brown[400],
                    borderRadius: BorderRadius.circular(8.0),
                    border: const Border(
                      top: BorderSide(width: 2.0, color: Colors.redAccent),
                      left: BorderSide(width: 2.0, color: Colors.redAccent),
                      right: BorderSide(width: 2.0, color: Colors.redAccent),
                      bottom: BorderSide(width: 2.0, color: Colors.redAccent),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Event: $index', style: const TextStyle(fontSize: 25.0),),
                      const SizedBox(height: 20.0),
                      const FlutterLogo(size: 100.0),
                    ],
                  ),
                );
              }
            ),
          ),
              
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



class AppBarController{

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

}

// Created by `Suebersson Montalvão` - 14/07/2023
// Upgraded 14/07/2023

/// Obter a o tamanho de uma [Widget] após a renderizeção
class WidgetSizeAfterRender extends StatefulWidget {
  const WidgetSizeAfterRender({
    super.key,
    required this.child,
    required this.afterRendering
  });

  final Widget child;
  final Function(Size) afterRendering;

  @override
  State<WidgetSizeAfterRender> createState() => _WidgetSizeAfterRenderState();
}

class _WidgetSizeAfterRenderState extends State<WidgetSizeAfterRender> {
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.afterRendering(context.size ?? const Size(0.0, 0.0));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
*/