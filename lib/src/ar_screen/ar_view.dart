import 'dart:io';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:sizer/sizer.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';

class ARview extends StatefulWidget {
  const ARview({super.key, required this.urlModel});
  final String urlModel;
  @override
  State<ARview> createState() => _ARviewWidgetState();
}

class _ARviewWidgetState extends State<ARview> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? localObjectNode;
  ARNode? webObjectNode;
  ARNode? fileSystemNode;
  HttpClient? httpClient;

  double zoomValue = -1.5;
  double moveUpOrDown = -0.8;

  @override
  void dispose() {
    super.dispose();
    if (arSessionManager != null) {
      arSessionManager!.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: Stack(children: [
      ARView(
        onARViewCreated: onARViewCreated,
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      ),
      Align(
          alignment: FractionalOffset.bottomCenter,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFFFFF)),
                      child: IconButton(
                          onPressed: zoomIn,
                          icon: const Icon(Icons.zoom_in_map))),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFFFFF)),
                      child: IconButton(
                          onPressed: zoomOut,
                          icon: const Icon(Icons.zoom_out_map))),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFFFFF)),
                      child: IconButton(
                          onPressed: moveUp,
                          icon: const Icon(Icons.arrow_upward_rounded))),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFFFFF)),
                      child: IconButton(
                          onPressed: moveDown,
                          icon: const Icon(Icons.arrow_downward_rounded))),
                )
              ],
            ),
          ]))
    ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager manager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    arSessionManager = arSessionManager;
    arObjectManager = manager;

    arSessionManager.onInitialize(
      showPlanes: true,
      handleTaps: false,
    );
    arObjectManager!.onInitialize();

    httpClient = HttpClient();

    webObjectNode = ARNode(
      name: "mynode",
      type: NodeType.webGLB,
      uri: widget.urlModel,
      position: Vector3(0.0, -0.8, -1.5),
    );
    arObjectManager!.addNode(webObjectNode!);
  }

  zoomIn() async {
    zoomValue = zoomValue + 0.2;
    await arObjectManager!.removeNode(webObjectNode!);
    webObjectNode = ARNode(
      type: NodeType.webGLB,
      uri: widget.urlModel,
      position: Vector3(0.0, -0.8, zoomValue),
    );
    arObjectManager!.addNode(webObjectNode!);
  }

  zoomOut() async {
    zoomValue = zoomValue - 0.2;
    await arObjectManager!.removeNode(webObjectNode!);
    webObjectNode = ARNode(
      type: NodeType.webGLB,
      uri: widget.urlModel,
      position: Vector3(0.0, -0.8, zoomValue),
    );
    arObjectManager!.addNode(webObjectNode!);
  }

  moveUp() async {
    moveUpOrDown = moveUpOrDown + 0.2;
    await arObjectManager!.removeNode(webObjectNode!);
    webObjectNode = ARNode(
      type: NodeType.webGLB,
      uri: widget.urlModel,
      position: Vector3(0.0, moveUpOrDown, zoomValue),
    );
    arObjectManager!.addNode(webObjectNode!);
  }

  moveDown() async {
    moveUpOrDown = moveUpOrDown - 0.2;
    await arObjectManager!.removeNode(webObjectNode!);
    webObjectNode = ARNode(
      type: NodeType.webGLB,
      uri: widget.urlModel,
      position: Vector3(0.0, moveUpOrDown, zoomValue),
    );
    arObjectManager!.addNode(webObjectNode!);
  }
}
