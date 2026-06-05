import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../models/income_record.dart';
import '../../repositories/income_repository.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final amountController = TextEditingController();
  final dogNameController = TextEditingController();
  final notesController = TextEditingController();

  final repository = IncomeRepository();

  String serviceType = 'Dog Walk';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    amountController.dispose();
    dogNameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void saveIncome() {
    final amount = double.tryParse(amountController.text);

    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount.')),
      );
      return;
    }

    final record = IncomeRecord(
      id: const Uuid().v4(),
      amount: amount,
      serviceType: serviceType,
      dogName: dogNameController.text.trim(),
      notes: notesController.text.trim(),
      date: selectedDate,
    );

    repository.addIncome(record);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Income'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount SEK',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: serviceType,
            decoration: const InputDecoration(
              labelText: 'Service Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Dog Walk', child: Text('Dog Walk')),
              DropdownMenuItem(value: 'Day Care', child: Text('Day Care')),
              DropdownMenuItem(value: 'Boarding', child: Text('Boarding')),
              DropdownMenuItem(value: 'Drop-in', child: Text('Drop-in')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {
              setState(() {
                serviceType = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: dogNameController,
            decoration: const InputDecoration(
              labelText: 'Dog / Client Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            title: const Text('Date'),
            subtitle: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2024),
                lastDate: DateTime(2035),
              );

              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: notesController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: saveIncome,
            icon: const Icon(Icons.save),
            label: const Text('Save Income'),
          ),
        ],
      ),
    );
  }
}