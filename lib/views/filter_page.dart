import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/filter_controller.dart';

class FiltersPage extends StatelessWidget {
  final List<String> customerList;

  const FiltersPage({Key? key, required this.customerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FiltersController controller =
        Get.put(FiltersController(customerList));

    Future<void> pickDate({required bool isStart}) async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate:
            isStart ? controller.startDate.value : controller.endDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) =>
            Theme(data: ThemeData.dark(), child: child!),
      );
      if (picked != null) {
        if (isStart) {
          controller.startDate.value = picked;
        } else {
          controller.endDate.value = picked;
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text("Filters",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
        actions: [
          TextButton(
            onPressed: controller.applyFilters,
            child: const Text("Filter", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => pickDate(isStart: true),
                        child: Text(
                          "${controller.startDate.value.day}/${controller.startDate.value.month}/${controller.startDate.value.year}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => pickDate(isStart: false),
                        child: Text(
                          "${controller.endDate.value.day}/${controller.endDate.value.month}/${controller.endDate.value.year}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  children: controller.statusOptions.map((status) {
                    return ChoiceChip(
                      label: Text(status),
                      selected: controller.selectedStatus.value == status,
                      onSelected: (_) =>
                          controller.selectedStatus.value = status,
                      showCheckmark: false,
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey[800],
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    border: Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedCustomer.value.isNotEmpty
                        ? controller.selectedCustomer.value
                        : null,
                    dropdownColor: Colors.grey[900],
                    isExpanded: true,
                    hint: const Text("Select Customer",
                        style: TextStyle(color: Colors.white54)),
                    iconEnabledColor: Colors.white,
                    underline: const SizedBox(),
                    items: controller.customerList.toSet().map((customer) {
                      return DropdownMenuItem(
                        value: customer,
                        child: Text(customer,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) controller.selectedCustomer.value = val;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                if (controller.selectedCustomer.value.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text(controller.selectedCustomer.value,
                          style: const TextStyle(color: Colors.white)),
                      deleteIcon: const Icon(Icons.close, color: Colors.white),
                      onDeleted: () => controller.selectedCustomer.value = '',
                      backgroundColor: Colors.blue,
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: controller.applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Apply',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 16)),
                )
              ],
            )),
      ),
    );
  }
}
