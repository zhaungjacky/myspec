import 'package:flutter/material.dart';
import 'package:certispec/models/lab_test.dart';
import 'package:gap/gap.dart';

class TestDetail extends StatelessWidget {
  final LabTest test;

  const TestDetail({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    // final imageWidth = screenWidth * 0.5;
    // final imageHeight = screenHeight * 0.5;
    return Scaffold(
      appBar: AppBar(title: Text(test.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   test.imageUrlOrPath,
              //   // width: imageWidth,
              //   // height: imageHeight,
              //   scale: 0.2,
              //   fit: BoxFit.fitWidth,
              // ),
              Gap(16),
              Text('Method', style: Theme.of(context).textTheme.titleMedium),
              Gap(6),
              Text(test.method),
              Gap(6),
              Text('Equipment', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(test.equipment),
              Gap(6),
              Text('Reagent', style: Theme.of(context).textTheme.titleMedium),
              Text(test.reagent),

              Gap(6),
              Text('Apparatus', style: Theme.of(context).textTheme.titleMedium),
              Text(test.appratus.join(' , ')),
              Gap(16),
              Text('Procedure', style: Theme.of(context).textTheme.titleMedium),
              test.procedure.isEmpty
                  ? const Text('No procedure steps available.')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: test.procedure.map((step) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Step ${step.step}: ${step.description}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (step.equipment != null &&
                                  step.equipment!.isNotEmpty)
                                Text('Equipment: ${step.equipment}'),
                              if (step.volume != null && step.volume! > 0)
                                Text(
                                  'Volume: ${step.volume} ${step.unit ?? ''}',
                                ),
                              if (step.tool != null && step.tool!.isNotEmpty)
                                Text('Tool: ${step.tool}'),
                              if (step.reagent != null &&
                                  step.reagent!.isNotEmpty)
                                Text('Reagent: ${step.reagent}'),
                              if (step.keypoint != null &&
                                  step.keypoint!.isNotEmpty)
                                Text('Key Point: ${step.keypoint}'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
