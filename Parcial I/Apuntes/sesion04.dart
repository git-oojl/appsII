//Sesion04
//Funciones

//Funcion de entrada principal
void main(){
  print("Esta es la sesion de funciones");
  suma();
  print(sumaStr());
  print(sumaP(7,3));
  print(sumaPO(14, 2));
  print(sumaPO(14));
  print(sumaPNom(b:14, a:2));

}

//funcion sin parámetros
void suma(){
  print("a + b = c");
}
//funcion sin parámetros que retorna un valor
String sumaStr(){
  return "a + b = c";
}
//funcion con parámetros
String sumaP(int a, int b){
  return "$a + $b = ${a + b}";
}

/**
 * funcion con parámetros opcionales
Uso: sumaPO(14), sumaPO(14,2)
*/
String sumaPO(int a, [int? b]){
  b = b ?? 0;
  return "$a + $b = ${a + b}";
}

/**
 * funcion con parámetros opciones tipo2
Uso: sumaPO2(14), sumaPO2(14,2)
 */
String sumaPO2(int a, [int? b]){
  b ??= 0;
  return "$a + $b = ${a + b}";
}
/**
 * funcion con parámetros nombrados
 * a es un parámetro opcional
 * b es un parámetros obligatorio
 * Uso: print(sumaPNom(b:14, a:2)), print(sumaPNom(b:14))
 */
String sumaPNom({int a=0,  required int b}){
  return "$a + $b = ${a + b}";
}