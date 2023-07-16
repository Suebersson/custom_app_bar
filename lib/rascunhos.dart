import 'package:flutter/material.dart';

class CheckBoxWithText extends StatefulWidget {
    const CheckBoxWithText({
      super.key,
      required this.label, 
      this.padding = const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
    });

    final String label;
    final EdgeInsetsGeometry padding;

  @override
  State<CheckBoxWithText> createState() => _CheckBoxWithTextState();
}

class _CheckBoxWithTextState extends State<CheckBoxWithText> {
  
  bool statusCheckBox = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          statusCheckBox = !statusCheckBox;
        });
      },
      child: Padding(
        padding: widget.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: statusCheckBox, 
              onChanged: (value){
                setState(() {
                  statusCheckBox = !statusCheckBox;
                });
              }
            ),
            // CupertinoCheckbox(
            //   value: statusCheckBox,
            //   activeColor: Colors.deepPurpleAccent,
            //   checkColor: Colors.teal,
            //   inactiveColor: Colors.deepPurpleAccent,
            //   onChanged: (value){
            //     setState(() {
            //       statusCheckBox = !statusCheckBox;
            //     });
            //   }
            // ),
            // const SizedBox(width: 4.0),
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}








// Visibility(
//   visible: appBarController.appBarIsOpen,
//   replacement: const SizedBox.shrink(),
//   child: SingleChildScrollView(
//     physics: const BouncingScrollPhysics(),
//     scrollDirection: Axis.vertical,
//     child: ColoredBox(
//       color: Colors.teal,
//       child: SizedBox(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Wrap(
//               spacing: 5.0,
//               runSpacing: 1.0,
//               children: List.generate(eventType.length, (i) {
//                 print('CheckBoxWithText');
//                 return CheckBoxWithText(
//                   label: eventType[i], 
//                   status: appBarController.checkBoxs[i].status,
//                 );
//               }),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   FilledButton(
//                     onPressed: (){
//                       // Chamar a CupertinoModalpopup
//                     }, 
//                     child: Text(
//                       'Filtrar',
//                       style: theme.appBarTheme.titleTextStyle?.copyWith(
//                         fontSize: 20.0
//                       )
//                     )
//                   ),
//                   FilledButton(
//                     onPressed: appBarController.cleanFilter, 
//                     child: Text(
//                       'Limpar',
//                       style: theme.appBarTheme.titleTextStyle?.copyWith(
//                         fontSize: 20.0
//                       )
//                     )
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   ),
// ),



/*
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
      scrollController.animateTo(
        0.5, 
        duration: const Duration(milliseconds: 200), 
        curve: Curves.ease
      );
      scrollController.animateTo(
        0.0, 
        duration: const Duration(milliseconds: 200), 
        curve: Curves.ease
      );

      scrollController.addListener(() {
        
        _currentScrollIndex = scrollController.offset;
        // print('ScrollPosition is: $_currentScrollIndex');//type is double

          if (scrollController.position.userScrollDirection == ScrollDirection.forward) {//down
            if (!appBarIsOpen) {
              // print('opening');
              appBarIsOpen = true;
              animationHeight.value = kToolbarHeight;// + Constants.paddingTop!;
            }
          } else {//up
            if (appBarIsOpen) {
              // print('closing');
              appBarIsOpen = false;
              animationHeight.value = 0.0;//Constants.paddingTop!;
            }
          }

      });


    });


*/


  // final ValueState<double> animationHeight = ValueState(
  //   appBarIsOpen 
  //     ? appBarController.appBarSize + Constants.paddingTop! 
  //     : Constants.paddingTop!
  // );
          // StateSetterBuilder<double>(
          //   valueStateSetter: animationHeight,
          //   builder: (context, height) {






                  // newScrollIndex = scrollController.offset;

      // if (newScrollIndex < _currentScrollIndex) {//down
      //   if (!appBarIsOpen) {
      //     // print('opening');
      //     appBarIsOpen = true;
      //     animationHeight.value = kToolbarHeight;// + Constants.paddingTop!;
      //   }
      // } else {//up
      //   if (appBarIsOpen) {
      //     // print('closing');
      //     appBarIsOpen = false;
      //     animationHeight.value = 0.0;//Constants.paddingTop!;
      //   }
      // }

      // _currentScrollIndex = newScrollIndex;






      /*

  Future<void> upDateAppBar() async{
    if (scrollController.position.userScrollDirection == ScrollDirection.forward) {//down
      if (!appBarController.appBarIsOpen) {
        // print('opening');
        appBarController.appBarIsOpen = true;
        animationHeight.value = appBarController.appBarSize;// + Constants.paddingTop!;
      }
    } else {//up
      if (appBarController.appBarIsOpen) {
        // print('closing');
        appBarController.appBarIsOpen = false;
        animationHeight.value = 0.0;//Constants.paddingTop!;
      }
    }
  }

      */




                // ValueListenableBuilder<double>(
          //   valueListenable: animationHeight,
          //   builder: (context, height, snapshot) {

              // final ValueNotifier<double> animationHeight = ValueNotifier(
  //   appBarIsOpen ? appBarController.appBarSize : 0.0
  // );