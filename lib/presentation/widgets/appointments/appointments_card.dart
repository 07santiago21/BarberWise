import 'package:barber/domain/entities/appointment_entity_.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final appt = widget.appointment;

    final time =
        '${appt.startTime.hour.toString().padLeft(2, '0')}:${appt.startTime.minute.toString().padLeft(2, '0')} - '
        '${appt.endTime.hour.toString().padLeft(2, '0')}:${appt.endTime.minute.toString().padLeft(2, '0')}';

     final duration = appt.service?.duration;
     final price = appt.service?.price.toStringAsFixed(0);

     String formatDuration(int? minutes) {
      if (minutes == null) return 'Duración no disponible';
      final h = minutes ~/ 60;
      final m = minutes % 60;
      if (h > 0) return '${h}h ${m}min';
      return '$m min';
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Parte visible
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 20),
                      const SizedBox(width: 8),
                      Text(time),
                    ],
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: 24,
                  ),
                ],
              ),

              if (_expanded) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cliente y servicio
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appt.clientName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text('Servicio: ${appt.service?.name}'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.schedule, size: 16),
                            const SizedBox(width: 4),
                            Text(formatDuration(duration)),
                          ],
                        ),
                      ],
                    ),
                    // Precio
                    Column(
                      children: [
                        const Icon(Icons.attach_money, size: 20),
                        Text(price ?? '-'),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
