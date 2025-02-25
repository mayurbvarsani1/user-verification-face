
import 'package:image_task/image_task.dart';

class AppButton extends StatelessWidget {
  final String buttonName;
  final Color? textColor;
  final double buttonHeight;
  final double? buttonWidth;
  final double? fontSize;
  final double borderRadius;
  final Color? borderColor;
  final VoidCallback? onButtonTap;
  FontWeight? fontWeight;
  Color? buttonColor;

  AppButton({
    Key? key,
    required this.buttonName,
    this.textColor =Colors.black,
    this.buttonHeight = 42,
    this.buttonWidth,
    this.onButtonTap,
    this.fontSize = 18,
    this.borderRadius = 30,
    this.borderColor ,
    this.fontWeight = FontWeight.bold,
    this.buttonColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onButtonTap,
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          duration: 200.milliseconds,
          height: buttonHeight,
          width: buttonWidth ?? Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: borderColor != null ? Border.all(color: borderColor ?? Colors.black):null,
              borderRadius: BorderRadius.circular(borderRadius),
              color: buttonColor
          ),
          child: Text(
            buttonName,textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSize,fontWeight: fontWeight,color: textColor),
          ),
        ),
      ),
    );
  }
}












