:: Este script deve verificar se o wireguard esta funcionando corretamente
:: Por enquanto so colocarei um pseudocodigo aqui para depois ser traduzido em batch ou powershell

:: Constante HANDSHAKE_TIME_TRESHOLD

:: Criar funcao que recebe o endereco de um arquivo de configuracao, nesta funcao:
     :: Procurar todos os peers que possuem endpoints
     :: utilizar wg-show para obter o tempo do ultimo handshake de cada peer
     :: Traduzir tempo em segundos
     :: Verificar, em comparacao com uma constante chamada HANDSHAKE_TIME_TRESHOLD se o tempo de handshake ultrapassou o estimado
     :: Se tiver ultrapassado reiniciar conexao (verificar se eh melhor reiniciar servico ou utilizar o comando da ultima linha desse arquivo)

:: Criar uma lista de arquivos de configuracao
:: Percorrer a lista de arquivos e chamar a funcao de verificacao para cada um
:: Fim do Script




:: Colocar este script como uma tarefa agendada no Task Scheduler para executar como admin a cada X minutos (eu escolheria 3 minutos)


::set "network_name=EXAMPLE_NAME"
::set "peer=XXXXXXXXXXXPEER_KEYXXXXXXXXXXXXXXXX"
::set "endpoint=0.0.0.0:0000"
::
::wg set %network_name% peer %peer% endpoint %endpoint%
