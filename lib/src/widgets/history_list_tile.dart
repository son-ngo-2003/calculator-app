import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:second_app/src/models/formule_model.dart';
import 'package:second_app/src/models/history_model.dart';
import 'package:second_app/src/widgets/sized_icon_button.dart';

class HistoryListTile extends StatelessWidget {
  const HistoryListTile({super.key, required this.id, required this.formule, required this.result, required this.animation});

  final int id;
  final String formule;
  final double result;
  final Animation<double> animation;

  SnackBar getSnackbar(String content) {
    return SnackBar(
      content: Text(content),
      duration: const Duration(milliseconds: 1500),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.all(8.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formuleModel = Provider.of<FormuleModel>(context);
    final historyModel = Provider.of<HistoryModel>(context);
    final theme = Theme.of(context);
    double iconSize = 40.0;

    return SlideTransition(
      position: animation.drive(CurveTween(curve: Curves.easeOut)).drive(Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(result.toString(), style: theme.textTheme.titleMedium?.copyWith(fontSize: 19.0), maxLines: 1,),
          subtitle: Text(formule, maxLines: 1,),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedIconButton(
                icon: Icons.content_copy_outlined,
                size: iconSize,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: result.toString())).then((_){
                    if (!context.mounted) return;
                    final snackBar = getSnackbar('Copied to clipboard successfully!');
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
              ),

              SizedIconButton(
                svgAssetsName: 'lib/assets/icons/copy_to_ans_icon.svg',
                size: iconSize,
                onPressed: () { 
                  formuleModel.setAns(result);
                  final snackBar = getSnackbar('Copied to ANS successfully!');
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),

              SizedIconButton(
                icon: Icons.delete_outline,
                size: iconSize + 4,
                onPressed: () { 
                  historyModel.removeHistory(id); 
                  final snackBar = getSnackbar('Deleted successfully!');
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),

            ],
          ),
          contentPadding: const EdgeInsets.all(5.0),
        ),
      ),
    );
  }
}