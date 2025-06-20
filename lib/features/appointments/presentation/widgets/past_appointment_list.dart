import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/circular_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../controller/past_appointment_controller.dart';
import 'past_appointment_body.dart';

class PastAppointmentList extends ConsumerWidget
{
  const PastAppointmentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final pastAsync = ref.watch(pastAppointmentsProvider);
    return pastAsync.when(
      data: (appointments)
      {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
              children:
              [
                PastAppointmentWidget(model: appointments[index]),
                if (index != appointments.length - 1)
                  Sizes.size16.verticalSpace,
              ],
            ),
            childCount: appointments.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: AppCircularIndicator(),),
      error: (e, _) => SliverToBoxAdapter(child: CustomErrorWidget(e: e),),
    );
  }
}
