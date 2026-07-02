import 'package:cortexia/features/admission/data/models/room_model.dart';
import 'package:cortexia/features/admission/domain/repo/admission_repo_interface.dart';
import 'package:flutter/foundation.dart';

/// A lightweight in-memory cache for the Rooms list.
///
/// Usage:
///   final service = locator.get[RoomCacheService]();
///   await service.ensureLoaded();
///   final room = service.resolveRoom(roomId);
///   final bed  = service.resolveBed(bedId);
class RoomCacheService {
  final AdmissionRepoInterface _repo;

  RoomCacheService(this._repo);

  List<RoomModel> _rooms = [];
  bool _loaded = false;

  // ── Public API ──────────────────────────────────────────────────────────

  /// Returns true once rooms have been fetched at least once.
  bool get isLoaded => _loaded;

  /// Returns a flat, unmodifiable list of all rooms.
  List<RoomModel> get rooms => List.unmodifiable(_rooms);

  /// Fetches rooms from the API if not already loaded.
  Future<void> ensureLoaded() async {
    if (_loaded) return;
    await refresh();
  }

  /// Forces a fresh fetch from the API and rebuilds the cache.
  Future<void> refresh() async {
    try {
      final result = await _repo.getRooms();
      result.when(
        onSuccess: (rooms) {
          _rooms = rooms;
          _loaded = true;
          debugPrint('[RoomCacheService] Cached ${rooms.length} rooms.');
        },
        onError: (err) {
          debugPrint('[RoomCacheService] Failed to load rooms: ${err.messages}');
        },
      );
    } catch (e) {
      debugPrint('[RoomCacheService] Exception loading rooms: $e');
    }
  }

  // ── Lookup helpers ──────────────────────────────────────────────────────

  /// Returns the [RoomModel] for the given [roomId], or null if not found.
  RoomModel? resolveRoom(String? roomId) {
    if (roomId == null || roomId.isEmpty) return null;
    try {
      return _rooms.firstWhere(
        (r) => r.roomId?.toLowerCase() == roomId.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Returns the [BedModel] for the given [bedId], or null if not found.
  BedModel? resolveBed(String? bedId) {
    if (bedId == null || bedId.isEmpty) return null;
    for (final room in _rooms) {
      if (room.beds == null) continue;
      try {
        final bed = room.beds!.firstWhere(
          (b) => b.bedId?.toLowerCase() == bedId.toLowerCase(),
        );
        return bed;
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  /// Convenience: resolves a human-readable location label for a patient.
  ///
  /// Returns a [_ResolvedLocation] with floor, roomNumber, bedNumber, roomType.
  ResolvedLocation resolveLocation({String? roomId, String? bedId}) {
    final room = resolveRoom(roomId);
    final bed = resolveBed(bedId);
    return ResolvedLocation(
      floor: room?.floor,
      roomNumber: room?.roomNumber,
      bedNumber: bed?.bedNumber,
      roomType: room?.roomTypeLabel,
    );
  }
}

/// Resolved, human-readable location data for a patient.
class ResolvedLocation {
  final int? floor;
  final String? roomNumber;
  final String? bedNumber;
  final String? roomType;

  const ResolvedLocation({
    this.floor,
    this.roomNumber,
    this.bedNumber,
    this.roomType,
  });

  bool get hasData =>
      floor != null || roomNumber != null || bedNumber != null;

  @override
  String toString() =>
      'ResolvedLocation(floor: $floor, room: $roomNumber, bed: $bedNumber, type: $roomType)';
}
