//Estructuras de control

void main(){

  final int edad = 23;
  final List<int> numeros = <int>[1, 3, 5, 9, 7, 2, 14, 11];
  final int opcion = 5;
  int bandera = 10;

  print("La edad es: $edad");

  // print("El numero 0: ${numeros[0]}");

  //if
  // if( edad > 18){
  //   print("Es mayor de edad");
  // }

  //if -else
  // if( edad > 18){
  //   print("Es mayor de edad");
  // }
  // else{
  //   print("No es mayor de edad");
  // }
  
  print("${ edad > 18? 'SI':'NO'} es mayor de edad");

  //switch
  switch(opcion){
    case 0:{
      print("La opción fue 0");
      break;
    }
    case 1:{
      print("La opción fue 1");
      break;
    }
    case 2:{
      print("La opción fue 2");
      break;
    }
    default:{
      print("Opción no válida");
    }break;
  }
  
  //for clasico
  for(int i=0; i<numeros.length;i++){
    print("El elemento $i es ${numeros[i]}");
  }
  //for in
  print("Utilizando for in");
  for( int numero in numeros){
    print("El numero es: $numero");
  }
  //while
  print("Uso de while");
  while(bandera > 0){
    print("Bandera = ${bandera--}");
  }
  //dowhile

  print("Media");
  media(numeros);
}

int media( List<int> arreglo){
  return ;
}