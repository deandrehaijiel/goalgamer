import 'package:flutter/material.dart';

import '../../backbone/dependency_injection.dart' as di;
import '../../backbone/bloc_status.dart';
import '../../data/gateway/constants.dart';
import '../bloc/coin/bloc.dart';
import '../bloc/global_data/bloc.dart';
import '../bloc/settings/bloc.dart';

class RefreshButton extends StatefulWidget {
  final void Function()? onPressed;
  const RefreshButton({
    super.key,
    this.onPressed,
  });

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {
  final CoinBloc coinBloc = di.sl.get();
  final GlobalDataBloc globalDataBloc = di.sl.get();
  final SettingsBloc settingsBloc = di.sl.get();
  int pageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      splashRadius: 0.1,
      onPressed: () {
        // ignore: unnecessary_statements
        widget.onPressed;
        settingsBloc.add(const SettingsEvent.getFiatCurrency());
        settingsBloc.stream.listen(
          (SettingsState state) {
            if (state.status == BlocStatus.Loaded) {
              globalDataBloc.add(const GlobalDataEvent.getGlobalData());
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
      },
      icon: const Icon(Icons.refresh, color: Colors.black),
    );
  }
}
