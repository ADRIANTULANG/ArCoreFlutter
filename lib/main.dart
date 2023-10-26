import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    // _addSphere(arCoreController!);
    // _addCylindre(arCoreController!);
    // _addCube(arCoreController!);
    _addModel(arCoreController!);
  }

  void _addModel(ArCoreController controller) async {
    controller.addArCoreNode(ArCoreReferenceNode(
      objectUrl:
          'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Duck/glTF/Duck.gltf',
      // objectUrl: 'http://192.168.1.24/modelsfiles/newsofas.gltf',
      // scale: Vector3(0.0, -0.5, -2.0), // Adjust the scale as needed
      // position: Vector3(-0.5, 0.5, -3.5),
      position: Vector3(0.0, -0.5, -2.0),
    ));
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

  // void _addCylindre(ArCoreController controller) {
  //   final material = ArCoreMaterial(
  //     color: const Color.fromARGB(120, 66, 134, 244),
  //     reflectance: 1.0,
  //   );
  //   final cylindre = ArCoreCylinder(
  //     materials: [material],
  //     radius: 0.5,
  //     height: 0.3,
  //   );
  //   final node = ArCoreNode(
  //     shape: cylindre,
  //     position: Vector3(0.0, -0.5, -2.0),
  //   );
  //   controller.addArCoreNode(node);
  // }

  // void _addCube(ArCoreController controller) {
  //   final material = ArCoreMaterial(
  //     color: const Color.fromARGB(120, 66, 134, 244),
  //     metallic: 1.0,
  //   );
  //   final cube = ArCoreCube(
  //     materials: [material],
  //     size: Vector3(0.5, 0.5, 0.5),
  //   );
  //   final node = ArCoreNode(
  //     shape: cube,
  //     position: Vector3(-0.5, 0.5, -3.5),
  //   );
  //   controller.addArCoreNode(node);
  // }

  @override
  void dispose() {
    arCoreController!.dispose();
    super.dispose();
  }
}

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   ArCoreController? arCoreController;
//   ArCoreNode? arCoreNode;

//   @override
//   void dispose() {
//     arCoreController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AR Screen'),
//       ),
//       body: ArCoreView(
//         onArCoreViewCreated: _onArCoreViewCreated,
//         enableTapRecognizer: true,
//       ),
//     );
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;

//     _addModel();
//   }

//   void _addModel() async {
//     // final ByteData byteData =
//     //     await rootBundle.load('assets/models/GalaxyS10.gltf');
//     // final String modelPath =
//     //     await writeToFile(byteData); // Replace with your actual model path

//     arCoreController!.addArCoreNode(
//       ArCoreReferenceNode(
//         name: 'GalaxyS10',
//         objectUrl:
//             'https://firebasestorage.googleapis.com/v0/b/taskmanagement-566fe.appspot.com/o/GalaxyS10.gltf?alt=media&token=c9358e20-58a4-46e9-9c1f-700389f3398a&_gl=1*djqfu4*_ga*MTA5MzMzNDY5OC4xNjk1NjExNTcz*_ga_CW55HF8NVT*MTY5ODI0ODQ5OC4xMi4xLjE2OTgyNDg1NjcuNjAuMC4w',
//         // object3DFileName: modelPath,
//         scale: Vector3(1, 1, 1), // Adjust the scale as needed
//       ),
//     );
//   }

//   // void _onNodeTap(String nodeId) {
//   //   print('Node tapped: $nodeId');
//   //   // Handle node tap event
//   // }

//   Future<String> writeToFile(ByteData data) async {
//     final buffer = data.buffer;
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/GalaxyS10.gltf';
//     await File(filePath).writeAsBytes(
//         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//     return filePath;
//   }
// }
