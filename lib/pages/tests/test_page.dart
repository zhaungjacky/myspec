import 'package:certispec/pages/tests/bloc/test_bloc.dart';
import 'package:certispec/pages/tests/test_detail.dart';
import 'package:certispec/services/lab/lab_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:certispec/models/lab_test.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TestLists extends StatefulWidget {
  const TestLists({super.key});

  @override
  State<TestLists> createState() => _TestListsState();
}

class _TestListsState extends State<TestLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laboratory Tests')),
      body: BlocBuilder<TestBloc, TestState>(
        builder: (context, state) {
          if (state is TestsLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TestsLoadSuccess) {
            final List<LabTest> tests = state.tests;
            if (tests.isEmpty) {
              return const Center(child: Text('No tests available.'));
            }
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: tests.length,
                itemBuilder: (context, index) {
                  final t = tests[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(t.name),
                              subtitle: Text(t.method),
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(t.imageUrlOrPath),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        TestDetail(test: t),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is TestsLoadFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = LabTest.classExample();
          final labService = LabDataImpl();
          final res = await labService.createItem(data);
          if (res) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Test added successfully')),
            );
          } else {
            ScaffoldMessenger.of(
              // ignore: use_build_context_synchronously
              context,
            ).showSnackBar(
                const SnackBar(content: Text('Failed to add test')));
          }
        },
        child: const Icon(Icons.add, color: Colors.green),
      ),
    );
  }
}
