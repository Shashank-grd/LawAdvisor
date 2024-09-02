import 'package:flutter/material.dart';
import 'package:lawadvisor/screens/lawyer-detail.dart';

class SearchCard extends StatefulWidget {
  final snap;
  const SearchCard({Key? key,required this.snap}) : super(key: key);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {

  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LawyerDetailScreen(snap: widget.snap)));
    },
    child:ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.snap['photoUrl']),
      ),
      title: Text(
        widget.snap['username'],
      ),
      subtitle: Text(
       widget.snap['city'], // Show the city in the list
      ),
      trailing: Text(
       widget.snap['speci'] ,
        style: const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      ), // S,
    ),
    );
  }
}