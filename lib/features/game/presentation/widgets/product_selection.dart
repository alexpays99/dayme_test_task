import 'package:flutter/material.dart';
import '../bloc/game/game_bloc.dart';
import '../bloc/game/game_event.dart';
import '../bloc/game/game_state.dart';
import '../widgets/or_widget.dart';
import '../widgets/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSelection extends StatelessWidget {
  final GameLoaded state;

  const ProductSelection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ProductCard(
                    product: state.currentPair[0],
                    isSelected: state.selectedProduct?.productId ==
                        state.currentPair[0].productId,
                    onTap: () => context
                        .read<GameBloc>()
                        .add(SelectProduct(state.currentPair[0])),
                  ),
                ),
                const SizedBox(width: 8.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ProductCard(
                    product: state.currentPair[1],
                    isSelected: state.selectedProduct?.productId ==
                        state.currentPair[1].productId,
                    onTap: () => context
                        .read<GameBloc>()
                        .add(SelectProduct(state.currentPair[1])),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 100,
          child: OrWidget(),
        ),
      ],
    );
  }
}
