import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/couter_bloc.dart';

class CounterPage extends StatelessWidget{
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: BlocBuilder<CounterBloc,int>(
        builder: (context, count) {
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: EdgeInsets.all(5),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: ()=> context.read<CounterBloc>().add(IncrementEvent()),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(5),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: ()=> context.read<CounterBloc>().add(DecrementEvent()),
            ),
          )
        ],
      ),
    );
  }
}