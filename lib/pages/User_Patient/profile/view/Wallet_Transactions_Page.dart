import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/cubits/cubit/pat_wallet_cubit.dart';

import 'package:medihive_1_/pages/User_Patient/profile/widgets/Custom_Wallet_Tran_Container.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class WalletTransactionsPage extends StatefulWidget {
  WalletTransactionsPage({super.key});

  @override
  State<WalletTransactionsPage> createState() => _WalletTransactionsPageState();
}

class _WalletTransactionsPageState extends State<WalletTransactionsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context
          .read<PatWalletCubit>()
          .getWalletTransactions(context: context, paginating: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<PatWalletCubit>();
    if (walletCubit.transData.isEmpty) {
      walletCubit.getWalletTransactions(context: context);
    }
    return BlocBuilder<PatWalletCubit, PatWalletState>(
      buildWhen: (previous, current) {
        return current is TransSuccess ||
            current is TransFailed ||
            current is TransLaoding ||
            current is PagTransSuccess ||
            current is PagTransFailed;
        // معالجة حالة فشل في pagination
      },
      builder: (context, state) {
        if (state is TransLaoding) {
          return const Loadingindecator();
        } else if (state is TransFailed) {
          return Center(
            child: Text(state.errorMessage!),
          );
        } else if (state is TransSuccess || state is PagTransSuccess) {
          return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 7,
                  ),
              controller: _scrollController,
              itemCount: walletCubit.hasMoreTrans
                  ? walletCubit.transData.length + 1
                  : walletCubit.transData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index < walletCubit.transData.length) {
                  return CustomWalletTranContainer(
                    tranc: walletCubit.transData[index],
                  );
                } else {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              });
        } else if (state is PagTransFailed) {
          return Center(
            child: Text(state.errorMessage!),
          );
        } else {
          return Center(
            child: const SizedBox.shrink(),
          );
        }
      },
    );
  }
}
