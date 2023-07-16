import 'package:flutter/material.dart';

import './custom_scaffod_appbar.dart';

class Events extends StatelessWidget {
  const Events({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffodAppBar(
      body: (scrollController){
        return Expanded(
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
        );
      }
    );
  }
}
