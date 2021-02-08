<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1612525950598" MODIFIED="1612525955921" TEXT="tgr009">
<icon BUILTIN="Package"/>
<node CREATED="1612525950598" MODIFIED="1612527043606" POSITION="right" TEXT="TGR009">
<icon BUILTIN="Descriptor.window.editor"/>
<node CREATED="1612525950598" MODIFIED="1612535832598" TEXT="m&#xe9;todos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950598" FOLDED="true" MODIFIED="1612527045455" TEXT="PACK_CONSULTA">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950598" MODIFIED="1612526800999" TEXT="body">
<node CREATED="1612525950598" MODIFIED="1612525950598" TEXT="PACKAGE BODY PACK_CONSULTA IS&#xa;&#xa;  I_TABELA  VARCHAR2(2000);&#xa;  I_TIPO    VARCHAR2(2000);&#xa;&#xa;-------------------------------------------------------------------------------------------------------------------------&#xa;&#xa;  PROCEDURE PEGA_TIPO(PRIM_ITEM IN VARCHAR2,TIPO OUT NUMBER) IS&#xa;    TIPODADO VARCHAR2(80);&#xa;  BEGIN&#xa;    TIPODADO := GET_ITEM_PROPERTY(PRIM_ITEM,DATATYPE);&#xa;    IF (TIPODADO = &apos;ALPHA&apos;) OR (TIPODADO = &apos;CHAR&apos;) THEN&#xa;      TIPO := 1;&#xa;    ELSIF (TIPODADO = &apos;NUMBER&apos;) OR (TIPODADO = &apos;RNUMBER&apos;) OR (TIPODADO = &apos;MONEY&apos;) OR (TIPODADO = &apos;RMONEY&apos;) THEN&#xa;      TIPO := 2;&#xa;    END IF;&#xa;  END PEGA_TIPO;&#xa;&#xa;-------------------------------------------------------------------------------------------------------------------------&#xa;&#xa;  PROCEDURE CONSULTA IS&#xa;    PRIM_ITEM   VARCHAR2(80);&#xa;    ULTI_ITEM   VARCHAR2(80);&#xa;    LABEL_ITEM  VARCHAR2(80);&#xa;    I           NUMBER;&#xa;    TIPO        NUMBER;&#xa;    ITEM_TIPO   VARCHAR2(80);&#xa;  BEGIN&#xa;    I_BLOCO  := :SYSTEM.CURSOR_BLOCK;&#xa;    GO_BLOCK(&apos;CONSULTA&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    I_TABELA := GET_BLOCK_PROPERTY(I_BLOCO,DML_DATA_TARGET_NAME);&#xa;    IF I_TABELA IS NOT NULL THEN&#xa;      PRIM_ITEM := GET_BLOCK_PROPERTY(I_BLOCO,FIRST_ITEM);&#xa;      ULTI_ITEM := GET_BLOCK_PROPERTY(I_BLOCO,LAST_ITEM);&#xa;      I := 1;&#xa;      LOOP&#xa;        I_TIPO     := GET_ITEM_PROPERTY(I_BLOCO||&apos;.&apos;||PRIM_ITEM,DATATYPE);&#xa;        LABEL_ITEM := GET_ITEM_PROPERTY(I_BLOCO||&apos;.&apos;||PRIM_ITEM,PROMPT_TEXT);&#xa;        ITEM_TIPO  := GET_ITEM_PROPERTY(I_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE);&#xa;        IF (PRIM_ITEM &lt;&gt; &apos;DT_RECORD&apos;) AND (ITEM_TIPO &lt;&gt; &apos;DISPLAY ITEM&apos;) AND &#xa;            GET_ITEM_PROPERTY(I_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_CANVAS) IS NOT NULL THEN&#xa;          PEGA_TIPO(I_BLOCO||&apos;.&apos;||PRIM_ITEM,TIPO);&#xa;          :CONSULTA.DS_CAMPO := REPLACE(LABEL_ITEM,CHR(10),&apos; &apos;);&#xa;          :CONSULTA.NM_CAMPO := I_TABELA||&apos;.&apos;||PRIM_ITEM;&#xa;          :CONSULTA.TP_ITEM  := TIPO;&#xa;          NEXT_RECORD;&#xa;        END IF;&#xa;        EXIT WHEN I_BLOCO||&apos;.&apos;||PRIM_ITEM = I_BLOCO||&apos;.&apos;||ULTI_ITEM;&#xa;        PRIM_ITEM := GET_ITEM_PROPERTY(I_BLOCO||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;      END LOOP;&#xa;      CLEAR_RECORD;&#xa;      FIRST_RECORD;&#xa;    END IF;&#xa;  END CONSULTA;&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950604" MODIFIED="1612526828210" TEXT="PACK_CONSULTA">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950604" MODIFIED="1612526829659" TEXT="body">
<node CREATED="1612525950604" MODIFIED="1612525950604" TEXT="PACKAGE PACK_CONSULTA IS &#xa;&#xa;  I_BLOCO  VARCHAR2(1000);&#xa;&#xa;  PROCEDURE CONSULTA;&#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950604" FOLDED="true" MODIFIED="1612525950604" TEXT="VALIDA_ERROS">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950604" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950604" MODIFIED="1612525950604" TEXT="PROCEDURE VALIDA_ERROS IS&#xa;  TIPO_ERRO   VARCHAR2(03) := ERROR_TYPE;&#xa;  CODIGO_ERRO NUMBER       := ERROR_CODE;&#xa;  TMP          VARCHAR2(32000);&#xa;BEGIN&#xa;  IF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41803) THEN&#xa;      --N&#xe3;o h&#xe1; registro anterior a partir do qual copiar valor&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 42100) THEN&#xa;      --N&#xe3;o foram encontrados erros recentemente&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41003) THEN&#xa;      --Esta fun&#xe7;&#xe3;o n&#xe3;o pode ser executada aqui&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40815) THEN&#xa;      --A vari&#xe1;vel %s n&#xe3;o existe&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40222) THEN&#xa;      --Item desativado %s falhou na valida&#xe7;&#xe3;o&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40738) THEN&#xa;      --Argumento 1 para incorporar GO_BLOCK n&#xe3;o pode ser nulo&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41058) THEN&#xa;      --Esta propriedade n&#xe3;o existe para GET_ITEM_PROPERTY&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40104) THEN&#xa;      --No such block %s&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41045) THEN&#xa;      --N&#xe3;o &#xe9; poss&#xed;vel localizar o item : ID inv&#xe1;lido&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41332) THEN&#xa;      --List element index out of range&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40401) THEN&#xa;      --N&#xe3;o h&#xe1; altera&#xe7;&#xf5;es a salvar&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41009) THEN&#xa;      --Tecla de fun&#xe7;&#xe3;o n&#xe3;o permitida&#xa;      NULL;&#xa;  ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40510) THEN&#xa;      TMP := NULL;&#xa;      TMP := DBMS_ERROR_TEXT;&#xa;      IF INSTR(TMP,&apos;ORA-02292&apos;,1) &gt; 0 THEN&#xa;        MESSAGE(&apos;N&#xe3;o foi possivel deletar o registro, registro filho localizado.&apos;);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;      ELSE&#xa;        MESSAGE(&apos;N&#xe3;o foi possivel deletar o registro.&apos;);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;       END IF;&#xa;  ELSE&#xa;     MESSAGE (ERROR_TYPE||&apos;-&apos;||ERROR_CODE||&apos; &apos;||ERROR_TEXT);&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950604" MODIFIED="1612526815242" TEXT="VALIDA_MENSAGEM">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950604" MODIFIED="1612526818226" TEXT="body">
<node CREATED="1612525950605" MODIFIED="1612525950605" TEXT="PROCEDURE VALIDA_MENSAGEM IS&#xa;  TIPO_MENSAGEM   VARCHAR2(03) := MESSAGE_TYPE;&#xa;  CODIGO_MENSAGEM NUMBER       := MESSAGE_CODE;&#xa;BEGIN&#xa;  IF (TIPO_MENSAGEM = &apos;FRM&apos;) AND (CODIGO_MENSAGEM = 40400) THEN&#xa;      --Registro aplicado e salvo&#xa;      MESSAGE (&apos;000002 - Registro salvo com sucesso&apos;);&#xa;  ELSE&#xa;     MESSAGE (MESSAGE_TYPE||&apos;-&apos;||MESSAGE_CODE||&apos; &apos;||MESSAGE_TEXT);&#xa;  END IF;&#xa;END;"/>
</node>
<node CREATED="1612527055811" MODIFIED="1612527058122" TEXT="@">
<node CREATED="1612527059393" LINK="procedures/VALIDA_MENSAGEM.mm" MODIFIED="1612527073502" TEXT="file"/>
</node>
</node>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525950605" TEXT="INSERE_LOGUSUARIO">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950605" MODIFIED="1612525950605" TEXT="PROCEDURE INSERE_LOGUSUARIO(I_DS_EVENTO IN VARCHAR2, I_TP_EVENTO IN VARCHAR2) IS&#xa;BEGIN&#xa;  INSERT INTO LOGUSUARIO&#xa;        (CD_EMPRESA, &#xa;         CD_MODULO, &#xa;         CD_PROGRAMA, &#xa;         CD_USUARIO, &#xa;         DS_EVENTO, &#xa;         DT_EVENTO, &#xa;         HR_EVENTO, &#xa;         SQ_EVENTO, &#xa;         TP_EVENTO)&#xa;        VALUES&#xa;        (:GLOBAL.CD_EMPRESA, &#xa;         :GLOBAL.CD_MODULO, &#xa;         :GLOBAL.CD_PROGRAMA, &#xa;         :GLOBAL.CD_USUARIO, &#xa;         I_DS_EVENTO, &#xa;         TRUNC(SYSDATE), &#xa;         TO_CHAR(SYSDATE,&apos;HH24:MI&apos;), &#xa;         SEQ_AUDITORIA.NEXTVAL, &#xa;         I_TP_EVENTO);  &#xa;    FAZ_COMMIT;&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525950605" TEXT="PACK_TPCALCULO">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950605" MODIFIED="1612525950605" TEXT="PACKAGE PACK_TPCALCULO IS &#xa;  PROCEDURE CARREGA_TPCALCULO;&#xa;  PROCEDURE GRAVA_TPCALCULO (O_MENSAGEM      OUT VARCHAR2);&#xa;  PROCEDURE EXCLUI_TPCALCULO (I_CD_ITEM         IN TPCALCITEMSIMILAR.CD_ITEM%TYPE,&#xa;                              I_CD_TIPOCALCULO IN TPCALCITEMSIMILAR.CD_TIPOCALCULO%TYPE,&#xa;                              O_MENSAGEM       OUT VARCHAR2);&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525950605" TEXT="PACK_TPCALCULO">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950605" MODIFIED="1612525950605" TEXT="PACKAGE BODY PACK_TPCALCULO IS&#xa;  &#xa;  PROCEDURE CARREGA_TPCALCULO IS&#xa;   &#xa;    CURSOR CUR_TPCALCITEMSIMILAR IS&#xa;    SELECT TPCALCITEMSIMILAR.CD_TIPOCALCULO&#xa;      FROM TPCALCITEMSIMILAR&#xa;     WHERE TPCALCITEMSIMILAR.CD_ITEM = :CONTROLE.CD_ITEMSIMILAR&#xa;     ORDER BY TPCALCITEMSIMILAR.CD_ITEM;&#xa;  BEGIN&#xa;    &#xa;    GO_BLOCK(&apos;TPCALCULO&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    FIRST_RECORD;&#xa;    FOR I IN CUR_TPCALCITEMSIMILAR LOOP&#xa;      :TPCALCULO.CD_TIPOCALCULO := I.CD_TIPOCALCULO;&#xa;      &#xa;      IF(GET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, UPDATE_ALLOWED) = &apos;TRUE&apos;) THEN  &#xa;        SET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, INSERT_ALLOWED, PROPERTY_FALSE);&#xa;        SET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, UPDATE_ALLOWED, PROPERTY_FALSE);&#xa;        SET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, VISUAL_ATTRIBUTE, &apos;VSA_CAMPOEXIBICAO&apos;);&#xa;      END IF;&#xa;      &#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;  END CARREGA_TPCALCULO;&#xa;  &#xa;  PROCEDURE GRAVA_TPCALCULO (O_MENSAGEM      OUT VARCHAR2) IS&#xa;&#xa;  E_GERAL            EXCEPTION;&#xa;  BEGIN&#xa;    &#xa;    GO_BLOCK(&apos;TPCALCULO&apos;);&#xa;    FIRST_RECORD;&#xa;    LOOP&#xa;      &#xa;      IF :TPCALCULO.CD_TIPOCALCULO IS NOT NULL THEN&#xa;        &#xa;        BEGIN&#xa;          INSERT INTO TPCALCITEMSIMILAR(CD_ITEM,&#xa;                                        CD_TIPOCALCULO,&#xa;                                        DT_RECORD)&#xa;                                 VALUES(:CONTROLE.CD_ITEMSIMILAR,&#xa;                                         :TPCALCULO.CD_TIPOCALCULO,&#xa;                                         SYSDATE);&#xa;        EXCEPTION&#xa;          WHEN DUP_VAL_ON_INDEX THEN&#xa;            NULL;&#xa;          WHEN OTHERS THEN&#xa;            /*Ocorreu um erro inesperado ao gravar o Tp. C&#xe1;lculo &#xa2;CD_TPCALC&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.*/&#xa;            O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32626, &apos;&#xa2;CD_TPCALC=&apos;||:TPCALCULO.CD_TIPOCALCULO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;            RAISE E_GERAL;&#xa;        END;&#xa;        IF(GET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, UPDATE_ALLOWED) = &apos;TRUE&apos;) THEN  &#xa;          SET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, INSERT_ALLOWED, PROPERTY_FALSE);&#xa;          SET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, UPDATE_ALLOWED, PROPERTY_FALSE);&#xa;          SET_ITEM_INSTANCE_PROPERTY(&apos;TPCALCULO.CD_TIPOCALCULO&apos;, CURRENT_RECORD, VISUAL_ATTRIBUTE, &apos;VSA_CAMPOEXIBICAO&apos;);&#xa;        END IF;&#xa;      END IF;      &#xa;      EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;      NEXT_RECORD;    &#xa;    END LOOP;&#xa;    FIRST_RECORD;&#xa;    IF FORM_SUCCESS THEN&#xa;      /*Apropria&#xe7;&#xe3;o de Frete gerada com sucesso com os seguintes lotes cont&#xe1;beis &#xa2;V_LOTES&#xa2;.*/      &#xa;      FAZ_COMMIT;&#xa;      /*Registro salvo com sucesso.*/&#xa;      MENSAGEM_PADRAO(2926, NULL);&#xa;    END IF;&#xa;  &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      O_MENSAGEM := &apos;&#xa5;[GRAVA_TPCALCULO] &#xa5;&apos;||O_MENSAGEM;&#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM := &apos;&#xa5;[GRAVA_TPCALCULO: Erro] &#xa5;&apos;||SQLERRM;&#xa;  END GRAVA_TPCALCULO;&#xa;  &#xa;  PROCEDURE EXCLUI_TPCALCULO (I_CD_ITEM         IN TPCALCITEMSIMILAR.CD_ITEM%TYPE,&#xa;                              I_CD_TIPOCALCULO IN TPCALCITEMSIMILAR.CD_TIPOCALCULO%TYPE,&#xa;                              O_MENSAGEM       OUT VARCHAR2) IS&#xa;&#xa;  E_GERAL            EXCEPTION;&#xa;  BEGIN&#xa;    &#xa;    BEGIN&#xa;      DELETE &#xa;        FROM TPCALCITEMSIMILAR&#xa;       WHERE TPCALCITEMSIMILAR.CD_ITEM = I_CD_ITEM&#xa;          AND TPCALCITEMSIMILAR.CD_TIPOCALCULO = I_CD_TIPOCALCULO;&#xa;      EXCEPTION&#xa;        WHEN OTHERS THEN&#xa;        /*Erro ao excluir registros &#xa2;TABELA&#xa2;. Erro &#xa2;SQLERRM&#xa2;*/&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(14853, &apos;&#xa2;TABELA=&apos;||&apos;TPCALCITEMSIMILAR&apos;||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;  &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      O_MENSAGEM := &apos;&#xa5;[EXCLUI_TPCALCULO] &#xa5;&apos;||O_MENSAGEM;&#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM := &apos;&#xa5;[EXCLUI_TPCALCULO: Erro] &#xa5;&apos;||SQLERRM;&#xa;  END EXCLUI_TPCALCULO;&#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525950605" TEXT="CENTRALIZA_FORM">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950605" MODIFIED="1612525950605" TEXT="PROCEDURE CENTRALIZA_FORM(NM_FORMPRINCIPAL IN VARCHAR2, NM_FORMFILHO IN VARCHAR2) IS&#xa;  V_WIDTH_PRINCIPAL   NUMBER;&#xa;  V_HEIGHT_PRINCIPAL NUMBER;&#xa;  V_WIDTH_LAYOUT     NUMBER;&#xa;  V_HEIGHT_LAYOUT    NUMBER;&#xa;  V_X_POS             NUMBER;&#xa;  V_Y_POS             NUMBER;&#xa;&#xa;BEGIN&#xa;  V_WIDTH_PRINCIPAL  := GET_WINDOW_PROPERTY(NM_FORMPRINCIPAL,WIDTH);&#xa;  V_HEIGHT_PRINCIPAL := GET_WINDOW_PROPERTY(NM_FORMPRINCIPAL,HEIGHT);&#xa;  &#xa;  V_WIDTH_LAYOUT     := GET_WINDOW_PROPERTY(NM_FORMFILHO,WIDTH);&#xa;  V_HEIGHT_LAYOUT    := GET_WINDOW_PROPERTY(NM_FORMFILHO,HEIGHT);&#xa;  &#xa;  V_X_POS := (V_WIDTH_PRINCIPAL  - V_WIDTH_LAYOUT)  / 2;&#xa;  V_Y_POS := (V_HEIGHT_PRINCIPAL - V_HEIGHT_LAYOUT) / 2;&#xa;  &#xa;  SET_WINDOW_PROPERTY(NM_FORMFILHO,X_POS,V_X_POS);&#xa;  SET_WINDOW_PROPERTY(NM_FORMFILHO,Y_POS,V_Y_POS);&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950605" FOLDED="true" MODIFIED="1612525950605" TEXT="MSG_CONFIRMACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950606" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950606" MODIFIED="1612525950606" TEXT="FUNCTION MSG_CONFIRMACAO (V_DESCRICAO IN VARCHAR2) RETURN BOOLEAN IS&#xa;  RETORNO NUMBER; &#xa;BEGIN&#xa;    /*&#xa;    V_MENSAGEM := &apos;J&#xe1; Existem Dados Gravados Para Este Per&#xed;odo,&#xd;Para esta empresa e esta Vers&#xe3;o.&#xd;Se Gravar Novamente Ir&#xe1; Apagar os Valores Anteriores&#xd; Deseja Continuar..?&apos;;&#xa;    IF NOT MSG_CONFIRMACAO(V_MENSAGEM) THEN&#xa;      V_MENSAGEM := &apos;Gera&#xe7;&#xe3;o do Relatorio Cancelada Pelo Usu&#xe1;rio.&apos;;&#xa;      RAISE E_GERAL;&#xa;    END IF;  &#xa;    */ &#xa;    SET_ALERT_PROPERTY(&apos;MENSAGEM_EDICAO&apos;,ALERT_MESSAGE_TEXT,V_DESCRICAO); &#xa;    RETORNO := SHOW_ALERT(&apos;MENSAGEM_EDICAO&apos;);&#xa;    IF RETORNO &lt;&gt; 88 THEN&#xa;      RETURN(FALSE);&#xa;    ELSE&#xa;      RETURN(TRUE);&#xa;    END IF;    &#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950606" FOLDED="true" MODIFIED="1612525950606" TEXT="MENSAGEM">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950606" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950606" MODIFIED="1612525950606" TEXT="PROCEDURE MENSAGEM (V_DS_TITULO IN VARCHAR2,V_DS_MENSAGEM IN VARCHAR2,V_TP_MENSAGEM IN NUMBER) IS&#xa;/* &#xa;    &#xa;     Como usar?&#xa;     &#xa;     MENSAGEM (TITULO,MENSAGEM,ESTILO);&#xa;     &#xa;     TITULO(varchar2)   = titulo da janela de mensagem&#xa;     MENSAGEM(varchar2) = mensagem central&#xa;     ESTILO(Number)     = estilo da mensagem (icone)&#xa;       - 1 = Erro&#xa;       - 2 = Observacao&#xa;       - 3 = Precaucao&#xa;       - 4 = Aparece na barra (N&#xe3;o utiliza titulo) &#xa;&#xa;*/&#xa;  ALERT_ID ALERT;&#xa;  MENSAGEM VARCHAR2(32000);&#xa;  RETORNO  NUMBER;&#xa;  &#xa;  V_ST_PADRAO   VARCHAR2(1) := &apos;N&apos;; -- &apos;S&apos; - SIM &apos;N&apos; - N&#xc3;O&#xa;  V_CD_MENSAGEM VARCHAR2(32000);&#xa;  V_NR_POSISAO  NUMBER;&#xa;  E_NAO_MOSTRA_MENSAGEM EXCEPTION;&#xa;  V_GLOBAL_ST_AUTOMACAO VARCHAR2(3000);&#xa;  V_GLOBAL_CD_VERSAOPARMGEM VARCHAR2(3000);&#xa;  V_ST_AUTOMACAO VARCHAR2(1);&#xa;BEGIN&#xa;  V_GLOBAL_ST_AUTOMACAO := &apos;GLOBAL.ST_AUTOMACAO_&apos;||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#xa;  DEFAULT_VALUE(NULL, V_GLOBAL_ST_AUTOMACAO);&#xa;  V_ST_AUTOMACAO := NVL(NAME_IN(V_GLOBAL_ST_AUTOMACAO), &apos;N&apos;);&#xa;  /* MGT:17/06/2013:60343 - Adicionado chamada utilizando NAME_IN para que mesmo que uma tela n&#xe3;o utilize o envio de &#xa;   * emails automatico o proceduimento MENSAGEM posso ser utilizado normalmente, essa variavel global &#xe9; preenchida&#xa;   * pelo programa UTI032, quando o mesma chama os programa que tem o envio de email automatizado.&#xa;  */&#xa;  IF NVL(V_ST_AUTOMACAO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;    &#xa;    V_GLOBAL_CD_VERSAOPARMGEM := &apos;GLOBAL.CD_VERSAOPARMGEN_&apos;||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#xa;    DEFAULT_VALUE(NULL, V_GLOBAL_CD_VERSAOPARMGEM);&#xa;    &#xa;    PACK_RELEMAIL.INSERE_LOGRELEMAIL(:GLOBAL.CD_USUARIO,&#xa;                                     :GLOBAL.CD_MODULO,&#xa;                                     :GLOBAL.CD_PROGRAMA,&#xa;                                     NAME_IN(V_GLOBAL_CD_VERSAOPARMGEM),&#xa;                                     V_DS_MENSAGEM);&#xa;    RAISE E_NAO_MOSTRA_MENSAGEM;&#xa;  END IF;&#xa;  &#xa;  V_ST_PADRAO := &apos;N&apos;;&#xa;  &#xa;  -- TESTA SE A MENSAGEM EH PAD&#xc7;&#xc3;O OU NAUM --&#xa;  IF INSTR(V_DS_MENSAGEM,&apos;&#xa2;MPM=&apos;) &gt; 0 THEN&#xa;    V_ST_PADRAO   := &apos;S&apos;; -- EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;    V_NR_POSISAO  := INSTR(V_DS_MENSAGEM,&apos;&#xa2;MPM=&apos;) + 5;&#xa;    V_CD_MENSAGEM := SUBSTR(V_DS_MENSAGEM,V_NR_POSISAO,9);&#xa;  ELSE&#xa;    V_ST_PADRAO := &apos;N&apos;; -- N&#xc3;O EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;  END IF;&#xa;  &#xa;  /**JMS:28/09/2006:14099&#xa;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USU&#xc1;RIO ELE ABRA O MEU FORM COM A MENSAGEM&#xa;   * E N&#xc3;O A JANELA PADR&#xc3;O DO FORMS, DESTA FORMA &#xc9; POSS&#xcd;VEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#xa;   */&#xa;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#xa;  IF (V_TP_MENSAGEM &lt;&gt; 4) THEN&#xa;    IF NVL(V_ST_PADRAO,&apos;N&apos;) = &apos;N&apos; THEN&#xa;      PACK_MENSAGEM.SET_TITULO(V_DS_TITULO);&#xa;      PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#xa;      PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#xa;      &#xa;      /* FBZ:06/09/2019:137847&#xa;       * Aconteceram alguns casos no Maxys Web em tela complexas em que essa chamada do CALL_FORM&#xa;       * fez com que o processo frmweb.exe no servidor fosse encerrado de forma inesperada. Era uma situa&#xe7;&#xe3;o&#xa;       * espor&#xe1;rica, mas aparentemente esse SYNCHRONIZE faz com que o erro pare de acontecer.&#xa;       */&#xa;      IF (NOT EXECUTANDO_NO_FORMS_6) THEN&#xa;        SYNCHRONIZE;&#xa;      END IF;&#xa;      &#xa;      CALL_FORM (&apos;ABT002&apos;, NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#xa;    ELSE&#xa;      MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#xa;    END IF;&#xa;  ELSE&#xa;    CLEAR_MESSAGE;&#xa;    MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#xa;  END IF;&#xa;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#xa;&#xa;  /*&#xa;  IF V_ST_PADRAO = &apos;N&apos; THEN&#xa;    MENSAGEM := &apos;MENSAGEM_&apos;;&#xa;    IF (V_TP_MENSAGEM = 1) THEN&#xa;      MENSAGEM := MENSAGEM || &apos;ERRO&apos;;&#xa;    ELSIF (V_TP_MENSAGEM = 2) THEN&#xa;      MENSAGEM := MENSAGEM || &apos;OBSERVACAO&apos;;&#xa;    ELSIF (V_TP_MENSAGEM = 3) THEN&#xa;      MENSAGEM := MENSAGEM || &apos;PRECAUCAO&apos;;&#xa;    END IF;  &#xa;    IF (V_TP_MENSAGEM &lt;&gt; 4) THEN&#xa;      ALERT_ID := FIND_ALERT(MENSAGEM);&#xa;      SET_ALERT_PROPERTY(ALERT_ID,ALERT_MESSAGE_TEXT,V_DS_MENSAGEM);&#xa;      SET_ALERT_PROPERTY(ALERT_ID,TITLE,V_DS_TITULO);&#xa;      RETORNO := SHOW_ALERT(ALERT_ID);&#xa;    ELSE&#xa;      CLEAR_MESSAGE;&#xa;      MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#xa;    END IF;&#xa;  ELSIF V_ST_PADRAO = &apos;S&apos; THEN&#xa;    MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#xa;  END IF;  &#xa;  */&#xa;EXCEPTION&#xa;  WHEN E_NAO_MOSTRA_MENSAGEM THEN&#xa;    NULL;  &#xa;END;"/>
</node>
</node>
<node CREATED="1612525950606" FOLDED="true" MODIFIED="1612525950606" TEXT="MENSAGEM_PADRAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1612525950606" FOLDED="true" MODIFIED="1612525955917" TEXT="body">
<node CREATED="1612525950606" MODIFIED="1612525950606" TEXT="PROCEDURE MENSAGEM_PADRAO(I_CD_MENSAGEM IN VARCHAR2,&#xa;                          I_PARAMETRO   IN VARCHAR2) IS -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#xa;/* &#xa;    &#xa;  I_CD_MENSAGEM = -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#xa;&#xa;*/&#xa;&#xa;  ALERT_ID       ALERT;&#xa;  MENSAGEM       VARCHAR2(32000);&#xa;  RETORNO        NUMBER;&#xa;  I_MENSAGEM    VARCHAR2(32000);&#xa;  V_TP_MENSAGEM VARCHAR2(32000);&#xa;  V_DS_MENSAGEM VARCHAR2(32000);&#xa;  J_DS_MENSAGEM VARCHAR2(32000);&#xa;  V_CD_MENSAGEM VARCHAR2(32000);&#xa;  V_TITULO      VARCHAR2(32000);&#xa;  &#xa;  V_DEFAULT_BROWSER    VARCHAR2(32000);&#xa;  V_TP_CONEXAO        VARCHAR2(32000);&#xa;  V_CAMINHO_AJUDA      VARCHAR2(32000);&#xa;  ARQUIVO_NAO_EXISTE  EXCEPTION;&#xa;&#xa;&#xa;  V_ST_MENSPRONTA VARCHAR2(1) := &apos;N&apos;; -- &apos;S&apos; - SIM &apos;N&apos; - N&#xc3;O&#xa;  V_NR_POSISAO    NUMBER;&#xa;  E_NAO_MOSTRA_MENSAGEM EXCEPTION;&#xa;  V_GLOBAL_ST_AUTOMACAO VARCHAR2(3000);&#xa;  V_GLOBAL_CD_VERSAOPARMGEM VARCHAR2(3000);&#xa;  V_ST_AUTOMACAO VARCHAR2(1);&#xa;BEGIN&#xa;  V_GLOBAL_ST_AUTOMACAO := &apos;GLOBAL.ST_AUTOMACAO_&apos;||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#xa;  DEFAULT_VALUE(NULL, V_GLOBAL_ST_AUTOMACAO);&#xa;  V_ST_AUTOMACAO := NVL(NAME_IN(V_GLOBAL_ST_AUTOMACAO), &apos;N&apos;);&#xa;  /* MGT:17/06/2013:60343 - Adicionado chamada utilizando NAME_IN para que mesmo que uma tela n&#xe3;o utilize o envio de &#xa;   * emails automatico o proceduimento MENSAGEM_PADRAO posso ser utilizado normalmente, essa variavel global &#xe9; preenchida&#xa;   * pelo programa UTI032, quando o mesma chama os programa que tem o envio de email automatizado.&#xa;  */&#xa;  IF NVL(V_ST_AUTOMACAO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;    &#xa;    V_GLOBAL_CD_VERSAOPARMGEM := &apos;GLOBAL.CD_VERSAOPARMGEN_&apos;||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||PACK_SESSAO.RETORNA_SID;&#xa;    DEFAULT_VALUE(NULL, V_GLOBAL_CD_VERSAOPARMGEM);&#xa;    &#xa;    PACK_RELEMAIL.INSERE_LOGRELEMAIL(:GLOBAL.CD_USUARIO,&#xa;                                     :GLOBAL.CD_MODULO,&#xa;                                     :GLOBAL.CD_PROGRAMA,&#xa;                                     NAME_IN(V_GLOBAL_CD_VERSAOPARMGEM),&#xa;                                     V_DS_MENSAGEM);&#xa;    RAISE E_NAO_MOSTRA_MENSAGEM;&#xa;  END IF;&#xa;&#xa;  V_ST_MENSPRONTA := &apos;N&apos;;&#xa;  &#xa;  &#xa;  -- TESTA SE A MENSAGEM EH PAD&#xc7;&#xc3;O OU NAUM --&#xa;  IF INSTR(I_PARAMETRO,&apos;&#xa2;MPM=&apos;) &gt; 0 THEN&#xa;    V_ST_MENSPRONTA   := &apos;S&apos;; -- EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;  ELSE&#xa;    V_ST_MENSPRONTA := &apos;N&apos;; -- N&#xc3;O EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;  END IF;&#xa;  &#xa;  IF V_ST_MENSPRONTA = &apos;N&apos; THEN&#xa;    -- Pesquisa Mensagem --&#xa;    PACK_MENSAGEM.MONTA_MENSAGEM(I_CD_MENSAGEM,I_PARAMETRO,V_TP_MENSAGEM,V_DS_MENSAGEM,I_MENSAGEM);&#xa;    IF I_MENSAGEM IS NOT NULL THEN&#xa;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;    &#xa;    PACK_MENSAGEM.ARRUMA_CD_MENSAGEM(I_CD_MENSAGEM,V_CD_MENSAGEM,I_MENSAGEM);&#xa;    IF I_MENSAGEM IS NOT NULL THEN&#xa;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;    &#xa;  ELSIF V_ST_MENSPRONTA = &apos;S&apos; THEN&#xa;&#xa;    V_DS_MENSAGEM := SUBSTR(I_PARAMETRO,1,LENGTH(I_PARAMETRO)/*-15*/);&#xa;    V_CD_MENSAGEM := I_CD_MENSAGEM;&#xa;    &#xa;    -- Pesquisa TP_MENSAGEM --&#xa;    PACK_MENSAGEM.MONTA_MENSAGEM(V_CD_MENSAGEM,&apos;&#xa2;&#xa2;&apos;,V_TP_MENSAGEM,J_DS_MENSAGEM,I_MENSAGEM);&#xa;    IF I_MENSAGEM IS NOT NULL THEN&#xa;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;    &#xa;  END IF;  &#xa;&#xa;  MENSAGEM := &apos;MENSAGEM_&apos;;&#xa;  IF V_TP_MENSAGEM = &apos;E&apos; THEN&#xa;    MENSAGEM := MENSAGEM||&apos;ERRO&apos;;&#xa;    V_TITULO := &apos;ERRO&apos;;&#xa;  ELSIF V_TP_MENSAGEM = &apos;O&apos; THEN&#xa;    MENSAGEM := MENSAGEM||&apos;OBSERVACAO&apos;;&#xa;    V_TITULO := &apos;Observa&#xe7;&#xe3;o&apos;;&#xa;  ELSIF V_TP_MENSAGEM = &apos;P&apos; THEN&#xa;    MENSAGEM := MENSAGEM||&apos;PRECAUCAO&apos;;&#xa;    V_TITULO := &apos;Precau&#xe7;&#xe3;o&apos;;&#xa;  END IF;&#xa;  --MENSAGEM := MENSAGEM||&apos;_NOVA&apos;;&#xa;  V_TITULO := V_TITULO||&apos; - &apos;||V_CD_MENSAGEM;&#xa;  &#xa;  /**JMS:28/09/2006:14099&#xa;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USU&#xc1;RIO ELE ABRA O MEU FORM COM A MENSAGEM&#xa;   * E N&#xc3;O A JANELA PADR&#xc3;O DO FORMS, DESTA FORMA &#xc9; POSS&#xcd;VEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#xa;   */&#xa;  IF (V_TP_MENSAGEM &lt;&gt; &apos;A&apos;) THEN&#xa;    PACK_MENSAGEM.SET_TITULO(V_TITULO);&#xa;    PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#xa;    PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#xa;    PACK_MENSAGEM.SET_CODIGO_MENSAGEM(V_CD_MENSAGEM);&#xa;    CALL_FORM(&apos;ABT002&apos;, NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#xa;  ELSE&#xa;    CLEAR_MESSAGE;&#xa;    MESSAGE(V_DS_MENSAGEM,ACKNOWLEDGE);&#xa;  END IF;&#xa;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#xa;   &#xa;EXCEPTION&#xa;  WHEN ARQUIVO_NAO_EXISTE THEN&#xa;    NULL;&#xa;  WHEN E_NAO_MOSTRA_MENSAGEM THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" MODIFIED="1612535922275" POSITION="right" TEXT="blocks">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950607" MODIFIED="1612533188789" TEXT="ITEMSIMILAR">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1612525950607" MODIFIED="1612533190555" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525950607" TEXT="DT_RECORD: Datetime(16)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="@">
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Dt Registro">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" MODIFIED="1612533193424" TEXT="CD_ITEMBAL: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950607" MODIFIED="1612533194410" TEXT="@">
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Produto da balan&#xe7;a">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Item de balan&#xe7;a">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Entrar com o item de balan&#xe7;a">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="LOV_ITEMBAL">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" MODIFIED="1612533198984" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612533201086" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612533203361" TEXT="body">
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="BEGIN&#xa;   IF (:ITEMSIMILAR.CD_ITEMBAL IS NOT NULL) THEN&#xa;      SELECT ITEMBALANCA.DS_ITEMBAL&#xa;      INTO :ITEMSIMILAR.TXTDS_ITEMBAL&#xa;      FROM ITEMBALANCA&#xa;      WHERE (ITEMBALANCA.CD_ITEMBAL = :ITEMSIMILAR.CD_ITEMBAL);&#xa;   ELSE&#xa;       MESSAGE(&apos;O Item n&#xe3;o pode ser nulo.&apos;);&#xa;       RAISE FORM_TRIGGER_FAILURE;&#xa;   END IF;&#xa;EXCEPTION&#xa;   WHEN NO_DATA_FOUND THEN&#xa;      --MESSAGE(&apos;Item de balan&#xe7;a n&#xe3;o cadastrado&apos;);&#xa;      MENSAGEM_PADRAO(25, &apos;&#xa2;CD_ITEMBAL=&apos;||:ITEMSIMILAR.CD_ITEMBAL||&apos;&#xa2;&apos;);&#xa;      :ITEMSIMILAR.TXTDS_ITEMBAL := NULL;&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" MODIFIED="1612533539203" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950607" MODIFIED="1612533540816" TEXT="@">
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Produto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955917" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Entrar com o item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="LOV_ITEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" MODIFIED="1612533543331" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612533544549" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612533545948" TEXT="body">
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="/**NEU:25/09/2006:13471&#xa; * MODIFICADO PARA BUSCAR DA TABELA ITEMEMPRESA.DT_CANCELAMENTO, SOMENTE PERMITINDO O &#xa; * CADASTRAMENTO DE ITEM QUE EST&#xc3;O ATIVOS.&#xa; */&#xa;BEGIN&#xa;  IF :ITEMSIMILAR.CD_ITEM IS NOT NULL THEN&#xa;    BEGIN&#xa;      SELECT DISTINCT ITEM.DS_ITEM&#xa;        INTO :ITEMSIMILAR.TXTDS_ITEM&#xa;        FROM ITEMEMPRESA,ITEM&#xa;       WHERE ITEMEMPRESA.CD_ITEM = ITEM.CD_ITEM&#xa;         AND ITEM.CD_ITEM = :ITEMSIMILAR.CD_ITEM&#xa;         AND ITEMEMPRESA.DT_CANCELAMENTO IS NULL;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --MESSAGE(&apos;O Item n&#xe3;o est&#xe1; cadastrado ou est&#xe1; cancelado.&apos;);&#xa;        MENSAGEM_PADRAO(3662, &apos;&#xa2;CD_ITEM=&apos;||:ITEMSIMILAR.CD_ITEM||&apos;&#xa2;&apos;);&#xa;        :ITEMSIMILAR.TXTDS_ITEM := NULL;&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;    END;  &#xa;  END IF;&#xa;END;&#xa;&#xa;BEGIN&#xa;  IF :ITEMSIMILAR.CD_ITEM IS NOT NULL THEN&#xa;    SELECT ITEM.DS_ITEM&#xa;      INTO :ITEMSIMILAR.TXTDS_ITEM&#xa;      FROM ITEMEMPRESA,ITEM, ITEMSIMILAR&#xa;     WHERE ITEMEMPRESA.CD_ITEM = ITEM.CD_ITEM&#xa;       AND ITEMSIMILAR.CD_ITEM = ITEM.CD_ITEM&#xa;       AND ITEMEMPRESA.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#xa;       AND ITEM.CD_ITEM = :ITEMSIMILAR.CD_ITEM&#xa;       AND ITEMEMPRESA.DT_CANCELAMENTO IS NULL;&#xa;    --MESSAGE(&apos;O item n&#xe3;o pode ser duplicado.&apos;);&#xa;    MENSAGEM_PADRAO(13077, &apos;&#xa2;CD_ITEM=&apos;||:ITEMSIMILAR.CD_ITEM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  END IF;&#xa;EXCEPTION &#xa;  WHEN NO_DATA_FOUND THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525950607" TEXT="TXTDS_ITEM: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="@">
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Descri&#xe7;&#xe3;o do item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525950607" TEXT="TXTDS_ITEMBAL: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="@">
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Descri&#xe7;&#xe3;o do item de balan&#xe7;a">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525950607" TEXT="ST_MOVTOGRAOS: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="@">
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Somente&#xa;Gr&#xe3;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Restri&#xe7;&#xe3;o de utiliza&#xe7;&#xe3;o deste Item/produto somente em programas do Modulo de Gr&#xe3;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="N">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="LOV_ITEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525950607" TEXT="CD_CULTURA: Number(3)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="@">
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="Cultura">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="LOV_CULTURA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525955918" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525950607" TEXT="body">
<node CREATED="1612525950607" MODIFIED="1612525950607" TEXT="/*FAB:05/09/08:9986&#xa; * Para incluir a cultura nas entradas e saidas de graos e gravar no contaspagrec &#xa;*/&#xa;BEGIN&#xa;   IF :ITEMSIMILAR.CD_CULTURA IS NOT NULL THEN&#xa;      SELECT DS_CULTURA&#xa;        INTO :ITEMSIMILAR.TXTDS_CULTURA&#xa;        FROM CULTURA&#xa;       WHERE CULTURA.CD_CULTURA = :ITEMSIMILAR.CD_CULTURA;&#xa;   END IF;&#xa;EXCEPTION&#xa;   WHEN NO_DATA_FOUND THEN&#xa;      --MESSAGE(&apos;Cultura (&apos;||:ITEMSIMILAR.CD_CULTURA||&apos;) n&#xe3;o cadastrada&apos;);&#xa;      MENSAGEM_PADRAO(637, &apos;&#xa2;CD_CULTURA=&apos;||:ITEMSIMILAR.CD_CULTURA||&apos;&#xa2;&apos;);&#xa;      :ITEMSIMILAR.TXTDS_ITEM := NULL;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950607" FOLDED="true" MODIFIED="1612525950607" TEXT="TXTDS_CULTURA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955918" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955918" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="Descri&#xe7;&#xe3;o do item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="CONSULTA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="DS_CAMPO: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955918" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955918" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955918" TEXT="WHEN-MOUSE-CLICK">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="body">
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="GO_ITEM(&apos;CONSULTA.VALOR_INICIAL&apos;); --adicionado por Gustavo em 05/01/2005"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="VALOR_INICIAL: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="@"/>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="VALOR_FINAL: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="@"/>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="TP_CONSULTA: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="BTN_CONSULTAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="body"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="BTN_FECHAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="body"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="NM_CAMPO: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="@"/>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="TP_ITEM: Button(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="@"/>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612527593023" TEXT="CONTROLE">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1612525950608" MODIFIED="1612526094484" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="BTN_CADASTRATPCALC: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="body">
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="DECLARE&#xa;  V_MENSAGEM     VARCHAR2(32000);&#xa;  E_GERAL         EXCEPTION;&#xa;  &#xa;BEGIN&#xa;  &#xa;  :CONTROLE.CD_ITEMSIMILAR := :ITEMSIMILAR.CD_ITEM;&#xa;  :CONTROLE.DS_ITEMSIMILAR := :ITEMSIMILAR.TXTDS_ITEM;&#xa;  PACK_TPCALCULO.CARREGA_TPCALCULO;&#xa;  CENTRALIZA_FORM(&apos;WIN_ITEMSIMILAR&apos;,&apos;WIN_TPCALCULO&apos;);&#xa;  GO_BLOCK(&apos;TPCALCULO&apos;);&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Observa&#xe7;&#xe3;o&apos;, V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;, SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="BTN_SALVAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="body">
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="DECLARE&#xa;  V_MENSAGEM         VARCHAR2(32000);&#xa;  E_GERAL             EXCEPTION;&#xa;  V_CD_TIPOCALCULO  NUMBER;&#xa;  V_COUNT            NUMBER;&#xa;  &#xa;BEGIN&#xa;  &#xa;  V_CD_TIPOCALCULO := :TPCALCULO.CD_TIPOCALCULO;&#xa;  GO_BLOCK(&apos;TPCALCULO&apos;);&#xa;  FIRST_RECORD;&#xa;  V_COUNT := 0;&#xa;  LOOP&#xa;    &#xa;    IF V_CD_TIPOCALCULO = :TPCALCULO.CD_TIPOCALCULO THEN&#xa;      V_COUNT := V_COUNT + 1;&#xa;    END IF;&#xa;    &#xa;    EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;    NEXT_RECORD;&#xa;  END LOOP;&#xa;  &#xa;  IF V_COUNT &gt; 1 THEN&#xa;    /*Tipo de C&#xe1;lculo &#xa2;CD_TPCALC&#xa2; informado mais de uma vez. Verifique.*/&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32641, &apos;&#xa2;CD_TPCALC=&apos;||:TPCALCULO.CD_TIPOCALCULO||&apos;&#xa2;&apos;);&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;  &#xa;  PACK_TPCALCULO.GRAVA_TPCALCULO(V_MENSAGEM);&#xa;  IF V_MENSAGEM IS NOT NULL THEN&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Observa&#xe7;&#xe3;o&apos;, V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;, SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" MODIFIED="1612526112706" TEXT="BTN_VOLTAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" MODIFIED="1612526114899" TEXT="@">
<node CREATED="1612525950608" MODIFIED="1612526116483" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" MODIFIED="1612526118065" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" MODIFIED="1612526119750" TEXT="body">
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="DECLARE&#xa;  V_MENSAGEM                  VARCHAR2(2000);&#xa;  E_GERAL                      EXCEPTION;&#xa;BEGIN&#xa;&#xa;  GO_BLOCK(&apos;ITEMSIMILAR&apos;);&#xa;  FIRST_RECORD;&#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,V_MENSAGEM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="body">
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="GO_ITEM(&apos;CONTROLE.BTN_SALVAR&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" MODIFIED="1612526098924" TEXT="CD_ITEMSIMILAR: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" MODIFIED="1612526100906" TEXT="@">
<node CREATED="1612525950608" MODIFIED="1612526102639" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="Produto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950608" MODIFIED="1612526109129" TEXT="DS_ITEMSIMILAR: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="@"/>
</node>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="TPCALCULO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="CD_TIPOCALCULO: Number(3)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="@">
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="Tp. C&#xe1;lculo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="LOV_TPCALCULO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525955919" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1612525950608" FOLDED="true" MODIFIED="1612525950608" TEXT="body">
<node CREATED="1612525950608" MODIFIED="1612525950608" TEXT="DECLARE&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  E_GERAL      EXCEPTION;  &#xa;BEGIN&#xa;&#xa;  IF (:TPCALCULO.CD_TIPOCALCULO IS NOT NULL) THEN&#xa;    BEGIN&#xa;      SELECT TIPOCALCULOPRECO.DS_TIPOCALCULO            &#xa;        INTO :TPCALCULO.DS_TPCALCULO             &#xa;        FROM TIPOCALCULOPRECO&#xa;       WHERE TIPOCALCULOPRECO.CD_TIPOCALCULO  =:TPCALCULO.CD_TIPOCALCULO ;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(402,&apos;&#xa2;CD_TIPOCALCULO=&apos;||:TPCALCULO.CD_TIPOCALCULO ||&apos;&#xa2;&apos;); --Tipo de C&#xe1;lculo de Pre&#xe7;o &#xa2;CD_TIPOCALCULO&#xa2; n&#xe3;o Cadastrado. Verifique TIT002.&#xa;        RAISE E_GERAL;      &#xa;      WHEN TOO_MANY_ROWS THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(403,&apos;&#xa2;CD_TIPOCALCULO=&apos;||:TPCALCULO.CD_TIPOCALCULO ||&apos;&#xa2;&apos;); --Tipo de C&#xe1;lculo de Pre&#xe7;o &#xa2;CD_TIPOCALCULO&#xa2; Cadastrado V&#xe1;rias Vezes. Verifique TIT002.&#xa;        RAISE E_GERAL;      &#xa;      WHEN OTHERS THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(854,&apos;&#xa2;CD_TIPOCALCULO=&apos;||:TPCALCULO.CD_TIPOCALCULO ||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Erro ao pesquisar tipo de c&#xe1;lculo &#xa2;CD_TIPOCALCULO&#xa2;. Verifique TIT002. Erro: &#xa2;SQLERRM&#xa2;.&#xa;        RAISE E_GERAL;&#xa;    END;      &#xa;  END IF; --IF (:CTRC.CD_TIPOCALCMOT IS NOT NULL) THEN  &#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,V_MENSAGEM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="DS_TPCALCULO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955919" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955919" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="LOV_TPCALCULO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WEBUTIL">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="DUMMY: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955919" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="if :system.cursor_block = &apos;WEBUTIL&apos; then &#xa;  next_block;&#xa;end if;&#xa;WebUtil_Core.ShowBeans(false);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_CLIENTINFO_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_FILE_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_HOST_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_SESSION_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_FILETRANSFER_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_OLE_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_C_API_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="WEBUTIL_BROWSER_FUNCTIONS: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="WHEN-CUSTOM-ITEM-EVENT">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="body">
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="begin&#xa;  WEBUTIL_CORE.CustomEventHandler(:SYSTEM.CUSTOM_ITEM_EVENT,:SYSTEM.CUSTOM_ITEM_EVENT_PARAMETERS);&#xa;end;&#xa;  "/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="MAX_BEANS">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955920" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="APLICATIVOEXTERNO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="@"/>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="DIALOGOSDEPROGRESSO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="@"/>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="BALANCAHRF: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="@"/>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="HRFBEAN: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="@"/>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="ARQUIVOUTILS: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="@"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" MODIFIED="1612525967603" POSITION="right" TEXT="list of values">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="LOV_TPCALCULO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="DS_TIPOCALCULO: Button(377)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="CD_TIPOCALCULO: Button(41)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="LOV_CULTURA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525950609" TEXT="DS_CULTURA: Button(310)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950609" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950609" MODIFIED="1612525950609" TEXT="Cultura">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525950610" TEXT="CD_CULTURA: Button(46)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950610" MODIFIED="1612525950610" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="PROFILE">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1612525950610" MODIFIED="1612525950610" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
</node>
</node>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="LOV_ITEMBAL">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525950610" TEXT="DS_ITEMBAL: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950610" MODIFIED="1612525950610" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525950610" TEXT="CD_ITEMBAL: Button(57)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950610" MODIFIED="1612525950610" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="LOV_ITEM">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525950610" TEXT="DS_ITEM: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950610" MODIFIED="1612525950610" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525950610" TEXT="CD_ITEM: Button(57)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="@">
<node CREATED="1612525950610" FOLDED="true" MODIFIED="1612525955921" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1612525950610" MODIFIED="1612525950610" TEXT="C&#xf3;digo">
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
