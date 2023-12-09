import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/home_page_bloc/bloc/home_page_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardGroup extends StatefulWidget {
  final String subject;
  final Widget? widgetCard;
  const CardGroup(String s, {Key? key, required this.subject, this.widgetCard})
      : super(key: key);

  @override
  _CardGroupState createState() => _CardGroupState();
}

class _CardGroupState extends State<CardGroup> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25.0), // Set your desired border radius
          ),
        ),
        child: Skeleton.ignorePointer(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.3,
                  strokeAlign: BorderSide.strokeAlignInside,
                  color: HomePageState().isLoading  == true ? Color(0xFF1A9CB0) : Colors.grey.shade200,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Container(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("${widget.subject}",
                          style: TextStyle(
                              color: Color(0xFF15616D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto")),
                    ),
                    BlocBuilder<WalletBloc, WalletState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {context.read<WalletBloc>().add(GetAllWallet(1));},
                          style: TextButton.styleFrom(
                            shape: StadiumBorder(),
                            foregroundColor: Colors.black,
                          ),
                          child: Row(
                            children: [
                              Text("more",
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontSize: 14,
                                      fontFamily: "Roboto")),
                              Icon(
                                Icons.navigate_next,
                                color: Color(0xFF707070),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}
