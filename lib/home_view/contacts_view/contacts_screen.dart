import 'package:flutter/material.dart';
import 'package:freesms/home_view/widget/drawer.dart';
import '../../Costanat.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

//TODO: delete this screen if unused

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Contact", style: TextStyle(color: Costanat.appBarTextColor,
            fontSize: 20,fontWeight: FontWeight.w700),
        ),
      ),

      body:  Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,
            top: 5.0,bottom: 5.0),
        child: FutureBuilder(
          //method to be waiting for in the future
          future: FlutterContacts.getContacts(withProperties: true),
          builder: (_, snapshot) {

            //if done show data,
            if (snapshot.connectionState == ConnectionState.done) {

              if(snapshot.data == null)
              {
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Container(
                        width: double.maxFinite,
                        // color: Colors.yellowAccent,
                        height: 72,
                        // margin: const EdgeInsets.only(bottom: 20.0),
                        child:
                        Image.asset("assets/images/out-of-stock 1.png",
                          width: 72,height: 72,)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("No Results Found :(",style: TextStyle(
                          color: Color(0xFF0C0D0F),fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      Text("we couldn't find what you searched for. \n Try searching again."
                        ,style: TextStyle(
                            color: Color(0xFF7E8494),fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                        textAlign: TextAlign.center,),
                    )
                  ],),),
                );
              }

               // print(snapshot.data);
              //  var list = snapshot.data as List;
              var list = snapshot.data as List<Contact>;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return
                     ListTile(
                       dense: true,
                      onTap: () {
                        // var aa = list[index].id;
                        print("********************33  ");
                        String number = list[index].phones.first.number;
                        String displayName = list[index].displayName;
                        print("******************** ************************ ");
                      },
                         leading: ConstrainedBox(
                           constraints: const BoxConstraints(
                             minWidth: 46,
                             minHeight: 46,
                             maxWidth: 64,
                             maxHeight: 64,
                           ),
                           child: Image.asset("assets/images/img_avatar_contact.png"
                               , fit: BoxFit.cover),
                         ),

                      title: const Text("",style: TextStyle(
                          color:  Color(0xFF0C0D0F),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "iransansweb"
                      )),
                      subtitle: Text(list[index].phones != null ?
                         list[index].phones.first.toString() : " "
                          ,style: const TextStyle(
                          color:  Color(0xFF7E8494),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "iransansweb"
                      )),
                    );
                  });
            }
            else if (snapshot.hasError) {
              // return widget informing of error
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Error:(",style: TextStyle(
                            color: Color(0xFF0C0D0F),fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                    ],),),
              );
            }
            else {
              //if the process is not finished then show the indicator process
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),

    );
  }


}
