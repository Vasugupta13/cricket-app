import 'package:cricket_app/src/data/models/player_model.dart';
import 'package:cricket_app/src/presentation/common_blocs/home/home_bloc.dart';
import 'package:cricket_app/src/presentation/screens/edit_player_details/bloc/edit_player_bloc.dart';
import 'package:cricket_app/src/utils/gradient_button.dart';
import 'package:cricket_app/src/utils/snackbars_and_toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPlayerDetailsScreen extends StatefulWidget {
  final PlayerDetailModel player;

  const EditPlayerDetailsScreen({super.key, required this.player});

  @override
  State<EditPlayerDetailsScreen> createState() =>
      _EditPlayerDetailsScreenState();
}

class _EditPlayerDetailsScreenState extends State<EditPlayerDetailsScreen> {
  late EditPlayerBloc creatorBloc;
  late HomeBloc homeBloc;
  final TextEditingController totalRunsController = TextEditingController();
  final TextEditingController ypsController = TextEditingController();
  final TextEditingController dpsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    creatorBloc = BlocProvider.of<EditPlayerBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    totalRunsController.text = widget.player.totalRuns.toString();
    ypsController.text = widget.player.yps.toString();
    dpsController.text = widget.player.dps.toString();
  }

  @override
  void dispose() {
    totalRunsController.dispose();
    ypsController.dispose();
    dpsController.dispose();
    super.dispose();
  }

  Future<void> onSave() async {
    final totalRuns = totalRunsController.text;
    final yps = ypsController.text;
    final dps = dpsController.text;
    creatorBloc.add(EditPlayerDetails(
      playerId: widget.player.id,
      totalRuns: totalRuns,
      yps: yps,
      dps: dps,
    ));
    Future.delayed(const Duration(seconds: 1), () => homeBloc.add(FetchPlayers()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Player Details',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.player.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: totalRunsController,
              decoration: const InputDecoration(labelText: 'Total Runs'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: ypsController,
              decoration: const InputDecoration(
                  labelText: 'Yearly Periodic Score (YPS)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: dpsController,
              decoration: const InputDecoration(
                  labelText: 'Daily Periodic Score (DPS)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            BlocConsumer<EditPlayerBloc, EditPlayerState>(
              listener: (context, state) {
                if (state is EditPlayerDetailsSuccess) {
                  SnackbarsAndToasts.showSuccessSnackbar(
                      context, 'Player details updated successfully');
                } else if (state is EditPlayerDetailsFailure) {
                  SnackbarsAndToasts.showErrorSnackbar(
                      context, 'Failed to update player details');
                }
              },
              builder: (context, state) {
                if (state is EditPlayerDetailsLoading) {
                  return const CircularProgressIndicator();
                }
                return GradientButton(
                  title: 'Save',
                  onTap: onSave,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
