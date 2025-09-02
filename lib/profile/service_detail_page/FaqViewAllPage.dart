import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';

class FaqViewAllPage extends StatelessWidget {
  final List<Map<String, dynamic>> faqList;

  const FaqViewAllPage({super.key, required this.faqList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF252525),
                        size: 18.0,
                      ),
                    ),
                  ),
                  Text(
                    'FAQs',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'primaryFont',
                          color: Color(0xFF252525),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(width: 36.0),
                ],
              ),
            ),
            Expanded(
              child: faqList.isEmpty
                  ? Center(
                      child: Text(
                        'No data found',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'primaryFont',
                              color: Color(0xFF898989),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CollapsibleFaqList(faqList: faqList),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CollapsibleFaqList extends StatelessWidget {
  final List<Map<String, dynamic>> faqList;

  const CollapsibleFaqList({super.key, required this.faqList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: faqList.length,
      separatorBuilder: (_, __) => SizedBox(height: 6.0),
      itemBuilder: (context, index) {
        final faq = faqList[index];
        return ExpandableNotifier(
          initialExpanded: false,
          child: ExpandablePanel(
            header: Text(
              faq['question'] ?? '',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'primaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
            ),
            collapsed: Container(),
            expanded: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                faq['answer'] ?? '',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'primaryFont',
                      fontSize: 14,
                    ),
              ),
            ),
            theme: const ExpandableThemeData(
              tapHeaderToExpand: true,
              tapBodyToExpand: true,
              tapBodyToCollapse: true,
              hasIcon: true,
            ),
          ),
        );
      },
    );
  }
}
