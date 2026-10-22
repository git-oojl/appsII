//Sesion 02
//Continuación de tipos de datos

void main(){

  final int edad = 28;
  final double peso = 5.5;
  final String nombre = "Emma Frost";
  final bool esAlumno = true;
  
  //final materias = ["Patrones de Diseño","Apps Móviles I","Apps Móviles II"];

  //final List<String> materias = ["Patrones de Diseño","Apps Móviles I","Apps Móviles II"];
  //final materias = <String>["Patrones de Diseño","Apps Móviles I","Apps Móviles II"];
  final List<String> materias = <String>["Patrones de Diseño","Apps Móviles I","Apps Móviles II"];

  print(
"""
Edad: $edad
Peso: $peso
Nombre: $nombre
Es alumno: $esAlumno
""");
  print("Materias: $materias");
  print("Materia1: ${ materias[0] } ");
  print("Materia1: ${ materias[1] } ");
  print("Materia1: ${ materias[2] } ");


}

