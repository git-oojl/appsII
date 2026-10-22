//Sesion02B
//Mapas

void main(){
  final Map<String, dynamic> persona = {
    "edad": 25,
    "nombre": "Emma Frost",
    "peso": 62.5,
    "mutantante": true,
    "academias":{
      0: "Academia Massachussets",
      1: "Academia X-men"      
    },
    "poderes":<String>["Control mental", "Ilusiones", "Ataques Psiquicos"]
  };
  print("persona: $persona");
  print("Edad: ${ persona["edad"] } ");
  print("Nombre: ${ persona["nombre"] } ");
  print("Academias ${ persona["academias"] }");
  print("Academia1 ${ persona["academias"][0] }");
  print("Poderes ${ persona["poderes"] }");
  print("Poder 1 ${ persona["poderes"][0] }");

}