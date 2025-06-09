import 'package:flutter/material.dart';
import 'package:barber/domain/entities/appointment_entity_.dart';

class NextAppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const NextAppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Próximo turno',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${appointment.startTime.hour}:${appointment.startTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    appointment.clientName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    appointment.service?.name ?? 'Sin servicio',
                    style: const TextStyle(fontSize: 18),
                  ),
                  
                  Text(
                    '\$${appointment.service?.price.toStringAsFixed(0) ?? '0'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
