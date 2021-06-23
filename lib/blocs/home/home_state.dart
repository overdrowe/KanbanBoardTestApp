import 'package:kanban_board/page_state/form_submission_status.dart';
import 'package:kanban_board/models/kanban_card.dart';

class HomeState {
  final FormSubmissionStatus? formStatus;
  final List<KanbanCard>? cardsList;

  HomeState({this.formStatus, this.cardsList});

  HomeState copyWith({
    FormSubmissionStatus? formStatus = const InitialFormStatus(),
    List<KanbanCard>? cardsList
  }) {
    return HomeState(
      formStatus: formStatus ?? this.formStatus,
      cardsList: cardsList ?? this.cardsList,
    );
  }
}
