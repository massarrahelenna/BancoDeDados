# BancoDeDados

 Correções no Código Estacionamento:

1 -  Não mudamos nada, pois já está tudo em pt-br.

2 - Achamos melhor manter a foreign key id_professor, para manter o encadeamento de todas as tabelas com a tabela professor. 

3 - Criamos índices para status e para nome, em vez de email, pois faz mais sentido dentro no nosso código

4 - Adicionamos CHECKS em  ano, valor_mensal, data_reportagem e data_hora_saida.
 
5 - Os valores ENUM e status_pagamento nunca vão mudar, portanto usá-los na mesma tabela é suficiente.
 
6 - Sugestão implementada


