// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/product/enums/firebase_collection.dart';
import 'package:news_app/product/enums/platform_enum.dart';

import 'package:news_app/product/models/version_number_model.dart';
import 'package:news_app/product/splash/version_manager.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(const SplashState());

  Future<void> checkDeviceVersion(String deviceVersion) async {
    final databaseVersion = await getLastestVersionFromDatabase();

    if (databaseVersion == null || databaseVersion.isEmpty) {
      state = state.copyWith(isRedirectHome: false);
      return;
    }

    final checkIsNeedForceUpdate = VersionManager(
      deviceVersion: deviceVersion,
      databaseVersion: databaseVersion,
    );

    if (checkIsNeedForceUpdate.isNeedTpUpdate()) {
      state = state.copyWith(isForceUpdateRequired: true);
    } else {
      state = state.copyWith(isRedirectHome: true);
    }
  }

  Future<String?> getLastestVersionFromDatabase() async {
    if (kIsWeb) return null;
    final response = await FirebaseColletions.version.reference
        .withConverter<VersionNuberModel>(
          fromFirestore: (snapshot, options) =>
              VersionNuberModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(PlatformEnum.currentPlatform)
        .get();

    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  const SplashState({
    this.isRedirectHome,
    this.isForceUpdateRequired,
  });

  final bool? isRedirectHome;
  final bool? isForceUpdateRequired;

  @override
  List<Object?> get props => [isForceUpdateRequired, isRedirectHome];

  SplashState copyWith({
    bool? isRedirectHome,
    bool? isForceUpdateRequired,
  }) {
    return SplashState(
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
      isForceUpdateRequired:
          isForceUpdateRequired ?? this.isForceUpdateRequired,
    );
  }
}
