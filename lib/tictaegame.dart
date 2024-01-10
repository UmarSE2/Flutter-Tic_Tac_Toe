import 'package:flutter/material.dart';

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tic Tac Toe',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 110, 115, 218),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
             margin: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 97, 101, 182),
                  padding: EdgeInsets.all(10),
                ),
              ),
            ),
           
            TicTacToeScreen(),
          ],
        ),
      ),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<List<String>> board =
      List.generate(3, (i) => List.generate(3, (j) => ''));

  bool player1Turn = true;
  int moves = 0;

  void resetGame() {
    setState(() {
      board = List.generate(3, (i) => List.generate(3, (j) => ''));
      player1Turn = true;
      moves = 0;
    });
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '') {
      setState(() {
        board[row][col] = player1Turn ? 'X' : 'O';
        player1Turn = !player1Turn;
        moves++;

        if (checkWin(row, col)) {
          showResultDialog(player1Turn ? 'Player O wins!' : 'Player X wins!');
        } else if (moves == 9) {
          showResultDialog('It\'s a draw!');
        }
      });
    }
  }

  bool checkWin(int row, int col) {
    if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
      return true; // Check row
    }

    if (board[0][col] == board[1][col] && board[1][col] == board[2][col]) {
      return true; // Check column
    }

    if (row == col &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return true; // Check main diagonal
    }

    if (row + col == 2 &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return true; // Check other diagonal
    }

    return false;
  }

  void showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            int row = index ~/ 3;
            int col = index % 3;
            return GestureDetector(
              onTap: () => makeMove(row, col),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Center(
                  child: Text(
                    board[row][col],
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: resetGame,
          child: Text('Reset Game' ,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 97, 101, 182)),
                  ),
          style: TextButton.styleFrom(
                    primary:Colors.white,
                  ),
        ),
      ],
    );
  }
}
