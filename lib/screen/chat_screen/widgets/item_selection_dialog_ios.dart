import 'package:flutter/cupertino.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class ItemSelectionDialogIos extends StatelessWidget {
  final VoidCallback onImageBtnClickIos;
  final VoidCallback onVideoBtnClickIos;
  final VoidCallback onCloseBtnClickIos;

  const ItemSelectionDialogIos(
      {Key? key,
      required this.onCloseBtnClickIos,
      required this.onImageBtnClickIos,
      required this.onVideoBtnClickIos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text(
        AppRes.whichItemWouldYouLikeEtc,
        style: TextStyle(color: ColorRes.grey),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: onImageBtnClickIos,
          child: const Text(AppRes.photos),
        ),
        CupertinoActionSheetAction(
          onPressed: onVideoBtnClickIos,
          child: const Text(AppRes.videos),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: onCloseBtnClickIos,
        child: const Text(AppRes.close),
      ),
    );
  }
}
