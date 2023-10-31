import 'package:flutter/material.dart';
import 'package:lot_to_do/first_screen.dart';
import 'package:provider/provider.dart';
import 'provider_anime.dart';
import 'package:audioplayers/audioplayers.dart';



class Animati extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final animatiProvider = Provider.of<AnimatiProvider>(context);



//
// Stop playing the sound
final player=AudioPlayer();
Future<void> playAudioFrom(String url) async{
  await player.play(AssetSource(url));
}




    return GestureDetector(
      onTap: () {
        animatiProvider.toggleSelected();
        playAudioFrom('sound.mp3') ;
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        color: !animatiProvider.selected ? Colors.white : Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
          AnimatedDefaultTextStyle(
          duration: const Duration(seconds: 2), // Duration of the animation
          style: TextStyle(
            fontSize: !animatiProvider.selected ? 24.0 : 80,
            fontWeight: !animatiProvider.selected? FontWeight.bold : FontWeight.normal,
            color: !animatiProvider.selected ? Colors.blue : Colors.yellow,
          ),
          child:const  Text('LOT TO DO'),
        ),


             const Image(
                image: AssetImage('assets/app icon.png'),
                fit: BoxFit.cover,
              ),
              Column(


                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FloatingActionButton(onPressed: (){
                    player.stop();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
                  },
                  backgroundColor: Colors.yellow,
                    child: const Icon(Icons.start,color: Colors.red,size: 25,),
                  )

                ],
              )



              ,

            ],
          ),
        ),
      ),
    );
  }
}
