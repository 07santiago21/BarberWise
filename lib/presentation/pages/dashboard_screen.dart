import 'package:flutter/material.dart';
import 'package:barber/presentation/providers/dashboard_provider.dart';
import 'package:barber/presentation/widgets/dashboard/greeting_header.dart';
import 'package:barber/presentation/widgets/dashboard/daily_summary_card.dart';
import 'package:barber/presentation/widgets/dashboard/next_appointment_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardProvider provider = DashboardProvider();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    provider.loadDashboardData().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || provider.nextAppointment == null || provider.dailySummary == null) {
      return const Scaffold(
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Header (30%)
                  SizedBox(
                    height: height * 0.30,
                    child: const GreetingHeader(),
                  ),

                  const SizedBox(height: 8),

                  // Próximo turno (25%)
                  SizedBox(
                    height: height * 0.25,
                    child: SizedBox.expand(
                      child: NextAppointmentCard(appointment: provider.nextAppointment!),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Resumen del día (45%)
                  Expanded(
                    child: SizedBox.expand(
                      child: DailySummaryCard(summary: provider.dailySummary!),
                    ),
                  ),

                  const SizedBox(height: 12), // Espacio inferior
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
