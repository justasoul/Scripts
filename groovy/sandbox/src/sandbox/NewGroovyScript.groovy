/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sandbox

def get_answers_from_remExecutTestDMIF_request (xml_request_content) {

    def final_output    
    def envelope = new XmlSlurper().parseText( xml_request_content )

    envelope.declareNamespace( s:'http://schemas.xmlsoap.org/soap/envelope/'
                        , i:'http://www.w3.org/2001/XMLSchema-instance'
                        )


    // Capacidade Financeira ///////////////////////////////////////////////////////
    def capacidade_financeira =      
         envelope.'s:Body'.'RemExecutTestDMIF'.'input'.'Questionario'.'NipCapFinanceira'.'RemDMIFInputNipCapFinData'

    final_output =                "Capacidade Financeira\n"     
    final_output = final_output + "Titular:IdPergunta:IdResposta\n"
    
    capacidade_financeira.each{ cap_fin -> 

        def output    
        output =  cap_fin.Nip.text()

        cap_fin.'RespostasCapFinanceira'.'RemDMIFTestInputResposta'.each{ resp -> 

            final_output = final_output + output + ":" + resp.IdPergunta.text() + ":" + resp.IdResposta.text() + "\n"
        }

    }

    // Objectivos Investimento ////////////////////////////////////////////////////
    def objectivos_investimento =      
         envelope.'s:Body'.'RemExecutTestDMIF'.'input'.'Questionario'.'ProdutosObjInvestimento'.'RemDMIFInputProdutosObjInvData'

    final_output = final_output + "Objectivos Investimento\n"  
    final_output = final_output + "Titular:Produto:IdPergunta:IdResposta\n"  

    objectivos_investimento.each{ obj_inv -> 

        def output    
        output =  obj_inv.NipTitular.text() + ":" + obj_inv.Produto.text()   

        obj_inv.RespostasObjInvestimento.RemDMIFTestInputResposta.each{ resp ->             
            final_output = final_output + output + ":" + resp.IdPergunta.text() + ":" + resp.IdResposta.text() + "\n"
        }

    }

    return final_output    
}



def res = get_answers_from_remExecutTestDMIF_request (
                '''<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body><RemExecutTestDMIF xmlns="http://BancoBPI/DMIFService/1"><input xmlns:i="http://www.w3.org/2001/XMLSchema-instance"><Canal>ONL</Canal><Empresa>0010</Empresa><NIP>5101173</NIP><NUC>5171094</NUC><Questionario><NipCapFinanceira><RemDMIFInputNipCapFinData><Nip>1</Nip><RespostasCapFinanceira><RemDMIFTestInputResposta><IdPergunta>4</IdPergunta><IdResposta>31</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>5</IdPergunta><IdResposta>34</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>6</IdPergunta><IdResposta>37</IdResposta></RemDMIFTestInputResposta></RespostasCapFinanceira></RemDMIFInputNipCapFinData><RemDMIFInputNipCapFinData><Nip>2</Nip><RespostasCapFinanceira><RemDMIFTestInputResposta><IdPergunta>4</IdPergunta><IdResposta>32</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>5</IdPergunta><IdResposta>35</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>6</IdPergunta><IdResposta>38</IdResposta></RemDMIFTestInputResposta></RespostasCapFinanceira></RemDMIFInputNipCapFinData></NipCapFinanceira><ProdutosObjInvestimento><RemDMIFInputProdutosObjInvData><Aplicacao>FUN</Aplicacao><NipTitular>1</NipTitular><Produto>00807</Produto><RespostasObjInvestimento><RemDMIFTestInputResposta><IdPergunta>1</IdPergunta><IdResposta>1</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>2</IdPergunta><IdResposta>6</IdResposta></RemDMIFTestInputResposta></RespostasObjInvestimento></RemDMIFInputProdutosObjInvData><RemDMIFInputProdutosObjInvData><Aplicacao>FUN</Aplicacao><NipTitular>1</NipTitular><Produto>00807</Produto><RespostasObjInvestimento><RemDMIFTestInputResposta><IdPergunta>1</IdPergunta><IdResposta>1</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>2</IdPergunta><IdResposta>6</IdResposta></RemDMIFTestInputResposta></RespostasObjInvestimento></RemDMIFInputProdutosObjInvData><RemDMIFInputProdutosObjInvData><Aplicacao>FUN</Aplicacao><NipTitular>2</NipTitular><Produto>00807</Produto><RespostasObjInvestimento><RemDMIFTestInputResposta><IdPergunta>1</IdPergunta><IdResposta>2</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>2</IdPergunta><IdResposta>12</IdResposta></RemDMIFTestInputResposta></RespostasObjInvestimento></RemDMIFInputProdutosObjInvData><RemDMIFInputProdutosObjInvData><Aplicacao>FUN</Aplicacao><NipTitular>2</NipTitular><Produto>00807</Produto><RespostasObjInvestimento><RemDMIFTestInputResposta><IdPergunta>1</IdPergunta><IdResposta>2</IdResposta></RemDMIFTestInputResposta><RemDMIFTestInputResposta><IdPergunta>2</IdPergunta><IdResposta>12</IdResposta></RemDMIFTestInputResposta></RespostasObjInvestimento></RemDMIFInputProdutosObjInvData></ProdutosObjInvestimento><QuestionarioId>15015</QuestionarioId></Questionario><TipoRemediacao>Banco</TipoRemediacao><UserMec i:nil="true"/></input></RemExecutTestDMIF></s:Body></s:Envelope>
                '''    
          ) 
          
// println res 



///////////////////////////////////////////////

import groovy.xml.*

def get_ult_rem_perg_resp_cap_financeira (p_perguntas_respostas_ids) {
    
    def writer = new StringWriter()
    def respostas_xml = new MarkupBuilder(writer)
    
    respostas_xml.RespostasCapFinanceira{
        data '2019-01-31T00:00:00'
        respostas {
            p_perguntas_respostas_ids.each{ pr_ids->

                RemDMIFOutputRespostas {
                   PerguntaId (pr_ids.perguntaid)
                   RespostaId (pr_ids.respostaid)
                }            

            }        
        }
    }
    
    return writer.toString()
    
}

def get_ult_rem_perg_resp_obj_investimento(p_perguntas_respostas_ids) {
    
    def writer = new StringWriter()
    def respostas_xml = new MarkupBuilder(writer)
    
    respostas_xml.RespostasObjInvestimento{        
        
            p_perguntas_respostas_ids.each{ pr_ids->
                RemDMIFOutputRespostas {
                   PerguntaId (pr_ids.perguntaid)
                   RespostaId (pr_ids.respostaid)
                }            

            }                
    }
    
    return writer.toString()
    
}

                         
def perguntas_respostas_ids_cap_fim = [
         [perguntaid: 4, respostaid: 31]
       , [perguntaid: 5, respostaid: 34] 
       , [perguntaid: 6, respostaid: 37]
]

println get_ult_rem_perg_resp_cap_financeira(perguntas_respostas_ids_cap_fim)


def perguntas_respostas_ids_obj_investimento = [
         [perguntaid: 1, respostaid: 1]
       , [perguntaid: 2, respostaid: 7] 
]

println get_ult_rem_perg_resp_obj_investimento(perguntas_respostas_ids_obj_investimento)

/*
respostas_xml.RespostasCapFinanceira{
    data '2019-01-31T00:00:00'
    respostas {
        RemDMIFOutputRespostas {
           perguntaid '4' 
           respostaid '31'
        }
        
    }
}
*/




///////////////////////////////////////////////

// println ('Res #: ' + res  )  //dump()

println ('end')


