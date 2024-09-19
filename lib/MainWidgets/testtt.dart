// showDialog(
// context: context,
// builder: (context) {
// String contentText = "Content of Dialog";
// return StatefulBuilder(
// builder: (context, setState) {
// return  AlertDialog(
// insetPadding: EdgeInsets.symmetric(horizontal: 16),
// shape:
// RoundedRectangleBorder(borderRadius: new BorderRadius.circular(24)),
// scrollable: false,
// elevation: 10,
// content: StreamBuilder<Object>(
// stream: null,
// builder: (context, snapshot) {
// return Container(
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Row(
// children: [
// Image.asset(
// "assets/images/walleticon.png",
// width: 49,
// // height: ,
// ),
// SizedBox(width: 16),
// Expanded(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisSize: MainAxisSize.min,
// children: [
// Text(
// 'Note',
// textAlign: TextAlign.left,
// style: bold14,
// ),
// SizedBox(
// height: 4,
// ),
// Text(
// "Provider Name : "+ProviderName +"\n"+
// "Maximum Amount : "+MaximumAmount +"\n"+
// "Minimum Amount : "+MinimumAmount +"\n"+
// "Receivable Amount : "+ReceivableAmount ,
// style: size14_400G
// ),
// SizedBox(
// height: 16,
// ),
// ],
// ),
// ),
// ],
// ),
// Row(
// children: [
// GestureDetector(
// onTap: () {
// Navigator.pop(context);
// // Navigator.push(
// //   context,
// //   MaterialPageRoute(
// //       builder: (context) => CertificatePasscode()),
// // );
// },
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Colors.red.shade400),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 16, vertical: 8),
// child: Text(
// "Dismiss",
// style: txt14SemiWhite,
// ),
// ),
// ),
// ),
// SizedBox(width: 10,),
// GestureDetector(
// onTap: () async{
//
//
// var rsp = await RechargeApi(
// ProviderCode,
// numController.text.toString(),
// Our_SendValue,
// SkuCode,
// ReceiveValue,
// CoupenTitle,
// type);
//
// Navigator.pop(context);
//
// // Navigator.push(
// //   context,
// //   MaterialPageRoute(
// //       builder: (context) => RechargeNow(
// //         id: SkuCode.toString(),
// //         type: "1",
// //         num: numController.text.toString(),
// //       )),
// // );
// },
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: themeBlue),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 16, vertical: 8),
// child: Text(
// "Recharge",
// style: txt14SemiWhite,
// ),
// ),
// ),
// ),
// ],
// )
// ],
// ),
// );
// }),
// )
// },
// );
// },
// );