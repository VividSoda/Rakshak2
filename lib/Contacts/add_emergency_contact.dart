import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rakshak_test/Contacts/select_contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<Contact> emergencyContact = [];
  late Contact contact;
  List<String> recipients = [];

  addItemToList(){
    setState(() {
      emergencyContact.add(contact);
    });
  }

  deleteListItem(Contact _contact){
    setState(() {
      emergencyContact.remove(_contact);
    });
  }

  addRecipients(){
    setState(() {
      recipients.add(contact.phones!.elementAt(0).value.toString());
    });
  }

  deleteRecipients(Contact contact){
    setState(() {
      recipients.remove(contact.phones!.elementAt(0).value.toString());
    });
  }

  _sendSMS(String message, List<String> recipients) async{
    await Permission.sms.request();
    await sendSMS(message: message, recipients: recipients,sendDirect: true).catchError((onError){
      return "Message cannot be sent: $onError";
    });
  }

  @override
  Widget build(BuildContext context) {
    int emergencyContactLength = emergencyContact.length;
    bool emergencyListExist = (emergencyContact.isNotEmpty);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Emergency Contacts"),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children:[
              const Center(
                  child: Text(
                    "Messaging Alerts",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  )
              ),

              const SizedBox(height: 10),

              (emergencyListExist)? Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: emergencyContact.length,
                      itemBuilder: (context,index){
                        Contact contact = emergencyContact[index];
                        return ListTile(
                          title: Text('${contact.displayName}'),
                          subtitle: Text(contact.phones!.isNotEmpty ? '${contact.phones!.elementAt(0).value}' : ''),
                          leading: (contact.avatar != null && contact.avatar!.isNotEmpty) ?
                          CircleAvatar(
                            backgroundImage: MemoryImage(contact.avatar!),
                          ) :
                          CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(contact.initials()),
                          ),
                          trailing: IconButton(
                              onPressed: (){
                                contact = emergencyContact[index];
                                deleteListItem(contact);
                                deleteRecipients(contact);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )
                          ),
                        );
                      }
                  )
              ):
              Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text("No items added")
              ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String message;
                    message = "I might be in danger at this location \n"
                        "(https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}).\n"
                        "Powered by Rakshak";
                    _sendSMS(
                        message, recipients);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Message Successful'
                            ),
                            backgroundColor: Colors.green
                        )
                    );
                  },
                  child: const Text("Send message")
              )
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          if(emergencyContactLength<3){
            contact = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SelectContactPage())
            );
            addItemToList();
            addRecipients();
          }

          else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
                content: Text("Maximum allowed : 3"),
              ),
            );
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
