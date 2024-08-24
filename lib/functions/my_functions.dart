import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyController extends GetxController with GetTickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> animations;
  var lengthContainer = 1.obs;
  var isAnimating = false.obs;
  var selectedColor = Colors.green.obs;
  var dropdownValue = 'Green'.obs;
  var currentSliderValue = 20.0.obs;
  var itemsInline = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  void _initializeControllers() {
    controllers = List.generate(
      lengthContainer.value,
          (_) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      ),
    );
    animations = controllers
        .map((controller) => Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    ))
        .toList();
  }

  void updateLengthContainer(String value) {
    handleTap();
    final int newLength = int.tryParse(value) ?? 1;
    lengthContainer.value = newLength;
    _initializeControllers();
  }

  void updateItemsInline(String value) {
    itemsInline.value = int.tryParse(value) ?? 1;
  }

  void updateColor(String color) {
    dropdownValue.value = color;
    switch (color) {
      case 'Red':
        selectedColor.value = Colors.red;
        break;
      case 'Blue':
        selectedColor.value = Colors.blue;
        break;
      case 'Green':
        selectedColor.value = Colors.green;
        break;
      case 'Purple':
        selectedColor.value = Colors.purple;
        break;
      default:
        selectedColor.value = Colors.blue;
    }
  }

  void updateSliderValue(double value) {
    currentSliderValue.value = value;
    handleTap();
  }

  Future<void> handleTap() async {
    if (isAnimating.value) return;
    isAnimating.value = true;

    for (int i = 0; i < controllers.length; i++) {
      await controllers[i].forward();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (animations.every((animation) => animation.value == 1.0)) {
      for (var controller in controllers) {
        controller.duration = const Duration(milliseconds: 100);
        await controller.reverse();
      }

      if (currentSliderValue.value < 30) {
        for (var controller in controllers) {
          controller.duration = const Duration(seconds: 1);
        }
      } else if (currentSliderValue.value > 30 &&
          currentSliderValue.value < 66) {
        for (var controller in controllers) {
          controller.duration = const Duration(seconds: 2);
        }
      } else if (currentSliderValue.value > 66) {
        for (var controller in controllers) {
          controller.duration = const Duration(seconds: 3);
        }
      }

      for (int i = 0; i < controllers.length; i++) {
        await controllers[i].forward();
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }

    isAnimating.value = false;

    handleTap();
  }

  void startInitialAnimation() {
    if (controllers.isEmpty) {
      _initializeControllers();
    }
    handleTap();
  }
}