// ignore_for_file: library_private_types_in_public_api

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../backbone/dependency_injection.dart' as di;
import '../../backbone/bloc_status.dart';
import '../../data/gateway/constants.dart';
import '../../domain/entity/coin.dart';
import '../bloc/coin/bloc.dart';
import '../bloc/global_data/bloc.dart';
import '../bloc/settings/bloc.dart';
import '../components/coin_info_box.dart';
import '../components/refresh_button.dart';
import 'widgets.dart';

class RatingsWidget extends StatefulWidget {
  final Function toggleMarketWidget;

  const RatingsWidget({super.key, required this.toggleMarketWidget});

  @override
  _RatingsWidgetState createState() => _RatingsWidgetState();
}

class _RatingsWidgetState extends State<RatingsWidget>
    with SingleTickerProviderStateMixin {
  List<Coin> coinList = <Coin>[];
  final CoinBloc coinBloc = di.sl.get();
  final GlobalDataBloc globalDataBloc = di.sl.get();
  final SettingsBloc settingsBloc = di.sl.get();
  int amountOfPages = 1;
  int pageNumber = 1;
  String? fiatCurrency;

  bool _ratingsWidget = true;

  final _scrollController = ScrollController();
  bool _isPositionedVisible = true;

  late int coinIndex;
  late String coinName;
  late num currentPrice;
  late String imageUrl;
  late String symbol;
  late num priceChangePercentage;
  late num marketCap;
  late List<double> sparkline;
  late List<FlSpot> lateFlSpotList;
  late String lateFiatCurrency;

  late AnimationController _animationController;
  late Animation<double> _animationFade;

  void _handleGoalScroll() {
    if (_scrollController.offset > 0 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      // scroll is going down, hide the Positioned element
      setState(
        () {
          _isPositionedVisible = true;
        },
      );
    } else if (_scrollController.offset <= 0 ||
        _scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
      // scroll is going up or at the top, show the Positioned element
      setState(
        () {
          _isPositionedVisible = false;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    );

    _animationFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.forward();

    settingsBloc.add(const SettingsEvent.getFiatCurrency());
    settingsBloc.stream.listen(
      (SettingsState state) {
        if (state.status == BlocStatus.Loaded) {
          if (mounted) {
            setState(() {
              fiatCurrency = state.fiatCurrency!;
            });
          }
          globalDataBloc.add(const GlobalDataEvent.getGlobalData());
          coinBloc.add(CoinEvent.getMarketCoins(
              fiatCurrency.toString(), order, pageNumber, perPage100, 'true'));
        }
      },
    );

    _scrollController.addListener(_handleGoalScroll);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 4.1,
      child: _ratingsWidget
          ? Stack(alignment: Alignment.center, children: [
              Column(
                children: <Widget>[
                  Flexible(
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.black,
                      strokeWidth: 2,
                      onRefresh: () {
                        settingsBloc.add(const SettingsEvent.getFiatCurrency());
                        settingsBloc.stream.listen(
                          (SettingsState state) {
                            if (state.status == BlocStatus.Loaded) {
                              coinBloc.add(CoinEvent.getMarketCoins(
                                state.fiatCurrency!,
                                order,
                                pageNumber,
                                perPage100,
                                sparkLineIsTrue,
                              ));
                            }
                          },
                        );
                        return Future<void>.delayed(
                          const Duration(seconds: 1),
                        );
                      },
                      child: BlocBuilder<CoinBloc, CoinState>(
                        bloc: coinBloc,
                        builder: (_, CoinState state) {
                          coinList = state.coins;
                          if (state.status == BlocStatus.Loading) {
                            return Center(
                              child: LoadingAnimationWidget.beat(
                                color: Colors.white,
                                size: 40,
                              ),
                            );
                          } else if (state.status == BlocStatus.Loaded) {
                            return FadeTransition(
                              opacity: _animationFade,
                              child: FadingEdgeScrollView.fromScrollView(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: coinList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final List<FlSpot> flSpotList = <FlSpot>[];

                                    final List<double> newSparkline =
                                        <double>[];
                                    double i = 0;
                                    for (var element
                                        in coinList[index].sparkline) {
                                      i++;
                                      newSparkline.add(element as double);
                                      flSpotList.add(FlSpot(i, element));
                                    }
                                    return InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: CoinInfoBox(
                                        coinIndex: index,
                                        coinName: coinList[index].name!,
                                        currentPrice:
                                            coinList[index].currentPrice!,
                                        imageUrl: coinList[index].image!,
                                        symbol: coinList[index].symbol!,
                                        priceChangePercentage: coinList[index]
                                            .priceChangePercentage!,
                                        marketCap: coinList[index].marketCap!,
                                        sparkline: newSparkline,
                                        flSpotList: flSpotList,
                                        fiatCurrency: fiatCurrency.toString(),
                                      ),
                                      onTap: () => setState(() {
                                        _ratingsWidget = false;
                                        coinIndex = index;
                                        coinName = coinList[index].name!;
                                        currentPrice =
                                            coinList[index].currentPrice!;
                                        imageUrl = coinList[index].image!;
                                        symbol = coinList[index].symbol!;
                                        priceChangePercentage = coinList[index]
                                            .priceChangePercentage!;
                                        marketCap = coinList[index].marketCap!;
                                        sparkline = newSparkline;
                                        lateFlSpotList = flSpotList;
                                        lateFiatCurrency =
                                            fiatCurrency.toString();
                                      }),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else {
                            return Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Center(
                                    child: RefreshButton(),
                                  ),
                                  Positioned(
                                    top: 10,
                                    child: ElevatedButton(
                                        onPressed: () => setState(() {
                                              widget.toggleMarketWidget();
                                            }),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                        child: const Text(
                                          'Back to Finances',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  )
                                ]);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 375),
                top: _isPositionedVisible ? -100 : 10,
                child: ElevatedButton(
                    onPressed: () => setState(() {
                          widget.toggleMarketWidget();
                        }),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text(
                      'Back to Finances',
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ])
          : DetailInfoWidget(
            coinIndex: coinIndex,
            coinName: coinName,
            currentPrice: currentPrice,
            imageUrl: imageUrl,
            symbol: symbol,
            priceChangePercentage: priceChangePercentage,
            marketCap: marketCap,
            sparkline: sparkline,
            flSpotList: lateFlSpotList,
            fiatCurrency: lateFiatCurrency,
            toggleRatingsWidget: () {
              setState(() {
                _ratingsWidget = true;
              });
            },
          ),
    );
  }
}
