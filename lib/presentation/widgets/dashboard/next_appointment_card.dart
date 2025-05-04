import 'package:flutter/material.dart';
import 'package:barber/domain/entities/appointment_entity.dart';

class NextAppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;

  const NextAppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xF5F5F5F5),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Próximo turno',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              '${appointment.date.hour}:${appointment.date.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(appointment.clientName, style: const TextStyle(fontSize: 18)),
            Text(appointment.type.name, style: const TextStyle(fontSize: 18)),
            Text('\$${appointment.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
