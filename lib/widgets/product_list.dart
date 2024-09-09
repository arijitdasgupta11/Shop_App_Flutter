import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata', 'Puma'];
  late String selectedFilter;
  List<Map<String, Object>> filteredProducts = products;
  final TextEditingController tec = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  void _performSearch(String text) {
    final String search = text;
    setState(() {
      filteredProducts = products
          .where((item) => item['title']
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(195, 194, 194, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nColletion',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: tec,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: GestureDetector(
                      onTap: () {
                        _performSearch(tec.text);
                      },
                      child: const Icon(Icons.search),
                    ),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                  onSubmitted: (value) {
                    _performSearch(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                        filteredProducts = selectedFilter != 'All'
                            ? products
                                .where(
                                    (item) => item['company'] == selectedFilter)
                                .toList()
                            : products;
                      });
                      // print(selectedFilter);
                    },
                    child: Chip(
                      label: Text(filter),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  ),
                );
              },
            ),
          ),
          filteredProducts.isNotEmpty
              ? Expanded(
                child: LayoutBuilder(builder: (context,constraints)
                {
                      if(constraints.maxWidth>1231)
                      {
                        return GridView.builder(
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.0,
                            ),
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsPage(
                                            product: product);
                                      },
                                    ),
                                  );
                                },
                                child: ProductCard(
                                  title: product['title'] as String,
                                  price: product['price'] as double,
                                  image: product['imageUrl'] as String,
                                  isEven: index.isEven,
                                ),
                              );
                            },
                          );
                      } 
                      else{
                        return  ListView.builder(
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsPage(
                                            product: product);
                                      },
                                    ),
                                  );
                                },
                                child: ProductCard(
                                  title: product['title'] as String,
                                  price: product['price'] as double,
                                  image: product['imageUrl'] as String,
                                  isEven: index.isEven,
                                ),
                              );
                            },
                          );
                      }
                }),
              )
              : const Center(
                  child: Text('No such shoes found!'),
                ),
        ],
      ),
    );
  }
}
