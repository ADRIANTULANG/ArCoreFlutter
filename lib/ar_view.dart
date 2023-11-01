import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ArCoreController? arCoreController;
  ArCoreReferenceNode? node;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => getBack(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: Stack(
          children: [
            ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
            ),
            TextButton(
                onPressed: () {
                  rotate();
                },
                child: const Text("Rotate"))
          ],
        ),
      ),
    );
  }

  getBack() async {
    Get.back();
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    // _addSphere(arCoreController!);
    // _addCylindre(arCoreController!);
    // _addCube(arCoreController!);
    _addModel(arCoreController!);
  }

  // void _addSphere(ArCoreController controller) {
  //   final material =
  //       ArCoreMaterial(color: const Color.fromARGB(120, 66, 134, 244));
  //   final sphere = ArCoreSphere(
  //     materials: [material],
  //     radius: 0.1,
  //   );
  //   final node = ArCoreNode(
  //     shape: sphere,
  //     position: Vector3(0, 0, -1.5),
  //   );
  //   controller.addArCoreNode(node);
  // }

  void _addModel(ArCoreController controller) async {
    node = ArCoreReferenceNode(
      name: "mynode",
      // objectUrl:
      //     'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Duck/glTF/Duck.gltf',
      objectUrl:
          'https://raw.githubusercontent.com/ADRIANTULANG/ArCoreFlutter/main/assets/models/newsofa.gltf',

      // scale: Vector3(0.0, -0.5, -2.0), // Adjust the scale as needed
      // position: Vector3(-0.5, 0.5, -3.5),
      // position: Vector3(0.0, -0.5, -2.0), normal size
      position: Vector3(0.0, -0.5, -0.8),
    );
    controller.addArCoreNode(node!);
  }

  rotate() async {
    await arCoreController!.removeNode(nodeName: "mynode");
    arCoreController!.addArCoreNode(ArCoreReferenceNode(
      name: "mynode",
      objectUrl:
          'https://raw.githubusercontent.com/ADRIANTULANG/ArCoreFlutter/main/assets/models/newsofa.gltf',
      position:
          Vector3(0.0, -0.5, -0.9), // plus or minus z value to zoom in and out
      rotation: Vector4(0, 25, 0, -45), // plus y value later to rotate.
    ));
  }

  @override
  void dispose() {
    if (arCoreController != null) {
      arCoreController!.dispose();
    }
    super.dispose();
  }
}
