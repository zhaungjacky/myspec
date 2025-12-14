import 'package:certispec/models/customer_info.dart';
import 'package:certispec/pages/customers/bloc/customer_bloc.dart';
import 'package:certispec/pages/customers/customer_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});
  static String routhPath([String? customerInfo]) =>
      "/chat/${customerInfo ?? ':customerInfo'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          switch (state) {
            case CustomerInitial():
              return const Center(child: CircularProgressIndicator());
            case CustomerLoaded():
              final customers = state.customers;
              return AnimationLimiter(
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final customer = customers[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Card(
                            elevation: 1.15,
                            child: ListTile(
                              title: Text(customer.name!),
                              subtitle: Text(customer.email!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        CustomerDetail(info: customer),
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
                    );
                  },
                ),
              );
            case CustomerError():
              return Center(child: Text('Error: ${state.message}'));

            case CustomerLoading():
              return const Center(child: CircularProgressIndicator());
            case CustomerZero():
              return Center(child: Text(state.message));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // final myCustomer = CustomerInfo(
          //   name: 'IOCO',
          //   email: 'IOCO@gmail.com',
          //   phone: '1234567890',
          //   samples: [
          //     SampleInfo(
          //       sampleName: 'BFO',
          //       testContent: 'VOSICITY AT 50C',
          //       description: "Test for viscosity at 50 degrees Celsius",
          //       testType: 'submitted',
          //       keypoint: 'IF BUBBLE AT TUBE, USE BLOWER TO REMOVE',
          //       cost: 150,
          //     ),
          //     SampleInfo(
          //       testType: 'submitted',
          //       testContent: 'ACETONE CONTENT',
          //       description: "Test for acetone content in the sample",
          //       keypoint: 'WHEN WASH, BE CAREFUL WITH ACETONE',
          //       cost: 125,
          //       sampleName: 'BFO',
          //     ),
          //     SampleInfo(
          //       testType: 'submitted',
          //       keypoint: 'LESS THAN 0.5%',
          //       sampleName: 'BFO',
          //       testContent: 'SURPHER TENSION',
          //       description: 'LESS THAN 0.5%',
          //       cost: 145,
          //     ),
          //   ],
          // );

          final myCustomer = CustomerInfo(
            name: 'Parkland',
            email: 'parklan@gmail.com',
            phone: '1234567890',
            samples: [
              SampleInfo(
                sampleName: 'FCC-FEED',
                testContent: 'Metals',
                description: "Na V Ni Fe Ca Mg Zn P",
                testType: 'submitted',
                keypoint:
                    'IF P < 10PPM, Report 2 decial place, if 10-100PPM, report 1 decimal place, if >100PPM, report integer',
                cost: 150,
              ),
              SampleInfo(
                testType: 'submitted',
                testContent: 'ACETONE CONTENT',
                description: "Test for acetone content in the sample",
                keypoint: 'WHEN WASH, BE CAREFUL WITH ACETONE',
                cost: 125,
                sampleName: 'Diesel',
              ),
              SampleInfo(
                testType: 'submitted',
                keypoint: 'LESS THAN 0.5%',
                sampleName: 'DHT-FEED',
                testContent: 'SURPHER TENSION',
                description: 'LESS THAN 0.5%',
                cost: 145,
              ),
            ],
          );

          context.read<CustomerBloc>().add(CustomerAdd(customer: myCustomer));
        },
      ),
    );
  }
}
