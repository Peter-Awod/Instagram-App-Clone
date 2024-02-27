import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state)  {},
      builder: (context, state) {
        return Center(
          child: Text(
              'Search'
          ),
        );
      },
    );
  }
}
