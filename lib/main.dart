import 'package:animation_application/widgets/rectangle_clipper.dart';
import 'package:animation_application/widgets/textfiled_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'functions/my_functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}



class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyFunctions controller = Get.put(MyFunctions());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startInitialAnimation();
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/images/image.jpg'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => SizedBox(
                          width: double.infinity,
                          child: DropdownButtonFormField<String>(
                            value: controller.dropdownValue.value,
                            onChanged: (String? value) {
                              if (value != null) {
                                controller.updateColor(value);
                              }
                            },
                            items: ['Red', 'Blue', 'Green', 'Purple']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ),
                        )),
                    Obx(() => Slider(
                          activeColor: controller.selectedColor.value,
                          thumbColor: controller.selectedColor.value,
                          value: controller.currentSliderValue.value,
                          max: 100,
                          divisions: 5,
                          label: controller.currentSliderValue.value
                              .round()
                              .toString(),
                          onChanged: controller.updateSliderValue,
                        )),
                    const SizedBox(height: 10),
                    Obx(() => TextfiledWidget(
                          onChanged: controller.updateLengthContainer,
                          selectedColor: controller.selectedColor.value,
                          hintText: "Total Items",
                        )),
                    const SizedBox(height: 10),
                    Obx(() => TextfiledWidget(
                          selectedColor: controller.selectedColor.value,
                          hintText: "Items in line",
                          onChanged: controller.updateItemsInline,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: controller.itemsInline.value,
                    childAspectRatio:
                        controller.itemsInline.value == 1 ? 20 : 5,
                  ),
                  itemCount: controller.lengthContainer.value,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: controller.handleFunction,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final containerWidth = constraints.maxWidth;
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 3, top: 3),
                                width: containerWidth,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                alignment: Alignment.center,
                              ),
                              AnimatedBuilder(
                                animation: controller.animations[index],
                                builder: (context, child) {
                                  return ClipRect(
                                    clipper: RectangleClipper(
                                      width: containerWidth *
                                          controller.animations[index].value,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 3, top: 3),
                                      width: containerWidth,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: controller.selectedColor.value,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



