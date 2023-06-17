import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_app/widgets/item_restaurant.dart';

// tinggal menampilkan hasil pencarian di UI
// CAPE ANJING

class SearchRestaurant extends StatefulWidget {
  static const routeName = '/search_restaurant';

  const SearchRestaurant({super.key});

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  final List result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find your favourite restaurant here.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ChangeNotifierProvider(
                create: (context) => RestaurantProvider(),
                child: Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    return TextField(
                      onChanged: (value) async {
                        var res = await RestaurantProvider().searchRestaurant(value);

                        // print('state: ${context.watch<RestaurantProvider>().state}');
                        result.clear();
                        result.add(res.restaurants);

                        print('resultsssss: $result');
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(23, 74, 98, 163),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                        ),
                        hintText: 'ex: restaurant name, menu...',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12
                        ),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.white
                      ),
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    );
                  }
                ),
              ),
              const SizedBox(height: 10),
              // FOR EXAMPLE
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final restaurant = result[index];
                  print('restaurant: $restaurant');
                  // return ItemRestaurant(restaurant: restaurant);
                  return Text('ok');
                },
              )
              // Expanded(
              //   child: ChangeNotifierProvider(
              //     create: (context) => RestaurantProvider(),
              //     child: Consumer<RestaurantProvider>(
              //       builder: (context, state, _) {
              //         print('state: ${state.state}');
              //         if (state.state == ResultState.loading) {
              //           return const Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         } else {
              //           if (state.state == ResultState.hasData) {
              //             return ListView.builder(
              //               itemCount: state.result.total,
              //               itemBuilder: (context, index) {
              //                 final restaurant = state.result.restaurants[index];
              //                 return ItemRestaurant(restaurant: restaurant);
              //               },
              //             );
              //           } else if (state.state == ResultState.noData) {
              //             return const Center(
              //               child: Text('No restaurants is found'),
              //             );
              //           } else if (state.state == null) {
              //             return const Text('');
              //           } else {
              //             return const Center(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(
              //                     Icons.wifi_off_outlined,
              //                     size: 50,
              //                   ),
              //                   Text(
              //                     'You are currently offline',
              //                     style: TextStyle(
              //                       fontSize: 15
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             );
              //           }
              //         }
              //       },
              //     ),
              //   )
              // ),
            ]
          ),
        )
      ),
    );
  }
}