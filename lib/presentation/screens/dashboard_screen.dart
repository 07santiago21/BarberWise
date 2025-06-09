import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barber/presentation/widgets/dashboard/greeting_header.dart';
import 'package:barber/presentation/widgets/dashboard/next_appointment_card.dart';
import 'package:barber/presentation/widgets/dashboard/daily_summary_card.dart';
import 'package:barber/presentation/providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(dashboardProvider.notifier).loadDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.25,
                    child: const GreetingHeader(),
                  ),
                  Expanded(
                    child: state.nextAppointment != null
                        ? NextAppointmentCard(
                            appointment: state.nextAppointment!)
                        : const Center(child: Text('Sin turnos próximos')),
                  ),
                  Expanded(
                    child: state.summary != null
                        ? DailySummaryCard(summary: state.summary!)
                        : const SizedBox(),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
