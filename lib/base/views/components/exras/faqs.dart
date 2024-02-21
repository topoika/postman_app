// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/extras.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/faq.dart';
import '../../pages/more/faq.page.dart';
import '../buttons.dart';
import '../input/universal.widget.dart';

class FAQsList extends StatefulWidget {
  final List<FAQ> faqs;
  final Function init;
  const FAQsList({
    Key? key,
    required this.faqs,
    required this.init,
  }) : super(key: key);

  @override
  State<FAQsList> createState() => _FAQsListState();
}

class _FAQsListState extends State<FAQsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.faqs.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemBuilder: (context, index) {
        final faq = widget.faqs[index];
        return Dismissible(
          key: ValueKey(faq.id),
          onDismissed: (DismissDirection direction) {
            if (isAdmin()) {}
            ExtraController().deleteFaq(faq).then((value) {
              widget.init();
            });
          },
          child: InkWell(
            onTap: () {
              if (isAdmin()) {
                showFaqInputForm(context, faq, () => widget.init());
              }
            },
            splashColor: Colors.grey.withOpacity(.2),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () => setState(() => faq.open = !faq.open!),
                    splashColor: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            faq.title!,
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: greenColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: .9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            faq.open!
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: Colors.black54,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: faq.open!,
                    child: Text(
                      faq.description!,
                      textAlign: TextAlign.left,
                      textScaleFactor: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FAQInputForm extends StatefulWidget {
  final FAQ faq;
  final Function onSubmit;
  const FAQInputForm({super.key, required this.faq, required this.onSubmit});

  @override
  _FAQInputFormState createState() => _FAQInputFormState();
}

class _FAQInputFormState extends StateMVC<FAQInputForm> {
  late ExtraController con;
  _FAQInputFormState() : super(ExtraController()) {
    con = controller as ExtraController;
  }
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    bool edit = widget.faq.id != null;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: con.formKey,
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          shrinkWrap: true,
          children: <Widget>[
            mainHeading(context, edit ? "Edit FAQ" : "Add new FAQ"),
            const SizedBox(height: 20),
            InputFieldItem(
              hint: "Title",
              label: "Question",
              onValidate: (val) => con.setError(val),
              type: "text",
              onsaved: (val) => widget.faq.title = val,
              init: widget.faq.title,
            ),
            InputFieldItem(
              hint: "Answer Description",
              label: "Answer",
              onValidate: (val) => con.setError(val),
              type: "description",
              onsaved: (val) => widget.faq.description = val,
              init: widget.faq.description,
            ),
            Visibility(
                visible: loading,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
            Visibility(
              visible: !loading,
              child:
                  buttonOne(edit ? "Update FAQ" : "Submit FAQ", true, () async {
                if (con.formKey.currentState!.validate()) {
                  setState(() => loading = true);
                  con.formKey.currentState!.save();
                  if (edit) {
                    await con.updateFaq(widget.faq);
                  } else {
                    await con.addFaq(widget.faq);
                  }
                  setState(() => loading = false);
                  Navigator.pop(context);
                  widget.onSubmit();
                } else {
                  con.error != null
                      ? toastShow(context, con.error.toString(), "err")
                      : null;
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
