import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class AnimatedMeshGradientView extends StatelessWidget {
  const AnimatedMeshGradientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: AnimatedMeshGradient(
        colors: const [
          Color.fromARGB(1, 4, 217, 96),
          Color.fromARGB(1, 28, 25, 115),
          Color.fromARGB(1, 6, 14, 64),
          Color.fromARGB(1, 91, 68, 242),
        ],
        options: AnimatedMeshGradientOptions(
            speed: 0.01, grain: .5, amplitude: 40, frequency: 5),
      ),
    );
  }
}
