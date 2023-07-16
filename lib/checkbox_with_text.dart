import 'package:ephemeral_state_manager/ephemeral_state_manager.dart';
import 'package:flutter/material.dart';

class CheckBoxState {
  final String label;
  final ValueState<bool> status;
  const CheckBoxState({
    required this.label,
    required this.status,
  });
}

class CheckBoxWithText extends StatelessWidget {

  const CheckBoxWithText({
    super.key,
    required this.label, 
    required this.status,
    this.spaceBetween = 0.0,
    this.onChecked,
    this.onUnChecked,
    this.padding = const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
  });

  final String label;
  final double spaceBetween;
  final EdgeInsetsGeometry padding;
  final ValueState<bool> status;
  final void Function()? onChecked;
  final void Function()? onUnChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        status.value = !status.value;
        if (status.value) {
          onChecked?.call();
        } else {
          onUnChecked?.call();
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          StateSetterBuilder<bool>(
            valueStateSetter: status,
            builder: (context, isChecked) {
                return Checkbox(
                  value: isChecked, 
                  onChanged: (value){
                    status.value = value!;
                    if (value) {
                      onChecked?.call();
                    } else {
                      onUnChecked?.call();
                    }
                  }
                );
              }
            ),
            spaceBetween <= 0.0 
              ? const SizedBox.shrink() 
              : SizedBox(width: spaceBetween),
            Text(
              label,
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
