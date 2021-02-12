<map version="1.0.1">
<node TEXT="tgr009">
<icon BUILTIN="Package"/>
<node TEXT="TGR009">
<icon BUILTIN="Descriptor.window.editor"/>
<node TEXT="métodos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="PACK_CONSULTA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE BODY PACK_CONSULTA IS&#10;&#10;  I_TABELA  VARCHAR2(2000);&#10;  I_TIPO    VARCHAR2(2000);&#10;&#10;-------------------------------------------------------------------------------------------------------------------------&#10;&#10;  PROCEDURE PEGA_TIPO(PRIM_ITEM IN VARCHAR2,TIPO OUT NUMBER) IS&#10;    TIPODADO VARCHAR2(80);&#10;  BEGIN&#10;    TIPODADO := GET_ITEM_PROPERTY(PRIM_ITEM,DATATYPE);&#10;    IF (TIPODADO = 'ALPHA') OR (TIPODADO = 'CHAR') THEN&#10;      TIPO := 1;&#10;    ELSIF (TIPODADO = 'NUMBER') OR (TIPODADO = 'RNUMBER') OR (TIPODADO = 'MONEY') OR (TIPODADO = 'RMONEY') THEN&#10;      TIPO := 2;&#10;    END IF;&#10;  END PEGA_TIPO;&#10;&#10;-------------------------------------------------------------------------------------------------------------------------&#10;&#10;  PROCEDURE CONSULTA IS&#10;    PRIM_ITEM   VARCHAR2(80);&#10;    ULTI_ITEM   VARCHAR2(80);&#10;    LABEL_ITEM  VARCHAR2(80);&#10;    I           NUMBER;&#10;    TIPO        NUMBER;&#10;    ITEM_TIPO   VARCHAR2(80);&#10;  BEGIN&#10;    I_BLOCO  := :SYSTEM.CURSOR_BLOCK;&#10;    GO_BLOCK('CONSULTA');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    I_TABELA := GET_BLOCK_PROPERTY(I_BLOCO,DML_DATA_TARGET_NAME);&#10;    IF I_TABELA IS NOT NULL THEN&#10;      PRIM_ITEM := GET_BLOCK_PROPERTY(I_BLOCO,FIRST_ITEM);&#10;      ULTI_ITEM := GET_BLOCK_PROPERTY(I_BLOCO,LAST_ITEM);&#10;      I := 1;&#10;      LOOP&#10;        I_TIPO     := GET_ITEM_PROPERTY(I_BLOCO||'.'||PRIM_ITEM,DATATYPE);&#10;        LABEL_ITEM := GET_ITEM_PROPERTY(I_BLOCO||'.'||PRIM_ITEM,PROMPT_TEXT);&#10;        ITEM_TIPO  := GET_ITEM_PROPERTY(I_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE);&#10;        IF (PRIM_ITEM &#60;> 'DT_RECORD') AND (ITEM_TIPO &#60;> 'DISPLAY ITEM') AND &#10;            GET_ITEM_PROPERTY(I_BLOCO||'.'||PRIM_ITEM,ITEM_CANVAS) IS NOT NULL THEN&#10;          PEGA_TIPO(I_BLOCO||'.'||PRIM_ITEM,TIPO);&#10;          :CONSULTA.DS_CAMPO := REPLACE(LABEL_ITEM,CHR(10),' ');&#10;          :CONSULTA.NM_CAMPO := I_TABELA||'.'||PRIM_ITEM;&#10;          :CONSULTA.TP_ITEM  := TIPO;&#10;          NEXT_RECORD;&#10;        END IF;&#10;        EXIT WHEN I_BLOCO||'.'||PRIM_ITEM = I_BLOCO||'.'||ULTI_ITEM;&#10;        PRIM_ITEM := GET_ITEM_PROPERTY(I_BLOCO||'.'||PRIM_ITEM,NEXTITEM);&#10;      END LOOP;&#10;      CLEAR_RECORD;&#10;      FIRST_RECORD;&#10;    END IF;&#10;  END CONSULTA;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_CONSULTA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_CONSULTA IS &#10;&#10;  I_BLOCO  VARCHAR2(1000);&#10;&#10;  PROCEDURE CONSULTA;&#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_ERROS">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_ERROS IS&#10;  TIPO_ERRO   VARCHAR2(03) := ERROR_TYPE;&#10;  CODIGO_ERRO NUMBER       := ERROR_CODE;&#10;  TMP          VARCHAR2(32000);&#10;BEGIN&#10;  IF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41803) THEN&#10;      --Não há registro anterior a partir do qual copiar valor&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 42100) THEN&#10;      --Não foram encontrados erros recentemente&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41003) THEN&#10;      --Esta função não pode ser executada aqui&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40815) THEN&#10;      --A variável %s não existe&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40222) THEN&#10;      --Item desativado %s falhou na validação&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40738) THEN&#10;      --Argumento 1 para incorporar GO_BLOCK não pode ser nulo&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41058) THEN&#10;      --Esta propriedade não existe para GET_ITEM_PROPERTY&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40104) THEN&#10;      --No such block %s&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41045) THEN&#10;      --Não é possível localizar o item : ID inválido&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41332) THEN&#10;      --List element index out of range&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40401) THEN&#10;      --Não há alterações a salvar&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41009) THEN&#10;      --Tecla de função não permitida&#10;      NULL;&#10;  ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40510) THEN&#10;      TMP := NULL;&#10;      TMP := DBMS_ERROR_TEXT;&#10;      IF INSTR(TMP,'ORA-02292',1) > 0 THEN&#10;        MESSAGE('Não foi possivel deletar o registro, registro filho localizado.');&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;      ELSE&#10;        MESSAGE('Não foi possivel deletar o registro.');&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;       END IF;&#10;  ELSE&#10;     MESSAGE (ERROR_TYPE||'-'||ERROR_CODE||' '||ERROR_TEXT);&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_MENSAGEM">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_MENSAGEM IS&#10;  TIPO_MENSAGEM   VARCHAR2(03) := MESSAGE_TYPE;&#10;  CODIGO_MENSAGEM NUMBER       := MESSAGE_CODE;&#10;BEGIN&#10;  IF (TIPO_MENSAGEM = 'FRM') AND (CODIGO_MENSAGEM = 40400) THEN&#10;      --Registro aplicado e salvo&#10;      MESSAGE ('000002 - Registro salvo com sucesso');&#10;  ELSE&#10;     MESSAGE (MESSAGE_TYPE||'-'||MESSAGE_CODE||' '||MESSAGE_TEXT);&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="INSERE_LOGUSUARIO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE INSERE_LOGUSUARIO(I_DS_EVENTO IN VARCHAR2, I_TP_EVENTO IN VARCHAR2) IS&#10;BEGIN&#10;  INSERT INTO LOGUSUARIO&#10;        (CD_EMPRESA, &#10;         CD_MODULO, &#10;         CD_PROGRAMA, &#10;         CD_USUARIO, &#10;         DS_EVENTO, &#10;         DT_EVENTO, &#10;         HR_EVENTO, &#10;         SQ_EVENTO, &#10;         TP_EVENTO)&#10;        VALUES&#10;        (:GLOBAL.CD_EMPRESA, &#10;         :GLOBAL.CD_MODULO, &#10;         :GLOBAL.CD_PROGRAMA, &#10;         :GLOBAL.CD_USUARIO, &#10;         I_DS_EVENTO, &#10;         TRUNC(SYSDATE), &#10;         TO_CHAR(SYSDATE,'HH24:MI'), &#10;         SEQ_AUDITORIA.NEXTVAL, &#10;         I_TP_EVENTO);  &#10;    FAZ_COMMIT;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_TPCALCULO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_TPCALCULO IS &#10;  PROCEDURE CARREGA_TPCALCULO;&#10;  PROCEDURE GRAVA_TPCALCULO (O_MENSAGEM      OUT VARCHAR2);&#10;  PROCEDURE EXCLUI_TPCALCULO (I_CD_ITEM         IN TPCALCITEMSIMILAR.CD_ITEM%TYPE,&#10;                              I_CD_TIPOCALCULO IN TPCALCITEMSIMILAR.CD_TIPOCALCULO%TYPE,&#10;                              O_MENSAGEM       OUT VARCHAR2);&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_TPCALCULO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE BODY PACK_TPCALCULO IS&#10;  &#10;  PROCEDURE CARREGA_TPCALCULO IS&#10;   &#10;    CURSOR CUR_TPCALCITEMSIMILAR IS&#10;    SELECT TPCALCITEMSIMILAR.CD_TIPOCALCULO&#10;      FROM TPCALCITEMSIMILAR&#10;     WHERE TPCALCITEMSIMILAR.CD_ITEM = :CONTROLE.CD_ITEMSIMILAR&#10;     ORDER BY TPCALCITEMSIMILAR.CD_ITEM;&#10;  BEGIN&#10;    &#10;    GO_BLOCK('TPCALCULO');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    FIRST_RECORD;&#10;    FOR I IN CUR_TPCALCITEMSIMILAR LOOP&#10;      :TPCALCULO.CD_TIPOCALCULO := I.CD_TIPOCALCULO;&#10;      &#10;      IF(GET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, UPDATE_ALLOWED) = 'TRUE') THEN  &#10;        SET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, INSERT_ALLOWED, PROPERTY_FALSE);&#10;        SET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, UPDATE_ALLOWED, PROPERTY_FALSE);&#10;        SET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, VISUAL_ATTRIBUTE, 'VSA_CAMPOEXIBICAO');&#10;      END IF;&#10;      &#10;      NEXT_RECORD;&#10;    END LOOP;&#10;  END CARREGA_TPCALCULO;&#10;  &#10;  PROCEDURE GRAVA_TPCALCULO (O_MENSAGEM      OUT VARCHAR2) IS&#10;&#10;  E_GERAL            EXCEPTION;&#10;  BEGIN&#10;    &#10;    GO_BLOCK('TPCALCULO');&#10;    FIRST_RECORD;&#10;    LOOP&#10;      &#10;      IF :TPCALCULO.CD_TIPOCALCULO IS NOT NULL THEN&#10;        &#10;        BEGIN&#10;          INSERT INTO TPCALCITEMSIMILAR(CD_ITEM,&#10;                                        CD_TIPOCALCULO,&#10;                                        DT_RECORD)&#10;                                 VALUES(:CONTROLE.CD_ITEMSIMILAR,&#10;                                         :TPCALCULO.CD_TIPOCALCULO,&#10;                                         SYSDATE);&#10;        EXCEPTION&#10;          WHEN DUP_VAL_ON_INDEX THEN&#10;            NULL;&#10;          WHEN OTHERS THEN&#10;            /*Ocorreu um erro inesperado ao gravar o Tp. Cálculo ¢CD_TPCALC¢. Erro: ¢SQLERRM¢.*/&#10;            O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32626, '¢CD_TPCALC='||:TPCALCULO.CD_TIPOCALCULO||'¢SQLERRM='||SQLERRM||'¢');&#10;            RAISE E_GERAL;&#10;        END;&#10;        IF(GET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, UPDATE_ALLOWED) = 'TRUE') THEN  &#10;          SET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, INSERT_ALLOWED, PROPERTY_FALSE);&#10;          SET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, UPDATE_ALLOWED, PROPERTY_FALSE);&#10;          SET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, VISUAL_ATTRIBUTE, 'VSA_CAMPOEXIBICAO');&#10;        END IF;&#10;      END IF;      &#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;    &#10;    END LOOP;&#10;    FIRST_RECORD;&#10;    IF FORM_SUCCESS THEN&#10;      /*Apropriação de Frete gerada com sucesso com os seguintes lotes contábeis ¢V_LOTES¢.*/      &#10;      FAZ_COMMIT;&#10;      /*Registro salvo com sucesso.*/&#10;      MENSAGEM_PADRAO(2926, NULL);&#10;    END IF;&#10;  &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      O_MENSAGEM := '¥[GRAVA_TPCALCULO] ¥'||O_MENSAGEM;&#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM := '¥[GRAVA_TPCALCULO: Erro] ¥'||SQLERRM;&#10;  END GRAVA_TPCALCULO;&#10;  &#10;  PROCEDURE EXCLUI_TPCALCULO (I_CD_ITEM         IN TPCALCITEMSIMILAR.CD_ITEM%TYPE,&#10;                              I_CD_TIPOCALCULO IN TPCALCITEMSIMILAR.CD_TIPOCALCULO%TYPE,&#10;                              O_MENSAGEM       OUT VARCHAR2) IS&#10;&#10;  E_GERAL            EXCEPTION;&#10;  BEGIN&#10;    &#10;    BEGIN&#10;      DELETE &#10;        FROM TPCALCITEMSIMILAR&#10;       WHERE TPCALCITEMSIMILAR.CD_ITEM = I_CD_ITEM&#10;          AND TPCALCITEMSIMILAR.CD_TIPOCALCULO = I_CD_TIPOCALCULO;&#10;      EXCEPTION&#10;        WHEN OTHERS THEN&#10;        /*Erro ao excluir registros ¢TABELA¢. Erro ¢SQLERRM¢*/&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(14853, '¢TABELA='||'TPCALCITEMSIMILAR'||'¢SQLERRM='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;  &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      O_MENSAGEM := '¥[EXCLUI_TPCALCULO] ¥'||O_MENSAGEM;&#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM := '¥[EXCLUI_TPCALCULO: Erro] ¥'||SQLERRM;&#10;  END EXCLUI_TPCALCULO;&#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="CENTRALIZA_FORM">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE CENTRALIZA_FORM(NM_FORMPRINCIPAL IN VARCHAR2, NM_FORMFILHO IN VARCHAR2) IS&#10;  V_WIDTH_PRINCIPAL   NUMBER;&#10;  V_HEIGHT_PRINCIPAL NUMBER;&#10;  V_WIDTH_LAYOUT     NUMBER;&#10;  V_HEIGHT_LAYOUT    NUMBER;&#10;  V_X_POS             NUMBER;&#10;  V_Y_POS             NUMBER;&#10;&#10;BEGIN&#10;  V_WIDTH_PRINCIPAL  := GET_WINDOW_PROPERTY(NM_FORMPRINCIPAL,WIDTH);&#10;  V_HEIGHT_PRINCIPAL := GET_WINDOW_PROPERTY(NM_FORMPRINCIPAL,HEIGHT);&#10;  &#10;  V_WIDTH_LAYOUT     := GET_WINDOW_PROPERTY(NM_FORMFILHO,WIDTH);&#10;  V_HEIGHT_LAYOUT    := GET_WINDOW_PROPERTY(NM_FORMFILHO,HEIGHT);&#10;  &#10;  V_X_POS := (V_WIDTH_PRINCIPAL  - V_WIDTH_LAYOUT)  / 2;&#10;  V_Y_POS := (V_HEIGHT_PRINCIPAL - V_HEIGHT_LAYOUT) / 2;&#10;  &#10;  SET_WINDOW_PROPERTY(NM_FORMFILHO,X_POS,V_X_POS);&#10;  SET_WINDOW_PROPERTY(NM_FORMFILHO,Y_POS,V_Y_POS);&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="MSG_CONFIRMACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="FUNCTION MSG_CONFIRMACAO (V_DESCRICAO IN VARCHAR2) RETURN BOOLEAN IS&#10;  RETORNO NUMBER; &#10;BEGIN&#10;    /*&#10;    V_MENSAGEM := 'Já Existem Dados Gravados Para Este Período,Para esta empresa e esta Versão.Se Gravar Novamente Irá Apagar os Valores Anteriores Deseja Continuar..?';&#10;    IF NOT MSG_CONFIRMACAO(V_MENSAGEM) THEN&#10;      V_MENSAGEM := 'Geração do Relatorio Cancelada Pelo Usuário.';&#10;      RAISE E_GERAL;&#10;    END IF;  &#10;    */ &#10;    SET_ALERT_PROPERTY('MENSAGEM_EDICAO',ALERT_MESSAGE_TEXT,V_DESCRICAO); &#10;    RETORNO := SHOW_ALERT('MENSAGEM_EDICAO');&#10;    IF RETORNO &#60;> 88 THEN&#10;      RETURN(FALSE);&#10;    ELSE&#10;      RETURN(TRUE);&#10;    END IF;    &#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="MENSAGEM">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE MENSAGEM (V_DS_TITULO IN VARCHAR2,V_DS_MENSAGEM IN VARCHAR2,V_TP_MENSAGEM IN NUMBER) IS&#10;/* &#10;    &#10;     Como usar?&#10;     &#10;     MENSAGEM (TITULO,MENSAGEM,ESTILO);&#10;     &#10;     TITULO(varchar2)   = titulo da janela de mensagem&#10;     MENSAGEM(varchar2) = mensagem central&#10;     ESTILO(Number)     = estilo da mensagem (icone)&#10;       - 1 = Erro&#10;       - 2 = Observacao&#10;       - 3 = Precaucao&#10;       - 4 = Aparece na barra (Não utiliza titulo) &#10;&#10;*/&#10;  ALERT_ID ALERT;&#10;  MENSAGEM VARCHAR2(32000);&#10;  RETORNO  NUMBER;&#10;  &#10;  V_ST_PADRAO   VARCHAR2(1) := 'N'; -- 'S' - SIM 'N' - NÃO&#10;  V_CD_MENSAGEM VARCHAR2(32000);&#10;  V_NR_POSISAO  NUMBER;&#10;  E_NAO_MOSTRA_MENSAGEM EXCEPTION;&#10;  V_GLOBAL_ST_AUTOMACAO VARCHAR2(3000);&#10;  V_GLOBAL_CD_VERSAOPARMGEM VARCHAR2(3000);&#10;  V_ST_AUTOMACAO VARCHAR2(1);&#10;BEGIN&#10;  V_GLOBAL_ST_AUTOMACAO := 'GLOBAL.ST_AUTOMACAO_'||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#10;  DEFAULT_VALUE(NULL, V_GLOBAL_ST_AUTOMACAO);&#10;  V_ST_AUTOMACAO := NVL(NAME_IN(V_GLOBAL_ST_AUTOMACAO), 'N');&#10;  /* MGT:17/06/2013:60343 - Adicionado chamada utilizando NAME_IN para que mesmo que uma tela não utilize o envio de &#10;   * emails automatico o proceduimento MENSAGEM posso ser utilizado normalmente, essa variavel global é preenchida&#10;   * pelo programa UTI032, quando o mesma chama os programa que tem o envio de email automatizado.&#10;  */&#10;  IF NVL(V_ST_AUTOMACAO,'N') = 'S' THEN&#10;    &#10;    V_GLOBAL_CD_VERSAOPARMGEM := 'GLOBAL.CD_VERSAOPARMGEN_'||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#10;    DEFAULT_VALUE(NULL, V_GLOBAL_CD_VERSAOPARMGEM);&#10;    &#10;    PACK_RELEMAIL.INSERE_LOGRELEMAIL(:GLOBAL.CD_USUARIO,&#10;                                     :GLOBAL.CD_MODULO,&#10;                                     :GLOBAL.CD_PROGRAMA,&#10;                                     NAME_IN(V_GLOBAL_CD_VERSAOPARMGEM),&#10;                                     V_DS_MENSAGEM);&#10;    RAISE E_NAO_MOSTRA_MENSAGEM;&#10;  END IF;&#10;  &#10;  V_ST_PADRAO := 'N';&#10;  &#10;  -- TESTA SE A MENSAGEM EH PADÇÃO OU NAUM --&#10;  IF INSTR(V_DS_MENSAGEM,'¢MPM=') > 0 THEN&#10;    V_ST_PADRAO   := 'S'; -- EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;    V_NR_POSISAO  := INSTR(V_DS_MENSAGEM,'¢MPM=') + 5;&#10;    V_CD_MENSAGEM := SUBSTR(V_DS_MENSAGEM,V_NR_POSISAO,9);&#10;  ELSE&#10;    V_ST_PADRAO := 'N'; -- NÃO EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;  END IF;&#10;  &#10;  /**JMS:28/09/2006:14099&#10;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USUÁRIO ELE ABRA O MEU FORM COM A MENSAGEM&#10;   * E NÃO A JANELA PADRÃO DO FORMS, DESTA FORMA É POSSÍVEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#10;   */&#10;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#10;  IF (V_TP_MENSAGEM &#60;> 4) THEN&#10;    IF NVL(V_ST_PADRAO,'N') = 'N' THEN&#10;      PACK_MENSAGEM.SET_TITULO(V_DS_TITULO);&#10;      PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#10;      PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#10;      &#10;      /* FBZ:06/09/2019:137847&#10;       * Aconteceram alguns casos no Maxys Web em tela complexas em que essa chamada do CALL_FORM&#10;       * fez com que o processo frmweb.exe no servidor fosse encerrado de forma inesperada. Era uma situação&#10;       * esporárica, mas aparentemente esse SYNCHRONIZE faz com que o erro pare de acontecer.&#10;       */&#10;      IF (NOT EXECUTANDO_NO_FORMS_6) THEN&#10;        SYNCHRONIZE;&#10;      END IF;&#10;      &#10;      CALL_FORM ('ABT002', NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#10;    ELSE&#10;      MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#10;    END IF;&#10;  ELSE&#10;    CLEAR_MESSAGE;&#10;    MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#10;  END IF;&#10;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#10;&#10;  /*&#10;  IF V_ST_PADRAO = 'N' THEN&#10;    MENSAGEM := 'MENSAGEM_';&#10;    IF (V_TP_MENSAGEM = 1) THEN&#10;      MENSAGEM := MENSAGEM || 'ERRO';&#10;    ELSIF (V_TP_MENSAGEM = 2) THEN&#10;      MENSAGEM := MENSAGEM || 'OBSERVACAO';&#10;    ELSIF (V_TP_MENSAGEM = 3) THEN&#10;      MENSAGEM := MENSAGEM || 'PRECAUCAO';&#10;    END IF;  &#10;    IF (V_TP_MENSAGEM &#60;> 4) THEN&#10;      ALERT_ID := FIND_ALERT(MENSAGEM);&#10;      SET_ALERT_PROPERTY(ALERT_ID,ALERT_MESSAGE_TEXT,V_DS_MENSAGEM);&#10;      SET_ALERT_PROPERTY(ALERT_ID,TITLE,V_DS_TITULO);&#10;      RETORNO := SHOW_ALERT(ALERT_ID);&#10;    ELSE&#10;      CLEAR_MESSAGE;&#10;      MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#10;    END IF;&#10;  ELSIF V_ST_PADRAO = 'S' THEN&#10;    MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#10;  END IF;  &#10;  */&#10;EXCEPTION&#10;  WHEN E_NAO_MOSTRA_MENSAGEM THEN&#10;    NULL;  &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="MENSAGEM_PADRAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE MENSAGEM_PADRAO(I_CD_MENSAGEM IN VARCHAR2,&#10;                          I_PARAMETRO   IN VARCHAR2) IS -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#10;/* &#10;    &#10;  I_CD_MENSAGEM = -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#10;&#10;*/&#10;&#10;  ALERT_ID       ALERT;&#10;  MENSAGEM       VARCHAR2(32000);&#10;  RETORNO        NUMBER;&#10;  I_MENSAGEM    VARCHAR2(32000);&#10;  V_TP_MENSAGEM VARCHAR2(32000);&#10;  V_DS_MENSAGEM VARCHAR2(32000);&#10;  J_DS_MENSAGEM VARCHAR2(32000);&#10;  V_CD_MENSAGEM VARCHAR2(32000);&#10;  V_TITULO      VARCHAR2(32000);&#10;  &#10;  V_DEFAULT_BROWSER    VARCHAR2(32000);&#10;  V_TP_CONEXAO        VARCHAR2(32000);&#10;  V_CAMINHO_AJUDA      VARCHAR2(32000);&#10;  ARQUIVO_NAO_EXISTE  EXCEPTION;&#10;&#10;&#10;  V_ST_MENSPRONTA VARCHAR2(1) := 'N'; -- 'S' - SIM 'N' - NÃO&#10;  V_NR_POSISAO    NUMBER;&#10;  E_NAO_MOSTRA_MENSAGEM EXCEPTION;&#10;  V_GLOBAL_ST_AUTOMACAO VARCHAR2(3000);&#10;  V_GLOBAL_CD_VERSAOPARMGEM VARCHAR2(3000);&#10;  V_ST_AUTOMACAO VARCHAR2(1);&#10;BEGIN&#10;  V_GLOBAL_ST_AUTOMACAO := 'GLOBAL.ST_AUTOMACAO_'||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#10;  DEFAULT_VALUE(NULL, V_GLOBAL_ST_AUTOMACAO);&#10;  V_ST_AUTOMACAO := NVL(NAME_IN(V_GLOBAL_ST_AUTOMACAO), 'N');&#10;  /* MGT:17/06/2013:60343 - Adicionado chamada utilizando NAME_IN para que mesmo que uma tela não utilize o envio de &#10;   * emails automatico o proceduimento MENSAGEM_PADRAO posso ser utilizado normalmente, essa variavel global é preenchida&#10;   * pelo programa UTI032, quando o mesma chama os programa que tem o envio de email automatizado.&#10;  */&#10;  IF NVL(V_ST_AUTOMACAO,'N') = 'S' THEN&#10;    &#10;    V_GLOBAL_CD_VERSAOPARMGEM := 'GLOBAL.CD_VERSAOPARMGEN_'||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#10;    DEFAULT_VALUE(NULL, V_GLOBAL_CD_VERSAOPARMGEM);&#10;    &#10;    PACK_RELEMAIL.INSERE_LOGRELEMAIL(:GLOBAL.CD_USUARIO,&#10;                                     :GLOBAL.CD_MODULO,&#10;                                     :GLOBAL.CD_PROGRAMA,&#10;                                     NAME_IN(V_GLOBAL_CD_VERSAOPARMGEM),&#10;                                     V_DS_MENSAGEM);&#10;    RAISE E_NAO_MOSTRA_MENSAGEM;&#10;  END IF;&#10;&#10;  V_ST_MENSPRONTA := 'N';&#10;  &#10;  &#10;  -- TESTA SE A MENSAGEM EH PADÇÃO OU NAUM --&#10;  IF INSTR(I_PARAMETRO,'¢MPM=') > 0 THEN&#10;    V_ST_MENSPRONTA   := 'S'; -- EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;  ELSE&#10;    V_ST_MENSPRONTA := 'N'; -- NÃO EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;  END IF;&#10;  &#10;  IF V_ST_MENSPRONTA = 'N' THEN&#10;    -- Pesquisa Mensagem --&#10;    PACK_MENSAGEM.MONTA_MENSAGEM(I_CD_MENSAGEM,I_PARAMETRO,V_TP_MENSAGEM,V_DS_MENSAGEM,I_MENSAGEM);&#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;    PACK_MENSAGEM.ARRUMA_CD_MENSAGEM(I_CD_MENSAGEM,V_CD_MENSAGEM,I_MENSAGEM);&#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;  ELSIF V_ST_MENSPRONTA = 'S' THEN&#10;&#10;    V_DS_MENSAGEM := SUBSTR(I_PARAMETRO,1,LENGTH(I_PARAMETRO)/*-15*/);&#10;    V_CD_MENSAGEM := I_CD_MENSAGEM;&#10;    &#10;    -- Pesquisa TP_MENSAGEM --&#10;    PACK_MENSAGEM.MONTA_MENSAGEM(V_CD_MENSAGEM,'¢¢',V_TP_MENSAGEM,J_DS_MENSAGEM,I_MENSAGEM);&#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;  END IF;  &#10;&#10;  MENSAGEM := 'MENSAGEM_';&#10;  IF V_TP_MENSAGEM = 'E' THEN&#10;    MENSAGEM := MENSAGEM||'ERRO';&#10;    V_TITULO := 'ERRO';&#10;  ELSIF V_TP_MENSAGEM = 'O' THEN&#10;    MENSAGEM := MENSAGEM||'OBSERVACAO';&#10;    V_TITULO := 'Observação';&#10;  ELSIF V_TP_MENSAGEM = 'P' THEN&#10;    MENSAGEM := MENSAGEM||'PRECAUCAO';&#10;    V_TITULO := 'Precaução';&#10;  END IF;&#10;  --MENSAGEM := MENSAGEM||'_NOVA';&#10;  V_TITULO := V_TITULO||' - '||V_CD_MENSAGEM;&#10;  &#10;  /**JMS:28/09/2006:14099&#10;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USUÁRIO ELE ABRA O MEU FORM COM A MENSAGEM&#10;   * E NÃO A JANELA PADRÃO DO FORMS, DESTA FORMA É POSSÍVEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#10;   */&#10;  IF (V_TP_MENSAGEM &#60;> 'A') THEN&#10;    PACK_MENSAGEM.SET_TITULO(V_TITULO);&#10;    PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#10;    PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#10;    PACK_MENSAGEM.SET_CODIGO_MENSAGEM(V_CD_MENSAGEM);&#10;    CALL_FORM('ABT002', NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#10;  ELSE&#10;    CLEAR_MESSAGE;&#10;    MESSAGE(V_DS_MENSAGEM,ACKNOWLEDGE);&#10;  END IF;&#10;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#10;   &#10;EXCEPTION&#10;  WHEN ARQUIVO_NAO_EXISTE THEN&#10;    NULL;&#10;  WHEN E_NAO_MOSTRA_MENSAGEM THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TGR009">
<icon BUILTIN="Descriptor.grouping"/>
<node TEXT="Trigger">
<node TEXT="WHEN-WINDOW-CLOSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  EXIT_FORM(NO_VALIDATE,FULL_ROLLBACK);&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-CQUERY">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-PRVBLK">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-EDIT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-DELREC">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE &#10;  V_ALERT     NUMBER;&#10;  V_DS_EVENTO VARCHAR2(32000);&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL      EXCEPTION;&#10;BEGIN&#10;  :GLOBAL.MD_BLOCO  := :SYSTEM.CURRENT_BLOCK;&#10;  --IF :GLOBAL.TP_ACESSO = 'M' THEN&#10;   IF NOT PACK_VALIDA.VAL_PERMISSAO('E', :GLOBAL.CD_USUARIO, :GLOBAL.CD_EMPRESA, :GLOBAL.CD_MODULO, :GLOBAL.CD_PROGRAMA) THEN&#10;    -- O usuário ¢CD_USUARIO¢ não tem permissão de EXCLUSÃO para o módulo ¢CD_MODULO¢,&#10;    -- programa ¢CD_PROGRAMA¢ e Empresa ¢CD_EMPRESA¢. Verifique o Programa ANV053.&#10;    MENSAGEM_PADRAO(487, '¢CD_USUARIO=' ||:GLOBAL.CD_USUARIO||&#10;                         '¢CD_MODULO='  ||:GLOBAL.CD_MODULO||&#10;                         '¢CD_PROGRAMA='||:GLOBAL.CD_PROGRAMA||&#10;                         '¢CD_EMPRESA=' ||:GLOBAL.CD_EMPRESA||'¢');    &#10;  ELSE&#10;    V_ALERT := SHOW_ALERT('EXCLUSAO');&#10;    IF V_ALERT = ALERT_BUTTON1 THEN&#10;      IF :GLOBAL.ST_AUDITORIA = 'S' THEN&#10;        V_DS_EVENTO := 'Removeu O REGISTRO da tabela ITEMBALANCA,'||&#10;                       'Cód. Produto balança = '||:ITEMSIMILAR.CD_ITEMBAL||&#10;                       ', Cód. Produto similar =  '||:ITEMSIMILAR.CD_ITEM||'.';        &#10;        INSERE_LOGUSUARIO(V_DS_EVENTO,'E');&#10;        &#10;      END IF;      &#10;      --JUI:25/06/2019:134469&#10;      IF(GET_ITEM_INSTANCE_PROPERTY('TPCALCULO.CD_TIPOCALCULO', CURRENT_RECORD, UPDATE_ALLOWED) = 'FALSE') THEN&#10;        PACK_TPCALCULO.EXCLUI_TPCALCULO(:CONTROLE.CD_ITEMSIMILAR, :TPCALCULO.CD_TIPOCALCULO,V_DS_EVENTO);&#10;        IF V_MENSAGEM IS NOT NULL THEN&#10;          RAISE E_GERAL;&#10;        END IF;&#10;        DELETE_RECORD;&#10;      END IF;&#10;      IF FORM_SUCCESS THEN&#10;         COMMIT_FORM;&#10;      END IF;&#10;    END IF;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-ENTQRY">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-DUP-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  SET_WINDOW_PROPERTY('WIN_CONSULTA',TITLE,'Consulta Avançada - '||:SYSTEM.CURRENT_FORM);&#10;  PACK_CONSULTA.CONSULTA;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-PRINT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  NULL;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-EXEQRY">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-DUPREC">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  CLEAR_BLOCK(NO_VALIDATE);&#10;  SET_BLOCK_PROPERTY(:SYSTEM.CURSOR_BLOCK,DEFAULT_WHERE,' ');&#10;  EXECUTE_QUERY;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-CLRBLK">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-CLRREC">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  CLEAR_RECORD;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-EXIT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  EXIT_FORM(NO_VALIDATE,FULL_ROLLBACK);&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-CLRFRM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-MENU">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-NXTBLK">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
</node>
</node>
</node>
<node TEXT="KEY-HELP">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  HOST_CLIENTE (:GLOBAL.VL_UNCMAXYS||'\AJUDA\'||:SYSTEM.CURRENT_FORM||'.HTM');&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-F9">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF SHOW_LOV('PROFILE') THEN&#10;    DECLARE&#10;      I_CD_MODULO      PROFILE.CD_MODULO%TYPE;&#10;      I_CD_PROGRAMA    PROFILE.CD_PROGRAMA%TYPE;&#10;      I_TP_ACESSO      PROFILE.TP_ACESSO%TYPE;&#10;      I_DS_PROGRAMA    PROGRAMA.DS_PROGRAMA%TYPE;&#10;      I_ST_AUDITORIA   PROGRAMA.ST_AUDITORIA%TYPE;&#10;      AUX_ST_AUDITORIA PROGRAMA.ST_AUDITORIA%TYPE;&#10;      AUX_CD_MODULO    PROGRAMA.CD_MODULO%TYPE;&#10;      AUX_CD_PROGRAMA  PROGRAMA.CD_PROGRAMA%TYPE;&#10;      AUX_TP_ACESSO    PROFILE.TP_ACESSO%TYPE;&#10;    BEGIN&#10;      IF :GLOBAL.EXEC_PROGRAMA IS NOT NULL THEN&#10;        I_CD_MODULO   := SUBSTR(:GLOBAL.EXEC_PROGRAMA,1,3);&#10;        I_CD_PROGRAMA := SUBSTR(:GLOBAL.EXEC_PROGRAMA,4,3);&#10;        &#10;        SELECT PROFILE.TP_ACESSO&#10;          INTO I_TP_ACESSO&#10;          FROM PROFILE&#10;         WHERE (PROFILE.CD_EMPRESA = :GLOBAL.CD_EMPRESA)&#10;           AND (PROFILE.CD_USUARIO = :GLOBAL.CD_USUARIO)&#10;           AND (PROFILE.CD_MODULO = I_CD_MODULO)&#10;           AND (PROFILE.CD_PROGRAMA = I_CD_PROGRAMA);&#10;        &#10;        SELECT PROGRAMA.DS_PROGRAMA,&#10;               PROGRAMA.ST_AUDITORIA&#10;          INTO I_DS_PROGRAMA,&#10;               I_ST_AUDITORIA&#10;          FROM PROGRAMA&#10;         WHERE (PROGRAMA.CD_MODULO = I_CD_MODULO)&#10;           AND (PROGRAMA.CD_PROGRAMA = I_CD_PROGRAMA);&#10;&#10;        :GLOBAL.DS_PROGRAMA  := I_DS_PROGRAMA;&#10;        AUX_TP_ACESSO        := :GLOBAL.TP_ACESSO;&#10;        AUX_ST_AUDITORIA     := :GLOBAL.ST_AUDITORIA;&#10;        AUX_CD_MODULO        := :GLOBAL.CD_MODULO;&#10;        AUX_CD_PROGRAMA      := :GLOBAL.CD_PROGRAMA;&#10;        :GLOBAL.TP_ACESSO    := I_TP_ACESSO;&#10;        :GLOBAL.ST_AUDITORIA := I_ST_AUDITORIA;&#10;        :GLOBAL.CD_MODULO    := I_CD_MODULO;&#10;        :GLOBAL.CD_PROGRAMA  := I_CD_PROGRAMA;&#10;        &#10;        /*IF I_CD_PROGRAMA &#60;= 09 THEN&#10;           CALL_FORM(I_CD_MODULO||'00'||I_CD_PROGRAMA,HIDE,DO_REPLACE,NO_QUERY_ONLY);&#10;        ELSIF (I_CD_PROGRAMA >=10) AND (I_CD_PROGRAMA &#60;= 99) THEN&#10;           CALL_FORM(I_CD_MODULO||'0'||I_CD_PROGRAMA,HIDE,DO_REPLACE,NO_QUERY_ONLY);&#10;        ELSIF (I_CD_PROGRAMA > 99) THEN&#10;           CALL_FORM(I_CD_MODULO||I_CD_PROGRAMA,HIDE,DO_REPLACE,NO_QUERY_ONLY);&#10;        END IF;*/&#10;        &#10;        /** ALG:13/07/2015:89115&#10;         * Adicionado tratamento para atualizar a conexão na tabela SESSAO.&#10;         ***/&#10;        PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                     :GLOBAL.CD_EMPRESA,&#10;                                     :GLOBAL.CD_MODULO,&#10;                                     :GLOBAL.CD_PROGRAMA);&#10;        &#10;        CALL_FORM(I_CD_MODULO||LPAD(I_CD_PROGRAMA, 3, '0'), HIDE, DO_REPLACE, NO_QUERY_ONLY);&#10;        &#10;        I_DS_PROGRAMA         := NULL;&#10;        :GLOBAL.ST_AUDITORIA  := AUX_ST_AUDITORIA;&#10;        :GLOBAL.CD_MODULO     := AUX_CD_MODULO;&#10;        :GLOBAL.CD_PROGRAMA   := AUX_CD_PROGRAMA;&#10;        :GLOBAL.TP_ACESSO     := AUX_TP_ACESSO;&#10;        :GLOBAL.EXEC_PROGRAMA := NULL;&#10;        &#10;        PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                     :GLOBAL.CD_EMPRESA,&#10;                                     :GLOBAL.CD_MODULO,&#10;                                     :GLOBAL.CD_PROGRAMA);&#10;        &#10;      END IF;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        -- RRW:05/08/2011:32921: Padronização.&#10;        --MESSAGE ('Usuário não tem acesso ao programa, ou programa não existe');&#10;        /*O Usuário ¢CD_USUARIO¢ não tem acesso ao programa ¢NM_PROGRAMA¢ ou programa não está cadastrado.*/&#10;        MENSAGEM_PADRAO(13320, '¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢NM_PROGRAMA='||I_CD_MODULO||LPAD(I_CD_PROGRAMA,3,0)||'¢');&#10;    END;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="VALIDA_ERROS;">
</node>
</node>
</node>
<node TEXT="ON-MESSAGE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="VALIDA_MENSAGEM;">
</node>
</node>
</node>
<node TEXT="KEY-COMMIT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_DS_EVENTO VARCHAR2(32000);&#10;BEGIN&#10;  IF NOT PACK_VALIDA.VAL_PERMISSAO('I', :GLOBAL.CD_USUARIO, :GLOBAL.CD_EMPRESA, :GLOBAL.CD_MODULO, :GLOBAL.CD_PROGRAMA) AND :SYSTEM.RECORD_STATUS IN ('NEW','INSERT') THEN&#10;    -- O usuário ¢CD_USUARIO¢ não tem permissão de INCLUSÃO para o módulo ¢CD_MODULO¢, &#10;    -- programa ¢CD_PROGRAMA¢ e Empresa ¢CD_EMPRESA¢. Verifique o Programa ANV053.&#10;    MENSAGEM_PADRAO(486, '¢CD_USUARIO='  ||:GLOBAL.CD_USUARIO||&#10;                         '¢CD_MODULO='  ||:GLOBAL.CD_MODULO||&#10;                         '¢CD_PROGRAMA='||:GLOBAL.CD_PROGRAMA||&#10;                         '¢CD_EMPRESA='  ||:GLOBAL.CD_EMPRESA||'¢');     &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  ELSIF NOT PACK_VALIDA.VAL_PERMISSAO('A', :GLOBAL.CD_USUARIO, :GLOBAL.CD_EMPRESA, :GLOBAL.CD_MODULO, :GLOBAL.CD_PROGRAMA) AND :SYSTEM.RECORD_STATUS = 'QUERY' THEN&#10;    -- O usuário ¢CD_USUARIO¢ não tem permissão de ALTERAÇÃO para o módulo ¢CD_MODULO¢, &#10;    -- programa ¢CD_PROGRAMA¢ e Empresa ¢CD_EMPRESA¢. Verifique o Programa ANV053.&#10;    MENSAGEM_PADRAO(485, '¢CD_USUARIO='  ||:GLOBAL.CD_USUARIO||&#10;                         '¢CD_MODULO='  ||:GLOBAL.CD_MODULO||&#10;                         '¢CD_PROGRAMA='||:GLOBAL.CD_PROGRAMA||&#10;                         '¢CD_EMPRESA='  ||:GLOBAL.CD_EMPRESA||'¢');     &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;    &#10;  ELSE&#10;    IF :ITEMSIMILAR.CD_ITEMBAL IS NULL THEN &#10;      -- O código do produto de balança deve ser informado.&#10;      MENSAGEM_PADRAO(13078, NULL);&#10;      GO_ITEM('ITEMSIMILAR.CD_ITEMBAL');&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    ELSIF :ITEMSIMILAR.CD_ITEM IS NULL THEN&#10;      -- O Código do Produtor deve ser informado.&#10;      MENSAGEM_PADRAO(4304, NULL);&#10;      GO_ITEM('ITEMSIMILAR.CD_ITEM');&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;    :ITEMSIMILAR.DT_RECORD := SYSDATE;&#10;    --------------------------------AUDITORIA------------------------------------------------&#10;    IF :GLOBAL.ST_AUDITORIA = 'S' THEN&#10;      IF :SYSTEM.RECORD_STATUS IN ('NEW','INSERT') THEN&#10;        V_DS_EVENTO := 'Inseriu um novo registro na tabela ITEMSIMILAR, '||&#10;                       'Cód. Produto Balança = '||:ITEMSIMILAR.CD_ITEMBAL||&#10;                       ',Cód. Produto similar = '||:ITEMSIMILAR.CD_ITEM;&#10;        IF :ITEMSIMILAR.ST_MOVTOGRAOS IS NOT NULL THEN&#10;          V_DS_EVENTO := V_DS_EVENTO||', Somente Graos = '||:ITEMSIMILAR.ST_MOVTOGRAOS;&#10;        END IF;&#10;        IF :ITEMSIMILAR.CD_CULTURA IS NOT NULL THEN&#10;          V_DS_EVENTO := V_DS_EVENTO||', Cultura = '||:ITEMSIMILAR.CD_CULTURA;&#10;        END IF;&#10;        V_DS_EVENTO := V_DS_EVENTO ||'.';&#10;        INSERE_LOGUSUARIO(V_DS_EVENTO, 'I');&#10;      ELSE&#10;        V_DS_EVENTO := 'Alterou o registro na tabela ITEMSIMILAR, ';&#10;        IF GET_ITEM_PROPERTY('ITEMSIMILAR.CD_ITEMBAL',DATABASE_VALUE) &#60;> :ITEMSIMILAR.CD_ITEMBAL THEN&#10;          V_DS_EVENTO :=  V_DS_EVENTO||' Cód. Produto Balança de = '||GET_ITEM_PROPERTY('ITEMSIMILAR.CD_ITEMBAL',DATABASE_VALUE)||&#10;                                                   ' para = '||:ITEMSIMILAR.CD_ITEMBAL||'.';&#10;        END IF;&#10;        &#10;        IF GET_ITEM_PROPERTY('ITEMSIMILAR.CD_ITEM',DATABASE_VALUE) &#60;> :ITEMSIMILAR.CD_ITEM THEN&#10;          V_DS_EVENTO :=  V_DS_EVENTO||' Cód. Produto similar de = '||GET_ITEM_PROPERTY('ITEMSIMILAR.CD_ITEM',DATABASE_VALUE)||&#10;                                                   ' para = '||:ITEMSIMILAR.CD_ITEM||'.';&#10;        END IF;&#10;        &#10;        IF GET_ITEM_PROPERTY('ITEMSIMILAR.ST_MOVTOGRAOS',DATABASE_VALUE) &#60;> :ITEMSIMILAR.ST_MOVTOGRAOS THEN&#10;          V_DS_EVENTO :=  V_DS_EVENTO||' Somente Graos de = '||GET_ITEM_PROPERTY('ITEMSIMILAR.ST_MOVTOGRAOS',DATABASE_VALUE)||&#10;                                                   ' para = '||:ITEMSIMILAR.ST_MOVTOGRAOS||'.';&#10;        END IF;&#10;          &#10;        IF GET_ITEM_PROPERTY('ITEMSIMILAR.CD_CULTURA',DATABASE_VALUE) &#60;> :ITEMSIMILAR.CD_CULTURA THEN&#10;          V_DS_EVENTO :=  V_DS_EVENTO||' Cultura de = '||GET_ITEM_PROPERTY('ITEMSIMILAR.CD_CULTURA',DATABASE_VALUE)||&#10;                                                   ' para = '||:ITEMSIMILAR.CD_CULTURA||'.';&#10;        END IF;&#10;        &#10;        IF V_DS_EVENTO &#60;> 'Alterou o registro na tabela ITEMSIMILAR, ' THEN&#10;          INSERE_LOGUSUARIO(V_DS_EVENTO, 'A');&#10;        END IF;&#10;        &#10;      END IF;&#10;    END IF;&#10;    ------------------------------------------------------------------------------------------&#10;    COMMIT_FORM;&#10;    EXECUTE_QUERY;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-NEW-FORM-INSTANCE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  SET_WINDOW_PROPERTY(FORMS_MDI_WINDOW,WINDOW_STATE,MAXIMIZE);&#10;  SET_WINDOW_PROPERTY(FORMS_MDI_WINDOW,TITLE,'MAXYS - SISTEMA DE GESTÃO CORPORATIVA                                                                                  MAXICON SYSTEMS');&#10;  SET_WINDOW_PROPERTY('WIN_ITEMSIMILAR',WINDOW_STATE,NORMAL);&#10;  SET_WINDOW_PROPERTY('WIN_ITEMSIMILAR',POSITION,0,1);&#10;  SET_WINDOW_PROPERTY('WIN_ITEMSIMILAR',WINDOW_SIZE,1011,562);&#10;  SET_WINDOW_PROPERTY('WIN_ITEMSIMILAR',TITLE,:SYSTEM.CURRENT_FORM||' - '||:GLOBAL.DS_PROGRAMA||'                                                   '||:GLOBAL.CD_EMPRESA||'   '||:GLOBAL.CD_USUARIO||' - '||:GLOBAL.NM_USUARIO);&#10;  EXECUTE_QUERY;&#10;  IF :GLOBAL.TP_ACESSO = 'C' THEN&#10;     SET_MENU_ITEM_PROPERTY('TOOLBAR.GRAVA',ENABLED,PROPERTY_FALSE);&#10;     SET_MENU_ITEM_PROPERTY('TOOLBAR.NOVO',ENABLED,PROPERTY_FALSE);&#10;     SET_MENU_ITEM_PROPERTY('TOOLBAR.EXCLUI',ENABLED,PROPERTY_FALSE);&#10;  ELSE&#10;     SET_MENU_ITEM_PROPERTY('TOOLBAR.GRAVA',ENABLED,PROPERTY_TRUE);&#10;     SET_MENU_ITEM_PROPERTY('TOOLBAR.NOVO',ENABLED,PROPERTY_TRUE);&#10;     SET_MENU_ITEM_PROPERTY('TOOLBAR.EXCLUI',ENABLED,PROPERTY_TRUE);&#10;  END IF;&#10;     SET_MENU_ITEM_PROPERTY('TOOLBAR.IMPRIME',ENABLED,PROPERTY_FALSE);&#10;END;">
</node>
</node>
</node>
<node TEXT="APOS_INICIALIZACAO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="EXECUTE_TRIGGER('WHEN-NEW-FORM-INSTANCE');">
</node>
</node>
</node>
</node>
</node>
<node TEXT="blocks">
<icon BUILTIN="Descriptor.grouping"/>
<node TEXT="ITEMSIMILAR">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DT_RECORD: Datetime(16)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Registro">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEMBAL: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Produto da balança">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Item de balança">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Entrar com o item de balança">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMBAL">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;   IF (:ITEMSIMILAR.CD_ITEMBAL IS NOT NULL) THEN&#10;      SELECT ITEMBALANCA.DS_ITEMBAL&#10;      INTO :ITEMSIMILAR.TXTDS_ITEMBAL&#10;      FROM ITEMBALANCA&#10;      WHERE (ITEMBALANCA.CD_ITEMBAL = :ITEMSIMILAR.CD_ITEMBAL);&#10;   ELSE&#10;       MESSAGE('O Item não pode ser nulo.');&#10;       RAISE FORM_TRIGGER_FAILURE;&#10;   END IF;&#10;EXCEPTION&#10;   WHEN NO_DATA_FOUND THEN&#10;      --MESSAGE('Item de balança não cadastrado');&#10;      MENSAGEM_PADRAO(25, '¢CD_ITEMBAL='||:ITEMSIMILAR.CD_ITEMBAL||'¢');&#10;      :ITEMSIMILAR.TXTDS_ITEMBAL := NULL;&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Produto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Entrar com o item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="/**NEU:25/09/2006:13471&#10; * MODIFICADO PARA BUSCAR DA TABELA ITEMEMPRESA.DT_CANCELAMENTO, SOMENTE PERMITINDO O &#10; * CADASTRAMENTO DE ITEM QUE ESTÃO ATIVOS.&#10; */&#10;BEGIN&#10;  IF :ITEMSIMILAR.CD_ITEM IS NOT NULL THEN&#10;    BEGIN&#10;      SELECT DISTINCT ITEM.DS_ITEM&#10;        INTO :ITEMSIMILAR.TXTDS_ITEM&#10;        FROM ITEMEMPRESA,ITEM&#10;       WHERE ITEMEMPRESA.CD_ITEM = ITEM.CD_ITEM&#10;         AND ITEM.CD_ITEM = :ITEMSIMILAR.CD_ITEM&#10;         AND ITEMEMPRESA.DT_CANCELAMENTO IS NULL;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --MESSAGE('O Item não está cadastrado ou está cancelado.');&#10;        MENSAGEM_PADRAO(3662, '¢CD_ITEM='||:ITEMSIMILAR.CD_ITEM||'¢');&#10;        :ITEMSIMILAR.TXTDS_ITEM := NULL;&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;    END;  &#10;  END IF;&#10;END;&#10;&#10;BEGIN&#10;  IF :ITEMSIMILAR.CD_ITEM IS NOT NULL THEN&#10;    SELECT ITEM.DS_ITEM&#10;      INTO :ITEMSIMILAR.TXTDS_ITEM&#10;      FROM ITEMEMPRESA,ITEM, ITEMSIMILAR&#10;     WHERE ITEMEMPRESA.CD_ITEM = ITEM.CD_ITEM&#10;       AND ITEMSIMILAR.CD_ITEM = ITEM.CD_ITEM&#10;       AND ITEMEMPRESA.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#10;       AND ITEM.CD_ITEM = :ITEMSIMILAR.CD_ITEM&#10;       AND ITEMEMPRESA.DT_CANCELAMENTO IS NULL;&#10;    --MESSAGE('O item não pode ser duplicado.');&#10;    MENSAGEM_PADRAO(13077, '¢CD_ITEM='||:ITEMSIMILAR.CD_ITEM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  END IF;&#10;EXCEPTION &#10;  WHEN NO_DATA_FOUND THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TXTDS_ITEM: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TXTDS_ITEMBAL: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do item de balança">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_MOVTOGRAOS: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Somente&#10;Grãos">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Restrição de utilização deste Item/produto somente em programas do Modulo de Grãos">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="N">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CULTURA: Number(3)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cultura">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_CULTURA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="/*FAB:05/09/08:9986&#10; * Para incluir a cultura nas entradas e saidas de graos e gravar no contaspagrec &#10;*/&#10;BEGIN&#10;   IF :ITEMSIMILAR.CD_CULTURA IS NOT NULL THEN&#10;      SELECT DS_CULTURA&#10;        INTO :ITEMSIMILAR.TXTDS_CULTURA&#10;        FROM CULTURA&#10;       WHERE CULTURA.CD_CULTURA = :ITEMSIMILAR.CD_CULTURA;&#10;   END IF;&#10;EXCEPTION&#10;   WHEN NO_DATA_FOUND THEN&#10;      --MESSAGE('Cultura ('||:ITEMSIMILAR.CD_CULTURA||') não cadastrada');&#10;      MENSAGEM_PADRAO(637, '¢CD_CULTURA='||:ITEMSIMILAR.CD_CULTURA||'¢');&#10;      :ITEMSIMILAR.TXTDS_ITEM := NULL;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TXTDS_CULTURA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="CONSULTA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_CAMPO: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-MOUSE-CLICK">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('CONSULTA.VALOR_INICIAL'); --adicionado por Gustavo em 05/01/2005">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALOR_INICIAL: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="VALOR_FINAL: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="TP_CONSULTA: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_CONSULTAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_FECHAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_CAMPO: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="TP_ITEM: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
</node>
</node>
<node TEXT="CONTROLE">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="BTN_CADASTRATPCALC: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM     VARCHAR2(32000);&#10;  E_GERAL         EXCEPTION;&#10;  &#10;BEGIN&#10;  &#10;  :CONTROLE.CD_ITEMSIMILAR := :ITEMSIMILAR.CD_ITEM;&#10;  :CONTROLE.DS_ITEMSIMILAR := :ITEMSIMILAR.TXTDS_ITEM;&#10;  PACK_TPCALCULO.CARREGA_TPCALCULO;&#10;  CENTRALIZA_FORM('WIN_ITEMSIMILAR','WIN_TPCALCULO');&#10;  GO_BLOCK('TPCALCULO');&#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Observação', V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro', SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_SALVAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM         VARCHAR2(32000);&#10;  E_GERAL             EXCEPTION;&#10;  V_CD_TIPOCALCULO  NUMBER;&#10;  V_COUNT            NUMBER;&#10;  &#10;BEGIN&#10;  &#10;  V_CD_TIPOCALCULO := :TPCALCULO.CD_TIPOCALCULO;&#10;  GO_BLOCK('TPCALCULO');&#10;  FIRST_RECORD;&#10;  V_COUNT := 0;&#10;  LOOP&#10;    &#10;    IF V_CD_TIPOCALCULO = :TPCALCULO.CD_TIPOCALCULO THEN&#10;      V_COUNT := V_COUNT + 1;&#10;    END IF;&#10;    &#10;    EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;    NEXT_RECORD;&#10;  END LOOP;&#10;  &#10;  IF V_COUNT > 1 THEN&#10;    /*Tipo de Cálculo ¢CD_TPCALC¢ informado mais de uma vez. Verifique.*/&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32641, '¢CD_TPCALC='||:TPCALCULO.CD_TIPOCALCULO||'¢');&#10;    RAISE E_GERAL;&#10;  END IF;&#10;  &#10;  PACK_TPCALCULO.GRAVA_TPCALCULO(V_MENSAGEM);&#10;  IF V_MENSAGEM IS NOT NULL THEN&#10;    RAISE E_GERAL;&#10;  END IF;&#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Observação', V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro', SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_VOLTAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM                  VARCHAR2(2000);&#10;  E_GERAL                      EXCEPTION;&#10;BEGIN&#10;&#10;  GO_BLOCK('ITEMSIMILAR');&#10;  FIRST_RECORD;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('CONTROLE.BTN_SALVAR');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEMSIMILAR: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Produto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEMSIMILAR: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
</node>
</node>
<node TEXT="TPCALCULO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_TIPOCALCULO: Number(3)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Tp. Cálculo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TPCALCULO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL      EXCEPTION;  &#10;BEGIN&#10;&#10;  IF (:TPCALCULO.CD_TIPOCALCULO IS NOT NULL) THEN&#10;    BEGIN&#10;      SELECT TIPOCALCULOPRECO.DS_TIPOCALCULO            &#10;        INTO :TPCALCULO.DS_TPCALCULO             &#10;        FROM TIPOCALCULOPRECO&#10;       WHERE TIPOCALCULOPRECO.CD_TIPOCALCULO  =:TPCALCULO.CD_TIPOCALCULO ;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(402,'¢CD_TIPOCALCULO='||:TPCALCULO.CD_TIPOCALCULO ||'¢'); --Tipo de Cálculo de Preço ¢CD_TIPOCALCULO¢ não Cadastrado. Verifique TIT002.&#10;        RAISE E_GERAL;      &#10;      WHEN TOO_MANY_ROWS THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(403,'¢CD_TIPOCALCULO='||:TPCALCULO.CD_TIPOCALCULO ||'¢'); --Tipo de Cálculo de Preço ¢CD_TIPOCALCULO¢ Cadastrado Várias Vezes. Verifique TIT002.&#10;        RAISE E_GERAL;      &#10;      WHEN OTHERS THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(854,'¢CD_TIPOCALCULO='||:TPCALCULO.CD_TIPOCALCULO ||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar tipo de cálculo ¢CD_TIPOCALCULO¢. Verifique TIT002. Erro: ¢SQLERRM¢.&#10;        RAISE E_GERAL;&#10;    END;      &#10;  END IF; --IF (:CTRC.CD_TIPOCALCMOT IS NOT NULL) THEN  &#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_TPCALCULO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TPCALCULO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="WEBUTIL">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DUMMY: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="if :system.cursor_block = 'WEBUTIL' then &#10;  next_block;&#10;end if;&#10;WebUtil_Core.ShowBeans(false);">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_CLIENTINFO_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_FILE_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_HOST_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_SESSION_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_FILETRANSFER_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_OLE_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_C_API_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="WEBUTIL_BROWSER_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="begin&#10;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#10;end;&#10;  ">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="MAX_BEANS">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="APLICATIVOEXTERNO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DIALOGOSDEPROGRESSO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="BALANCAHRF: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="HRFBEAN: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="ARQUIVOUTILS: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
</node>
</node>
</node>
<node TEXT="list of values">
<icon BUILTIN="Descriptor.grouping"/>
<node TEXT="LOV_TPCALCULO">
<icon BUILTIN="Descriptor.enum"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_TIPOCALCULO: Button(377)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Descrição">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_TIPOCALCULO: Button(41)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Código">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_CULTURA">
<icon BUILTIN="Descriptor.enum"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_CULTURA: Button(310)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Cultura">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CULTURA: Button(46)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Código">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="PROFILE">
<icon BUILTIN="Descriptor.enum"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
</node>
</node>
<node TEXT="LOV_ITEMBAL">
<icon BUILTIN="Descriptor.enum"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_ITEMBAL: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Descrição">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEMBAL: Button(57)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Código">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_ITEM">
<icon BUILTIN="Descriptor.enum"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_ITEM: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Descrição">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Button(57)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Código">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</map>
