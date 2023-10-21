String classificarPessoa(double valorImc){
   if(valorImc<16){
    return "Magreza grave";
  }
   if((valorImc>=16) &&(valorImc<17)){
     return "Magreza moderada";
   }
   if((valorImc>=17) &&(valorImc<18.5)){
     return "Magreza leve";
   }
   if((valorImc>=18.5) &&(valorImc<25)){
     return "Saudável";
   }
   if((valorImc>=25) &&(valorImc<30)){
     return "Sobrepeso";
   }
   if((valorImc>=30) &&(valorImc<35)){
     return "Obesidade grau I";
   }
   if((valorImc>=35) &&(valorImc<40)){
     return "Obesidade grau II (severa)";
   }

     return "Obesidade grau III (mórbida)";

}