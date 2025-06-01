import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/home_store_cubit.dart';
import 'store_items_list.dart';
import 'store_items_grid.dart';

class HomeStoreBody extends StatefulWidget {
  const HomeStoreBody({super.key});

  @override
  State<HomeStoreBody> createState() => _HomeStoreBodyState();
}

class _HomeStoreBodyState extends State<HomeStoreBody> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(isGrid ? Icons.list : Icons.grid_view),
                onPressed: () {
                  setState(() => isGrid = !isGrid);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeStoreCubit, HomeStoreState>(
            builder: (context, state) {
              if (state is HomeStoreError) {
                return Text(state.failure.message);
              }

              if (state is HomeStoreLoaded) {
                final data = state.data;
                return isGrid
                    ? StoreItemsGrid(items: data)
                    : StoreItemsList(items: data);
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
