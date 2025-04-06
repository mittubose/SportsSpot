import 'package:flutter/material.dart';
import 'package:joola_spot/domain/models/time_slot.dart';

class TimeSlotSelector extends StatelessWidget {
  final List<TimeSlot> availableSlots;
  final Function(TimeSlot) onSlotSelected;
  final TimeSlot? selectedSlot;

  const TimeSlotSelector({
    Key? key,
    required this.availableSlots,
    required this.onSlotSelected,
    this.selectedSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Time Slots',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableSlots.map((slot) {
            final isSelected = selectedSlot?.id == slot.id;
            return InkWell(
              onTap: () => onSlotSelected(slot),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${slot.startTime.hour}:${slot.startTime.minute.toString().padLeft(2, '0')} - ${slot.endTime.hour}:${slot.endTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
