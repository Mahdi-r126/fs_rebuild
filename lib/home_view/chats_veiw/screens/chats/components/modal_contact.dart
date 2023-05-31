import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:freesms/helpers/contactHelper.dart';
import 'package:freesms/home_view/chats_veiw/screens/chats/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ModalContact extends StatefulWidget {
  const ModalContact({Key? key}) : super(key: key);

  @override
  State<ModalContact> createState() => _ModalContactState();
}

class _ModalContactState extends State<ModalContact> {
  List<Contact> _contacts=[];
  List<Contact>  _selectedContacts=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contacts=ContactHelper.getAll();
  }
  @override
  Widget build(BuildContext context) {
    final selectedContact=Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Select Contact",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(_contacts[index].displayName!,style: TextStyle(color: Colors.black,fontSize: 14),)),
                        Checkbox(
                            value: _selectedContacts.contains(_contacts[index]) ? true : false,
                            onChanged: (value) {
                              if (value!) {
                                _selectedContacts.add(_contacts[index]);
                              } else {
                                _selectedContacts.remove(_contacts[index]);
                              }
                              setState(() {});
                            },
                          checkColor: Colors.white,
                          focusColor: Colors.blueAccent,
                          activeColor: Colors.blueAccent,
                        )
                    ]
                    );
                  },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              ),
            ),
            const SizedBox(height: 20,),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width-40,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: MaterialButton(
            onPressed: () {
              selectedContact.setContact=_selectedContacts;
              Navigator.pop(context);
            },
            child: const Text("Import", style: TextStyle(fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),),
          ),
        )
          ],
        ),
      ),
    );
  }
}
