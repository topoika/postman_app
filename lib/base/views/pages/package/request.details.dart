import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/package.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/package.dart';
import '../../../data/models/request.dart';
import '../../components/buttons.dart';
import '../../components/packages/image.slider.dart';
import '../../components/packages/request.list.dart';
import '../../components/universal.widgets.dart';

class RequestDetails extends StatefulWidget {
  final Request request;
  const RequestDetails({super.key, required this.request});

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends StateMVC<RequestDetails> {
  late PackageController con;
  _RequestDetailsState() : super(PackageController()) {
    con = controller as PackageController;
  }
  Package? package;
  @override
  void initState() {
    super.initState();
    setPackage();
  }

  void setPackage() async {
    await con.getOnePackage(widget.request.packageId!).then((value) {
      setState(() => package = value);
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool mine = widget.request.recieverId! == activeUser.value.id;
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "Request Details",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: package == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                SliderWithIndicators(images: package!.images),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              package!.name ?? "",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                color: greenColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${widget.request.postFee ?? 0.toStringAsFixed(2)}',
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: statusColor(widget.request.status!),
                        ),
                        child: Text(
                          widget.request.status!.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.redAccent.withOpacity(.12),
                            ),
                            child: const Icon(Icons.location_on_rounded,
                                color: Colors.redAccent, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "${widget.request.trip!.departureDetails!.address!.nameAddress} - ${widget.request.trip!.departureDetails!.address!.city}",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        alignment: Alignment.centerLeft,
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.redAccent.withOpacity(.5),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.redAccent.withOpacity(.12),
                            ),
                            child: const Icon(Icons.location_on_rounded,
                                color: Colors.redAccent, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "${widget.request.trip!.destinationDetails!.address!.nameAddress} - ${widget.request.trip!.destinationDetails!.address!.city}",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 30,
                        color: Colors.black12,
                        thickness: .9,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              widget.request.trip!.traveller!.image != null
                                  ? showLargeImage(
                                      context,
                                      widget.request.trip!.traveller!.image,
                                      null)
                                  : toastShow(
                                      context, "No profile picture", "nor");
                            },
                            child: Container(
                              height: getWidth(context, 10),
                              width: getWidth(context, 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.3),
                                image: widget.request.trip!.traveller!.image !=
                                        null
                                    ? DecorationImage(
                                        image: cachedImage(widget.request.trip!
                                                .traveller!.image ??
                                            noUserImage),
                                        fit: BoxFit.fill,
                                      )
                                    : null,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                              ),
                              child:
                                  widget.request.trip!.traveller!.image == null
                                      ? const Icon(
                                          Icons.person,
                                          color: Colors.black,
                                          size: 30,
                                        )
                                      : const SizedBox(),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.request.trip!.traveller!.username ?? "",
                            textScaleFactor: 1,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Visibility(
                        visible: widget.request.status == "accepted",
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Congratulations!",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: statusColor(widget.request.status!),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                "Postman accepted your request",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      buttonOne(
                          widget.request.status == "accepted"
                              ? "Pay Now"
                              : "Message Postman",
                          true, () {
                        if (widget.request.status == "accepted") {
                          Navigator.pushNamed(context, "/PaymentPage",
                              arguments: widget.request);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, "/ConversationPage",
                              arguments: widget.request.trip!.traveller);
                        }
                      })
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
