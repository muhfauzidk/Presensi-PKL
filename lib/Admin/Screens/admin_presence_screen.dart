import 'package:presensi/Admin/Controllers/admin_presence_controller.dart';
import 'package:presensi/Admin/Widgets/presence_tile.dart';
import 'package:presensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AdminAllPresenceView extends GetView<AdminAllPresenceController> {
  static String routeName = "/admin_presence";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Absensi',
          style: TextStyle(
            color: secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.green),
            onPressed: () {
              Get.back();
            },
          ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(bottom: 8, top: 8, right: 8),
            child: ElevatedButton(
              onPressed: () {
                Get.dialog(
                  Dialog(
                    child: Container(
                      height: 372,
                      child: SfDateRangePicker(
                        headerHeight: 50,
                        headerStyle: const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
                        monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                        selectionMode: DateRangePickerSelectionMode.range,
                        selectionColor: primaryColor,
                        rangeSelectionColor: primaryColor.withOpacity(0.2),
                        viewSpacing: 10,
                        showActionButtons: true,
                        onCancel: () => Get.back(),
                        onSubmit: (data) {
                          if (data != null) {
                            PickerDateRange range = data as PickerDateRange;
                            if (range.endDate != null) {
                              controller.pickDate(range.startDate!, range.endDate!);
                            }
                          }
                          //else skip
                        },
                      ),
                    ),
                  ),
                );
              },
              child: SvgPicture.asset('assets/icons/filter.svg'),
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: secondaryExtraSoft,
          ),
        ),
      ),
      body: GetBuilder<AdminAllPresenceController>(
        init: Get.put<AdminAllPresenceController>(AdminAllPresenceController()),
        builder: (con) {
          return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: controller.getAllPresence(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  var data = snapshot.data!.docs;
                  return ListView.separated(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      var presenceData = data[index].data();
                      return PresenceTile(
                        presenceData: presenceData,
                      );
                    },
                  );
                default:
                  return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
