import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 500,
          color: Colors.red,
          child: EasyStepper(
            direction: Axis.horizontal,
            activeStep: activeStep,
            showStepBorder: false,
            borderThickness: 0,
            padding: const EdgeInsets.all(0),
            internalPadding: 0,
            stepRadius: 25,
            finishedStepBorderColor: Colors.white,
            finishedStepTextColor: Colors.white,
            finishedStepBackgroundColor: Colors.green,
            activeStepIconColor: Colors.green,
            showLoadingAnimation: false,
            steps: [
              EasyStep(
                customStep: CircleAvatar(
                  backgroundColor:
                      activeStep >= 0 ? AppColors.kPrimary : Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    color:
                        activeStep >= 0 ? AppColors.kWhite : AppColors.kPrimary,
                  ),
                ),
                title: 'Cart',
              ),
              EasyStep(
                customStep: CircleAvatar(
                  backgroundColor:
                      activeStep >= 1 ? AppColors.kPrimary : AppColors.kWhite,
                  child: Icon(
                    Icons.check,
                    color:
                        activeStep >= 1 ? AppColors.kWhite : AppColors.kPrimary,
                  ),
                ),
                title: 'Delivery',
              ),
              EasyStep(
                customStep: CircleAvatar(
                  backgroundColor:
                      activeStep >= 2 ? AppColors.kPrimary : AppColors.kWhite,
                  child: Icon(
                    Icons.check,
                    color:
                        activeStep >= 2 ? AppColors.kWhite : AppColors.kPrimary,
                  ),
                ),
                title: 'Completed',
              ),
            ],
            onStepReached: (index) => setState(() => activeStep = index),
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static const Color kWhite = Colors.white;
  static const Color kPrimary = Colors.green;
}
