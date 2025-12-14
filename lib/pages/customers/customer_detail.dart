import 'package:certispec/models/customer_info.dart';
import 'package:flutter/material.dart';

class CustomerDetail extends StatelessWidget {
  final CustomerInfo info;
  const CustomerDetail({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(info.name ?? 'Customer Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${info.name ?? 'N/A'}'),
            SizedBox(height: 8),
            Text('Email: ${info.email ?? 'N/A'}'),
            SizedBox(height: 8),
            Text('Phone: ${info.phone ?? 'N/A'}'),
            SizedBox(height: 16),
            Text('Samples:', style: Theme.of(context).textTheme.titleMedium),
            ...?info.samples?.map(
              (sample) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sample Name: ${sample.sampleName}'),
                    Text('Test Content: ${sample.testContent}'),
                    Text('Description: ${sample.description}'),
                    Text('Test Type: ${sample.testType}'),
                    Text('Keypoint: ${sample.keypoint}'),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
