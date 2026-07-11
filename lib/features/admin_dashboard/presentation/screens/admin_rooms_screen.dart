import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/bed_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/room_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_rooms_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRoomsScreen extends StatefulWidget {
  const AdminRoomsScreen({super.key});

  @override
  State<AdminRoomsScreen> createState() => _AdminRoomsScreenState();
}

class _AdminRoomsScreenState extends State<AdminRoomsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminRoomsCubit>().getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminRoomsCubit, AdminRoomsState>(
      listener: (context, state) {
        if (state is AdminRoomsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Action completed!'),
              backgroundColor: AppColors.successGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          // Reload rooms after successful mutation
          context.read<AdminRoomsCubit>().getRooms();
        }
        if (state is AdminRoomsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminSectionHeader(
                title: 'Floor Plan Overview',
                subtitle: 'Visual representation of hospital rooms and beds',
                actionLabel: 'Refresh',
                actionIcon: Icons.refresh,
                onAction: () => context.read<AdminRoomsCubit>().getRooms(),
              ),
              const SizedBox(height: 24),
              _buildMainContent(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainContent(AdminRoomsState state) {
    if (state is AdminRoomsLoading || state is AdminRoomsInitial) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: CircularProgressIndicator(color: AppColors.primaryBlue),
        ),
      );
    }

    if (state is AdminRoomsError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            children: [
              const Icon(Icons.error_outline,
                  color: AppColors.errorRed, size: 48),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.read<AdminRoomsCubit>().getRooms(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // Success could be just after an operation, but normally we wait for Loaded
    List<RoomModel> rooms = [];
    if (state is AdminRoomsLoaded) {
      rooms = state.rooms;
    } else if (state is AdminRoomsSuccess) {
      // Data might not be easily parsable here, typically we re-fetch via the listener
      return const Center(child: CircularProgressIndicator());
    }

    if (rooms.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: Text('No rooms found.',
              style: TextStyle(color: AppColors.textSecondary)),
        ),
      );
    }

    // Group rooms by floor
    final roomsByFloor = <int, List<RoomModel>>{};
    for (var room in rooms) {
      final floor = room.floor ?? 0;
      if (!roomsByFloor.containsKey(floor)) {
        roomsByFloor[floor] = [];
      }
      roomsByFloor[floor]!.add(room);
    }

    final sortedFloors = roomsByFloor.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedFloors.map((floor) {
        return _buildFloorSection(floor, roomsByFloor[floor]!);
      }).toList(),
    );
  }

  Widget _buildFloorSection(int floor, List<RoomModel> rooms) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: AppColors.primaryBlue.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.layers_outlined,
                  color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                'Floor $floor',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: rooms.map((room) => _buildRoomVisual(room)).toList(),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildRoomVisual(RoomModel room) {
    IconData roomIcon;
    Color roomColor;

    switch (room.roomType) {
      case RoomType.icu:
        roomIcon = Icons.monitor_heart_outlined;
        roomColor = AppColors.errorRed;
        break;
      case RoomType.surgery:
        roomIcon = Icons.medical_services_outlined;
        roomColor = AppColors.warningOrange;
        break;
      case RoomType.emergency:
        roomIcon = Icons.local_hospital_outlined;
        roomColor = AppColors.warningOrange;
        break;
      case RoomType.or:
        roomIcon = Icons.cut_outlined;
        roomColor = AppColors.primaryBlue;
        break;
      case RoomType.general:
      default:
        roomIcon = Icons.meeting_room_outlined;
        roomColor = AppColors.successGreen;
        break;
    }

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Room Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBg,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              border: const Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(roomIcon, color: roomColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      room.roomNumber ?? 'Unknown Room',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: roomColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    room.roomTypeLabel,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: roomColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Beds View
          Padding(
            padding: const EdgeInsets.all(16),
            child: room.beds == null || room.beds!.isEmpty
                ? const Center(
                    child: Text('No beds found.',
                        style: TextStyle(
                            color: AppColors.textLight, fontSize: 12)))
                : Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children:
                        room.beds!.map((bed) => _buildBedVisual(bed)).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBedVisual(BedModel bed) {
    Color bedColor;
    IconData bedIcon;

    switch (bed.status) {
      case BedStatus.occupied:
        bedColor = AppColors.errorRed;
        bedIcon = Icons.bed; // occupied icon
        break;
      case BedStatus.maintenance:
        bedColor = AppColors.textSecondary;
        bedIcon = Icons.build_outlined;
        break;
      case BedStatus.available:
      default:
        bedColor = AppColors.successGreen;
        bedIcon = Icons.bed_outlined; // available icon
        break;
    }

    return Tooltip(
      message: bed.currentAdmissionId != null
          ? 'Admission: ${bed.currentAdmissionId}'
          : bed.statusLabel,
      child: Container(
        width: 60,
        height: 70,
        decoration: BoxDecoration(
          color: bedColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: bedColor.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(bedIcon, color: bedColor, size: 28),
            const SizedBox(height: 4),
            Text(
              bed.bedNumber?.split('-').last ?? 'Bed',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: bedColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
