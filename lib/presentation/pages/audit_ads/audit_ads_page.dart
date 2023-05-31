import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../apis/apis.dart';
import '../../../models/sponsor_ad.dart';
import '../../shared/utils/injection_container.dart';
import 'audit_ads_bloc.dart';
import 'audit_ads_state.dart';
import 'widgets/page_number_button.dart';

class AuditAdsPage extends StatefulWidget {
  const AuditAdsPage({Key? key}) : super(key: key);

  @override
  State<AuditAdsPage> createState() => _AuditAdsPageState();
}

class _AuditAdsPageState extends State<AuditAdsPage> {
  bool _isSearch = false;
  final TextEditingController _controller = TextEditingController();
  final List<Widget> _tabs = const [
    Tab(
      child: Text(
        'Waiting list',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    ),
    Tab(
      child: Text(
        'Confirmed',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    ),
    Tab(
      child: Text(
        'Pause',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    )
  ];
  var _page = 1;
  final _limit = 5;


  @override
  Widget build(BuildContext context) {
    AuditAdsBloc auditAdsBloc = sl<AuditAdsBloc>();

    return DefaultTabController(
      length: 3,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) =>
                auditAdsBloc..getAdsForAudit(_limit, _page),
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'Audit Ads',
            ),
            bottom: TabBar(tabs: _tabs),
          ),
          body: Builder(builder: (context) {
            final getAdsState = context.watch<AuditAdsBloc>().state;
            return SizedBox(
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).size.height - 144) * 0.1,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: _controller,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              top: 10.0, right: 30, left: 30, bottom: 10.0),
                          suffixIcon: _isSearch
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.indigo,
                                  ),
                                  widthFactor: 15,
                                  heightFactor: 15,
                                )
                              : GestureDetector(
                                  child: const Icon(Icons.search),
                                  onTap: () {
                                    setState(() {
                                      if (_controller.text.isEmpty) {
                                        _isSearch = false;
                                      } else {
                                        _isSearch = true;
                                      }
                                    });

                                    setState(() {
                                      _isSearch = false;
                                    });
                                  },
                                ),
                          hintText: 'search',
                        ),
                        onEditingComplete: () {
                          setState(() {
                            if (_controller.text.isEmpty) {
                              _isSearch = false;
                            } else {
                              _isSearch = true;
                            }
                          });
                          setState(() {
                            _isSearch = false;
                          });
                        },
                      ),
                    ),
                  ),
                  getAdsState is AuditAdsSuccess
                      ? Expanded(
                          child: TabBarView(
                            children: [
                              adsListView(context, getAdsState.auditAdsModel.adsList.where((element) => element.status == 'WAITING').toList()),
                              adsListView(context, getAdsState.auditAdsModel.adsList.where((element) => element.status == 'CONFIRMED').toList()),
                              adsListView(context, getAdsState.auditAdsModel.adsList.where((element) => element.status == 'PAUSE').toList()),
                            ],
                          ))
                      : getAdsState is AuditAdsFailure
                          ? Text(getAdsState.error)
                          : const Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: getAdsState is AuditAdsSuccess ? makePagination(context, getAdsState) : const [SizedBox()],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget adsListView(BuildContext pContext, List<SponsorAd>? adsList) {
    return SizedBox(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: adsList!.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(10.0),
                child: adsList.isNotEmpty
                    ? createAdsRow(pContext, adsList, index)
                    : const SizedBox(
                        child: Center(child: Text('Fetching data failed')),
                      ));
          }),
    );
  }

  Widget createAdsRow(BuildContext context, List<SponsorAd>? ads, int index) {
    SponsorAd a = ads![index];
    return Container(
      decoration:  BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(3.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'mainText',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.text,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'additionalText',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.additionalText ?? '',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'fee',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${a.fee}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'senderFee',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${a.senderFee}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'receiverFee',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${a.receiverFee}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'maximumViewPerSender',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${a.maximumViewPerSender}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'maximumViewPerReceiver',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${a.maximumViewPerReceiver}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'orderCount',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${a.orderCount}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'senderMobileTypes',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.senderMobileTypes.join(", "),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'receiverMobileTypes',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.receiverMobileTypes.join(", "),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'senderOperators',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.senderOperators.join(", "),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'receiverOperators',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.receiverOperators.join(", "),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'senderMobileNumbers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.senderMobileNumbers.join(", "),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'receiverMobileNumbers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            a.receiverMobileNumbers.join(", "),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: Center(
          //     child: Image.memory(
          //       convertBase64Image(a.image ?? ''),
          //       height: 144,
          //       width: 256,
          //       alignment: Alignment.center,
          //       errorBuilder: (context, error, stackTrace) => const Text(''),
          //       gaplessPlayback: true,
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Checkbox(
              value: (a.status == 'CONFIRMED') ? true : false,
              onChanged: (value) {
                if (a.status == 'WAITING') {
                  auditTheAds(context, a.adId, 'CONFIRMED');
                } else if (a.status == 'CONFIRMED') {
                  auditTheAds(context, a.adId, 'PAUSE');
                } else {
                  auditTheAds(context, a.adId, 'CONFIRMED');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Uint8List convertBase64Image(String base64String) {
    return const Base64Decoder().convert(base64String);
  }

  List<Widget> makePagination(BuildContext context, AuditAdsSuccess state) {
    int totalItems = state.auditAdsModel.totalItems;
    int itemsPerPage = 5;
    int totalPages = (totalItems ~/ itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0);

    List<Widget> pages = [];
    for(int i = 1; i <= totalPages; i++) {
      pages.add(GestureDetector(
        onTap: (){
          _page = i;
          context.read<AuditAdsBloc>().getAdsForAudit(_limit, i);
        },
        child: PageNumberButton(
          pageNumber: i,
          isSelected: _page == i,
        ),
      ));
    }
    return pages;
  }

  // TODO: this is not clean
  Future<void> auditTheAds(BuildContext context, String? adId, String status) async {
    Apis api = Apis();
    List<dynamic> response = await api.auditAds(adId, status);
    if (response[0] != null) {
      context.read<AuditAdsBloc>().getAdsForAudit(_limit, _page);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response[1], textAlign: TextAlign.center),
      ));
    }
  }
}
