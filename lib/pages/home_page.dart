import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/app_style/app_style.dart';
import 'package:kanban_board/page_state/form_submission_status.dart';
import 'package:kanban_board/blocs/home/home_bloc.dart';
import 'package:kanban_board/blocs/home/home_event.dart';
import 'package:kanban_board/blocs/home/home_state.dart';
import 'package:kanban_board/models/kanban_card.dart';
import 'package:kanban_board/pages/login_page.dart';
import 'package:kanban_board/repositories/user_repository.dart';
import 'package:kanban_board/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  final String token;

  HomePage({Key? key, required this.token}) : super(key: key);

  final List<Tab> tabs = <Tab>[
    Tab(child: Text('On hold', maxLines: 1, overflow: TextOverflow.visible, softWrap: false)),
    Tab(child: Text('In progress', maxLines: 1, overflow: TextOverflow.visible, softWrap: false)),
    Tab(child: Text('Needs review', maxLines: 1, overflow: TextOverflow.visible, softWrap: false)),
    Tab(child: Text('Approved', maxLines: 1, overflow: TextOverflow.visible, softWrap: false)),
  ];

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(token: token),
      child: BlocProvider(
        create: (context) => HomeBloc(userRepo: context.read<UserRepository>())..add(GetCards()),
        child: DefaultTabController(
            length: tabs.length,
            child: Builder(builder: (BuildContext context) {
              final TabController tabController = DefaultTabController.of(context)!;
              tabController.addListener(() {
                if (!tabController.indexIsChanging) {
                  print(tabController.index);
                  context.read<HomeBloc>().add(GetCards());
                }
              });
              return _mainField(context);
            })),
      ),
    );
  }

  Widget _mainField(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // here the desired height
        child: CustomAppBar(
          title: '',
          actionButton: _backButton(context),
          bottom: TabBar(tabs: tabs),
        ),
      ),
      body: _tabsView(),
    );
  }

  Widget _tabsView() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.formStatus is SubmissionFailed) {
        _showSnackBar(context, (state.formStatus! as SubmissionFailed).exception.toString());
      }
      return ((state.formStatus is FormSubmitting) || (state.cardsList == null))
          ? TabBarView(
              children: [
                Center(child: CircularProgressIndicator()),
                Center(child: CircularProgressIndicator()),
                Center(child: CircularProgressIndicator()),
                Center(child: CircularProgressIndicator()),
              ],
            )
          : TabBarView(
              children: [
                _cardsListField(state.cardsList!.where((element) => element.row == 0).toList()),
                _cardsListField(state.cardsList!.where((element) => element.row == 1).toList()),
                _cardsListField(state.cardsList!.where((element) => element.row == 2).toList()),
                _cardsListField(state.cardsList!.where((element) => element.row == 3).toList()),
              ],
            );
    });
  }

  Widget _cardsListField(List<KanbanCard> list) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
            list.length,
            (int index) => Card(
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID: " + list[index].id.toString(), style: TextStyle(color: Colors.white)),
                      SizedBox(height: 8),
                      Text(list[index].text, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppStyle().mainColor),
      margin: EdgeInsets.all(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
