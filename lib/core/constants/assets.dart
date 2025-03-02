import 'package:flutter_svg/flutter_svg.dart';

abstract class ImageAssets {
  final String asset;

  ImageAssets(this.asset);

  SvgPicture get svg => SvgPicture.asset(asset);
}

enum GameImageAssets implements ImageAssets {
  activeCoin('assets/images/active_coin.svg'),
  activeLike('assets/images/active_like.svg'),
  close('assets/images/close.svg'),
  defaultCoin('assets/images/default_coin.svg'),
  defaultLike('assets/images/default_like.svg'),
  promoIcon('assets/images/promo_icon.svg'),
  winIcon('assets/images/win_icon.svg'),
  wheelImg('assets/images/wheel_img.svg'),
  coinsImg('assets/images/coins_img.svg');

  @override
  final String asset;

  const GameImageAssets(this.asset);

  @override
  SvgPicture get svg => SvgPicture.asset(asset);
}
