//Fazer manipulações de algo que quero chamar

class BaseResource{

String resolverParams(String url, Map<String, String>params){
  params.keys.forEach((k) { 
   url = url.replaceAll(':$k', params[k]!);
  });
  return url;
}
}