// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'referral_cubit.dart';

enum ReferralCheckingStatus { initial, inProgress, failure, success }

enum ReferralSendingStatus { initial, inProgress, failure, success }

class ReferralState extends Equatable {
  const ReferralState({
    this.checkingStatus = ReferralCheckingStatus.initial,
    this.sendingStatus = ReferralSendingStatus.initial,
  });

  final ReferralCheckingStatus checkingStatus;
  final ReferralSendingStatus sendingStatus;

  @override
  List<Object> get props => [
        checkingStatus,
        sendingStatus,
      ];

  ReferralState copyWith({
    ReferralCheckingStatus? checkingStatus,
    ReferralSendingStatus? sendingStatus,
  }) {
    return ReferralState(
      checkingStatus: checkingStatus ?? this.checkingStatus,
      sendingStatus: sendingStatus ?? this.sendingStatus,
    );
  }
}
