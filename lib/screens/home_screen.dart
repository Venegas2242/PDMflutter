import 'package:flutter/material.dart';
import '../models/list_model.dart';
import 'detail_screen.dart';
import '../witdgets/contact_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _listController;
  late List<Animation<Offset>> _listSlideAnimations;

  List<GameModel> gameList = [
    GameModel(name: 'Dream League Soccer 2023', shortDescription: 'FIFPRO licensed soccer', longDescription: "Dream League Soccer 2023 puts you in the heart of the action with a fresh look and brand new features! Build your dream team from over 4,000 FIFPRO licensed players and take to the field against the world's best soccer clubs!", imagePath: 'assets/image1.png', imagePath2: 'assets/image1_2.jpeg'),
    GameModel(name: 'EA SPORTS FC MOBILE 24', shortDescription: 'Kickoff with football stars!', longDescription: "Welcome to EA SPORTS FC™ MOBILE! Join us in building the future of football and assemble your Ultimate Team™ from the world's top players, clubs, and leagues. Collect Player Items of world-class talent like Vini Jr., Erling Haaland, Virgil van Dijk, and Son Heung-min. Play as Real Madrid from LALIGA EA SPORTS, or Manchester City from the Premier League and many more.", imagePath: 'assets/image2.png', imagePath2: 'assets/image2_2.png'),
    GameModel(name: 'Stumble Guys', shortDescription: 'Fun multiplayer knockout game', longDescription: "Stumble Guys is a massive multiplayer party knockout game with up to 32 players online. Join millions of players and stumble to victory in this fun multiplayer knockout battle royale! Are you ready to enter the running chaos? Running, stumbling, falling, jumping, and winning has never been so fun!", imagePath: 'assets/image3.jpeg', imagePath2: 'assets/image3_2.jpeg'),
    GameModel(name: 'Brawl Stars', shortDescription: 'Epic 3v3 and Battle Royale', longDescription: "Fast-paced 3v3 multiplayer and battle royale made for mobile! Play with friends or solo across a variety of game modes in under three minutes.", imagePath: 'assets/image4.png', imagePath2: 'assets/image4_2.jpeg'),
    GameModel(name: 'Candy Crush Saga', shortDescription: 'Sweet Match 3 Puzzle Games', longDescription: "Start playing Candy Crush Saga today - a legendary puzzle game loved by millions of players around the world. \nWith over a trillion levels played, this sweet match 3 puzzle game is one of the most popular mobile games of all time!", imagePath: 'assets/image5.jpeg', imagePath2: 'assets/image5_2.png'),
    GameModel(name: 'Mobile Legends: Bang Bang', shortDescription: 'Play with the world!', longDescription: "Join your friends in Mobile Legends: Bang Bang, the brand new 5v5 MOBA showdown, and fight against real players! Choose your favorite heroes and build the perfect team with your comrades-in-arms! 10-second matchmaking, 10-minute battles. \nLaning, jungling, pushing, and teamfighting, all the fun of PC MOBA and action games in the palm of your hand! Feed your eSports spirit!", imagePath: 'assets/image6.jpeg', imagePath2: 'assets/image6_2.jpg'),
    GameModel(name: 'League of Legends: Wild Rift', shortDescription: 'Competitive 5v5 MOBA Action', longDescription: "Dive into 5v5 MOBA action with League of Legends: Wild Rift. This battle arena game, reimagined for mobile, brings faster matches, new champions & strategic objectives.\nIt's League of Legends by Riot Games, now built from the ground up for mobile PvP battles. Dive into Wild Rift's fast-paced multiplayer strategy games with smooth controls and endless online battle arena action.", imagePath: 'assets/image7.jpeg', imagePath2: 'assets/image7_2.png'),
    GameModel(name: 'Dragon City - Breed & Battle!', shortDescription: 'Collect, merge & fight dragons', longDescription: "Ready to master this dragon game and collect and breed tons of adorable fire-breathing dragons?\nBuild a Dragon City on floating islands, fill it with farms, habitats, buildings...and tons of dragons!\nTrain them to your will, feed and evolve them into stunning monsters and prove your might to be the top Dragon Master in the world!", imagePath: 'assets/image8.jpg', imagePath2: 'assets/image8_2.jpg'),
    GameModel(name: 'Clash of Clans', shortDescription: 'Lead Your Clan to Victory!', longDescription: "Join millions of players worldwide as you build your village, raise a clan, and compete in epic Clan Wars!\nMustachioed Barbarians, fire wielding Wizards, and other unique troops are waiting for you! Enter the world of Clash!", imagePath: 'assets/image9.jpg', imagePath2: 'assets/image9_2.jpg'),
    GameModel(name: 'Clash Royale', shortDescription: 'Epic Real-Time PvP Battles', longDescription: "Enter the Arena! Build your Battle Deck and outsmart the enemy in fast real-time battles. From the creators of CLASH OF CLANS comes a realtime multiplayer battle game starring your favourite Clash characters and more. Start battling against players from around the world!", imagePath: 'assets/image10.jpeg', imagePath2: 'assets/image10_2.jpeg'),
  ];

  @override
  void initState() {
    super.initState();

    _listController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    // Inicializa la lista de animaciones de deslizamiento.
    _listSlideAnimations = List.generate(
      gameList.length,
          (index) => Tween<Offset>(
        begin: Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _listController, curve: Curves.easeInOut),
      ),
    );

    // Iniciar la animación cuando se carga la pantalla
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _listController.forward();
    });
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Must-Play Games')),
      body: ListView.builder(
        itemCount: gameList.length + 1,
        itemBuilder: (context, index) {
          if (index == gameList.length) {
            // Mostrar el formulario en el último ítem de la lista
            return AddContactForm(onSubmit: (formData) {
              // Procesar los datos del formulario y mostrarlos en el modal
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Información de la app ingresada'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nombre de la app: ${formData['appName']}'),
                        Text('Descripción: ${formData['description']}'),
                        Text('Número de versión: ${formData['versionNumber']}'),
                        Text('Número de teléfono de soporte: ${formData['supportPhoneNumber']}'),
                        Text('Fecha de lanzamiento: ${formData['releaseDate']}'),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            });
          } else {
            return SlideTransition(
              position: _listSlideAnimations[index]!,
              child: ListTile(
                title: Text(gameList[index].name),
                subtitle: Text(gameList[index].shortDescription),
                leading: Image.asset(gameList[index].imagePath),
                trailing: IconButton(
                  icon: Icon(gameList[index].isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      gameList[index].isFavorite = !gameList[index].isFavorite;
                    });
                  },
                ),
                onTap: () async {
                  // Navega a la pantalla de detalles y espera un resultado.
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(gameList[index])),
                  );

                  // Actualiza el estado de favorito en la lista según el resultado.
                  if (result != null && result is bool) {
                    // Actualizar el estado de favorito en la lista
                    setState(() {
                      gameList[index].isFavorite = result;
                    });
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}