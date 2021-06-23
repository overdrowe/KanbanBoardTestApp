import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/page_state/form_submission_status.dart';
import 'package:kanban_board/blocs/home/home_event.dart';
import 'package:kanban_board/blocs/home/home_state.dart';
import 'package:kanban_board/models/kanban_card.dart';
import 'package:kanban_board/repositories/user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepo;

  HomeBloc({required this.userRepo}) : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetCards) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        yield state.copyWith(cardsList: _createCards(await userRepo.getCards()));
        print(state.cardsList!.length);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
      }
    }
  }

  List<KanbanCard> _createCards(var response) {
    return List.generate(response.length, (int index) => KanbanCard.fromJson(response[index]));
  }
}
