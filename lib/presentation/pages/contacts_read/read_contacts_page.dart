import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freesms/presentation/pages/contacts_read/widgets/read_timer.dart';
import '../../../../helpers/sharedprefs.dart';
import '../../../home_view/home_screen.dart';
import '../../shared/utils/injection_container.dart';
import 'read_contacts_bloc.dart';
import 'read_contacts_state.dart';

class ReadContactsPage extends StatelessWidget {
  const ReadContactsPage({Key? key}) : super(key: key);

  void readingContacts(BuildContext context) {
    context
        .read<ReadContactsBloc>().readContacts();
  }

  @override
  Widget build(BuildContext context) {

    ReadContactsBloc readContactsBloc = sl<ReadContactsBloc>();

    return BlocProvider(
      create: (BuildContext context) => readContactsBloc,
      child: BlocListener<ReadContactsBloc, ReadContactsState>(
        listener: (context, state) {
          if (state is ReadContactsSuccess) {
            SharedPrefs.setFirstDBInjection(false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen() /*MainPage()*/),
            );
          }
        },
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Builder(
              builder: (context) {
                final readingContactsState = context.watch<ReadContactsBloc>().state;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset('assets/images/read_contacts.jpg', height: 250),
                    Text(readingContactsState is ReadContactsInitial ? 'Hi, Can I read your contacts?'
                      : readingContactsState is ReadContactsLoading ? 'Thanks, I\'m searching, wait please...'
                      : readingContactsState is ReadContactsSuccess ? 'Congratulations ${readingContactsState.result} contacts found'
                      : 'I\'m sorry, some thing went wrong' , style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                (readingContactsState is ReadContactsInitial || readingContactsState is ReadContactsFailure) ?
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states
                                  .contains(MaterialState.pressed)) {
                                return const Color(0xFF2C66FF);
                              } else {
                                return const Color(0xFF2C66FF);
                              }
                            }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () => readingContacts(context),
                      child: const Padding(
                        padding:
                        EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          'Sure :)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                    : readingContactsState is ReadContactsLoading ? Column(
                      children: const [
                        SizedBox(child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  ReadTimer()
                        )),
                      ],
                    )
                    : const SizedBox(height: 52, width: 52)
                  ],
                );
              }
            ),
          )
        ),
      ),
    );
  }
}
