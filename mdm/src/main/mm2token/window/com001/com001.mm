<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1607991779074" ID="ID_673921398" MODIFIED="1607991779074" TEXT="comm001">
<icon BUILTIN="Package"/>
<node CREATED="1607991779074" ID="ID_1318424936" MODIFIED="1607991779074" POSITION="right" TEXT="COM001">
<icon BUILTIN="Descriptor.window.editor"/>
<node CREATED="1607991779074" MODIFIED="1607991779074" TEXT="m&#xe9;todos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779074" FOLDED="true" MODIFIED="1607991779074" TEXT="MENSAGEM_PADRAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779074" MODIFIED="1607991779074" TEXT="body">
<node CREATED="1607991779074" MODIFIED="1607991779074" TEXT="PROCEDURE MENSAGEM_PADRAO(I_CD_MENSAGEM IN VARCHAR2,&#xa;                          I_PARAMETRO   IN VARCHAR2) AS -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#xa;/* &#xa;    &#xa;  I_CD_MENSAGEM = -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#xa;&#xa;*/&#xa;&#xa;  ALERT_ID       ALERT;&#xa;  MENSAGEM       VARCHAR2(32000);&#xa;  RETORNO        NUMBER;&#xa;  I_MENSAGEM    VARCHAR2(32000);&#xa;  V_TP_MENSAGEM VARCHAR2(32000);&#xa;  V_DS_MENSAGEM VARCHAR2(32000);&#xa;  J_DS_MENSAGEM VARCHAR2(32000);&#xa;  V_CD_MENSAGEM VARCHAR2(32000);&#xa;  V_TITULO      VARCHAR2(32000);&#xa;  &#xa;  V_DEFAULT_BROWSER    VARCHAR2(32000);&#xa;  V_TP_CONEXAO        VARCHAR2(32000);&#xa;  V_CAMINHO_AJUDA      VARCHAR2(32000);&#xa;  ARQUIVO_NAO_EXISTE  EXCEPTION;&#xa;&#xa;&#xa;  V_ST_MENSPRONTA VARCHAR2(1) := &apos;N&apos;; -- &apos;S&apos; - SIM &apos;N&apos; - N&#xc3;O&#xa;  V_NR_POSISAO    NUMBER;&#xa;&#xa;&#xa;BEGIN&#xa;  V_ST_MENSPRONTA := &apos;N&apos;;&#xa;  &#xa;  &#xa;  -- TESTA SE A MENSAGEM EH PAD&#xc7;&#xc3;O OU NAUM --&#xa;  IF INSTR(I_PARAMETRO,&apos;&#xa2;MPM=&apos;) &gt; 0 THEN&#xa;    V_ST_MENSPRONTA   := &apos;S&apos;; -- EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;  ELSE&#xa;    V_ST_MENSPRONTA := &apos;N&apos;; -- N&#xc3;O EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;  END IF;&#xa;  &#xa;  IF V_ST_MENSPRONTA = &apos;N&apos; THEN&#xa;    -- Pesquisa Mensagem --&#xa;    PACK_MENSAGEM.MONTA_MENSAGEM(I_CD_MENSAGEM,I_PARAMETRO,V_TP_MENSAGEM,V_DS_MENSAGEM,I_MENSAGEM);&#xa;    IF I_MENSAGEM IS NOT NULL THEN&#xa;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;    &#xa;    PACK_MENSAGEM.ARRUMA_CD_MENSAGEM(I_CD_MENSAGEM,V_CD_MENSAGEM,I_MENSAGEM);&#xa;    IF I_MENSAGEM IS NOT NULL THEN&#xa;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;    &#xa;  ELSIF V_ST_MENSPRONTA = &apos;S&apos; THEN&#xa;&#xa;    V_DS_MENSAGEM := SUBSTR(I_PARAMETRO,1,LENGTH(I_PARAMETRO)/*-15*/);&#xa;    V_CD_MENSAGEM := I_CD_MENSAGEM;&#xa;    &#xa;    -- Pesquisa TP_MENSAGEM --&#xa;    PACK_MENSAGEM.MONTA_MENSAGEM(V_CD_MENSAGEM,&apos;&#xa2;&#xa2;&apos;,V_TP_MENSAGEM,J_DS_MENSAGEM,I_MENSAGEM);&#xa;    IF I_MENSAGEM IS NOT NULL THEN&#xa;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;    &#xa;  END IF;  &#xa;&#xa;  MENSAGEM := &apos;MENSAGEM_&apos;;&#xa;  IF V_TP_MENSAGEM = &apos;E&apos; THEN&#xa;    MENSAGEM := MENSAGEM||&apos;ERRO&apos;;&#xa;    V_TITULO := &apos;ERRO&apos;;&#xa;  ELSIF V_TP_MENSAGEM = &apos;O&apos; THEN&#xa;    MENSAGEM := MENSAGEM||&apos;OBSERVACAO&apos;;&#xa;    V_TITULO := &apos;Observa&#xe7;&#xe3;o&apos;;&#xa;  ELSIF V_TP_MENSAGEM = &apos;P&apos; THEN&#xa;    MENSAGEM := MENSAGEM||&apos;PRECAUCAO&apos;;&#xa;    V_TITULO := &apos;Precau&#xe7;&#xe3;o&apos;;&#xa;  END IF;&#xa;  --MENSAGEM := MENSAGEM||&apos;_NOVA&apos;;&#xa;  V_TITULO := V_TITULO||&apos; - &apos;||V_CD_MENSAGEM;&#xa;  &#xa;  /**JMS:28/09/2006:14099&#xa;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USU&#xc1;RIO ELE ABRA O MEU FORM COM A MENSAGEM&#xa;   * E N&#xc3;O A JANELA PADR&#xc3;O DO FORMS, DESTA FORMA &#xc9; POSS&#xcd;VEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#xa;   */&#xa;  IF (V_TP_MENSAGEM &lt;&gt; &apos;A&apos;) THEN&#xa;    PACK_MENSAGEM.SET_TITULO(V_TITULO);&#xa;    PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#xa;    PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#xa;    PACK_MENSAGEM.SET_CODIGO_MENSAGEM(V_CD_MENSAGEM);&#xa;    CALL_FORM(&apos;ABT002&apos;, NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#xa;  ELSE&#xa;    CLEAR_MESSAGE;&#xa;    MESSAGE(V_DS_MENSAGEM,ACKNOWLEDGE);&#xa;  END IF;&#xa;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#xa;  &#xa;EXCEPTION&#xa;  WHEN ARQUIVO_NAO_EXISTE THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779074" ID="ID_1423508587" MODIFIED="1607991779074" TEXT="MENSAGEM">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779074" FOLDED="true" ID="ID_265262537" MODIFIED="1607991779074" TEXT="body">
<node CREATED="1607991779074" MODIFIED="1607991779074" TEXT="PROCEDURE MENSAGEM (V_DS_TITULO IN VARCHAR2,V_DS_MENSAGEM IN VARCHAR2,V_TP_MENSAGEM IN NUMBER) IS&#xa;/* &#xa;    &#xa;     Como usar?&#xa;     &#xa;     MENSAGEM (TITULO,MENSAGEM,ESTILO);&#xa;     &#xa;     TITULO(varchar2)   = titulo da janela de mensagem&#xa;     MENSAGEM(varchar2) = mensagem central&#xa;     ESTILO(Number)     = estilo da mensagem (icone)&#xa;       - 1 = Erro&#xa;       - 2 = Observacao&#xa;       - 3 = Precaucao&#xa;       - 4 = Aparece na barra (N&#xe3;o utiliza titulo) &#xa;&#xa;*/&#xa;  ALERT_ID ALERT;&#xa;  MENSAGEM VARCHAR2(32000);&#xa;  RETORNO  NUMBER;&#xa;  &#xa;  V_ST_PADRAO   VARCHAR2(1) := &apos;N&apos;; -- &apos;S&apos; - SIM &apos;N&apos; - N&#xc3;O&#xa;  V_CD_MENSAGEM VARCHAR2(32000);&#xa;  V_NR_POSISAO  NUMBER;&#xa;  &#xa;BEGIN&#xa;  &#xa;  V_ST_PADRAO := &apos;N&apos;;&#xa;  &#xa;  -- TESTA SE A MENSAGEM EH PAD&#xc7;&#xc3;O OU NAUM --&#xa;  IF INSTR(V_DS_MENSAGEM,&apos;&#xa2;MPM=&apos;) &gt; 0 THEN&#xa;    V_ST_PADRAO   := &apos;S&apos;; -- EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;    V_NR_POSISAO  := INSTR(V_DS_MENSAGEM,&apos;&#xa2;MPM=&apos;) + 5;&#xa;    V_CD_MENSAGEM := SUBSTR(V_DS_MENSAGEM,V_NR_POSISAO,9);&#xa;  ELSE&#xa;    V_ST_PADRAO := &apos;N&apos;; -- N&#xc3;O EH MENSAGEM PADR&#xc3;O Q VEIO DO BANCO DE DADOS&#xa;  END IF;&#xa;  &#xa;  /**JMS:28/09/2006:14099&#xa;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USU&#xc1;RIO ELE ABRA O MEU FORM COM A MENSAGEM&#xa;   * E N&#xc3;O A JANELA PADR&#xc3;O DO FORMS, DESTA FORMA &#xc9; POSS&#xcd;VEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#xa;   */&#xa;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#xa;  IF (V_TP_MENSAGEM &lt;&gt; 4) THEN&#xa;    IF NVL(V_ST_PADRAO,&apos;N&apos;) = &apos;N&apos; THEN&#xa;      PACK_MENSAGEM.SET_TITULO(V_DS_TITULO);&#xa;      PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#xa;      PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#xa;      CALL_FORM (&apos;ABT002&apos;, NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#xa;    ELSE&#xa;      MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#xa;    END IF;&#xa;  ELSE&#xa;    CLEAR_MESSAGE;&#xa;    MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#xa;  END IF;&#xa;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#xa;&#xa;  /*&#xa;  IF V_ST_PADRAO = &apos;N&apos; THEN&#xa;    MENSAGEM := &apos;MENSAGEM_&apos;;&#xa;    IF (V_TP_MENSAGEM = 1) THEN&#xa;      MENSAGEM := MENSAGEM || &apos;ERRO&apos;;&#xa;    ELSIF (V_TP_MENSAGEM = 2) THEN&#xa;      MENSAGEM := MENSAGEM || &apos;OBSERVACAO&apos;;&#xa;    ELSIF (V_TP_MENSAGEM = 3) THEN&#xa;      MENSAGEM := MENSAGEM || &apos;PRECAUCAO&apos;;&#xa;    END IF;  &#xa;    IF (V_TP_MENSAGEM &lt;&gt; 4) THEN&#xa;      ALERT_ID := FIND_ALERT(MENSAGEM);&#xa;      SET_ALERT_PROPERTY(ALERT_ID,ALERT_MESSAGE_TEXT,V_DS_MENSAGEM);&#xa;      SET_ALERT_PROPERTY(ALERT_ID,TITLE,V_DS_TITULO);&#xa;      RETORNO := SHOW_ALERT(ALERT_ID);&#xa;    ELSE&#xa;      CLEAR_MESSAGE;&#xa;      MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#xa;    END IF;&#xa;  ELSIF V_ST_PADRAO = &apos;S&apos; THEN&#xa;    MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#xa;  END IF;  &#xa;  */&#xa;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779074" ID="ID_392516455" MODIFIED="1610488900095" TEXT="VALIDA_MENSAGEM">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779074" ID="ID_424191098" MODIFIED="1607991779074" TEXT="body">
<node CREATED="1607991779074" MODIFIED="1607991779074" TEXT="PROCEDURE VALIDA_MENSAGEM IS&#xa;  TIPO_MENSAGEM   VARCHAR2(03) := MESSAGE_TYPE;&#xa;  CODIGO_MENSAGEM NUMBER       := MESSAGE_CODE;&#xa;BEGIN&#xa;  IF (TIPO_MENSAGEM = &apos;FRM&apos;) AND (CODIGO_MENSAGEM = 40400) THEN&#xa;      --Registro aplicado e salvo&#xa;      NULL;&#xa;  ELSE&#xa;     MESSAGE (MESSAGE_TYPE||&apos;-&apos;||MESSAGE_CODE||&apos; &apos;||MESSAGE_TEXT);&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779074" ID="ID_469312534" MODIFIED="1607991779074" TEXT="AUDITA_GRAVACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779074" FOLDED="true" ID="ID_103724374" MODIFIED="1607991779074" TEXT="body">
<node CREATED="1607991779074" ID="ID_1316210101" MODIFIED="1607991779074" TEXT="PROCEDURE AUDITA_GRAVACAO IS&#xa;  PRIM_ITEM      VARCHAR2(80);&#xa;  ULTI_ITEM      VARCHAR2(80);&#xa;  STATUS         VARCHAR2(15);&#xa;  PROX_BLOCO     VARCHAR2(80);&#xa;  ULTI_BLOCO     VARCHAR2(80);&#xa;  TABELA         VARCHAR2(80);&#xa;  I_DS_DML       VARCHAR2(32000);&#xa;  I_TP_EVENTO    LOGUSUARIO.TP_EVENTO%TYPE;&#xa;  I_DS_EVENTO    VARCHAR2(32000);&#xa;  I_REGISTRO     VARCHAR2(32000);&#xa;  I_CAMPOS_INS   VARCHAR2(32000);&#xa;  I_VALORES_INS  VARCHAR2(32000);&#xa;  I_INSERT       VARCHAR2(32000);&#xa;  I_CONTADOR_INS NUMBER;&#xa;  I_CAMPOS_UPD   VARCHAR2(32000);&#xa;  I_VALORES_UPD  VARCHAR2(32000);&#xa;  I_UPDATE       VARCHAR2(32000);&#xa;  I_WHERE        VARCHAR2(32000);&#xa;  I_CONTADOR_UPD NUMBER;&#xa;BEGIN&#xa;  --DHG:22411:Incluida verifica&#xe7;&#xe3;o para que sempre volte para o bloco origem ap&#xf3;s terminar a verifica&#xe7;&#xe3;o&#xa;  :GLOBAL.MD_BLOCO := :SYSTEM.CURSOR_BLOCK;&#xa;  PROX_BLOCO := GET_FORM_PROPERTY(:SYSTEM.CURRENT_FORM,FIRST_BLOCK);&#xa;  ULTI_BLOCO := GET_FORM_PROPERTY(:SYSTEM.CURRENT_FORM,LAST_BLOCK);&#xa;  IF PROX_BLOCO IS NOT NULL THEN&#xa;    WHILE (PROX_BLOCO &lt;&gt; ULTI_BLOCO) LOOP&#xa;      /* MRH:17/12/2008:20503&#xa;       * Verifico se o bloco atual n&#xe3;o &#xe9; um bloco padr&#xe3;o usado no Maxys.&#xa;       * Essa verifica&#xe7;&#xe3;o evita que um desses blocos seja exibido na tela&#xa;       * caso o WHILE termine sobre um deles.&#xa;       */&#xa;      IF PROX_BLOCO NOT IN (&apos;IMPRESSAO&apos;,&apos;CONSULTA&apos;,&apos;PROGRESSAO&apos;,&apos;PROGRESSAO2&apos;,&apos;VERSAO_REL&apos;,&apos;BALANCA&apos;) THEN&#xa;        /* MWE:18/09/2007:15149&#xa;         * ao alterar o TGR012, encontrei um erro neste procedimento.&#xa;         * O TGR012 tem um bloco que n&#xe3;o tem item naveg&#xe1;veis e ocorre &#xa;         * erro ao entrar no bloco.&#xa;         * adicionado o comando para retornar true caso o bloco seja neveg&#xe1;vel&#xa;         */ &#xa;        IF GET_BLOCK_PROPERTY(PROX_BLOCO,ENTERABLE) = &apos;TRUE&apos; THEN&#xa;          GO_BLOCK (PROX_BLOCO);&#xa;          I_TP_EVENTO    := &apos;&apos;;&#xa;          I_REGISTRO     := &apos;&apos;;&#xa;          I_DS_EVENTO    := &apos;&apos;;&#xa;          I_CAMPOS_INS   := &apos;&apos;;&#xa;          I_VALORES_INS  := &apos;&apos;;&#xa;          I_INSERT       := &apos;&apos;;&#xa;          I_CONTADOR_INS := 0;&#xa;          I_CAMPOS_UPD   := &apos;&apos;;&#xa;          I_VALORES_UPD  := &apos;&apos;;&#xa;          I_UPDATE       := &apos;&apos;;&#xa;          I_CONTADOR_UPD := 0;&#xa;          I_WHERE        := &apos;&apos;;&#xa;          TABELA         := GET_BLOCK_PROPERTY(PROX_BLOCO,DML_DATA_TARGET_NAME);&#xa;          PRIM_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,FIRST_ITEM);&#xa;          ULTI_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,LAST_ITEM);&#xa;          STATUS         := :SYSTEM.RECORD_STATUS;&#xa;          LOOP&#xa;            IF STATUS = &apos;INSERT&apos; THEN&#xa;              --GDG:05/01/2010:32828 Adicionada verifica&#xe7;&#xe3;o para gravar auditoria dos campos sublinhados(por padr&#xe3;o, s&#xe3;o campos obrigat&#xf3;rios)&#xa;              IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; OR&#xa;                 GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PROMPT_FONT_STYLE) = &apos;UNDERLINE&apos; THEN&#xa;                I_TP_EVENTO := &apos;I&apos;;&#xa;                I_REGISTRO  := I_REGISTRO||&apos; &apos;||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PROMPT_TEXT)||&apos; &apos;||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;                I_DS_EVENTO := (&apos;Inseriu na tabela &apos; || TABELA || &apos; o registro &apos; || I_REGISTRO);&#xa;              END IF;&#xa;              IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NOT NULL THEN&#xa;                IF (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;TEXT ITEM&apos;) OR&#xa;                   (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;LIST&apos;) OR  &#xa;                   (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;RADIO GROUP&apos;) OR &#xa;                   (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;CHECK BOX&apos;) THEN&#xa;                  IF I_CONTADOR_INS = 0 THEN&#xa;                    I_CAMPOS_INS  := &apos; ( &apos;||PRIM_ITEM;&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;                      I_VALORES_INS := &apos; ( &apos;||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;                    ELSE&#xa;                      I_VALORES_INS := &apos; ( &apos;||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;                    END IF;&#xa;                  ELSE&#xa;                    I_CAMPOS_INS := I_CAMPOS_INS||&apos;, &apos;||PRIM_ITEM;&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;                      I_VALORES_INS := I_VALORES_INS||&apos;, &apos;||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;                    ELSE&#xa;                      I_VALORES_INS := I_VALORES_INS||&apos;, &apos;||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;                    END IF;&#xa;                  END IF;&#xa;                  I_INSERT := &apos;INSERT INTO &apos;||TABELA;&#xa;                END IF;&#xa;                I_CONTADOR_INS := I_CONTADOR_INS + 1;&#xa;              END IF;&#xa;            ELSIF STATUS = &apos;CHANGED&apos; THEN&#xa;              IF (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;TEXT ITEM&apos;) OR&#xa;                 (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;LIST&apos;) OR&#xa;                 (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;RADIO GROUP&apos;) OR&#xa;                 (GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,ITEM_TYPE) = &apos;CHECK BOX&apos;) THEN&#xa;                 GO_ITEM (PROX_BLOCO||&apos;.&apos;||PRIM_ITEM);&#xa;                --GDG:05/01/2010:32828 Adicionada verifica&#xe7;&#xe3;o para gravar auditoria dos campos sublinhados(por padr&#xe3;o, s&#xe3;o campos obrigat&#xf3;rios)&#xa;                IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; OR&#xa;                   GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PROMPT_FONT_STYLE) = &apos;UNDERLINE&apos; THEN&#xa;                  I_TP_EVENTO := &apos;A&apos;;&#xa;                  I_REGISTRO  := I_REGISTRO||&apos; &apos;||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PROMPT_TEXT)||&apos; &apos;||:SYSTEM.CURSOR_VALUE;&#xa;                  I_DS_EVENTO := (&apos;Atualizou o registro &apos; || I_REGISTRO || &apos; na tabela &apos; || TABELA);&#xa;                END IF;&#xa;                IF (:SYSTEM.CURSOR_VALUE IS NOT NULL) THEN&#xa;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) &lt;&gt; &apos;TRUE&apos; THEN&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;                      IF (PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.HR_RECORD&apos;) THEN&#xa;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||&apos; = &apos;||CHR(39)||TO_CHAR(RETORNA_DATAHORA,&apos;HH24:MI&apos;)||CHR(39)||&apos;, &apos;;&#xa;                      ELSE&#xa;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||&apos; = &apos;||CHR(39)||:SYSTEM.CURSOR_VALUE||CHR(39)||&apos;, &apos;;&#xa;                      END IF;&#xa;                    ELSE&#xa;                      IF (PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.DT_RECORD&apos;) THEN&#xa;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||&apos; = &apos;||RETORNA_DATAHORA||&apos;, &apos;;&#xa;                      ELSE&#xa;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||&apos; = &apos;||:SYSTEM.CURSOR_VALUE||&apos;, &apos;;&#xa;                      END IF;&#xa;                    END IF;&#xa;                  END IF;&#xa;                ELSIF (:SYSTEM.CURSOR_VALUE IS NULL) THEN&#xa;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) &lt;&gt; &apos;TRUE&apos; THEN&#xa;                    I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||&apos; = &apos;||CHR(39)||&apos; &apos;||CHR(39)||&apos;, &apos;;&#xa;                  END IF;&#xa;                END IF;&#xa;              END IF;&#xa;              IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;                IF I_CONTADOR_UPD = 0 THEN&#xa;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;                    I_CAMPOS_UPD := I_CAMPOS_UPD||PRIM_ITEM||&apos; = &apos;||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;                  ELSE&#xa;                    I_CAMPOS_UPD := I_CAMPOS_UPD||PRIM_ITEM||&apos; = &apos;||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;                  END IF;&#xa;                ELSE&#xa;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;                    I_CAMPOS_UPD := I_CAMPOS_UPD||&apos; AND &apos;||PRIM_ITEM||&apos; = &apos;||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;                  ELSE&#xa;                    I_CAMPOS_UPD := I_CAMPOS_UPD||&apos; AND &apos;||PRIM_ITEM||&apos; = &apos;||GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;                  END IF;&#xa;                END IF;&#xa;                I_CONTADOR_UPD := I_CONTADOR_UPD + 1;&#xa;                I_WHERE        := &apos; WHERE &apos;||I_CAMPOS_UPD;&#xa;              END IF;&#xa;            END IF;&#xa;            EXIT WHEN PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.&apos;||ULTI_ITEM;&#xa;            PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;          END LOOP;&#xa;          IF (I_CAMPOS_INS IS NOT NULL) AND (I_VALORES_INS IS NOT NULL) THEN&#xa;            I_CAMPOS_INS  := I_CAMPOS_INS||&apos;)&apos;;&#xa;            I_VALORES_INS := I_VALORES_INS||&apos;)&apos;;&#xa;            I_INSERT      := I_INSERT||I_CAMPOS_INS||&apos; VALUES &apos;||I_VALORES_INS||&apos;;&apos;;&#xa;          END IF;&#xa;          IF (I_VALORES_UPD IS NOT NULL) THEN&#xa;            I_VALORES_UPD := SUBSTR(I_VALORES_UPD,1,LENGTH(I_VALORES_UPD)-2);&#xa;            I_UPDATE      := &apos;UPDATE &apos;||TABELA||&apos; SET &apos;||I_VALORES_UPD||&apos; &apos;||I_WHERE||&apos;;&apos;;&#xa;          END IF;&#xa;          IF I_TP_EVENTO = &apos;I&apos; THEN&#xa;            I_DS_DML := I_INSERT;&#xa;          ELSE&#xa;            I_DS_DML := I_UPDATE;&#xa;          END IF;&#xa;          IF I_DS_EVENTO IS NOT NULL THEN&#xa;            /*RDS:19/08/2008:18621&#xa;            * Alterado para gravar mais de uma linha na logusuario, caso ultrapasse os 2000 caracteres do campo ds_dml&#xa;            */&#xa;            /*RDS:29177:06/10/2010&#xa;             * Acertado la&#xe7;o na grava&#xe7;&#xe3;o do log no procedimento audita_gravacao&#xa;            */&#xa;            FOR I IN 1.. NVL((TRUNC(LENGTH(I_DS_DML) / 2000) + 1),1) LOOP   &#xa;              BEGIN&#xa;                INSERT INTO LOGUSUARIO (CD_EMPRESA,CD_USUARIO,CD_MODULO,CD_PROGRAMA,&#xa;                                        DT_EVENTO,SQ_EVENTO,HR_EVENTO,DS_EVENTO,TP_EVENTO,DS_DML)&#xa;                        VALUES (:GLOBAL.CD_EMPRESA,:GLOBAL.CD_USUARIO,:GLOBAL.CD_MODULO,&#xa;                                :GLOBAL.CD_PROGRAMA,RETORNA_DATAHORA,SEQ_AUDITORIA.NEXTVAL,&#xa;                                TO_CHAR(RETORNA_DATAHORA,&apos;HH24:MI&apos;),I_DS_EVENTO,I_TP_EVENTO,SUBSTR(I_DS_DML,((I - 1) * 2000 + 1),2000));&#xa;              EXCEPTION&#xa;                WHEN OTHERS THEN&#xa;                  DEBUG_PROGRAMA(&apos;AUDITA_GRAVACAO - Erro durante tentativa de inser&#xe7;&#xe3;o na tabela LOGUSUARIO: &apos;||SQLERRM);&#xa;              END;&#xa;            END LOOP;&#xa;          END IF;&#xa;        END IF;&#xa;      END IF; --IF PROX_BLOCO NOT IN (&apos;IMPRESSAO&apos;,&apos;CONSULTA&apos;,&apos;PROGRESSAO&apos;,&apos;PROGRESSAO2&apos;,&apos;VERSAO_REL&apos;,&apos;BALANCA&apos;) THEN  &#xa;      -- pega o pr&#xf3;ximo bloco&#xa;      PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#xa;    END LOOP;&#xa;  END IF;&#xa;  --DHG:22411:Incluida verifica&#xe7;&#xe3;o para que sempre volte para o bloco origem ap&#xf3;s terminar a verifica&#xe7;&#xe3;o&#xa;  GO_BLOCK(:GLOBAL.MD_BLOCO);&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779074" FOLDED="true" MODIFIED="1607991779074" TEXT="HABILITA_GRAVACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779074" MODIFIED="1607991779074" TEXT="body">
<node CREATED="1607991779074" MODIFIED="1607991779074" TEXT="PROCEDURE HABILITA_GRAVACAO&#xa;   (BLOCO_INICIAL  IN VARCHAR2,&#xa;    BLOCO_FINAL    IN VARCHAR2,&#xa;    ITEM_EXCECAO   IN VARCHAR2,&#xa;    VERIFICA_CHAVE IN VARCHAR2) IS&#xa;    PRIM_ITEM     VARCHAR2(80);&#xa;    ULTI_ITEM     VARCHAR2(80);&#xa;    PROX_BLOCO    VARCHAR2(80);&#xa;    ULTI_BLOCO    VARCHAR2(80);&#xa;BEGIN&#xa;  PROX_BLOCO := BLOCO_INICIAL;&#xa;  ULTI_BLOCO := BLOCO_FINAL;&#xa;  IF :GLOBAL.TP_ACESSO = &apos;M&apos; THEN&#xa;     SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_TRUE);&#xa;     IF (:SYSTEM.RECORD_STATUS = &apos;NEW&apos;) AND (:SYSTEM.LAST_RECORD = &apos;FALSE&apos;) THEN&#xa;        SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;     ELSIF (:SYSTEM.RECORD_STATUS = &apos;NEW&apos;) AND (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;) THEN&#xa;        IF PROX_BLOCO IS NOT NULL THEN&#xa;          LOOP&#xa;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#xa;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#xa;            LOOP&#xa;              IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; THEN&#xa;                 IF VERIFICA_CHAVE = &apos;S&apos; THEN&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                      END IF;&#xa;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;FALSE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    END IF;&#xa;                 END IF;&#xa;              END IF;&#xa;              EXIT WHEN PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.&apos;||ULTI_ITEM;&#xa;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;            END LOOP;&#xa;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#xa;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#xa;          END LOOP;&#xa;        END IF;  &#xa;     ELSIF (:SYSTEM.RECORD_STATUS = &apos;QUERY&apos;) AND (:SYSTEM.LAST_RECORD = &apos;FALSE&apos;) THEN&#xa;        IF PROX_BLOCO IS NOT NULL THEN&#xa;          LOOP&#xa;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#xa;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#xa;            LOOP&#xa;              IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; THEN&#xa;                 IF VERIFICA_CHAVE = &apos;S&apos; THEN&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;FALSE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    END IF;&#xa;                 END IF;&#xa;              END IF;&#xa;              EXIT WHEN PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.&apos;||ULTI_ITEM;&#xa;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;            END LOOP;&#xa;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#xa;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#xa;          END LOOP;&#xa;        END IF;  &#xa;     ELSIF (:SYSTEM.RECORD_STATUS = &apos;QUERY&apos;) AND (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;) THEN&#xa;        IF PROX_BLOCO IS NOT NULL THEN&#xa;           LOOP&#xa;             PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#xa;             ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#xa;             LOOP&#xa;               IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; THEN&#xa;                 IF VERIFICA_CHAVE = &apos;S&apos; THEN&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;FALSE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    END IF;&#xa;                 END IF;&#xa;              END IF;&#xa;              EXIT WHEN PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.&apos;||ULTI_ITEM;&#xa;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;            END LOOP;&#xa;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#xa;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#xa;          END LOOP;&#xa;        END IF;  &#xa;     ELSIF (:SYSTEM.RECORD_STATUS = &apos;INSERT&apos;) AND (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;) THEN&#xa;        IF PROX_BLOCO IS NOT NULL THEN&#xa;          LOOP&#xa;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#xa;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#xa;            LOOP&#xa;              IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; THEN&#xa;                 IF VERIFICA_CHAVE = &apos;S&apos; THEN&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;FALSE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    END IF;&#xa;                 END IF;&#xa;              END IF;&#xa;              EXIT WHEN PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.&apos;||ULTI_ITEM;&#xa;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;            END LOOP;&#xa;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#xa;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#xa;          END LOOP;&#xa;        END IF;  &#xa;     ELSIF (:SYSTEM.RECORD_STATUS = &apos;INSERT&apos;) AND (:SYSTEM.LAST_RECORD = &apos;FALSE&apos;) THEN&#xa;        IF PROX_BLOCO IS NOT NULL THEN&#xa;          LOOP&#xa;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#xa;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#xa;            LOOP&#xa;              IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; THEN&#xa;                 IF VERIFICA_CHAVE = &apos;S&apos; THEN&#xa;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;FALSE&apos; THEN&#xa;                       IF PROX_BLOCO||&apos;.&apos;||PRIM_ITEM &lt;&gt; ITEM_EXCECAO THEN&#xa;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#xa;                             SET_ITEM_PROPERTY(&apos;TOOLBAR.BTN_GRAVA&apos;,ENABLED,PROPERTY_FALSE);&#xa;                          END IF;&#xa;                       END IF;&#xa;                    END IF;&#xa;                 END IF;&#xa;              END IF;&#xa;              EXIT WHEN PROX_BLOCO||&apos;.&apos;||PRIM_ITEM = PROX_BLOCO||&apos;.&apos;||ULTI_ITEM;&#xa;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;            END LOOP;&#xa;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#xa;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#xa;          END LOOP;&#xa;        END IF;  &#xa;     END IF;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="AUDITA_EXCLUSAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE AUDITA_EXCLUSAO IS&#xa;  PRIM_ITEM   VARCHAR2(80);&#xa;  ULTI_ITEM   VARCHAR2(80);&#xa;  ULTI_BLOCO  VARCHAR2(80);&#xa;  TABELA      VARCHAR2(80);&#xa;  I_TP_EVENTO LOGUSUARIO.TP_EVENTO%TYPE;&#xa;  I_DS_EVENTO LOGUSUARIO.DS_EVENTO%TYPE;&#xa;  I_REGISTRO  LOGUSUARIO.DS_EVENTO%TYPE;&#xa;  I_INSTRUCAO LOGUSUARIO.DS_DML%TYPE; --Armazena a instru&#xe7;&#xe3;o de delete completa&#xa;  I_CHAVE     LOGUSUARIO.DS_DML%TYPE; --Armazena e &#xe9; zerada com os atributos chave&#xa;  I_CONTADOR  NUMBER;&#xa;BEGIN&#xa;  --DHG:22411:Incluida verifica&#xe7;&#xe3;o para que sempre volte para o bloco origem ap&#xf3;s terminar a verifica&#xe7;&#xe3;o&#xa;  :GLOBAL.MD_BLOCO := :SYSTEM.CURSOR_BLOCK;&#xa;  I_REGISTRO  := NULL;&#xa;  I_DS_EVENTO := NULL;&#xa;  I_TP_EVENTO := NULL;&#xa;  TABELA      := GET_BLOCK_PROPERTY(:SYSTEM.CURSOR_BLOCK,DML_DATA_TARGET_NAME);&#xa;  PRIM_ITEM   := GET_BLOCK_PROPERTY(:SYSTEM.CURSOR_BLOCK,FIRST_ITEM);&#xa;  ULTI_ITEM   := GET_BLOCK_PROPERTY(:SYSTEM.CURSOR_BLOCK,LAST_ITEM);&#xa;  I_CONTADOR  := 0;&#xa;  I_CHAVE     := NULL;&#xa;  LOOP&#xa;    --GDG:05/01/2010:32828 Adicionada verifica&#xe7;&#xe3;o para gravar auditoria dos campos sublinhados(por padr&#xe3;o, s&#xe3;o campos obrigat&#xf3;rios)&#xa;    IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,REQUIRED) = &apos;TRUE&apos; OR&#xa;       GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,PROMPT_FONT_STYLE) = &apos;UNDERLINE&apos; THEN&#xa;      I_TP_EVENTO := &apos;E&apos;;&#xa;      I_REGISTRO  := I_REGISTRO||&apos; &apos;||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,PROMPT_TEXT)||&apos; &apos;||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;      I_DS_EVENTO := (&apos;Excluiu o registro &apos; || I_REGISTRO || &apos; da tabela &apos; || TABELA);&#xa;    END IF;&#xa;    IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;      IF I_CONTADOR = 0 THEN&#xa;        IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;          I_CHAVE := GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,ITEM_NAME)||&apos; = &apos;||&#xa;                    CHR(39)||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;        ELSE&#xa;          I_CHAVE := GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,ITEM_NAME)||&apos; = &apos;||&#xa;                    GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;        END IF;&#xa;      ELSIF I_CONTADOR &gt;= 1 THEN&#xa;        IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;          I_CHAVE := I_CHAVE||&apos; AND &apos;||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,ITEM_NAME)||&apos; = &apos;||&#xa;                    CHR(39)||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;        ELSE&#xa;          I_CHAVE := I_CHAVE||&apos; AND &apos;||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,ITEM_NAME)||&apos; = &apos;||&#xa;                    GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,DATABASE_VALUE);&#xa;        END IF;&#xa;      END IF;&#xa;      I_INSTRUCAO := &apos;DELETE FROM &apos;||TABELA||&apos; WHERE &apos;||I_CHAVE;&#xa;      I_CONTADOR  := I_CONTADOR + 1;&#xa;    END IF;&#xa;    &#xa;    EXIT WHEN :SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM = :SYSTEM.CURSOR_BLOCK||&apos;.&apos;||ULTI_ITEM;&#xa;    PRIM_ITEM := GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||&apos;.&apos;||PRIM_ITEM,NEXTITEM);&#xa;  END LOOP;&#xa;  &#xa;  --DHG:22411:Incluida verifica&#xe7;&#xe3;o para que sempre volte para o bloco origem ap&#xf3;s terminar a verifica&#xe7;&#xe3;o&#xa;  GO_BLOCK(:GLOBAL.MD_BLOCO);&#xa;      &#xa;  IF I_INSTRUCAO IS NOT NULL THEN&#xa;    I_INSTRUCAO := I_INSTRUCAO||&apos;;&apos;;&#xa;  END IF;&#xa;  &#xa;  BEGIN&#xa;    INSERT INTO LOGUSUARIO (CD_EMPRESA,CD_USUARIO,CD_MODULO,CD_PROGRAMA,&#xa;                            DT_EVENTO,SQ_EVENTO,HR_EVENTO,DS_EVENTO,TP_EVENTO,DS_DML)&#xa;             VALUES (:GLOBAL.CD_EMPRESA,:GLOBAL.CD_USUARIO,:GLOBAL.CD_MODULO,&#xa;                     :GLOBAL.CD_PROGRAMA,RETORNA_DATAHORA,SEQ_AUDITORIA.NEXTVAL,&#xa;                     TO_CHAR(RETORNA_DATAHORA,&apos;HH24:MI:SS&apos;),I_DS_EVENTO,I_TP_EVENTO,I_INSTRUCAO);&#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      DEBUG_PROGRAMA(&apos;AUDITA_EXCLUSAO - Erro durante tentativa de inser&#xe7;&#xe3;o na tabela LOGUSUARIO: &apos;||SQLERRM);&#xa;  END;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="AUDITORIA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE AUDITORIA(&#xa;V_TP_EVENTO IN LOGUSUARIO.TP_EVENTO%TYPE,&#xa;V_DS_EVENTO IN LOGUSUARIO.DS_EVENTO%TYPE) IS&#xa;BEGIN  &#xa;   INSERT INTO LOGUSUARIO(CD_EMPRESA,&#xa;                          CD_USUARIO, &#xa;                          CD_MODULO,&#xa;                          CD_PROGRAMA,&#xa;                          DT_EVENTO, &#xa;                          TP_EVENTO, &#xa;                          DS_EVENTO,&#xa;                          SQ_EVENTO,&#xa;                          HR_EVENTO)&#xa;     VALUES            (:GLOBAL.CD_EMPRESA,&#xa;                        :GLOBAL.CD_USUARIO,&#xa;                        :GLOBAL.CD_MODULO,&#xa;                        :GLOBAL.CD_PROGRAMA,&#xa;                        SYSDATE,&#xa;                        V_TP_EVENTO,&#xa;                        V_DS_EVENTO,&#xa;                        SEQ_AUDITORIA.NEXTVAL,&#xa;                        TO_CHAR(SYSDATE,&apos;HH24:MI&apos;));&#xa;   &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="CRIA_RECORDGROUP">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE CRIA_RECORDGROUP(  NM_GRUPO IN VARCHAR2,V_INSTRUCAO  IN VARCHAR2,V_ERRO OUT NUMBER) IS&#xa;  V_GRUPO             RECORDGROUP;&#xa;BEGIN&#xa;&#xa;  V_GRUPO :=  FIND_GROUP(NM_GRUPO);&#xa;  IF NOT ID_NULL(V_GRUPO) THEN&#xa;    DELETE_GROUP(V_GRUPO);&#xa;  END IF;  &#xa;  V_GRUPO:= CREATE_GROUP_FROM_QUERY(NM_GRUPO,V_INSTRUCAO); &#xa;  V_ERRO := POPULATE_GROUP(V_GRUPO);&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="VERIFICA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE VERIFICA(&#xa;V_CD_CENTROCUSTO IN ITEMCOMPRACCUSTO.CD_CENTROCUSTO%TYPE,&#xa;EXISTE OUT BOOLEAN)  IS&#xa;BEGIN&#xa;   EXISTE := FALSE;&#xa;   FIRST_RECORD;&#xa;   WHILE :SYSTEM.LAST_RECORD = &apos;FALSE&apos; LOOP&#xa;      IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO = V_CD_CENTROCUSTO THEN&#xa;         EXISTE := TRUE;&#xa;      END IF;&#xa;   END LOOP;   &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="CENTRALIZA_FORM">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE CENTRALIZA_FORM(NM_FORMPRINCIPAL IN VARCHAR2, NM_FORMFILHO IN VARCHAR2) IS&#xa;  V_WIDTH_PRINCIPAL   NUMBER;&#xa;  V_HEIGHT_PRINCIPAL NUMBER;&#xa;  V_WIDTH_LAYOUT     NUMBER;&#xa;  V_HEIGHT_LAYOUT    NUMBER;&#xa;  V_X_POS             NUMBER;&#xa;  V_Y_POS             NUMBER;&#xa;&#xa;BEGIN&#xa;  V_WIDTH_PRINCIPAL  := GET_WINDOW_PROPERTY(NM_FORMPRINCIPAL,WIDTH);&#xa;  V_HEIGHT_PRINCIPAL := GET_WINDOW_PROPERTY(NM_FORMPRINCIPAL,HEIGHT);&#xa;  &#xa;  V_WIDTH_LAYOUT     := GET_WINDOW_PROPERTY(NM_FORMFILHO,WIDTH);&#xa;  V_HEIGHT_LAYOUT    := GET_WINDOW_PROPERTY(NM_FORMFILHO,HEIGHT);&#xa;  &#xa;  V_X_POS := (V_WIDTH_PRINCIPAL  - V_WIDTH_LAYOUT)  / 2;&#xa;  V_Y_POS := (V_HEIGHT_PRINCIPAL - V_HEIGHT_LAYOUT) / 2;&#xa;  &#xa;  SET_WINDOW_PROPERTY(NM_FORMFILHO,X_POS,V_X_POS);&#xa;  SET_WINDOW_PROPERTY(NM_FORMFILHO,Y_POS,V_Y_POS);&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="VALIDA_ERROS">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE VALIDA_ERROS IS&#xa;  TIPO_ERRO   VARCHAR2(03)    := ERROR_TYPE;&#xa;  CODIGO_ERRO NUMBER          := ERROR_CODE;&#xa;  DBMSERRCODE NUMBER          := DBMS_ERROR_CODE;&#xa;  DBMSERRTEXT VARCHAR2(32000) := DBMS_ERROR_TEXT;&#xa;  V_DS_PROMPT  VARCHAR2(200);&#xa;  V_MASCARA    VARCHAR2(30);&#xa;  V_DS_ITEM    VARCHAR2(30);&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  E_GERAL      EXCEPTION;&#xa;&#xa;BEGIN&#xa;  /**&#xa;   * &#xda;ltima altera&#xe7;&#xe3;o : 14/11/2008&#xa;   * Programador      : RBS - Rubens Sertage&#xa;   * Modifica&#xe7;&#xe3;o      : Trata a mensagem de erro quando a sess&#xe3;o do usu&#xe1;rio expirar.&#xa;   */&#xa;   /** RBS:SOL20158:14/11/2008&#xa;   *  Trata a mensagem de erro quando a sess&#xe3;o do usu&#xe1;rio expirar.&#xa;   *  Mostra a mensagem apenas uma vez. Deve estar no come&#xe7;o do c&#xf3;digo.&#xa;   *  Se for necess&#xe1;rio colocar algum procedimento anterior a este,&#xa;   *  o procedimento n&#xe3;o deve fazer consulta ao banco. Vai funcionar &#xa;   *   normalmente da outra maneira, mas se a sess&#xe3;o expirar os erros n&#xe3;o &#xa;   *  ser&#xe3;o tratados.&#xa;   */&#xa;  IF (DBMSERRCODE IN (-1012,-28)) THEN &#xa;    --Verifica se a mensagem j&#xe1; foi mostrada.&#xa;    IF (:GLOBAL.ST_SESSAO_EXPIRADA = &apos;N&apos;) THEN&#xa;      MESSAGE(&apos;A sua sess&#xe3;o expirou, a aplica&#xe7;&#xe3;o deve ser reiniciada!&apos;);&#xa;      MESSAGE(&apos; &apos;);&#xa;      :GLOBAL.ST_SESSAO_EXPIRADA := &apos;S&apos;;&#xa;    END IF;&#xa;  ELSE&#xa;    /** EDU:03/04/2007&#xa;     * Adicionado apenas para verificar o que passa nas vari&#xe1;veis,&#xa;     * para facilitar uma futura altera&#xe7;&#xe3;o.&#xa;     */&#xa;    DEBUG_PROGRAMA(:SYSTEM.CURRENT_FORM||&apos;.&apos;||&apos;VALIDA_ERROS : ERROR_TYPE: &apos;||TIPO_ERRO||&apos; - ERROR_CODE: &apos;||CODIGO_ERRO);&#xa;    DEBUG_PROGRAMA(:SYSTEM.CURRENT_FORM||&apos;.&apos;||&apos;VALIDA_ERROS : DBMS_ERROR_CODE: &apos;||DBMSERRCODE||&apos; - DBMS_ERROR_TEXT: &apos;||DBMSERRTEXT);&#xa;    &#xa;    IF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41803) THEN&#xa;      --N&#xe3;o h&#xe1; registro anterior a partir do qual copiar valor&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40209) THEN&#xa;      --O campo deve ser da tela FM999G999G999D000.&#xa;      IF (:SYSTEM.TRIGGER_ITEM IS NOT NULL) THEN&#xa;        V_DS_ITEM   := :SYSTEM.TRIGGER_ITEM;&#xa;        V_DS_PROMPT  := GET_ITEM_PROPERTY(V_DS_ITEM,PROMPT_TEXT);&#xa;        V_MASCARA   := GET_ITEM_PROPERTY(V_DS_ITEM,FORMAT_MASK);&#xa;        V_MENSAGEM := &apos;O Campo &apos;||V_DS_PROMPT||&apos; deve estar no Formato &apos;||V_MASCARA||&apos;. Favor Verifique!&apos;||:system.record_status;&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 42100) THEN&#xa;      --N&#xe3;o foram encontrados erros recentemente&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41003) THEN&#xa;      --Esta fun&#xe7;&#xe3;o n&#xe3;o pode ser executada aqui&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40815) THEN&#xa;      --A vari&#xe1;vel %s n&#xe3;o existe&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40222) THEN&#xa;      --Item desativado %s falhou na valida&#xe7;&#xe3;o&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40738) THEN&#xa;      --Argumento 1 para incorporar GO_BLOCK n&#xe3;o pode ser nulo&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41058) THEN&#xa;      --Esta propriedade n&#xe3;o existe para GET_ITEM_PROPERTY&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40104) THEN&#xa;      --No such block %s&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41045) THEN&#xa;      --N&#xe3;o &#xe9; poss&#xed;vel localizar o item : ID inv&#xe1;lido&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41332) THEN&#xa;      --List element index out of range&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40401) THEN&#xa;      --N&#xe3;o h&#xe1; altera&#xe7;&#xf5;es a salvar&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40105) THEN&#xa;      --N&#xe3;o foi poss&#xed;vel decompor refer&#xea;ncia ao item ..&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41830) THEN&#xa;      IF ( :SYSTEM.CURSOR_ITEM = &apos;ITEMCOMPRA.CD_MOVIMENTACAO&apos; ) THEN&#xa;        BELL;&#xa;        MESSAGE(&apos;Nenhuma Movimenta&#xe7;&#xe3;o cadastrada com o para a Empresa e o Item Selecionados &apos;);&#xa;      ELSE&#xa;        MESSAGE (ERROR_TYPE||&apos;-&apos;||ERROR_CODE||&apos; &apos;||ERROR_TEXT);  &#xa;      END IF;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 41009) THEN&#xa;      --Tecla de fun&#xe7;&#xe3;o n&#xe3;o permitida&#xa;      NULL;&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40510) THEN&#xa;      IF INSTR(DBMSERRTEXT,&apos;ORA-02292&apos;,1) &gt; 0 THEN&#xa;        BELL;&#xa;        MESSAGE(&apos;N&#xe3;o foi possivel deletar o registro, registro filho localizado.&apos;);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;      ELSE&#xa;        BELL;&#xa;        MESSAGE(&apos;N&#xe3;o foi possivel deletar o registro.&apos;);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;       END IF;&#xa;    /**JMS:26/12/2006:13363&#xa;     * COLOCADO ESTE IF AQUI PARA QUE SE CASO VIER ALGUMA MSG DA PACK_ERRO.LEVANTA_ERRO&#xa;     * ELE ESTOURE A MENSAGEM Q ELA ESTOUROU N&#xc3;O A MSG COM O ORA-20999&#xa;     * QUEM DESENVOLVEU O &quot;IF&quot; FOI O &quot;EDU&quot; EU SOH COLOQUEI NO MODELO2 POR O EDU ESTAVA&#xa;     * DE F&#xc9;RIAS&#xa;     */&#xa;    /** EDU:03/04/2007:13363&#xa;     * Foi removida a verifica&#xe7;&#xe3;o da condi&#xe7;&#xe3;o do DBMS_ERROR_CODE.&#xa;     * Por hora, vai ficar assim, que &#xe9; mais garantido, mas pode acontecer casos&#xa;     * que n&#xe3;o deve passar por aqui, ent&#xe3;o ser&#xe1; necess&#xe1;rio alterar esta condi&#xe7;&#xe3;o.&#xa;     * Deixei assim justamente porque n&#xe3;o sei quais s&#xe3;o estes casos ainda.&#xa;     * O DEBUG_PROGRAMA no in&#xed;cio do procedimento foi colocado para verificar&#xa;     * o que est&#xe1; passando nas vari&#xe1;veis para facilitar a altera&#xe7;&#xe3;o.&#xa;     */&#xa;    ELSIF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO = 40735) AND (DBMSERRTEXT IS NOT NULL) THEN&#xa;      /**JMS:11/05/2007:15981&#xa;       * MODIFICAO PARA CONCATENAR O ERROR_TEXT PARA QUE MESMO QUE ESTOURE 1403&#xa;       * NO DBMSERRTEXT ELE VAI ESTOURAR O ERRO CORRETO QUE OCORREU DENTRO &#xa;       * DE ALGUM GATILHO DENTRO DO FORMS MESMO, DAE &#xc9; POSSIVEL&#xa;       * VER DENTRO DO BOT&#xc3;O DETALHES DA MENSAGEM.&#xa;       */&#xa;      MENSAGEM(&apos;Erro&apos;,DBMSERRTEXT||&apos; - &apos;||ERROR_TEXT,1);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    ELSE&#xa;      MESSAGE(ERROR_TYPE||&apos;-&apos;||ERROR_CODE||&apos; &apos;||ERROR_TEXT);&#xa;      /** EDU:05/10/2007&#xa;       * Adicionado a verifica&#xe7;&#xe3;o de acordo com o erro para dar um RAISE, pois assim,&#xa;       * conseguimos tratar para no momento de gravar um bloco de banco, n&#xe3;o ficar&#xa;       * dando a mensagem v&#xe1;rias vezes.&#xa;       * Fiquei na d&#xfa;vida se neste ELSE eu deixava o RAISE direto ou colocava uma condi&#xe7;&#xe3;o.&#xa;       * Optei por colocar a condi&#xe7;&#xe3;o, assim posso evitar de dar problemas generalizados.&#xa;       */&#xa;      IF (TIPO_ERRO = &apos;FRM&apos;) AND (CODIGO_ERRO IN (40202, 40102)) THEN&#xa;        -- 40202 - O campo deve ser informado.&#xa;        -- 40102 - O registro deve ser informado ou exclu&#xed;do primeiro.&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;      END IF;&#xa;    END IF;&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    IF NOT (PACK_PROCEDIMENTOS.V_MSG) THEN&#xa;      MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,4);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;      PACK_PROCEDIMENTOS.V_MSG := TRUE;&#xa;    END IF;&#xa;    &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="PACK_GLOBAL">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PACKAGE PACK_GLOBAL IS&#xa;&#xa;  TP_PEDIDO        TIPOPEDIDO.CD_TIPOPEDIDO%TYPE;&#xa;  ST_APROVSOLIC    VARCHAR2(1);&#xa;  TP_ITEM          VARCHAR2(1);&#xa;  QT_PREVISTA      NUMBER;&#xa;  TP_SELECAOCONTA  PARMRECEB.TP_SELECAOCONTA%TYPE;&#xa;  TP_APROVSOLIC    VARCHAR2(1);&#xa;  ST_VALIDACCUSTO  VARCHAR2(1);&#xa;  VALIDA_QUANTIDADE  BOOLEAN := TRUE;&#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="PACK_TELA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PACKAGE BODY PACK_TELA IS&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE VALIDA_OBRIGATORIO(I_NM_BLOCO IN VARCHAR2,&#xa;                               O_MENSAGEM IN OUT VARCHAR2) IS&#xa;  &#xa;    V_TP_BLOCO         NUMBER;&#xa;    V_BL_VALIDA        BOOLEAN := TRUE;&#xa;    V_ITEMINI           VARCHAR2(61); -- Item Inicial&#xa;    V_ITEM             VARCHAR2(61); -- Item Atual&#xa;    V_NR_REGISTRO      NUMBER;&#xa;    V_NR_REGISTROMSG   NUMBER;&#xa;    V_ITEMMSG          VARCHAR2(61);&#xa;    V_MENSAGEM         VARCHAR2(2000);&#xa;    E_GERAL            EXCEPTION;&#xa;  &#xa;  BEGIN&#xa;    &#xa;    V_TP_BLOCO := GET_BLOCK_PROPERTY(FIND_BLOCK(I_NM_BLOCO),RECORDS_DISPLAYED);&#xa;    -- Deleta registros em branco quando o bloco for do tipo Grid --&#xa;    IF (V_TP_BLOCO &lt;&gt; 1) THEN&#xa;      GO_BLOCK(I_NM_BLOCO);&#xa;      LOOP&#xa;        &#xa;        V_ITEMINI := GET_BLOCK_PROPERTY(I_NM_BLOCO, FIRST_ITEM) ;&#xa;        V_ITEM    := I_NM_BLOCO || &apos;.&apos; || V_ITEMINI ;&#xa;        &#xa;        -- Para cada item&#xa;        WHILE V_ITEMINI IS NOT NULL LOOP&#xa;          -- Verifica se o Item &#xe9; visivel --&#xa;          IF (GET_ITEM_PROPERTY(V_ITEM, VISIBLE) = &apos;TRUE&apos;) AND (GET_ITEM_PROPERTY(V_ITEM, ITEM_CANVAS) IS NOT NULL) THEN&#xa;            -- Verifica se o Item pode ser manipulado pelo usu&#xe1;rio --&#xa;            IF GET_ITEM_PROPERTY(V_ITEM, ITEM_TYPE) NOT IN (&apos;DISPLAY ITEM&apos;,&apos;BUTTON&apos;,&apos;OLE OBJECT&apos;) THEN&#xa;              -- Verifica se o Item est&#xe1; preenchido&#xa;              IF NAME_IN(V_ITEM) IS NOT NULL AND (GET_ITEM_PROPERTY(V_ITEM, ENABLED) = &apos;TRUE&apos;) THEN&#xa;                V_BL_VALIDA := FALSE;&#xa;              END IF;      &#xa;            END IF;&#xa;          END IF;&#xa;          &#xa;          -- Pr&#xf3;ximo item --&#xa;          V_ITEMINI   := NULL;&#xa;          V_ITEMINI   := GET_ITEM_PROPERTY(V_ITEM, NEXTITEM);&#xa;          V_ITEM      := I_NM_BLOCO || &apos;.&apos; || V_ITEMINI;&#xa;        END LOOP;&#xa;        &#xa;        IF V_BL_VALIDA THEN&#xa;          DELETE_RECORD;&#xa;          FIRST_RECORD;&#xa;        END IF;&#xa;        &#xa;        IF (:SYSTEM.LAST_RECORD = &apos;TRUE&apos; AND V_BL_VALIDA) THEN&#xa;          DELETE_RECORD;&#xa;          EXIT;&#xa;        END IF;&#xa;  &#xa;        EXIT WHEN (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;);&#xa;        V_BL_VALIDA := TRUE;&#xa;        NEXT_RECORD;&#xa;      END LOOP;&#xa;      CLEAR_MESSAGE;&#xa;      FIRST_RECORD;&#xa;    END IF;&#xa;    &#xa;    -- Apenas valida bloco informado, se a variavel de mensagem estiver nula, &#xa;    -- indicando que as valida&#xe7;&#xf5;es de bloco anteriores n&#xe3;o tiveram erro nenhum.&#xa;    IF O_MENSAGEM IS NULL THEN&#xa;      GO_BLOCK(I_NM_BLOCO);&#xa;      FIRST_RECORD;&#xa;      LOOP&#xa;        &#xa;        V_NR_REGISTRO := :SYSTEM.CURSOR_RECORD;&#xa;        V_ITEMINI := GET_BLOCK_PROPERTY(I_NM_BLOCO, FIRST_ITEM) ;&#xa;        V_ITEM    := I_NM_BLOCO || &apos;.&apos; || V_ITEMINI ;&#xa;        &#xa;        -- Para cada item&#xa;        WHILE V_ITEMINI IS NOT NULL LOOP&#xa;          -- Verifica se o Item &#xe9; visivel --&#xa;          IF (GET_ITEM_PROPERTY(V_ITEM, VISIBLE) = &apos;TRUE&apos;) AND (GET_ITEM_PROPERTY(V_ITEM, ITEM_CANVAS) IS NOT NULL) THEN&#xa;            -- Verifica se o Item pode ser manipulado pelo usu&#xe1;rio --&#xa;            IF (GET_ITEM_PROPERTY(V_ITEM, ITEM_TYPE) NOT IN (&apos;DISPLAY ITEM&apos;,&apos;BUTTON&apos;,&apos;OLE OBJECT&apos;)) THEN&#xa;              -- Verifica se o Item &#xe9; obrigat&#xf3;rio (UNDERLINE) e est&#xe1; preenchido&#xa;              IF (GET_ITEM_PROPERTY(V_ITEM, PROMPT_FONT_STYLE) = &apos;UNDERLINE&apos; AND NAME_IN(V_ITEM) IS NULL AND GET_ITEM_PROPERTY(V_ITEM, ENABLED) = &apos;TRUE&apos;) THEN&#xa;                IF (V_NR_REGISTROMSG IS NULL AND V_ITEMMSG IS NULL) THEN&#xa;                  V_NR_REGISTROMSG := V_NR_REGISTRO;&#xa;                  V_ITEMMSG        := V_ITEM;&#xa;                END IF;&#xa;                V_MENSAGEM := V_MENSAGEM||PACK_MENSAGEM.MENS_PADRAO(1710,&apos;&#xa2;DS_VARIAVEL=&apos;||GET_ITEM_PROPERTY(V_ITEM, PROMPT_TEXT)||&apos;&#xa2;&apos;)||&apos;&#xa7;&apos;; --&#xc9; Obrigat&#xf3;rio Informar o Campo &#xa2;DS_VARIAVEL&#xa2;.;&#xa;              END IF;      &#xa;            END IF;&#xa;          END IF;&#xa;          &#xa;          -- Pr&#xf3;ximo item --&#xa;          V_ITEMINI   := NULL;&#xa;          V_ITEMINI   := GET_ITEM_PROPERTY(V_ITEM, NEXTITEM);&#xa;          V_ITEM      := I_NM_BLOCO || &apos;.&apos; || V_ITEMINI;&#xa;        END LOOP;&#xa;        &#xa;        IF V_MENSAGEM IS NOT NULL THEN&#xa;          GO_RECORD(V_NR_REGISTROMSG);&#xa;          GO_ITEM(V_ITEMMSG);&#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;        &#xa;        EXIT WHEN (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;);&#xa;        NEXT_RECORD;&#xa;      END LOOP;&#xa;      FIRST_RECORD;&#xa;    END IF;&#xa;    &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      O_MENSAGEM := V_MENSAGEM;&#xa;    WHEN OTHERS THEN&#xa;      -- RRW:05/08/2011:32921: Padroniza&#xe7;&#xe3;o.&#xa;      /*Erro ao validar campos obrigat&#xf3;rios. Erro: &#xa2;SQLERRM&#xa2;.&#xa5;Local: &#xa2;DS_LOCAL&#xa2;*/&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8034, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;DS_LOCAL=N&#xc3;O INFORMADO&#xa2;&apos;);&#xa;      --O_MENSAGEM := SQLERRM;&#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE HABILITA_ITEM(V_DS_ITEM VARCHAR2,V_NR_REGISTRO NUMBER DEFAULT NULL) IS&#xa;  BEGIN&#xa;    IF V_NR_REGISTRO IS NULL THEN&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,UPDATE_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,NAVIGABLE,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,VISUAL_ATTRIBUTE,&apos;&apos;);&#xa;    ELSE&#xa;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,UPDATE_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,NAVIGABLE,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,VISUAL_ATTRIBUTE,&apos;&apos;);&#xa;    END IF;&#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE DESABILITA_ITEM(V_DS_ITEM VARCHAR2,V_NR_REGISTRO NUMBER DEFAULT NULL) IS&#xa;  BEGIN&#xa;    IF V_NR_REGISTRO IS NULL THEN&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,UPDATE_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,NAVIGABLE,PROPERTY_FALSE);&#xa;      IF GET_ITEM_PROPERTY(V_DS_ITEM,ITEM_TYPE) NOT IN (&apos;RADIO GROUP&apos;,&apos;CHECKBOX&apos;,&apos;LIST&apos;) THEN&#xa;        SET_ITEM_PROPERTY(V_DS_ITEM,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;      END IF;&#xa;    ELSE&#xa;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,UPDATE_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,NAVIGABLE,PROPERTY_FALSE);&#xa;      IF GET_ITEM_PROPERTY(V_DS_ITEM,ITEM_TYPE) NOT IN (&apos;RADIO GROUP&apos;,&apos;CHECKBOX&apos;,&apos;LIST&apos;) THEN&#xa;        SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;      END IF;&#xa;    END IF;&#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE MOSTRA_ITEM(V_DS_ITEM VARCHAR2) IS&#xa;  BEGIN&#xa;    IF GET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE) = &apos;FALSE&apos; THEN&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM||&apos;__F&apos;,VISIBLE,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,ENABLED,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,NAVIGABLE,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,UPDATE_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;    END IF;&#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE OCULTA_ITEM(V_DS_ITEM VARCHAR2) IS&#xa;  BEGIN&#xa;    IF GET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE) = &apos;TRUE&apos; THEN&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM||&apos;__F&apos;,VISIBLE,PROPERTY_FALSE);&#xa;      SET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE,PROPERTY_FALSE);&#xa;    END IF;&#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="PACK_TELA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PACKAGE PACK_TELA IS&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  /* DHG:20/07/2010:21411&#xa;   * Cria&#xe7;&#xe3;o de um procedimento padr&#xe3;o que valida preenchimento de campos obrigat&#xf3;rios.&#xa;   * Para ser considerado campo obrigat&#xf3;rio, o programa deve estar padronizado para tal,&#xa;   * ou seja, para campos obrigat&#xf3;rios, o prompt do item deve estar sublinhado, indicando&#xa;   * a obrigatoriedade.&#xa;   * Utiliza&#xe7;&#xe3;o: antes de efetuar inclus&#xf5;es ou altera&#xe7;&#xf5;es.&#xa;   * EX.: Utilizado no KEY-COMMIT:&#xa;     -- Quando validamos apenas um bloco.&#xa;     VALIDA_OBRIGATORIO(&apos;NOME_DO_BLOCO&apos;,V_MENSAGEM);&#xa;     IF V_MENSAGEM IS NOT NULL THEN&#xa;       RAISE E_GERAL; -- RAISE FORM_TRIGGER_FAILURE;&#xa;     END IF;&#xa;     &#xa;     -- Quando queremos validar varios blocos na sequencia&#xa;     VALIDA_OBRIGATORIO(&apos;NOME_DO_BLOCO_1&apos;,V_MENSAGEM);&#xa;     VALIDA_OBRIGATORIO(&apos;NOME_DO_BLOCO_2&apos;,V_MENSAGEM);&#xa;     VALIDA_OBRIGATORIO(&apos;NOME_DO_BLOCO_N&apos;,V_MENSAGEM);&#xa;     IF V_MENSAGEM IS NOT NULL THEN&#xa;       RAISE E_GERAL; -- RAISE FORM_TRIGGER_FAILURE;&#xa;     END IF;&#xa;   */&#xa;  PROCEDURE VALIDA_OBRIGATORIO(I_NM_BLOCO IN VARCHAR2, O_MENSAGEM IN OUT VARCHAR2);&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  /* DHG:20/07/2010:21411&#xa;   * Procedimento utilizado para habilitar as propriedades INSERT, UPDATE e NAVIGABLE do item informado&#xa;   */&#xa;  PROCEDURE HABILITA_ITEM(V_DS_ITEM VARCHAR2, V_NR_REGISTRO NUMBER DEFAULT NULL);&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  /* DHG:20/07/2010:21411&#xa;   * Procedimento utilizado para desabilitar as propriedades INSERT, UPDATE e NAVIGABLE do item informado&#xa;   */&#xa;  PROCEDURE DESABILITA_ITEM(V_DS_ITEM VARCHAR2, V_NR_REGISTRO NUMBER DEFAULT NULL);&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  /* DHG:20/07/2010:21411&#xa;   * Procedimento utilizado para mostrar o item informado. Seta propriedade VISIBLE e depend&#xea;ncias.&#xa;   * Padr&#xe3;o de utiliza&#xe7;&#xe3;o: para poder usar este recurso, &#xe9; preciso ter um item do mesmo tipo criado&#xa;                           antes do item que ir&#xe1; ser exibido ao usu&#xe1;rio. Este item, obrigatoriamente&#xa;                           deve ser o PREVIOUS_ITEM no n&#xed;vel de bloco para o item a ser ocultado e possuir&#xa;                           o mesmo nome do item com a adi&#xe7;&#xe3;o dos caracteres: &quot;__F&quot;. &#xa;   * Motivo do padr&#xe3;o &quot;__F&quot;: esses itens n&#xe3;o ser&#xe3;o armazenados no dicionario de dados para internacionaliza&#xe7;&#xe3;o.&#xa;   * EX: Item de Fundo/Sombra do tipo TEXT_ITEM: CD_EMPRESA__F. Propriedade ATIVADO deve estar N&#xc3;O!&#xa;         Item para o usu&#xe1;rio do tipo TEXT_ITEM: CD_EMPRESA.&#xa;         &#xa;         Item de Fundo/Sombra do tipo DISPLAY_ITEM: NM_EMPRESA__F.&#xa;         Item para o usu&#xe1;rio do tipo DISPLAY_ITEM: NM_EMPRESA.&#xa;     Obs: LIST_BOX, BUTTON e CHECK_BOX n&#xe3;o necessitam de fundo, por&#xe9;m caso seja preciso, utilizar DISPLAY_ITEM. &#xa;   */&#xa;  PROCEDURE MOSTRA_ITEM(V_DS_ITEM VARCHAR2);&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  /* DHG:20/07/2010:21411&#xa;   * Procedimento utilizado para mostrar o item informado. Seta propriedade VISIBLE e depend&#xea;ncias.&#xa;   * Padr&#xe3;o de utiliza&#xe7;&#xe3;o: para poder usar este recurso, &#xe9; preciso ter um item do mesmo tipo criado&#xa;                           antes do item que ir&#xe1; ser exibido ao usu&#xe1;rio. Este item, obrigatoriamente&#xa;                           deve ser o PREVIOUS_ITEM no n&#xed;vel de bloco para o item a ser ocultado e possuir&#xa;                           o mesmo nome do item com a adi&#xe7;&#xe3;o dos caracteres: &quot;__F&quot;.&#xa;   * Motivo do padr&#xe3;o &quot;__F&quot;: esses itens n&#xe3;o ser&#xe3;o armazenados no dicionario de dados para internacionaliza&#xe7;&#xe3;o.&#xa;   * EX: Item de Fundo/Sombra do tipo TEXT_ITEM: CD_EMPRESA__F. Propriedade ATIVADO deve estar N&#xc3;O!&#xa;         Item para o usu&#xe1;rio do tipo TEXT_ITEM: CD_EMPRESA.&#xa;         &#xa;         Item de Fundo/Sombra do tipo DISPLAY_ITEM: NM_EMPRESA__F.&#xa;         Item para o usu&#xe1;rio do tipo DISPLAY_ITEM: NM_EMPRESA.&#xa;     Obs: LIST_BOX, BUTTON e CHECK_BOX n&#xe3;o necessitam de fundo, por&#xe9;m caso seja preciso, utilizar DISPLAY_ITEM. &#xa;   */&#xa;  PROCEDURE OCULTA_ITEM(V_DS_ITEM VARCHAR2);&#xa;  ------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="VALIDA_MOVIMENTACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE VALIDA_MOVIMENTACAO (V_MENSAGEM OUT VARCHAR2) IS&#xa;  V_CD_CONTACONTABIL     HISTCONTB.CD_CONTACONTABIL%TYPE;&#xa;  E_GERAL                EXCEPTION;&#xa;  V_DS_MOVIMENTACAO      VARCHAR2(60);  &#xa;&#xa;BEGIN&#xa;  &#xa;  /** WLV:13/08/2012:41514&#xa;    * Padroniza&#xe7;&#xe3;o de mensagens.&#xa;    */   &#xa;  &#xa;  /* RBM: 21356: 25/03/2009&#xa;   * Tratamento de consultas abaixo.&#xa;   */       &#xa;  IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN&#xa;    BEGIN&#xa;      SELECT PARMOVIMENT.DS_MOVIMENTACAO &#xa;        INTO V_DS_MOVIMENTACAO &#xa;        FROM PARMOVIMENT&#xa;       WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        V_DS_MOVIMENTACAO := NULL;&#xa;        --V_MENSAGEM := &apos;C&#xf3;digo de Movimenta&#xe7;&#xe3;o n&#xe3;o Cadastrado&apos;;&#xa;        --A Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; n&#xe3;o est&#xe1; cadastrada. Verifique o programa TCB008.&#xa;        V_MENSAGEM :=PACK_MENSAGEM.MENS_PADRAO(46, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN TOO_MANY_ROWS THEN&#xa;         V_DS_MOVIMENTACAO := NULL;&#xa;        --V_MENSAGEM := &apos;C&#xf3;digo de movimenta&#xe7;&#xe3;o encontrado em duplicidade.&apos;;&#xa;        --A Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; est&#xe1; cadastrada v&#xe1;rias vezes. Verifique TCB008.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(47, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN&#xa;         V_DS_MOVIMENTACAO := NULL;&#xa;        --V_MENSAGEM := &apos;Erro ao consultar descri&#xe7;&#xe3;o da movimenta&#xe7;&#xe3;o - &apos;||SQLERRM;&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(48, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;    &#xa;    /** WLV:13/08/2012:41514&#xa;      * Comentado NEGOCIO do from e da clausula WHERE o N.CD_NEGOCIO = ITEMCONTANEG.CD_NEGOCIO&#xa;      * pois estava retornando TOO_MANY_ROWS mesmo com os NEGOCIOS diferentes.&#xa;      */   &#xa;    BEGIN &#xa;      /*CSL:30/12/2013:64869*/&#xa;      IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;        SELECT HISTCONTB.CD_CONTACONTABIL&#xa;          INTO V_CD_CONTACONTABIL&#xa;          FROM PARMOVIMENT,HISTCONTB,ITEMCONTANEG,PLANOCONTABIL&#xa;         WHERE HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#xa;           AND PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;           AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#xa;           AND ITEMCONTANEG.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#xa;           AND ITEMCONTANEG.CD_ITEM           = :ITEMCOMPRA.CD_ITEM   &#xa;           AND ITEMCONTANEG.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA&#xa;           AND ITEMCONTANEG.ST_SITUACAO       = &apos;A&apos;&#xa;           AND ITEMCONTANEG.CD_NEGOCIO        = (SELECT MIN(I.CD_NEGOCIO) &#xa;                                                    FROM /*NEGOCIO N,*/ ITEMCONTANEG I &#xa;                                                   WHERE /*N.CD_NEGOCIO     = ITEMCONTANEG.CD_NEGOCIO&#xa;                                                     AND */I.CD_ITEM        = ITEMCONTANEG.CD_ITEM&#xa;                                                     AND I.CD_EMPRESA       = ITEMCONTANEG.CD_EMPRESA&#xa;                                                     AND I.ST_SITUACAO       = &apos;A&apos;&#xa;                                                     AND I.CD_CONTACONTABIL = ITEMCONTANEG.CD_CONTACONTABIL); &#xa;      ELSE&#xa;        SELECT HISTCONTB.CD_CONTACONTABIL&#xa;          INTO V_CD_CONTACONTABIL&#xa;          FROM PARMOVIMENT, HISTCONTB, ITEMCONTANEG, PLANOCONTABILVERSAO&#xa;         WHERE HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#xa;           AND PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;           AND PLANOCONTABILVERSAO.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#xa;           AND ITEMCONTANEG.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#xa;           AND ITEMCONTANEG.CD_ITEM           = :ITEMCOMPRA.CD_ITEM   &#xa;           AND ITEMCONTANEG.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA&#xa;           AND ITEMCONTANEG.ST_SITUACAO       = &apos;A&apos;&#xa;           AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE))&#xa;           AND ITEMCONTANEG.CD_NEGOCIO        = (SELECT MIN(I.CD_NEGOCIO) &#xa;                                                   FROM ITEMCONTANEG I &#xa;                                                  WHERE I.CD_ITEM          = ITEMCONTANEG.CD_ITEM&#xa;                                                    AND I.CD_EMPRESA       = ITEMCONTANEG.CD_EMPRESA&#xa;                                                    AND I.ST_SITUACAO      = &apos;A&apos;&#xa;                                                    AND I.CD_CONTACONTABIL = ITEMCONTANEG.CD_CONTACONTABIL);   &#xa;      END IF;      &#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --Conta Cont&#xe1;bil n&#xe3;o associada ao item &#xa2;CD_ITEM&#xa2;, na empresa &#xa2;CD_EMPRESA&#xa2; e movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2;. Verifique os programas TCB008 e TIT001.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7955, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN TOO_MANY_ROWS THEN&#xa;         V_DS_MOVIMENTACAO := NULL;&#xa;        --Conta Cont&#xe1;bil associada v&#xe1;rias vezes ao item &#xa2;CD_ITEM&#xa2;, na empresa &#xa2;CD_EMPRESA&#xa2; e movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7956, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN&#xa;         V_DS_MOVIMENTACAO := NULL;&#xa;        --Erro ao pesquisar conta cont&#xe1;bil &#xa2;CD_CONTACONTABIL&#xa2;. Erro &#xa2;SQLERRM&#xa2;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(144, &apos;&#xa2;CD_CONTACONTABIL=&apos;||V_CD_CONTACONTABIL||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END; &#xa;  ELSE&#xa;    V_DS_MOVIMENTACAO := NULL;&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="VALIDA_SOLICITACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PROCEDURE VALIDA_SOLICITACAO IS  &#xa;BEGIN&#xa;  IF :ITEMCOMPRA.CD_EMPRESA IS NULL THEN&#xa;      mensagem(&apos;Maxys&apos;,&apos;Informe o c&#xf3;digo da empresa&apos;,2);&#xa;      GO_ITEM(&apos;ITEMCOMPRA.CD_EMPRESA&apos;);&#xa;      --RAISE E_GERAL;         &#xa;  END IF;     &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779075" FOLDED="true" MODIFIED="1607991779075" TEXT="PACK_GRUPO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="body">
<node CREATED="1607991779075" MODIFIED="1607991779075" TEXT="PACKAGE PACK_GRUPO IS&#xa;  --CENTRO CUSTO&#xa;  PROCEDURE CRIA_GRUPO_CC;&#xa;  PROCEDURE ADICIONA_GRUPO_CC(I_CD_EMPRCCUSTODEST IN NUMBER,&#xa;                              I_CD_ITEM            IN NUMBER,&#xa;                              I_CD_CENTROCUSTO    IN NUMBER,&#xa;                              I_CD_MOVIMENTACAO   IN NUMBER,&#xa;                              I_CD_AUTORIZADOR    IN VARCHAR2,&#xa;                              I_QT_PEDIDAUNIDSOL  IN NUMBER,&#xa;                               I_PC_PARTICIPACAO   IN NUMBER,&#xa;                               I_CD_NEGOCIO        IN NUMBER,&#xa;                               I_DS_OBSERVACAO     IN VARCHAR2,&#xa;                               I_CD_CONTAORCAMENTO IN NUMBER);&#xa;                              &#xa;  PROCEDURE DELETA_GRUPO_CC  (I_CD_ITEM    IN NUMBER);&#xa;  PROCEDURE CARREGA_DADOS_CC (I_CD_ITEM    IN NUMBER);&#xa;  &#xa;&#xa;  --LOVS DO CENTRO DE CUSTO&#xa;  PROCEDURE CRIA_GRUPO_LOVCC;&#xa;  PROCEDURE ADICIONA_GRUPO_LOVCC(I_CD_ITEM     IN NUMBER,&#xa;                                  I_CD_CENTROCUSTO  IN NUMBER,&#xa;                                 I_PC_PARTICIPACAO IN NUMBER);&#xa;  PROCEDURE DELETA_GRUPO_LOVCC;&#xa;&#xa;  --PROCEDURE CARREGA_DADOS_NG (I_CD_ITEM    IN NUMBER);  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779076" FOLDED="true" MODIFIED="1607991779076" TEXT="PACK_GRUPO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="body">
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="PACKAGE BODY PACK_GRUPO IS&#xa;-----------------------------------------------------------------------------&#xa;-----------------------------------------------------------------------------&#xa;                             -- CENTRO CUSTO --&#xa;-----------------------------------------------------------------------------&#xa;-----------------------------------------------------------------------------&#xa;  PROCEDURE CRIA_GRUPO_CC IS&#xa;    GRP_REPLICA RECORDGROUP;&#xa;    COL_REPLICA GROUPCOLUMN;&#xa;  BEGIN&#xa;    GRP_REPLICA := FIND_GROUP(&apos;GRUPO_CC&apos;);&#xa;    IF NOT ID_NULL(GRP_REPLICA) THEN &#xa;      DELETE_GROUP(GRP_REPLICA); &#xa;    END IF;&#xa;    &#xa;    GRP_REPLICA := CREATE_GROUP(&apos;GRUPO_CC&apos;);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;CD_ITEM&apos;          , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;CD_CENTROCUSTO&apos;   , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;CD_NEGOCIO&apos;       , NUMBER_COLUMN);/*CSL:21/12/2010:30317*/&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;CD_MOVIMENTACAO&apos;  , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;CD_AUTORIZADOR&apos;   , CHAR_COLUMN,4);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;QT_PEDIDAUNIDSOL&apos; , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;PC_PARTICIPACAO&apos;  , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;CD_EMPRCCUSTODEST&apos;, NUMBER_COLUMN);--GDG:22/07/2011:28715&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;DS_OBSERVACAO&apos;    , CHAR_COLUMN,150);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_CC&apos;, &apos;CD_CONTAORCAMENTO&apos;, NUMBER_COLUMN);&#xa;    &#xa;  END CRIA_GRUPO_CC;&#xa;  ---------------------------------------------------------------------------------------------&#xa;  &#xa;  PROCEDURE ADICIONA_GRUPO_CC(I_CD_EMPRCCUSTODEST IN NUMBER,&#xa;                              I_CD_ITEM            IN NUMBER,&#xa;                              I_CD_CENTROCUSTO    IN NUMBER,&#xa;                              I_CD_MOVIMENTACAO   IN NUMBER,&#xa;                              I_CD_AUTORIZADOR    IN VARCHAR2,&#xa;                              I_QT_PEDIDAUNIDSOL  IN NUMBER,&#xa;                               I_PC_PARTICIPACAO   IN NUMBER,&#xa;                               I_CD_NEGOCIO        IN NUMBER/*CSL:21/12/2010:30317*/,&#xa;                               I_DS_OBSERVACAO     IN VARCHAR2,&#xa;                               I_CD_CONTAORCAMENTO IN NUMBER) IS&#xa;  BEGIN&#xa;    ADD_GROUP_ROW(&apos;GRUPO_CC&apos;,END_OF_GROUP);&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_EMPRCCUSTODEST&apos;, GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_CD_EMPRCCUSTODEST);--GDG:22/07/2011:28715&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_ITEM&apos;          , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_CD_ITEM         );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_CENTROCUSTO&apos;   , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_CD_CENTROCUSTO  );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_NEGOCIO&apos;       , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_CD_NEGOCIO      );/*CSL:21/12/2010:30317*/&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_MOVIMENTACAO&apos;  , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_CD_MOVIMENTACAO );&#xa;    SET_GROUP_CHAR_CELL  (&apos;GRUPO_CC.CD_AUTORIZADOR&apos;   , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_CD_AUTORIZADOR  );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.QT_PEDIDAUNIDSOL&apos; , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_QT_PEDIDAUNIDSOL);&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.PC_PARTICIPACAO&apos;  , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_PC_PARTICIPACAO );&#xa;    SET_GROUP_CHAR_CELL  (&apos;GRUPO_CC.DS_OBSERVACAO&apos;    , GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_DS_OBSERVACAO   );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_CONTAORCAMENTO&apos;, GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;), I_CD_CONTAORCAMENTO);&#xa;    &#xa;  END ADICIONA_GRUPO_CC;&#xa;  ---------------------------------------------------------------------------------------------&#xa;  PROCEDURE DELETA_GRUPO_CC( I_CD_ITEM IN NUMBER ) IS&#xa;    NR_REG NUMBER;&#xa;    NR_TOT NUMBER;&#xa;  BEGIN&#xa;    &#xa;    LOOP&#xa;      NR_TOT := GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;);&#xa;      NR_REG := 0;&#xa;      FOR I IN 1 ..GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;) LOOP&#xa;        NR_REG := NR_REG + 1;&#xa;        IF GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_ITEM&apos;, I) = I_CD_ITEM THEN&#xa;          DELETE_GROUP_ROW(&apos;GRUPO_CC&apos;, I);&#xa;          EXIT;&#xa;        END IF;&#xa;      END LOOP;&#xa;      EXIT WHEN NR_TOT = NR_REG;&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;  END DELETA_GRUPO_CC;&#xa;  &#xa;  ---------------------------------------------------------------------------------------------&#xa;  PROCEDURE CARREGA_DADOS_CC (I_CD_ITEM IN NUMBER) IS&#xa;  I_EXISTE   BOOLEAN;&#xa;  BEGIN  &#xa;    I_EXISTE := FALSE;&#xa;    GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    FIRST_RECORD;    &#xa;    IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN /*ATR:80785:11/02/2015*/&#xa;      FOR I IN 1..GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;) LOOP&#xa;        IF NVL(GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;),0) &gt; 0 THEN&#xa;          IF I_CD_ITEM = GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_ITEM&apos;, I) THEN&#xa;            :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_EMPRCCUSTODEST&apos;, I);&#xa;            :ITEMCOMPRACCUSTO.CD_ITEM           := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_ITEM&apos;           , I);&#xa;            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO    := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_CENTROCUSTO&apos;   , I);&#xa;            :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_MOVIMENTACAO&apos;  , I);&#xa;            :ITEMCOMPRACCUSTO.CD_AUTORIZADOR    := GET_GROUP_CHAR_CELL  (&apos;GRUPO_CC.CD_AUTORIZADOR&apos;   , I);  &#xa;            :ITEMCOMPRACCUSTO.PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.PC_PARTICIPACAO&apos;  , I);&#xa;            :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.QT_PEDIDAUNIDSOL&apos; , I);            &#xa;            :ITEMCOMPRACCUSTO.CD_NEGOCIO        := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_NEGOCIO&apos;       , I);&#xa;            :ITEMCOMPRACCUSTO.DS_OBSERVACAO     := GET_GROUP_CHAR_CELL  (&apos;GRUPO_CC.DS_OBSERVACAO&apos;    , I);&#xa;            I_EXISTE := TRUE;&#xa;            NEXT_RECORD;&#xa;          END IF;&#xa;        END IF;&#xa;      END LOOP;&#xa;      FIRST_RECORD;&#xa;    ELSE --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN  /*ATR:80785:11/02/2015*/&#xa;      FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#xa;        IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT &gt; 0 THEN&#xa;          IF :ITEMCOMPRA.CD_EMPRESA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRESA AND&#xa;            :ITEMCOMPRA.NR_ITEMCOMPRA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).NR_ITEMCOMPRA THEN    &#xa;            :ITEMCOMPRACCUSTO.CD_ITEM             :=   PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_ITEM;    &#xa;            :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRCCUSTODEST;                      &#xa;            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO      :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_CENTROCUSTO;         &#xa;            :ITEMCOMPRACCUSTO.CD_NEGOCIO          :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_NEGOCIO;                &#xa;            :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_MOVIMENTACAO;          &#xa;            :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).QT_PEDIDAUNIDSOL;     &#xa;            :ITEMCOMPRACCUSTO.PC_PARTICIPACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).PC_PARTICIPACAO;&#xa;            I_EXISTE := TRUE;    &#xa;            NEXT_RECORD;&#xa;          END IF;&#xa;        END IF; --IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT &gt; 0 THEN&#xa;      END LOOP; --FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#xa;      FIRST_RECORD;&#xa;    END IF; --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN   &#xa;    IF NOT I_EXISTE THEN&#xa;      IF  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#xa;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO :=  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#xa;        GO_ITEM(&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;);&#xa;      END IF;&#xa;     ELSE&#xa;      GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_CENTROCUSTO&apos;);&#xa;    END IF;  &#xa;  END;&#xa;  &#xa;  -----------------------------------------------------------------------------&#xa;  -----------------------------------------------------------------------------&#xa;                               -- L O V CENTRO CUSTO --&#xa;  -----------------------------------------------------------------------------&#xa;  -----------------------------------------------------------------------------&#xa;  PROCEDURE CRIA_GRUPO_LOVCC IS&#xa;    GRP_REPLICA RECORDGROUP;&#xa;    COL_REPLICA GROUPCOLUMN;&#xa;  BEGIN&#xa;    GRP_REPLICA := FIND_GROUP(&apos;GRUPO_LOVCC&apos;);&#xa;    IF NOT ID_NULL(GRP_REPLICA) THEN DELETE_GROUP(GRP_REPLICA); END IF;&#xa;    GRP_REPLICA := CREATE_GROUP(&apos;GRUPO_LOVCC&apos;);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_LOVCC&apos;, &apos;CD_ITEM&apos;        , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_LOVCC&apos;, &apos;CD_CENTROCUSTO&apos;, CHAR_COLUMN, 2000);&#xa;  END CRIA_GRUPO_LOVCC;&#xa;  ---------------------------------------------------------------------------------------------&#xa;  PROCEDURE ADICIONA_GRUPO_LOVCC(I_CD_ITEM          IN NUMBER,&#xa;                                 I_CD_CENTROCUSTO   IN NUMBER,&#xa;                                  I_PC_PARTICIPACAO  IN NUMBER) IS&#xa;  V_CD_CENTROCUSTO VARCHAR2(2000);&#xa;  V_EXISTE         NUMBER;&#xa;  V_GRUPO          NUMBER;&#xa;  BEGIN&#xa;    V_CD_CENTROCUSTO := NULL;&#xa;    V_EXISTE         := 0;&#xa;    -- VERIFICA SE A CONTA ESTA NO RECORD GROUP --&#xa;    FOR I IN 1 ..GET_GROUP_ROW_COUNT(&apos;GRUPO_LOVCC&apos;) LOOP&#xa;      IF NVL(GET_GROUP_ROW_COUNT(&apos;GRUPO_LOVCC&apos;),0) &gt; 0 THEN&#xa;        IF GET_GROUP_NUMBER_CELL(&apos;GRUPO_LOVCC.CD_ITEM&apos; ,I) = I_CD_ITEM THEN&#xa;          V_CD_CENTROCUSTO := V_CD_CENTROCUSTO||&apos;, &apos;||GET_GROUP_CHAR_CELL(&apos;GRUPO_LOVCC.CD_CENTROCUSTO&apos;, I);&#xa;          V_GRUPO  := I;&#xa;          V_EXISTE := 1;&#xa;        END IF;&#xa;      END IF;&#xa;    END LOOP;&#xa;    IF V_EXISTE = 0 THEN&#xa;      ADD_GROUP_ROW(&apos;GRUPO_LOVCC&apos;,END_OF_GROUP);&#xa;      SET_GROUP_NUMBER_CELL(&apos;GRUPO_LOVCC.CD_ITEM&apos;     , GET_GROUP_ROW_COUNT(&apos;GRUPO_LOVCC&apos;), I_CD_ITEM);&#xa;      SET_GROUP_CHAR_CELL(&apos;GRUPO_LOVCC.CD_CENTROCUSTO&apos;, GET_GROUP_ROW_COUNT(&apos;GRUPO_LOVCC&apos;), I_CD_CENTROCUSTO||&apos; x &apos;||I_PC_PARTICIPACAO||&apos;%&apos;) ;&#xa;    ELSIF V_EXISTE = 1 THEN&#xa;      SET_GROUP_CHAR_CELL(&apos;GRUPO_LOVCC.CD_CENTROCUSTO&apos;, V_GRUPO, SUBSTR(V_CD_CENTROCUSTO,3,LENGTH(V_CD_CENTROCUSTO))||&apos;, &apos;||&#xa;                                                                 I_CD_CENTROCUSTO||&apos; x &apos;||I_PC_PARTICIPACAO||&apos;%&apos;);&#xa;    END IF;&#xa;  END ADICIONA_GRUPO_LOVCC;&#xa;  ---------------------------------------------------------------------------------------------&#xa;  PROCEDURE DELETA_GRUPO_LOVCC IS&#xa;  BEGIN&#xa;    DELETE_GROUP(&apos;GRUPO_LOVCC&apos;);&#xa;    PACK_GRUPO.CRIA_GRUPO_LOVCC;&#xa;  END DELETA_GRUPO_LOVCC;&#xa;&#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779076" FOLDED="true" MODIFIED="1607991779076" TEXT="ADICIONA_GRUPO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="body">
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="PROCEDURE ADICIONA_GRUPO IS&#xa;BEGIN      &#xa;  --Adiciona novas linhas no grupo com os dados do bloco e nr_registro = :GLOBAL.NR_REGISTRO&#xa;  GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;  FIRST_RECORD;&#xa;  --Deleta o quem tem no grupo com nr_registro = :GLOBAL.NR_REGISTRO&#xa;  PACK_GRUPO.DELETA_GRUPO_CC(:ITEMCOMPRACCUSTO.CD_ITEM);&#xa;  FIRST_RECORD;&#xa;  LOOP&#xa;    IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN        &#xa;      PACK_GRUPO.ADICIONA_GRUPO_CC(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,--GDG:22/07/2011:28715&#xa;                                   :ITEMCOMPRACCUSTO.CD_ITEM,&#xa;                                   :ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#xa;                                   :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#xa;                                   :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,&#xa;                                   :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL,&#xa;                                    :ITEMCOMPRACCUSTO.PC_PARTICIPACAO,&#xa;                                    :ITEMCOMPRACCUSTO.CD_NEGOCIO,&#xa;                                    :ITEMCOMPRACCUSTO.DS_OBSERVACAO,&#xa;                                    :ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO);&#xa;    END IF;&#xa;    EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;    NEXT_RECORD;  &#xa;  END LOOP;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779076" FOLDED="true" MODIFIED="1607991779076" TEXT="PACK_PROCEDIMENTOS">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="body">
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="PACKAGE PACK_PROCEDIMENTOS IS &#xa;  &#xa;  V_MSG  BOOLEAN := FALSE;&#xa;  &#xa;  V_VT_PROJETORATEIO     PACK_PROJETOMONI.REG_PROJETORATEIO;  &#xa;  NR_REGBLOCO           NUMBER;&#xa;  &#xa;  TYPE TB_ITENS IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;&#xa;  T_ITENS   TB_ITENS;&#xa;  &#xa;  TYPE TB_STRING IS TABLE OF VARCHAR2(32000) INDEX BY BINARY_INTEGER;&#xa;  T_ERROS   TB_STRING;&#xa;  &#xa;  V_VERIFICA_CHAMADA_RCO6  BOOLEAN := FALSE;&#xa;  V_DUPLICADO   BOOLEAN := FALSE; /*ATR:80785:11/02/2015*/&#xa;  V_CCUSTO      BOOLEAN := FALSE; &#xa;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE MOSTRA_ULTIMAS_COMPRAS;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE SOLICITACAO_DEVOLVIDA;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  FUNCTION RETORNA_TP_PEDIDO RETURN VARCHAR2;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  FUNCTION PERMITE_COMPRA(I_QT_ESTOQUEMAX  IN NUMBER,&#xa;                          I_QT_SALDO      IN NUMBER,&#xa;                          I_QT_ESTOQUE    IN NUMBER,&#xa;                          I_QT_PEDIDA      IN NUMBER) RETURN BOOLEAN;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE CARREGA_ITEMCOMPRA(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                               I_NR_LOTECOMPRA  IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,&#xa;                               O_MENSAGEM       OUT VARCHAR2);&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE CARREGA_ITEMCOMPRACCUSTO(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                                     I_NR_ITEMCOMPRA  IN ITEMCOMPRA.NR_ITEMCOMPRA%TYPE);&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE CARREGA_LOTE;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------  &#xa;  TYPE R_ITEMCOMPRA IS RECORD(NR_ITEMCOMPRA   ITEMCOMPRA.NR_ITEMCOMPRA%TYPE,&#xa;                              CD_EMPRESA      ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                              CD_ITEM           ITEMCOMPRA.CD_ITEM%TYPE,&#xa;                              CD_MOVIMENTACAO  ITEMCOMPRA.CD_MOVIMENTACAO%TYPE,&#xa;                              QT_PREVISTA      ITEMCOMPRA.QT_PREVISTA%TYPE&#xa;                              );&#xa;  &#xa;  TYPE T_ITEMCOMPRA IS TABLE OF R_ITEMCOMPRA INDEX BY BINARY_INTEGER;&#xa;  &#xa;  VET_ITEMCOMPRA T_ITEMCOMPRA;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------  &#xa;  TYPE R_ITEMCOMPRACCUSTO IS RECORD(NR_ITEMCOMPRA      ITEMCOMPRACCUSTO.NR_ITEMCOMPRA%TYPE,&#xa;                                    CD_EMPRESA        ITEMCOMPRACCUSTO.CD_EMPRESA%TYPE,&#xa;                                    CD_ITEM            ITEMCOMPRA.CD_ITEM%TYPE,&#xa;                                    CD_EMPRCCUSTODEST  ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST%TYPE,&#xa;                                    CD_CENTROCUSTO    ITEMCOMPRACCUSTO.CD_CENTROCUSTO%TYPE,   &#xa;                                    CD_NEGOCIO        ITEMCOMPRACCUSTO.CD_NEGOCIO%TYPE,&#xa;                                    CD_MOVIMENTACAO   ITEMCOMPRACCUSTO.CD_MOVIMENTACAO%TYPE,   &#xa;                                    QT_PEDIDAUNIDSOL  ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL%TYPE,&#xa;                                    PC_PARTICIPACAO    ITEMCOMPRACCUSTO.PC_PARTICIPACAO%TYPE&#xa;                                    );   &#xa;  &#xa;  TYPE T_ITEMCOMPRACCUSTO IS TABLE OF R_ITEMCOMPRACCUSTO INDEX BY BINARY_INTEGER;&#xa;  &#xa;  VET_ITEMCOMPRACCUSTO   T_ITEMCOMPRACCUSTO;&#xa;  VET_ITEMCOMPRANEGOCIO  T_ITEMCOMPRACCUSTO;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------  &#xa;  PROCEDURE CARREGA_PEDIDOINTERNO_EMV078;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------  &#xa;  /* ASF:25/03/2019:132689 */  &#xa;   PROCEDURE CARREGA_ITENSSOLICCOMPRA_TMP;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------  &#xa;  /* ASF:17/06/2019:134714 */ &#xa;  ST_VALIDA_ANOSAFRA BOOLEAN DEFAULT FALSE;&#xa;   &#xa;   PROCEDURE VALIDA_ANOSAFRA(O_MENSAGEM OUT VARCHAR2);&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  /*ASF:08/07/2019:134720*/&#xa;  PROCEDURE SALVA_ANEXO(O_MENSAGEM OUT VARCHAR2); &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  /*ASF:09/07/2019:134720*/&#xa;  TYPE TDSARQUIVOS IS RECORD(&#xa;      CD_EMPRESA    NUMBER,&#xa;      NR_ITEMCOMPRA NUMBER,&#xa;      DS_ARQUIVO    VARCHAR2(32000));&#xa;      &#xa;  TYPE T_DSARQUIVOS IS TABLE OF TDSARQUIVOS INDEX BY BINARY_INTEGER;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ARQUIVOS T_DSARQUIVOS;  &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE GRAVA_ARQUIVOS_VETOR(V_CD_EMPRESA    IN NUMBER,&#xa;                                 V_NR_ITEMCOMPRA IN NUMBER, &#xa;                                 V_DS_ARQUIVO    IN VARCHAR2,&#xa;                                 O_MENSAGEM     OUT VARCHAR2);  &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  FUNCTION EXISTE_ARQUIVOS(V_CD_EMPRESA    IN NUMBER,&#xa;                           V_NR_ITEMCOMPRA IN NUMBER) RETURN BOOLEAN;  &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE VALIDA_AUTORIZADOR(I_MENSAGEM OUT VARCHAR2);&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE VALIDA_LOCALARMAZ(V_MENSAGEM OUT VARCHAR2); &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE CONSULTA_NM_LOCALARMAZENAGEM;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779076" FOLDED="true" MODIFIED="1607991779076" TEXT="PACK_PROCEDIMENTOS">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="body">
<node CREATED="1607991779076" MODIFIED="1607991779076" TEXT="PACKAGE BODY PACK_PROCEDIMENTOS IS&#xa;  PROCEDURE MOSTRA_ULTIMAS_COMPRAS IS&#xa;    I_QT_PEDEXIBIR  PARMCOMPRA.QT_PEDEXIBIR%TYPE;&#xa;    I_MENSAGEM      VARCHAR2(2000);&#xa;    E_GERAL         EXCEPTION;&#xa;      &#xa;  BEGIN&#xa;    IF :ITEMCOMPRA.CD_ITEM IS NULL THEN&#xa;      --Informe o item para visualizar as &#xfa;ltimas compras!&#xa;      I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4678,&apos;&apos;);&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;    &#xa;    SELECT QT_PEDEXIBIR &#xa;      INTO I_QT_PEDEXIBIR&#xa;      FROM PARMCOMPRA&#xa;     WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#xa;    &#xa;    DECLARE&#xa;      CURSOR CUR_ULTIMASCOMPRAS IS&#xa;      SELECT CD_CLIFOR, &#xa;             NM_CLIFOR, &#xa;             NR_NFFORNEC, &#xa;             DT_EMISSAO,&#xa;             PS_ATENDIDO, &#xa;             QT_ATENDIDA, &#xa;             VL_UNITITEM, &#xa;             VL_TOTITEM,PC_IPI&#xa;        FROM VIEW_ULTIMASCOMPRAS&#xa;       WHERE CD_EMPRESA  = :GLOBAL.CD_EMPRESA&#xa;         AND CD_ITEM     = :ITEMCOMPRA.CD_ITEM&#xa;       ORDER BY TRUNC(DT_EMISSAO) DESC, NM_CLIFOR;&#xa;  &#xa;      BEGIN&#xa;        GO_BLOCK(&apos;ULTIMASCOMPRAS&apos;);&#xa;        SET_BLOCK_PROPERTY(&apos;ULTIMASCOMPRAS&apos;,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;        CLEAR_BLOCK(NO_VALIDATE);&#xa;        FOR I IN CUR_ULTIMASCOMPRAS LOOP&#xa;          :ULTIMASCOMPRAS.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#xa;          :ULTIMASCOMPRAS.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#xa;          :ULTIMASCOMPRAS.NR_NFEMPR   := I.NR_NFFORNEC;&#xa;          :ULTIMASCOMPRAS.CD_CLIFOR   := I.CD_CLIFOR;&#xa;          :ULTIMASCOMPRAS.NM_CLIFOR   := I.NM_CLIFOR;&#xa;          :ULTIMASCOMPRAS.PS_ATENDIDO := I.PS_ATENDIDO;&#xa;          :ULTIMASCOMPRAS.QT_ATENDIDA := I.QT_ATENDIDA;&#xa;          :ULTIMASCOMPRAS.VL_UNITITEM := I.VL_UNITITEM;&#xa;          :ULTIMASCOMPRAS.VL_TOTITEM  := I.VL_TOTITEM;&#xa;          :ULTIMASCOMPRAS.DT_EMISSAO  := I.DT_EMISSAO;&#xa;          :ULTIMASCOMPRAS.PC_IPI      := I.PC_IPI;&#xa;          NEXT_RECORD;&#xa;        END LOOP;&#xa;        FIRST_RECORD;&#xa;        SET_BLOCK_PROPERTY(&apos;ULTIMASCOMPRAS&apos;,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;    END;&#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      mensagem(&apos;Maxys&apos;,I_MENSAGEM,2);&#xa;    WHEN OTHERS THEN&#xa;      MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;  END MOSTRA_ULTIMAS_COMPRAS;&#xa;  &#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  &#xa;  PROCEDURE SOLICITACAO_DEVOLVIDA IS&#xa;  &#xa;  BEGIN&#xa;     GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;     CLEAR_BLOCK(NO_VALIDATE);&#xa;     &#xa;     --:CONTROLE.DS_OBSCANCEL := NULL;&#xa;  &#xa;     GO_BLOCK(&apos;DEVOLUCAO&apos;);&#xa;     EXECUTE_QUERY;&#xa;  END SOLICITACAO_DEVOLVIDA;&#xa;&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  &#xa;  FUNCTION RETORNA_TP_PEDIDO RETURN VARCHAR2 IS&#xa;    BEGIN&#xa;      RETURN PACK_GLOBAL.TP_PEDIDO;&#xa;    END RETORNA_TP_PEDIDO;&#xa;  &#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  /* MGK:60876:26/07/2013  &#xa;   * Determina se &#xe9; poss&#xed;vel lan&#xe7;ar o item numa compra atrav&#xe9;s da f&#xf3;rmula:&#xa;   *&#xa;   * Estoque atual do item(I_QT_ESTOQUE) + &#xa;   * Solicita&#xe7;&#xf5;es cujo pedido ainda n&#xe3;o foi recebido no REC001(I_QT_SALDO) + &#xa;   * Quantidade pedida na solicita&#xe7;&#xe3;o de compra atual(I_QT_PEDIDA).&#xa;   * &#xa;   * Caso o resultado deste c&#xe1;lculo seja superior &#xe0; quantidade m&#xe1;xima planejada para o item (I_QT_ESTOQUEMAX), n&#xe3;o ser&#xe1; poss&#xed;vel &#xa;   * adicion&#xe1;-lo na solicita&#xe7;&#xe3;o de compra.&#xa;   */&#xa;  FUNCTION PERMITE_COMPRA(I_QT_ESTOQUEMAX  IN NUMBER,&#xa;                          I_QT_SALDO      IN NUMBER,&#xa;                          I_QT_ESTOQUE    IN NUMBER,&#xa;                          I_QT_PEDIDA      IN NUMBER) RETURN BOOLEAN IS&#xa;  &#xa;  V_NOVO_SALDO  NUMBER;&#xa;  &#xa;  BEGIN&#xa;    V_NOVO_SALDO := NVL(I_QT_SALDO,0) + NVL(I_QT_ESTOQUE,0) + NVL(I_QT_PEDIDA,0);&#xa;    &#xa;    IF NVL(V_NOVO_SALDO,0) &gt; NVL(I_QT_ESTOQUEMAX,0) THEN&#xa;      RETURN (FALSE);&#xa;    ELSE&#xa;      RETURN (TRUE);&#xa;    END IF;&#xa;      &#xa;  END;                          &#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  /*ATR:80785:11/02/2015 -- Procedimento criado para carregar os dados da solicita&#xe7;&#xe3;o de&#xa;   *compra para a tela de duplica&#xe7;&#xe3;o de lote*/&#xa;  PROCEDURE CARREGA_ITEMCOMPRA(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                               I_NR_LOTECOMPRA  IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,&#xa;                               O_MENSAGEM       OUT VARCHAR2) IS&#xa;  V_INSTRUCAO       VARCHAR2(1000);&#xa;  E_GERAL            EXCEPTION;&#xa;  V_ERRO            NUMBER;&#xa;  V_MENSAGEM        VARCHAR2(32000);  &#xa;  BEGIN&#xa;    V_INSTRUCAO := &apos;SELECT ITEMCOMPRA.CD_EMPRESA,&#xa;                           ITEMCOMPRA.NR_LOTECOMPRA,&#xa;                           ITEMCOMPRA.NR_ITEMCOMPRA,&#xa;                           ITEMCOMPRA.CD_ITEM,&#xa;                           ITEMCOMPRA.CD_MOVIMENTACAO,&#xa;                           ITEMCOMPRA.QT_PREVISTA&#xa;                      FROM ITEMCOMPRA&#xa;                     WHERE ITEMCOMPRA.CD_EMPRESA = &apos;||I_CD_EMPRESA||&apos;&#xa;                       AND ITEMCOMPRA.NR_LOTECOMPRA = &apos;||I_NR_LOTECOMPRA;  &#xa;                                            &#xa;    CRIA_RECORDGROUP(&apos;GRUPO_ITEMCOMPRA_DUPL&apos;,V_INSTRUCAO,V_ERRO);&#xa;    IF V_ERRO &lt;&gt; 0 THEN&#xa;      IF V_ERRO = 1403 THEN&#xa;        --A consulta n&#xe3;o retornou dados para os par&#xe2;metros informados.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1544,NULL);&#xa;        RAISE E_GERAL;&#xa;      ELSE  &#xa;        --Ocorreu um erro inesperado ao criar o grupo de registros. Erro: &apos;||SQLERRM&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1853,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    END IF; --IF V_ERRO &lt;&gt; 0 THEN&#xa;    &#xa;    GO_BLOCK(&apos;DUPLICAITEMCOMPRACC&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    GO_BLOCK(&apos;DUPLICAITEMCOMPRA&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    &#xa;    FOR I IN 1..GET_GROUP_ROW_COUNT(&apos;GRUPO_ITEMCOMPRA_DUPL&apos;) LOOP&#xa;        :DUPLICAITEMCOMPRA.CD_EMPRESA       := GET_GROUP_NUMBER_CELL(&apos;GRUPO_ITEMCOMPRA_DUPL.CD_EMPRESA&apos;,I);&#xa;        :DUPLICAITEMCOMPRA.NR_LOTECOMPRA   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_ITEMCOMPRA_DUPL.NR_LOTECOMPRA&apos;,I);&#xa;        :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_ITEMCOMPRA_DUPL.NR_ITEMCOMPRA&apos;,I);&#xa;        :DUPLICAITEMCOMPRA.CD_ITEM         := GET_GROUP_NUMBER_CELL(&apos;GRUPO_ITEMCOMPRA_DUPL.CD_ITEM&apos;,I);&#xa;        :DUPLICAITEMCOMPRA.CD_MOVIMENTACAO := GET_GROUP_NUMBER_CELL(&apos;GRUPO_ITEMCOMPRA_DUPL.CD_MOVIMENTACAO&apos;,I);&#xa;        :DUPLICAITEMCOMPRA.QT_PREVISTA     := GET_GROUP_NUMBER_CELL(&apos;GRUPO_ITEMCOMPRA_DUPL.QT_PREVISTA&apos;,I);&#xa;        &#xa;        IF :DUPLICAITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;          :DUPLICAITEMCOMPRA.DS_ITEM := PACK_VALIDATE.RETORNA_DS_ITEM(:DUPLICAITEMCOMPRA.CD_ITEM);&#xa;        END IF;&#xa;        &#xa;        NEXT_RECORD;  &#xa;    END LOOP;&#xa;    FIRST_RECORD;&#xa;&#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      O_MENSAGEM := &apos;CARREGA_ITEMCOMPRA: &apos;||V_MENSAGEM;&#xa;      GO_BLOCK(&apos;DUPLICAITEMCOMPRACC&apos;);&#xa;      CLEAR_BLOCK(NO_VALIDATE);&#xa;      GO_BLOCK(&apos;DUPLICAITEMCOMPRA&apos;);&#xa;      CLEAR_BLOCK(NO_VALIDATE);&#xa;      GO_ITEM(&apos;CONS_ITEMCOMPRA.NR_LOTECOMPRA&apos;);&#xa;    WHEN OTHERS THEN&#xa;      --Ocorreu um erro inesperado ao criar o grupo de registros. Erro &#xa2;SQLERRM&#xa2;.&#xa;      O_MENSAGEM := &apos;CARREGA_ITEMCOMPRA: &apos;||PACK_MENSAGEM.MENS_PADRAO(1853, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;       GO_BLOCK(&apos;DUPLICAITEMCOMPRACC&apos;);&#xa;      CLEAR_BLOCK(NO_VALIDATE);&#xa;      GO_BLOCK(&apos;DUPLICAITEMCOMPRA&apos;);&#xa;      CLEAR_BLOCK(NO_VALIDATE);&#xa;      GO_ITEM(&apos;CONS_ITEMCOMPRA.NR_LOTECOMPRA&apos;);&#xa;  END CARREGA_ITEMCOMPRA;&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  /*ATR:80785:11/02/2015 -- Procedimento criado para carregar os dados de centro de custo&#xa;   *para a tela de duplica&#xe7;&#xe3;o de lote*/&#xa;  PROCEDURE CARREGA_ITEMCOMPRACCUSTO(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                                     I_NR_ITEMCOMPRA  IN ITEMCOMPRA.NR_ITEMCOMPRA%TYPE) IS&#xa;  V_COUNT            NUMBER;&#xa;  &#xa;  CURSOR CUR_ITEMCOMPRACCUSTO IS&#xa;    SELECT ITEMCOMPRACCUSTO.NR_ITEMCOMPRA,&#xa;           ITEMCOMPRACCUSTO.CD_EMPRESA,&#xa;           ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,&#xa;           ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#xa;           ITEMCOMPRACCUSTO.CD_NEGOCIO,&#xa;           ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#xa;           ITEMCOMPRACCUSTO.CD_AUTORIZADOR,&#xa;           ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL,&#xa;           ITEMCOMPRACCUSTO.PC_PARTICIPACAO&#xa;      FROM ITEMCOMPRACCUSTO&#xa;     WHERE ITEMCOMPRACCUSTO.CD_EMPRESA = I_CD_EMPRESA&#xa;       AND ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA;&#xa;    &#xa;  BEGIN&#xa;  BEGIN&#xa;      SELECT COUNT(*)&#xa;        INTO V_COUNT&#xa;        FROM ITEMCOMPRACCUSTO&#xa;       WHERE ITEMCOMPRACCUSTO.CD_EMPRESA = I_CD_EMPRESA&#xa;         AND ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA;&#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN&#xa;        V_COUNT := 0;&#xa;    END;&#xa;    &#xa;    &#xa;    &#xa;    IF V_COUNT &gt; 0 THEN&#xa;      V_CCUSTO := TRUE;&#xa;      GO_BLOCK(&apos;DUPLICAITEMCOMPRACC&apos;);&#xa;      CLEAR_BLOCK(NO_VALIDATE);&#xa;      FIRST_RECORD;&#xa;      FOR I IN CUR_ITEMCOMPRACCUSTO LOOP&#xa;          :DUPLICAITEMCOMPRACC.NR_ITEMCOMPRA     := I.NR_ITEMCOMPRA;  &#xa;          :DUPLICAITEMCOMPRACC.CD_EMPRESA        := I.CD_EMPRESA;         &#xa;          :DUPLICAITEMCOMPRACC.CD_EMPRCCUSTODEST := I.CD_EMPRCCUSTODEST;  &#xa;          :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO    := I.CD_CENTROCUSTO;     &#xa;          :DUPLICAITEMCOMPRACC.CD_NEGOCIO        := I.CD_NEGOCIO;         &#xa;          :DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO   := I.CD_MOVIMENTACAO;    &#xa;          :DUPLICAITEMCOMPRACC.CD_AUTORIZADOR    := I.CD_AUTORIZADOR;     &#xa;          :DUPLICAITEMCOMPRACC.QT_PEDIDAUNIDSOL  := I.QT_PEDIDAUNIDSOL;         &#xa;          :DUPLICAITEMCOMPRACC.PC_PARTICIPACAO   := I.PC_PARTICIPACAO;  &#xa;                  &#xa;          IF :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO IS NOT NULL THEN&#xa;            :DUPLICAITEMCOMPRACC.DS_CENTROCUSTO := PACK_VALIDATE.RETORNA_DS_CENTROCUSTO(:DUPLICAITEMCOMPRACC.CD_CENTROCUSTO);&#xa;          END IF;&#xa;          &#xa;          IF :DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO IS NOT NULL THEN&#xa;            :DUPLICAITEMCOMPRACC.DS_MOVIMENTACAO := PACK_VALIDATE.RETORNA_DS_MOVIMENTACAO(:DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO);&#xa;          END IF;&#xa;          &#xa;          NEXT_RECORD;  &#xa;      END LOOP; --FOR I IN CUR_ITEMCOMPRACCUSTO LOOP&#xa;      FIRST_RECORD;&#xa;    ELSE&#xa;      V_CCUSTO := FALSE;&#xa;      GO_BLOCK(&apos;DUPLICAITEMCOMPRACC&apos;);&#xa;      CLEAR_BLOCK(NO_VALIDATE);&#xa;      GO_BLOCK(&apos;DUPLICAITEMCOMPRA&apos;);  &#xa;    END IF; --IF V_COUNT &gt; 0 THEN&#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      NULL;&#xa;  END CARREGA_ITEMCOMPRACCUSTO;&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  /*ATR:80785:11/02/2015 -- Procedimento criado para carregar os dados do lote de compra &#xa;   *para a tela principal do COM001*/&#xa;  PROCEDURE CARREGA_LOTE IS &#xa;  V_ITEM VARCHAR2(100); &#xa;  BEGIN&#xa;&#xa;    PACK_PROCEDIMENTOS.V_DUPLICADO := TRUE;   &#xa;    &#xa;    PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.DELETE;&#xa;    PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.DELETE;&#xa;    GO_BLOCK(&apos;DUPLICAITEMCOMPRA&apos;);&#xa;    FIRST_RECORD;&#xa;    LOOP&#xa;      V_ITEM := :SYSTEM.CURSOR_ITEM;&#xa;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT + 1).NR_ITEMCOMPRA    := :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA;      &#xa;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).CD_EMPRESA       := :DUPLICAITEMCOMPRA.CD_EMPRESA;        &#xa;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).CD_ITEM          := :DUPLICAITEMCOMPRA.CD_ITEM;      &#xa;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).CD_MOVIMENTACAO := :DUPLICAITEMCOMPRA.CD_MOVIMENTACAO;      &#xa;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).QT_PREVISTA     := :DUPLICAITEMCOMPRA.QT_PREVISTA;        &#xa;       &#xa;       &#xa;      PACK_PROCEDIMENTOS.CARREGA_ITEMCOMPRACCUSTO(:DUPLICAITEMCOMPRA.CD_EMPRESA,&#xa;                                                  :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA);&#xa;       IF V_CCUSTO = TRUE THEN&#xa;         GO_BLOCK(&apos;DUPLICAITEMCOMPRACC&apos;);&#xa;        FIRST_RECORD;&#xa;        LOOP                                    &#xa;          IF :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA = :DUPLICAITEMCOMPRACC.NR_ITEMCOMPRA AND&#xa;            :DUPLICAITEMCOMPRA.CD_EMPRESA = :DUPLICAITEMCOMPRACC.CD_EMPRESA THEN&#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT + 1).NR_ITEMCOMPRA       := :DUPLICAITEMCOMPRACC.NR_ITEMCOMPRA;      &#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_EMPRESA          := :DUPLICAITEMCOMPRACC.CD_EMPRESA;&#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_ITEM             := :DUPLICAITEMCOMPRA.CD_ITEM;        &#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_EMPRCCUSTODEST := :DUPLICAITEMCOMPRACC.CD_EMPRCCUSTODEST;      &#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_CENTROCUSTO    := :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO;      &#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_NEGOCIO          := :DUPLICAITEMCOMPRACC.CD_NEGOCIO;        &#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_MOVIMENTACAO    := :DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO;      &#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).QT_PEDIDAUNIDSOL   := :DUPLICAITEMCOMPRACC.QT_PEDIDAUNIDSOL;    &#xa;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).PC_PARTICIPACAO    := :DUPLICAITEMCOMPRACC.PC_PARTICIPACAO;  &#xa;                        &#xa;            EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;            NEXT_RECORD;&#xa;          END IF;&#xa;        END LOOP; --Loop Bloco DUPLICAITEMCOMPRACC&#xa;        &#xa;        GO_ITEM(V_ITEM);&#xa;        &#xa;       END IF; --IF V_CCUSTO = TRUE THEN&#xa;       &#xa;      EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;      NEXT_RECORD;&#xa;    END LOOP; --Loop Bloco DUPLICAITEMCOMPRA&#xa;    &#xa;    &#xa;    FIRST_RECORD;   &#xa;    GO_BLOCK(&apos;CONTROLE&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);  &#xa;    FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT LOOP&#xa;      IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT &gt; 0 THEN&#xa;         :ITEMCOMPRA.NR_ITEMCOMPRA_AUX   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).NR_ITEMCOMPRA;               &#xa;         :ITEMCOMPRA.CD_EMPRESA_AUX      :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).CD_EMPRESA;                   &#xa;         :ITEMCOMPRA.CD_ITEM             :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).CD_ITEM;                 &#xa;         :ITEMCOMPRA.CD_MOVIMENTACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).CD_MOVIMENTACAO;               &#xa;         :ITEMCOMPRA.QT_PREVISTA        :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).QT_PREVISTA;          &#xa;      END IF;&#xa;      NEXT_RECORD;&#xa;    END LOOP; --FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT LOOP&#xa;    FIRST_RECORD;    &#xa;  /*  GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);  &#xa;    FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#xa;      IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT &gt; 0 THEN&#xa;        :ITEMCOMPRACCUSTO.NR_ITEMCOMPRA       :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).NR_ITEMCOMPRA;      &#xa;        :ITEMCOMPRACCUSTO.CD_EMPRESA          :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRESA;         &#xa;        :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRCCUSTODEST;          &#xa;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO      :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_CENTROCUSTO;         &#xa;        :ITEMCOMPRACCUSTO.CD_NEGOCIO          :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_NEGOCIO;                &#xa;        :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_MOVIMENTACAO;          &#xa;        :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).QT_PEDIDAUNIDSOL;       &#xa;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).PC_PARTICIPACAO;&#xa;        PACK_PROCEDIMENTOS.V_DUPLICADO := TRUE;   &#xa;      END IF;&#xa;      NEXT_RECORD; &#xa;    END LOOP;&#xa;    FIRST_RECORD;    */  &#xa;    &#xa;       &#xa;    GO_ITEM(&apos;CONTROLE.CD_EMPRESA&apos;);&#xa;        &#xa;  END CARREGA_LOTE;&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------AUG:130776:20/02/2019---------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  PROCEDURE CARREGA_PEDIDOINTERNO_EMV078 IS&#xa;    CURSOR CUR_ITEMPEDIDOINTERNO_TMP IS &#xa;      SELECT CD_EMPRPEDINTERNO ,&#xa;             NR_PEDIDOINTERNO  ,&#xa;             CD_ITEM           ,&#xa;             QT_PEDIDA         ,&#xa;             PS_PEDIDO         &#xa;        FROM ITEMPEDIDOINTERNO_TMP;&#xa;&#xa;  BEGIN&#xa;    IF :PARAMETER.CD_MODULO   = &apos;EMV&apos; AND &#xa;       :PARAMETER.CD_PROGRAMA = 78    THEN&#xa;        &#xa;      :CONTROLE.CD_EMPRESA     := :PARAMETER.CD_EMPRCENTRODISTRIB;&#xa;    &#xa;      SET_ITEM_PROPERTY(&apos;CONTROLE.CD_EMPRESA&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;); &#xa;      SET_ITEM_PROPERTY(&apos;CONTROLE.CD_EMPRESA&apos;,INSERT_ALLOWED,PROPERTY_FALSE);  &#xa;      &#xa;      GO_ITEM(&apos;CONTROLE.DT_DESEJADA&apos;);&#xa;      :CONTROLE.DT_DESEJADA    := :PARAMETER.DT_DESEJADA;&#xa;      SET_ITEM_PROPERTY(&apos;CONTROLE.DT_DESEJADA&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;); &#xa;      SET_ITEM_PROPERTY(&apos;CONTROLE.DT_DESEJADA&apos;,INSERT_ALLOWED,PROPERTY_FALSE);  &#xa;        &#xa;      GO_BLOCK(&apos;ITEMCOMPRA&apos;);  &#xa;      FIRST_RECORD;&#xa;        &#xa;      FOR I IN CUR_ITEMPEDIDOINTERNO_TMP LOOP&#xa;        :ITEMCOMPRA.CD_EMPRESA   := :PARAMETER.CD_EMPRCENTRODISTRIB;&#xa;        :ITEMCOMPRA.CD_ITEM       := I.CD_ITEM;&#xa;        :ITEMCOMPRA.QT_PREVISTA := NVL(I.QT_PEDIDA , I.PS_PEDIDO);&#xa;        &#xa;        NEXT_RECORD;&#xa;      END LOOP;&#xa;      FIRST_RECORD;&#xa;      &#xa;      SET_ITEM_PROPERTY(&apos;ITEMCOMPRA.CD_ITEM&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;); &#xa;      SET_ITEM_PROPERTY(&apos;ITEMCOMPRA.CD_ITEM&apos;,INSERT_ALLOWED,PROPERTY_FALSE);  &#xa;      &#xa;      SET_ITEM_PROPERTY(&apos;ITEMCOMPRA.QT_PREVISTA&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;); &#xa;      SET_ITEM_PROPERTY(&apos;ITEMCOMPRA.QT_PREVISTA&apos;,INSERT_ALLOWED,PROPERTY_FALSE);  &#xa;      &#xa;      &#xa;    END IF;    &#xa;  END CARREGA_PEDIDOINTERNO_EMV078;&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  /* ASF:25/03/2019:132689 */  &#xa;    PROCEDURE CARREGA_ITENSSOLICCOMPRA_TMP IS&#xa;      CURSOR CUR_ITENSSOLICCOMPRA_TMP IS&#xa;        SELECT ITENSGERARSOLICCOMPRA_TMP.CD_ITEM,   &#xa;               ITEM.DS_ITEM,      &#xa;               ITENSGERARSOLICCOMPRA_TMP.QT_SOLICITADA&#xa;          FROM ITENSGERARSOLICCOMPRA_TMP, ITEM&#xa;         WHERE ITENSGERARSOLICCOMPRA_TMP.CD_ITEM = ITEM.CD_ITEM;&#xa;    &#xa;    BEGIN&#xa;      &#xa;      IF NVL(:PARAMETER.CD_MODULO,&apos;XXX&apos;) = &apos;RCO&apos; AND NVL(:PARAMETER.CD_PROGRAMA,0) = 6 THEN&#xa;        &#xa;        PACK_PROCEDIMENTOS.V_VERIFICA_CHAMADA_RCO6 := TRUE;&#xa;        &#xa;        GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;        FIRST_RECORD;&#xa;        FOR I IN CUR_ITENSSOLICCOMPRA_TMP LOOP &#xa;          :ITEMCOMPRA.CD_ITEM      := I.CD_ITEM;&#xa;          :ITEMCOMPRA.QT_PREVISTA   := I.QT_SOLICITADA;&#xa;           NEXT_RECORD;&#xa;        END LOOP;&#xa;        FIRST_RECORD;&#xa;        &#xa;        PACK_PROCEDIMENTOS.V_VERIFICA_CHAMADA_RCO6 := FALSE;&#xa;      END IF;  &#xa;    END;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------    &#xa;  /* ASF:17/06/2019:134714 */  &#xa;  PROCEDURE VALIDA_ANOSAFRA(O_MENSAGEM OUT VARCHAR2) IS  &#xa;    V_ST_VALIDA_ANOSAFRA VARCHAR2(1);  &#xa;  BEGIN&#xa;      &#xa;    V_ST_VALIDA_ANOSAFRA := PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;VFT&apos;,4,&apos;MAX&apos;,1,&apos;LST_ANOSAFRA&apos;);&#xa;    &#xa;    IF (NVL(V_ST_VALIDA_ANOSAFRA,&apos;N&apos;) IN (&apos;S&apos;,&apos;I&apos;)) THEN --Par&#xe2;metro &quot;Utilizar cadastro de Ano Safra/Obrigar Informe&quot; - P&#xe1;gina VFT004 do VFT028.&#xa;      IF (:CONTROLE.DT_ANOSAFRA IS NOT NULL) THEN&#xa;        BEGIN&#xa;          SELECT ANOSAFRA.NR_SEQUENCIAL,&#xa;                 ANOSAFRA.DT_ANOSAFRA||&apos; - &apos;||ANOSAFRA.DS_ANOSAFRA&#xa;            INTO :CONTROLE.DT_ANOSAFRA,&#xa;                 :CONTROLE.DS_ANOSAFRA&#xa;            FROM ANOSAFRA&#xa;           WHERE ANOSAFRA.CD_EMPRESA     = NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA)&#xa;             AND ANOSAFRA.NR_SEQUENCIAL = :CONTROLE.DT_ANOSAFRA;&#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            :CONTROLE.DS_ANOSAFRA := NULL;&#xa;            O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20997, &apos;&#xa2;NR_SEQUENCIAL=&apos;||:CONTROLE.DT_ANOSAFRA||&apos;&#xa2;&apos;);&#xa;          WHEN TOO_MANY_ROWS THEN&#xa;            O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20998, &apos;&#xa2;NR_SEQUENCIAL=&apos;||:CONTROLE.DT_ANOSAFRA||&apos;&#xa2;&apos;);&#xa;        END;&#xa;        &#xa;        IF (O_MENSAGEM IS NOT NULL) AND (NOT ST_VALIDA_ANOSAFRA) THEN&#xa;          :CONTROLE.DS_ANOSAFRA := &apos;SEM CADASTRO DE ANO SAFRA.&apos;;&#xa;          ST_VALIDA_ANOSAFRA  := TRUE;&#xa;          O_MENSAGEM := NULL;&#xa;          RETURN;&#xa;        ELSIF (O_MENSAGEM IS NOT NULL) THEN&#xa;          RETURN;&#xa;        END IF;&#xa;&#xa;      ELSE&#xa;        IF (:SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM) THEN&#xa;          :CONTROLE.DS_ANOSAFRA := NULL;&#xa;        END IF;&#xa;      END IF;&#xa;    ELSE&#xa;      IF (:CONTROLE.DT_ANOSAFRA IS NOT NULL) THEN&#xa;        :CONTROLE.DS_ANOSAFRA := &apos;SEM CADASTRO DE ANO SAFRA.&apos;;&#xa;      ELSE&#xa;        :CONTROLE.DS_ANOSAFRA := NULL;&#xa;      END IF;&#xa;    END IF;&#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------  &#xa;    ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------&#xa;  /*ASF:08/07/2019:134720*/&#xa;  PROCEDURE SALVA_ANEXO(O_MENSAGEM OUT VARCHAR2) IS    &#xa;    V_DS_EVENTO    VARCHAR2(32000);&#xa;    V_NM_ARQUIVO   VARCHAR2(32000);&#xa;    V_NM_GRAVACAO  VARCHAR2(32000);&#xa;&#xa;    E_GERAL         EXCEPTION;&#xa;  BEGIN&#xa;&#xa;    GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;    FIRST_RECORD;&#xa;    LOOP  &#xa;      &#xa;      FOR J IN 1..ARQUIVOS.COUNT LOOP&#xa;        IF ARQUIVOS(J).CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA AND ARQUIVOS(J).NR_ITEMCOMPRA = :SYSTEM.CURSOR_RECORD THEN&#xa;          &#xa;          V_NM_GRAVACAO := NEW_SYSGUID()||&apos;\&apos;||ARQUIVOS(J).DS_ARQUIVO;&#xa;          &#xa;          PACK_FILELOADER.UPLOAD_ARQUIVOBD(I_DS_ARQUIVO  =&gt; ARQUIVOS(J).DS_ARQUIVO,&#xa;                                           I_NM_GRAVACAO =&gt; V_NM_GRAVACAO,&#xa;                                           O_MENSAGEM     =&gt; O_MENSAGEM);&#xa;                                                                                                                    &#xa;          IF O_MENSAGEM IS NOT NULL THEN&#xa;            RAISE E_GERAL;&#xa;          END IF;  &#xa;          &#xa;          V_NM_ARQUIVO := PACK_ARQUIVOUTILS.RETORNA_NOMEARQUIVO(ARQUIVOS(J).DS_ARQUIVO);&#xa;          &#xa;          BEGIN &#xa;            INSERT INTO ANEXOITEMCOMPRA&#xa;                   (NR_ITEMCOMPRA,&#xa;                    CD_EMPRESA,&#xa;                    DS_ARQUIVO,&#xa;                    NM_ARQUIVO,&#xa;                    DT_RECORD) &#xa;            VALUES (:ITEMCOMPRA.NR_ITEMCOMPRA,&#xa;                    :ITEMCOMPRA.CD_EMPRESA,&#xa;                    V_NM_GRAVACAO,&#xa;                    V_NM_ARQUIVO,&#xa;                    SYSDATE);       &#xa;          EXCEPTION&#xa;            WHEN DUP_VAL_ON_INDEX THEN&#xa;              --O Anexo &#xa2;V_NM_ARQUIVO&#xa2; j&#xe1; foi inserido nessa solicita&#xe7;&#xe3;o de compra!&#xa;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32684, &apos;&#xa2;V_NM_ARQUIVO=&apos;||V_NM_ARQUIVO||&apos;&#xa2;&apos;);&#xa;              RAISE E_GERAL;                &#xa;            WHEN OTHERS THEN&#xa;               /*Ocorreu o seguinte erro ao inserir na tabela &#xa2;TABELA&#xa2;: &#xa2;SQLERRM&#xa2;*/&#xa;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6980, &apos;&#xa2;TABELA=ANEXOITEMCOMPRA&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;              RAISE E_GERAL;&#xa;          END;          &#xa;          &#xa;          V_DS_EVENTO := &apos;O USUARIO (&apos;||:GLOBAL.CD_USUARIO||&apos;) INSERIU NA TABELA ANEXO DE SOLICITA&#xc7;&#xc3;O DE COMPRA, COM O NR_ITEMCOMPRA &apos;||&#xa;                         &apos;(&apos;||:ITEMCOMPRA.NR_ITEMCOMPRA||&apos;), COM O EMPRESA (&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;).&apos; ;&#xa;      &#xa;          PACK_LOGUSUARIO.AUDITAR_INSERCAO(V_CD_EMPRESA  =&gt; :GLOBAL.CD_EMPRESA,&#xa;                                           V_CD_MODULO   =&gt; :GLOBAL.CD_MODULO,&#xa;                                           V_CD_PROGRAMA =&gt; :GLOBAL.CD_PROGRAMA,&#xa;                                           V_CD_USUARIO  =&gt; :GLOBAL.CD_USUARIO,&#xa;                                           V_DS_EVENTO   =&gt; V_DS_EVENTO,&#xa;                                           V_NM_ENTIDADE =&gt; &apos;ANEXOITEMCOMPRA&apos;,&#xa;                                           V_DS_DML      =&gt; NULL);&#xa;        END IF;  &#xa;      &#xa;      END LOOP;&#xa;&#xa;      EXIT WHEN (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;);&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;    FIRST_RECORD;  &#xa;  &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      NULL;&#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(25697, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;  END SALVA_ANEXO;  &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE GRAVA_ARQUIVOS_VETOR(V_CD_EMPRESA    IN NUMBER,&#xa;                                 V_NR_ITEMCOMPRA IN NUMBER, &#xa;                                 V_DS_ARQUIVO    IN VARCHAR2,&#xa;                                 O_MENSAGEM     OUT VARCHAR2) IS&#xa;    V_NR_ITENS     NUMBER;&#xa;    V_NM_ARQUIVO   VARCHAR2(32000);  &#xa;    &#xa;    E_GERAL         EXCEPTION;                  &#xa;  BEGIN&#xa;    &#xa;    IF V_CD_EMPRESA IS NOT NULL AND V_NR_ITEMCOMPRA IS NOT NULL AND V_DS_ARQUIVO IS NOT NULL THEN&#xa;      V_NM_ARQUIVO := PACK_ARQUIVOUTILS.RETORNA_NOMEARQUIVO(V_DS_ARQUIVO);&#xa;      V_NR_ITENS := 0;&#xa;      -- Verifica se o item adicional, com a chave da combo principal j&#xe1; foi gravado no vetor&#xa;      FOR J IN 1..ARQUIVOS.COUNT LOOP&#xa;        IF ARQUIVOS(J).DS_ARQUIVO = V_DS_ARQUIVO &#xa;          AND ARQUIVOS(J).NR_ITEMCOMPRA = V_NR_ITEMCOMPRA&#xa;          AND ARQUIVOS(J).CD_EMPRESA = V_CD_EMPRESA THEN&#xa;          O_MENSAGEM := &apos;O Anexo (&apos;||V_NM_ARQUIVO||&apos;) j&#xe1; foi inserido&apos;;&#xa;          RAISE E_GERAL;&#xa;        END IF;        &#xa;      END LOOP;&#xa;      V_NR_ITENS := NVL(ARQUIVOS.COUNT,0) + 1;&#xa;      &#xa;      ARQUIVOS(V_NR_ITENS).DS_ARQUIVO    := V_DS_ARQUIVO; &#xa;      ARQUIVOS(V_NR_ITENS).NR_ITEMCOMPRA := V_NR_ITEMCOMPRA;&#xa;      ARQUIVOS(V_NR_ITENS).CD_EMPRESA    := V_CD_EMPRESA;  &#xa;    END IF;   &#xa;  &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      NULL;&#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM := &apos;&#xa5;[PACK_PROCEDIMENTOS.GRAVA_ARQUIVOS_VETOR: Erro] &#xa5;&apos;||SQLERRM;     &#xa;  END;          &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  FUNCTION EXISTE_ARQUIVOS(V_CD_EMPRESA    IN NUMBER,&#xa;                           V_NR_ITEMCOMPRA IN NUMBER) RETURN BOOLEAN IS&#xa;   EXISTE BOOLEAN := FALSE;                           &#xa;  BEGIN                              &#xa;      &#xa;    FOR I IN 1..ARQUIVOS.COUNT LOOP&#xa;      IF ARQUIVOS(I).CD_EMPRESA = V_CD_EMPRESA AND ARQUIVOS(I).NR_ITEMCOMPRA = V_NR_ITEMCOMPRA THEN&#xa;        EXISTE := TRUE;&#xa;      END IF;  &#xa;    END LOOP;&#xa;    &#xa;    RETURN EXISTE;&#xa;    &#xa;  END;  &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------  &#xa;  PROCEDURE VALIDA_AUTORIZADOR(I_MENSAGEM OUT VARCHAR2) IS&#xa;  &#xa;  V_CD_AUTORICCUSTO  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#xa;  V_CD_AUTORICCUSTO2 AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#xa;  E_GERAL EXCEPTION; &#xa;    &#xa;  BEGIN&#xa;     IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#xa;      GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;      FIRST_RECORD;&#xa;      &#xa;      LOOP&#xa;        IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947  &#xa;          BEGIN  &#xa;            SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)  &#xa;              INTO V_CD_AUTORICCUSTO&#xa;              FROM AUTORIZCCUSTORESTRITO&#xa;             WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO &#xa;               AND AUTORIZCCUSTORESTRITO.CD_EMPRESA = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#xa;               AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = &apos;S&apos;;  &#xa;            EXCEPTION &#xa;              WHEN OTHERS THEN&#xa;                V_CD_AUTORICCUSTO := NULL;  &#xa;          END;&#xa;   &#xa;          IF V_CD_AUTORICCUSTO IS NOT NULL THEN &#xa;            IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN &#xa;              /*O autorizador da tela principal deve ser informado.*/&#xa;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33735, NULL);&#xa;              RAISE E_GERAL; &#xa;            END IF; -- IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN &#xa;            BEGIN  &#xa;              SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#xa;                INTO V_CD_AUTORICCUSTO2&#xa;                FROM AUTORIZCCUSTORESTRITO&#xa;               WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO  &#xa;                 AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR&#xa;                 AND AUTORIZCCUSTORESTRITO.CD_EMPRESA = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#xa;                 AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = &apos;S&apos;;  &#xa;            EXCEPTION&#xa;              WHEN NO_DATA_FOUND THEN  &#xa;                I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);  &#xa;                RAISE E_GERAL;  &#xa;            END;&#xa;          END IF;  --IF V_CD_AUTORICCUSTO IS NOT NULL THEN &#xa;        END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN &#xa;        GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;        EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;        NEXT_RECORD;&#xa;      END LOOP;&#xa;    END IF;  -- IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#xa;    &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      NULL;&#xa;    WHEN OTHERS THEN&#xa;      I_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(16084, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;  &#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;  PROCEDURE VALIDA_LOCALARMAZ(V_MENSAGEM OUT VARCHAR2) IS --eml:22/05/2020:148401&#xa;&#xa;  V_COUNT                NUMBER;&#xa;  E_GERAL                EXCEPTION;&#xa;&#xa;  BEGIN&#xa;  &#xa;    IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN&#xa;      BEGIN&#xa;        SELECT COUNT(*)&#xa;          INTO V_COUNT&#xa;          FROM PARMOVIMENT, CMI&#xa;         WHERE PARMOVIMENT.CD_CMI = CMI.CD_CMI&#xa;           AND CMI.CD_OPERESTOQUE IS NOT NULL&#xa;           AND  PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO;&#xa;      EXCEPTION&#xa;        WHEN OTHERS THEN&#xa;          V_COUNT := 0;&#xa;      END;&#xa;      &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_TIPOLOCALARMAZ&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_TIPOLOCALARMAZ&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_TIPOLOCALARMAZ&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);     &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_LOCALARMAZ&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_LOCALARMAZ&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);     &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_LOCALARMAZ&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ1&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ1&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);   &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ1&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);  &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ2&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ2&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);   &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ2&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);  &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ3&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ3&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);   &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ3&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);  &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ4&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ4&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE); &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ4&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;      &#xa;      IF V_COUNT &gt; 0 THEN --V_COUNT 1&#xa;        BEGIN&#xa;          SELECT COUNT(*)&#xa;            INTO V_COUNT&#xa;            FROM LOCALARMAZENAGEMUSUARIO&#xa;           WHERE (LOCALARMAZENAGEMUSUARIO.CD_EMPRESA = :CONTROLE.CD_EMPRESA OR LOCALARMAZENAGEMUSUARIO.CD_EMPRESA IS NULL)&#xa;             AND LOCALARMAZENAGEMUSUARIO.CD_USUARIO = :GLOBAL.CD_USUARIO&#xa;             AND NVL(LOCALARMAZENAGEMUSUARIO.ST_ATIVO, &apos;N&apos;) = &apos;S&apos;;&#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            V_COUNT := 0;&#xa;        END;&#xa; &#xa;        IF V_COUNT &gt; 0  THEN --V_COUNT &#xa;          BEGIN&#xa;            SELECT LOCALARMAZENAGEMUSUARIO.CD_TIPOLOCALARMAZ,&#xa;                   LOCALARMAZENAGEMUSUARIO.CD_LOCALARMAZ,&#xa;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ1,&#xa;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ2,&#xa;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ3,&#xa;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ4&#xa;              INTO :ITEMCOMPRA.CD_TIPOLOCALARMAZ,&#xa;                   :ITEMCOMPRA.CD_LOCALARMAZ,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ1,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ2,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ3,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ4&#xa;              FROM LOCALARMAZENAGEMUSUARIO&#xa;             WHERE (LOCALARMAZENAGEMUSUARIO.CD_EMPRESA = :CONTROLE.CD_EMPRESA OR LOCALARMAZENAGEMUSUARIO.CD_EMPRESA IS NULL)&#xa;               AND LOCALARMAZENAGEMUSUARIO.CD_USUARIO = :GLOBAL.CD_USUARIO&#xa;               AND NVL(LOCALARMAZENAGEMUSUARIO.ST_ATIVO, &apos;N&apos;) = &apos;S&apos;;&#xa;          EXCEPTION&#xa;            WHEN TOO_MANY_ROWS THEN&#xa;              IF SHOW_LOV(&apos;LOV_LOCALUSUARIO&apos;) THEN&#xa;                NULL;&#xa;              ELSE&#xa;                /*O Local de Armazenagem deve ser informado.*/&#xa;                 V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3619, NULL);&#xa;                 RAISE E_GERAL;&#xa;              END IF;&#xa;            WHEN OTHERS THEN&#xa;              :ITEMCOMPRA.CD_TIPOLOCALARMAZ  := NULL;&#xa;              :ITEMCOMPRA.CD_LOCALARMAZ      := NULL;&#xa;              :ITEMCOMPRA.NR_SUBLOCARMAZ1    := NULL;&#xa;              :ITEMCOMPRA.NR_SUBLOCARMAZ2    := NULL;&#xa;              :ITEMCOMPRA.NR_SUBLOCARMAZ3    := NULL;&#xa;              :ITEMCOMPRA.NR_SUBLOCARMAZ4    := NULL;&#xa;          END;&#xa;                          &#xa;          BEGIN &#xa;            SELECT COUNT(*)&#xa;              INTO V_COUNT&#xa;              FROM ITEMLOCALARMAZ&#xa;             WHERE (ITEMLOCALARMAZ.CD_EMPRESA        = :GLOBAL.CD_EMPRESA)&#xa;               AND (ITEMLOCALARMAZ.CD_ITEM           = :ITEMCOMPRA.CD_ITEM)&#xa;               AND (ITEMLOCALARMAZ.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ)&#xa;               AND (ITEMLOCALARMAZ.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ)&#xa;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1)&#xa;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2)&#xa;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3)&#xa;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ4   = :ITEMCOMPRA.NR_SUBLOCARMAZ4)&#xa;               AND (NVL(ITEMLOCALARMAZ.ST_ITEMLOCAL , &apos;A&apos;) = &apos;A&apos;);&#xa;          EXCEPTION&#xa;            WHEN OTHERS THEN&#xa;              MENSAGEM_PADRAO(15996, &apos;&#xa2;NM_TABELA=&apos;||&apos;ITEMLOCALARMAZ&apos;||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;               RAISE E_GERAL;&#xa;          END;&#xa;&#xa;&#xa;           IF V_COUNT = 0 THEN&#xa;              /*O Local de Armazenagem &#xa2;CD_TIPOLOCALARMAZ&#xa2; - &#xa2;CD_LOCALARMAZ&#xa2;- &#xa2;NR_SUBLOCALARMAZ1&#xa2; - &#xa2;NR_SUBLOCALARMAZ2&#xa2; - &#xa2;NR_SUBLOCALARMAZ3&#xa2; - &#xa2;NR_SUBLOCALARMAZ4&#xa2; n&#xe3;o est&#xe1; cadastrado para o item &#xa2;CD_ITEM&#xa2; e empresa &#xa2;CD_EMPRESA&#xa2; . Verifique TIT001.*/&#xa;             V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(393, &apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ||&apos;&#xa2;CD_LOCALARMAZ=&apos;||:ITEMCOMPRA.CD_LOCALARMAZ||&apos;&#xa2;NR_SUBLOCALARMAZ1=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ1||&apos;&#xa2;NR_SUBLOCALARMAZ2=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ2||&apos;&#xa2;NR_SUBLOCALARMAZ3=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ3||&apos;&#xa2;NR_SUBLOCALARMAZ4=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ4||&apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;              RAISE E_GERAL;&#xa;           END IF;&#xa;&#xa;        ELSIF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;TES&apos;,25,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;ST_VALIDALOCAL&apos;),&apos;N&apos;) = &apos;S&apos; THEN --V_COUNT 2&#xa;          BEGIN&#xa;            SELECT ITEMLOCALARMAZ.CD_TIPOLOCALARMAZ,&#xa;                   ITEMLOCALARMAZ.CD_LOCALARMAZ,&#xa;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ1,&#xa;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ2,&#xa;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ3,&#xa;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ4&#xa;              INTO :ITEMCOMPRA.CD_TIPOLOCALARMAZ,&#xa;                   :ITEMCOMPRA.CD_LOCALARMAZ,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ1,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ2,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ3,&#xa;                   :ITEMCOMPRA.NR_SUBLOCARMAZ4           &#xa;              FROM ITEMLOCALARMAZ&#xa;             WHERE (ITEMLOCALARMAZ.CD_EMPRESA        = :GLOBAL.CD_EMPRESA)&#xa;               AND (ITEMLOCALARMAZ.CD_ITEM           = :ITEMCOMPRA.CD_ITEM)&#xa;               AND (NVL(ITEMLOCALARMAZ.ST_ITEMLOCAL , &apos;A&apos;) = &apos;A&apos;);&#xa;          EXCEPTION&#xa;            WHEN TOO_MANY_ROWS THEN&#xa;              IF SHOW_LOV(&apos;LOV_LOCALUSUARIO&apos;) THEN --FZZER UMA LOV NOVA&#xa;                NULL;&#xa;              ELSE&#xa;               /*O Local de Armazenagem deve ser informado.*/&#xa;                V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3619, NULL);&#xa;                RAISE E_GERAL;&#xa;              END IF;&#xa;            WHEN OTHERS THEN&#xa;              /*O Local de Armazenagem &#xa2;CD_TIPOLOCALARMAZ&#xa2; - &#xa2;CD_LOCALARMAZ&#xa2;- &#xa2;NR_SUBLOCALARMAZ1&#xa2; - &#xa2;NR_SUBLOCALARMAZ2&#xa2; - &#xa2;NR_SUBLOCALARMAZ3&#xa2; - &#xa2;NR_SUBLOCALARMAZ4&#xa2; n&#xe3;o est&#xe1; cadastrado para o item &#xa2;CD_ITEM&#xa2; e empresa &#xa2;CD_EMPRESA&#xa2; . Verifique TIT001.*/&#xa;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(393, &apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ||&apos;&#xa2;CD_LOCALARMAZ=&apos;||:ITEMCOMPRA.CD_LOCALARMAZ||&apos;&#xa2;NR_SUBLOCALARMAZ1=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ1||&apos;&#xa2;NR_SUBLOCALARMAZ2=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ2||&apos;&#xa2;NR_SUBLOCALARMAZ3=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ3||&apos;&#xa2;NR_SUBLOCALARMAZ4=&apos;||:ITEMCOMPRA.NR_SUBLOCARMAZ4||&apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;              RAISE E_GERAL;&#xa;          END;    &#xa;        END IF; -- IF V_COUNT 2&#xa;      END IF; --IF V_COUNT 1&#xa;    ELSE&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_TIPOLOCALARMAZ&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_TIPOLOCALARMAZ&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_TIPOLOCALARMAZ&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);     &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_LOCALARMAZ&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_LOCALARMAZ&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);     &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.CD_LOCALARMAZ&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ1&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ1&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);   &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ1&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);  &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ2&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ2&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);   &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ2&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);  &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ3&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ3&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);   &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ3&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);  &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ4&apos;,CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ4&apos;,CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE); &#xa;      SET_ITEM_INSTANCE_PROPERTY (&apos;ITEMCOMPRA.NR_SUBLOCARMAZ4&apos;,CURRENT_RECORD,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);&#xa;    END IF; --:ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      :ITEMCOMPRA.CD_TIPOLOCALARMAZ  := NULL;&#xa;      :ITEMCOMPRA.CD_LOCALARMAZ      := NULL;&#xa;      :ITEMCOMPRA.NR_SUBLOCARMAZ1    := NULL;&#xa;      :ITEMCOMPRA.NR_SUBLOCARMAZ2    := NULL;&#xa;      :ITEMCOMPRA.NR_SUBLOCARMAZ3    := NULL;&#xa;      :ITEMCOMPRA.NR_SUBLOCARMAZ4    := NULL;&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2); &#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM_PADRAO(16084, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;&#xa;  END VALIDA_LOCALARMAZ;&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------   &#xa;  PROCEDURE CONSULTA_NM_LOCALARMAZENAGEM IS&#xa;  &#xa;  BEGIN&#xa;    &#xa;    IF :ITEMCOMPRA.CD_TIPOLOCALARMAZ IS NOT NULL AND&#xa;       :ITEMCOMPRA.CD_LOCALARMAZ   IS NOT NULL /*AND&#xa;      -- :ITEMCOMPRA.NR_SUBLOCARMAZ1 IS NOT NULL AND&#xa;      -- :ITEMCOMPRA.NR_SUBLOCARMAZ2 IS NOT NULL AND&#xa;      -- :ITEMCOMPRA.NR_SUBLOCARMAZ3 IS NOT NULL AND&#xa;      /* :ITEMCOMPRA.NR_SUBLOCARMAZ4 IS NOT NULL*/ THEN  &#xa;      BEGIN&#xa;        SELECT DISTINCT LOCALARMAZENAGEM.DS_LOCALARMAZ&#xa;          INTO :ITEMCOMPRA.NM_LOCALARMAZENAGEM&#xa;          FROM LOCALARMAZENAGEM&#xa;         WHERE LOCALARMAZENAGEM.CD_EMPRESA        = :CONTROLE.CD_EMPRESA&#xa;           AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#xa;           AND LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ   &#xa;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1 &#xa;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2 &#xa;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3 &#xa;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ4   = :ITEMCOMPRA.NR_SUBLOCARMAZ4&#xa;           AND LOCALARMAZENAGEM.ST_OCUPACAO = &apos;A&apos;;&#xa;      EXCEPTION &#xa;        WHEN OTHERS THEN&#xa;          :ITEMCOMPRA.NM_LOCALARMAZENAGEM := NULL;&#xa;      END;    &#xa;       &#xa;    END IF;     &#xa;  END CONSULTA_NM_LOCALARMAZENAGEM;  &#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------ &#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779077" FOLDED="true" MODIFIED="1607991779077" TEXT="VALIDA_DUPLICADOS">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="body">
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="PROCEDURE VALIDA_DUPLICADOS (O_MENSAGEM    OUT VARCHAR2) IS&#xa;&#xa;  V_NR_REGISTRO     NUMBER;&#xa;  V_CD_CENTROCUSTO  ITEMCOMPRACCUSTO.CD_CENTROCUSTO%TYPE;&#xa;  V_CD_NEGOCIO      ITEMCOMPRACCUSTO.CD_NEGOCIO%TYPE; /*CSL:22/12/2010:30317*/&#xa;  V_MENSAGEM        VARCHAR2(32000);&#xa;  E_GERAL            EXCEPTION;&#xa;  V_CD_EMPRCCUSTODEST  EMPRESA.CD_EMPRESA%TYPE;&#xa;BEGIN&#xa;  &#xa;  GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;  FIRST_RECORD;&#xa;  LOOP&#xa;    V_NR_REGISTRO    := :SYSTEM.CURSOR_RECORD;&#xa;    V_CD_CENTROCUSTO := :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#xa;    V_CD_NEGOCIO     := :ITEMCOMPRACCUSTO.CD_NEGOCIO;&#xa;    --GDG:22/07/2011:28715    &#xa;    V_CD_EMPRCCUSTODEST := NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :ITEMCOMPRACCUSTO.CD_EMPRESA);&#xa;    FIRST_RECORD;&#xa;    LOOP&#xa;      IF (V_NR_REGISTRO &lt;&gt; :SYSTEM.CURSOR_RECORD) THEN&#xa;        /**CSL:22/12/2010:30317&#xa;         * Alterado para passar a comparar tamb&#xe9;m o c&#xf3;digo do neg&#xf3;cio, pois poder&#xe1; ser &#xa;         * informado varios centros de custos iguais, por&#xe9;m com c&#xf3;digos de neg&#xf3;cio diferentes.&#xa;         */&#xa;        IF V_CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO AND V_CD_NEGOCIO = :ITEMCOMPRACCUSTO.CD_NEGOCIO&#xa;          --GDG:22/07/2011:28715 VALIDA&#xc7;&#xc3;O DE REGISTRO DUPLICADO&#xa;          AND V_CD_EMPRCCUSTODEST = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :ITEMCOMPRACCUSTO.CD_EMPRESA) THEN&#xa;          --V_MENSAGEM := &apos;O Centro de Custo (&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;) e o Neg&#xf3;cio (&apos;||:ITEMCOMPRACCUSTO.CD_NEGOCIO||&apos;) do registro atual (&apos;||:SYSTEM.CURSOR_RECORD||&apos;) &#xe9; igual ao do registro (&apos;||V_NR_REGISTRO||&apos;). Por favor verifique e altere.&apos;; &#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6353,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRACCUSTO.CD_NEGOCIO||&apos;&#xa2;NR_REGATUAL=&apos;||:SYSTEM.CURSOR_RECORD||&apos;&#xa2;NR_REGISTRO=&apos;||V_NR_REGISTRO||&apos;&#xa2;&apos;);--O Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2; e o Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; do registro atual &#xa2;NR_REGATUAL&#xa2; &#xe9; igual ao do registro &#xa2;NR_REGISTRO&#xa2;. Por favor verifique e altere. &#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;      END IF;&#xa;     &#xa;      EXIT WHEN (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;);&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;    &#xa;    GO_RECORD(V_NR_REGISTRO);&#xa;    EXIT WHEN (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;);&#xa;    NEXT_RECORD;&#xa;  END LOOP;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    O_MENSAGEM := V_MENSAGEM; &#xa;  WHEN OTHERS THEN&#xa;    O_MENSAGEM := SQLERRM;   &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779077" FOLDED="true" MODIFIED="1607991779077" TEXT="ENVIA_EMAIL">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="body">
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="PROCEDURE ENVIA_EMAIL(I_CD_EMPRESA    IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                      I_NR_LOTECOMPRA  IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE) IS&#xa;                      &#xa;  V_VET_DESTINATARIOS  PACK_DADOS_EMAIL.R_DESTINATARIOS;&#xa;  V_VET_ANEXOEMAIL      PACK_DADOS_EMAIL.R_ANEXOEMAIL;&#xa;  V_REMETENTE          PACK_DADOS_EMAIL.T_REMETENTE;&#xa;  V_NM_USUARIO         USUARIO.NM_USUARIO%TYPE;&#xa;  V_CORPOEMAIL         VARCHAR2(32000);&#xa;  V_MENSAGEM           VARCHAR2(32000);&#xa;  V_DS_MENSAGEMEMAIL   VARCHAR2(2000);&#xa;  V_NM_CONTAEMAIL      VARCHAR2(600);&#xa;  V_NM_EXIBICAOEMAIL   VARCHAR2(600);&#xa;  V_NM_USUARIOEMAIL    VARCHAR2(600);&#xa;  V_DS_SENHAEMAIL      VARCHAR2(600);&#xa;  V_NM_HOSTEMAIL       VARCHAR2(600);&#xa;  V_NR_PORTA           VARCHAR2(600);&#xa;  V_NM_CONTAEMAILDEST  VARCHAR2(60);&#xa;  V_NM_BASE            VARCHAR2(60);&#xa;  V_ST_CONEXAO         VARCHAR2(1);&#xa;  V_COUNTFORNEC         NUMBER; /*ATR:115974:26/12/2017*/&#xa;  V_COUNT               NUMBER; /*ATR:115974:26/12/2017*/&#xa;  E_GERAL              EXCEPTION;&#xa;  V_NR_SID             NUMBER;&#xa;  --V_NR_SEQUENCIA       NUMBER;&#xa;  ----------------------------------------------------------------------------------------&#xa;  /* MGK:63701:10/10/2013&#xa;   * Estrutura utilizada para armazenar os dados das solicita&#xe7;&#xf5;es de compras. &#xa;   * Esses dados ser&#xe3;o utilizados na composi&#xe7;&#xe3;o do e-mail que ser&#xe1; enviado ao autorizador.&#xa;   */&#xa;&#xa;  CURSOR CUR_USUARIOS IS &#xa;    SELECT DISTINCT USUARIO.NM_CONTAEMAIL&#xa;      FROM USUARIO, SOLICITANTE, PARMCOMPRA&#xa;     WHERE USUARIO.NM_CONTAEMAIL IS NOT NULL&#xa;       AND USUARIO.CD_USUARIO = SOLICITANTE.CD_USUARIO&#xa;       AND SOLICITANTE.CD_EMPRESA = PARMCOMPRA.CD_EMPRESA&#xa;       AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.ST_APROVSOLIC&#xa;       AND (SOLICITANTE.DT_VENCIMENTO IS NULL OR TRUNC(SOLICITANTE.DT_VENCIMENTO) &gt;= TRUNC(SYSDATE))&#xa;       AND PARMCOMPRA.CD_EMPRESA = I_CD_EMPRESA;&#xa;  &#xa;  CURSOR CUR_DADOS_SOLICITACOES IS&#xa;    SELECT (ITEMCOMPRA.CD_TIPOCOMPRA||&apos; - &apos;||TIPOCOMPRA.DS_TIPOCOMPRA) DS_TIPOCOMPRA,&#xa;           (NVL(ITEMCOMPRA.DS_OBSERVACAO,&apos;Sem observa&#xe7;&#xe3;o&apos;)) DS_OBSERVACAO,&#xa;           (ITEMCOMPRA.CD_ITEM||&apos; - &apos;||ITEM.DS_ITEM) DS_ITEM, &#xa;           (NVL(ITEMCOMPRA.QT_PREVISTA,0)) QT_PREVISTA, &#xa;           ITEMCOMPRA.NR_LOTECOMPRA,&#xa;           ITEMCOMPRA.NR_ITEMCOMPRA,&#xa;           ITEMCOMPRA.ST_ITEMCOMPRA,&#xa;           ITEMCOMPRA.CD_EMPRESA&#xa;      FROM ITEMCOMPRA, &#xa;           ITEM, &#xa;           TIPOCOMPRA&#xa;     WHERE ITEMCOMPRA.CD_ITEM       = ITEM.CD_ITEM&#xa;       AND ITEMCOMPRA.CD_TIPOCOMPRA  = TIPOCOMPRA.CD_TIPOCOMPRA&#xa;       AND ITEMCOMPRA.CD_EMPRESA    = I_CD_EMPRESA&#xa;       AND ITEMCOMPRA.NR_LOTECOMPRA = I_NR_LOTECOMPRA;&#xa;     &#xa;  V_MSG_EMAIL          VARCHAR2(32000);&#xa;  V_MSG_EMAIL_1       VARCHAR2(32000) := &apos;O n&#xfa;mero de lote (&apos;||I_NR_LOTECOMPRA||&apos;) possui As seguintes solicita&#xe7;&#xf5;es de compras: &apos;;&#xa;  V_MSG_EMAIL_2        VARCHAR2(32000);&#xa;  V_MSG_EMAIL_3       VARCHAR2(32000) := &apos;Estas solicita&#xe7;&#xf5;es de compras est&#xe3;o aguardando sua autoriza&#xe7;&#xe3;o. Verifique os programas indicados para cada solicita&#xe7;&#xe3;o.&apos;;&#xa;  V_NM_PROGRAMA       VARCHAR2(10);&#xa;  V_ST_APROVSOLIC     VARCHAR2(1);&#xa;  ----------------------------------------------------------------------------------------&#xa;&#xa;  BEGIN&#xa;    &#xa;    -- Buscando configura&#xe7;&#xe3;o de email do compras para a empresa logada.&#xa;    BEGIN&#xa;      SELECT RETORNA_VALORSTRING(VL_PARAMETRO,1,&apos;&#xa2;&apos;) NM_CONTAEMAIL,&#xa;             RETORNA_VALORSTRING(VL_PARAMETRO,2,&apos;&#xa2;&apos;) NM_EXIBICAOEMAIL,&#xa;             RETORNA_VALORSTRING(VL_PARAMETRO,3,&apos;&#xa2;&apos;) NM_USUARIOEMAIL,&#xa;             RETORNA_VALORSTRING(VL_PARAMETRO,4,&apos;&#xa2;&apos;) DS_SENHAEMAIL,&#xa;             RETORNA_VALORSTRING(VL_PARAMETRO,5,&apos;&#xa2;&apos;) NM_HOSTEMAIL,&#xa;             RETORNA_VALORSTRING(VL_PARAMETRO,6,&apos;&#xa2;&apos;) NR_PORTA,&#xa;             RETORNA_VALORSTRING(VL_PARAMETRO,7,&apos;&#xa2;&apos;) ST_CONEXAO&#xa;        INTO V_NM_CONTAEMAIL,&#xa;             V_NM_EXIBICAOEMAIL,&#xa;             V_NM_USUARIOEMAIL,&#xa;             V_DS_SENHAEMAIL,&#xa;             V_NM_HOSTEMAIL,&#xa;             V_NR_PORTA,&#xa;             V_ST_CONEXAO&#xa;        FROM PARMGENERICO&#xa;       WHERE RETORNA_VALORSTRING(NM_PARAMETRO,1,&apos;&#xa2;&apos;) = &apos;EMAILCOMPRAS&apos;&#xa;         AND RETORNA_VALORSTRING(NM_PARAMETRO,2,&apos;&#xa2;&apos;) = :GLOBAL.CD_EMPRESA&#xa;         AND PARMGENERICO.CD_MODULO                  = &apos;COM&apos;&#xa;         AND PARMGENERICO.CD_PROGRAMA                = 9;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        V_NM_CONTAEMAIL    := NULL;&#xa;        V_NM_EXIBICAOEMAIL := NULL;&#xa;        V_NM_USUARIOEMAIL  := NULL;&#xa;        V_DS_SENHAEMAIL    := NULL;&#xa;        V_NM_HOSTEMAIL     := NULL;&#xa;        V_NR_PORTA         := NULL;&#xa;        V_ST_CONEXAO       := NULL;&#xa;        --N&#xe3;o foram encontrados os par&#xe2;metros de envio de email para a  empresa &#xa2;CD_EMPRESA&#xa2;. Verifique o Programa COM009 P&#xe1;gina &quot;Envio Email&quot;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8356,&apos;&#xa2;CD_EMPRESA=&apos;||:GLOBAL.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN &#xa;        V_NM_CONTAEMAIL    := NULL;&#xa;        V_NM_EXIBICAOEMAIL := NULL;&#xa;        V_NM_USUARIOEMAIL  := NULL;&#xa;        V_DS_SENHAEMAIL    := NULL;&#xa;        V_NM_HOSTEMAIL     := NULL;&#xa;        V_NR_PORTA         := NULL;&#xa;        V_ST_CONEXAO       := NULL;&#xa;        --Ocorreu um erro ao consultar os par&#xe2;metros de envio de email para a  empresa &#xa2;CD_EMPRESA&#xa2;. Verifique o Programa COM009 P&#xe1;gina &quot;Envio Email&quot;. Erro &#xa2;SQLERRM&#xa2;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8357,&apos;&#xa2;CD_EMPRESA=&apos;||:GLOBAL.CD_EMPRESA||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    END; &#xa;    IF V_NM_USUARIOEMAIL IS NOT NULL THEN&#xa;      BEGIN&#xa;        SELECT PARMGENERICO.NM_PARAMETRO DS_MENSAGEMEMAIL&#xa;          INTO V_DS_MENSAGEMEMAIL&#xa;          FROM PARMGENERICO&#xa;         WHERE RETORNA_VALORSTRING(VL_PARAMETRO,1,&apos;&#xa2;&apos;) = &apos;EMAILCOMPRAS&apos;&#xa;           AND RETORNA_VALORSTRING(VL_PARAMETRO,2,&apos;&#xa2;&apos;) = :GLOBAL.CD_EMPRESA&#xa;           AND PARMGENERICO.CD_PROGRAMA                = 9&#xa;           AND PARMGENERICO.CD_MODULO                  = &apos;COM&apos;;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          V_DS_MENSAGEMEMAIL := NULL;&#xa;        WHEN OTHERS THEN &#xa;          V_DS_MENSAGEMEMAIL := NULL;&#xa;      END; &#xa;      &#xa;      /**MPB:09/04/2012:43880&#xa;       * Realizado altera&#xe7;&#xe3;o de tabela para compatibilizar as opera&#xe7;&#xf5;es com a estrutura do Oracle RAC.&#xa;       */&#xa;    &#xa;      -- busca do SID do logado..&#xa;      BEGIN&#xa;        SELECT DISTINCT MAX$MYSTAT.SID&#xa;          INTO V_NR_SID&#xa;          FROM MAX$MYSTAT;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          NULL;&#xa;      END;&#xa;      &#xa;      -- Qual base esta logado&#xa;      BEGIN&#xa;        SELECT NM_HOST&#xa;          INTO V_NM_BASE&#xa;          FROM HOST;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          V_NM_BASE := &apos;MAXYS_PROD&apos;;          &#xa;      END;&#xa;      V_COUNTFORNEC := 0;&#xa;      IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN &#xa;        BEGIN&#xa;          SELECT COUNT(*)&#xa;            INTO V_COUNTFORNEC&#xa;            FROM USUARIO&#xa;           WHERE USUARIO.NM_CONTAEMAIL IS NOT NULL&#xa;             AND USUARIO.CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            V_COUNTFORNEC := 0;&#xa;        END;&#xa;      ELSE &#xa;        BEGIN&#xa;          SELECT COUNT(*)&#xa;            INTO V_COUNTFORNEC&#xa;            FROM USUARIO, SOLICITANTE, PARMCOMPRA&#xa;           WHERE USUARIO.NM_CONTAEMAIL IS NOT NULL&#xa;             AND USUARIO.CD_USUARIO = SOLICITANTE.CD_USUARIO&#xa;             AND SOLICITANTE.CD_EMPRESA = PARMCOMPRA.CD_EMPRESA&#xa;             AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.ST_APROVSOLIC&#xa;             AND (SOLICITANTE.DT_VENCIMENTO IS NULL OR TRUNC(SOLICITANTE.DT_VENCIMENTO) &gt;= TRUNC(SYSDATE))&#xa;             AND PARMCOMPRA.CD_EMPRESA = I_CD_EMPRESA;&#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            V_COUNTFORNEC := 0;&#xa;        END;&#xa;      END IF;&#xa;    /*  --buscando dados do email do fornecedor.&#xa;      BEGIN&#xa;        SELECT USUARIO.NM_CONTAEMAIL, &#xa;               USUARIO.NM_USUARIO &#xa;          INTO V_NM_CONTAEMAILDEST,&#xa;               V_NM_USUARIO&#xa;          FROM USUARIO&#xa;         WHERE CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          --Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o possui email configurado. Verifique ANV001.&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4751,&apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos; - &apos;||:CONTROLE.NM_USUAUTORIZ||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;        WHEN OTHERS THEN&#xa;          V_MENSAGEM := &apos;Imposs&#xed;vel buscar email de autorizador &apos;||SQLERRM;&#xa;          RAISE E_GERAL;&#xa;      END;*/&#xa;      IF V_COUNTFORNEC &gt; 0 THEN&#xa;        /*RETORNA_SEQUENCIA(&apos;SQEMAIL&apos;,:GLOBAL.CD_EMPRESA,V_NR_SEQUENCIA,V_MENSAGEM);&#xa;        IF V_MENSAGEM IS NOT NULL THEN&#xa;          RAISE E_GERAL;      &#xa;        END IF;*/&#xa;        &#xa;        --Buscar o par&#xe2;metro &quot;Aprovar solicita&#xe7;&#xe3;o de Compras&quot;, da p&#xe1;gina &quot;Valida&#xe7;&#xf5;es&quot; do COM009.&#xa;        BEGIN  &#xa;          SELECT NVL(PARMCOMPRA.ST_APROVSOLIC,&apos;N&apos;)&#xa;            INTO V_ST_APROVSOLIC&#xa;            FROM PARMCOMPRA&#xa;           WHERE PARMCOMPRA.CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#xa;        EXCEPTION &#xa;          WHEN OTHERS THEN&#xa;            V_ST_APROVSOLIC := &apos;N&apos;;&#xa;        END;&#xa;        &#xa;        --MGK:63701:10/10/2013 - Inclu&#xed;do o c&#xf3;digo abaixo, cuja finalidade &#xe9; compor a mensagem que ser&#xe1; enviada ao autorizador da solicita&#xe7;&#xe3;o de compra.&#xa;        FOR I IN CUR_DADOS_SOLICITACOES LOOP&#xa;          IF ((NVL(V_ST_APROVSOLIC,&apos;N&apos;) = &apos;S&apos;) OR (I.ST_ITEMCOMPRA = 0)) THEN&#xa;            V_NM_PROGRAMA := &apos;COM002&apos;;&#xa;          ELSIF ((NVL(V_ST_APROVSOLIC,&apos;N&apos;) = &apos;N&apos;) OR (I.ST_ITEMCOMPRA IN (1,14))) THEN&#xa;            V_NM_PROGRAMA := &apos;COM006&apos;;&#xa;          END IF;&#xa;          &#xa;          IF (V_MSG_EMAIL_2 IS NULL) THEN&#xa;            V_MSG_EMAIL_2 := CHR(10)||&#xa;                             &apos;&gt;&gt; Solicita&#xe7;&#xe3;o (&apos;||I.NR_ITEMCOMPRA||&#xa;                              &apos;) da empresa (&apos;||I.CD_EMPRESA||&#xa;                              &apos;), item (&apos;||I.DS_ITEM||&#xa;                              &apos;), quantidade (&apos;||I.QT_PREVISTA||&#xa;                              &apos;), tipo de compra (&apos;||I.DS_TIPOCOMPRA||&#xa;                              &apos;) observa&#xe7;&#xe3;o (&apos;||I.DS_OBSERVACAO||&#xa;                              &apos;). (Verificar o programa &apos;||V_NM_PROGRAMA||&apos;)&apos;;&#xa;          ELSE&#xa;            V_MSG_EMAIL_2 := V_MSG_EMAIL_2||&apos;; &apos;||&#xa;                             CHR(10)||&#xa;                             CHR(10)||&#xa;                             &apos;&gt;&gt; Solicita&#xe7;&#xe3;o (&apos;||I.NR_ITEMCOMPRA||&#xa;                             &apos;) da empresa (&apos;||I.CD_EMPRESA||&#xa;                             &apos;), item (&apos;||I.DS_ITEM||&#xa;                             &apos;), quantidade (&apos;||I.QT_PREVISTA  ||&#xa;                             &apos;), tipo de compra (&apos;||I.DS_TIPOCOMPRA||&#xa;                             &apos;) observa&#xe7;&#xe3;o (&apos;||I.DS_OBSERVACAO||&#xa;                             &apos;). (Verificar o programa &apos;||V_NM_PROGRAMA||&apos;)&apos;;&#xa;          END IF;&#xa;        END LOOP;&#xa;        &#xa;        --MGK:63701:10/10/2013 - Jun&#xe7;&#xe3;o das vari&#xe1;veis&#xa;        V_MSG_EMAIL := V_MSG_EMAIL_1||&#xa;                       CHR(10)||&#xa;                       V_MSG_EMAIL_2||&apos;.&apos;||&#xa;                       CHR(10)||&#xa;                       CHR(10)||&#xa;                       V_MSG_EMAIL_3;&#xa;        &#xa;        --Mensagem do corpo do email.&#xa;        V_CORPOEMAIL := CHR(10)||&#xa;                        &apos;Aten&#xe7;&#xe3;o:&apos;||&#xa;                        CHR(10)||&#xa;                        V_MSG_EMAIL||&#xa;                        CHR(10)||&#xa;                        CHR(10)||&#xa;                        &apos;Solicitado por: &apos;||:GLOBAL.CD_USUARIO||&apos; - &apos;||:GLOBAL.NM_USUARIO||&#xa;                        CHR(10)||&#xa;                        CHR(10)||&#xa;                        &apos;Obs.: &apos;||&#xa;                        CHR(10)||&#xa;                        V_DS_MENSAGEMEMAIL;&#xa;        &#xa;        --MGK:63701:10/10/2013 - preenchimento das vari&#xe1;veis que ser&#xe3;o passadas para o procedimento INCLUI_FILAEMAIL.&#xa;        IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#xa;           --buscando dados do email do fornecedor.&#xa;          BEGIN&#xa;            SELECT USUARIO.NM_CONTAEMAIL, &#xa;                   USUARIO.NM_USUARIO &#xa;              INTO V_NM_CONTAEMAILDEST,&#xa;                   V_NM_USUARIO&#xa;              FROM USUARIO&#xa;             WHERE CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#xa;          EXCEPTION&#xa;            WHEN NO_DATA_FOUND THEN&#xa;              --Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o possui email configurado. Verifique ANV001.&#xa;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4751,&apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos; - &apos;||:CONTROLE.NM_USUAUTORIZ||&apos;&#xa2;&apos;);&#xa;              RAISE E_GERAL;&#xa;            WHEN OTHERS THEN&#xa;              V_MENSAGEM := &apos;Imposs&#xed;vel buscar email de autorizador &apos;||SQLERRM;&#xa;              RAISE E_GERAL;&#xa;          END;          &#xa;          V_REMETENTE.DS_ASSUNTO                  := &apos;Solicita&#xe7;&#xf5;es aguardando sua libera&#xe7;&#xe3;o.&apos;;&#xa;          V_REMETENTE.NM_EXIBICAOEMAIL            := V_NM_EXIBICAOEMAIL;&#xa;          V_REMETENTE.NM_USUARIOEMAIL             := V_NM_USUARIOEMAIL;&#xa;          V_REMETENTE.DS_CONTAEMAIL               := V_NM_CONTAEMAIL;&#xa;          V_REMETENTE.DS_SENHAEMAIL               := V_DS_SENHAEMAIL;&#xa;          V_REMETENTE.NM_HOSTEMAIL                := V_NM_HOSTEMAIL;&#xa;          V_REMETENTE.NR_PORTAEMAIL               := V_NR_PORTA;&#xa;          V_REMETENTE.ST_CONEXAO                  := V_ST_CONEXAO;&#xa;          V_REMETENTE.DS_COMPLEMENSAGEM            := V_CORPOEMAIL;&#xa;          V_REMETENTE.DS_MENSAGEMEMAIL            := &apos;Solicita&#xe7;&#xf5;es aguardando sua libera&#xe7;&#xe3;o.&apos;||CHR(10);&#xa;          V_VET_DESTINATARIOS(1).DS_EMAIL         := V_NM_CONTAEMAILDEST;&#xa;          V_VET_DESTINATARIOS(1).NM_EXIBICAOEMAIL := NULL;&#xa;          V_VET_DESTINATARIOS(1).NR_DESTINATARIO  := 1;        &#xa;        ELSE&#xa;          V_COUNT := 0;&#xa;          FOR I IN CUR_USUARIOS LOOP&#xa;            V_COUNT := V_COUNT + 1;&#xa;            V_REMETENTE.DS_ASSUNTO                  := &apos;Solicita&#xe7;&#xf5;es aguardando sua libera&#xe7;&#xe3;o.&apos;;&#xa;            V_REMETENTE.NM_EXIBICAOEMAIL            := V_NM_EXIBICAOEMAIL;&#xa;            V_REMETENTE.NM_USUARIOEMAIL             := V_NM_USUARIOEMAIL;&#xa;            V_REMETENTE.DS_CONTAEMAIL               := V_NM_CONTAEMAIL;&#xa;            V_REMETENTE.DS_SENHAEMAIL               := V_DS_SENHAEMAIL;&#xa;            V_REMETENTE.NM_HOSTEMAIL                := V_NM_HOSTEMAIL;&#xa;            V_REMETENTE.NR_PORTAEMAIL               := V_NR_PORTA;&#xa;            V_REMETENTE.ST_CONEXAO                  := V_ST_CONEXAO;&#xa;            V_REMETENTE.DS_COMPLEMENSAGEM            := V_CORPOEMAIL;&#xa;            V_REMETENTE.DS_MENSAGEMEMAIL            := &apos;Solicita&#xe7;&#xf5;es aguardando sua libera&#xe7;&#xe3;o.&apos;||CHR(10);&#xa;            V_VET_DESTINATARIOS(V_COUNT).DS_EMAIL         := I.NM_CONTAEMAIL;&#xa;            V_VET_DESTINATARIOS(V_COUNT).NM_EXIBICAOEMAIL := NULL;&#xa;            V_VET_DESTINATARIOS(V_COUNT).NR_DESTINATARIO  := V_COUNT;            &#xa;          END LOOP;&#xa;        END IF;&#xa;          --MGK:63701:10/10/2013 - grava&#xe7;&#xe3;o na tabela EMAIL e DESTINATARIO_EMAIL.&#xa;          PACK_DADOS_EMAIL.INCLUI_FILAEMAIL(I_CD_EMPRESA         =&gt; :GLOBAL.CD_EMPRESA,&#xa;                                            I_CD_USUARIO         =&gt; :GLOBAL.CD_USUARIO,&#xa;                                            I_SID               =&gt; V_NR_SID,&#xa;                                            I_REMETENTE         =&gt; V_REMETENTE,&#xa;                                            I_VET_DESTINATARIOS =&gt; V_VET_DESTINATARIOS,&#xa;                                            I_VET_ANEXOEMAIL     =&gt; V_VET_ANEXOEMAIL,&#xa;                                            I_TP_PRIORIDADE     =&gt; 4,&#xa;                                            O_MENSAGEM           =&gt; V_MENSAGEM);&#xa;      END IF;&#xa;    END IF;&#xa;    /**FLA:06/12/2019:142176&#xa;     * Adicionado para impedir o travamento da sess&#xe3;o da tela&#xa;     */&#xa;    FAZ_COMMIT;&#xa;     &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;     /**FLA:06/12/2019:142176&#xa;      * Adicionado para impedir o travamento da sess&#xe3;o da tela&#xa;      */&#xa;      FAZ_ROLLBACK;&#xa;      MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;  END;"/>
</node>
</node>
<node CREATED="1607991779077" FOLDED="true" MODIFIED="1607991779077" TEXT="PACK_AUDITORIA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="body">
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="/**FZA:29085:09/11/2010&#xa;***Criado pacote para gravacao de logs de todos os campos alterados nos blocos de banco do programa.&#xa;***A chamada dos procedimentos dessa PACK estao nos gatilhos PRE-INSERT  e PRE-UPDATE de cada bloco, &#xa;***assim ele grava log de todos os registros alterados dentro do bloco, pois todos regitros alterados passam&#xa;***por esses gatilhos.&#xa;***Na procedure AUDITA_GRAVACAO, foi ajustado para nao inserir LOG dos blocos que sao inseridos por essa PACK.&#xa;***A gravacao dos Log referente as exclusoes estao sendo gravados na Procedure AUDITA_EXCLUSAO normalmente&#xa;**/&#xa;PACKAGE BODY PACK_AUDITORIA IS&#xa;  --Procedimento que insere os dados atualizados do bloco.&#xa;  PROCEDURE AUDITA_ATUALIZACAO (V_BLOCO IN VARCHAR2) IS&#xa;    DS_TABELA       VARCHAR2(32000);&#xa;    DS_PRIM_ITEM    VARCHAR2(32000);&#xa;    DS_ULTI_ITEM    VARCHAR2(32000);&#xa;    I_UPDATE        VARCHAR2(32000);&#xa;    I_VALORES_UPD   VARCHAR2(32000);&#xa;    I_REGISTRO      VARCHAR2(32000);&#xa;    I_DS_EVENTO     VARCHAR2(32000);&#xa;    I_DS_VALOR      VARCHAR2(32000);&#xa;    I_DS_DML        VARCHAR2(32000);&#xa;    I_CAMPOS_UPD    VARCHAR2(32000);&#xa;    I_WHERE         VARCHAR2(32000);&#xa;    I_CONTADOR_UPD  NUMBER := 0;&#xa;  BEGIN&#xa;    DS_TABELA         := GET_BLOCK_PROPERTY(V_BLOCO,DML_DATA_TARGET_NAME);&#xa;    DS_PRIM_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,FIRST_ITEM);&#xa;    DS_ULTI_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,LAST_ITEM);&#xa;    LOOP                &#xa;      IF (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;TEXT ITEM&apos;) OR&#xa;         (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;LIST&apos;) OR&#xa;         (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;RADIO GROUP&apos;) OR&#xa;         (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;CHECK BOX&apos;) THEN&#xa;        --Verifica se o campo &#xe9; uma coluna da tabela&#xa;        IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,COLUMN_NAME) IS NOT NULL THEN          &#xa;          --Busca o valor do campo e concatena a mensagem que ira aparecer no anv7&#xa;          I_DS_VALOR :=  NAME_IN(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM);&#xa;          I_REGISTRO  := I_REGISTRO||&apos; &apos;||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,PROMPT_TEXT)||&apos; &apos;||I_DS_VALOR;&#xa;          I_DS_EVENTO := (&apos;Atualizou o registro &apos; || I_REGISTRO || &apos; na tabela &apos; || DS_TABELA);&#xa;        END IF;&#xa;        --Monta o WHERE da SQL referente a alteracao efetuada.&#xa;        IF (I_DS_VALOR IS NOT NULL) THEN&#xa;          IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,PRIMARY_KEY) &lt;&gt; &apos;TRUE&apos; THEN&#xa;            IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;              IF (V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM = V_BLOCO||&apos;.HR_RECORD&apos;) THEN&#xa;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||&apos; = &apos;||CHR(39)||TO_CHAR(RETORNA_DATAHORA,&apos;HH24:MI&apos;)||CHR(39)||&apos;, &apos;;&#xa;              ELSE&#xa;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||&apos; = &apos;||CHR(39)||:SYSTEM.CURSOR_VALUE||CHR(39)||&apos;, &apos;;&#xa;              END IF;&#xa;            ELSE&#xa;              IF (V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM = V_BLOCO||&apos;.DT_RECORD&apos;) THEN&#xa;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||&apos; = &apos;||RETORNA_DATAHORA||&apos;, &apos;;&#xa;              ELSE&#xa;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||&apos; = &apos;||:SYSTEM.CURSOR_VALUE||&apos;, &apos;;&#xa;              END IF;&#xa;            END IF;&#xa;          END IF;&#xa;        ELSIF (I_DS_VALOR IS NULL) THEN&#xa;          IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,PRIMARY_KEY) &lt;&gt; &apos;TRUE&apos; THEN&#xa;            I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||&apos; = &apos;||CHR(39)||&apos; &apos;||CHR(39)||&apos;, &apos;;&#xa;          END IF;&#xa;        END IF;&#xa;        --Monta os Campos atualizados da SQL&#xa;        IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,PRIMARY_KEY) = &apos;TRUE&apos; THEN&#xa;          IF I_CONTADOR_UPD = 0 THEN&#xa;            IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;              I_CAMPOS_UPD := I_CAMPOS_UPD||DS_PRIM_ITEM||&apos; = &apos;||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;            ELSE&#xa;              I_CAMPOS_UPD := I_CAMPOS_UPD||DS_PRIM_ITEM||&apos; = &apos;||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE);&#xa;            END IF;&#xa;          ELSE&#xa;            IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;              I_CAMPOS_UPD := I_CAMPOS_UPD||&apos; AND &apos;||DS_PRIM_ITEM||&apos; = &apos;||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;            ELSE&#xa;              I_CAMPOS_UPD := I_CAMPOS_UPD||&apos; AND &apos;||DS_PRIM_ITEM||&apos; = &apos;||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE);&#xa;            END IF;&#xa;          END IF;&#xa;          I_CONTADOR_UPD := I_CONTADOR_UPD + 1;&#xa;          I_WHERE        := &apos; WHERE &apos;||I_CAMPOS_UPD;&#xa;        END IF;        &#xa;      END IF;      &#xa;      EXIT WHEN V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM = V_BLOCO||&apos;.&apos;||DS_ULTI_ITEM;&#xa;      DS_PRIM_ITEM := GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,NEXTITEM);&#xa;    END LOOP;        &#xa;    --Contatena os valores que foram alterados&#xa;    IF (I_VALORES_UPD IS NOT NULL) THEN&#xa;      I_VALORES_UPD := SUBSTR(I_VALORES_UPD,1,LENGTH(I_VALORES_UPD)-2);&#xa;      I_UPDATE      := &apos;UPDATE &apos;||DS_TABELA||&apos; SET &apos;||I_VALORES_UPD||&apos; &apos;||I_WHERE||&apos;;&apos;;&#xa;      I_DS_DML      := I_UPDATE;&#xa;    END IF;  &#xa;    &#xa;    --Chama o procedimento para inserir na tabela LOGUSUARIO&#xa;    PACK_AUDITORIA.INSERE_LOGUSUARIO(I_DS_EVENTO,I_DS_DML,&apos;A&apos;);  &#xa;    &#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------------------------------------------  &#xa;  ------------------------------------------------------------------------------------------------------------------------------------------------&#xa;  &#xa;  PROCEDURE AUDITA_INSERCAO(V_BLOCO IN VARCHAR2) IS&#xa;    --Procedimento que grava os dados inseridos no Bloco&#xa;    DS_TABELA       VARCHAR2(32000);&#xa;    DS_PRIM_ITEM    VARCHAR2(32000);&#xa;    DS_ULTI_ITEM    VARCHAR2(32000);&#xa;    I_INSERT        VARCHAR2(32000);&#xa;    I_VALORES_INS   VARCHAR2(32000);&#xa;    I_REGISTRO      VARCHAR2(32000);&#xa;    I_DS_EVENTO     VARCHAR2(32000);&#xa;    I_DS_DML        VARCHAR2(32000);&#xa;    I_CAMPOS_INS    VARCHAR2(32000);&#xa;    I_CONTADOR_INS  NUMBER:=0;  &#xa;  BEGIN&#xa;    DS_TABELA         := GET_BLOCK_PROPERTY(V_BLOCO,DML_DATA_TARGET_NAME);&#xa;    DS_PRIM_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,FIRST_ITEM);&#xa;    DS_ULTI_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,LAST_ITEM);&#xa;    LOOP&#xa;      --Verifica se o campo &#xe9; uma coluna da tabela&#xa;      IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,COLUMN_NAME) IS NOT NULL THEN  &#xa;        --Busca o valor do campo e concatena a mensagem que ira aparecer no anv7              &#xa;        I_REGISTRO  := I_REGISTRO||&apos; &apos;||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,PROMPT_TEXT)||&apos; &apos;||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE);&#xa;        I_DS_EVENTO := (&apos;Inseriu na tabela &apos; || DS_TABELA || &apos; o registro &apos; || I_REGISTRO);&#xa;      END IF;&#xa;      --Verifica se foi inserido valor nessa coluna&#xa;      IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE) IS NOT NULL THEN&#xa;        IF (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;TEXT ITEM&apos;) OR&#xa;           (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;LIST&apos;) OR  &#xa;           (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;RADIO GROUP&apos;) OR &#xa;           (GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,ITEM_TYPE) = &apos;CHECK BOX&apos;) THEN&#xa;          IF I_CONTADOR_INS = 0 THEN&#xa;            I_CAMPOS_INS  := &apos; ( &apos;||DS_PRIM_ITEM;&#xa;            IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;              I_VALORES_INS := &apos; ( &apos;||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;            ELSE&#xa;              I_VALORES_INS := &apos; ( &apos;||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE);&#xa;            END IF;&#xa;          ELSE&#xa;            I_CAMPOS_INS := I_CAMPOS_INS||&apos;, &apos;||DS_PRIM_ITEM;&#xa;            IF GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATATYPE) = &apos;CHAR&apos; THEN&#xa;              I_VALORES_INS := I_VALORES_INS||&apos;, &apos;||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#xa;            ELSE&#xa;              I_VALORES_INS := I_VALORES_INS||&apos;, &apos;||GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,DATABASE_VALUE);&#xa;            END IF;&#xa;          END IF;&#xa;          I_INSERT := &apos;INSERT INTO &apos;||DS_TABELA;&#xa;        END IF;&#xa;        I_CONTADOR_INS := I_CONTADOR_INS + 1;&#xa;      END IF;&#xa;      EXIT WHEN V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM = V_BLOCO||&apos;.&apos;||DS_ULTI_ITEM;&#xa;      DS_PRIM_ITEM := GET_ITEM_PROPERTY(V_BLOCO||&apos;.&apos;||DS_PRIM_ITEM,NEXTITEM);      &#xa;    END LOOP;&#xa;    --Contatena os valores que foram inseridos&#xa;    IF (I_CAMPOS_INS IS NOT NULL) AND (I_VALORES_INS IS NOT NULL) THEN&#xa;      I_CAMPOS_INS  := I_CAMPOS_INS||&apos;)&apos;;&#xa;      I_VALORES_INS := I_VALORES_INS||&apos;)&apos;;&#xa;      I_INSERT      := I_INSERT||I_CAMPOS_INS||&apos; VALUES &apos;||I_VALORES_INS||&apos;;&apos;;&#xa;      I_DS_DML       := I_INSERT;&#xa;    END IF;&#xa;    &#xa;    --Chama o procedimento para inserir na tabela LOGUSUARIO&#xa;    PACK_AUDITORIA.INSERE_LOGUSUARIO(I_DS_EVENTO,I_DS_DML,&apos;I&apos;);  &#xa;    &#xa;  END;&#xa;  ------------------------------------------------------------------------------------------------------------------------------------------------&#xa;  ------------------------------------------------------------------------------------------------------------------------------------------------  &#xa;  ------------------------------------------------------------------------------------------------------------------------------------------------&#xa;  --Procedimento que insere as alteracoes feitas na tabela LOGUSUARIO&#xa;  PROCEDURE INSERE_LOGUSUARIO(I_DS_EVENTO   IN LOGUSUARIO.DS_EVENTO%TYPE,&#xa;                              I_DS_DML      IN LOGUSUARIO.DS_DML%TYPE   ,&#xa;                              I_TP_EVENTO   IN LOGUSUARIO.TP_EVENTO%TYPE) IS&#xa;    I_TAM_EVENTO NUMBER;&#xa;  BEGIN&#xa;    &#xa;    --Verifica qual das duas descricoes tem o tamanho maior para quebrar em duas linhas caso seja maior que 2000 caracteres&#xa;    IF LENGTH(I_DS_DML) &gt;= LENGTH(I_DS_EVENTO) THEN&#xa;      I_TAM_EVENTO := LENGTH(I_DS_DML);&#xa;    ELSE&#xa;      I_TAM_EVENTO := LENGTH(I_DS_EVENTO);&#xa;    END IF;&#xa;    IF I_DS_EVENTO IS NOT NULL THEN&#xa;       FOR I IN 1.. NVL((TRUNC(I_TAM_EVENTO / 2000) + 1),1) LOOP   &#xa;        BEGIN&#xa;          --Insere os dados no Log.&#xa;          INSERT INTO LOGUSUARIO (CD_EMPRESA,&#xa;                                  CD_USUARIO,&#xa;                                  CD_MODULO,&#xa;                                  CD_PROGRAMA,&#xa;                                  DT_EVENTO,&#xa;                                  SQ_EVENTO,&#xa;                                  HR_EVENTO,&#xa;                                  DS_EVENTO,&#xa;                                  TP_EVENTO,&#xa;                                  DS_DML)&#xa;                          VALUES (:GLOBAL.CD_EMPRESA,&#xa;                                  :GLOBAL.CD_USUARIO,&#xa;                                  :GLOBAL.CD_MODULO,&#xa;                                  :GLOBAL.CD_PROGRAMA,&#xa;                                  RETORNA_DATAHORA,&#xa;                                  SEQ_AUDITORIA.NEXTVAL,&#xa;                                  TO_CHAR(RETORNA_DATAHORA,&apos;HH24:MI&apos;),&#xa;                                  SUBSTR(I_DS_EVENTO,((I - 1) * 2000 + 1),2000),&#xa;                                  I_TP_EVENTO,&#xa;                                  SUBSTR(I_DS_DML   ,((I - 1) * 2000 + 1),2000));&#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            DEBUG_PROGRAMA(&apos;AUDITA_GRAVACAO - Erro durante tentativa de inser&#xe7;&#xe3;o na tabela LOGUSUARIO: &apos;||SQLERRM);&#xa;        END;&#xa;      END LOOP;&#xa;    END IF;&#xa;  END;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779077" FOLDED="true" MODIFIED="1607991779077" TEXT="PACK_AUDITORIA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="body">
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="PACKAGE PACK_AUDITORIA IS&#xa;&#xa;  PROCEDURE AUDITA_ATUALIZACAO(V_BLOCO IN VARCHAR2);&#xa;  ---------------------------------------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE AUDITA_INSERCAO(V_BLOCO IN VARCHAR2);&#xa;  ---------------------------------------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------------------------------------&#xa;  PROCEDURE INSERE_LOGUSUARIO(I_DS_EVENTO   IN LOGUSUARIO.DS_EVENTO%TYPE,&#xa;                              I_DS_DML      IN LOGUSUARIO.DS_DML%TYPE   ,&#xa;                              I_TP_EVENTO   IN LOGUSUARIO.TP_EVENTO%TYPE);&#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779077" FOLDED="true" MODIFIED="1607991779077" TEXT="PACK_GRAVALIBERACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="body">
<node CREATED="1607991779077" MODIFIED="1607991779077" TEXT="/** WLV:15/02/2012:40906&#xa;  * Criado para fazer a verifica&#xe7;&#xe3;o se foi alterado a solicita&#xe7;&#xe3;o de compra.&#xa;  * pois antes mesmo quando n&#xe3;o se alterava nada na solicita&#xe7;&#xe3;o ele estourava o alerta de confirma&#xe7;&#xe3;o&#xa;  */ &#xa;PACKAGE PACK_GRAVALIBERACAO IS &#xa;   TYPE R_DADOSGRAVACAO IS RECORD(CD_EMPRESA              ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                                   CD_AUTORIZADOR          ITEMCOMPRA.CD_AUTORIZADOR%TYPE,&#xa;                                   CD_TIPOCOMPRA           ITEMCOMPRA.CD_TIPOCOMPRA%TYPE,&#xa;                                   DT_DESEJADA              ITEMCOMPRA.DT_DESEJADA%TYPE,&#xa;                                   NR_LOTECOMPRA             ITEMCOMPRA.NR_LOTECOMPRA%TYPE,&#xa;                                   DT_INICIO                ITEMCOMPRA.DT_INICIO%TYPE,&#xa;                                   NR_CONTRATO             ITEMCOMPRA.NR_CONTRATO%TYPE,&#xa;                                   CD_DEPARTAMENTO         ITEMCOMPRA.CD_DEPARTAMENTO%TYPE);&#xa;                                                        &#xa;   TYPE T_DADOSGRAVACAO IS TABLE OF R_DADOSGRAVACAO INDEX BY BINARY_INTEGER;&#xa;   VET_DADOSGRAVACAO    T_DADOSGRAVACAO;&#xa;   &#xa;   PROCEDURE GRAVA_VETOR(I_CD_EMPRESA            IN ITEMCOMPRA.CD_EMPRESA%TYPE,     &#xa;                         I_CD_AUTORIZADOR       IN ITEMCOMPRA.CD_AUTORIZADOR%TYPE, &#xa;                         I_CD_TIPOCOMPRA        IN ITEMCOMPRA.CD_TIPOCOMPRA%TYPE,  &#xa;                         I_DT_DESEJADA          IN ITEMCOMPRA.DT_DESEJADA%TYPE,    &#xa;                         I_NR_LOTECOMPRA        IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,  &#xa;                         I_DT_INICIO            IN ITEMCOMPRA.DT_INICIO%TYPE,      &#xa;                         I_NR_CONTRATO          IN ITEMCOMPRA.NR_CONTRATO%TYPE,&#xa;                         I_CD_DEPARTAMENTO      IN ITEMCOMPRA.CD_DEPARTAMENTO%TYPE,&#xa;                         O_MENSAGEM             OUT VARCHAR2);   &#xa;    &#xa;    &#xa;   TYPE R2_DADOSGRAVACAO IS RECORD(CD_ITEM                   ITEMCOMPRA.CD_ITEM%TYPE,&#xa;                                   CD_MOVIMENTACAO          ITEMCOMPRA.CD_MOVIMENTACAO%TYPE,&#xa;                                   QT_PREVISTA              ITEMCOMPRA.QT_PREVISTA%TYPE,&#xa;                                   DS_OBSERVACAOEXT          ITEMCOMPRA.DS_OBSERVACAOEXT%TYPE,&#xa;                                   DS_OBSERVACAO            ITEMCOMPRA.DS_OBSERVACAO%TYPE);&#xa;                                   &#xa;   TYPE T2_DADOSGRAVACAO IS TABLE OF R2_DADOSGRAVACAO INDEX BY BINARY_INTEGER;&#xa;   VET2_DADOSGRAVACAO    T2_DADOSGRAVACAO;                               &#xa;    &#xa;    &#xa;   PROCEDURE GRAVA_VETOR_ITENS(O_MENSAGEM OUT VARCHAR2); &#xa;    &#xa;    &#xa;   PROCEDURE VERIFICA_DADOS_MODIFICADOS(RETORNO OUT BOOLEAN, O_MENSAGEM OUT VARCHAR2);&#xa;   &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="PACK_GRAVALIBERACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="/** WLV:15/02/2012:40906&#xa;  * Criado para fazer a verifica&#xe7;&#xe3;o se foi alterado a solicita&#xe7;&#xe3;o de compra.&#xa;  * pois antes mesmo quando n&#xe3;o se alterava nada na solicita&#xe7;&#xe3;o ele estourava o alerta de confirma&#xe7;&#xe3;o&#xa;  */ &#xa;PACKAGE BODY PACK_GRAVALIBERACAO IS&#xa;  &#xa;  &#xa;  PROCEDURE GRAVA_VETOR(I_CD_EMPRESA            IN ITEMCOMPRA.CD_EMPRESA%TYPE,     &#xa;                        I_CD_AUTORIZADOR        IN ITEMCOMPRA.CD_AUTORIZADOR%TYPE, &#xa;                        I_CD_TIPOCOMPRA         IN ITEMCOMPRA.CD_TIPOCOMPRA%TYPE,  &#xa;                        I_DT_DESEJADA            IN ITEMCOMPRA.DT_DESEJADA%TYPE,    &#xa;                        I_NR_LOTECOMPRA          IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,  &#xa;                        I_DT_INICIO              IN ITEMCOMPRA.DT_INICIO%TYPE,      &#xa;                        I_NR_CONTRATO           IN ITEMCOMPRA.NR_CONTRATO%TYPE,&#xa;                        I_CD_DEPARTAMENTO       IN ITEMCOMPRA.CD_DEPARTAMENTO%TYPE,&#xa;                        O_MENSAGEM             OUT VARCHAR2) IS&#xa;  BEGIN&#xa;      &#xa;    VET_DADOSGRAVACAO.DELETE;&#xa;    VET_DADOSGRAVACAO(1).CD_EMPRESA       := I_CD_EMPRESA; &#xa;    VET_DADOSGRAVACAO(1).CD_AUTORIZADOR   := I_CD_AUTORIZADOR;&#xa;    VET_DADOSGRAVACAO(1).CD_TIPOCOMPRA    := I_CD_TIPOCOMPRA;&#xa;    VET_DADOSGRAVACAO(1).DT_DESEJADA      := I_DT_DESEJADA;&#xa;    VET_DADOSGRAVACAO(1).NR_LOTECOMPRA    := I_NR_LOTECOMPRA;&#xa;    VET_DADOSGRAVACAO(1).DT_INICIO        := I_DT_INICIO;&#xa;    VET_DADOSGRAVACAO(1).NR_CONTRATO      := I_NR_CONTRATO;&#xa;    VET_DADOSGRAVACAO(1).CD_DEPARTAMENTO  := I_CD_DEPARTAMENTO;&#xa;  &#xa;  EXCEPTION    &#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM := &apos;N&#xe3;o foi poss&#xed;vel gravar vetor. &apos;||SQLERRM;  &#xa;  END;&#xa;      &#xa;  PROCEDURE GRAVA_VETOR_ITENS(O_MENSAGEM OUT VARCHAR2) IS&#xa;   V_COUNT                     NUMBER;  &#xa;   &#xa;  BEGIN&#xa;    &#xa;    VET2_DADOSGRAVACAO.DELETE;&#xa;    GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;    FIRST_RECORD;&#xa;    &#xa;    LOOP&#xa;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;        V_COUNT := NVL(VET2_DADOSGRAVACAO.LAST,0) + 1;&#xa;        VET2_DADOSGRAVACAO(V_COUNT).CD_ITEM          := :ITEMCOMPRA.CD_ITEM;&#xa;        VET2_DADOSGRAVACAO(V_COUNT).CD_MOVIMENTACAO  := :ITEMCOMPRA.CD_MOVIMENTACAO;&#xa;        VET2_DADOSGRAVACAO(V_COUNT).QT_PREVISTA      := :ITEMCOMPRA.QT_PREVISTA;  &#xa;        VET2_DADOSGRAVACAO(V_COUNT).DS_OBSERVACAOEXT := :ITEMCOMPRA.DS_OBSERVACAOEXT;  &#xa;        VET2_DADOSGRAVACAO(V_COUNT).DS_OBSERVACAO     := :ITEMCOMPRA.DS_OBSERVACAO;&#xa;      END IF;&#xa;      EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;  EXCEPTION    &#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM := &apos;N&#xe3;o foi poss&#xed;vel gravar vetor. &apos;||SQLERRM;&#xa;  END;&#xa;      &#xa;      &#xa;  PROCEDURE VERIFICA_DADOS_MODIFICADOS(RETORNO OUT BOOLEAN, O_MENSAGEM OUT VARCHAR2) IS&#xa;    V_FLAG_BLOCO1 BOOLEAN;&#xa;    V_FLAG_BLOCO2 BOOLEAN;&#xa;    &#xa;    V_COUNT  NUMBER;&#xa;  BEGIN&#xa;    V_FLAG_BLOCO1 := TRUE;&#xa;    RETORNO        := TRUE;&#xa;    GO_BLOCK(&apos;CONTROLE&apos;);&#xa;    FIRST_RECORD;&#xa;    &#xa;    IF NVL(VET_DADOSGRAVACAO(1).CD_EMPRESA,0)                                   = NVL(:CONTROLE.CD_EMPRESA,0)         AND&#xa;       NVL(VET_DADOSGRAVACAO(1).CD_AUTORIZADOR,&apos;-1&apos;)                             = NVL(:CONTROLE.CD_AUTORIZADOR,&apos;-1&apos;)  AND&#xa;       NVL(VET_DADOSGRAVACAO(1).CD_TIPOCOMPRA,&apos;-1&apos;)                             = NVL(:CONTROLE.CD_TIPOCOMPRA,&apos;-1&apos;)   AND&#xa;       NVL(VET_DADOSGRAVACAO(1).DT_DESEJADA,TO_DATE(&apos;01/01/1900&apos;,&apos;DD/MM/RRRR&apos;)) = NVL(:CONTROLE.DT_DESEJADA,TO_DATE(&apos;01/01/1900&apos;,&apos;DD/MM/RRRR&apos;))AND   &#xa;       VET_DADOSGRAVACAO(1).NR_LOTECOMPRA                                        = :CONTROLE.NR_LOTECOMPRA              AND &#xa;       NVL(VET_DADOSGRAVACAO(1).DT_INICIO,TO_DATE(&apos;01/01/1900&apos;,&apos;DD/MM/RRRR&apos;))    = NVL(:CONTROLE.DT_INICIO,TO_DATE(&apos;01/01/1900&apos;,&apos;DD/MM/RRRR&apos;))AND     &#xa;       NVL(VET_DADOSGRAVACAO(1).NR_CONTRATO,0)                                   = NVL(:CONTROLE.NR_CONTRATO,0) AND&#xa;       NVL(VET_DADOSGRAVACAO(1).CD_DEPARTAMENTO,0)                               = NVL(:CONTROLE.CD_DEPARTAMENTO,0) THEN&#xa;       &#xa;       V_FLAG_BLOCO1 := TRUE;&#xa;    ELSE&#xa;       V_FLAG_BLOCO1 := FALSE;&#xa;    END IF; &#xa;    &#xa;    V_COUNT := 0;&#xa;    V_FLAG_BLOCO2 := TRUE;&#xa;    GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;    FIRST_RECORD;&#xa;    LOOP&#xa;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;        V_COUNT := NVL(V_COUNT,0) + 1;&#xa;      END IF;&#xa;      &#xa;      FOR I IN 1..NVL(VET2_DADOSGRAVACAO.COUNT,0)LOOP&#xa;        IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;          IF VET2_DADOSGRAVACAO(I).CD_ITEM            = :ITEMCOMPRA.CD_ITEM THEN &#xa;            IF VET2_DADOSGRAVACAO(I).CD_MOVIMENTACAO  = :ITEMCOMPRA.CD_MOVIMENTACAO AND    &#xa;               VET2_DADOSGRAVACAO(I).QT_PREVISTA      = :ITEMCOMPRA.QT_PREVISTA AND&#xa;               NVL(VET2_DADOSGRAVACAO(I).DS_OBSERVACAOEXT,&apos; &apos;) = NVL(:ITEMCOMPRA.DS_OBSERVACAOEXT,&apos; &apos;) AND&#xa;               NVL(VET2_DADOSGRAVACAO(I).DS_OBSERVACAO,&apos; &apos;)    = NVL(:ITEMCOMPRA.DS_OBSERVACAO,&apos; &apos;) THEN&#xa;               NULL;&#xa;            ELSE &#xa;              V_FLAG_BLOCO2 := FALSE;&#xa;            END IF;&#xa;          END IF;&#xa;        END IF;&#xa;      END LOOP;&#xa;      EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;    &#xa;    --caso a quantidade de itens do Lote de Compra for difrente do Vetor, entende que foi inserido&#xa;    IF NVL(V_COUNT,0) &lt;&gt; NVL(VET2_DADOSGRAVACAO.COUNT,0) THEN&#xa;      V_FLAG_BLOCO2 := FALSE;&#xa;    END IF;&#xa;&#xa;    IF V_FLAG_BLOCO1 AND V_FLAG_BLOCO2 THEN&#xa;      RETORNO := TRUE;&#xa;    ELSE&#xa;      RETORNO := FALSE;&#xa;    END IF;&#xa;    &#xa;  EXCEPTION    &#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM := &apos;Erro ao verificar dados &apos;||SQLERRM;&#xa;  END;&#xa;      &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="DEFINIR_ROUND">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE DEFINIR_ROUND (I_CD_ITEM  IN  ITEMEMPRESA.CD_ITEM%TYPE,&#xa;                         O_MENSAGEM  OUT  VARCHAR2) IS&#xa;&#xa;  V_TP_UNIDMED       TIPOCALCULOPRECO.TP_UNIDMED%TYPE;&#xa;  V_CD_TIPOCALCULO  ITEMEMPRESA.CD_TIPOCALCULO%TYPE;&#xa;  E_GERAL            EXCEPTION;&#xa;  &#xa;BEGIN&#xa;  /* MGK:52401:03/12/2012&#xa;  ** Criado procedimento para controlar o arredondamento do campo QT_PREVISTA.&#xa;  */&#xa;  BEGIN&#xa;    SELECT ITEMEMPRESA.CD_TIPOCALCULO&#xa;      INTO V_CD_TIPOCALCULO&#xa;      FROM ITEMEMPRESA&#xa;     WHERE ITEMEMPRESA.CD_ITEM    = I_CD_ITEM&#xa;        AND ITEMEMPRESA.CD_EMPRESA = :CONTROLE.CD_EMPRESA;&#xa;  EXCEPTION&#xa;    WHEN NO_DATA_FOUND THEN&#xa;      V_CD_TIPOCALCULO := NULL;&#xa;      --N&#xe3;o existe um tipo de c&#xe1;lculo v&#xe1;lido para o item &#xa2;CD_ITEM&#xa2; na empresa &#xa2;CD_EMPRESA&#xa2;. Verifique TIT001, aba Empresa.&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1348, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;    WHEN TOO_MANY_ROWS THEN&#xa;      ----Mais de um Tipo de C&#xe1;lculo para o Item (&#xa2;CD_ITEM&#xa2;) e Empresa (&#xa2;CD_EMPRESA&#xa2;) encontrados. Verifique TIT001!&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12220, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;    WHEN OTHERS THEN&#xa;      --Ocorreu um erro durante a consulta dos dados do item &#xa2;CD_ITEM&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(60, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;  END;&#xa;  &#xa;  BEGIN&#xa;    SELECT TIPOCALCULOPRECO.TP_UNIDMED&#xa;      INTO V_TP_UNIDMED&#xa;      FROM TIPOCALCULOPRECO&#xa;     WHERE TIPOCALCULOPRECO.CD_TIPOCALCULO = V_CD_TIPOCALCULO;&#xa;  EXCEPTION&#xa;    WHEN NO_DATA_FOUND THEN&#xa;      V_TP_UNIDMED := NULL;&#xa;      --Unidade de medida n&#xe3;o est&#xe1; cadastrada para o item &#xa2;CD_ITEM&#xa2;. Verifique TIT001.&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(302, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;&apos;);&#xa;    WHEN TOO_MANY_ROWS THEN&#xa;      --Unidade de medida cadastrada v&#xe1;rias vezes para o item &#xa2;CD_ITEM&#xa2;. Verifique TIT001&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(303, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;&apos;);&#xa;    WHEN OTHERS THEN&#xa;      --Erro ao buscar do tipo de unidade de medida para o item &#xa2;CD_ITEM&#xa2; na empresa &#xa2;CD_EMPRMOVTO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7191, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;CD_EMPRMOVTO=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;  END;&#xa;  &#xa;  IF (V_TP_UNIDMED = &apos;1&apos;) THEN -- Item &#xe9; por peso&#xa;    NULL;&#xa;  ELSIF (V_TP_UNIDMED = &apos;2&apos;) THEN -- Item &#xe9; por qtde&#xa;    :ITEMCOMPRA.QT_PREVISTA := ROUND(:ITEMCOMPRA.QT_PREVISTA);&#xa;  ELSE&#xa;    O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(471, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;    RAISE E_GERAL;&#xa;  END IF;--IF (V_TP_UNIDMED = 1) THEN&#xa;  &#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    NULL;&#xa;    &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="CANCELAR_ITEMCOMPRA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE CANCELAR_ITEMCOMPRA (I_NR_ITEMCOMPRA  IN ITEMCOMPRA.NR_ITEMCOMPRA%TYPE,&#xa;                               I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#xa;                               I_CD_ITEM         IN ITEMCOMPRA.CD_ITEM%TYPE,&#xa;                               O_MENSAGEM       OUT VARCHAR2) IS &#xa;  &#xa;  V_COUNT_PONTOPEDIDO              NUMBER;&#xa;  V_COUNT_ITEMCOMPRACCUSTO        NUMBER;&#xa;  V_COUNT                          NUMBER;&#xa;  V_MENSAGEM                       VARCHAR2(32000);&#xa;  E_GERAL                          EXCEPTION;&#xa;  V_DADOS_ENTRADA                  PACK_PEDIDOINTERNO.R_DADOS_ENTRADA;&#xa;  V_ROW_PEDIDOINTERNOINTECOMPRA    PEDIDOINTERNOINTECOMPRA%ROWTYPE;&#xa;  V_ROW_ITEMPEDIDOINTERNO          ITEMPEDIDOINTERNO%ROWTYPE;&#xa;  V_NR_PEDIDOINTERNO              PEDIDOINTERNO.NR_PEDIDOINTERNO%TYPE;&#xa;  V_QTDE_PESO_RECALCULADO          NUMBER;&#xa;  V_CD_UNIDMEDESTQ                 VARCHAR2(10);&#xa;  V_TP_UNIDMED                    VARCHAR2(10);  &#xa;BEGIN&#xa;&#xa;  BEGIN&#xa;    UPDATE ITEMCOMPRA&#xa;       SET ITEMCOMPRA.ST_ITEMCOMPRA = 99,&#xa;           ITEMCOMPRA.DS_OBSCANCEL  = :ITEMCOMPRA.DS_OBSCANCEL&#xa;     WHERE ITEMCOMPRA.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA &#xa;       AND ITEMCOMPRA.CD_EMPRESA    = I_CD_EMPRESA;&#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      -- Erro ao Atualizar o registro da Tabela &#xa2;NM_TABELA&#xa2;. Erro &#xa2;SQLERRM&#xa2;. &#xa5;Detalhes &#xa2;DS_DETALHE&#xa2;&#xa5;.&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864, &apos;&#xa2;NM_TABELA=&apos;||&apos;ITEMCOMPRA&apos;||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;DS_DETALHE=&apos;||&apos;Houve erro ao atualizar a solicita&#xe7;&#xe3;o de Compra (&apos;||I_NR_ITEMCOMPRA||&apos;) na empresa (&apos;||I_CD_EMPRESA||&apos;).&apos;||&apos;&#xa2;&apos;); &#xa;      RAISE E_GERAL;&#xa;  END;&#xa;&#xa;  IF (:GLOBAL.ST_AUDITORIA = &apos;S&apos;) THEN&#xa;    PACK_LOGUSUARIO.AUDITAR_ATUALIZACAO (V_CD_EMPRESA  =&gt; :GLOBAL.CD_EMPRESA,&#xa;                                         V_CD_MODULO    =&gt; :GLOBAL.CD_MODULO,&#xa;                                         V_CD_PROGRAMA =&gt; :GLOBAL.CD_PROGRAMA,&#xa;                                         V_CD_USUARIO  =&gt; :GLOBAL.CD_USUARIO,&#xa;                                         V_DS_EVENTO    =&gt; &apos;O usu&#xe1;rio (&apos;||:GLOBAL.CD_USUARIO||&apos;) efetuou o cancelamento da solicita&#xe7;&#xe3;o de compra (&apos;||I_NR_ITEMCOMPRA||&apos;) na empresa (&apos;||I_CD_EMPRESA||&apos;).&apos;,&#xa;                                         V_NM_ENTIDADE =&gt; &apos;ITEMCOMPRA&apos;,&#xa;                                         V_DS_DML      =&gt; &apos;UPDATE ITEMCOMPRA&#xa;                                                              SET ITEMCOMPRA.ST_ITEMCOMPRA = 99&#xa;                                                            WHERE ITEMCOMPRA.NR_ITEMCOMPRA = &apos;||I_NR_ITEMCOMPRA||&apos; &#xa;                                                              AND ITEMCOMPRA.CD_EMPRESA    = &apos;||I_CD_EMPRESA);&#xa;  END IF; --IF (:GLOBAL.ST_AUDITORIA = &apos;S&apos;) THEN&#xa;  ----------------------------------------------&#xa;  &#xa;   BEGIN &#xa;     SELECT COUNT(*) &#xa;       INTO V_COUNT_ITEMCOMPRACCUSTO &#xa;       FROM ITEMCOMPRACCUSTO &#xa;     WHERE ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA &#xa;       AND ITEMCOMPRACCUSTO.CD_EMPRESA    = I_CD_EMPRESA; &#xa;   EXCEPTION &#xa;     WHEN OTHERS THEN &#xa;       V_COUNT_ITEMCOMPRACCUSTO := 0; &#xa;   END; &#xa;   &#xa;   IF (NVL(V_COUNT_ITEMCOMPRACCUSTO,0) &gt; 0) THEN&#xa;    BEGIN&#xa;      UPDATE ITEMCOMPRACCUSTO&#xa;         SET ITEMCOMPRACCUSTO.ST_ITEMCOMPRA = 99&#xa;       WHERE ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA &#xa;         AND ITEMCOMPRACCUSTO.CD_EMPRESA    = I_CD_EMPRESA;&#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN&#xa;        -- Erro ao Atualizar o registro da Tabela &#xa2;NM_TABELA&#xa2;. Erro &#xa2;SQLERRM&#xa2;. &#xa5;Detalhes &#xa2;DS_DETALHE&#xa2;&#xa5;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864, &apos;&#xa2;NM_TABELA=&apos;||&apos;ITEMCOMPRACCUSTO&apos;||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;DS_DETALHE=&apos;||&apos;Houve erro ao atualizar a solicita&#xe7;&#xe3;o de Compra (&apos;||I_NR_ITEMCOMPRA||&apos;) na empresa (&apos;||I_CD_EMPRESA||&apos;).&apos;||&apos;&#xa2;&apos;); &#xa;        RAISE E_GERAL;&#xa;    END;  &#xa;    &#xa;    IF (:GLOBAL.ST_AUDITORIA = &apos;S&apos;) THEN&#xa;      PACK_LOGUSUARIO.AUDITAR_ATUALIZACAO (V_CD_EMPRESA  =&gt; :GLOBAL.CD_EMPRESA,&#xa;                                           V_CD_MODULO    =&gt; :GLOBAL.CD_MODULO,&#xa;                                           V_CD_PROGRAMA =&gt; :GLOBAL.CD_PROGRAMA,&#xa;                                           V_CD_USUARIO  =&gt; :GLOBAL.CD_USUARIO,&#xa;                                           V_DS_EVENTO    =&gt; &apos;O usu&#xe1;rio (&apos;||:GLOBAL.CD_USUARIO||&apos;) efetuou o cancelamento da solicita&#xe7;&#xe3;o de compra (&apos;||I_NR_ITEMCOMPRA||&apos;) na empresa (&apos;||I_CD_EMPRESA||&apos;) e os centros de custo associados a esta solicita&#xe7;&#xe3;o de compra.&apos;,&#xa;                                           V_NM_ENTIDADE =&gt; &apos;ITEMCOMPRACCUSTO&apos;,&#xa;                                           V_DS_DML      =&gt; &apos;UPDATE ITEMCOMPRACCUSTO&#xa;                                                                SET ITEMCOMPRACCUSTO.ST_ITEMCOMPRA = 99&#xa;                                                              WHERE ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = &apos;||I_NR_ITEMCOMPRA||&apos; &#xa;                                                                AND ITEMCOMPRACCUSTO.CD_EMPRESA    = &apos;||I_CD_EMPRESA);&#xa;    END IF; --IF (:GLOBAL.ST_AUDITORIA = &apos;S&apos;) THEN&#xa;  END IF; --IF (NVL(V_COUNT_ITEMCOMPRACCUSTO,0) &gt; 0) THEN&#xa;  -------------------------------------------------------&#xa;  &#xa;  /** ALE:27/07/2013:59721&#xa;   *  Quando o par&#xe2;metro &quot;Ativar Controle de Ponto de Pedido&quot; estiver configurado na p&#xe1;gina &quot;Valida&#xe7;&#xf5;es&quot; do COM009, ser&#xe1;&#xa;   *  realizado o reprocesso de solicita&#xe7;&#xe3;o de compras.&#xa;   *&#xa;   *  O calculo que o Maxys realizar para definir o status da solicita&#xe7;&#xe3;o para &quot;Dentro do Ponto de Pedido&quot; &#xe9; o seguinte: &#xa;   *  &quot;Quantidade em estoque - Soma total das solicita&#xe7;&#xf5;es de compras com status &quot;Dentro do Ponto de Pedido&quot; - Quando solicitada &#xa;   *  na solicita&#xe7;&#xe3;o que est&#xe1; realizada no momento&quot;.&#xa;   * &#xa;   *  Se o resultado dessa f&#xf3;rmula for maior ou igual ao a quantidade configurada para o ponto de pedido do item no TIT001, &#xa;   *  a solicita&#xe7;&#xe3;o de compras ficar&#xe1; com o status &quot;Dentro do Ponto de Pedido&quot;. Se o resultado dessa f&#xf3;rmula for menor que a &#xa;   *  quantidade configurada para o ponto de pedido do item no TIT001, a solicita&#xe7;&#xe3;o ficar&#xe1; com o status &quot;Liberado&quot;. &#xa;   *&#xa;   *  No cotidiano das empresas, &#xe9; comum o estoque dos itens sofrerem altera&#xe7;&#xf5;es de seus saldos no estoque, uma vez que s&#xe3;o &#xa;   *  realizadas entradas e sa&#xed;das do item. Como o item pode sofrer essas altera&#xe7;&#xf5;es de saldo, o status da solicita&#xe7;&#xe3;o de compra &#xa;   *  que estiver dentro do ponto do pedido ou liberada para o processo de compras, pode se tornar obsoleto e para resolver &#xa;   *  esse problema, a cada altera&#xe7;&#xe3;o no estoque, os status devem ser reprocessados para representar a situa&#xe7;&#xe3;o atual da empresa.&#xa;   *&#xa;   *  O reprocesso dos status de solicita&#xe7;&#xf5;es de compras sempre ir&#xe1; ocorrer em dois momentos: &#xa;   *  - Quando a quantidade em estoque do item for atualizada (compra, venda e cancelamento de movimenta&#xe7;&#xe3;o de estoque);&#xa;   *  - Cancelamento de solicita&#xe7;&#xf5;es de compras com status &#xbf;Liberado&#xbf;, &#xbf;Em Cota&#xe7;&#xe3;o&#xbf; e &#xbf;Dentro do Ponto de Pedido&#xbf;.   &#xa;   */  &#xa;  IF (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,I_CD_EMPRESA,&apos;ST_PONTOPEDIDO&apos;),&apos;N&apos;) = &apos;S&apos;) THEN    &#xa;    BEGIN&#xa;      SELECT COUNT(ITEMCOMPRA.NR_ITEMCOMPRA)&#xa;        INTO V_COUNT_PONTOPEDIDO&#xa;        FROM ITEMCOMPRA&#xa;       WHERE ITEMCOMPRA.ST_ITEMCOMPRA IN (1,3,14)&#xa;         AND ITEMCOMPRA.CD_ITEM = I_CD_ITEM;&#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN&#xa;        V_COUNT_PONTOPEDIDO := 0;&#xa;    END;&#xa;    &#xa;    IF (NVL(V_COUNT_PONTOPEDIDO,0) &gt; 0) THEN&#xa;      PACK_COMPRAS.VERIFICA_PONTOPEDIDO (I_CD_ITEM  =&gt; I_CD_ITEM,&#xa;                                         O_MENSAGEM =&gt; V_MENSAGEM);                  &#xa;      IF (V_MENSAGEM IS NOT NULL) THEN&#xa;        RAISE E_GERAL;&#xa;      END IF; --IF (V_MENSAGEM IS NOT NULL) THEN&#xa;    END IF; --IF (NVL(V_COUNT_PONTOPEDIDO,0) &gt; 0) THEN&#xa;  END IF; --IF (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,V_CD_EMPRESA,&apos;ST_PONTOPEDIDO&apos;),&apos;N&apos;) = &apos;S&apos;) THEN  &#xa;  ---------------------------------------------------------------------------------------------------------------&#xa;  &#xa;  &#xa;  /*AUG:130776:20/02/2019*/&#xa;  BEGIN&#xa;    SELECT NR_PEDIDOINTERNO&#xa;      INTO V_NR_PEDIDOINTERNO &#xa;      FROM PEDIDOINTERNOINTECOMPRA&#xa;     WHERE PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO = :CONTROLE.CD_EMPRESA&#xa;       --AND PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO  = :PARAMETER.NR_PEDIDOINTERNO   &#xa;       AND PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA     = :ITEMCOMPRA.CD_ITEM          &#xa;       AND PEDIDOINTERNOINTECOMPRA.CD_EMPRCOMPRA     = :ITEMCOMPRA.CD_EMPRESA;&#xa;  EXCEPTION&#xa;    WHEN NO_DATA_FOUND THEN&#xa;      V_COUNT := 0;&#xa;  END;&#xa;  &#xa;  IF V_NR_PEDIDOINTERNO IS NOT NULL THEN  &#xa;    V_DADOS_ENTRADA.CD_MODULO     := :GLOBAL.CD_MODULO;   &#xa;    V_DADOS_ENTRADA.CD_PROGRAMA   := :GLOBAL.CD_PROGRAMA; &#xa;    V_DADOS_ENTRADA.CD_EMPRESA    := :GLOBAL.CD_EMPRESA;  &#xa;    V_DADOS_ENTRADA.CD_USUARIO    := :GLOBAL.CD_USUARIO;  &#xa;    V_DADOS_ENTRADA.ST_AUDITORIA  := :GLOBAL.ST_AUDITORIA;&#xa;    &#xa;    V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO := :CONTROLE.CD_EMPRESA;&#xa;    V_ROW_PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO  :=  V_NR_PEDIDOINTERNO;&#xa;    V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA     := :ITEMCOMPRA.CD_ITEM;&#xa;    V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRCOMPRA     := :ITEMCOMPRA.CD_EMPRESA;&#xa;    &#xa;    /*AUG:130776:20/02/2019*/&#xa;    PACK_PEDIDOINTERNO.CANCELA_PEDINTERNOINTECOMPRA(V_DADOS_ENTRADA,&#xa;                                                    V_ROW_PEDIDOINTERNOINTECOMPRA,&#xa;                                                    :CONTROLE.NR_LOTECOMPRA,&#xa;                                                    V_MENSAGEM);&#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;    &#xa;    BEGIN&#xa;      SELECT *&#xa;        INTO V_ROW_ITEMPEDIDOINTERNO&#xa;        FROM ITEMPEDIDOINTERNO&#xa;       WHERE ITEMPEDIDOINTERNO.CD_EMPRPEDINTERNO  = V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO&#xa;         AND ITEMPEDIDOINTERNO.NR_PEDIDOINTERNO    = V_ROW_PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO&#xa;         AND ITEMPEDIDOINTERNO.CD_ITEM            = V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA;&#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN&#xa;        O_MENSAGEM := &apos;Erro desconhecido ao alterar a tabela ITEMPEDIDOINTERNO..: &apos;||SQLERRM;&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;    &#xa;    PACK_PEDIDOINTERNO.RETORNA_UNIDMED( V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO,  &#xa;                                        V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA,&#xa;                                        V_TP_UNIDMED,&#xa;                                        V_CD_UNIDMEDESTQ);&#xa;                 &#xa;    IF NVL(V_TP_UNIDMED, &apos;1&apos;) = &apos;2&apos; AND V_CD_UNIDMEDESTQ IS NULL THEN&#xa;      PACK_PEDIDOINTERNO.VALIDA_QTDE_PESO(V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO,&#xa;                                          V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA,&#xa;                                          :ITEMCOMPRA.QT_PREVISTA,&#xa;                                          V_QTDE_PESO_RECALCULADO,&#xa;                                          &apos;Q&apos;,&#xa;                                          O_MENSAGEM);&#xa;      IF O_MENSAGEM IS NOT NULL THEN&#xa;        RAISE E_GERAL;&#xa;      END IF;          &#xa;      &#xa;      V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA := V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA - V_QTDE_PESO_RECALCULADO;&#xa;    ELSE&#xa;      PACK_PEDIDOINTERNO.VALIDA_QTDE_PESO(V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO,&#xa;                                          V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA,  &#xa;                                          V_QTDE_PESO_RECALCULADO,  &#xa;                                          :ITEMCOMPRA.QT_PREVISTA,&#xa;                                          &apos;P&apos;,&#xa;                                          O_MENSAGEM);&#xa;      IF O_MENSAGEM IS NOT NULL THEN&#xa;        RAISE E_GERAL;&#xa;      END IF;                                                     &#xa;      &#xa;      V_ROW_ITEMPEDIDOINTERNO.PS_PEDIDO := V_ROW_ITEMPEDIDOINTERNO.PS_PEDIDO - V_QTDE_PESO_RECALCULADO;&#xa;     END IF;  &#xa;    &#xa;    PACK_PEDIDOINTERNO.GRAVA_ITEMPEDIDOINTERNO(V_DADOS_ENTRADA,&#xa;                                               V_ROW_ITEMPEDIDOINTERNO,&#xa;                                               O_MENSAGEM);&#xa;    IF O_MENSAGEM IS NOT NULL THEN&#xa;      RAISE E_GERAL;&#xa;    END IF;                                    &#xa;  END IF;--IF NVL(V_COUNT,0) &gt; 0 THEN  &#xa;  /* WLV:16/02/2012:40906 - Adicionado para mostrar ao usu&#xe1;rio que o item foi cancelado*/  &#xa;  --O item &#xa2;CD_ITEM&#xa2; da solicita&#xe7;&#xe3;o de compra &#xa2;NR_ITEMCOMPRA&#xa2; da empresa &#xa2;CD_EMPRESA&#xa2; foi cancelada com sucesso. Verifique se status no COM003.&#xa;  MENSAGEM_PADRAO(16208, &apos;&#xa2;CD_ITEM=&apos;||I_CD_ITEM||&apos;&#xa2;NR_ITEMCOMPRA=&apos;||I_NR_ITEMCOMPRA||&apos;&#xa2;CD_EMPRESA=&apos;||I_CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    O_MENSAGEM := &apos;[CANCELAR_ITEMCOMPRA] - &apos;||V_MENSAGEM;&#xa;  WHEN OTHERS THEN&#xa;    O_MENSAGEM := &apos;[CANCELAR_ITEMCOMPRA] - &apos;||SQLERRM;&#xa;END CANCELAR_ITEMCOMPRA;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="VALIDA_CONTA_ORCAMENTO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE VALIDA_CONTA_ORCAMENTO(I_TRIGGER_ITEM    IN VARCHAR2, &#xa;                                 I_CD_MOVIMENTACAO IN NUMBER, &#xa;                               ---  &#xa;                                 I_CD_CENTROCUSTO  IN VARCHAR2,&#xa;                                 I_CD_NEGOCIO      IN NUMBER DEFAULT NULL ) IS                                &#xa;BEGIN&#xa;  IF PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,&apos;COMPRAS&apos;) = &apos;S&apos; AND &#xa;     PACK_ORC051.RETORNA_TIPO_ORCAMENTO(SYSDATE) = &apos;O&apos; AND &#xa;     NVL(PACK_PARMGEN.CONSULTA_PARAMETRO (&apos;ORC&apos;,50,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CONTAORCCOMPRAS&apos;),&apos;N&apos;) = &apos;S&apos; THEN      &#xa;    BEGIN&#xa;      SELECT HISTCONTB.CD_CONTACONTABIL&#xa;        INTO :CONTROLE.CD_CONTACONTABIL&#xa;        FROM PARMOVIMENT,&#xa;             HISTCONTB&#xa;       WHERE PARMOVIMENT.CD_MOVIMENTACAO = I_CD_MOVIMENTACAO&#xa;         AND PARMOVIMENT.CD_HISTCONTB     = HISTCONTB.CD_HISTCONTB;&#xa;         &#xa;      :CONTROLE.CD_CONTAORCAMENTO := NULL;&#xa;            &#xa;      BEGIN &#xa;        SELECT R.CD_CONTAORCAMENTO&#xa;          INTO :CONTROLE.CD_CONTAORCAMENTO&#xa;          FROM RELACAOCONTASORCCTB R, PLANOCONTASORCAMENTO P , PLANOCONTABIL&#xa;         WHERE R.CD_CONTACONTABIL  = :CONTROLE.CD_CONTACONTABIL                           &#xa;           AND R.CD_CONTAORCAMENTO = P.CD_CONTAORCAMENTO&#xa;           AND R.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#xa;           AND ((I_CD_CENTROCUSTO IS NOT NULL &#xa;                 AND EXISTS (SELECT PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO&#xa;                               FROM PLANOCONTASORCAMENTOCUSTO&#xa;                              WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO&#xa;                                AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO    = I_CD_CENTROCUSTO&#xa;                              )) &#xa;               OR&#xa;               (I_CD_CENTROCUSTO IS NULL &#xa;                 AND 0 = (SELECT COUNT(PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO)&#xa;                            FROM PLANOCONTASORCAMENTOCUSTO&#xa;                           WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO &#xa;                             AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO IS NULL))                                                               &#xa;                            );   &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          :CONTROLE.CD_CONTAORCAMENTO := NULL;&#xa;          MENSAGEM_PADRAO(28965, &apos;&#xa2;CD_CONTACONTABIL=&apos;||:CONTROLE.CD_CONTACONTABIL||&apos;&#xa2;CD_CENTROCUSTO=&apos;||NVL(I_CD_CENTROCUSTO,&apos;N&#xe3;o Informado&apos;)||&apos;&#xa2;&apos;);&#xa;        WHEN TOO_MANY_ROWS THEN&#xa;          LOOP&#xa;            IF SHOW_LOV(&apos;LOV_CONTAORC&apos;) THEN&#xa;              EXIT;&#xa;            END IF;&#xa;          END LOOP;              &#xa;      END;&#xa;          &#xa;      IF :CONTROLE.CD_CONTAORCAMENTO IS NOT NULL THEN&#xa;        COPY(:CONTROLE.CD_CONTAORCAMENTO, I_TRIGGER_ITEM);&#xa;      END IF;    &#xa;      &#xa;         &#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN&#xa;        NULL;&#xa;    END;    &#xa;  END IF;        &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="MANIPULA_CAMPO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE MANIPULA_CAMPO(I_DS_CAMPO IN VARCHAR2,&#xa;                         I_TIPO     IN VARCHAR2) IS&#xa;BEGIN &#xa;  IF I_TIPO = &apos;A&apos; THEN&#xa;    IF GET_ITEM_PROPERTY(I_DS_CAMPO,ENABLED) = &apos;FALSE&apos; THEN&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,ENABLED          ,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,NAVIGABLE        ,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,VISUAL_ATTRIBUTE ,&apos;VSA_CAMPOTEXTO&apos;);&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,PROMPT_FONT_STYLE,FONT_UNDERLINE);  &#xa;    END IF;  &#xa;  ELSE&#xa;    IF GET_ITEM_PROPERTY(I_DS_CAMPO,ENABLED) = &apos;TRUE&apos; THEN&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,ENABLED          ,PROPERTY_FALSE);&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,REQUIRED         ,PROPERTY_FALSE);&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,VISUAL_ATTRIBUTE ,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;      SET_ITEM_PROPERTY (I_DS_CAMPO,PROMPT_FONT_STYLE,FONT_PLAIN);&#xa;    END IF;&#xa;  END IF;        &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="PACK_GRUPO_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PACKAGE PACK_GRUPO_NEGOCIO IS&#xa;  --CENTRO CUSTO&#xa;  PROCEDURE CRIA_GRUPO_NEGOCIO;&#xa;  PROCEDURE ADICIONA_GRUPO_NEGOCIO( I_CD_EMPRCCUSTODEST IN NUMBER,&#xa;                                    I_CD_ITEM            IN NUMBER,&#xa;                                    I_CD_CENTROCUSTO    IN NUMBER,&#xa;                                    I_CD_MOVIMENTACAO   IN NUMBER,&#xa;                                    I_CD_AUTORIZADOR    IN VARCHAR2,&#xa;                                    I_QT_PEDIDAUNIDSOL  IN NUMBER,&#xa;                                     I_PC_PARTICIPACAO   IN NUMBER,&#xa;                                     I_CD_NEGOCIO        IN NUMBER,&#xa;                                     I_DS_OBSERVACAO     IN VARCHAR2,&#xa;                                     I_CD_CONTAORCAMENTO IN NUMBER);&#xa;                              &#xa;  PROCEDURE DELETA_GRUPO_NEGOCIO  (I_CD_ITEM    IN NUMBER);&#xa;  PROCEDURE CARREGA_DADOS_NEGOCIO (I_CD_ITEM    IN NUMBER);&#xa;  &#xa;&#xa;  --LOVS DO CENTRO DE CUSTO&#xa;  /*PROCEDURE CRIA_GRUPO_LOVCC;&#xa;  PROCEDURE ADICIONA_GRUPO_LOVCC(I_CD_ITEM     IN NUMBER,&#xa;                                  I_CD_CENTROCUSTO  IN NUMBER,&#xa;                                 I_PC_PARTICIPACAO IN NUMBER);&#xa;  PROCEDURE DELETA_GRUPO_LOVCC;*/&#xa;&#xa;  --PROCEDURE CARREGA_DADOS_NG (I_CD_ITEM    IN NUMBER);  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="PACK_GRUPO_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PACKAGE BODY PACK_GRUPO_NEGOCIO IS&#xa;-----------------------------------------------------------------------------&#xa;-----------------------------------------------------------------------------&#xa;                             -- CENTRO CUSTO --&#xa;-----------------------------------------------------------------------------&#xa;-----------------------------------------------------------------------------&#xa;  PROCEDURE CRIA_GRUPO_NEGOCIO IS&#xa;    GRP_REPLICA RECORDGROUP;&#xa;    COL_REPLICA GROUPCOLUMN;&#xa;  BEGIN&#xa;    GRP_REPLICA := FIND_GROUP(&apos;GRUPO_NEGOCIO&apos;);&#xa;    IF NOT ID_NULL(GRP_REPLICA) THEN &#xa;      DELETE_GROUP(GRP_REPLICA); &#xa;    END IF;&#xa;    &#xa;    GRP_REPLICA := CREATE_GROUP(&apos;GRUPO_NEGOCIO&apos;);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;CD_ITEM&apos;          , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;CD_CENTROCUSTO&apos;   , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;CD_NEGOCIO&apos;       , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;CD_MOVIMENTACAO&apos;  , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;CD_AUTORIZADOR&apos;   , CHAR_COLUMN,4);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;QT_PEDIDAUNIDSOL&apos; , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;PC_PARTICIPACAO&apos;  , NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;CD_EMPRCCUSTODEST&apos;, NUMBER_COLUMN);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;DS_OBSERVACAO&apos;    , CHAR_COLUMN,150);&#xa;    COL_REPLICA := ADD_GROUP_COLUMN(&apos;GRUPO_NEGOCIO&apos;, &apos;CD_CONTAORCAMENTO&apos;, NUMBER_COLUMN);&#xa;    &#xa;  END CRIA_GRUPO_NEGOCIO;&#xa;  ---------------------------------------------------------------------------------------------&#xa;  &#xa;  PROCEDURE ADICIONA_GRUPO_NEGOCIO( I_CD_EMPRCCUSTODEST IN NUMBER,&#xa;                                    I_CD_ITEM            IN NUMBER,&#xa;                                    I_CD_CENTROCUSTO    IN NUMBER,&#xa;                                    I_CD_MOVIMENTACAO   IN NUMBER,&#xa;                                    I_CD_AUTORIZADOR    IN VARCHAR2,&#xa;                                    I_QT_PEDIDAUNIDSOL  IN NUMBER,&#xa;                                     I_PC_PARTICIPACAO   IN NUMBER,&#xa;                                     I_CD_NEGOCIO        IN NUMBER/*CSL:21/12/2010:30317*/,&#xa;                                     I_DS_OBSERVACAO     IN VARCHAR2,&#xa;                                     I_CD_CONTAORCAMENTO IN NUMBER) IS&#xa;  BEGIN&#xa;    ADD_GROUP_ROW(&apos;GRUPO_NEGOCIO&apos;,END_OF_GROUP);&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_EMPRCCUSTODEST&apos;, GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_CD_EMPRCCUSTODEST);--GDG:22/07/2011:28715&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_ITEM&apos;          , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_CD_ITEM         );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_CENTROCUSTO&apos;   , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_CD_CENTROCUSTO  );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_NEGOCIO&apos;       , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_CD_NEGOCIO      );/*CSL:21/12/2010:30317*/&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_MOVIMENTACAO&apos;  , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_CD_MOVIMENTACAO );&#xa;    SET_GROUP_CHAR_CELL  (&apos;GRUPO_NEGOCIO.CD_AUTORIZADOR&apos;   , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_CD_AUTORIZADOR  );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.QT_PEDIDAUNIDSOL&apos; , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_QT_PEDIDAUNIDSOL);&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.PC_PARTICIPACAO&apos;  , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_PC_PARTICIPACAO );&#xa;    SET_GROUP_CHAR_CELL  (&apos;GRUPO_NEGOCIO.DS_OBSERVACAO&apos;    , GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_DS_OBSERVACAO   );&#xa;    SET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_CONTAORCAMENTO&apos;, GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;), I_CD_CONTAORCAMENTO);&#xa;    &#xa;  END ADICIONA_GRUPO_NEGOCIO;&#xa;  ---------------------------------------------------------------------------------------------&#xa;  PROCEDURE DELETA_GRUPO_NEGOCIO( I_CD_ITEM IN NUMBER ) IS&#xa;    NR_REG NUMBER;&#xa;    NR_TOT NUMBER;&#xa;  BEGIN&#xa;    &#xa;    LOOP&#xa;      NR_TOT := GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;);&#xa;      NR_REG := 0;&#xa;      FOR I IN 1 ..GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;) LOOP&#xa;        NR_REG := NR_REG + 1;&#xa;        IF GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_ITEM&apos;, I) = I_CD_ITEM THEN&#xa;          DELETE_GROUP_ROW(&apos;GRUPO_NEGOCIO&apos;, I);&#xa;          EXIT;&#xa;        END IF;&#xa;      END LOOP;&#xa;      EXIT WHEN NR_TOT = NR_REG;&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;  END DELETA_GRUPO_NEGOCIO;&#xa;  &#xa;  ---------------------------------------------------------------------------------------------&#xa;  PROCEDURE CARREGA_DADOS_NEGOCIO (I_CD_ITEM IN NUMBER) IS&#xa;  I_EXISTE   BOOLEAN;&#xa;  BEGIN  &#xa;    I_EXISTE := FALSE;&#xa;    GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    FIRST_RECORD;    &#xa;    IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN &#xa;      FOR I IN 1..GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;) LOOP&#xa;        IF NVL(GET_GROUP_ROW_COUNT(&apos;GRUPO_NEGOCIO&apos;),0) &gt; 0 THEN&#xa;          IF I_CD_ITEM = GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_ITEM&apos;, I) THEN&#xa;            :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST := GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_EMPRCCUSTODEST&apos;, I);&#xa;            :ITEMCOMPRANEGOCIO.CD_ITEM            := GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_ITEM&apos;           , I);&#xa;           -- :ITEMCOMPRANEGOCIO.CD_CENTROCUSTO    := GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_CENTROCUSTO&apos;   , I);&#xa;            :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_MOVIMENTACAO&apos;  , I);&#xa;            --:ITEMCOMPRANEGOCIO.CD_AUTORIZADOR    := GET_GROUP_CHAR_CELL  (&apos;GRUPO_NEGOCIO.CD_AUTORIZADOR&apos;   , I);&#xa;            :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.PC_PARTICIPACAO&apos;  , I);&#xa;            :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.QT_PEDIDAUNIDSOL&apos; , I);&#xa;            :ITEMCOMPRANEGOCIO.CD_NEGOCIO         := GET_GROUP_NUMBER_CELL(&apos;GRUPO_NEGOCIO.CD_NEGOCIO&apos;       , I);&#xa;            :ITEMCOMPRANEGOCIO.DS_OBSERVACAO     := GET_GROUP_CHAR_CELL  (&apos;GRUPO_NEGOCIO.DS_OBSERVACAO&apos;    , I);&#xa;            I_EXISTE := TRUE;&#xa;            NEXT_RECORD;&#xa;          END IF;&#xa;        END IF;&#xa;      END LOOP;&#xa;      FIRST_RECORD;&#xa;    ELSE --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN  /*ATR:80785:11/02/2015*/&#xa;      FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.COUNT LOOP&#xa;        IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.COUNT &gt; 0 THEN&#xa;          IF :ITEMCOMPRA.CD_EMPRESA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_EMPRESA AND&#xa;            :ITEMCOMPRA.NR_ITEMCOMPRA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).NR_ITEMCOMPRA THEN    &#xa;            :ITEMCOMPRANEGOCIO.CD_ITEM            :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_ITEM;    &#xa;            :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST  :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_EMPRCCUSTODEST;          &#xa;            --:ITEMCOMPRANEGOCIO.CD_CENTROCUSTO     :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_CENTROCUSTO;         &#xa;            :ITEMCOMPRANEGOCIO.CD_NEGOCIO           :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_NEGOCIO;                &#xa;            :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO     :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_MOVIMENTACAO;          &#xa;            :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).QT_PEDIDAUNIDSOL;       &#xa;            :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).PC_PARTICIPACAO;&#xa;            I_EXISTE := TRUE;    &#xa;            NEXT_RECORD;&#xa;          END IF;&#xa;        END IF; --IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT &gt; 0 THEN&#xa;      END LOOP; --FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#xa;      FIRST_RECORD;&#xa;    END IF; --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN   &#xa;    &#xa;    IF NOT I_EXISTE THEN&#xa;      IF  :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#xa;        :ITEMCOMPRANEGOCIO.CD_NEGOCIO :=  :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#xa;        GO_ITEM(&apos;ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL&apos;);&#xa;      END IF;&#xa;     ELSE&#xa;      GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_NEGOCIO&apos;);&#xa;    END IF;  &#xa;  END;&#xa;  &#xa; &#xa;&#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="VALIDA_DUPLICADOS_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE VALIDA_DUPLICADOS_NEGOCIO (O_MENSAGEM    OUT VARCHAR2) IS&#xa;&#xa;  V_NR_REGISTRO     NUMBER;&#xa;  V_CD_NEGOCIO      ITEMCOMPRACCUSTO.CD_NEGOCIO%TYPE; /*CSL:22/12/2010:30317*/&#xa;  V_MENSAGEM        VARCHAR2(32000);&#xa;  E_GERAL            EXCEPTION;&#xa;  V_CD_EMPRCCUSTODEST  EMPRESA.CD_EMPRESA%TYPE;&#xa;BEGIN&#xa;  &#xa;  GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;  FIRST_RECORD;&#xa;  LOOP&#xa;    V_NR_REGISTRO    := :SYSTEM.CURSOR_RECORD;&#xa;    --V_CD_CENTROCUSTO := :ITEMCOMPRANEGOCIO.CD_CENTROCUSTO;&#xa;    V_CD_NEGOCIO     := :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#xa;    --GDG:22/07/2011:28715    &#xa;    V_CD_EMPRCCUSTODEST := NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST, :ITEMCOMPRANEGOCIO.CD_EMPRESA);&#xa;    FIRST_RECORD;&#xa;    LOOP&#xa;      IF (V_NR_REGISTRO &lt;&gt; :SYSTEM.CURSOR_RECORD) THEN&#xa;        IF V_CD_NEGOCIO = :ITEMCOMPRANEGOCIO.CD_NEGOCIO/*&#xa;          AND V_CD_EMPRCCUSTODEST = NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST, :ITEMCOMPRANEGOCIO.CD_EMPRESA)*/ THEN&#xa;          --V_MENSAGEM := &apos;O Centro de Custo (&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;) e o Neg&#xf3;cio (&apos;||:ITEMCOMPRACCUSTO.CD_NEGOCIO||&apos;) do registro atual (&apos;||:SYSTEM.CURSOR_RECORD||&apos;) &#xe9; igual ao do registro (&apos;||V_NR_REGISTRO||&apos;). Por favor verifique e altere.&apos;; &#xa;          --V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6353,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRACCUSTO.CD_NEGOCIO||&apos;&#xa2;NR_REGATUAL=&apos;||:SYSTEM.CURSOR_RECORD||&apos;&#xa2;NR_REGISTRO=&apos;||V_NR_REGISTRO||&apos;&#xa2;&apos;);--O Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2; e o Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; do registro atual &#xa2;NR_REGATUAL&#xa2; &#xe9; igual ao do registro &#xa2;NR_REGISTRO&#xa2;. Por favor verifique e altere. &#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(16603, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRANEGOCIO.CD_ITEM||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;      END IF;&#xa;     &#xa;      EXIT WHEN (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;);&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;    &#xa;    GO_RECORD(V_NR_REGISTRO);&#xa;    EXIT WHEN (:SYSTEM.LAST_RECORD = &apos;TRUE&apos;);&#xa;    NEXT_RECORD;&#xa;  END LOOP;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    O_MENSAGEM := V_MENSAGEM; &#xa;  WHEN OTHERS THEN&#xa;    O_MENSAGEM := SQLERRM;   &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="ADICIONA_GRUPO_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE ADICIONA_GRUPO_NEGOCIO IS&#xa;BEGIN      &#xa;  --Adiciona novas linhas no grupo com os dados do bloco e nr_registro = :GLOBAL.NR_REGISTRO&#xa;  GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;  FIRST_RECORD;&#xa;  --Deleta o quem tem no grupo com nr_registro = :GLOBAL.NR_REGISTRO&#xa;  PACK_GRUPO_NEGOCIO.DELETA_GRUPO_NEGOCIO(:ITEMCOMPRANEGOCIO.CD_ITEM);&#xa;  &#xa;  FIRST_RECORD;&#xa;  LOOP&#xa;    IF :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#xa;      PACK_GRUPO_NEGOCIO.ADICIONA_GRUPO_NEGOCIO(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST,--GDG:22/07/2011:28715&#xa;                                   :ITEMCOMPRANEGOCIO.CD_ITEM,&#xa;                                   NULL, --:ITEMCOMPRANEGOCIO.CD_CENTROCUSTO,&#xa;                                   :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO,&#xa;                                   NULL, --:ITEMCOMPRANEGOCIO.CD_AUTORIZADOR,&#xa;                                   :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL,&#xa;                                    :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO,&#xa;                                    :ITEMCOMPRANEGOCIO.CD_NEGOCIO,&#xa;                                    :ITEMCOMPRANEGOCIO.DS_OBSERVACAO,&#xa;                                    :ITEMCOMPRANEGOCIO.CD_CONTAORCAMENTO);&#xa;    END IF;&#xa;    EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;    NEXT_RECORD;  &#xa;  END LOOP;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="IMPORTA_ARQUIVO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE IMPORTA_ARQUIVO(O_MENSAGEM OUT VARCHAR2) IS&#xa;  E_GERAL EXCEPTION;      &#xa;  V_CMD              VARCHAR2(32000);&#xa;  V_CAMINHOARQUIVO  VARCHAR2(32000);&#xa;BEGIN&#xa;  -- valida insta&#xe7;&#xe3;o do aplicativo&#xa;  PACK_ARQUIVOUTILS.VALIDA_ARQUIVOSERVIDOR(:GLOBAL.VL_UNCMAXYS||&apos;\LeitorArquivos\LeitorArquivos.exe&apos;, O_MENSAGEM);&#xa;  IF O_MENSAGEM IS NOT NULL THEN&#xa;    RETURN;      &#xa;  END IF;&#xa;  &#xa;  MENSAGEM(&apos;Maxys&apos;,&apos;Processando Arquivo (&apos;||RETORNA_NOME_ARQUIVO(REPLACE(:ITEMCOMPRACCUSTO.DS_CAMINHO,&apos;\&apos;,&apos;/&apos;))||&apos;). Aguarde...&apos;, 4);&#xa;  SYNCHRONIZE;&#xa;  &#xa;  V_CAMINHOARQUIVO := :ITEMCOMPRACCUSTO.DS_CAMINHO;&#xa;  IF WEBUTIL_FILE_TRANSFER.CLIENT_TO_AS(:ITEMCOMPRACCUSTO.DS_CAMINHO,&#xa;                                        :GLOBAL.VL_REPORTPATH||&apos;\&apos;||RETORNA_NOMEARQUIVO(:ITEMCOMPRACCUSTO.DS_CAMINHO)) THEN&#xa;    V_CAMINHOARQUIVO := :GLOBAL.VL_REPORTPATH||&apos;\&apos;||RETORNA_NOMEARQUIVO(:ITEMCOMPRACCUSTO.DS_CAMINHO);&#xa;  END IF;&#xa;  &#xa;  --Chama o leitor&#xa;  V_CMD := :GLOBAL.VL_UNCMAXYS||&apos;\LeitorArquivos\LeitorArquivos.exe  --base &apos;||PACK_SESSAO.VL_CURRENTHOST||&apos; &apos;||--nome da base&#xa;                                                                   &apos; --modulo &apos;||:GLOBAL.CD_MODULO||&#xa;                                                                   &apos; --programa &apos;||:GLOBAL.CD_PROGRAMA||&#xa;                                                                   &apos; --usuario &apos;||:GLOBAL.CD_USUARIO||&#xa;                                                                   &apos; --sid &apos;||PACK_SESSAO.RETORNA_SID||&apos; &apos;||--id da conex&#xe3;o do usu&#xe1;rio&#xa;                                                                   &apos; --caminhoArquivo &quot;&apos;||V_CAMINHOARQUIVO||&apos;&quot; &apos;||--caminho completo do arquivo&#xa;                                                                   &apos; --usuarioBanco=&apos;||PACK_SESSAO.VL_CURRENTSCHEMA||&#xa;                                                                   &apos; --layout &apos;||:CONTROLE.CD_LAYOUT; --c&#xf3;digo do layout da tabela LAYOUTARQUIVO&#xa;  &#xa;  HOST_SERVIDOR(V_CMD, NO_SCREEN);    &#xa;  &#xa;  IF O_MENSAGEM IS NULL THEN&#xa;    IF WEBUTIL_FILE_TRANSFER.AS_TO_CLIENT(:GLOBAL.VL_REPORTPATHCLIENT||&apos;\&apos;||RETORNA_NOMEARQUIVO(V_CAMINHOARQUIVO),&#xa;                                          V_CAMINHOARQUIVO) THEN&#xa;      V_CAMINHOARQUIVO := :GLOBAL.VL_REPORTPATHCLIENT||&apos;\&apos;||RETORNA_NOMEARQUIVO(V_CAMINHOARQUIVO);&#xa;    END IF;&#xa;    --PACK_ARQUIVOUTILS.VISUALIZA_ARQUIVO(V_CAMINHOARQUIVO, O_MENSAGEM);&#xa;    IF O_MENSAGEM IS NOT NULL THEN &#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;  END IF;  &#xa;  &#xa;    GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    :CONTROLE.DS_LOG := NULL;&#xa;     CARREGA_PLANILHA_CENTROCUSTO(O_MENSAGEM);    &#xa;    IF(O_MENSAGEM IS NOT NULL)THEN       &#xa;       GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;      CLEAR_BLOCK(NO_VALIDATE);         &#xa;      CENTRALIZA_FORM(&apos;WIN_ITEMCOMPRA&apos;,&apos;WIN_IMPORTACAOLOG&apos;);    &#xa;      MENSAGEM_PADRAO(32755,NULL);&#xa;      GO_ITEM(&apos;CONTROLE.BTN_VOLTARLOG&apos;);  &#xa;    RAISE E_GERAL;&#xa;   END IF;&#xa;&#xa;  &#xa;  IF O_MENSAGEM IS NOT NULL THEN&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;  &#xa;  GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;  FIRST_RECORD;&#xa;  &#xa;  CLEAR_MESSAGE;&#xa;  SYNCHRONIZE;&#xa;                    &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    CLEAR_MESSAGE;&#xa;    O_MENSAGEM := &apos;&#xa5;IMPORTA_ARQUIVO&#xa5;&apos;||O_MENSAGEM;&#xa;  WHEN OTHERS THEN&#xa;    /*Ocorreu um erro inesperado. Erro &#xa2;SQLERRM&#xa2;.&#xa5;Detalhes: &#xa2;DS_DETALHES&#xa2;&#xa5;.*/&#xa;    O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8388, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;DS_DETALHES=IMPORTA_ARQUIVO&#xa2;&apos;);&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="RETORNA_NOME_ARQUIVO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="FUNCTION RETORNA_NOME_ARQUIVO(I_DS_CAMINHO VARCHAR2) RETURN VARCHAR2 IS&#xa;BEGIN&#xa;  RETURN SUBSTR(I_DS_CAMINHO,INSTR(I_DS_CAMINHO,&apos;/&apos;,-1,1)+1,LENGTH(I_DS_CAMINHO));&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779078" FOLDED="true" MODIFIED="1607991779078" TEXT="CARREGA_PLANILHA_CENTROCUSTO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="body">
<node CREATED="1607991779078" MODIFIED="1607991779078" TEXT="PROCEDURE CARREGA_PLANILHA_CENTROCUSTO(O_MENSAGEM OUT VARCHAR2) IS           &#xa;  GRUPO              RECORDGROUP;&#xa;  ERRO                    NUMBER;&#xa;  V_CONSULTA              VARCHAR2(32000);  &#xa;  V_NR_LINHAINI            NUMBER := 0;  &#xa;  V_CD_MOVIMENTACAO        ITEMCOMPRACCUSTO.CD_MOVIMENTACAO%TYPE;  &#xa;  V_MENSAGEM               VARCHAR2(32000);    &#xa;  V_CD_CENTROCUSTO        VARCHAR2(10);&#xa;    -- adiciona lunha de log&#xa;  PROCEDURE ADD_LOG(I_NR_LINHA IN NUMBER, I_DS_LOG   IN VARCHAR2) IS&#xa;    V_LENGTH NUMBER;&#xa;  BEGIN&#xa;    V_LENGTH := LENGTH(:CONTROLE.DS_LOG);&#xa;    IF NVL(V_LENGTH,0) + LENGTH(&apos;Linha &apos;||LPAD(V_NR_LINHAINI+I_NR_LINHA,3,&apos;0&apos;)||&apos;: &apos;||I_DS_LOG|| CHR(10)) &gt; 32676 THEN&#xa;      NULL;&#xa;    ELSE  &#xa;      :CONTROLE.DS_LOG := :CONTROLE.DS_LOG || &apos;Linha &apos;||LPAD(V_NR_LINHAINI+I_NR_LINHA,3,&apos;0&apos;)||&apos;: &apos;||I_DS_LOG|| CHR(10);&#xa;    END IF;  &#xa;  END;    &#xa;&#xa;BEGIN  &#xa;&#xa;  &#xa; V_CONSULTA :=&apos;SELECT ROWNUM NR_LINHA,&#xa;               RETORNA_VALORSTRING(DS_LINHA, 01, &apos;&apos;&#xa2;&apos;&apos;) CD_CENTROCUSTO,  &#xa;               RETORNA_VALORSTRING(DS_LINHA, 02, &apos;&apos;&#xa2;&apos;&apos;) PC_PARTICIPACAO,   &#xa;               RETORNA_VALORSTRING(DS_LINHA, 03, &apos;&apos;&#xa2;&apos;&apos;) CD_EMPRESA,  &#xa;               RETORNA_VALORSTRING(DS_LINHA, 04, &apos;&apos;&#xa2;&apos;&apos;) CD_NEGOCIO,         &#xa;               RETORNA_VALORSTRING(DS_LINHA, 05, &apos;&apos;&#xa2;&apos;&apos;) CD_MOVIMENTACAO,     &#xa;               RETORNA_VALORSTRING(DS_LINHA, 06, &apos;&apos;&#xa2;&apos;&apos;) QT_PARTICIPACAO,&#xa;               DS_LINHA    &#xa;            FROM PARMREPORTSTMP&#xa;           WHERE PARMREPORTSTMP.CD_MODULO   = &apos;||QUOTES(:GLOBAL.CD_MODULO)||&apos;&#xa;             AND PARMREPORTSTMP.CD_PROGRAMA = &apos;||:GLOBAL.CD_PROGRAMA||&apos;&#xa;             AND PARMREPORTSTMP.CD_USUARIO   = &apos;||QUOTES(:GLOBAL.CD_USUARIO)||&apos;&#xa;             AND PARMREPORTSTMP.NR_SID       = &apos;||PACK_SESSAO.RETORNA_SID;  &#xa;  GRUPO := FIND_GROUP(&apos;GRUPO&apos;);&#xa;  &#xa;  IF NOT ID_NULL(GRUPO) THEN&#xa;    DELETE_GROUP(GRUPO);&#xa;  END IF;&#xa;&#xa;  GRUPO := CREATE_GROUP_FROM_QUERY(&apos;GRUPO&apos;, V_CONSULTA);&#xa;  ERRO   := POPULATE_GROUP(GRUPO);&#xa;&#xa;  IF ERRO = 1403 THEN&#xa;    --A consulta n&#xe3;o retornou dados.&#xa;     O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12065, NULL);&#xa;    RETURN; &#xa;  ELSIF ERRO NOT IN (0,1403) THEN&#xa;    --Ocorreu um erro ao realizar a consulta conforme filtros/par&#xe2;metros informados. Erro: &#xa2;SQLERRM&#xa2;.&#xa;    O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(25697, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RETURN;      &#xa;  END IF;&#xa;&#xa;  &#xa;  GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;  CLEAR_BLOCK(NO_VALIDATE);&#xa;  FIRST_RECORD;&#xa;  FOR I IN 1..GET_GROUP_ROW_COUNT(&apos;GRUPO&apos;) LOOP&#xa;  BEGIN    &#xa;    BEGIN            &#xa;      --Realiza a valida&#xe7;&#xe3;o antes de inserir as colunas.&#xa;      IF GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_CENTROCUSTO&apos;,I) IS NOT NULL THEN      &#xa;        V_CD_CENTROCUSTO := REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_CENTROCUSTO&apos;,I),&apos;.&apos;,&apos;&apos;);            &#xa;        :ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO := NULL;&#xa;        :ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO     := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_NEGOCIO&apos;,I),&apos;.&apos;,&apos;&apos;));&#xa;        IF(:ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO &lt;&gt; 0)THEN&#xa;          :ITEMCOMPRACCUSTO.ST_NEGOCIOPLANILHA  := &apos;S&apos;;&#xa;        END IF;  &#xa;        VALIDA_CENTROCUSTO(TO_NUMBER(V_CD_CENTROCUSTO),  :ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO,V_MENSAGEM);&#xa;        IF(V_MENSAGEM IS NOT NULL) THEN &#xa;          ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),V_MENSAGEM);  &#xa;        ELSE                                                                     &#xa;          :ITEMCOMPRACCUSTO.CD_CENTROCUSTO     := TO_NUMBER(V_CD_CENTROCUSTO);                                              &#xa;          :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_EMPRESA&apos;,I),&apos;.&apos;,&apos;&apos;));                         &#xa;          &#xa;            :ITEMCOMPRACCUSTO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#xa;            :ITEMCOMPRACCUSTO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#xa;            :ITEMCOMPRACCUSTO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#xa;            :ITEMCOMPRACCUSTO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#xa;            :ITEMCOMPRACCUSTO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;                  &#xa;                    &#xa;          &#xa;          IF TO_NUMBER(GET_GROUP_CHAR_CELL(&apos;GRUPO.PC_PARTICIPACAO&apos;,I)) IS NULL THEN  &#xa;            --O percentual  de participa&#xe7;&#xe3;o deve ser informado.&#xa;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3720, NULL);     &#xa;            ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),V_MENSAGEM);          &#xa;          ELSIF TO_NUMBER(GET_GROUP_CHAR_CELL(&apos;GRUPO.PC_PARTICIPACAO&apos;,I)) &gt; 100 &#xa;             OR TO_NUMBER(GET_GROUP_CHAR_CELL(&apos;GRUPO.PC_PARTICIPACAO&apos;,I)) &lt;= 0  THEN&#xa;          --Total do Percentual de Participa&#xe7;&#xe3;o deve estar entre 0 e 100%.&#xa;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32801, NULL);           &#xa;             ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),V_MENSAGEM);&#xa;          ELSE            &#xa;            :ITEMCOMPRACCUSTO.PC_PARTICIPACAO     := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.PC_PARTICIPACAO&apos;,I),&apos;.&apos;,&apos;&apos;));             &#xa;            &#xa;            IF :ITEMCOMPRACCUSTO.PC_PARTICIPACAO &lt;&gt; 0  THEN                          &#xa;              :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO / 100 ,3);                        &#xa;            END IF;              &#xa;              V_CD_MOVIMENTACAO := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_MOVIMENTACAO&apos;,I),&apos;.&apos;,&apos;&apos;));                         &#xa;               --Caso exista problema ao buscar a movimenta&#xe7;&#xe3;o &#xe9; considerada a movimenta&#xe7;&#xe3;o da informada na tela inicial.&#xa;               IF V_CD_MOVIMENTACAO &lt;&gt; 0 AND V_CD_MOVIMENTACAO IS NOT NULL  THEN            &#xa;                VALIDA_MOV_IMP(V_CD_MOVIMENTACAO,V_MENSAGEM);                           &#xa;                IF(V_MENSAGEM IS NOT NULL)THEN&#xa;                  :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO     :=   :ITEMCOMPRA.CD_MOVIMENTACAO;  &#xa;                ELSE  &#xa;                   :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO     := ZVL(TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_MOVIMENTACAO&apos;,I),&apos;.&apos;,&apos;&apos;)),:ITEMCOMPRA.CD_MOVIMENTACAO);                           &#xa;                END IF;&#xa;                ELSE &#xa;                  :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO     :=   :ITEMCOMPRA.CD_MOVIMENTACAO;  &#xa;              END IF;              &#xa;            &#xa;          IF TO_NUMBER(GET_GROUP_CHAR_CELL(&apos;GRUPO.QT_PARTICIPACAO&apos;,I)) &lt; 0 THEN&#xa;            --O Peso ou Quantidade do item do pedido n&#xe3;o pode ser negativo.&#xa;            V_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(3282, NULL);&#xa;            ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),V_MENSAGEM);  &#xa;          ELSE &#xa;            IF TO_NUMBER(GET_GROUP_CHAR_CELL(&apos;GRUPO.QT_PARTICIPACAO&apos;,I)) IS NOT NULL THEN&#xa;              :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL    := ZVL(TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.QT_PARTICIPACAO&apos;,I),&apos;.&apos;,&apos;&apos;)), :ITEMCOMPRA.QT_PREVISTA);                        &#xa;            END IF;  &#xa;          END IF;              &#xa;          IF TO_NUMBER(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_NEGOCIO&apos;,I)) IS NOT NULL THEN            &#xa;            VALIDA_NEGOCIO_IMP(TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_NEGOCIO&apos;,I),&apos;.&apos;,&apos;&apos;)),V_MENSAGEM);           &#xa;            IF (V_MENSAGEM IS NOT NULL)THEN                      &#xa;              ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),V_MENSAGEM);  &#xa;            ELSE &#xa;              :ITEMCOMPRACCUSTO.CD_NEGOCIO  := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_NEGOCIO&apos;,I),&apos;.&apos;,&apos;&apos;));              &#xa;            END IF;  &#xa;          END IF;                  &#xa;            END IF;                &#xa;        END IF;                &#xa;        ELSE           &#xa;          V_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(292, NULL);&#xa;          ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),V_MENSAGEM);  &#xa;        END IF; --IF TO_NUMBER(GET_GROUP_CHAR_CELL(&apos;GRUPO.CD_CENTROCUSTO&apos;,I)) IS NOT NULL THEN    &#xa;              &#xa;    EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;        ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),&apos;Erro ao inserir registros&apos;);&#xa;    END;          &#xa;                       &#xa;    EXCEPTION &#xa;      WHEN OTHERS THEN&#xa;        --Ocorreu erro no processamento do arquivo. Erro: &#xa2;SQLERRM&#xa2;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(26848, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        ADD_LOG(GET_GROUP_NUMBER_CELL(&apos;GRUPO.NR_LINHA&apos;,I),V_MENSAGEM);&#xa;    END;      &#xa;    IF(:CONTROLE.DS_LOG IS NULL)THEN&#xa;    -- EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;      NEXT_RECORD;&#xa;    END IF;  &#xa;    &#xa;  END LOOP;&#xa;  &#xa;  &#xa;  BEGIN&#xa;    DELETE FROM PARMREPORTSTMP&#xa;    WHERE PARMREPORTSTMP.CD_MODULO   = :GLOBAL.CD_MODULO&#xa;      AND PARMREPORTSTMP.CD_PROGRAMA = :GLOBAL.CD_PROGRAMA&#xa;      AND PARMREPORTSTMP.CD_USUARIO  = :GLOBAL.CD_USUARIO               &#xa;      AND PARMREPORTSTMP.NR_SID      = PACK_SESSAO.RETORNA_SID;    &#xa;    FAZ_COMMIT;&#xa;    &#xa;    &#xa;  IF :CONTROLE.DS_LOG IS NOT NULL THEN&#xa;    O_MENSAGEM := &apos;Erro na importa&#xe7;&#xe3;o do arquivo.&apos;;&#xa;    return;&#xa;  END IF;  &#xa;    &#xa;    &#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      NULL;&#xa;  END;         &#xa;    &#xa;  ---------------------------------------------------------------------------------------------&#xa;  ---------------------------------------------------------------------------------------------&#xa;  -----------------------------------------------------------------------------------------------&#xa;end; "/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="VALIDA_EMPCC">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PROCEDURE VALIDA_EMPCC (I_CD_EMPRESA IN NUMBER) IS&#xa;BEGIN&#xa;  null;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" ID="ID_1861333301" MODIFIED="1610488916037" TEXT="VALIDA_CENTROCUSTO">
<icon BUILTIN="Method.public"/>
<node CREATED="1610488918922" ID="ID_1379314547" MODIFIED="1610488920268" TEXT="@">
<node CREATED="1610488924697" ID="ID_1067871712" LINK="window/com001/procedures/VALIDA_CENTROCUSTO.mm" MODIFIED="1610499955926" TEXT="tokens">
<icon BUILTIN="element"/>
</node>
<node CREATED="1610545066981" ID="ID_919047621" MODIFIED="1610545074630" TEXT="reusar">
<icon BUILTIN="element"/>
<node CREATED="1610545069798" ID="ID_578800383" MODIFIED="1610545087274" TEXT="S">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" ID="ID_222017338" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PROCEDURE VALIDA_CENTROCUSTO (V_CD_CENTROCUSTO NUMBER,&#xa;                              V_CD_NEGOCIO     NUMBER,&#xa;                              O_MENSAGEM OUT VARCHAR2) IS&#xa;BEGIN&#xa;  /**FZA:15/02/2011:33648&#xa;*** Ajustado tratamento de erros, as validacoes estavam aparecendo mais de uma vez.&#xa;**/&#xa;DECLARE&#xa;  V_ST_VALIDACCUSTO PARMCOMPRA.ST_VALIDACCUSTO%TYPE;&#xa;  V_CD_AUTORIZADOR  CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#xa;  V_CD_USUARIO      CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#xa;  V_ST_ATIVO        RESTRINGIRMOV.ST_ATIVO%TYPE;    &#xa;  V_CD_MOVIMENTACAO  NUMBER;&#xa;  V_MENSAGEM        VARCHAR2(2000);&#xa;--  V_CD_EMPRESA      AUTORIZCCUSTORESTRITO.CD_EMPRESA%TYPE;&#xa;  V_CD_AUTORICCUSTO  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#xa;  V_CD_CENTROCUSTO  AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO%TYPE;&#xa;  V_CD_AUTORICCUSTO2  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#xa;--  V_ST_REGISTRO     AUTORIZCCUSTORESTRITO.ST_REGISTRO%TYPE;&#xa;  &#xa;BEGIN&#xa;  IF V_CD_CENTROCUSTO IS NOT NULL THEN&#xa;    --FJC:05/07/2018:121701&#xa;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CC_USUARIO&apos;),&apos;N&apos;) = &apos;S&apos;  THEN    &#xa;       BEGIN&#xa;        SELECT CCUSTOAUTORIZ.CD_USUARIO&#xa;           INTO V_CD_USUARIO&#xa;           FROM CENTROCUSTO, CCUSTOAUTORIZ&#xa;          WHERE CENTROCUSTO.CD_CENTROCUSTO    = CCUSTOAUTORIZ.CD_CENTROCUSTO&#xa;            AND CCUSTOAUTORIZ.CD_USUARIO      = :GLOBAL.CD_USUARIO&#xa;            AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#xa;            AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = V_CD_CENTROCUSTO&#xa;            AND NVL(CENTROCUSTO.ST_CENTROCUSTO, &apos;A&apos;) = &apos;A&apos;;                   &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN          &#xa;          --O Usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o est&#xe1; autorizado para o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCO003.&#xa;           V_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(3771,&apos;&#xa2;CD_USUARIO=&apos;||:GLOBAL.CD_USUARIO||&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);                      &#xa;          WHEN TOO_MANY_ROWS THEN&#xa;           V_CD_USUARIO := NULL;&#xa;          WHEN OTHERS THEN               &#xa;            --Ocorreu um erro inesperado na busca dos dados do usu&#xe1;rio autorizador. Erro: &#xa2;SQLERRM&#xa2;.&#xa;           V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3958,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);           &#xa;      END;            &#xa;    END IF;&#xa;        &#xa;    IF V_MENSAGEM IS NOT NULL THEN  &#xa;      O_MENSAGEM := O_MENSAGEM||V_MENSAGEM;&#xa;      RETURN; &#xa;    END IF;&#xa;        &#xa;    DECLARE&#xa;      V_ST_CENTROCUSTO  CENTROCUSTO.ST_CENTROCUSTO%TYPE;&#xa;      E_GERAL EXCEPTION;&#xa;    BEGIN&#xa;        &#xa;      /**GRA:13783:27/12/2006&#xa;       * O PROCEDIMENTO ABAIXO VERIFICA SE O CENTRO DE&#xa;       * CUSTO EST&#xc1; CADASTRADO PARA A EMPRESA INFORMADA.&#xa;       */ &#xa;      PACK_VALIDA.VAL_CCUSTOEMPR(V_CD_CENTROCUSTO,&#xa;                                 NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRACCUSTO.CD_EMPRESA),--GDG:22/07/2011:28715&#xa;                                  :GLOBAL.CD_MODULO,&#xa;                                  :GLOBAL.CD_PROGRAMA,&#xa;                                  :ITEMCOMPRACCUSTO.DS_CENTROCUSTO,&#xa;                                  V_MENSAGEM);           &#xa;      IF V_MENSAGEM IS NOT NULL THEN  &#xa;        O_MENSAGEM := O_MENSAGEM||V_MENSAGEM;&#xa;        RETURN; &#xa;      END IF;                                                                                    &#xa;&#xa;    &#xa;      SELECT ST_CENTROCUSTO, DS_CENTROCUSTO&#xa;        INTO V_ST_CENTROCUSTO, :ITEMCOMPRACCUSTO.DS_CENTROCUSTO &#xa;        FROM CENTROCUSTO&#xa;       WHERE CENTROCUSTO.CD_CENTROCUSTO = V_CD_CENTROCUSTO;&#xa;       IF NVL(V_ST_CENTROCUSTO,&apos;A&apos;) = &apos;I&apos; THEN&#xa;           --O centro de custo &#xa2;CD_CENTROCUSTO&#xa2; encontra-se inativo e n&#xe3;o pode ser usado. Verifique TCB007.&#xa;           O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1509,&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;           :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;           &#xa;           RETURN;&#xa;       END IF;&#xa;     &#xa;    EXCEPTION&#xa;      WHEN E_GERAL THEN&#xa;        O_MENSAGEM := V_MENSAGEM;&#xa;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#xa;        RAISE FORM_TRIGGER_FAILURE;     &#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --O Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o programa TCB007.&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(254,&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#xa;        :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;                &#xa;        RETURN;&#xa;      WHEN OTHERS THEN&#xa;        --Ocorreu um erro inesperado ao consultar os dados do centro de custo &#xa2;CD_CENTROCUSTO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(999,&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;SQLERREM=&apos;||SQLERRM||&apos;&#xa2;&apos;);              &#xa;        RETURN;&#xa;    END;&#xa; &#xa; -----------------------------------------------------------------------------------------------------------------&#xa; --VALIDA CENTRO DE CUSTO&#xa; -----------------------------------------------------------------------------------------------------------------&#xa;   IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN&#xa;    DECLARE&#xa;      E_GERAL  EXCEPTION;&#xa;    BEGIN       &#xa;      SELECT NVL(ST_VALIDACCUSTO,&apos;N&apos;)&#xa;        INTO V_ST_VALIDACCUSTO&#xa;        FROM PARMCOMPRA&#xa;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA;&#xa;        /* CSL:22264:30/06/09 - COMPARA&#xc7;&#xc3;O INADEQUADA */&#xa;        --IF V_ST_VALIDACCUSTO = &apos;S&apos; THEN&#xa;        IF V_ST_VALIDACCUSTO = &apos;C&apos; THEN        &#xa;         BEGIN&#xa;          SELECT CCUSTOAUTORIZ.CD_USUARIO&#xa;             INTO V_CD_AUTORIZADOR&#xa;             FROM CCUSTOAUTORIZ&#xa;            WHERE CCUSTOAUTORIZ.CD_USUARIO      = :CONTROLE.CD_AUTORIZADOR&#xa;              AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)--GDG:22/07/2011:28715&#xa;              AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = V_CD_CENTROCUSTO&#xa;             AND CCUSTOAUTORIZ.TP_AUTORIZADOR  IN (&apos;A&apos;,&apos;S&apos;,&apos;T&apos;);          &#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            --O Usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o est&#xe1; autorizado para o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCO003.&#xa;             O_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(3771,&apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR ||&apos; - &apos;||:CONTROLE.NM_USUAUTORIZ||&#xa;                                                          &apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;             :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#xa;             :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#xa;             RETURN;         &#xa;            WHEN OTHERS THEN&#xa;              --Ocorreu um erro inesperado na busca dos dados do usu&#xe1;rio autorizador. Erro: &#xa2;SQLERRM&#xa2;.&#xa;             O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3958,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;             RETURN;&#xa;        END;&#xa;        END IF; &#xa;      &#xa;  /*     BEGIN --eml:13/01/2019:139947         &#xa;         SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                               &#xa;           INTO  V_CD_AUTORICCUSTO&#xa;            FROM AUTORIZCCUSTORESTRITO&#xa;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#xa;           --  AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#xa;              AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = :ITEMCOMPRACCUSTO.CD_EMPRESA&#xa;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = &apos;S&apos;; &#xa;&#xa;           IF(V_CD_AUTORICCUSTO IS  NOT NULL)THEN&#xa;             IF(:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NOT NULL)THEN&#xa;                SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR                               &#xa;                INTO V_CD_AUTORICCUSTO&#xa;                 FROM AUTORIZCCUSTORESTRITO&#xa;                WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#xa;                  AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :ITEMCOMPRACCUSTO.CD_AUTORIZADOR&#xa;                   AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = :ITEMCOMPRACCUSTO.CD_EMPRESA&#xa;                  AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = &apos;S&apos;;&#xa;               IF V_CD_AUTORICCUSTO IS NULL THEN           &#xa;               --O Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o tem permiss&#xe3;o, para o centro de Custo  &#xa2;CD_CENTROCUSTO&#xa2;  verifique TCO035.&#xa;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;&apos;);&#xa;              RETURN; &#xa;             END IF;                   &#xa;            ELSE &#xa;              --Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2; restrito, informe o Autorizador!&#xa;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;             RETURN;&#xa;            END IF;      &#xa;          END IF;           &#xa;       END;   */&#xa;       &#xa;      IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947             &#xa;       BEGIN  &#xa;        SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                                        &#xa;            INTO V_CD_AUTORICCUSTO&#xa;            FROM AUTORIZCCUSTORESTRITO&#xa;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO--EMLLL               &#xa;              AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#xa;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = &apos;S&apos;;               &#xa;         EXCEPTION &#xa;           WHEN OTHERS THEN             &#xa;            V_CD_AUTORICCUSTO := NULL;                                     &#xa;         END;           &#xa;        IF V_CD_AUTORICCUSTO IS NOT NULL THEN           &#xa;          IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN                                             &#xa;          /*O autorizador da tela principal deve ser informado.*/&#xa;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33735, NULL);&#xa;            RETURN;          &#xa;          END IF;&#xa;          &#xa;        BEGIN           &#xa;          SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#xa;            INTO V_CD_AUTORICCUSTO2&#xa;            FROM AUTORIZCCUSTORESTRITO&#xa;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO            &#xa;            AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#xa;             AND AUTORIZCCUSTORESTRITO.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#xa;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO     = &apos;S&apos;;             &#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;               O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);  &#xa;          RETURN;          &#xa;        END;  &#xa;       END IF;    &#xa;    END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN     &#xa;   &#xa;    EXCEPTION      &#xa;      WHEN E_GERAL THEN&#xa;        O_MENSAGEM := V_MENSAGEM;&#xa;        RETURN;&#xa;       WHEN NO_DATA_FOUND THEN &#xa;         NULL;  &#xa;            &#xa;       WHEN TOO_MANY_ROWS THEN&#xa;         V_MENSAGEM := &apos;A consulta retornou mais de uma empresa para esta condi&#xe7;&#xe3;o.&apos;;&#xa;        RETURN;&#xa;      WHEN OTHERS THEN&#xa;        V_MENSAGEM := &apos;Erro inesperado: &apos;||SQLERRM;&#xa;        RETURN;&#xa;    END;  &#xa;   END IF; --IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN  &#xa;   IF V_CD_NEGOCIO = 0 THEN&#xa;    /**CSL:21/12/2010:30317&#xa;     * Adicionado campo cd_negocio para permitir ou n&#xe3;o que o usu&#xe1;rio altere o neg&#xf3;cio para o qual &#xa;     * vai ser destinado o valor do centro de custo, de acordo com o status do parametro ST_NEGOCIOCCUSTO (N - Negado, S - Permitido) do CTI010.&#xa;     */   &#xa;    BEGIN&#xa;      SELECT CENTROCUSTO.CD_NEGOCIO,&#xa;             NEGOCIO.DS_NEGOCIO&#xa;        INTO :ITEMCOMPRACCUSTO.CD_NEGOCIO,&#xa;             :ITEMCOMPRACCUSTO.DS_NEGOCIO&#xa;        FROM CENTROCUSTO, NEGOCIO&#xa;       WHERE CENTROCUSTO.CD_NEGOCIO     = NEGOCIO.CD_NEGOCIO&#xa;         AND CENTROCUSTO.CD_CENTROCUSTO = V_CD_CENTROCUSTO;&#xa;      &#xa;      IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;CTI&apos;,10,&apos;MAX&apos;,100,&apos;ST_NEGOCIOCCUSTO&apos;),&apos;N&apos;) = &apos;N&apos; THEN&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,ENABLED,PROPERTY_FALSE);&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);  &#xa;      ELSE&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,ENABLED,PROPERTY_TRUE);&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);  &#xa;      END IF;&#xa;    &#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(5243,&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);--Nenhum neg&#xf3;cio associado ao centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCB007.&#xa;        RETURN;&#xa;      WHEN TOO_MANY_ROWS THEN&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6306,&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);--Existe mais de um neg&#xf3;cio associado ao centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCB007.&#xa;        RETURN;&#xa;      WHEN OTHERS THEN&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6307,&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);--Ocorreu um erro inesperado ao tentar localizar o c&#xf3;digo de neg&#xf3;cio associado ao Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;        RETURN;&#xa;    END;&#xa;    END IF;    &#xa;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  V_CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#xa;    --VALIDA_CONTA_ORCAMENTO(&apos;ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, V_CD_CENTROCUSTO);&#xa;      VALIDA_ORCAMENTO_IMP(&apos;ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&apos;, NVL(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, :ITEMCOMPRA.CD_MOVIMENTACAO),V_CD_CENTROCUSTO, V_MENSAGEM);    &#xa;      IF V_MENSAGEM IS NOT NULL THEN  &#xa;        O_MENSAGEM := O_MENSAGEM||V_MENSAGEM;&#xa;        RETURN; &#xa;      END IF;&#xa;    END IF;&#xa;  &#xa;  ELSE &#xa;    :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#xa;  END IF;&#xa;&#xa;-----------------------------------------------------------------------------------------------------------------&#xa;--VALIDA SE A MOVIMENTA&#xc7;&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O PARA O CENTRO DE CUSTO (TCB053)&#xa;--AUG:122414:24/05/2018&#xa;-----------------------------------------------------------------------------------------------------------------      &#xa;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NOT NULL AND&#xa;       V_CD_CENTROCUSTO  IS NOT NULL THEN&#xa;    &#xa;      /*RETORNO: S = POSSUI RESTRI&#xc7;&#xc3;O&#xa;       *          N = N&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#xa;       */&#xa;        &#xa;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#xa;                                                      V_CD_CENTROCUSTO);&#xa;                                                                                                           &#xa;      IF NVL(V_ST_ATIVO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;        V_CD_MOVIMENTACAO := :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO;&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;        RETURN;&#xa;      END IF;&#xa;    END IF;  &#xa;      &#xa;    IF V_CD_CENTROCUSTO  IS NOT NULL AND&#xa;       :ITEMCOMPRA.CD_MOVIMENTACAO       IS NOT NULL THEN&#xa;         &#xa;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRA.CD_MOVIMENTACAO,&#xa;                                                      V_CD_CENTROCUSTO);&#xa;                                                                            &#xa;      IF NVL(V_ST_ATIVO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;||V_CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;         RETURN;&#xa;      END IF;&#xa;    END IF;    &#xa;END;&#xa;END;&#xa;      &#xa;&#xa;"/>
</node>
</node>
<node CREATED="1607991779079" ID="ID_743844437" MODIFIED="1607991779079" TEXT="VALIDA_ORCAMENTO_IMP">
<icon BUILTIN="Method.public"/>
<node CREATED="1610545061486" ID="ID_1132046644" MODIFIED="1610545066345" TEXT="@">
<node CREATED="1610545066981" ID="ID_640908040" MODIFIED="1610545074630" TEXT="reusar">
<icon BUILTIN="element"/>
<node CREATED="1610545069798" ID="ID_733417094" MODIFIED="1610545073230" TEXT="N">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" ID="ID_1538816112" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" ID="ID_1168295411" MODIFIED="1607991779079" TEXT="PROCEDURE VALIDA_ORCAMENTO_IMP(I_TRIGGER_ITEM    IN VARCHAR2, &#xa;                               I_CD_MOVIMENTACAO IN NUMBER,                   &#xa;                               I_CD_CENTROCUSTO  IN VARCHAR2,                               &#xa;                               O_MENSAGEM OUT VARCHAR) IS&#xa;BEGIN&#xa;     ----Valida Ora&#xe7;amento&#xa;        IF PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,&apos;COMPRAS&apos;) = &apos;S&apos; AND &#xa;         PACK_ORC051.RETORNA_TIPO_ORCAMENTO(SYSDATE) = &apos;O&apos; AND &#xa;         NVL(PACK_PARMGEN.CONSULTA_PARAMETRO (&apos;ORC&apos;,50,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CONTAORCCOMPRAS&apos;),&apos;N&apos;) = &apos;S&apos; THEN      &#xa;        BEGIN&#xa;          SELECT HISTCONTB.CD_CONTACONTABIL&#xa;            INTO :CONTROLE.CD_CONTACONTABIL&#xa;            FROM PARMOVIMENT,&#xa;                 HISTCONTB&#xa;           WHERE PARMOVIMENT.CD_MOVIMENTACAO = I_CD_MOVIMENTACAO&#xa;             AND PARMOVIMENT.CD_HISTCONTB     = HISTCONTB.CD_HISTCONTB;&#xa;             &#xa;          :CONTROLE.CD_CONTAORCAMENTO := NULL;&#xa;                &#xa;          BEGIN &#xa;            SELECT R.CD_CONTAORCAMENTO&#xa;              INTO :CONTROLE.CD_CONTAORCAMENTO&#xa;              FROM RELACAOCONTASORCCTB R, PLANOCONTASORCAMENTO P , PLANOCONTABIL&#xa;             WHERE R.CD_CONTACONTABIL  = :CONTROLE.CD_CONTACONTABIL                           &#xa;               AND R.CD_CONTAORCAMENTO = P.CD_CONTAORCAMENTO&#xa;               AND R.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#xa;               AND ((I_CD_CENTROCUSTO IS NOT NULL &#xa;                     AND EXISTS (SELECT PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO&#xa;                                   FROM PLANOCONTASORCAMENTOCUSTO&#xa;                                  WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO&#xa;                                    AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO    = I_CD_CENTROCUSTO&#xa;                                  )) &#xa;                   OR&#xa;                   (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL &#xa;                     AND 0 = (SELECT COUNT(PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO)&#xa;                                FROM PLANOCONTASORCAMENTOCUSTO&#xa;                               WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO &#xa;                                 AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO IS NULL))                                                               &#xa;                                );   &#xa;          EXCEPTION&#xa;            WHEN NO_DATA_FOUND THEN&#xa;              :CONTROLE.CD_CONTAORCAMENTO := NULL;&#xa;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(28965, &apos;&#xa2;CD_CONTACONTABIL=&apos;||:CONTROLE.CD_CONTACONTABIL||&apos;&#xa2;CD_CENTROCUSTO=&apos;||NVL(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&apos;N&#xe3;o Informado&apos;)||&apos;&#xa2;&apos;);&#xa;              RETURN;&#xa;            WHEN TOO_MANY_ROWS THEN&#xa;              LOOP&#xa;                IF SHOW_LOV(&apos;LOV_CONTAORC&apos;) THEN&#xa;                  EXIT;&#xa;                END IF;&#xa;              END LOOP;              &#xa;          END;&#xa;              &#xa;          IF :CONTROLE.CD_CONTAORCAMENTO IS NOT NULL THEN&#xa;            COPY(:CONTROLE.CD_CONTAORCAMENTO, I_TRIGGER_ITEM);&#xa;          END IF;    &#xa;          &#xa;             &#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            NULL;&#xa;        END;    &#xa;      END IF;                           &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="VALIDA_MOV_IMP">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PROCEDURE VALIDA_MOV_IMP(V_CD_MOVIMENTACAO NUMBER, &#xa;                         O_DS_MENSAGEM OUT VARCHAR2) IS&#xa;BEGIN&#xa;  DECLARE&#xa;  V_TP_PEDIDO    PARMOVIMENT.TP_PEDIDO%TYPE; --PHS:60051:11/07/2013&#xa;  I_CD_NATUREZA  PLANOCONTABIL.CD_NATUREZA%TYPE;&#xa;  I_MENSAGEM     VARCHAR2(32000);&#xa;  I_RETORNO       VARCHAR2(01);&#xa;  V_ST_ATIVO     RESTRINGIRMOV.ST_ATIVO%TYPE;&#xa;  E_GERAL        EXCEPTION;&#xa;BEGIN&#xa;&#xa;  IF V_CD_MOVIMENTACAO IS NOT NULL THEN&#xa;      IF PACK_GLOBAL.TP_SELECAOCONTA = &apos;O&apos; THEN&#xa;        /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padr&#xe3;o da fun&#xe7;&#xe3;o VALIDA_SELECAOCONTA quando for &apos;CO&apos;*/&#xa;        I_MENSAGEM := VALIDA_SELECAOCONTA (NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:CONTROLE.CD_EMPRESA),&#xa;                                           :ITEMCOMPRACCUSTO.CD_ITEM,&#xa;                                           V_CD_MOVIMENTACAO, &#xa;                                           NULL, &apos;CO&apos;);    &#xa;        IF (I_MENSAGEM IS NOT NULL) AND (I_MENSAGEM &lt;&gt; &apos;S&apos;) THEN&#xa;          O_DS_MENSAGEM := I_MENSAGEM;&#xa;          RETURN;&#xa;        END IF;&#xa;      END IF;&#xa;      &#xa;      /* CSL:02/12/2013:64869&#xa;       * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO para n&#xe3;o permitir realizar lan&#xe7;amentos em contas, &#xa;       * que n&#xe3;o pertencem a vers&#xe3;o do plano de contas da empresa do lan&#xe7;amento.&#xa;       */&#xa;      PACK_VALIDA.VALIDA_CONTABIL_PLANO(V_CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:GLOBAL.CD_EMPRESA), I_MENSAGEM);&#xa;    &#xa;      IF I_MENSAGEM IS NOT NULL THEN&#xa;        O_DS_MENSAGEM := I_MENSAGEM;&#xa;        RETURN;&#xa;      END IF;&#xa;      &#xa;      BEGIN&#xa;        /*CSL:30/12/2013:64869*/&#xa;        IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;                 PLANOCONTABIL.CD_NATUREZA,&#xa;                 PARMOVIMENT.TP_PEDIDO&#xa;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#xa;                 I_CD_NATUREZA,&#xa;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#xa;            FROM PARMOVIMENT,HISTCONTB,PLANOCONTABIL&#xa;           WHERE PARMOVIMENT.CD_MOVIMENTACAO    = V_CD_MOVIMENTACAO&#xa;             AND HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#xa;             AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#xa;             AND PLANOCONTABIL.TP_CONTACONTABIL = &apos;CC&apos;;&#xa;        &#xa;        ELSE&#xa;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;                 PLANOCONTABILVERSAO.CD_NATUREZA,&#xa;                 PARMOVIMENT.TP_PEDIDO&#xa;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#xa;                 I_CD_NATUREZA,&#xa;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#xa;            FROM PARMOVIMENT, HISTCONTB, PLANOCONTABILVERSAO&#xa;           WHERE PARMOVIMENT.CD_MOVIMENTACAO           = V_CD_MOVIMENTACAO&#xa;             AND HISTCONTB.CD_HISTCONTB                = PARMOVIMENT.CD_HISTCONTB&#xa;             AND PLANOCONTABILVERSAO.CD_CONTACONTABIL  = HISTCONTB.CD_CONTACONTABIL&#xa;             AND PLANOCONTABILVERSAO.TP_CONTACONTABIL  = &apos;CC&apos;&#xa;             AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#xa;                 PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));  &#xa;        END IF;&#xa;        &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          --Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; n&#xe3;o cadastrada, n&#xe3;o &#xe9; de compra ou n&#xe3;o &#xe9; de Centro de Custo. Verifique TCB008.&#xa;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3775,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||V_CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;          O_DS_MENSAGEM := I_MENSAGEM;&#xa;          RETURN;      &#xa;      END;&#xa;    &#xa;      --PHS:60051:11/07/2013&#xa;      IF V_TP_PEDIDO &lt;&gt; PACK_GLOBAL.TP_PEDIDO THEN&#xa;        --A movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; possui o tipo de pedido &#xa2;TP_PEDIDO&#xa2; diferente do tipo de pedido &#xa2;TP_CADPEDIDO&#xa2; cadastrado para o programa. Verificar os programas TCB008 e ANV008.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20737,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||V_CD_MOVIMENTACAO||&apos;&#xa2;TP_PEDIDO=&apos;||V_TP_PEDIDO||&apos;&#xa2;TP_CADPEDIDO=&apos;||PACK_GLOBAL.TP_PEDIDO||&apos;&#xa2;&apos;); &#xa;        O_DS_MENSAGEM := I_MENSAGEM;&#xa;        RETURN;&#xa;      END IF;  &#xa;    &#xa;      /*CLM:22/08/2014:76468 &#xa;      IF NATUREZA_CENTROCUSTO(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO) &lt;&gt; I_CD_NATUREZA THEN&#xa;        --A Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; n&#xe3;o &#xe9; compat&#xed;vel com o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCB008.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3776,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||V_CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;*/&#xa;      &#xa;      I_RETORNO := RETORNA_NATUREZA (V_CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO,:GLOBAL.CD_EMPRESA); /*CSL:03/10/2013:62738*/&#xa;      IF I_RETORNO = &apos;I&apos; THEN&#xa;        --A natureza do Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2; &#xe9; incompat&#xed;vel com a natureza da Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2;. Verifique TCB007 e TCB008.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20318, &apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;CD_MOVIMENTACAO=&apos;||V_CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        O_DS_MENSAGEM := I_MENSAGEM;&#xa;        RETURN;&#xa;      END IF;&#xa;    &#xa;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#xa;      VALIDA_ORCAMENTO_IMP(&apos;ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRA.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO, I_MENSAGEM);&#xa;      IF (I_MENSAGEM  IS NOT NULL)THEN&#xa;        O_DS_MENSAGEM := I_MENSAGEM;&#xa;        RETURN;&#xa;      END IF; &#xa;    END IF;&#xa;          &#xa;  ELSE&#xa;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#xa;  END IF;&#xa;-----------------------------------------------------------------------------------------------------------------&#xa;--VALIDA SE A MOVIMENTA&#xc7;&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O PARA O CENTRO DE CUSTO (TCB053)&#xa;--AUG:122414:24/05/2018&#xa;-----------------------------------------------------------------------------------------------------------------      &#xa;      IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#xa;      &#xa;       /*RETORNO: S = POSSUI RESTRI&#xc7;&#xc3;O&#xa;        *          N = N&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#xa;        */&#xa;        &#xa;        V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(V_CD_MOVIMENTACAO,&#xa;                                                            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;        IF NVL(V_ST_ATIVO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||V_CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;          O_DS_MENSAGEM := I_MENSAGEM;&#xa;          RETURN;&#xa;        END IF;&#xa;      END IF;                      &#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#xa;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#xa;    O_DS_MENSAGEM := I_MENSAGEM;&#xa;    RETURN;&#xa;  WHEN OTHERS THEN&#xa;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#xa;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#xa;    O_DS_MENSAGEM := &apos;Maxys COM001 - Erro&apos;||SQLERRM;&#xa;    RETURN;&#xa;END;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="VALIDA_NEGOCIO_IMP">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PROCEDURE VALIDA_NEGOCIO_IMP(V_CD_NEGOCIO NUMBER, &#xa;                             O_DS_MENSAGEM OUT VARCHAR2 ) IS&#xa;BEGIN&#xa;  BEGIN&#xa;  IF :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN  &#xa;    SELECT DS_NEGOCIO&#xa;      INTO :ITEMCOMPRANEGOCIO.DS_NEGOCIO&#xa;      FROM NEGOCIO&#xa;     WHERE NEGOCIO.CD_NEGOCIO = :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#xa;     &#xa;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#xa;      VALIDA_CONTA_ORCAMENTO(&apos;ITEMCOMPRANEGOCIO.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRA.CD_MOVIMENTACAO, null,:ITEMCOMPRANEGOCIO.CD_NEGOCIO);&#xa;    END IF; &#xa;  ELSE&#xa;    :ITEMCOMPRANEGOCIO.DS_NEGOCIO := NULL;&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    O_DS_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(147,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||&apos;&#xa2;&apos;);--O Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o programa TCB001.&#xa;    RETURN;&#xa;  WHEN TOO_MANY_ROWS THEN&#xa;   O_DS_MENSAGEM :=   PACK_MENSAGEM.MENS_PADRAO(148,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||&apos;&#xa2;&apos;);--O Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; est&#xe1; cadastrado v&#xe1;rias vezes. Verifique o programa TCB001.&#xa;   RETURN;&#xa;  WHEN OTHERS THEN&#xa;    O_DS_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(149,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);--Ocorreu um erro inesperado ao consultar os dados do c&#xf3;digo de Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;    RETURN;&#xa;END;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="MSG_CONFIRMACAO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="FUNCTION MSG_CONFIRMACAO (V_DESCRICAO IN VARCHAR2) RETURN BOOLEAN IS&#xa;  RETORNO NUMBER; &#xa;BEGIN&#xa;    /*&#xa;    V_MENSAGEM := &apos;J&#xe1; Existem Dados Gravados Para Este Per&#xed;odo,&#xd;Para esta empresa e esta Vers&#xe3;o.&#xd;Se Gravar Novamente Ir&#xe1; Apagar os Valores Anteriores&#xd; Deseja Continuar..?&apos;;&#xa;    IF NOT MSG_CONFIRMACAO(V_MENSAGEM) THEN&#xa;      V_MENSAGEM := &apos;Gera&#xe7;&#xe3;o do Relatorio Cancelada Pelo Usu&#xe1;rio.&apos;;&#xa;      RAISE E_GERAL;&#xa;    END IF;  &#xa;    */ &#xa;    SET_ALERT_PROPERTY(&apos;MENSAGEM_EDICAO&apos;,ALERT_MESSAGE_TEXT,V_DESCRICAO); &#xa;    RETORNO := SHOW_ALERT(&apos;MENSAGEM_EDICAO&apos;);&#xa;    IF RETORNO &lt;&gt; 88 THEN&#xa;      RETURN(FALSE);&#xa;    ELSE&#xa;      RETURN(TRUE);&#xa;    END IF;    &#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="VALIDA_AUTORIZADORCOMPRA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PROCEDURE VALIDA_AUTORIZADORCOMPRA(I_CD_AUTORIZADOR VARCHAR2, &#xa;                                    O_MENSAGEM OUT VARCHAR2)    IS&#xa;                                  &#xa;BEGIN &#xa;  DECLARE&#xa;  E_GERAL EXCEPTION;&#xa;  V_VALIDOU VARCHAR2(1);&#xa;BEGIN      &#xa;    IF   I_CD_AUTORIZADOR IS NOT NULL THEN &#xa;      V_VALIDOU := &apos;N&apos;;&#xa;  /*    BEGIN&#xa;        SELECT USUARIO.NM_USUARIO &#xa;          INTO :ITEMCOMPRA.NM_USUAUTORIZ &#xa;          FROM USUARIO&#xa;         WHERE USUARIO.CD_USUARIO = I_CD_AUTORIZADOR;&#xa;      EXCEPTION                      &#xa;        WHEN NO_DATA_FOUND THEN  /&#xa;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32765, NULL);&#xa;        --  mensagem(&apos;Maxys&apos;,&apos;Autorizador n&#xe3;o cadastrado&apos;,2);&#xa;          RAISE E_GERAL;&#xa;      END;  */&#xa;      /** WLV:22/08/2012:41514&#xa;        * Adicionado o DISTINCT na consulta, pois quando ha um usu&#xe1;rio autorizador mais de uma vez cadastrada para mesma &#xa;        * empresa com grupos diferentes estourava TOO_MANY_ROWS.&#xa;        */    &#xa;      BEGIN  &#xa;        SELECT DISTINCT USUARIO.NM_USUARIO&#xa;          INTO :ITEMCOMPRA.NM_USUAUTORIZ&#xa;          FROM SOLICITANTE, &#xa;               PARMCOMPRA,&#xa;               USUARIO &#xa;         WHERE SOLICITANTE.CD_EMPRESA     = PARMCOMPRA.CD_EMPRESA&#xa;           AND USUARIO.CD_USUARIO         = SOLICITANTE.CD_USUARIO&#xa;           AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.TP_APROVSOLIC&#xa;           AND SOLICITANTE.CD_USUARIO     = I_CD_AUTORIZADOR &#xa;           AND PARMCOMPRA.CD_EMPRESA      = :GLOBAL.CD_EMPRESA;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN          &#xa;          --O Usu&#xe1;rio Informado &#xa2;CD_USUARIO&#xa2; n&#xe3;o &#xe9; um Autorizador Cadastrado para a empresa &#xa2;CD_EMPRESA&#xa2;. Verifique TCO002.          &#xa;          O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4737, &apos;&#xa2;CD_USUARIO=&apos;||I_CD_AUTORIZADOR||&apos;&#xa2;CD_EMPRESA=&apos;||:GLOBAL.CD_EMPRESA||&apos;&#xa2;&apos;);             &#xa;          RETURN;&#xa;      END;  &#xa;    ELSE &#xa;      :ITEMCOMPRA.NM_USUAUTORIZ:=NULL;&#xa;    END IF;    &#xa;EXCEPTION                      &#xa;    WHEN E_GERAL THEN&#xa;      RETURN;&#xa;    WHEN OTHERS THEN&#xa;      O_MENSAGEM :=  &apos;Maxys COM001 - Erro&apos;||SQLERRM;&#xa;      RETURN;&#xa;END;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" ID="ID_716399843" MODIFIED="1607991779079" TEXT="INFORMA_PROJETO">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PROCEDURE INFORMA_PROJETO (I_CD_EMPRESA IN NUMBER, O_MENSAGEM OUT VARCHAR2) IS&#xa;/*GBO:13/09/19:138077*/&#xa;  I_PARAMETROS            PARAMLIST;   &#xa;  E_SAIDA                  EXCEPTION;&#xa;  V_COUNT                  NUMBER;&#xa;  V_CD_CCUSTO             NUMBER;&#xa;  V_VT_REGISTRO           PACK_PROJETOMONI.REG_REGISTRO;&#xa;  V_POSVET                NUMBER;&#xa;  V_NR_CONTROLE           NUMBER;&#xa;  V_DS_CCUSTO             VARCHAR2(32000);&#xa;  &#xa;  /*CURSOR CUR_DADOS_PROJETO (C_CD_CENTRODECUSTO  IN NUMBER)IS&#xa;      SELECT PROJETORATEIO.NR_SEQUENCIAL,&#xa;             PROJETORATEIO.CD_PROJETO,&#xa;             PROJETORATEIO.CD_ESTUDO,&#xa;             ESTUDOMONI.DS_ESTUDO,&#xa;             ESTUDOMONI.NM_ESTUDO,&#xa;             PROJETORATEIO.CD_ETAPA,&#xa;             ETAPAMONI.DS_ETAPA,&#xa;             PROJETORATEIO.VL_RATEIO,&#xa;             PROJETORATEIO.NR_VERSAO,&#xa;             PROJETORATEIO.PC_RATEIO,&#xa;             PROJETORATEIO.NR_ITEMCOMPRA,&#xa;             PROJETORATEIO.NR_LOTECOMPRA&#xa;        FROM PROJETORATEIO,&#xa;             ESTUDOMONI,&#xa;             ETAPAMONI,&#xa;             PROJETOMONI,&#xa;             CENTROCUSTOMONI&#xa;       WHERE PROJETOMONI.CD_ESTUDO           = ESTUDOMONI.CD_ESTUDO&#xa;         AND PROJETOMONI.CD_PROJETO          = ETAPAMONI.CD_PROJETO&#xa;         AND PROJETOMONI.CD_ESTUDO           = ETAPAMONI.CD_ESTUDO&#xa;         AND PROJETOMONI.NR_VERSAO           = ETAPAMONI.NR_VERSAO&#xa;         AND PROJETORATEIO.CD_ETAPA          = ETAPAMONI.CD_ETAPA&#xa;         AND PROJETORATEIO.CD_PROJETO        = PROJETOMONI.CD_PROJETO&#xa;         AND PROJETORATEIO.CD_ESTUDO         = PROJETOMONI.CD_ESTUDO&#xa;         AND PROJETORATEIO.NR_VERSAO         = PROJETOMONI.NR_VERSAO&#xa;         AND PROJETORATEIO.CD_CENTROCUSTO    = CENTROCUSTOMONI.CD_CENTROCUSTO&#xa;         AND CENTROCUSTOMONI.ST_ATIVA        = 1&#xa;         AND PROJETORATEIO.CD_EMPRITEMCOMPRA = NVL(I_CD_EMPRESA,:GLOBAL.CD_EMPRESA)&#xa;         AND PROJETORATEIO.NR_ITEMCOMPRA     = :ITEMCOMPRA.NR_ITEMCOMPRA&#xa;         --AND NVL(PROJETORATEIO.NR_LOTECOMPRA,-1)= I_NR_LOTECOMPRA&#xa;         AND PROJETORATEIO.CD_CENTROCUSTO    = C_CD_CENTRODECUSTO;*/&#xa;  &#xa;BEGIN  &#xa;  IF PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;, 9, &apos;MAX&apos;, NVL(I_CD_EMPRESA,:GLOBAL.CD_EMPRESA), &apos;ST_PROJETOMONI&apos;) = &apos;S&apos; AND &#xa;     PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;, 9, &apos;MAX&apos;, NVL(I_CD_EMPRESA,:GLOBAL.CD_EMPRESA), &apos;ST_PRJETORATEIO&apos;) = &apos;S&apos; THEN&#xa;     &#xa;    V_COUNT  := 0;  &#xa;    -- VALIDA SE ALGUM REGISTRO HAVERA RATEIO.&#xa;    GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;    FIRST_RECORD;&#xa;    LOOP  &#xa;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL AND :ITEMCOMPRA.TP_CONTACONTABIL = &apos;CC&apos; THEN         &#xa;         FOR I IN 1..GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;) LOOP&#xa;          IF GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_ITEM&apos;, I) = :ITEMCOMPRA.CD_ITEM THEN&#xa;            V_CD_CCUSTO := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_CENTROCUSTO&apos;, I);    &#xa;            &#xa;            BEGIN&#xa;              SELECT COUNT(1)&#xa;                INTO V_COUNT&#xa;                FROM CENTROCUSTOMONI,&#xa;                     MOVIMENTACAOGRUPOMONI&#xa;               WHERE CENTROCUSTOMONI.ST_ATIVA       = 1&#xa;                 AND CENTROCUSTOMONI.CD_CENTROCUSTO = V_CD_CCUSTO&#xa;                 AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;                 AND EXISTS ( SELECT *&#xa;                                FROM PROJETOCENTROCUSTOMONI,PROJETOMONI&#xa;                               WHERE CENTROCUSTOMONI.CD_CENTROCUSTO    = PROJETOCENTROCUSTOMONI.CD_CENTROCUSTO &#xa;                                 AND PROJETOCENTROCUSTOMONI.CD_PROJETO     = PROJETOMONI.CD_PROJETO     &#xa;                                 AND PROJETOCENTROCUSTOMONI.CD_ESTUDO      = PROJETOMONI.CD_ESTUDO      &#xa;                                 AND PROJETOCENTROCUSTOMONI.NR_VERSAO      = PROJETOMONI.NR_VERSAO &#xa;                                 AND PROJETOMONI.ST_ATIVA                  = 1&#xa;                                 AND PROJETOMONI.ST_ESTADO                 IN (5,6,7));&#xa;            EXCEPTION&#xa;              WHEN OTHERS THEN&#xa;                V_COUNT := 0;&#xa;            END;&#xa;            &#xa;            EXIT WHEN V_COUNT &gt; 0;  &#xa;          END IF;&#xa;        END LOOP;        &#xa;        EXIT WHEN V_COUNT &gt; 0;  &#xa;      END IF;   &#xa;      GO_BLOCK(&apos;ITEMCOMPRA&apos;);           &#xa;      EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;    &#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;    &#xa;    IF NVL(V_COUNT, 0) &gt; 0 THEN &#xa;          &#xa;      PACK_PROJETOMONI.LIMPA_CACHE;&#xa;      &#xa;      V_COUNT       := 0;&#xa;      V_NR_CONTROLE := 0;&#xa;      -- VALIDA SE ALGUM REGISTRO HAVERA RATEIO.&#xa;      GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;      FIRST_RECORD;&#xa;      LOOP  &#xa;        IF :ITEMCOMPRA.CD_ITEM IS NOT NULL AND :ITEMCOMPRA.TP_CONTACONTABIL = &apos;CC&apos;  THEN         &#xa;           &#xa;           FOR I IN 1 ..GET_GROUP_ROW_COUNT(&apos;GRUPO_CC&apos;) LOOP&#xa;            IF GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_ITEM&apos;, I) = :ITEMCOMPRA.CD_ITEM THEN&#xa;              V_CD_CCUSTO := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.CD_CENTROCUSTO&apos;, I);    &#xa;              &#xa;              BEGIN&#xa;                SELECT COUNT(1)&#xa;                  INTO V_COUNT&#xa;                  FROM CENTROCUSTOMONI,&#xa;                       MOVIMENTACAOGRUPOMONI&#xa;                 WHERE CENTROCUSTOMONI.ST_ATIVA       = 1&#xa;                   AND CENTROCUSTOMONI.CD_CENTROCUSTO = V_CD_CCUSTO&#xa;                   AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;                   AND EXISTS ( SELECT *&#xa;                                FROM PROJETOCENTROCUSTOMONI,PROJETOMONI&#xa;                               WHERE CENTROCUSTOMONI.CD_CENTROCUSTO    = PROJETOCENTROCUSTOMONI.CD_CENTROCUSTO &#xa;                                 AND PROJETOCENTROCUSTOMONI.CD_PROJETO     = PROJETOMONI.CD_PROJETO     &#xa;                                 AND PROJETOCENTROCUSTOMONI.CD_ESTUDO      = PROJETOMONI.CD_ESTUDO      &#xa;                                 AND PROJETOCENTROCUSTOMONI.NR_VERSAO      = PROJETOMONI.NR_VERSAO &#xa;                                 AND PROJETOMONI.ST_ATIVA                  = 1&#xa;                                 AND PROJETOMONI.ST_ESTADO                 IN (5,6,7));&#xa;              EXCEPTION&#xa;                WHEN OTHERS THEN&#xa;                  V_COUNT := 0;&#xa;              END;&#xa;                &#xa;              --- PREECNHE VETOR&#xa;              IF V_COUNT &gt; 0 THEN&#xa;                BEGIN&#xa;                  SELECT DS_CENTROCUSTO&#xa;                    INTO V_DS_CCUSTO&#xa;                    FROM CENTROCUSTO &#xa;                   WHERE CD_CENTROCUSTO = V_CD_CCUSTO;&#xa;                EXCEPTION&#xa;                  WHEN OTHERS THEN&#xa;                    V_DS_CCUSTO := NULL;&#xa;                END;    &#xa;                &#xa;                IF :ITEMCOMPRA.NR_REGBLOCO IS NULL THEN&#xa;                  PACK_PROCEDIMENTOS.NR_REGBLOCO := NVL(PACK_PROCEDIMENTOS.NR_REGBLOCO,0) + 1;&#xa;                  :ITEMCOMPRA.NR_REGBLOCO        := PACK_PROCEDIMENTOS.NR_REGBLOCO;&#xa;                END IF;  &#xa;                &#xa;                V_NR_CONTROLE := NVL(V_NR_CONTROLE,0) + 1;&#xa;                V_POSVET      := NVL(V_VT_REGISTRO.COUNT,0) + 1;&#xa;                &#xa;                V_VT_REGISTRO(V_POSVET).NR_CONTROLE       := V_NR_CONTROLE;&#xa;                V_VT_REGISTRO(V_POSVET).NR_ITEMCOMPRA     := 0;&#xa;                V_VT_REGISTRO(V_POSVET).CD_ITEM           := :ITEMCOMPRA.CD_ITEM;&#xa;                V_VT_REGISTRO(V_POSVET).DS_ITEM           := :ITEMCOMPRA.DS_ITEM;&#xa;                V_VT_REGISTRO(V_POSVET).CD_UNIDMED        := :ITEMCOMPRA.DS_UNIDMED;&#xa;                V_VT_REGISTRO(V_POSVET).CD_EMPRESA        := NVL(I_CD_EMPRESA, :GLOBAL.CD_EMPRESA);&#xa;                V_VT_REGISTRO(V_POSVET).CD_CENTROCUSTO    := V_CD_CCUSTO;&#xa;                V_VT_REGISTRO(V_POSVET).DS_CENTROCUSTO    := V_DS_CCUSTO;&#xa;                V_VT_REGISTRO(V_POSVET).QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.QT_PEDIDAUNIDSOL&apos;, I);&#xa;                V_VT_REGISTRO(V_POSVET).PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_CC.PC_PARTICIPACAO&apos;, I);&#xa;                V_VT_REGISTRO(V_POSVET).NR_REGBLOCO       := :ITEMCOMPRA.NR_REGBLOCO;&#xa;              &#xa;              END IF;  &#xa;            END IF;&#xa;          END LOOP;        &#xa;          &#xa;        END IF;   &#xa;        GO_BLOCK(&apos;ITEMCOMPRA&apos;);           &#xa;        EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;    &#xa;        NEXT_RECORD;&#xa;      END LOOP;&#xa;    &#xa;      -- PREENCHE VETOR CC CUSTO REGISTRO&#xa;       PACK_PROJETOMONI.SET_VETOR_REGISTRO(V_VT_REGISTRO, PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO);&#xa;       &#xa;      I_PARAMETROS := GET_PARAMETER_LIST(&apos;PARAMPROJETOETAPA&apos;);&#xa;      IF (NOT ID_NULL(I_PARAMETROS)) THEN&#xa;        DESTROY_PARAMETER_LIST(I_PARAMETROS);&#xa;      END IF;&#xa;      &#xa;      I_PARAMETROS := CREATE_PARAMETER_LIST(&apos;PARAMPROJETOETAPA&apos;);&#xa;      &#xa;      --ADD_PARAMETER(I_PARAMETROS,&apos;CD_EMPRITEMCOMPRA&apos;, TEXT_PARAMETER,I_CD_EMPRESA);&#xa;      --ADD_PARAMETER(I_PARAMETROS,&apos;NR_LOTEITEMCOMPRA&apos;, TEXT_PARAMETER,I_NR_LOTECOMPRA);&#xa;      ADD_PARAMETER(I_PARAMETROS,&apos;ST_VETOR&apos;, TEXT_PARAMETER,&apos;S&apos;); &#xa;      &#xa;      --:GLOBAL.ST_CANCELADOFORMSEL403 := &apos;FALSE&apos;;&#xa;      CALL_FORM(&apos;SEL403&apos;, NO_HIDE ,NO_REPLACE, NO_QUERY_ONLY, I_PARAMETROS);&#xa;      /**FLA:16/12/2019:140632&#xa;       * Verifica&#xe7;&#xe3;o de do bot&#xe3;o cancelar na SEL403&#xa;       */&#xa;      /*IF NVL(:GLOBAL.ST_CANCELADOFORMSEL403, &apos;FALSE&apos;) = &apos;TRUE&apos; THEN&#xa;        O_MENSAGEM := &apos;TRUE&apos;;&#xa;      END IF;  &#xa;      ERASE(&apos;GLOBAL.ST_CANCELADOFORMSEL403&apos;);*/&#xa;      &#xa;      PACK_PROJETOMONI.GET_VETOR_PROJETORATEIO(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO);&#xa;          &#xa;      /*IF NVL(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO.COUNT, 0) &gt; 0 THEN&#xa;        PACK_PROJETOMONI.INSERE_PROJETORATEIO(O_MENSAGEM);&#xa;      ELS*/&#xa;      IF NVL(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO.COUNT, 0) = 0 THEN&#xa;        O_MENSAGEM := &apos;TRUE&apos;;&#xa;      END IF;  &#xa;      &#xa;    END IF ; --IF NVL(V_COUNT,0) &gt; 0 ...&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN E_SAIDA THEN &#xa;    NULL;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="MAX_CALL_FORM">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="FUNCTION MAX_CALL_FORM(I_CD_MODULO           IN PROGRAMA.CD_MODULO%TYPE,&#xa;                       I_CD_PROGRAMA         IN PROGRAMA.CD_PROGRAMA%TYPE,&#xa;                       I_TP_DISPLAY          IN NUMBER DEFAULT HIDE,&#xa;                       I_TP_MENU             IN NUMBER DEFAULT DO_REPLACE,&#xa;                       I_TP_QUERY            IN NUMBER DEFAULT NO_QUERY_ONLY,&#xa;                       I_PARAMLIST           IN PARAMLIST DEFAULT NULL,&#xa;                       I_ST_VALPERMISSAO     IN BOOLEAN DEFAULT TRUE,&#xa;                       I_ST_ATUALIZACONEXAO IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2 IS&#xa;  &#xa;  V_NM_PROGRAMA DESKPROGRAMA.NM_PROGRAMA%TYPE;&#xa;  V_NM_ARQUIVO  DESKPROGRAMA.NM_ARQUIVO%TYPE;&#xa;  V_CD_MODULO   PROGRAMA.CD_MODULO%TYPE;&#xa;  V_CD_PROGRAMA PROGRAMA.CD_PROGRAMA%TYPE;&#xa;  E_GERAL       EXCEPTION;&#xa;  V_MENSAGEM    VARCHAR2(32000);&#xa;BEGIN&#xa;  IF ((I_CD_MODULO IS NULL) OR (I_CD_PROGRAMA IS NULL)) THEN&#xa;    V_MENSAGEM := &apos;Informe m&#xf3;dulo e programa.&apos;;&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;  &#xa;  --Monta o nome do programa (m&#xf3;dulo + programa)&#xa;  V_NM_PROGRAMA := I_CD_MODULO||TO_CHAR(I_CD_PROGRAMA, &apos;FM000&apos;);&#xa;  &#xa;  --Verifica o acesso ao programa&#xa;  IF I_ST_VALPERMISSAO THEN&#xa;    IF (NVL(PACK_DESK.TEM_ACESSO_PROGRAMA(:GLOBAL.CD_USUARIO, V_NM_PROGRAMA, :GLOBAL.CD_EMPRESA), &apos;N&apos;) = &apos;N&apos;) THEN&#xa;      --O usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o tem permiss&#xe3;o para usar o programa &#xa2;CD_MODULO&#xa2;&#xa2;CD_PROGRAMA&#xa2; na empresa &#xa2;CD_EMPRESA&#xa2;.&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(335, &apos;&#xa2;CD_USUARIO=&apos;||:GLOBAL.CD_USUARIO||&apos;&#xa2;CD_MODULO=&apos;||I_CD_MODULO||&apos;&#xa2;CD_PROGRAMA=&apos;||I_CD_PROGRAMA||&apos;&#xa2;CD_EMPRESA=&apos;||:GLOBAL.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;  END IF; --IF I_ST_VALPERMISSAO THEN&#xa;  &#xa;  --Busca o nome do arquivo (FMX) do programa, cadastrado no ANV052&#xa;  BEGIN&#xa;    SELECT DESKPROGRAMA.NM_ARQUIVO&#xa;      INTO V_NM_ARQUIVO&#xa;      FROM DESKPROGRAMA&#xa;     WHERE DESKPROGRAMA.NM_PROGRAMA = V_NM_PROGRAMA;&#xa;  EXCEPTION&#xa;    WHEN NO_DATA_FOUND THEN&#xa;      --O programa &#xa2;NM_PROGRAMA&#xa2; n&#xe3;o esta cadastrado. Verifique ANV052.&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4773, &apos;&#xa2;NM_PROGRAMA=&apos;||V_NM_PROGRAMA||&apos;&#xa2;&apos;);&#xa;      RAISE E_GERAL;&#xa;    WHEN OTHERS THEN&#xa;      --Ocorreu um erro ao pesquisar o programa &#xa2;NM_PROGRAMA&#xa2;. Verifique ANV003 ou ANV052. Erro &#xa2;SQLERRM&#xa2;.&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8496, &apos;&#xa2;NM_PROGRAMA=&apos;||V_NM_PROGRAMA||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;      RAISE E_GERAL;&#xa;  END;  &#xa;  &#xa;  --Gravo as globais atuais e altero para o programa chamado&#xa;  IF I_ST_ATUALIZACONEXAO THEN&#xa;    V_CD_MODULO         := :GLOBAL.CD_MODULO;&#xa;    V_CD_PROGRAMA       := :GLOBAL.CD_PROGRAMA;&#xa;    :GLOBAL.CD_MODULO   := I_CD_MODULO;&#xa;    :GLOBAL.CD_PROGRAMA  := I_CD_PROGRAMA;&#xa;    &#xa;    PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#xa;                                 :GLOBAL.CD_EMPRESA,&#xa;                                 I_CD_MODULO,&#xa;                                 I_CD_PROGRAMA);&#xa;  END IF; --IF I_ST_ATUALIZACONEXAO THEN&#xa;  &#xa;  --Chama o form&#xa;  CALL_FORM(V_NM_ARQUIVO, I_TP_DISPLAY, I_TP_MENU, I_TP_QUERY, I_PARAMLIST);&#xa;  &#xa;  IF I_ST_ATUALIZACONEXAO THEN&#xa;    PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#xa;                                 :GLOBAL.CD_EMPRESA,&#xa;                                 V_CD_MODULO,&#xa;                                 V_CD_PROGRAMA);&#xa;  &#xa;    --Retorno os valores das globais&#xa;    :GLOBAL.CD_MODULO    := V_CD_MODULO;&#xa;    :GLOBAL.CD_PROGRAMA := V_CD_PROGRAMA;&#xa;  &#xa;  END IF; --IF I_ST_ATUALIZACONEXAO THEN&#xa;  &#xa;  RETURN NULL; --Sucesso&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    --Retorno os valores das globais&#xa;    IF ((V_CD_MODULO IS NOT NULL) AND (V_CD_PROGRAMA IS NOT NULL)) THEN&#xa;      :GLOBAL.CD_MODULO    := V_CD_MODULO;&#xa;      :GLOBAL.CD_PROGRAMA := V_CD_PROGRAMA;&#xa;      &#xa;      PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#xa;                                   :GLOBAL.CD_EMPRESA,&#xa;                                   V_CD_MODULO,&#xa;                                   V_CD_PROGRAMA);&#xa;    END IF;&#xa;    RETURN V_MENSAGEM;&#xa;  WHEN OTHERS THEN&#xa;    --Retorno os valores das globais&#xa;    IF ((V_CD_MODULO IS NOT NULL) AND (V_CD_PROGRAMA IS NOT NULL)) THEN&#xa;      :GLOBAL.CD_MODULO    := V_CD_MODULO;&#xa;      :GLOBAL.CD_PROGRAMA := V_CD_PROGRAMA;&#xa;      &#xa;      PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#xa;                                   :GLOBAL.CD_EMPRESA,&#xa;                                   V_CD_MODULO,&#xa;                                   V_CD_PROGRAMA);&#xa;    END IF;&#xa;    RETURN &apos;[MAX_CALL_FORM] Ocorreu um erro n&#xe3;o tratado: &apos;||SQLERRM;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="PACK_PREITEMCOMPRA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PACKAGE PACK_PREITEMCOMPRA IS&#xa;  &#xa;  PROCEDURE CARREGA_PREITEMCOMPRA(O_MENSAGEM       OUT VARCHAR2);&#xa;  ----------------------------------------------------------------------------------------------------&#xa;  ----------------------------------------------------------------------------------------------------&#xa;  ----------------------------------------------------------------------------------------------------&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779079" FOLDED="true" MODIFIED="1607991779079" TEXT="PACK_PREITEMCOMPRA">
<icon BUILTIN="Method.public"/>
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="body">
<node CREATED="1607991779079" MODIFIED="1607991779079" TEXT="PACKAGE BODY PACK_PREITEMCOMPRA IS&#xa;  &#xa;  PROCEDURE CARREGA_PREITEMCOMPRA(O_MENSAGEM       OUT VARCHAR2) IS&#xa;    E_GERAL            EXCEPTION;&#xa;    V_INSTRUCAO       VARCHAR2(32000);&#xa;    GRUPO             RECORDGROUP;&#xa;    ERRO              NUMBER;&#xa;  BEGIN&#xa;    V_INSTRUCAO := &apos;SELECT PREITEMCOMPRA.NR_PREITEMCOMPRA, &apos;||CHR(10)||&#xa;                   &apos;       PREITEMCOMPRA.NR_AGRUPAMENTO, &apos;||CHR(10)||&#xa;                   &apos;       PREITEMCOMPRA.DS_ITEM, &apos;||CHR(10)||&#xa;                   &apos;       PREITEMCOMPRA.CD_ITEM, &apos;||CHR(10)||&#xa;                   &apos;       PREITEMCOMPRA.QT_ITEM, &apos;||CHR(10)||&#xa;                   &apos;       PREITEMCOMPRA.DS_OBSERVACAO, &apos;||CHR(10)||&#xa;                   &apos;       ITEM.DS_ITEM DS_ITEMMAXYS, &apos;||CHR(10)||&#xa;                   &apos;       PREITEMCOMPRA.DT_DESEJADA &apos;||CHR(10)||&#xa;                   &apos;  FROM PREITEMCOMPRA, &apos;||CHR(10)||&#xa;                   &apos;       ITEM &apos;||CHR(10)||&#xa;                   &apos; WHERE PREITEMCOMPRA.CD_ITEM = ITEM.CD_ITEM (+) &apos;||CHR(10)||&#xa;                   &apos;   AND PREITEMCOMPRA.ST_PREITEMCOMPRA = &apos;&apos;1&apos;&apos; &apos;||CHR(10)||&#xa;                   &apos;   AND PREITEMCOMPRA.CD_EMPRESA = &apos;||:GLOBAL.CD_EMPRESA||CHR(10)||&#xa;                   &apos; ORDER BY PREITEMCOMPRA.NR_AGRUPAMENTO, &apos;||CHR(10)||&#xa;                   &apos;          PREITEMCOMPRA.NR_PREITEMCOMPRA &apos;;  &#xa;  &#xa;    GRUPO := FIND_GROUP(&apos;GRUPO_PREITEM&apos;);&#xa;    IF NOT ID_NULL(GRUPO) THEN&#xa;      DELETE_GROUP(GRUPO);&#xa;    END IF;&#xa;&#xa;    GRUPO := CREATE_GROUP_FROM_QUERY(&apos;GRUPO_PREITEM&apos;, V_INSTRUCAO);&#xa;    ERRO  := POPULATE_GROUP(GRUPO);&#xa;  &#xa;    IF ERRO = 1403 THEN&#xa;      --A consulta n&#xe3;o retornou dados com base nos filtros/par&#xe2;metros informados.&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1544, NULL);&#xa;      RAISE E_GERAL;&#xa;    ELSIF ERRO NOT IN (0, 1403) THEN&#xa;      --Ocorreu um erro ao realizar a consulta conforme filtros/par&#xe2;metros informados. Erro: &#xa2;SQLERRM&#xa2;.&#xa;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(25697, &apos;&#xa2;SQLERRM=&apos;||ERRO||&apos;&#xa2;&apos;);&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;&#xa;    GO_BLOCK(&apos;PREITEMCOMPRA&apos;);&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    FIRST_RECORD;&#xa;&#xa;    FOR I IN 1..GET_GROUP_ROW_COUNT(&apos;GRUPO_PREITEM&apos;) LOOP&#xa;&#xa;      :PREITEMCOMPRA.NR_ITEMCOMPRA    := GET_GROUP_NUMBER_CELL(&apos;GRUPO_PREITEM.NR_PREITEMCOMPRA&apos;, I);&#xa;      :PREITEMCOMPRA.DS_PREITEMCOMPRA := GET_GROUP_CHAR_CELL(&apos;GRUPO_PREITEM.DS_ITEM&apos;, I);&#xa;      :PREITEMCOMPRA.CD_ITEMAXYS      := GET_GROUP_NUMBER_CELL(&apos;GRUPO_PREITEM.CD_ITEM&apos;, I);&#xa;      :PREITEMCOMPRA.DS_ITEMAXYS      := GET_GROUP_CHAR_CELL(&apos;GRUPO_PREITEM.DS_ITEMMAXYS&apos;, I);&#xa;      :PREITEMCOMPRA.QT_ITEM          := GET_GROUP_NUMBER_CELL(&apos;GRUPO_PREITEM.QT_ITEM&apos;, I); &#xa;      :PREITEMCOMPRA.DS_OBSERVACAO    := GET_GROUP_CHAR_CELL(&apos;GRUPO_PREITEM.DS_OBSERVACAO&apos;, I);&#xa;      :PREITEMCOMPRA.NR_AGRUPAMENTO   := GET_GROUP_NUMBER_CELL(&apos;GRUPO_PREITEM.NR_AGRUPAMENTO&apos;, I);&#xa;      :PREITEMCOMPRA.DT_DESEJADA      := GET_GROUP_DATE_CELL(&apos;GRUPO_PREITEM.DT_DESEJADA&apos;, I);&#xa;&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;  &#xa;    IF (:SYSTEM.CURSOR_RECORD &gt; 1) THEN&#xa;      FIRST_RECORD;&#xa;    END IF;&#xa;  &#xa;  EXCEPTION&#xa;      WHEN E_GERAL THEN&#xa;        O_MENSAGEM := &apos;&#xa5;[CARREGA_PREITEMCOMPRA] &#xa5;&apos;||O_MENSAGEM;&#xa;      WHEN OTHERS THEN&#xa;        O_MENSAGEM := &apos;&#xa5;[CARREGA_PREITEMCOMPRA: Erro] &#xa5;. Erro: &apos;||SQLERRM;&#xa;  END CARREGA_PREITEMCOMPRA;&#xa;  ----------------------------------------------------------------------------------------------------&#xa;  ----------------------------------------------------------------------------------------------------&#xa;  ----------------------------------------------------------------------------------------------------  &#xa;END;"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" ID="ID_748598026" MODIFIED="1607991779080" POSITION="right" TEXT="blocks">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779080" FOLDED="true" ID="ID_1011743021" MODIFIED="1607991779080" TEXT="CONTROLE">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="C&#xf3;digo da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="C&#xf3;digo da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT=":GLOBAL.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="/* MGK:52401:03/12/12&#xa;** Ao validar o campo CD_EMPRESA sem informar nada, ser&#xe1; exibida uma mensagem alertando esse fato, &#xa;** ao inv&#xe9;s de limpar o campo, como estava sendo feito anteriormente.&#xa;*/&#xa;DECLARE&#xa;    I_CD_EMPRESA USUARIOEMPRESA.CD_EMPRESA%TYPE;&#xa;    V_MENSAGEM         VARCHAR2(32000);&#xa;    E_GERAL             EXCEPTION;&#xa;    V_DT_FECHAMENTO   EMPRESA.DT_FECHAMENTO%TYPE;&#xa;BEGIN&#xa;  IF (:CONTROLE.CD_EMPRESA IS NOT NULL) THEN&#xa;      SELECT USUARIOEMPRESA.CD_EMPRESA &#xa;        INTO I_CD_EMPRESA &#xa;        FROM USUARIOEMPRESA&#xa;       WHERE (USUARIOEMPRESA.CD_EMPRESA = :CONTROLE.CD_EMPRESA) &#xa;         AND (USUARIOEMPRESA.CD_USUARIO = :GLOBAL.CD_USUARIO);&#xa;        &#xa;    IF (I_CD_EMPRESA IS NOT NULL) THEN&#xa;      SELECT EMPRESA.NM_EMPRESA, DT_FECHAMENTO &#xa;        INTO :CONTROLE.NM_EMPRESA, V_DT_FECHAMENTO&#xa;         FROM EMPRESA&#xa;       WHERE EMPRESA.CD_EMPRESA = I_CD_EMPRESA;&#xa;    &#xa;      :ITEMCOMPRA.CD_EMPRESAITEM   := :CONTROLE.CD_EMPRESA;&#xa;      :ITEMCOMPRA.CD_EMPRESAUTORIZ := :CONTROLE.CD_EMPRESA;&#xa;      :ITEMCOMPRA.CD_EMPRESA       := :CONTROLE.CD_EMPRESA;&#xa;    END IF;--IF (I_CD_EMPRESA IS NOT NULL) THEN&#xa;    &#xa;    /*CSL:12/12/2013:64048 - Valida&#xe7;&#xe3;o para n&#xe3;o permitir lan&#xe7;amentos posteriores a data de fechamento da empresa.*/&#xa;    IF :CONTROLE.DT_DESEJADA IS NOT NULL THEN&#xa;      IF ((V_DT_FECHAMENTO IS NOT NULL) AND (TRUNC(V_DT_FECHAMENTO) &lt;= TRUNC(:CONTROLE.DT_DESEJADA))) THEN&#xa;        --A Empresa &#xa2;CD_EMPRESA&#xa2; est&#xe1; com a data de fechamento &#xa2;DT_FECHAMENTO&#xa2; informada, n&#xe3;o &#xe9; poss&#xed;vel realizar a opera&#xe7;&#xe3;o. Verifique TCB012.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21846, &apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;DT_FECHAMENTO=&apos;||TO_CHAR(V_DT_FECHAMENTO,&apos;DD/MM/RRRR&apos;)||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    END IF;    &#xa;  ELSE&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4957, NULL);&#xa;    RAISE E_GERAL;&#xa;  END IF;--IF (:CONTROLE.CD_EMPRESA IS NOT NULL) THEN&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    :CONTROLE.NM_EMPRESA := NULL;&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    :CONTROLE.NM_EMPRESA := NULL;&#xa;    --Empresa &#xa2;CD_EMPRESA&#xa2; n&#xe3;o cadastrada ou Usu&#xe1;rio n&#xe3;o tem acesso &#xe0; Empresa.&#xa;    MENSAGEM_PADRAO(278,&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN TOO_MANY_ROWS THEN&#xa;    :CONTROLE.NM_EMPRESA := NULL;&#xa;    --A consulta retornou mais de um resultado ao tentar localizar os dados da empresa &#xa2;CD_EMPRESA&#xa2;. Verifique o programa TCB012.&#xa;    MENSAGEM_PADRAO(216,&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;  &#xa;  WHEN OTHERS THEN       &#xa;    --Erro ao buscar os dados da empresa  &#xa2;CD_EMPRESA&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;    MENSAGEM_PADRAO(35,&apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE; &#xa;    &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="GO_ITEM(&apos;ITEMCOMPRA.DS_OBSERVACAO&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="NM_EMPRESA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Nome da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT=":GLOBAL.DS_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_SOLICAUTORIZ_DEPTO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="DECLARE &#xa;  V_VALIDARALCADA VARCHAR2(1);&#xa;  V_MENSAGEM       VARCHAR2(3200);&#xa;  E_GERAL          EXCEPTION;&#xa;  V_CONT          NUMBER;&#xa;  &#xa;BEGIN&#xa;  IF   :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#xa;    IF (:CONTROLE.CD_DEPARTAMENTO IS NOT NULL) THEN&#xa;      BEGIN&#xa;        SELECT COUNT(*)&#xa;          INTO V_CONT&#xa;          FROM AUTORIZDEPARTCOMPRA &#xa;         WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#xa;           AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR;&#xa;      EXCEPTION&#xa;        WHEN OTHERS THEN&#xa;          V_CONT := 0;&#xa;      END;&#xa;      &#xa;      IF (V_CONT = 0) THEN&#xa;        /*Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o est&#xe1; liberado para o departamento &#xa2;CD_DEPARTAMENTO&#xa2;*/&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34196, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    END IF;&#xa;&#xa;    BEGIN&#xa;      SELECT USUARIO.NM_USUARIO &#xa;        INTO :CONTROLE.NM_USUAUTORIZ &#xa;        FROM USUARIO&#xa;       WHERE USUARIO.CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN  &#xa;        --O Usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o programa  ANV001.&#xa;        MENSAGEM_PADRAO(245,&apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;&apos;);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;    END;&#xa;&#xa;    BEGIN&#xa;     SELECT DISTINCT USUARIO.NM_USUARIO&#xa;        INTO :CONTROLE.NM_USUAUTORIZ&#xa;        FROM SOLICITANTE, PARMCOMPRA, USUARIO &#xa;       WHERE SOLICITANTE.CD_EMPRESA     = PARMCOMPRA.CD_EMPRESA&#xa;         AND USUARIO.CD_USUARIO         = SOLICITANTE.CD_USUARIO&#xa;        --AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.TP_APROVSOLIC&#xa;         AND SOLICITANTE.CD_USUARIO     = :CONTROLE.CD_AUTORIZADOR&#xa;         AND PARMCOMPRA.CD_EMPRESA      = :GLOBAL.CD_EMPRESA;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          --O Usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o &#xe9; autorizador para a empresa &#xa2;CD_EMPRESA&#xa2;. Verifique  o tipo de aprovador no COM009 e o autorizador no TCO002.&#xa;           MENSAGEM_PADRAO(3956, &apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_EMPRESA=&apos;||:GLOBAL.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;        WHEN OTHERS THEN&#xa;          --Erro ao pesquisar se o usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; est&#xe1; cadastrado como solicitante/autorizador. Verifique TCO002. Erro: &#xa2;SQLERRM&#xa2;.  &#xa;          MENSAGEM_PADRAO(15350, &apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;    END; &#xa;   /* WLV:22/08/2012:41514&#xa;    * Adicionado o DISTINCT na consulta, pois quando ha um usu&#xe1;rio autorizador mais de uma vez cadastrada para mesma &#xa;    * empresa com grupos diferentes estourava TOO_MANY_ROWS.&#xa;    */  &#xa;  BEGIN&#xa;  SELECT ST_ALCADA&#xa;  INTO V_VALIDARALCADA&#xa;   FROM PARMCOMPRA &#xa;  WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#xa;  EXCEPTION &#xa;    WHEN OTHERS THEN&#xa;    V_VALIDARALCADA := &apos;N&apos;;&#xa;    &#xa;  END;&#xa;&#xa;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;ST_PERMITEAPROVADORES&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;    IF V_VALIDARALCADA = &apos;S&apos; THEN&#xa;      IF(:CONTROLE.CD_DEPARTAMENTO IS NOT NULL)THEN             &#xa;        BEGIN                  &#xa;          SELECT DISTINCT USUARIO.NM_USUARIO&#xa;            INTO :CONTROLE.NM_USUAUTORIZ&#xa;            FROM SOLICITANTE, PARMCOMPRA , USUARIO, AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA &#xa;           WHERE SOLICITANTE.CD_EMPRESA                  = PARMCOMPRA.CD_EMPRESA&#xa;             AND USUARIO.CD_USUARIO                      = SOLICITANTE.CD_USUARIO&#xa;          --   AND SOLICITANTE.ST_SOLICITANTE              = PARMCOMPRA.TP_APROVSOLIC SOL 137497&#xa;             AND SOLICITANTE.CD_USUARIO                  = :CONTROLE.CD_AUTORIZADOR&#xa;             AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO       = :CONTROLE.CD_DEPARTAMENTO&#xa;             AND DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO       = AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO&#xa;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR       = SOLICITANTE.CD_USUARIO&#xa;             AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = &apos;S&apos;&#xa;             AND PARMCOMPRA.CD_EMPRESA                   = :GLOBAL.CD_EMPRESA;&#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            /*EML:29/07/2019:13058      --O Usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o &#xe9; autorizador para a empresa &#xa2;CD_EMPRESA&#xa2;. Verifique  o tipo de aprovador no COM009 e o autorizador no TCO002.&#xa;             MENSAGEM_PADRAO(3956, &apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_EMPRESA=&apos;||:GLOBAL.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;            RAISE FORM_TRIGGER_FAILURE;*/&#xa;           --O Usu&#xe1;rio Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o est&#xe1; cadastrado como Aprovador de Necessidade para o Departamento de Compra &#xa2;CD_DEPARTAMENTO&#xa2;. Verifique o TCO024.&#xa;            MENSAGEM_PADRAO(21638, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;&apos;);&#xa;            RAISE FORM_TRIGGER_FAILURE;&#xa;          WHEN OTHERS THEN&#xa;            --Erro ao pesquisar se o usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; est&#xe1; cadastrado como solicitante/autorizador. Verifique TCO002. Erro: &#xa2;SQLERRM&#xa2;.  &#xa;            MENSAGEM_PADRAO(15350, &apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;            RAISE FORM_TRIGGER_FAILURE;              &#xa;        END;                            &#xa;      ELSE         &#xa;         BEGIN                  &#xa;         SELECT DISTINCT USUARIO.NM_USUARIO&#xa;           INTO :CONTROLE.NM_USUAUTORIZ&#xa;           FROM SOLICITANTE, PARMCOMPRA , USUARIO, AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA &#xa;          WHERE SOLICITANTE.CD_EMPRESA                   = PARMCOMPRA.CD_EMPRESA&#xa;            AND USUARIO.CD_USUARIO                       = SOLICITANTE.CD_USUARIO&#xa;            AND SOLICITANTE.ST_SOLICITANTE              = PARMCOMPRA.TP_APROVSOLIC&#xa;            AND SOLICITANTE.CD_USUARIO                   = :CONTROLE.CD_AUTORIZADOR&#xa;            AND DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO      = AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO            &#xa;            AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR      = SOLICITANTE.CD_USUARIO&#xa;            AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = &apos;S&apos;&#xa;            AND PARMCOMPRA.CD_EMPRESA                    = :GLOBAL.CD_EMPRESA;&#xa;       EXCEPTION&#xa;         WHEN NO_DATA_FOUND THEN           &#xa;           --O Usu&#xe1;rio Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o est&#xe1; cadastrado como Aprovador de Necessidade.&#xa;           MENSAGEM_PADRAO(32829, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;&apos;);&#xa;           RAISE FORM_TRIGGER_FAILURE;&#xa;         WHEN OTHERS THEN&#xa;           --Erro ao pesquisar se o usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; est&#xe1; cadastrado como solicitante/autorizador. Verifique TCO002. Erro: &#xa2;SQLERRM&#xa2;.  &#xa;           MENSAGEM_PADRAO(15350, &apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;           RAISE FORM_TRIGGER_FAILURE;              &#xa;       END;            &#xa;        --Sugere o Departamento de Compra, caso possuir apenas um cadastrado para o usu&#xe1;rio solicitante logado&#xa;        BEGIN       &#xa;           SELECT DISTINCT DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO, DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#xa;          INTO :CONTROLE.CD_DEPARTAMENTO, :CONTROLE.DS_DEPARTAMENTO  &#xa;          FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#xa;         WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO =  DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO         &#xa;          /* AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO IN&#xa;               (SELECT SOLICDEPARTCOMPRA.CD_DEPARTAMENTO&#xa;                  FROM SOLICDEPARTCOMPRA&#xa;                 WHERE SOLICDEPARTCOMPRA.CD_SOLICITANTE =:GLOBAL.CD_USUARIO)*/&#xa;           AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR       &#xa;           AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = &apos;S&apos;;              &#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            :CONTROLE.CD_DEPARTAMENTO := NULL;&#xa;            :CONTROLE.DS_DEPARTAMENTO := NULL;&#xa;        END;    &#xa;       &#xa;     END IF;         &#xa;       END IF;&#xa;    END IF;&#xa;    &#xa;    /* DCS:25/02/2014:68851&#xa;     * Removida valida&#xe7;&#xe3;o que obriga que o autorizador informado seja um aprovador de necessidade do TCO024&#xa;     */&#xa;    /* DCS:19/11/2013:63403&#xa;     * Caso esteja ativo o controle de Al&#xe7;adas por Departamento,&#xa;     * O Autorizador e Departamento devem estar cadastrados no TCO024&#xa;     */&#xa;/*EML:29/07/2019:13058    &#xa;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;ST_ALCADASDEPTO&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;      IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL AND :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#xa;        BEGIN&#xa;          SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#xa;            INTO :CONTROLE.DS_DEPARTAMENTO&#xa;            FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#xa;           WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#xa;             AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#xa;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#xa;             AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = &apos;S&apos;; --Aprovador de Necedssidade&#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            --O Usu&#xe1;rio Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o est&#xe1; cadastrado como Aprovador de Necessidade para o Departamento de Compra &#xa2;CD_DEPARTAMENTO&#xa2;. Verifique o TCO024.&#xa;            MENSAGEM_PADRAO(21638, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;&apos;);&#xa;            RAISE FORM_TRIGGER_FAILURE;&#xa;          WHEN OTHERS THEN&#xa;            MENSAGEM_PADRAO(21599, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Erro ao pesquisar o Departamento &#xa2;CD_DEPARTAMENTO&#xa2;. Erro &#xa2;SQLERRM&#xa2;. Verifique o TCO024, p&#xe1;gina Departamentos.&#xa;            RAISE FORM_TRIGGER_FAILURE;&#xa;        END;&#xa;      END IF;&#xa;    END IF;&#xa;--/*EML:29/07/2019:13058 */    &#xa;  &#xa;     IF(NVL(:CONTROLE.ST_MUDAUTORIZADOR,&apos;S&apos;) = &apos;S&apos;)THEN               &#xa;      VALIDA_AUTORIZADORCOMPRA(:CONTROLE.CD_AUTORIZADOR, V_MENSAGEM);  &#xa;      IF(V_MENSAGEM  IS NOT NULL)THEN              &#xa;        RAISE E_GERAL;&#xa;      END IF;                           &#xa;    END IF;&#xa;  ELSE &#xa;    :CONTROLE.NM_USUAUTORIZ:=NULL;&#xa;  END IF;  &#xa;  &#xa;EXCEPTION                      &#xa;  WHEN E_GERAL THEN&#xa;    :CONTROLE.NM_USUAUTORIZ:=NULL;&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);                 &#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="BEGIN &#xa;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;ST_PERMITEAPROVADORES&apos;)    ,&apos;N&apos;) = &apos;S&apos; THEN&#xa;     IF SHOW_LOV(&apos;LOV_SOLICAUTORIZ_DEPTO&apos;) THEN&#xa;       NULL;&#xa;     END IF;  &#xa;  ELSE&#xa;   IF SHOW_LOV(&apos;LOV_SOLICAUTORIZ&apos;) THEN&#xa;     NULL;&#xa;   END IF;&#xa; END IF;&#xa;END;&#xa;&#xa;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="NM_USUAUTORIZ: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="CD_TIPOCOMPRA: Number(3)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Tipo Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="C&#xf3;digo do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="C&#xf3;digo do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="DECLARE&#xa;  V_MENSAGEM    VARCHAR2(32000);&#xa;  E_GERAL        EXCEPTION;&#xa;BEGIN&#xa;  &#xa;  IF (:CONTROLE.CD_TIPOCOMPRA IS NOT NULL) THEN&#xa;    BEGIN&#xa;      SELECT TIPOCOMPRA.DS_TIPOCOMPRA,&#xa;             NVL(TIPOCOMPRA.TP_COMPRA,&apos;D&apos;) TP_COMPRA,&#xa;             DECODE(TIPOCOMPRA.TP_COMPRA,&apos;D&apos;,&apos;DIVERSAS&apos;,&#xa;                                         &apos;P&apos;,&apos;PATRIMONIAL&apos;,&#xa;                                         &apos;J&apos;,&apos;JUR&#xcd;DICA&apos;,&#xa;                                         &apos;DIVERSAS&apos;) DS_TPCOMPRA&#xa;        INTO :CONTROLE.DS_TIPOCOMPRA,&#xa;             :CONTROLE.TP_COMPRA,&#xa;             :CONTROLE.DS_TPCOMPRA&#xa;         FROM TIPOCOMPRA&#xa;       WHERE TIPOCOMPRA.CD_TIPOCOMPRA  = :CONTROLE.CD_TIPOCOMPRA&#xa;         AND NVL(TIPOCOMPRA.ST_ATIVO, &apos;A&apos;) = &apos;A&apos;;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;         --Tipo de compra &#xa2;CD_TIPOCOMPRA&#xa2; n&#xe3;o encontrado. Verifique o programa TCO020.&#xa;         V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2693,&apos;&#xa2;CD_TIPOCOMPRA=&apos;||:CONTROLE.CD_TIPOCOMPRA||&apos;&#xa2;&apos;);&#xa;         RAISE E_GERAL;&#xa;      WHEN TOO_MANY_ROWS THEN&#xa;        --Tipo de compra &#xa2;CD_TIPOCOMPRA&#xa2; est&#xe1; cadastrado v&#xe1;rias vezes. Verifique TCO020.&#xa;         V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3752,&apos;&#xa2;CD_TIPOCOMPRA=&apos;||:CONTROLE.CD_TIPOCOMPRA||&apos;&#xa2;&apos;);&#xa;         RAISE E_GERAL; &#xa;       WHEN OTHERS THEN&#xa;         --Ocorreu um erro inesperado ao tentar localizar o tipo de compra  &#xa2;CD_TIPOCOMPRA&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;         V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2695,&apos;&#xa2;CD_TIPOCOMPRA=&apos;||:CONTROLE.CD_TIPOCOMPRA||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);    &#xa;         RAISE E_GERAL;&#xa;    END;&#xa;    &#xa;    IF (NVL(:CONTROLE.TP_COMPRA,&apos;D&apos;) = &apos;J&apos;) THEN&#xa;      SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,           ENABLED, PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,         NAVIGABLE, PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;, VISUAL_ATTRIBUTE, &apos;VSA_CAMPOTEXTO&apos;);  &#xa;    ELSE&#xa;      :CONTROLE.NR_CONTRATO := NULL;      &#xa;      SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,           ENABLED, PROPERTY_FALSE);&#xa;      SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,        NAVIGABLE, PROPERTY_FALSE);      &#xa;      SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;, VISUAL_ATTRIBUTE, &apos;VSA_CAMPOEXIBICAO&apos;);      &#xa;    END IF; --IF (NVL(:CONTROLE.TP_COMPRA,&apos;D&apos;) = &apos;J&apos;) THEN&#xa;  ELSE&#xa;    :CONTROLE.DS_TIPOCOMPRA := NULL;    &#xa;    :CONTROLE.TP_COMPRA      := NULL;&#xa;    :CONTROLE.DS_TPCOMPRA    := NULL;&#xa;    :CONTROLE.NR_CONTRATO   := NULL;&#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,           ENABLED, PROPERTY_FALSE);&#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,        NAVIGABLE, PROPERTY_FALSE);      &#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;, VISUAL_ATTRIBUTE, &apos;VSA_CAMPOEXIBICAO&apos;);        &#xa;  END IF; --IF (:CONTROLE.CD_TIPOCOMPRA IS NOT NULL) THEN&#xa;    &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    :CONTROLE.DS_TIPOCOMPRA := NULL;    &#xa;    :CONTROLE.TP_COMPRA      := NULL;&#xa;    :CONTROLE.DS_TPCOMPRA    := NULL;&#xa;    :CONTROLE.NR_CONTRATO   := NULL;&#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,           ENABLED, PROPERTY_FALSE);&#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,        NAVIGABLE, PROPERTY_FALSE);      &#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;, VISUAL_ATTRIBUTE, &apos;VSA_CAMPOEXIBICAO&apos;);      &#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,V_MENSAGEM,1);    &#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    :CONTROLE.DS_TIPOCOMPRA := NULL;    &#xa;    :CONTROLE.TP_COMPRA      := NULL;&#xa;    :CONTROLE.DS_TPCOMPRA    := NULL;&#xa;    :CONTROLE.NR_CONTRATO   := NULL;&#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,           ENABLED, PROPERTY_FALSE);&#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;,        NAVIGABLE, PROPERTY_FALSE);      &#xa;    SET_ITEM_PROPERTY (&apos;CONTROLE.NR_CONTRATO&apos;, VISUAL_ATTRIBUTE, &apos;VSA_CAMPOEXIBICAO&apos;);      &#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,SQLERRM,1);    &#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="DS_TIPOCOMPRA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Descri&#xe7;&#xe3;o do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="DS_TPCOMPRA: Char(12)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Descri&#xe7;&#xe3;o do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="TP_COMPRA: Char(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="DECLARE&#xa;  V_DT_FECHAMENTO  EMPRESA.DT_FECHAMENTO%TYPE;&#xa;  V_CD_TIPOCOMPRA  TIPOCOMPRA.CD_TIPOCOMPRA%TYPE;&#xa;  V_DS_TIPOCOMPRA  TIPOCOMPRA.DS_TIPOCOMPRA%TYPE;&#xa;  V_MENSAGEM       VARCHAR2(32000);&#xa;  E_GERAL          EXCEPTION;&#xa;BEGIN&#xa;  IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM THEN&#xa;    IF :CONTROLE.DT_DESEJADA IS NOT NULL THEN     &#xa;       /*AUG:130776:15/03/2019 VERIFICA SE O COM001 FOI CHAMADO PELO EMV078 PARA N&#xc3;O VALIDAR A DATA DESEJADA DO PEDIDO INTERNO.&#xa;        *ESTA VALIDA&#xc7;&#xc3;O EST&#xc1; SENDO FEITA AO FINAL DA SOLICITA&#xc7;&#xc3;O DE COMPRA.&#xa;        */&#xa;      IF :PARAMETER.CD_MODULO   &lt;&gt; &apos;EMV&apos; AND&#xa;          :PARAMETER.CD_PROGRAMA &lt;&gt; 78    AND    &#xa;          TRUNC(:CONTROLE.DT_DESEJADA) &lt;= TRUNC(SYSDATE) THEN&#xa;          :CONTROLE.DT_DESEJADA := SYSDATE;&#xa;          --A Data Desejada deve ser maior que a data atual!&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4686,&apos;&apos;);        &#xa;          RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;      /*CSL:12/12/2013:64048 - Valida&#xe7;&#xe3;o para n&#xe3;o permitir lan&#xe7;amentos posteriores a data de fechamento da empresa.*/&#xa;      IF :CONTROLE.CD_EMPRESA IS NOT NULL THEN&#xa;        BEGIN&#xa;          SELECT EMPRESA.DT_FECHAMENTO&#xa;            INTO V_DT_FECHAMENTO&#xa;            FROM EMPRESA&#xa;           WHERE EMPRESA.CD_EMPRESA = :CONTROLE.CD_EMPRESA;&#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3214, NULL);&#xa;            RAISE E_GERAL;&#xa;        END;&#xa;      &#xa;        IF ((V_DT_FECHAMENTO IS NOT NULL) AND (TRUNC(V_DT_FECHAMENTO) &lt;= TRUNC(:CONTROLE.DT_DESEJADA))) THEN&#xa;          --A Empresa &#xa2;CD_EMPRESA&#xa2; est&#xe1; com a data de fechamento &#xa2;DT_FECHAMENTO&#xa2; informada, n&#xe3;o &#xe9; poss&#xed;vel realizar a opera&#xe7;&#xe3;o. Verifique TCB012.&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21846, &apos;&#xa2;CD_EMPRESA=&apos;||:CONTROLE.CD_EMPRESA||&apos;&#xa2;DT_FECHAMENTO=&apos;||TO_CHAR(V_DT_FECHAMENTO,&apos;DD/MM/RRRR&apos;)||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;      END IF;&#xa;      &#xa;      /* DCS:11/02/2014:58880&#xa;       * busca o tipo de compra autom&#xe1;tico cadastrado no TCO20, pela diferen&#xe7;a de dias entre a data de Emiss&#xe3;o e data Desejada&#xa;       */       &#xa;      IF NVL(PACK_COMPRAS.VALIDA_TIPOCOMPRAUTOMATICO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;        PACK_COMPRAS.DEFINE_TIPOCOMPRAUTOMATICO(TRUNC(SYSDATE),&#xa;                                                TRUNC(:CONTROLE.DT_DESEJADA),&#xa;                                                V_CD_TIPOCOMPRA,&#xa;                                                V_DS_TIPOCOMPRA,&#xa;                                                V_MENSAGEM);&#xa;        &#xa;        IF V_MENSAGEM IS NOT NULL THEN&#xa;          RAISE E_GERAL;&#xa;        END IF;        &#xa;        :CONTROLE.CD_TIPOCOMPRA := V_CD_TIPOCOMPRA;&#xa;        :CONTROLE.DS_TIPOCOMPRA := V_DS_TIPOCOMPRA;&#xa;      END IF;&#xa;      &#xa;    ELSE&#xa;      IF NVL(PACK_COMPRAS.VALIDA_TIPOCOMPRAUTOMATICO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;        :CONTROLE.CD_TIPOCOMPRA := NULL;&#xa;        :CONTROLE.DS_TIPOCOMPRA := NULL;&#xa;        :CONTROLE.TP_COMPRA      := NULL;&#xa;        :CONTROLE.DS_TPCOMPRA    := NULL;&#xa;      END IF;&#xa;    END IF;&#xa;  END IF;&#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0),V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM_PADRAO(2627, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Ocorreu um erro inesperado. Erro &#xa2;SQLERRM&#xa2;.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="DT_INICIO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Data de In&#xed;cio p/ Servi&#xe7;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Data de In&#xed;cio dos Servi&#xe7;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Data de In&#xed;cio dos Servi&#xe7;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="BEGIN&#xa;  IF (:CONTROLE.DT_DESEJADA IS NOT NULL) AND (:CONTROLE.DT_INICIO   IS NOT NULL) THEN&#xa;    IF :CONTROLE.DT_INICIO &gt; :CONTROLE.DT_DESEJADA THEN&#xa;      --Data de in&#xed;cio da obra deve ser menor que data desejada.&#xa;      MENSAGEM_PADRAO(4698,&apos;&apos;);&#xa;      :CONTROLE.DT_INICIO := :CONTROLE.DT_DESEJADA;&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;  END IF;&#xa;  &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="NR_CONTRATO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Nr. Contrato">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_ITEMCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="CD_DEPARTAMENTO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="Departamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="C&#xf3;digo do Departamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="LOV_DEPCOMPRAAUTO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="DECLARE&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  V_CD_AUTORIZADOR VARCHAR2(3);&#xa;  E_GERAL     EXCEPTION;&#xa;  V_COUNT      NUMBER;&#xa;  V_CONT      NUMBER;&#xa;BEGIN&#xa;  &#xa;  IF :SYSTEM.TRIGGER_ITEM = :SYSTEM.CURSOR_ITEM THEN&#xa;    IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#xa;      BEGIN&#xa;        SELECT DS_DEPARTAMENTO&#xa;          INTO :CONTROLE.DS_DEPARTAMENTO&#xa;          FROM DEPARTAMENTOCOMPRA&#xa;         WHERE CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21597, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;&apos;); --O Departamento &#xa2;CD_DEPARTAMENTO&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o TCO024, p&#xe1;gina Departamentos.&#xa;          RAISE E_GERAL;&#xa;        WHEN OTHERS THEN&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Erro ao pesquisar o Departamento &#xa2;CD_DEPARTAMENTO&#xa2;. Erro &#xa2;SQLERRM&#xa2;. Verifique o TCO024, p&#xe1;gina Departamentos.&#xa;          RAISE E_GERAL;&#xa;      END;&#xa;      &#xa;     /* DCS:25/02/2014:68851&#xa;      * valida se o departamento esta cadastrado para o Solicitante no TCO024&#xa;      */&#xa;      BEGIN&#xa;        SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#xa;          INTO :CONTROLE.DS_DEPARTAMENTO&#xa;          FROM SOLICDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#xa;         WHERE SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#xa;           AND SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#xa;           AND SOLICDEPARTCOMPRA.CD_SOLICITANTE  = :GLOBAL.CD_USUARIO;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22640, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;CD_SOLICITANTE=&apos;||:GLOBAL.CD_USUARIO||&apos;&#xa2;&apos;); --O Departamento de Compra &#xa2;CD_DEPARTAMENTO&#xa2; n&#xe3;o est&#xe1; cadastrado para o Usu&#xe1;rio Soliciante &#xa2;CD_SOLICITANTE&#xa2;. Verifique o TCO024.&#xa;          RAISE E_GERAL;&#xa;        WHEN OTHERS THEN&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Erro ao pesquisar o Departamento &#xa2;CD_DEPARTAMENTO&#xa2;. Erro &#xa2;SQLERRM&#xa2;. Verifique o TCO024, p&#xe1;gina Departamentos.&#xa;          RAISE E_GERAL;&#xa;      END;&#xa;&#xa;      IF (:CONTROLE.CD_AUTORIZADOR IS NOT NULL) THEN&#xa;        BEGIN&#xa;          SELECT COUNT(*)&#xa;            INTO V_CONT&#xa;            FROM AUTORIZDEPARTCOMPRA &#xa;           WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#xa;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR;&#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            V_CONT := 0;&#xa;        END;&#xa;&#xa;        IF (V_CONT = 0) THEN&#xa;          /*Autorizador &#xa2;CD_AUTORIZADOR&#xa2; n&#xe3;o est&#xe1; liberado para o departamento &#xa2;CD_DEPARTAMENTO&#xa2;*/&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34196, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;      END IF;&#xa;&#xa;        IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;ST_PERMITEAPROVADORES&apos;)    ,&apos;N&apos;) = &apos;S&apos; THEN   &#xa;          IF(:CONTROLE.CD_AUTORIZADOR IS NOT NULL)THEN&#xa;            V_CD_AUTORIZADOR := :CONTROLE.CD_AUTORIZADOR;&#xa;           ELSE                                           &#xa;             V_CD_AUTORIZADOR := :GLOBAL.CD_USUARIO;&#xa;          END IF;    &#xa;                  &#xa;                &#xa;          /* DCS:25/02/2014:68851&#xa;          * valida se o departamento esta cadastrado para o Solicitante no TCO024&#xa;          */&#xa;          BEGIN&#xa;            SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#xa;              INTO :CONTROLE.DS_DEPARTAMENTO&#xa;              FROM SOLICDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#xa;             WHERE SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#xa;               AND SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#xa;               AND SOLICDEPARTCOMPRA.CD_SOLICITANTE  = :GLOBAL.CD_USUARIO;&#xa;          EXCEPTION&#xa;            WHEN NO_DATA_FOUND THEN&#xa;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22640, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;CD_SOLICITANTE=&apos;||V_CD_AUTORIZADOR||&apos;&#xa2;&apos;); --O Departamento de Compra &#xa2;CD_DEPARTAMENTO&#xa2; n&#xe3;o est&#xe1; cadastrado para o Usu&#xe1;rio Soliciante &#xa2;CD_SOLICITANTE&#xa2;. Verifique o TCO024.&#xa;              RAISE E_GERAL;&#xa;            WHEN OTHERS THEN&#xa;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Erro ao pesquisar o Departamento &#xa2;CD_DEPARTAMENTO&#xa2;. Erro &#xa2;SQLERRM&#xa2;. Verifique o TCO024, p&#xe1;gina Departamentos.&#xa;              RAISE E_GERAL;&#xa;          END;&#xa;            &#xa;        BEGIN                              &#xa;          SELECT DISTINCT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#xa;            INTO :CONTROLE.DS_DEPARTAMENTO  &#xa;            FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#xa;           WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO =  DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO         &#xa;           /*  AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO IN&#xa;                 (SELECT SOLICDEPARTCOMPRA.CD_DEPARTAMENTO&#xa;                    FROM SOLICDEPARTCOMPRA&#xa;                   WHERE SOLICDEPARTCOMPRA.CD_SOLICITANTE = V_CD_AUTORIZADOR  )*/&#xa;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = V_CD_AUTORIZADOR&#xa;             AND DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#xa;             AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = &apos;S&apos;;         &#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22640, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;CD_SOLICITANTE=&apos;||V_CD_AUTORIZADOR||&apos;&#xa2;&apos;); --O Departamento de Compra &#xa2;CD_DEPARTAMENTO&#xa2; n&#xe3;o est&#xe1; cadastrado para o Usu&#xe1;rio Soliciante &#xa2;CD_SOLICITANTE&#xa2;. Verifique o TCO024.&#xa;            RAISE E_GERAL;&#xa;          WHEN OTHERS THEN&#xa;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, &apos;&#xa2;CD_DEPARTAMENTO=&apos;||:CONTROLE.CD_DEPARTAMENTO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Erro ao pesquisar o Departamento &#xa2;CD_DEPARTAMENTO&#xa2;. Erro &#xa2;SQLERRM&#xa2;. Verifique o TCO024, p&#xe1;gina Departamentos.&#xa;            RAISE E_GERAL;&#xa;        END;              &#xa;      END IF;&#xa;      &#xa;      /*GBO:20/12/2019:142153*/&#xa;      IF :CONTROLE.NR_LOTECOMPRA IS NULL THEN&#xa;        BEGIN&#xa;          SELECT COUNT(*) &#xa;            INTO V_COUNT&#xa;            FROM PROJETOCOMPRA&#xa;           WHERE PROJETOCOMPRA.CD_EMPRESA      = :CONTROLE.CD_EMPRESA&#xa;             AND PROJETOCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#xa;             AND PROJETOCOMPRA.ST_PROJETO     IN (&apos;A&apos;, &apos;B&apos;);&#xa;        EXCEPTION&#xa;          WHEN OTHERS THEN&#xa;            V_COUNT := 0;&#xa;        END;&#xa;        IF V_COUNT &gt; 0 THEN&#xa;          SET_ITEM_PROPERTY(&apos;CONTROLE.BTN_CAPEX&apos;,VISIBLE,PROPERTY_TRUE);&#xa;          SET_ITEM_PROPERTY(&apos;CONTROLE.BTN_CAPEX&apos;,ENABLED,PROPERTY_TRUE);&#xa;        ELSE&#xa;          SET_ITEM_PROPERTY(&apos;CONTROLE.BTN_CAPEX&apos;,VISIBLE,PROPERTY_FALSE);&#xa;          SET_ITEM_PROPERTY(&apos;CONTROLE.BTN_CAPEX&apos;,ENABLED,PROPERTY_FALSE);&#xa;          :CONTROLE.CD_PROJETOCOMPRA := NULL;&#xa;        END IF;&#xa;      END IF;&#xa;    ELSE&#xa;      :CONTROLE.CD_DEPARTAMENTO := NULL;&#xa;      :CONTROLE.DS_DEPARTAMENTO := NULL;&#xa;      SET_ITEM_PROPERTY(&apos;CONTROLE.BTN_CAPEX&apos;,VISIBLE,PROPERTY_FALSE);&#xa;      SET_ITEM_PROPERTY(&apos;CONTROLE.BTN_CAPEX&apos;,ENABLED,PROPERTY_FALSE);&#xa;      :CONTROLE.CD_PROJETOCOMPRA := NULL;&#xa;    END IF;&#xa;  END IF;&#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0),V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM_PADRAO(2627, &apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;); --Ocorreu um erro inesperado. Erro &#xa2;SQLERRM&#xa2;.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="body">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="BEGIN &#xa;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;ST_PERMITEAPROVADORES&apos;)    ,&apos;N&apos;) = &apos;S&apos; THEN&#xa;     IF SHOW_LOV(&apos;LOV_DEPCOMPRAAUTO&apos;) THEN&#xa;       NULL;&#xa;     END IF;  &#xa;  ELSE&#xa;   IF SHOW_LOV(&apos;LOV_DEPARTAMENTOCOMPRA&apos;) THEN&#xa;     NULL;&#xa;   END IF;&#xa; END IF;&#xa;END;&#xa;&#xa;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779080" FOLDED="true" MODIFIED="1607991779080" TEXT="DS_DEPARTAMENTO: Char(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="@">
<node CREATED="1607991779080" MODIFIED="1607991779080" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Descri&#xe7;&#xe3;o do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="NR_LOTECOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="N&#xfa;mero do Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="LOV_COMPRAS">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="DT_ANOSAFRA: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Ano Safra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;  V_INSTRUCAO       VARCHAR2(1000);&#xa;  V_ERRO            NUMBER;&#xa;  V_MENSAGEM        VARCHAR2(32000);     &#xa;  V_CD_EMPRESA      ITEMCOMPRA.CD_EMPRESA%TYPE;&#xa;  V_NR_LOTECOMPRA    ITEMCOMPRA.NR_ITEMCOMPRA%TYPE;  &#xa;BEGIN  &#xa;  IF :CONTROLE.NR_LOTECOMPRA IS NOT NULL AND :CONTROLE.CD_EMPRESA IS NOT NULL THEN&#xa;    PACK_PROCEDIMENTOS.V_DUPLICADO := FALSE; /*ATR:80785:11/02/2015*/&#xa;    V_NR_LOTECOMPRA := :CONTROLE.NR_LOTECOMPRA;&#xa;    V_CD_EMPRESA    := :CONTROLE.CD_EMPRESA;&#xa;    CLEAR_FORM(NO_VALIDATE);      &#xa;    /**KRG:03/06/2008:18311&#xa;     * Comentado pois o campo &#xe9; de f&#xf3;rmula, e na f&#xf3;rmula j&#xe1; faz receber a PACK_GLOBAL.TP_PEDIDO.&#xa;     */&#xa;    --:CONTROLE.TP_PEDIDO := PACK_GLOBAL.TP_PEDIDO; &#xa;    SET_BLOCK_PROPERTY(&apos;ITEMCOMPRA&apos;,DEFAULT_WHERE,&apos;     CD_EMPRESA    = &apos;||V_CD_EMPRESA||&#xa;                                                  &apos; AND NR_LOTECOMPRA = &apos;||V_NR_LOTECOMPRA);&#xa;    &#xa;    GO_BLOCK(&apos;ITEMCOMPRA&apos;); &#xa;    &#xa;    EXECUTE_QUERY;  &#xa;    LAST_RECORD;  &#xa;    :CONTROLE.CD_EMPRESA    := V_CD_EMPRESA;&#xa;    :CONTROLE.NR_LOTECOMPRA := V_NR_LOTECOMPRA;   &#xa;    V_INSTRUCAO := &apos;SELECT  ITEMCOMPRA.CD_ITEM,&#xa;                            ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#xa;                             ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#xa;                             ITEMCOMPRACCUSTO.CD_AUTORIZADOR,&#xa;                             ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL,&#xa;                             ITEMCOMPRACCUSTO.PC_PARTICIPACAO,&#xa;                             ITEMCOMPRACCUSTO.NR_ITEMCOMPRA,&#xa;                             ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,&#xa;                             ITEMCOMPRACCUSTO.CD_NEGOCIO,&#xa;                             ITEMCOMPRACCUSTO.DS_OBSERVACAO,&#xa;                             ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&#xa;                       FROM ITEMCOMPRACCUSTO,&#xa;                             ITEMCOMPRA&#xa;                      WHERE ITEMCOMPRA.CD_EMPRESA     = ITEMCOMPRACCUSTO.CD_EMPRESA&#xa;                        AND ITEMCOMPRA.NR_ITEMCOMPRA = ITEMCOMPRACCUSTO.NR_ITEMCOMPRA &#xa;                        AND ITEMCOMPRA.CD_EMPRESA    = &apos;||V_CD_EMPRESA||&apos;&#xa;                        AND ITEMCOMPRA.NR_LOTECOMPRA = &apos;||V_NR_LOTECOMPRA; &#xa;      -- Removido pois est&#xe1; trazendo as compras apenas status 11 e 2&#xa;      -- AND ITEMCOMPRACCUSTO.ST_ITEMCOMPRA  &lt;&gt; 2&#xa;      --------------------------------------------------------------------------&#xa;      -- CARREGA RECORDGROUP&#xa;      --------------------------------------------------------------------------              &#xa;      &#xa;    &#xa;    CRIA_RECORDGROUP(&apos;GRUPO_CC&apos;,V_INSTRUCAO,V_ERRO);&#xa;    DELETE ITEMCOMPRACCUSTO                              &#xa;     WHERE (CD_EMPRESA,NR_ITEMCOMPRA) IN (SELECT CD_EMPRESA,NR_ITEMCOMPRA&#xa;                                            FROM ITEMCOMPRA&#xa;                                           WHERE CD_EMPRESA    = V_CD_EMPRESA&#xa;                                             AND NR_LOTECOMPRA = V_NR_LOTECOMPRA) ;&#xa;    &#xa;&#xa;    PACK_GRAVALIBERACAO.GRAVA_VETOR(:CONTROLE.CD_EMPRESA,     &#xa;                                    :CONTROLE.CD_AUTORIZADOR, &#xa;                                    :CONTROLE.CD_TIPOCOMPRA,  &#xa;                                    :CONTROLE.DT_DESEJADA,&#xa;                                    :CONTROLE.NR_LOTECOMPRA,&#xa;                                    :CONTROLE.DT_INICIO,&#xa;                                    :CONTROLE.NR_CONTRATO,&#xa;                                    :CONTROLE.CD_DEPARTAMENTO,&#xa;                                    V_MENSAGEM);         &#xa;                                             &#xa;    PACK_GRAVALIBERACAO.GRAVA_VETOR_ITENS(V_MENSAGEM);                         &#xa;                                             &#xa;  ELSE&#xa;    GO_ITEM(&apos;ITEMCOMPRA.CD_ITEM&apos;);&#xa;  END IF;  &#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;  V_MENSAGEM           VARCHAR2(32000);&#xa;  E_GERAL               EXCEPTION;&#xa;BEGIN&#xa;  &#xa;  &#xa;  PACK_PROCEDIMENTOS.VALIDA_ANOSAFRA(V_MENSAGEM);&#xa;  IF (V_MENSAGEM IS NOT NULL) THEN&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,V_MENSAGEM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;  V_MENSAGEM           VARCHAR2(32000);&#xa;  E_GERAL               EXCEPTION;&#xa;  V_ST_VALIDA_ANOSAFRA VARCHAR2(1);&#xa;BEGIN&#xa;&#xa;  V_ST_VALIDA_ANOSAFRA := PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;VFT&apos;,4,&apos;MAX&apos;,1,&apos;LST_ANOSAFRA&apos;);&#xa;&#xa;  IF (NVL(V_ST_VALIDA_ANOSAFRA,&apos;N&apos;) IN (&apos;S&apos;,&apos;I&apos;)) THEN&#xa;    IF SHOW_LOV(&apos;LOV_ANOSAFRA&apos;) THEN&#xa;      NULL;&#xa;    END IF;&#xa;    VALIDATE(ITEM_SCOPE);&#xa;  END IF;&#xa;&#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,V_MENSAGEM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="DS_ANOSAFRA: Char(70)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@"/>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="BTN_CAPEX: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="CAPEX">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;  V_PARAMPROJETOCOMPRA  PARAMLIST;&#xa;  V_MENSAGEM            VARCHAR2(32000);&#xa;BEGIN&#xa;  IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#xa;    V_PARAMPROJETOCOMPRA := GET_PARAMETER_LIST(&apos;V_PARAMPROJETOCOMPRA&apos;);&#xa;    IF ( NOT ID_NULL(V_PARAMPROJETOCOMPRA) ) THEN&#xa;      DESTROY_PARAMETER_LIST(V_PARAMPROJETOCOMPRA);&#xa;    END IF;&#xa;    V_PARAMPROJETOCOMPRA := CREATE_PARAMETER_LIST(&apos;V_PARAMPROJETOCOMPRA&apos;);&#xa;    ADD_PARAMETER(V_PARAMPROJETOCOMPRA,&apos;CD_DEPARTAMENTO&apos; ,TEXT_PARAMETER, :CONTROLE.CD_DEPARTAMENTO );&#xa;    V_MENSAGEM := MAX_CALL_FORM(&apos;SEL&apos;,392, NO_HIDE, NO_REPLACE, NO_QUERY_ONLY, V_PARAMPROJETOCOMPRA);&#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      MENSAGEM(&apos;MAX&apos;,V_MENSAGEM,2);&#xa;    END IF;&#xa;    IF PACK_PROJETO_COMPRAS.GET_PROJETO_SELECIONADO IS NULL THEN&#xa;      /*Procedimento cancelado pelo usu&#xe1;rio.*/&#xa;      MENSAGEM_PADRAO(588, NULL);&#xa;    ELSE&#xa;      :CONTROLE.CD_PROJETOCOMPRA := PACK_PROJETO_COMPRAS.GET_PROJETO_SELECIONADO;&#xa;    END IF;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="GO_ITEM(&apos;ITEMCOMPRA.CD_ITEM&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="TP_PEDIDO: Char(2)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@"/>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="DS_OBSCANCEL: Char(500)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Motivo Devolu&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="BT_INCLUIR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="BEGIN&#xa;   GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;   SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="BT_GRAFICO: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE  &#xa;  PARAMETROS PARAMLIST; &#xa;      &#xa;BEGIN&#xa;  &#xa;  PARAMETROS := GET_PARAMETER_LIST(&apos;PARAMETROS&apos;);&#xa;  IF NOT ID_NULL(PARAMETROS) THEN&#xa;    DESTROY_PARAMETER_LIST(&apos;PARAMETROS&apos;);&#xa;  END IF;&#xa;&#xa;  PARAMETROS := CREATE_PARAMETER_LIST(&apos;PARAMETROS&apos;);&#xa;  ADD_PARAMETER(PARAMETROS, &apos;V_CD_ITEM&apos;,      TEXT_PARAMETER,:ITEMCOMPRA.CD_ITEM);&#xa;  ADD_PARAMETER(PARAMETROS, &apos;DESNAME&apos;,        TEXT_PARAMETER,&apos;Gr&#xe1;fico de Cota&#xe7;&#xe3;o Anual&apos;);&#xa;  ADD_PARAMETER(PARAMETROS, &apos;WINDOW_STATE&apos;,   TEXT_PARAMETER,&apos;MAXIMIZE&apos;);&#xa;  RUN_PRODUCT(GRAPHICS,:GLOBAL.VL_CURRENTPATH||&apos;\COTACAO.OGD&apos;,ASYNCHRONOUS,RUNTIME,FILESYSTEM,PARAMETROS,&apos;&apos;);&#xa;  &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="LST_AUTOSUGESTAO: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Op&#xe7;&#xf5;es de auto-sugest&#xe3;o (Quantidade e % Partic.)">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="2">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-LIST-CHANGED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  E_GERAL      EXCEPTION;&#xa;BEGIN&#xa;&#xa;  PACK_PARMGEN.AJUSTA_PARAMETRO(I_CD_MODULO        =&gt; :GLOBAL.CD_MODULO,&#xa;                                I_CD_PROGRAMA      =&gt; :GLOBAL.CD_PROGRAMA,&#xa;                                I_CD_USUARIO        =&gt; &apos;MAX&apos;,&#xa;                                I_CD_VERSAOPARMGEN =&gt; :GLOBAL.CD_EMPRESA,&#xa;                                I_NM_PARAMETRO      =&gt; &apos;ST_AUTOSUGESTAO&apos;,&#xa;                                I_VL_PARAMETRO      =&gt; :CONTROLE.LST_AUTOSUGESTAO,&#xa;                                O_DS_MENSAGEM      =&gt; V_MENSAGEM);&#xa;  FAZ_COMMIT;&#xa;&#xa;  IF (:CONTROLE.LST_AUTOSUGESTAO = 2) THEN&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_FALSE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,NAVIGABLE,PROPERTY_FALSE);  &#xa;    &#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,ENABLED,PROPERTY_TRUE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,NAVIGABLE,PROPERTY_TRUE);  &#xa;  ELSIF (:CONTROLE.LST_AUTOSUGESTAO = 5) THEN&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,ENABLED,PROPERTY_FALSE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,NAVIGABLE,PROPERTY_FALSE);    &#xa;    &#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_TRUE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;  ELSE  &#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,ENABLED,PROPERTY_TRUE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;    &#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_TRUE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;  END IF;&#xa;  &#xa;  /*ASF:19/02/2020:140506&#xa;  IF (:CONTROLE.LST_AUTOSUGESTAO = 5) THEN&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,ENABLED,PROPERTY_FALSE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,NAVIGABLE,PROPERTY_FALSE);&#xa;    &#xa;    SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;, ENABLED, PROPERTY_TRUE);      &#xa;    SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;, NAVIGABLE, PROPERTY_TRUE);&#xa;  ELSE&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,ENABLED,PROPERTY_TRUE);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;    &#xa;    SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;, ENABLED, PROPERTY_TRUE);     &#xa;  END IF;*/&#xa;  &#xa;  GO_ITEM(&apos;ITEMCOMPRACCUSTO.DS_OBSERVACAO&apos;);&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,V_MENSAGEM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="GO_ITEM(&apos;ITEMCOMPRACCUSTO.DS_OBSERVACAO&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="BT_SALVAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;  V_MENSAGEM                    VARCHAR2(32000);&#xa;  E_GERAL                       EXCEPTION;    &#xa;BEGIN&#xa;  &#xa;  IF (:ITEMCOMPRA.DS_OBSCANCEL IS NULL) THEN&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12107, NULL); -- O Campo Descri&#xe7;&#xe3;o da Observa&#xe7;&#xe3;o n&#xe3;o pode ser nulo!&#xa;    GO_ITEM(&apos;ITEMCOMPRA.DS_OBSCANCEL&apos;);&#xa;    RAISE E_GERAL;&#xa;  END IF; --IF (:CONTROLE.DS_OBSCANCEL IS NULL) THEN&#xa;  --------------------------------------------------&#xa;  /**FLA:24/02/2020:144838&#xa;   * Adi&#xe7;&#xe3;o de condi&#xe7;&#xe3;o para n&#xe3;o permitir cancelamento de solicita&#xe7;&#xe3;o de compra caso esteja em algum status&#xa;   * al&#xe9;m de &apos;N&#xe3;o Atendido&apos; e &apos;Parcialmente Atendido&apos;&#xa;   */&#xa;  IF :ITEMCOMPRA.ST_ITEMCOMPRA IN (1, 2) THEN&#xa;    &#xa;    IF (SHOW_ALERT(&apos;EXCLUSAO&apos;) = ALERT_BUTTON1) THEN&#xa;      IF (:GLOBAL.ST_AUDITORIA = &apos;S&apos;) THEN&#xa;        GO_BLOCK(:GLOBAL.MD_BLOCO);&#xa;        AUDITA_EXCLUSAO;&#xa;      END IF; --IF (:GLOBAL.ST_AUDITORIA = &apos;S&apos;) THEN&#xa;      ----------------------------------------------&#xa;      &#xa;      CANCELAR_ITEMCOMPRA (I_NR_ITEMCOMPRA =&gt; :ITEMCOMPRA.NR_ITEMCOMPRA,&#xa;                           I_CD_EMPRESA    =&gt; :ITEMCOMPRA.CD_EMPRESA,&#xa;                           I_CD_ITEM        =&gt; :ITEMCOMPRA.CD_ITEM,&#xa;                           O_MENSAGEM       =&gt; V_MENSAGEM);&#xa;      IF (V_MENSAGEM IS NOT NULL) THEN&#xa;        RAISE E_GERAL;&#xa;      END IF; --IF (V_MENSAGEM IS NOT NULL) THEN&#xa;    &#xa;      ------------------------------------------&#xa;      &#xa;      CLEAR_RECORD;&#xa;      IF (FORM_SUCCESS) THEN&#xa;        COMMIT;&#xa;        GO_ITEM(&apos;CONTROLE.NR_LOTECOMPRA&apos;); /*WLV:16/02/2012:40906 - Adicionado para atualizar a janela apos o cancelamento do item*/&#xa;        EXECUTE_TRIGGER(&apos;KEY-NEXT-ITEM&apos;);&#xa;      END IF; --IF (FORM_SUCCESS) THEN&#xa;    END IF; --IF (V_ALERT = ALERT_BUTTON1) THEN&#xa;      &#xa;  ELSE&#xa;    /*N&#xe3;o foi poss&#xed;vel Cancelar a Solicita&#xe7;&#xe3;o N&#xba; &#xa2;NR_ITEMCOMPRA&#xa2;, pois ele esta com Status &#xa2;ST_ITEMCOMPRA&#xa2;.*/&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12106, &apos;&#xa2;NR_ITEMCOMPRA=&apos;||:ITEMCOMPRA.NR_ITEMCOMPRA||&#xa;                                                   &apos;&#xa2;ST_ITEMCOMPRA=&apos;||:ITEMCOMPRA.ST_ITEMCOMPRA ||&apos; - &apos;||PACK_COMPRAS.RETORNA_ST_ITEMCOMPRACCUSTO(:ITEMCOMPRA.ST_ITEMCOMPRA)||&apos;&#xa2;&apos;);&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    FAZ_ROLLBACK;&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="GO_ITEM(&apos;CONTROLE.BT_VOLTAR&apos;);"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="GO_ITEM(&apos;ITEMCOMPRA.DS_OBSCANCEL&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="BT_VOLTAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="BEGIN&#xa;  :ITEMCOMPRA.DS_OBSCANCEL := NULL;&#xa;  GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="GO_ITEM(&apos;ITEMCOMPRA.DS_OBSCANCEL&apos;);"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="GO_ITEM(&apos;CONTROLE.BT_SALVAR&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="CD_CONTAORCAMENTO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@"/>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="CD_CONTACONTABIL: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@"/>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="BTN_CAMINHOITEM: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Abrir o Arquivo de Retorno">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;   V_NOMEARQ       VARCHAR2(255); -- recebe o arquivo texto&#xa;   V_NM_ARQRETORNO VARCHAR2(60);&#xa;   V_TP_ARQUIVO     LAYOUTARQUIVO.TP_ARQUIVO%TYPE;&#xa;   V_DS_EXTENSAO   VARCHAR2(32000);&#xa;   V_MENSAGEM       VARCHAR2(32000);&#xa;   E_GERAL EXCEPTION;&#xa;BEGIN&#xa;  :CONTROLE.CD_LAYOUT := PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;REC&apos;,10,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;CD_LAYOUT&apos;);&#xa;  IF(:CONTROLE.CD_LAYOUT IS NULL)THEN     &#xa;  --Necess&#xe1;rio informar um layout de importa&#xe7;&#xe3;o de planilha no REC010, page Compras.&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32845, NULL);&#xa;    RAISE E_GERAL;&#xa;  END IF;    &#xa;  &#xa;  BEGIN  &#xa;    SELECT LAYOUTARQUIVO.TP_ARQUIVO&#xa;      INTO V_TP_ARQUIVO&#xa;      FROM LAYOUTARQUIVO&#xa;     WHERE LAYOUTARQUIVO.CD_LAYOUT = :CONTROLE.CD_LAYOUT; &#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      V_TP_ARQUIVO := NULL;&#xa;  END ;&#xa;  /*&#xa;  1 - Texto com largura fixa&#xa;  2 - Texto com separadores&#xa;  3 - Excel (XLS ou XLSX)&#xa;  4 - XML;&#xa;  */&#xa;  IF NVL(V_TP_ARQUIVO, 0) = 1 THEN&#xa;    V_DS_EXTENSAO := &apos;Arquivo de Texto  (*.txt)|*.txt|&apos;;&#xa;  ELSIF NVL(V_TP_ARQUIVO, 0) = 2 THEN&#xa;    V_DS_EXTENSAO := &apos;Arquivo CSV  (*.csv)|*.csv|&apos;||&#xa;                     &apos;Arquivo de Texto  (*.txt)|*.txt|&apos;;&#xa;  ELSIF NVL(V_TP_ARQUIVO, 0) = 3 THEN&#xa;    V_DS_EXTENSAO := &apos;Arquivo do Excel (*.xlsx)|*.xlsx|&apos;||&#xa;                     &apos;Arquivo do Excel 2003-2007  (*.xls)|*.xls|&apos;||                     &#xa;                     &apos;Arquivo CSV  (*.csv)|*.csv|&apos;;&#xa;  ELSIF NVL(V_TP_ARQUIVO, 0) = 4 THEN&#xa;    V_DS_EXTENSAO := &apos;Arquivo XML  (*.xml)|*.xml|&apos;;                 &#xa;  ELSE&#xa;    V_DS_EXTENSAO := &apos;Arquivo de Texto  (*.txt)|*.txt|&apos;||&#xa;                     &apos;Arquivo CSV  (*.csv)|*.csv|&apos;||&#xa;                     &apos;Arquivo do Excel 2003-2007  (*.xls)|*.xls|&apos;||&#xa;                     &apos;Arquivo do Excel (*.xlsx)|*.xlsx|&apos;||&#xa;                     &apos;Arquivo XML  (*.xml)|*.xml|&apos;;&#xa;  END IF;&#xa;  &#xa;   -- Chama o Arquivo Texto pela Fun&#xe7;&#xe3;o Open_File&#xa;   /*&#xa;   V_NOMEARQ := GET_FILE_NAME(V_NM_ARQRETORNO,&#xa;                              NULL,&#xa;                              &apos;Arquivo de Texto  (*.txt)|*.txt|&apos;||&#xa;                              &apos;Arquivo CSV  (*.csv)|*.csv|&apos;||&#xa;                              &apos;Arquivo do Excel 2003-2007  (*.xls)|*.xls|&apos;||&#xa;                              &apos;Arquivo do Excel (*.xlsx)|*.xlsx|&apos;||&#xa;                              &apos;Arquivo XML  (*.xml)|*.xml|&apos;&#xa;                              ,NULL,&#xa;                              OPEN_FILE,&#xa;                              TRUE);&#xa;   */                               &#xa;   V_NOMEARQ := GET_FILE_NAME(V_NM_ARQRETORNO,&#xa;                              NULL,&#xa;                              V_DS_EXTENSAO,&#xa;                              NULL,&#xa;                              OPEN_FILE,&#xa;                              TRUE);                      &#xa;   :ITEMCOMPRACCUSTO.DS_CAMINHO := V_NOMEARQ;    &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;   &#xa;END;&#xa;  &#xa;  &#xa;  &#xa;&#xa;&#xa;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="DS_LOG: Button(32676)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="BTN_VOLTARLOG: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="CD_LAYOUT: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@"/>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="ST_MUDAUTORIZADOR: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="S">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="CD_PROJETOCOMPRA: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@"/>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="CHK_MARCARTODOS: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Marcar Todos">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="N">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-CHECKBOX-CHANGED">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;  V_REG_ATUAL      NUMBER;&#xa;BEGIN&#xa;  V_REG_ATUAL   := :SYSTEM.CURSOR_RECORD;&#xa;  GO_BLOCK(&apos;PREITEMCOMPRA&apos;);&#xa;  FIRST_RECORD;&#xa;&#xa;  LOOP&#xa;    IF (GET_ITEM_PROPERTY(&apos;CONTROLE.CHK_MARCARTODOS&apos;, PROMPT_TEXT) = &apos;Marcar Todos&apos;) THEN&#xa;      :PREITEMCOMPRA.ST_MARCADO := 1;&#xa;    ELSE&#xa;      :PREITEMCOMPRA.ST_MARCADO := 0;&#xa;    END IF; --IF (GET_ITEM_PROPERTY(&apos;CONTROLE.CHK_MARCARTODOS&apos;,PROMPT_TEXT) = &apos;Marcar Todos&apos;) THEN&#xa;&#xa;    EXIT WHEN (:SYSTEM.LAST_RECORD =  &apos;TRUE&apos;);&#xa;    NEXT_RECORD;&#xa;  END LOOP;&#xa;&#xa;   GO_RECORD(V_REG_ATUAL);&#xa;&#xa;  IF (GET_ITEM_PROPERTY(&apos;CONTROLE.CHK_MARCARTODOS&apos;, PROMPT_TEXT) = &apos;Marcar Todos&apos;) THEN&#xa;    SET_ITEM_PROPERTY(&apos;CONTROLE.CHK_MARCARTODOS&apos;, PROMPT_TEXT, &apos;Desmarcar Todos&apos;);&#xa;  ELSE&#xa;    SET_ITEM_PROPERTY(&apos;CONTROLE.CHK_MARCARTODOS&apos;, PROMPT_TEXT, &apos;Marcar Todos&apos;);&#xa;  END IF; --IF (GET_ITEM_PROPERTY(&apos;CONTROLE.CHK_MARCARTODOS&apos;,PROMPT_TEXT) = &apos;Marcar Todos&apos;) THEN&#xa;&#xa;EXCEPTION&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||&apos; - Erro&apos;, SQLERRM, 1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" ID="ID_1676057149" MODIFIED="1607991779081" TEXT="ITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="NR_REGBLOCO: Number()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@"/>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="C&#xf3;digo da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="C&#xf3;digo da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="150">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="LOV_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;    I_CD_EMPRESA USUARIOEMPRESA.CD_EMPRESA%TYPE;&#xa;BEGIN&#xa;  IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#xa;    SELECT USUARIOEMPRESA.CD_EMPRESA &#xa;      INTO I_CD_EMPRESA &#xa;      FROM USUARIOEMPRESA&#xa;     WHERE (USUARIOEMPRESA.CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA) &#xa;       AND (USUARIOEMPRESA.CD_USUARIO = :GLOBAL.CD_USUARIO);&#xa;          &#xa;    IF I_CD_EMPRESA IS NOT NULL THEN&#xa;      SELECT EMPRESA.NM_EMPRESA &#xa;        INTO :ITEMCOMPRA.NM_EMPRESA&#xa;        FROM EMPRESA&#xa;       WHERE EMPRESA.CD_EMPRESA = I_CD_EMPRESA;&#xa;  &#xa;      :ITEMCOMPRA.CD_EMPRESAITEM   := :ITEMCOMPRA.CD_EMPRESA;&#xa;      :ITEMCOMPRA.CD_EMPRESAUTORIZ := :ITEMCOMPRA.CD_EMPRESA;&#xa;    END IF;&#xa;   END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;     :ITEMCOMPRA.NM_EMPRESA := NULL;&#xa;     --Empresa &#xa2;CD_EMPRESA&#xa2; n&#xe3;o cadastrada ou Usu&#xe1;rio n&#xe3;o tem acesso &#xe0; Empresa.&#xa;     MENSAGEM_PADRAO(278,&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;     RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN TOO_MANY_ROWS THEN&#xa;     :ITEMCOMPRA.NM_EMPRESA := NULL;&#xa;     --A consulta retornou mais de um resultado ao tentar localizar os dados da empresa &#xa2;CD_EMPRESA&#xa2;. Verifique o programa TCB012.&#xa;     MENSAGEM_PADRAO(216,&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;     RAISE FORM_TRIGGER_FAILURE;  &#xa;   WHEN OTHERS THEN       &#xa;     --Erro ao buscar os dados da empresa  &#xa2;CD_EMPRESA&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;     MENSAGEM_PADRAO(35,&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;     RAISE FORM_TRIGGER_FAILURE; &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="NM_EMPRESA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Nome da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT=":GLOBAL.DS_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="@">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="LOV_ITEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;    I_CD_UNIDMED       UNIDMEDIDA.CD_UNIDMED%TYPE;&#xa;    I_DT_CANCELAMENTO  ITEMEMPRESA.DT_CANCELAMENTO%TYPE;&#xa;    I_MENSAGEM         VARCHAR2(2000);&#xa;    E_GERAL            EXCEPTION;&#xa;    V_CD_GRUPO         GRUPO.CD_GRUPO%TYPE;&#xa;    V_CD_SUBGRUPO       SUBGRUPO.CD_SUBGRUPO%TYPE;&#xa;    V_CD_ITEM           ITEMNF.CD_ITEM%TYPE; &#xa;    V_TP_ITEM           VARCHAR2(2);&#xa;    V_COUNT             NUMBER; &#xa;    V_TAB_PRECO         TABPRECO.CD_TABPRECO%TYPE;/*ATR:71810:29/01/2016*/&#xa;    V_EXISTE           VARCHAR2(1);/*ATR:71810:29/01/2016*/&#xa;    V_NR_SEQ           ITEMREGRAPARMOV.NR_SEQUENCIAL%TYPE;--AUG:127526:03/01/2019&#xa;    &#xa;BEGIN&#xa;  /*WLV:08/08/2012:41514 - Consulta para pegar os dados gravados no TIT001*/&#xa;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#xa;    BEGIN         &#xa;       SELECT ITEM.CD_GRUPO, ITEM.CD_SUBGRUPO, ITEM.TP_ITEM, ITEM.CD_ITEM&#xa;          INTO V_CD_GRUPO, V_CD_SUBGRUPO, V_TP_ITEM, V_CD_ITEM&#xa;         FROM ITEM&#xa;        WHERE ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#xa;    &#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --A consulta fez com que nenhum registro fosse recuperado.    &#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3129, NULL);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN&#xa;        --Ocorreu um erro n&#xe3;o esperado ao efetuar a consulta. Erro: &#xa2;NR_ERRO&#xa2;.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(13778, &apos;&#xa2;NR_ERRO=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;    &#xa;    V_COUNT := 0;&#xa;    /*WLV:08/08/2012:41514 - Consulta para verificar se tem alguma regra no TCO002 para o usu&#xe1;rio/empresa logados */&#xa;    BEGIN          &#xa;      SELECT COUNT(*)&#xa;       INTO V_COUNT&#xa;       FROM SOLICITANTE&#xa;      WHERE SOLICITANTE.CD_EMPRESA      = :GLOBAL.CD_EMPRESA&#xa;        AND SOLICITANTE.CD_USUARIO      = :GLOBAL.CD_USUARIO&#xa;        AND SOLICITANTE.ST_SOLICITANTE = &apos;S&apos;&#xa;        AND (SOLICITANTE.CD_GRUPO       = V_CD_GRUPO OR SOLICITANTE.CD_GRUPO IS NULL)&#xa;        AND (SOLICITANTE.CD_SUBGRUPO   = V_CD_SUBGRUPO OR SOLICITANTE.CD_SUBGRUPO IS NULL)&#xa;        AND (SOLICITANTE.TP_ITEM        = V_TP_ITEM OR SOLICITANTE.TP_ITEM IS NULL)&#xa;        AND (SOLICITANTE.CD_ITEM        = :ITEMCOMPRA.CD_ITEM OR SOLICITANTE.CD_ITEM IS NULL); &#xa;  &#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN&#xa;        --Ocorreu um erro n&#xe3;o esperado ao efetuar a consulta. Erro: &#xa2;NR_ERRO&#xa2;.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(13778, &apos;&#xa2;NR_ERRO=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;    &#xa;    /*WLV:08/08/2012:41514 - Caso o resultado do select acima for maior que 0 significa que existe uma regra para o usu&#xe1;rio/empresa*/&#xa;    IF V_COUNT = 0 THEN&#xa;      --O item &#xa2;CD_ITEM&#xa2; n&#xe3;o possui regra no TCO002 relacionado para o usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; para empresa &#xa2;CD_EMPRESA&#xa2;. Verfique o TCO002.&#xa;      I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(17811, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_USUARIO=&apos;||:GLOBAL.CD_USUARIO||&apos;&#xa2;CD_EMPRESA=&apos;||:GLOBAL.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;      :ITEMCOMPRA.DS_ITEM := NULL;&#xa;      :ITEMCOMPRA.DS_UNIDMED := NULL;&#xa;      RAISE E_GERAL;&#xa;    END IF;--IF V_COUNT = 0 THEN    &#xa;  END IF;--IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#xa;  ------------------------------------------------------------------------------------&#xa;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#xa;    BEGIN&#xa;      SELECT TP_ITEM, &#xa;             DS_ITEM, &#xa;             CD_UNIDMED &#xa;        INTO PACK_GLOBAL.TP_ITEM,  &#xa;             :ITEMCOMPRA.DS_ITEM,  &#xa;             I_CD_UNIDMED&#xa;        FROM ITEM&#xa;        WHERE ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --O item &#xa2;CD_ITEM&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o programa TIT001.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27,&apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;          &#xa;      ------------------------------------------------------------------------------------&#xa;    BEGIN&#xa;      SELECT DT_CANCELAMENTO &#xa;        INTO I_DT_CANCELAMENTO&#xa;        FROM ITEMEMPRESA&#xa;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA&#xa;         AND CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#xa;         &#xa;      /*AUG:121710:11/06/2018 Adicionada condi&#xe7;&#xe3;o para verificar se a data de cancelamento &#xe9; menor ou igual a data atual*/&#xa;      IF I_DT_CANCELAMENTO IS NOT NULL AND  &#xa;         I_DT_CANCELAMENTO &lt;= SYSDATE THEN&#xa;        --O Item &#xa2;CD_ITEM&#xa2; est&#xe1; cancelado para a empresa &#xa2;CD_EMPRESA&#xa2;. Verifique TIT001.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(184,&apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --O Item &#xa2;CD_ITEM&#xa2; n&#xe3;o est&#xe1; cadastrado ou est&#xe1; cancelado. Verifique o programa TIT001.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3662,&apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;      &#xa;      ------------------------------------------------------------------------------------&#xa;    BEGIN&#xa;      SELECT CD_ITEM &#xa;        INTO :ITEMCOMPRA.CD_ITEM&#xa;        FROM PLANEJITEM&#xa;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA&#xa;         AND CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --Planejamento de item n&#xe3;o cadastrado para o Item &#xa2;CD_ITEM&#xa2; e Empresa &#xa2;CD_EMPRESA&#xa2;. Verifique o programa TIT001.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20051, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN TOO_MANY_ROWS THEN&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20052, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20053, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;SQLERR=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;  &#xa;    &#xa;    /*AUG:127526:03/01/2019*/&#xa;    V_NR_SEQ := PACK_TCB054.RETORNA_SEQ_ITEMPARMOV(:ITEMCOMPRA.CD_ITEM,&#xa;                                                   :CONTROLE.CD_EMPRESA,&#xa;                                                   :GLOBAL.CD_USUARIO,&#xa;                                                   :GLOBAL.CD_MODULO,&#xa;                                                   :GLOBAL.CD_PROGRAMA);                               &#xa;    IF V_NR_SEQ IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NULL THEN&#xa;      BEGIN&#xa;        SELECT CD_MOVIMENTACAO&#xa;          INTO :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;          FROM ITEMPARMOV&#xa;          WHERE ITEMPARMOV.NR_SEQUENCIAL = V_NR_SEQ;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          :ITEMCOMPRA.CD_MOVIMENTACAO := NULL;&#xa;        WHEN TOO_MANY_ROWS THEN&#xa;          IF SHOW_LOV(&apos;LOV_ITEMPARMOV&apos;) THEN&#xa;            NULL;&#xa;          END IF;&#xa;        WHEN OTHERS THEN&#xa;          MENSAGEM(&apos;Maxys&apos;, SQLERRM,2);&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;      END;  &#xa;      &#xa;    ELSE-----&#xa;    &#xa;     /*FJC:02/07/2018:121705&#xa;        busca a ultima movimenta&#xe7;&#xe3;o utilizada para o item em lan&#xe7;amento de recebimento valido.&#xa;      */&#xa;      &#xa;      IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NULL AND &#xa;         NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,NVL(:ITEMCOMPRA.CD_EMPRESA, :GLOBAL.CD_EMPRESA),&apos;ST_ULTIMAMOVIMENTACAO&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;        :ITEMCOMPRA.CD_MOVIMENTACAO := PACK_COMPRAS.RETORNA_ULTIMAMOVIMENTACAO(I_CD_EMPRESA =&gt; NVL(:ITEMCOMPRA.CD_EMPRESA, :GLOBAL.CD_EMPRESA), &#xa;                                                                                I_CD_ITEM    =&gt; :ITEMCOMPRA.CD_ITEM,&#xa;                                                                                I_CD_CLIFOR  =&gt; NULL);&#xa;       END IF;&#xa;    END IF;--IF V_NR_SEQ IS NOT NULL THEN&#xa;    &#xa;    /*ATR:71810:29/01/2016*/&#xa;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CONTROLEORC051&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;      IF PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;CD_TABELAPRECORC051&apos;) IS NOT NULL THEN&#xa;        V_TAB_PRECO := PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,009,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;CD_TABELAPRECORC051&apos;);&#xa;        BEGIN&#xa;          SELECT &apos;S&apos;&#xa;            INTO V_EXISTE&#xa;            FROM PRECOVENDA, TABPRECO &#xa;           WHERE (PRECOVENDA.CD_TABPRECO = TABPRECO.CD_TABPRECO)&#xa;             AND (PRECOVENDA.CD_TABPRECO = V_TAB_PRECO)&#xa;             AND (PRECOVENDA.CD_ITEM = :ITEMCOMPRA.CD_ITEM)&#xa;             AND (PRECOVENDA.DT_EMVIGOR IS NULL OR&#xa;                 TRUNC(PRECOVENDA.DT_EMVIGOR) &lt;= TRUNC(SYSDATE)) &#xa;             AND (PRECOVENDA.DT_CANCELAMENTO IS NULL OR&#xa;                 TRUNC(PRECOVENDA.DT_CANCELAMENTO) &gt; TRUNC(SYSDATE))&#xa;             AND (PRECOVENDA.DT_VENCIMENTO IS NULL OR &#xa;                  TRUNC(PRECOVENDA.DT_VENCIMENTO) &gt; TRUNC(SYSDATE));        &#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            --O Item Informado &#xa2;CD_ITEM&#xa2; n&#xe3;o est&#xe1; cadastrado para a Tabela de Pre&#xe7;os &#xa2;CD_TABPRECO&#xa2; ou o pre&#xe7;o est&#xe1; cancelado, vencido, ou n&#xe3;o est&#xe1; em vigor. Favor verificar TVE003&#xa;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27044, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_TABPRECO=&apos;||V_TAB_PRECO||&apos;&#xa2;&apos;);&#xa;            RAISE E_GERAL;&#xa;          WHEN OTHERS THEN&#xa;            --Erro ao consultar a Tabela de Pre&#xe7;o &#xa2;CD_CD_TABPRECO&#xa2; para o Item &#xa2;CD_ITEM&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27026, &apos;&#xa2;CD_CD_TABPRECO=&apos;||V_TAB_PRECO||&apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;            RAISE E_GERAL;&#xa;        END;&#xa;      ELSE&#xa;        --O Controle por Or&#xe7;amento est&#xe1; ativo por&#xe9;m a tabela de pre&#xe7;o n&#xe3;o foi informada. Favor verificar COM009.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27043, NULL);&#xa;        RAISE E_GERAL;          &#xa;      END IF; --IF PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,009,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;CD_TABELAPRECORC051&apos;) IS NOT NULL THEN    &#xa;    END IF; --IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CONTROLEORC051&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;&#xa;    :ITEMCOMPRA.DS_UNIDMED := I_CD_UNIDMED;&#xa;  ELSE&#xa;    :ITEMCOMPRA.DS_ITEM:= NULL;&#xa;    :ITEMCOMPRA.DS_UNIDMED := NULL;&#xa;  END IF;&#xa;  &#xa;  ------------------------------------------------------------------------------------&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,I_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    MENSAGEM(&apos;Maxys COM001&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779081" FOLDED="true" MODIFIED="1607991779081" TEXT="body">
<node CREATED="1607991779081" MODIFIED="1607991779081" TEXT="DECLARE&#xa;    I_CD_UNIDMED  VARCHAR2(2);&#xa;    I_TP_ITEM     VARCHAR2(1); &#xa;    I_MENSAGEM    VARCHAR2(2000);&#xa;    E_GERAL       EXCEPTION;&#xa;    V_COUNTPEDIDO NUMBER; /*ATR:88023:24/06/2015*/&#xa;    E_REMOVE      EXCEPTION; /*ATR:88023:24/06/2015*/&#xa;  ------------------------------------------------------------------------------------&#xa;  CURSOR CUR_QT_CCUSTO IS&#xa;  SELECT ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&#xa;    FROM ITEMCOMPRACCUSTO&#xa;   WHERE :ITEMCOMPRA.NR_ITEMCOMPRA = ITEMCOMPRACCUSTO.NR_ITEMCOMPRA&#xa;     AND :ITEMCOMPRA.CD_EMPRESA    = ITEMCOMPRACCUSTO.CD_EMPRESA;&#xa;BEGIN  &#xa;  VALIDATE(ITEM_SCOPE);&#xa;  IF NOT FORM_SUCCESS THEN&#xa;    RETURN;&#xa;  END IF;&#xa;  &#xa;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;    IF :SYSTEM.RECORD_STATUS = &apos;INSERT&apos; THEN&#xa;      BEGIN&#xa;        SELECT DISTINCT ITEMCOMPRA.CD_ITEM &#xa;          INTO :ITEMCOMPRA.CD_ITEM&#xa;          FROM ITEMCOMPRA&#xa;         WHERE ITEMCOMPRA.CD_ITEM          = :ITEMCOMPRA.CD_ITEM&#xa;           AND ITEMCOMPRA.CD_EMPRESA       = :ITEMCOMPRA.CD_EMPRESA&#xa;           AND (ITEMCOMPRA.ST_ITEMCOMPRA   = 1 OR ITEMCOMPRA.ST_ITEMCOMPRA IS NULL);&#xa;           &#xa;           /*WLV:15/08/2012:41514 - Adicionado para que mostre a msg padr&#xe3;o em vez do alerta normal*/&#xa;           SET_ALERT_PROPERTY(&apos;INCLUIPEDIDO&apos;,ALERT_MESSAGE_TEXT,PACK_MENSAGEM.MENS_ALERTA(17882, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;&apos;));&#xa;           IF SHOW_ALERT(&apos;INCLUIPEDIDO&apos;)   = ALERT_BUTTON1 THEN&#xa;               /*CSL:22059:05/06/09&#xa;                *Se  houver alguma  solicita&#xe7;&#xe3;o  em aberto com o item que o usu&#xe1;rio  digitou/selecionou e o mesmo &#xa;                *desejar  incluir o  item em uma  das solicita&#xe7;&#xf5;es em  aberto, o programa exibe uma LOV  com a(s) &#xa;                *solicita&#xe7;&#xe3;o(&#xf5;es) em aberto para que o usu&#xe1;rio possa adicionar o &#xed;tem que ia pedir  na quantidade &#xa;                *da solicita&#xe7;&#xe3;o selecionada .&#xa;                */&#xa;                &#xa;              &#xa;               --MENSAGEM(&apos;Maxys COM001 - Aviso&apos;,&apos;J&#xe1; existe uma solicita&#xe7;&#xe3;o de compra para este item.&apos;||CHR(10)||CHR(10)||&apos;Inclua a quantidade desejada na mesma solicita&#xe7;&#xe3;o.&apos;,3);&#xa;               --SET_BLOCK_PROPERTY(&apos;ITEMCOMPRA&apos;, DEFAULT_WHERE, &apos; CD_ITEM = &apos;||:ITEMCOMPRA.CD_ITEM||&apos; AND CD_EMPRESA = &apos;||:ITEMCOMPRA.CD_EMPRESA||&apos; AND ( ST_ITEMCOMPRA &lt; 4 OR ST_ITEMCOMPRA IS NULL ) AND ROWNUM = 1 &apos;);&#xa;               --EXECUTE_QUERY(NO_VALIDATE);&#xa;               IF SHOW_LOV(&apos;LOV_COMPRAS&apos;) THEN&#xa;                NULL;&#xa;               END IF;&#xa;               GO_ITEM(&apos;CONTROLE.NR_LOTECOMPRA&apos;);&#xa;               Execute_Trigger (&apos;KEY-NEXT-ITEM&apos;); &#xa;           ELSE&#xa;               NULL;&#xa;           END IF;&#xa;           IF :ITEMCOMPRA.QT_PREVISTA = 0 THEN&#xa;              FOR I IN CUR_QT_CCUSTO LOOP&#xa;                :ITEMCOMPRA.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA + I.QT_PEDIDAUNIDSOL;&#xa;             END LOOP;&#xa;           END IF;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN        &#xa;          NULL;&#xa;        WHEN TOO_MANY_ROWS THEN&#xa;          :ITEMCOMPRA.CD_ITEM := NULL;&#xa;      END;&#xa;    END IF;&#xa;    -------------------------------------------------------------------------------------------&#xa;    BEGIN&#xa;      &#xa;      SELECT ITEMEMPRESA.CD_ITEM &#xa;        INTO :ITEMCOMPRA.CD_ITEM&#xa;        FROM ITEMEMPRESA&#xa;       WHERE ITEMEMPRESA.CD_ITEM    = :ITEMCOMPRA.CD_ITEM&#xa;         AND ITEMEMPRESA.CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESAITEM;&#xa;      &#xa;      SELECT ITEM.TP_ITEM,&#xa;              ITEM.DS_ITEM,          &#xa;              ITEM.CD_UNIDMED&#xa;        INTO I_TP_ITEM,      &#xa;             :ITEMCOMPRA.DS_ITEM,  &#xa;             I_CD_UNIDMED&#xa;        FROM ITEM&#xa;       WHERE ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#xa;&#xa;      IF I_TP_ITEM = &apos;A&apos; THEN&#xa;        MANIPULA_CAMPO(&apos;ITEMCOMPRA.DS_ITEMSERVICO&apos;,&apos;D&apos;);&#xa;        /*SET_ITEM_PROPERTY (&apos;ITEMCO MPRA.DS_ITEMSERVICO&apos;,ENABLED,PROPERTY_FALSE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCO MPRA.DS_ITEMSERVICO&apos;,REQUIRED,PROPERTY_FALSE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCO MPRA.DS_ITEMSERVICO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCO MPRA.DS_ITEMSERVICO&apos;,PROMPT_FONT_STYLE,FONT_PLAIN);        */&#xa;        :ITEMCOMPRA.DS_ITEMSERVICO     := NULL;&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,ENABLED,PROPERTY_FALSE);&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,REQUIRED,PROPERTY_FALSE);&#xa;        :ITEMCOMPRA.DT_INICIO         := NULL;&#xa;&#xa;      ELSIF I_TP_ITEM = &apos;S&apos; THEN&#xa;        MANIPULA_CAMPO(&apos;ITEMCOMPRA.DS_ITEMSERVICO&apos;,&apos;A&apos;);&#xa;        /*SET_ITEM_PROPERTY (&apos;ITEMCOM PRA.DS_ITEMSERVICO&apos;,ENABLED,PROPERTY_TRUE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOM PRA.DS_ITEMSERVICO&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOM PRA.DS_ITEMSERVICO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOM PRA.DS_ITEMSERVICO&apos;,PROMPT_FONT_STYLE,FONT_UNDERLINE);*/&#xa;        &#xa;        --SET_ITEM_PROPERTY (&apos;ITEMC OMPRA.DS_ITEMSERVICO&apos;,REQUIRED,PROPERTY_TRUE);&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,ENABLED,PROPERTY_TRUE);&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,REQUIRED,PROPERTY_TRUE);&#xa;&#xa;      ELSIF I_TP_ITEM IN (&apos;P&apos;,&apos;I&apos;) THEN&#xa;        MANIPULA_CAMPO(&apos;ITEMCOMPRA.DS_ITEMSERVICO&apos;,&apos;D&apos;);&#xa;        /*SET_ITEM_PROPERTY (&apos;ITEMCOM PRA.DS_ITEMSERVICO&apos;,ENABLED,PROPERTY_FALSE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOM PRA.DS_ITEMSERVICO&apos;,REQUIRED,PROPERTY_FALSE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCO MPRA.DS_ITEMSERVICO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCO MPRA.DS_ITEMSERVICO&apos;,PROMPT_FONT_STYLE,FONT_PLAIN);*/&#xa;        &#xa;        :ITEMCOMPRA.DS_ITEMSERVICO     := NULL;&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,ENABLED,PROPERTY_FALSE);&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,REQUIRED,PROPERTY_FALSE);&#xa;        :ITEMCOMPRA.DT_INICIO         := NULL;&#xa;&#xa;--      ELSIF I_TP_ITEM = &apos;I&apos; THEN&#xa;  --      MANIPULA_CAMPO(&apos;ITEMCOMPRA.DS_ITEMSERVICO&apos;,&apos;D&apos;);&#xa;        /*SET_ITEM_PROPERTY (&apos;ITE MCOMPRA.DS_ITEMSERVICO&apos;,ENABLED,PROPERTY_FALSE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEM COMPRA.DS_ITEMSERVICO&apos;,REQUIRED,PROPERTY_FALSE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEM COMPRA.DS_ITEMSERVICO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);&#xa;        SET_ITEM_PROPERTY (&apos;ITEM COMPRA.DS_ITEMSERVICO&apos;,PROMPT_FONT_STYLE,FONT_PLAIN);*/&#xa;        &#xa;--        :ITEMCOMPRA.DS_ITEMSERVICO     := NULL;&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,ENABLED,PROPERTY_FALSE);&#xa;        --SET_ITEM_PROPERTY (&apos;ITEMCOMPRA.DT_INICIO&apos;,REQUIRED,PROPERTY_FALSE);&#xa;--        :ITEMCOMPRA.DT_INICIO         := NULL;&#xa;      END IF;&#xa;&#xa;      SELECT UNIDMEDIDA.DS_UNIDMEDIDA &#xa;        INTO :ITEMCOMPRA.DS_UNIDMED&#xa;        FROM UNIDMEDIDA&#xa;       WHERE UNIDMEDIDA.CD_UNIDMED = I_CD_UNIDMED;&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --Item &#xa2;CD_ITEM&#xa2; n&#xe3;o cadastrado, n&#xe3;o associado a empresa &#xa2;CD_EMPRESA&#xa2;, sem Item Similar ou sem movimenta&#xe7;&#xe3;o.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(250,&apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;  END IF; &#xa;    &#xa;  /*ATR:88023:24/06/2015*/&#xa;  IF :CONTROLE.CD_EMPRESA IS NOT NULL AND :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#xa;    BEGIN&#xa;      SELECT COUNT(*)&#xa;        INTO V_COUNTPEDIDO&#xa;        FROM ITEMPEDIDOCOMPRA&#xa;       WHERE ITEMPEDIDOCOMPRA.ST_ITEMPEDIDO IN (&apos;1&apos;,&apos;2&apos;)&#xa;         AND ITEMPEDIDOCOMPRA.CD_EMPRESA = :CONTROLE.CD_EMPRESA&#xa;         AND ITEMPEDIDOCOMPRA.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN&#xa;        V_COUNTPEDIDO := 0;&#xa;    END;&#xa;    &#xa;    IF NVL(V_COUNTPEDIDO,0) &gt; 0 THEN&#xa;      SET_ALERT_PROPERTY(&apos;ALR_EXISTEPEDIDO&apos;,ALERT_MESSAGE_TEXT,&apos;O Item &apos;||(:ITEMCOMPRA.CD_ITEM)||&apos; possui pedido em aberto para a Empresa &apos;||(:CONTROLE.CD_EMPRESA)||&apos;. Deseja prosseguir com lan&#xe7;amento ou remover o item?&apos;);&#xa;      IF SHOW_ALERT(&apos;ALR_EXISTEPEDIDO&apos;)   = ALERT_BUTTON1 THEN&#xa;        NULL;&#xa;      ELSE&#xa;        RAISE E_REMOVE;&#xa;      END IF;&#xa;    END IF;  --IF NVL(V_COUNTPEDIDO,0) &gt; 0 THEN  &#xa;  END IF; --IF :CONTROLE.CD_EMPRESA IS NOT NULL AND :ITEMCOMPRA.CD_ITEM THEN     &#xa;&#xa;  NEXT_ITEM;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys COM001 - Aviso&apos;,I_MENSAGEM,3);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  /*ATR:88023:24/06/2015*/&#xa;  WHEN E_REMOVE THEN&#xa;    CLEAR_RECORD;&#xa;    GO_ITEM(&apos;ITEMCOMPRA.CD_ITEM&apos;);&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Descri&#xe7;&#xe3;o do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="LOV_ITEMCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="NM_USUAUTORIZ: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="TP_APROVSOLIC: Char(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@"/>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Moviment.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Somente Movimenta&#xe7;&#xf5;es do Tipo de Pedido do Programa COM004">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="LOV_ITEMPARMOV">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE &#xa;  V_MENSAGEM           VARCHAR2(32000);&#xa;  V_CD_OPERESTOQUE    CMI.CD_OPERESTOQUE%TYPE;&#xa;  V_DS_MOVIMENTACAO   VARCHAR2(60);&#xa;  V_ST_ATIVO          VARCHAR2(01);&#xa;  E_GERAL             EXCEPTION;&#xa;  V_NR_SEQ          ITEMREGRAPARMOV.NR_SEQUENCIAL%TYPE;--AUG:127526:03/01/2019&#xa;  V_ST_OBRIGATORIO   BOOLEAN;--AUG:127526:03/01/2019&#xa;  &#xa;  CURSOR CUR_ITEMPARMOV(C_NR_SEQ IN NUMBER) IS&#xa;    SELECT ST_OBRIGATORIO,&#xa;           CD_MOVIMENTACAO&#xa;      FROM ITEMPARMOV&#xa;     WHERE ITEMPARMOV.NR_SEQUENCIAL = C_NR_SEQ;     &#xa;BEGIN&#xa;  IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN &#xa;    &#xa;    /*AUG:127526:03/01/2019*/&#xa;    V_NR_SEQ := PACK_TCB054.RETORNA_SEQ_ITEMPARMOV(:ITEMCOMPRA.CD_ITEM,&#xa;                                                   :CONTROLE.CD_EMPRESA,&#xa;                                                   :GLOBAL.CD_USUARIO,&#xa;                                                   :GLOBAL.CD_MODULO,&#xa;                                                   :GLOBAL.CD_PROGRAMA);                               &#xa;    &#xa;    &#xa;    IF V_NR_SEQ IS NOT NULL THEN&#xa;      V_ST_OBRIGATORIO := FALSE;&#xa;      &#xa;      /* Verifico se existe pelo menos uma movimenta&#xe7;&#xe3;o obrigat&#xf3;ria&#xa;       * pois se possuir, dever&#xe1; obrigat&#xf3;riamente informar alguma movimenta&#xe7;&#xe3;o&#xa;       * cadastrada no TCB054. Caso n&#xe3;o possua, o usu&#xe1;rio ter&#xe1; a op&#xe7;&#xe3;o de &#xa;       * apertar o esc e o processo segue como era antes.&#xa;       */&#xa;      FOR I IN CUR_ITEMPARMOV(V_NR_SEQ) LOOP&#xa;        IF NVL(I.ST_OBRIGATORIO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;          V_ST_OBRIGATORIO := TRUE;&#xa;          EXIT;&#xa;        END IF;&#xa;      END LOOP;&#xa;    &#xa;      IF V_ST_OBRIGATORIO THEN&#xa;        FOR I IN CUR_ITEMPARMOV(V_NR_SEQ) LOOP&#xa;          IF I.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO THEN&#xa;            V_ST_OBRIGATORIO := FALSE;&#xa;            EXIT;&#xa;          END IF;&#xa;        END LOOP;&#xa;        /*Se a variavel ainda for verdadeira, quer dizer que a movimentacao n existe no TCB054*/&#xa;        IF V_ST_OBRIGATORIO THEN&#xa;          BEGIN&#xa;            SELECT STRING_AGG(CD_MOVIMENTACAO)&#xa;              INTO V_DS_MOVIMENTACAO&#xa;              FROM ITEMPARMOV&#xa;             WHERE ITEMPARMOV.NR_SEQUENCIAL = V_NR_SEQ;&#xa;          EXCEPTION&#xa;            WHEN NO_DATA_FOUND THEN&#xa;              V_DS_MOVIMENTACAO := NULL;&#xa;            WHEN OTHERS THEN&#xa;             V_DS_MOVIMENTACAO := NULL;&#xa;          END;&#xa;          --Como existe pelo menos uma movimenta&#xe7;&#xe3;o parametrizada para o item &#xa2;CD_ITEM&#xa2; como obrigat&#xf3;ria no TCB054, &#xa;          --&#xe9; necess&#xe1;rio informar um das seguintes movimenta&#xe7;&#xf5;es &#xa2;DS_MOVIMENTACOES&#xa2;&#xa;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32020, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;DS_MOVIMENTACOES=&apos;||V_DS_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;          &#xa;          --GO_ITEM(&apos;ITEMPEDIDO.CD_ITEM&apos;);&#xa;        END IF;  &#xa;      END IF;&#xa;    END IF;&#xa;    &#xa;     IF PACK_GLOBAL.TP_SELECAOCONTA = &apos;O&apos; THEN&#xa;       /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padr&#xe3;o da fun&#xe7;&#xe3;o VALIDA_SELECAOCONTA quando for &apos;CO&apos;*/&#xa;       V_MENSAGEM := VALIDA_SELECAOCONTA (:CONTROLE.CD_EMPRESA,&#xa;                                         :ITEMCOMPRA.CD_ITEM,&#xa;                                         :ITEMCOMPRA.CD_MOVIMENTACAO, &#xa;                                         NULL, &apos;CO&apos;);&#xa;      IF (V_MENSAGEM IS NOT NULL) AND (V_MENSAGEM &lt;&gt; &apos;S&apos;) THEN&#xa;        RAISE E_GERAL;&#xa;      END IF;                                                                   &#xa;    END IF;&#xa;    /* DCS:05/04/2012:34604&#xa;     * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO, ao inves do VALIDA_CONTABIL&#xa;     * este possui valida&#xe7;&#xe3;o para n&#xe3;o permitir realizar lan&#xe7;amentos em contas, &#xa;     * que n&#xe3;o pertencem a vers&#xe3;o do plano de contas da empresa do lan&#xe7;amento&#xa;     */&#xa;    --PACK_VALIDA.VALIDA_CONTABIL(:ITEMCOMPRA.CD_MOVIMENTACAO,NULL,TRUNC(SYSDATE),I_MENSAGEM);&#xa;    PACK_VALIDA.VALIDA_CONTABIL_PLANO(:ITEMCOMPRA.CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA), V_MENSAGEM);&#xa;    &#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;&#xa;    BEGIN&#xa;      /*CSL:30/12/2013:64869*/&#xa;      IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;        SELECT CMI.CD_OPERESTOQUE, &#xa;               PARMOVIMENT.DS_MOVIMENTACAO,&#xa;               PLANOCONTABIL.TP_CONTACONTABIL&#xa;          INTO V_CD_OPERESTOQUE, &#xa;               V_DS_MOVIMENTACAO,&#xa;               :ITEMCOMPRA.TP_CONTACONTABIL&#xa;          FROM PARMOVIMENT, &#xa;               CMI,&#xa;               HISTCONTB,&#xa;               PLANOCONTABIL&#xa;          WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;             AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#xa;             AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#xa;            AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#xa;           AND CMI.TP_FATES                = &apos;0&apos;;&#xa;      ELSE&#xa;        SELECT CMI.CD_OPERESTOQUE, &#xa;               PARMOVIMENT.DS_MOVIMENTACAO,&#xa;               PLANOCONTABILVERSAO.TP_CONTACONTABIL&#xa;          INTO V_CD_OPERESTOQUE, &#xa;               V_DS_MOVIMENTACAO,&#xa;               :ITEMCOMPRA.TP_CONTACONTABIL&#xa;          FROM PARMOVIMENT, &#xa;               CMI,&#xa;               HISTCONTB,&#xa;               PLANOCONTABILVERSAO&#xa;          WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;             AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#xa;             AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#xa;            AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#xa;            AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#xa;                PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE))&#xa;           AND CMI.TP_FATES                = &apos;0&apos;;&#xa;      END IF;      &#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        /*CSL:22115:10/06/09&#xa;         *Alterada a mensagem: &apos;Caracteristicas da movimenta&#xe7;&#xe3;o :ITEMCOMPRA.CD_MOVIMENTACAO n&#xe3;o encontrados.&apos; &#xa;         */&#xa;        --Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; inv&#xe1;lida para esta opera&#xe7;&#xe3;o. Verifique se o CMI desta movimenta&#xe7;&#xe3;o &#xe9; do tipo ENTRADA. Verifique TCB008/TCB002. &#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4723,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN TOO_MANY_ROWS THEN&#xa;        --A Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; est&#xe1; cadastrada v&#xe1;rias vezes. Verifique TCB008.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(47,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN&#xa;        --Erro ao Pesquisar a Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2;. Verifique TCB008. Erro &#xa2;SQLERRM&#xa2;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(48,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;      IF V_CD_OPERESTOQUE IS NOT NULL THEN&#xa;        VALIDA_MOVIMENTACAO(V_MENSAGEM);&#xa;        IF V_MENSAGEM IS NOT NULL THEN&#xa;          RAISE E_GERAL;&#xa;        --  RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;      END IF;&#xa;      &#xa;      IF NVL(:ITEMCOMPRA.TP_CONTACONTABIL,&apos;XXX&apos;) &lt;&gt; &apos;CC&apos; THEN&#xa;        VALIDA_CONTA_ORCAMENTO(&apos;ITEMCOMPRA.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRA.CD_MOVIMENTACAO, NULL);&#xa;      END IF;  &#xa;      &#xa;  -----------------------------------------------------------------------------------------------------------------&#xa;  --VALIDA SE A MOVIMENTA&#xc7;&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O PARA O CENTRO DE CUSTO (TCB053)&#xa;  --AUG:122414:24/05/2018&#xa;  -----------------------------------------------------------------------------------------------------------------      &#xa;    IF :ITEMCOMPRA.CD_MOVIMENTACAO       IS NOT NULL AND&#xa;       :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#xa;    &#xa;    /*RETORNO: S = POSSUI RESTRI&#xc7;&#xc3;O&#xa;     *          N = N&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#xa;     */&#xa;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRA.CD_MOVIMENTACAO,&#xa;                                                       :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;      IF NVL(V_ST_ATIVO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    END IF;      &#xa;  ELSE&#xa;    V_DS_MOVIMENTACAO := NULL;&#xa;  END IF;&#xa;&#xa;  PACK_PROCEDIMENTOS.VALIDA_LOCALARMAZ(V_MENSAGEM);  --eml:25/05/2020:148401&#xa;  IF V_MENSAGEM IS NOT NULL THEN&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);  &#xa;    RAISE FORM_TRIGGER_FAILURE;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE&#xa;  V_NR_SEQ          ITEMREGRAPARMOV.NR_SEQUENCIAL%TYPE;--AUG:127526:03/01/2019&#xa;  V_ST_OBRIGATORIO   BOOLEAN;--AUG:127526:03/01/2019&#xa;  &#xa;  CURSOR CUR_ITEMPARMOV(C_NR_SEQ IN NUMBER) IS&#xa;    SELECT ST_OBRIGATORIO,&#xa;           CD_MOVIMENTACAO&#xa;      FROM ITEMPARMOV&#xa;     WHERE ITEMPARMOV.NR_SEQUENCIAL = C_NR_SEQ;&#xa;BEGIN&#xa;    /*AUG:127526:03/01/2019*/&#xa;  V_NR_SEQ := PACK_TCB054.RETORNA_SEQ_ITEMPARMOV(:ITEMCOMPRA.CD_ITEM,&#xa;                                                 :CONTROLE.CD_EMPRESA,&#xa;                                                 :GLOBAL.CD_USUARIO,&#xa;                                                 :GLOBAL.CD_MODULO,&#xa;                                                 :GLOBAL.CD_PROGRAMA);                                                                   &#xa;  /* Verifico se existe pelo menos uma movimenta&#xe7;&#xe3;o obrigat&#xf3;ria&#xa;   * pois se possuir, dever&#xe1; obrigat&#xf3;riamente informar alguma movimenta&#xe7;&#xe3;o&#xa;   * cadastrada no TCB054. Caso n&#xe3;o possua, o usu&#xe1;rio ter&#xe1; a op&#xe7;&#xe3;o de &#xa;   * apertar o esc e o processo segue como era antes.&#xa;   */&#xa;  FOR I IN CUR_ITEMPARMOV(V_NR_SEQ) LOOP&#xa;    IF NVL(I.ST_OBRIGATORIO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;      V_ST_OBRIGATORIO := TRUE;&#xa;      EXIT;&#xa;    END IF;&#xa;  END LOOP;&#xa;  &#xa;  IF V_ST_OBRIGATORIO THEN&#xa;    SET_LOV_PROPERTY(&apos;LOV_ITEMPARMOV&apos;,GROUP_NAME,&apos;LOV_ITEMPARMOV&apos;);    &#xa;     IF SHOW_LOV(&apos;LOV_ITEMPARMOV&apos;) THEN&#xa;          NULL;&#xa;     END IF;&#xa;     ELSE--&#xa;&#xa;   SET_LOV_PROPERTY(&apos;LOV_MOVIMENTACAO1&apos;,GROUP_NAME, &apos;LOV_MOVIMENTACAO1&apos;);         &#xa;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;X&apos;) IN (&apos;O&apos;,&apos;S&apos;) &#xa;      AND SHOW_LOV(&apos;LOV_MOVIMENTACAO1&apos;) THEN&#xa;       NULL; &#xa;    ELSE            &#xa;     SET_LOV_PROPERTY(&apos;LOV_MOVIMENTACAO&apos;,GROUP_NAME, &apos;LOV_MOVIMENTACAO&apos;);&#xa;        IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;S&apos;)= &apos;S&apos; &#xa;          AND SHOW_LOV(&apos;LOV_MOVIMENTACAO&apos;) THEN&#xa;           NULL;&#xa;       END IF;&#xa;   END IF;&#xa;  END IF;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="BEGIN&#xa;  VALIDATE(ITEM_SCOPE);&#xa;  IF NOT FORM_SUCCESS THEN&#xa;    RETURN;&#xa;  END IF;&#xa;  NEXT_ITEM;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="QT_PREVISTA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Quantidade a Solicitar. Somente ser&#xe1; aceito casas decimais para este campo se o tipo de c&#xe1;lculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Quantidade a Solicitar.Somente ser&#xe1; aceito casas decimais para este campo se o tipo de c&#xe1;lculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE&#xa;    V_TP_UNIDMED   TIPOCALCULOPRECO.TP_UNIDMED%TYPE;  &#xa;BEGIN  &#xa;    IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL AND :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;      BEGIN&#xa;        SELECT TIPOCALCULOPRECO.TP_UNIDMED&#xa;          INTO V_TP_UNIDMED&#xa;          FROM TIPOCALCULOPRECO, &#xa;               ITEMEMPRESA&#xa;          WHERE TIPOCALCULOPRECO.CD_TIPOCALCULO = ITEMEMPRESA.CD_TIPOCALCULO&#xa;            AND ITEMEMPRESA.CD_EMPRESA          = :ITEMCOMPRA.CD_EMPRESA&#xa;            AND ITEMEMPRESA.CD_ITEM             = :ITEMCOMPRA.CD_ITEM;&#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;           --O item &#xa2;CD_ITEM&#xa2; na empresa &#xa2;CD_EMPRESA&#xa2; n&#xe3;o possui tipo de c&#xe1;lculo cadastrado. Verifique TIT001, page Empresas.&#xa;          MENSAGEM_PADRAO(2886, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;        WHEN TOO_MANY_ROWS THEN&#xa;          --O item &#xa2;CD_ITEM&#xa2; na empresa &#xa2;CD_EMPRESA&#xa2; possui v&#xe1;rios tipos de c&#xe1;lculo cadastrado. Verifique TIT001.&#xa;          MENSAGEM_PADRAO(4487, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;&apos;);&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;        WHEN OTHERS THEN&#xa;          --Ocorreu erro ao pesquisar tipo de c&#xe1;lculo para o item &#xa2;CD_ITEM&#xa2; na empresa &#xa2;CD_EMPRESA&#xa2; possui v&#xe1;rios tipo de c&#xe1;lculo cadastrado. Erro &#xa2;SQLERRM&#xa2;.&#xa;          MENSAGEM_PADRAO(4488, &apos;&#xa2;CD_ITEM=&apos;||:ITEMCOMPRA.CD_ITEM||&apos;&#xa2;CD_EMPRESA=&apos;||:ITEMCOMPRA.CD_EMPRESA||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;      END;&#xa;    PACK_GLOBAL.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#xa;    PACK_GLOBAL.VALIDA_QUANTIDADE := TRUE;&#xa;    SYNCHRONIZE;    &#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE&#xa;V_ST_UNIDADEITENS  VARCHAR2(1);&#xa;&#xa;BEGIN  &#xa;  --Foi modificado este conceito do compras&#xa;  --Pois na Averama pode diminuir uma quantidade Solicitada&#xa;  IF :ITEMCOMPRA.QT_PREVISTA IS NOT NULL THEN &#xa;    IF :ITEMCOMPRA.QT_PREVISTA &lt; PACK_GLOBAL.QT_PREVISTA AND PACK_GLOBAL.VALIDA_QUANTIDADE THEN&#xa;      IF SHOW_ALERT(&apos;ALR_DIMINUIR&apos;)  = ALERT_BUTTON2 THEN&#xa;        :ITEMCOMPRA.QT_PREVISTA  :=  PACK_GLOBAL.QT_PREVISTA;&#xa;      ELSE&#xa;        PACK_GLOBAL.VALIDA_QUANTIDADE := FALSE;&#xa;      END IF;  &#xa;    END IF;&#xa;    /**FLA:26/11/2019:141242&#xa;     * L&#xf3;gica do Par&#xe2;metro que permite informar mais de uma unidade para Item de servi&#xe7;o&#xa;     */&#xa;    V_ST_UNIDADEITENS := NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;ST_UNIDADEITENS&apos;), &apos;N&apos;);&#xa;    IF PACK_GLOBAL.TP_ITEM = &apos;S&apos; AND V_ST_UNIDADEITENS = &apos;N&apos; THEN&#xa;      :ITEMCOMPRA.QT_PREVISTA := 1;&#xa;    END IF;&#xa;    IF (:ITEMCOMPRA.QT_PREVISTA IS NULL) OR  (:ITEMCOMPRA.QT_PREVISTA = 0)THEN &#xa;      --A quantidade deve ser informada.&#xa;      MENSAGEM_PADRAO(1827,&apos;&apos;);&#xa;    /** WLV:13/08/2012:41514&#xa;      * Comentado o GO_ITEM abaixo pois n&#xe3;o h&#xe1; a necessidade, e estava errado com os dois pontos na frente do nome do bloco&#xa;      */   &#xa;      --GO_ITEM(&apos;:ITEMCOMPRA.QT_PREVISTA&apos;);&#xa;      :ITEMCOMPRA.QT_PREVISTA := NULL;    &#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE&#xa;  V_DS_MOVIMENTACAO VARCHAR2(60);&#xa;  VL_ESTIMADO       NUMBER;&#xa;  V_MENSAGEM        VARCHAR2(32000);&#xa;  E_GERAL            EXCEPTION;&#xa;BEGIN  &#xa;  VALIDATE (ITEM_SCOPE);&#xa;  IF NOT FORM_SUCCESS THEN&#xa;    RETURN;&#xa;  END IF;&#xa;  &#xa;  VALIDATE (RECORD_SCOPE);&#xa;  IF NOT FORM_SUCCESS THEN&#xa;    RETURN;&#xa;  END IF;&#xa;  &#xa;  IF (:ITEMCOMPRA.QT_PREVISTA &gt; 0) THEN&#xa;    /*MGK:52401:03/12/12 - Adicionada verifica&#xe7;&#xe3;o para que itens de quantidade tenham a QT_PREVISTA arredondada.*/&#xa;    DEFINIR_ROUND(I_CD_ITEM  =&gt; :ITEMCOMPRA.CD_ITEM,&#xa;                  O_MENSAGEM =&gt; V_MENSAGEM);&#xa;  &#xa;    IF (V_MENSAGEM IS NOT NULL) THEN                      &#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;  END IF;--IF (:ITEMCOMPRA.QT_PREVISTA &gt; 0) THEN&#xa;  &#xa;  BEGIN&#xa;    /*CSL:30/12/2013:64869*/&#xa;    IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;      SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;             PLANOCONTABIL.TP_CONTACONTABIL&#xa;        INTO V_DS_MOVIMENTACAO,&#xa;             :ITEMCOMPRA.TP_CONTACONTABIL&#xa;        FROM PARMOVIMENT,&#xa;             HISTCONTB,&#xa;             PLANOCONTABIL&#xa;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#xa;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL;&#xa;    ELSE&#xa;      SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;             PLANOCONTABILVERSAO.TP_CONTACONTABIL&#xa;        INTO V_DS_MOVIMENTACAO,&#xa;             :ITEMCOMPRA.TP_CONTACONTABIL&#xa;        FROM PARMOVIMENT,&#xa;             HISTCONTB,&#xa;             PLANOCONTABILVERSAO&#xa;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#xa;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#xa;          AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#xa;             PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));&#xa;    END IF;    &#xa;  EXCEPTION &#xa;    WHEN NO_DATA_FOUND THEN&#xa;      NULL;&#xa;  END;  &#xa;  /* GDG: 22978 : 13/11/2009 &#xa;   * Quando for realizado o pedido de um novo item(item este em que n&#xe3;o h&#xe1; registro de compra na empresa)&#xa;   * o programa abrir&#xe1; uma janela para que o usu&#xe1;rio que est&#xe1; abrindo a solicita&#xe7;&#xe3;o de compra informe&#xa;   * um valor estimado de quanto vai custar cada unidade do referido item.&#xa;   * Quando esse item j&#xe1; tiver um registro de compra, o programa pegar&#xe1; automaticamente o ultimo valor&#xa;   * negociado para o item (valor unit&#xe1;rio da ultima compra).&#xa;   * Esses valores ser&#xe3;o gravados somente se o par&#xe2;metro do COM009 estiver marcado (&apos;Permitir inserir valor estimado (COM009)&apos;).&#xa;   * Quando essa informa&#xe7;&#xe3;o ser gravada, ser&#xe1; possivel visualiz&#xe1;-la no COM002, em datelhes da solicita&#xe7;&#xe3;o.&#xa;   */&#xa;  IF :ITEMCOMPRA.QT_PREVISTA &gt; 0 &#xa;   AND :ITEMCOMPRA.VL_ESTIMADO IS NULL &#xa;   AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:GLOBAL.CD_EMPRESA,&apos;CHK_VLESTIMADO_COM001&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;    BEGIN      &#xa;      SELECT ITEMPEDIDOCOMPRA.VL_UNITITEM&#xa;        INTO VL_ESTIMADO&#xa;         FROM ITEMPEDIDOCOMPRA&#xa;        WHERE ITEMPEDIDOCOMPRA.CD_ITEM    = :ITEMCOMPRA.CD_ITEM&#xa;          AND ITEMPEDIDOCOMPRA.CD_EMPRESA = :CONTROLE.CD_EMPRESA&#xa;          AND ITEMPEDIDOCOMPRA.NR_PEDIDO  = (SELECT MAX(ITEMPEDIDOCOMPRA.NR_PEDIDO)&#xa;                                              FROM ITEMPEDIDOCOMPRA&#xa;                                             WHERE ITEMPEDIDOCOMPRA.CD_EMPRESA = :CONTROLE.CD_EMPRESA&#xa;                                               AND ITEMPEDIDOCOMPRA.CD_ITEM    = :ITEMCOMPRA.CD_ITEM);&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;         VL_ESTIMADO := NULL;&#xa;    END;  &#xa;    IF VL_ESTIMADO IS NULL THEN&#xa;      CENTRALIZA_FORM(&apos;WIN_ITEMCOMPRA&apos;, &apos;WIN_VLESTIMADO&apos;);&#xa;      GO_ITEM(&apos;ITEMCOMPRA_AUX.VL_ESTIMADO_AUX&apos;);&#xa;    ELSE      &#xa;      :ITEMCOMPRA.VL_ESTIMADO := VL_ESTIMADO;&#xa;    END IF;&#xa;  ELSE      &#xa;    IF :ITEMCOMPRA.TP_CONTACONTABIL = &apos;CC&apos;  THEN&#xa;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;        IF :ITEMCOMPRA.QT_PREVISTA &gt; 0 THEN&#xa;          --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#xa;          GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;          SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;          PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM); &#xa;        ELSE&#xa;          --O campo Quantidade deve ser informado.&#xa;          MENSAGEM_PADRAO(3654,&apos;&apos;);&#xa;          GO_ITEM(&apos;ITEMCOMPRA.QT_PREVISTA&apos;);&#xa;        END IF;  &#xa;      END IF;&#xa;        &#xa;    ELSIF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_OBRIGARATEIONEGOCIO&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;      -- TRATAMENTO DE RATEIO POR NEGOCIO    &#xa;      GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;      PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM);   &#xa;    ELSE&#xa;  --    NEXT_RECORD;&#xa;     -- GO_ITEM(&apos;ITEMCOMPRA.CD_ITEM&apos;);&#xa;     GO_ITEM(&apos;ITEMCOMPRA.CD_TIPOLOCALARMAZ&apos;);&#xa;    END IF;&#xa;  END IF;&#xa;  :CONTROLE.ST_MUDAUTORIZADOR := &apos;S&apos;;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  E_GERAL      EXCEPTION;&#xa;&#xa;BEGIN  &#xa;  IF (:ITEMCOMPRA.QT_PREVISTA &gt; 0) THEN&#xa;    /*MGK:52401:07/12/12 - Adicionada verifica&#xe7;&#xe3;o para que itens de quantidade tenham a QT_PREVISTA arredondada.*/&#xa;    DEFINIR_ROUND(I_CD_ITEM  =&gt; :ITEMCOMPRA.CD_ITEM,&#xa;                  O_MENSAGEM =&gt; V_MENSAGEM);&#xa;  &#xa;    IF (V_MENSAGEM IS NOT NULL) THEN                      &#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;  END IF;--IF (:ITEMCOMPRA.QT_PREVISTA &gt; 0) THEN&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="VL_ESTIMADO: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@"/>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="BTN_CENTROCUSTO: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE &#xa;  V_CD_OPERESTOQUE    CMI.CD_OPERESTOQUE%TYPE;&#xa;  V_DS_MOVIMENTACAO   VARCHAR2(60);&#xa;  V_MENSAGEM           VARCHAR2(32000);&#xa;  E_GERAL             EXCEPTION;&#xa;  V_ST_LANCAMOV VARCHAR2(10);&#xa;  V_ALERT       NUMBER;&#xa;  V_TP_INFORME  VARCHAR2(10);&#xa;BEGIN  &#xa;  VALIDATE(RECORD_SCOPE);&#xa;  IF NOT FORM_SUCCESS THEN&#xa;    RETURN;&#xa;  END IF;&#xa;  &#xa;  BEGIN&#xa;    /*CSL:30/12/2013:64869*/&#xa;    IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;      SELECT CMI.CD_OPERESTOQUE, &#xa;             PARMOVIMENT.DS_MOVIMENTACAO,&#xa;             PLANOCONTABIL.TP_CONTACONTABIL&#xa;        INTO V_CD_OPERESTOQUE, &#xa;             V_DS_MOVIMENTACAO,&#xa;             :ITEMCOMPRA.TP_CONTACONTABIL&#xa;        FROM PARMOVIMENT, &#xa;             CMI,&#xa;             HISTCONTB,&#xa;             PLANOCONTABIL&#xa;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;           AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#xa;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#xa;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#xa;         AND CMI.TP_FATES                = &apos;0&apos;;&#xa;    ELSE&#xa;      SELECT CMI.CD_OPERESTOQUE, &#xa;             PARMOVIMENT.DS_MOVIMENTACAO,&#xa;             PLANOCONTABILVERSAO.TP_CONTACONTABIL&#xa;        INTO V_CD_OPERESTOQUE, &#xa;             V_DS_MOVIMENTACAO,&#xa;             :ITEMCOMPRA.TP_CONTACONTABIL&#xa;        FROM PARMOVIMENT, &#xa;             CMI,&#xa;             HISTCONTB,&#xa;             PLANOCONTABILVERSAO&#xa;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;           AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#xa;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#xa;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#xa;          AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#xa;              PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE))&#xa;         AND CMI.TP_FATES                = &apos;0&apos;;&#xa;    END IF;      &#xa;  EXCEPTION&#xa;    WHEN NO_DATA_FOUND THEN&#xa;      /*CSL:22115:10/06/09&#xa;       *Alterada a mensagem: &apos;Caracteristicas da movimenta&#xe7;&#xe3;o :ITEMCOMPRA.CD_MOVIMENTACAO n&#xe3;o encontrados.&apos; &#xa;       */&#xa;      --Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; inv&#xe1;lida para esta opera&#xe7;&#xe3;o. Verifique se o CMI desta movimenta&#xe7;&#xe3;o &#xe9; do tipo ENTRADA. Verifique TCB008/TCB002. &#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4723,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;      RAISE E_GERAL;&#xa;    WHEN TOO_MANY_ROWS THEN&#xa;      --A Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; est&#xe1; cadastrada v&#xe1;rias vezes. Verifique TCB008.&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(47,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;      RAISE E_GERAL;&#xa;    WHEN OTHERS THEN&#xa;      --Erro ao Pesquisar a Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2;. Verifique TCB008. Erro &#xa2;SQLERRM&#xa2;.&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(48,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRA.CD_MOVIMENTACAO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;      RAISE E_GERAL;&#xa;  END;&#xa;  &#xa;  SELECT NVL(ST_LANCAMOV,&apos;N&apos;) &#xa;    INTO V_ST_LANCAMOV&#xa;    FROM PARMCOMPRA&#xa;   WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#xa;  &#xa;  --- IF PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,&apos;COMPRAS&apos;) = &apos;S&apos; AND &#xa;  ---   NVL(PACK_PARMGEN.CONSULTA_PARAMETRO (&apos;ORC&apos;,50,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CONTAORCCOMPRAS&apos;),&apos;N&apos;) = &apos;S&apos; THEN      &#xa;  V_TP_INFORME := &apos;S&apos;;&#xa;  FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#xa;    IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.EXISTS(I) AND PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(I).CD_ITEM = :ITEMCOMPRA.CD_ITEM THEN&#xa;      V_TP_INFORME := &apos;C&apos;;&#xa;      EXIT;&#xa;    END IF;  &#xa;  END LOOP;  &#xa;  &#xa;  IF V_TP_INFORME = &apos;S&apos; THEN&#xa;    FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.COUNT LOOP&#xa;      IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.EXISTS(I) AND PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(I).CD_ITEM = :ITEMCOMPRA.CD_ITEM THEN&#xa;        V_TP_INFORME := &apos;N&apos;;&#xa;        EXIT;&#xa;      END IF;  &#xa;    END LOOP;  &#xa;  END IF;&#xa;  &#xa;  IF V_TP_INFORME = &apos;C&apos; THEN&#xa;    --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#xa;    GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;    PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM); &#xa;  ELSIF V_TP_INFORME = &apos;N&apos; THEN&#xa;    -- TRATAMENTO DE RATEIO POR NEGOCIO&#xa;    GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;    SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;  &#xa;    PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM); &#xa;  ELSE&#xa;    &#xa;    IF V_ST_LANCAMOV = &apos;S&apos; OR :ITEMCOMPRA.TP_CONTACONTABIL = &apos;CC&apos; OR &#xa;      PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,&apos;COMPRAS&apos;) = &apos;S&apos; THEN  &#xa;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;        IF :ITEMCOMPRA.QT_PREVISTA &gt; 0 THEN&#xa;          &#xa;          IF :ITEMCOMPRA.TP_CONTACONTABIL &lt;&gt; &apos;CC&apos; &#xa;            AND (PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,&apos;COMPRAS&apos;) = &apos;S&apos; AND  V_ST_LANCAMOV = &apos;S&apos; ) THEN&#xa;            V_ALERT := SHOW_ALERT(&apos;ALERTA_TIPORATEIO&apos;);&#xa;            &#xa;            IF V_ALERT = ALERT_BUTTON1 THEN&#xa;              -- TRATAMENTO DE RATEIO POR NEGOCIO&#xa;              GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;              SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;            &#xa;              PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM); &#xa;                                   &#xa;            ELSIF V_ALERT = ALERT_BUTTON2 THEN&#xa;              --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#xa;              GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;              SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;              PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM);              &#xa;            ELSE  &#xa;              NULL;&#xa;            END IF;&#xa;          ELSIF :ITEMCOMPRA.TP_CONTACONTABIL &lt;&gt; &apos;CC&apos; &#xa;            AND (PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,&apos;COMPRAS&apos;) = &apos;S&apos; AND  V_ST_LANCAMOV = &apos;N&apos; ) THEN&#xa;              -- TRATAMENTO DE RATEIO POR NEGOCIO&#xa;            GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;            SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;            PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM); &#xa;            &#xa;          ELSE  &#xa;            &#xa;            --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#xa;            GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;            SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;            PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM);          &#xa;          END IF;&#xa;        ELSE&#xa;          --A quantidade deve ser informada.&#xa;          MENSAGEM_PADRAO(1827,&apos;&apos;);&#xa;          GO_ITEM(&apos;ITEMCOMPRA.QT_PREVISTA&apos;);&#xa;        END IF;  &#xa;      END IF;  &#xa;    END IF;&#xa;  END IF;  &#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN &#xa;    NULL;  &#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);  &#xa;    RAISE FORM_TRIGGER_FAILURE;  &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="BTN_SEL_ANEXO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE&#xa;  V_ANEXO     ARQUIVO.DS_ARQUIVO%TYPE;&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  E_GERAL     EXCEPTION;&#xa;BEGIN  &#xa;  IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#xa;    &#xa;    IF NOT PACK_PROCEDIMENTOS.EXISTE_ARQUIVOS(:ITEMCOMPRA.CD_EMPRESA,:SYSTEM.CURSOR_RECORD) THEN&#xa;      V_ANEXO := GET_FILE_NAME(NULL, NULL, NULL, &apos;Arquivo para Anexo&apos;, OPEN_FILE, TRUE);&#xa;      &#xa;      --:ITEMCOMPRA.DS_ARQUIVO := V_ANEXO;&#xa;      PACK_PROCEDIMENTOS.GRAVA_ARQUIVOS_VETOR(:ITEMCOMPRA.CD_EMPRESA,&#xa;                                              :SYSTEM.CURSOR_RECORD, &#xa;                                              V_ANEXO,&#xa;                                              V_MENSAGEM);&#xa;          &#xa;      IF V_MENSAGEM IS NOT NULL THEN&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    ELSE&#xa;      IF NOT MSG_CONFIRMACAO(&apos;Essa solicita&#xe7;&#xe3;o j&#xe1; tem um anexo salvo, deseja cadastrar mais um?&apos;) THEN&#xa;        RETURN;&#xa;      END IF;&#xa;      &#xa;      V_ANEXO := GET_FILE_NAME(NULL, NULL, NULL, &apos;Arquivo para Anexo&apos;, OPEN_FILE, TRUE);&#xa;    &#xa;      PACK_PROCEDIMENTOS.GRAVA_ARQUIVOS_VETOR(:ITEMCOMPRA.CD_EMPRESA,&#xa;                                              :SYSTEM.CURSOR_RECORD, &#xa;                                              V_ANEXO,                                                &#xa;                                              V_MENSAGEM);&#xa;    &#xa;      IF V_MENSAGEM IS NOT NULL THEN&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;    END IF;  &#xa;      &#xa;  ELSE&#xa;    -- S&#xf3; &#xe9; poss&#xed;vel verificar se o anexo &#xe9; permitido ap&#xf3;s ser informado o n&#xfa;mero da empresa, &#xa;    -- portanto se for nulo alertar o usu&#xe1;rio&#xa;    /*O campo &#xa2;NM_CAMPO&#xa2; deve ser informado.*/&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1545, &apos;&#xa2;NM_CAMPO=&apos;||&apos;Empresa&apos;||&apos;&#xa2;&apos;);&#xa;    RAISE E_GERAL;&#xa;  END IF;                    &#xa;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Observa&#xe7;&#xe3;o&apos;, V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||&apos; - Erro&apos;, SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="CD_TIPOLOCALARMAZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Tipo Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA.CD_TIPOLOCALARMAZ IS NOT NULL THEN    &#xa;    SELECT DISTINCT LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ&#xa;      INTO :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#xa;      FROM LOCALARMAZENAGEM&#xa;     WHERE LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ &#xa;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;&#xa;       &#xa;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;         &#xa;  END IF;  &#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    --O Tipo de Local de Armazenagem &#xa2;CD_TIPOLOCALARMAZ&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique TES001.&#xa;    MENSAGEM_PADRAO(123,&apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ||&apos;&#xa2;&apos;);    &#xa;    :ITEMCOMPRA.CD_TIPOLOCALARMAZ := NULL;&#xa;    RAISE FORM_TRIGGER_FAILURE; &#xa;  WHEN OTHERS THEN&#xa;    --Ocorreu um erro inesperado ao buscar dados tipo de local de armazenagem. Erro: &#xa2;SQLERRM&#xa2;.&#xa;    MENSAGEM_PADRAO(3120,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);    &#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-MOUSE-DOUBLECLICK">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="DECLARE&#xa;  V_MENSAGEM   VARCHAR2(32000);&#xa;BEGIN  &#xa;  PACK_PROCEDIMENTOS.VALIDA_LOCALARMAZ(V_MENSAGEM);  --eml:25/05/2020:148401&#xa;  IF V_MENSAGEM IS NOT NULL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  END IF;&#xa;END;  "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="CD_LOCALARMAZ: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA.CD_LOCALARMAZ IS NOT NULL THEN&#xa;    SELECT DISTINCT LOCALARMAZENAGEM.CD_LOCALARMAZ&#xa;      INTO :ITEMCOMPRA.CD_LOCALARMAZ&#xa;      FROM LOCALARMAZENAGEM&#xa;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ   &#xa;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ &#xa;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA; &#xa; &#xa;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;     &#xa;  END IF;    &#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    --O local de armazenagem (Tipo: &#xa2;CD_TIPOLOCALARMAZ&#xa2;, &#xa2;CD_LOCALARMAZ&#xa2;) n&#xe3;o est&#xe1; cadastrado. Verifique TES002.&#xa;    MENSAGEM_PADRAO(233,&apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||&apos;&#xa2;CD_LOCALARMAZ=&apos;||:ITEMCOMPRA.CD_LOCALARMAZ||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: &#xa2;SQLERRM&#xa2;.&#xa;     MENSAGEM_PADRAO(3120,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="NR_SUBLOCARMAZ1: Char(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Sub 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ1 IS NOT NULL THEN&#xa;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ1&#xa;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ1&#xa;      FROM LOCALARMAZENAGEM&#xa;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ    &#xa;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#xa;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;    &#xa;  &#xa;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;&#xa;    &#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    --O local de armazenagem (Tipo: &#xa2;CD_TIPOLOCALARMAZ&#xa2;, &#xa2;CD_LOCALARMAZ&#xa2;) n&#xe3;o est&#xe1; cadastrado. Verifique TES002.&#xa;    MENSAGEM_PADRAO(233,&apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||&apos;&#xa2;CD_LOCALARMAZ=&apos;||:ITEMCOMPRA.CD_LOCALARMAZ||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: &#xa2;SQLERRM&#xa2;.&#xa;     MENSAGEM_PADRAO(3120,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;    &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="NR_SUBLOCARMAZ2: Button(7)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="@">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="Sub 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779082" FOLDED="true" MODIFIED="1607991779082" TEXT="body">
<node CREATED="1607991779082" MODIFIED="1607991779082" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ2 IS NOT NULL THEN&#xa;&#xa;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ2&#xa;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ2&#xa;      FROM LOCALARMAZENAGEM&#xa;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ    &#xa;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2  &#xa;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;  &#xa;&#xa;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    --O local de armazenagem (Tipo: &#xa2;CD_TIPOLOCALARMAZ&#xa2;, &#xa2;CD_LOCALARMAZ&#xa2;) n&#xe3;o est&#xe1; cadastrado. Verifique TES002.&#xa;    MENSAGEM_PADRAO(233,&apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||&apos;&#xa2;CD_LOCALARMAZ=&apos;||:ITEMCOMPRA.CD_LOCALARMAZ||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: &#xa2;SQLERRM&#xa2;.&#xa;     MENSAGEM_PADRAO(3120,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_SUBLOCARMAZ3: Button(2)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Sub 3">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ3 IS NOT NULL THEN&#xa;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ3&#xa;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ3&#xa;      FROM LOCALARMAZENAGEM&#xa;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ     &#xa;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2  &#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3  &#xa;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;      &#xa;  &#xa;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM; &#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    --O local de armazenagem (Tipo: &#xa2;CD_TIPOLOCALARMAZ&#xa2;, &#xa2;CD_LOCALARMAZ&#xa2;) n&#xe3;o est&#xe1; cadastrado. Verifique TES002.&#xa;    MENSAGEM_PADRAO(233,&apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||&apos;&#xa2;CD_LOCALARMAZ=&apos;||:ITEMCOMPRA.CD_LOCALARMAZ||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: &#xa2;SQLERRM&#xa2;.&#xa;     MENSAGEM_PADRAO(3120,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_SUBLOCARMAZ4: Button(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Sub 4">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ4 IS NOT NULL THEN&#xa;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ4&#xa;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ4&#xa;      FROM LOCALARMAZENAGEM&#xa;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ     &#xa;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2  &#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3  &#xa;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ4   = :ITEMCOMPRA.NR_SUBLOCARMAZ4&#xa;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA; &#xa;       &#xa;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;    &#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    --O local de armazenagem (Tipo: &#xa2;CD_TIPOLOCALARMAZ&#xa2;, &#xa2;CD_LOCALARMAZ&#xa2;) n&#xe3;o est&#xe1; cadastrado. Verifique TES002.&#xa;    MENSAGEM_PADRAO(233,&apos;&#xa2;CD_TIPOLOCALARMAZ=&apos;||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||&apos;&#xa2;CD_LOCALARMAZ=&apos;||:ITEMCOMPRA.CD_LOCALARMAZ||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: &#xa2;SQLERRM&#xa2;.&#xa;     MENSAGEM_PADRAO(3120,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="NEXT_RECORD;                          &#xa;GO_ITEM(&apos;ITEMCOMPRA.CD_ITEM&apos;);        "/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NM_LOCALARMAZENAGEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="LOV_HISTCONTB">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DT_INICIO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Data In&#xed;cio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Data de In&#xed;cio dos Servi&#xe7;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Data de In&#xed;cio dos Servi&#xe7;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="BEGIN&#xa;  IF (:ITEMCOMPRA.DT_DESEJADA IS NOT NULL) AND (:ITEMCOMPRA.DT_INICIO IS NOT NULL) THEN&#xa;    IF :ITEMCOMPRA.DT_INICIO &gt; :ITEMCOMPRA.DT_DESEJADA THEN&#xa;       --Data de in&#xed;cio da obra deve ser menor que data desejada.&#xa;       MENSAGEM_PADRAO(4698,&apos;&apos;);&#xa;       :ITEMCOMPRA.DT_INICIO := :ITEMCOMPRA.DT_DESEJADA;&#xa;       RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DS_OBSERVACAOEXT: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Observa&#xe7;&#xe3;o Externa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Observa&#xe7;&#xe3;o Externa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Observa&#xe7;&#xe3;o Externa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Observa&#xe7;&#xe3;o Interna">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Observa&#xe7;&#xe3;o Interna">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Observa&#xe7;&#xe3;o Interna">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="BEGIN&#xa;  IF PACK_GLOBAL.TP_ITEM = &apos;S&apos; THEN&#xa;    NEXT_ITEM;&#xa;  ELSE&#xa;    NEXT_RECORD;&#xa;    GO_ITEM(&apos;ITEMCOMPRA.CD_ITEM&apos;);&#xa;  END IF;  &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DS_ITEMSERVICO: Char(1000)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Descri&#xe7;&#xe3;o Servi&#xe7;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Descri&#xe7;&#xe3;o dos Servi&#xe7;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Descri&#xe7;&#xe3;o dos Servi&#xe7;os">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="DECLARE&#xa;  I_TP_ITEM VARCHAR2(01);&#xa;BEGIN&#xa;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#xa;    BEGIN&#xa;      SELECT ITEM.TP_ITEM &#xa;        INTO I_TP_ITEM &#xa;        FROM ITEM &#xa;       WHERE (ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM); &#xa;    EXCEPTION&#xa;      WHEN OTHERS THEN &#xa;        NULL;&#xa;    END;&#xa;  &#xa;    IF I_TP_ITEM = &apos;S&apos; THEN&#xa;      IF  :ITEMCOMPRA.DS_ITEMSERVICO IS NULL THEN&#xa;         --A descri&#xe7;&#xe3;o do servi&#xe7;o deve ser informada.&#xa;         MENSAGEM_PADRAO(4688,&apos;&apos;);&#xa;         RAISE FORM_TRIGGER_FAILURE;&#xa;      END IF;&#xa;      --GO_BLOCK (&apos;ITEMCOMPRACCUSTO&apos;);&#xa;      NEXT_RECORD;&#xa;      GO_ITEM(&apos;ITEMCOMPRA.CD_ITEM&apos;);&#xa;    END IF;&#xa;  &#xa;  END IF;&#xa;&#xa;  /*IF PACK_GLOBAL.TP_ITEM IS NOT NULL THEN &#xa;    IF PACK_GLOBAL.TP_ITEM = &apos;S&apos; THEN&#xa;       GO_BLOCK (&apos;ITEMCOMPRACCUSTO&apos;);   &#xa;    END IF;&#xa;  ELSIF PACK_GLOBAL.TP_ITEM IS NULL THEN&#xa;    IF (:ITEMCOMPRA.CD_ITEM IS NOT NULL) THEN&#xa;        &#xa;        IF I_TP_ITEM = &apos;S&apos; THEN&#xa;          GO_BLOCK (&apos;ITEMCOMPRACCUSTO&apos;);   &#xa;        END IF;&#xa;    END IF;&#xa;  END IF;*/&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_EMPRESAITEM: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Cd Empresaitem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_EMPRESAUTORIZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Cd Empresaautoriz">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT=":ITEMCOMPRA.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_SOLICITANTE: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Cd Usuasolicita">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT=":GLOBAL.CD_USUARIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_EMPRESASOLIC: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT=":ITEMCOMPRA.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DT_SOLICITACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Data Solicita&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="$$DATE$$">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DT_CONSOLIDACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Dt Consolidacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="QT_NEGOCIADA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Qt Negociada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_ENDERENTREGA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Cd Enderentrega">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="ST_ITEMCOMPRA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="St Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="0">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="ST_CRONOGRAMACOMPRA: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="St Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DT_ALTERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Dt Alteracao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DT_LIBERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Dt Liberacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="ST_EMISSAONF: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="St Emissaonf">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_ITEMPRORIGEM: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Nr Itemprorigem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_NEGOCIACAO: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Nr Negociacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DT_RECORD: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Dt Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="HR_RECORD: Char(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Hr Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DS_OBSCANCEL: Char(500)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Informe o Motivo do Cancelamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="GO_ITEM(&apos;CONTROLE.BT_SALVAR&apos;);"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="GO_ITEM(&apos;CONTROLE.BT_VOLTAR&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="DECLARE&#xa;  V_ST_ITEMCOMPRA    ITEMCOMPRA.ST_ITEMCOMPRA%TYPE;  &#xa;BEGIN&#xa;&#xa;IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NOT NULL THEN&#xa;     &#xa;     SELECT CD_EMPRESA,              ST_ITEMCOMPRA&#xa;      INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#xa;      FROM ITEMCOMPRA&#xa;     WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#xa;       AND CD_SOLICITANTE    =    :GLOBAL.CD_USUARIO&#xa;       AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#xa;       &#xa;       --Cancelado&#xa;       IF V_ST_ITEMCOMPRA    =   99 THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Solicita&#xe7;&#xe3;o de compra, CANCELADA  n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;       END IF;&#xa;       &#xa;       --Aguardando Libera&#xe7;&#xe3;o&#xa;       IF V_ST_ITEMCOMPRA   =   0  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Aguardando Libera&#xe7;&#xe3;o  n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Recusada&#xa;       IF V_ST_ITEMCOMPRA   =   2  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Recusada n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Em Cota&#xe7;&#xe3;o&#xa;       IF V_ST_ITEMCOMPRA   =   3  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Em Cota&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Em Negocia&#xe7;&#xe3;o ...&#xa;       IF V_ST_ITEMCOMPRA   =   4  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Em Negocia&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Em Aprova&#xe7;&#xe3;o ... &#xa;       IF V_ST_ITEMCOMPRA   = 5  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Em Aprova&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Aprova&#xe7;&#xe3;o ...&#xa;       IF V_ST_ITEMCOMPRA   = 6  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Aprova&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;        &#xa;       --Solicita&#xe7;&#xe3;o, Pedido Gerado ... &#xa;       IF V_ST_ITEMCOMPRA   = 7  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Pedido foi Gerado n&#xe3;o &#xe9; poss&#xed;vel atualizar, aguardando chegada  ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;         CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       -- Cota&#xe7;&#xe3;o &#xa;       IF V_ST_ITEMCOMPRA   IN (1,11)  THEN&#xa;         SET_BLOCK_PROPERTY(&apos;ITEMCOMPRA&apos;,DEFAULT_WHERE,&apos;NR_ITEMCOMPRA = &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA);&#xa;         EXECUTE_QUERY(NO_VALIDATE);&#xa;           ---Atualiza para aguandando solicita&#xe7;ao a solicita&#xe7;&#xe3;o devolvida &#xa;           --------------------------------------------------------------------&#xa;           IF V_ST_ITEMCOMPRA = 11 THEN &#xa;             :ITEMCOMPRA.ST_ITEMCOMPRA:=0;            &#xa;           END IF; &#xa;           -------------------------------------------------------------------&#xa;       END IF;&#xa;  END IF;&#xa;  NEXT_ITEM;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;     BEGIN  &#xa;        SELECT CD_EMPRESA,            ST_ITEMCOMPRA&#xa;         INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#xa;         FROM ITEMCOMPRA&#xa;        WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#xa;          AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#xa;    &#xa;    mensagem(&apos;Maxys&apos;,&apos;Solicita&#xe7;&#xe3;o de compra pertence a outro Solicitante !&apos;,2);    &#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;    &#xa;    EXCEPTION&#xa;         WHEN NO_DATA_FOUND THEN&#xa;          mensagem(&apos;Maxys&apos;,&apos;Solicita&#xe7;&#xe3;o de compra n&#xe3;o cadastrada !&apos;,2);    &#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;    END;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_DEPARTAMENTO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="DECLARE&#xa;  V_ST_ITEMCOMPRA    ITEMCOMPRA.ST_ITEMCOMPRA%TYPE;  &#xa;BEGIN&#xa;&#xa;IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NOT NULL THEN&#xa;     &#xa;     SELECT CD_EMPRESA,              ST_ITEMCOMPRA&#xa;      INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#xa;      FROM ITEMCOMPRA&#xa;     WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#xa;       AND CD_SOLICITANTE    =    :GLOBAL.CD_USUARIO&#xa;       AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#xa;       &#xa;       --Cancelado&#xa;       IF V_ST_ITEMCOMPRA    =   99 THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Solicita&#xe7;&#xe3;o de compra, CANCELADA  n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;       END IF;&#xa;       &#xa;       --Aguardando Libera&#xe7;&#xe3;o&#xa;       IF V_ST_ITEMCOMPRA   =   0  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Aguardando Libera&#xe7;&#xe3;o  n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Recusada&#xa;       IF V_ST_ITEMCOMPRA   =   2  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Recusada n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Em Cota&#xe7;&#xe3;o&#xa;       IF V_ST_ITEMCOMPRA   =   3  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Em Cota&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Em Negocia&#xe7;&#xe3;o ...&#xa;       IF V_ST_ITEMCOMPRA   =   4  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Em Negocia&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Em Aprova&#xe7;&#xe3;o ... &#xa;       IF V_ST_ITEMCOMPRA   = 5  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Em Aprova&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       --Solicita&#xe7;&#xe3;o, Aprova&#xe7;&#xe3;o ...&#xa;       IF V_ST_ITEMCOMPRA   = 6  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Aprova&#xe7;&#xe3;o n&#xe3;o &#xe9; poss&#xed;vel atualizar ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;        CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;        &#xa;       --Solicita&#xe7;&#xe3;o, Pedido Gerado ... &#xa;       IF V_ST_ITEMCOMPRA   = 7  THEN&#xa;         mensagem(&apos;Maxys&apos;,&apos;Status, Pedido foi Gerado n&#xe3;o &#xe9; poss&#xed;vel atualizar, aguardando chegada  ... Solicita&#xe7;&#xe3;o n&#xfa;mero  &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#xa;         CLEAR_FORM(NO_VALIDATE);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;        END IF;&#xa;       &#xa;       -- Cota&#xe7;&#xe3;o &#xa;       IF V_ST_ITEMCOMPRA   IN (1,11)  THEN&#xa;         SET_BLOCK_PROPERTY(&apos;ITEMCOMPRA&apos;,DEFAULT_WHERE,&apos;NR_ITEMCOMPRA = &apos;||:ITEMCOMPRA.NR_ITEMCOMPRA);&#xa;         EXECUTE_QUERY(NO_VALIDATE);&#xa;           ---Atualiza para aguandando solicita&#xe7;ao a solicita&#xe7;&#xe3;o devolvida &#xa;           --------------------------------------------------------------------&#xa;           IF V_ST_ITEMCOMPRA = 11 THEN &#xa;             :ITEMCOMPRA.ST_ITEMCOMPRA:=0;            &#xa;           END IF; &#xa;           -------------------------------------------------------------------&#xa;       END IF;&#xa;  END IF;&#xa;  NEXT_ITEM;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;     BEGIN  &#xa;        SELECT CD_EMPRESA,            ST_ITEMCOMPRA&#xa;         INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#xa;         FROM ITEMCOMPRA&#xa;        WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#xa;          AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#xa;    &#xa;    mensagem(&apos;Maxys&apos;,&apos;Solicita&#xe7;&#xe3;o de compra pertence a outro Solicitante !&apos;,2);    &#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;    &#xa;    EXCEPTION&#xa;         WHEN NO_DATA_FOUND THEN&#xa;          mensagem(&apos;Maxys&apos;,&apos;Solicita&#xe7;&#xe3;o de compra n&#xe3;o cadastrada !&apos;,2);    &#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;    END;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="DECLARE&#xa;    I_CD_AUTORIZADOR VARCHAR2(03);&#xa;    MOSTRA_LOV       BOOLEAN;&#xa;    &#xa;BEGIN&#xa;  IF :SYSTEM.RECORD_STATUS = &apos;INSERT&apos; THEN -- ok                              &#xa;    IF PACK_GLOBAL.ST_APROVSOLIC = &apos;S&apos; THEN --OK&#xa;       IF (:ITEMCOMPRA.CD_EMPRESAUTORIZ IS NOT NULL) AND (:ITEMCOMPRA.CD_EMPRESASOLIC IS NOT NULL) &#xa;                                                     AND (:ITEMCOMPRA.CD_SOLICITANTE  IS NOT NULL) THEN&#xa;           &#xa;         I_CD_AUTORIZADOR := NULL;&#xa;        MOSTRA_LOV := SHOW_LOV(&apos;LOV_AUTORIZADOR&apos;);                         &#xa;       END IF;&#xa;    ELSE&#xa;       :ITEMCOMPRA.CD_SOLICITANTE := NULL;  &#xa;       :ITEMCOMPRA.NM_USUAUTORIZ  := NULL;  &#xa;    END IF;     &#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="null;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="TP_CONTACONTABIL: Char(2)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_TIPOCOMPRA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DS_TIPOCOMPRA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_REGISTRO: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="LOV_GRUPOCC">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_ITEMCOMPRA_AUX: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_EMPRESA_AUX: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_CONTAORCAMENTO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="BEGIN&#xa;  IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM THEN&#xa;    IF :ITEMCOMPRA.DT_DESEJADA IS NOT NULL THEN     &#xa;      IF :ITEMCOMPRA.DT_DESEJADA &lt; SYSDATE - 1 THEN&#xa;        --A Data Desejada deve ser maior que a data atual!&#xa;        MENSAGEM_PADRAO(4686,&apos;&apos;);&#xa;        :ITEMCOMPRA.DT_DESEJADA := SYSDATE;&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;      END IF;&#xa;    END IF;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_ESTUDOMONI: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_PROJETOMONI: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_VERSAOMONI: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_ETAPAMONI: Number(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="ST_PROJETOMONI: Char(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_PROJETOCOMPRA: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="NR_PREITEMCOMPRA: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@"/>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" ID="ID_1149937495" MODIFIED="1607991779083" TEXT="ITEMCOMPRACCUSTO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_EMPRCCUSTODEST: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Empresa&#xa;dest. custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="LOV_EMPRCCUSTODEST">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="DECLARE &#xa;  V_CD_AUTORICCUSTO  ITEMCOMPRACCUSTO.CD_AUTORIZADOR%TYPE;&#xa;  V_CD_AUTORICCUSTO2 ITEMCOMPRACCUSTO.CD_AUTORIZADOR%TYPE;&#xa;--  V_MENSAGEM VARCHAR2(32000);&#xa;BEGIN&#xa;  IF :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST IS NOT NULL THEN&#xa;    :ITEMCOMPRACCUSTO.NM_EMPRESADEST := PACK_VALIDATE.RETORNA_NM_EMPRESA(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST);      &#xa;    IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947             &#xa;       BEGIN  &#xa;        SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                                        &#xa;            INTO V_CD_AUTORICCUSTO&#xa;            FROM AUTORIZCCUSTORESTRITO&#xa;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO--EMLLL               &#xa;              AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#xa;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = &apos;S&apos;;               &#xa;         EXCEPTION &#xa;           WHEN OTHERS THEN             &#xa;            V_CD_AUTORICCUSTO := NULL;                                     &#xa;         END;           &#xa;        IF V_CD_AUTORICCUSTO IS NOT NULL THEN           &#xa;          IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN                                             &#xa;          /*O autorizador da tela principal deve ser informado.*/&#xa;            MENSAGEM_PADRAO(33735, NULL);&#xa;            RAISE FORM_TRIGGER_FAILURE;                 &#xa;          END IF;&#xa;          &#xa;        BEGIN           &#xa;          SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#xa;            INTO V_CD_AUTORICCUSTO2&#xa;            FROM AUTORIZCCUSTORESTRITO&#xa;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO            &#xa;            AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#xa;             AND AUTORIZCCUSTORESTRITO.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#xa;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO     = &apos;S&apos;;             &#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;             MENSAGEM_PADRAO(33731, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);  &#xa;            RAISE FORM_TRIGGER_FAILURE;              &#xa;        END;  &#xa;       END IF;    &#xa;    END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN               &#xa;  ELSE&#xa;    :ITEMCOMPRACCUSTO.NM_EMPRESADEST := NULL;&#xa;  END IF;    &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="BEGIN&#xa;  :ITEMCOMPRACCUSTO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#xa;  :ITEMCOMPRACCUSTO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#xa;  :ITEMCOMPRACCUSTO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#xa;  :ITEMCOMPRACCUSTO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#xa;  :ITEMCOMPRACCUSTO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="CD_CENTROCUSTO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="@">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="Centro Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="BEGIN&#xa;  :ITEMCOMPRACCUSTO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#xa;  :ITEMCOMPRACCUSTO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#xa;  :ITEMCOMPRACCUSTO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#xa;  :ITEMCOMPRACCUSTO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#xa;  :ITEMCOMPRACCUSTO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779083" FOLDED="true" MODIFIED="1607991779083" TEXT="body">
<node CREATED="1607991779083" MODIFIED="1607991779083" TEXT="/**FZA:15/02/2011:33648&#xa;*** Ajustado tratamento de erros, as validacoes estavam aparecendo mais de uma vez.&#xa;**/&#xa;DECLARE&#xa;  V_ST_VALIDACCUSTO  PARMCOMPRA.ST_VALIDACCUSTO%TYPE;&#xa;  V_CD_AUTORIZADOR   CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#xa;  V_CD_USUARIO       CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#xa;  V_ST_ATIVO         RESTRINGIRMOV.ST_ATIVO%TYPE;    &#xa;  V_CD_MOVIMENTACAO   NUMBER;&#xa;  E_GERAL             EXCEPTION;&#xa;  V_MENSAGEM         VARCHAR2(2000);&#xa;--  V_CD_EMPRESA       AUTORIZCCUSTORESTRITO.CD_EMPRESA%TYPE;&#xa;  V_CD_AUTORICCUSTO  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#xa;--  V_CD_AUTORICCUSTO3 AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#xa;  V_CD_AUTORICCUSTO2 AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#xa;--  V_CD_CENTROCUSTO   AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO%TYPE;&#xa;--  V_ST_REGISTRO      AUTORIZCCUSTORESTRITO.ST_REGISTRO%TYPE;&#xa;  &#xa;  &#xa;BEGIN&#xa;  IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#xa;    --FJC:05/07/2018:121701&#xa;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CC_USUARIO&apos;),&apos;N&apos;) = &apos;S&apos;  THEN    &#xa;       BEGIN&#xa;        SELECT CCUSTOAUTORIZ.CD_USUARIO&#xa;           INTO V_CD_USUARIO&#xa;           FROM CENTROCUSTO, CCUSTOAUTORIZ&#xa;          WHERE CENTROCUSTO.CD_CENTROCUSTO    = CCUSTOAUTORIZ.CD_CENTROCUSTO&#xa;            AND CCUSTOAUTORIZ.CD_USUARIO      = :GLOBAL.CD_USUARIO&#xa;            AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#xa;            AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#xa;            AND NVL(CENTROCUSTO.ST_CENTROCUSTO, &apos;A&apos;) = &apos;A&apos;;          &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN          &#xa;          --O Usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o est&#xe1; autorizado para o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCO003.&#xa;           MENSAGEM_PADRAO(3771,&apos;&#xa2;CD_USUARIO=&apos;||:GLOBAL.CD_USUARIO||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;           :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#xa;           :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#xa;           RAISE FORM_TRIGGER_FAILURE;&#xa;          WHEN TOO_MANY_ROWS THEN&#xa;           V_CD_USUARIO := NULL;&#xa;          WHEN OTHERS THEN&#xa;            --Ocorreu um erro inesperado na busca dos dados do usu&#xe1;rio autorizador. Erro: &#xa2;SQLERRM&#xa2;.&#xa;           MENSAGEM_PADRAO(3958,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;           RAISE FORM_TRIGGER_FAILURE;&#xa;      END;            &#xa;    END IF;&#xa;        &#xa;    DECLARE&#xa;      V_ST_CENTROCUSTO  CENTROCUSTO.ST_CENTROCUSTO%TYPE;&#xa;      E_GERAL EXCEPTION;&#xa;    BEGIN&#xa;        &#xa;      /**GRA:13783:27/12/2006&#xa;       * O PROCEDIMENTO ABAIXO VERIFICA SE O CENTRO DE&#xa;       * CUSTO EST&#xc1; CADASTRADO PARA A EMPRESA INFORMADA.&#xa;       */ &#xa;      PACK_VALIDA.VAL_CCUSTOEMPR(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#xa;                                 NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRACCUSTO.CD_EMPRESA),--GDG:22/07/2011:28715&#xa;                                  :GLOBAL.CD_MODULO,&#xa;                                  :GLOBAL.CD_PROGRAMA,&#xa;                                  :ITEMCOMPRACCUSTO.DS_CENTROCUSTO,&#xa;                                  V_MENSAGEM);                            &#xa;      IF V_MENSAGEM IS NOT NULL THEN  &#xa;         RAISE E_GERAL;&#xa;      END IF;&#xa;     /* CSL:22264:30/06/09 - As duas consultas foram substituidas por uma.*/&#xa;    /*SELECT CENTROCUSTO.ST_CENTROCUSTO&#xa;        INTO V_ST_CENTROCUSTO&#xa;        FROM CENTROCUSTO&#xa;       WHERE CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#xa;       &#xa;      SELECT CENTROCUSTO.DS_CENTROCUSTO ,CENTROCUSTO.ST_CENTROCUSTO&#xa;        INTO :ITEMCOMPRACCUSTO.DS_CENTROCUSTO,V_ST_CENTROCUSTO&#xa;        FROM CENTROCUSTO&#xa;       WHERE CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;*/&#xa;    &#xa;      SELECT ST_CENTROCUSTO, DS_CENTROCUSTO&#xa;        INTO V_ST_CENTROCUSTO, :ITEMCOMPRACCUSTO.DS_CENTROCUSTO &#xa;        FROM CENTROCUSTO&#xa;       WHERE CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#xa;       IF NVL(V_ST_CENTROCUSTO,&apos;A&apos;) = &apos;I&apos; THEN&#xa;           --O centro de custo &#xa2;CD_CENTROCUSTO&#xa2; encontra-se inativo e n&#xe3;o pode ser usado. Verifique TCB007.&#xa;           V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1509,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;           :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#xa;           RAISE E_GERAL;&#xa;       END IF;&#xa;     &#xa;    EXCEPTION&#xa;      WHEN E_GERAL THEN&#xa;        MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#xa;        RAISE FORM_TRIGGER_FAILURE;     &#xa;      WHEN NO_DATA_FOUND THEN&#xa;        --O Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o programa TCB007.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(254,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#xa;        :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#xa;        MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;        RAISE FORM_TRIGGER_FAILURE;     &#xa;      WHEN OTHERS THEN&#xa;        --Ocorreu um erro inesperado ao consultar os dados do centro de custo &#xa2;CD_CENTROCUSTO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(999,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;SQLERREM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;        RAISE FORM_TRIGGER_FAILURE;     &#xa;    END;&#xa; &#xa; -----------------------------------------------------------------------------------------------------------------&#xa; --VALIDA CENTRO DE CUSTO&#xa; -----------------------------------------------------------------------------------------------------------------&#xa;   IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN&#xa;    DECLARE&#xa;      E_GERAL  EXCEPTION;&#xa;    BEGIN       &#xa;      SELECT NVL(ST_VALIDACCUSTO,&apos;N&apos;)&#xa;        INTO V_ST_VALIDACCUSTO&#xa;        FROM PARMCOMPRA&#xa;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA;&#xa;        /* CSL:22264:30/06/09 - COMPARA&#xc7;&#xc3;O INADEQUADA */&#xa;        --IF V_ST_VALIDACCUSTO = &apos;S&apos; THEN&#xa;        IF V_ST_VALIDACCUSTO = &apos;C&apos; THEN        &#xa;         BEGIN&#xa;          SELECT CCUSTOAUTORIZ.CD_USUARIO&#xa;             INTO V_CD_AUTORIZADOR&#xa;             FROM CCUSTOAUTORIZ&#xa;            WHERE CCUSTOAUTORIZ.CD_USUARIO      = :CONTROLE.CD_AUTORIZADOR&#xa;              AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)--GDG:22/07/2011:28715&#xa;              AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#xa;             AND CCUSTOAUTORIZ.TP_AUTORIZADOR  IN (&apos;A&apos;,&apos;S&apos;,&apos;T&apos;);          &#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            --O Usu&#xe1;rio &#xa2;CD_USUARIO&#xa2; n&#xe3;o est&#xe1; autorizado para o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCO003.&#xa;             V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3771,&apos;&#xa2;CD_USUARIO=&apos;||:CONTROLE.CD_AUTORIZADOR ||&apos; - &apos;||:CONTROLE.NM_USUAUTORIZ||&#xa;                                                          &apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;             :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#xa;             :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#xa;             RAISE E_GERAL;&#xa;            WHEN TOO_MANY_ROWS THEN&#xa;            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#xa;            :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#xa;            WHEN OTHERS THEN&#xa;              --Ocorreu um erro inesperado na busca dos dados do usu&#xe1;rio autorizador. Erro: &#xa2;SQLERRM&#xa2;.&#xa;             V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3958,&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;             RAISE E_GERAL;&#xa;        END;&#xa;        END IF;&#xa; &#xa;       IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947             &#xa;           BEGIN  &#xa;             SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                                        &#xa;              INTO V_CD_AUTORICCUSTO&#xa;              FROM AUTORIZCCUSTORESTRITO&#xa;             WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO               &#xa;                AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#xa;               AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = &apos;S&apos;;               &#xa;           EXCEPTION &#xa;             WHEN OTHERS THEN&#xa;               V_CD_AUTORICCUSTO := NULL;                                     &#xa;           END;&#xa;                                        &#xa;        IF V_CD_AUTORICCUSTO IS NOT NULL THEN           &#xa;          IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN                                             &#xa;          /*O autorizador da tela principal deve ser informado.*/&#xa;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33735, NULL);&#xa;            RAISE E_GERAL;               &#xa;          END IF;&#xa;          &#xa;          BEGIN           &#xa;             SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#xa;               INTO V_CD_AUTORICCUSTO2&#xa;              FROM AUTORIZCCUSTORESTRITO&#xa;             WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO            &#xa;              AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#xa;               AND AUTORIZCCUSTORESTRITO.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#xa;               AND AUTORIZCCUSTORESTRITO.ST_REGISTRO     = &apos;S&apos;;               &#xa;           EXCEPTION&#xa;             WHEN NO_DATA_FOUND THEN                              &#xa;               V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, &apos;&#xa2;CD_AUTORIZADOR=&apos;||:CONTROLE.CD_AUTORIZADOR||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);  &#xa;              RAISE E_GERAL;              &#xa;           END;  &#xa;         END IF;    &#xa;       END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN     &#xa;    EXCEPTION      &#xa;      WHEN E_GERAL THEN&#xa;        MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;        RAISE FORM_TRIGGER_FAILURE;     &#xa;       WHEN NO_DATA_FOUND THEN &#xa;         NULL;  &#xa;       /* CSL:22264:30/06/09&#xa;       * Tratamentos de exce&#xe7;&#xe3;o &#xa;       */&#xa;       WHEN TOO_MANY_ROWS THEN&#xa;        MENSAGEM(&apos;Maxys&apos;,&apos;A consulta retornou mais de uma empresa para esta condi&#xe7;&#xe3;o.&apos;,1);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;      WHEN OTHERS THEN&#xa;        MENSAGEM(&apos;Maxys&apos;,&apos;Erro inesperado: &apos;||SQLERRM,1);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;    END;  &#xa;   END IF; --IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN  &#xa;   &#xa;    /**CSL:21/12/2010:30317&#xa;     * Adicionado campo cd_negocio para permitir ou n&#xe3;o que o usu&#xe1;rio altere o neg&#xf3;cio para o qual &#xa;     * vai ser destinado o valor do centro de custo, de acordo com o status do parametro ST_NEGOCIOCCUSTO (N - Negado, S - Permitido) do CTI010.&#xa;     */  &#xa;      &#xa;    IF(  NVL(:ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO,0) = 0) AND NVL(:ITEMCOMPRACCUSTO.ST_NEGOCIOPLANILHA,&apos;N&apos;)  = &apos;N&apos; THEN &#xa;      BEGIN&#xa;        SELECT CENTROCUSTO.CD_NEGOCIO,&#xa;               NEGOCIO.DS_NEGOCIO&#xa;          INTO :ITEMCOMPRACCUSTO.CD_NEGOCIO,&#xa;               :ITEMCOMPRACCUSTO.DS_NEGOCIO&#xa;          FROM CENTROCUSTO, NEGOCIO&#xa;         WHERE CENTROCUSTO.CD_NEGOCIO     = NEGOCIO.CD_NEGOCIO&#xa;           AND CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;      &#xa;        IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;CTI&apos;,10,&apos;MAX&apos;,100,&apos;ST_NEGOCIOCCUSTO&apos;),&apos;N&apos;) = &apos;N&apos; THEN&#xa;          SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,ENABLED,PROPERTY_FALSE);&#xa;          SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOEXIBICAO&apos;);  &#xa;        ELSE&#xa;          SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,ENABLED,PROPERTY_TRUE);&#xa;          SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;,VISUAL_ATTRIBUTE,&apos;VSA_CAMPOTEXTO&apos;);  &#xa;        END IF;&#xa;      &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          MENSAGEM_PADRAO(5243,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);--Nenhum neg&#xf3;cio associado ao centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCB007.&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;        WHEN TOO_MANY_ROWS THEN&#xa;          MENSAGEM_PADRAO(6306,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);--Existe mais de um neg&#xf3;cio associado ao centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCB007.&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;        WHEN OTHERS THEN&#xa;          MENSAGEM_PADRAO(6307,&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);--Ocorreu um erro inesperado ao tentar localizar o c&#xf3;digo de neg&#xf3;cio associado ao Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;          RAISE FORM_TRIGGER_FAILURE;&#xa;      END;&#xa;   END IF;&#xa;   &#xa;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#xa;      VALIDA_CONTA_ORCAMENTO(&apos;ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;    END IF;&#xa;  &#xa;  ELSE &#xa;    :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#xa;  END IF;&#xa;&#xa;-----------------------------------------------------------------------------------------------------------------&#xa;--VALIDA SE A MOVIMENTA&#xc7;&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O PARA O CENTRO DE CUSTO (TCB053)&#xa;--AUG:122414:24/05/2018&#xa;-----------------------------------------------------------------------------------------------------------------      &#xa;  BEGIN&#xa;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NOT NULL AND&#xa;       :ITEMCOMPRACCUSTO.CD_CENTROCUSTO  IS NOT NULL THEN&#xa;    &#xa;      /*RETORNO: S = POSSUI RESTRI&#xc7;&#xc3;O&#xa;       *          N = N&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#xa;       */&#xa;        &#xa;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#xa;                                                      :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;                                                                                                           &#xa;      IF NVL(V_ST_ATIVO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;        V_CD_MOVIMENTACAO := :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO;&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    END IF;  &#xa;      &#xa;    IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO  IS NOT NULL AND&#xa;       :ITEMCOMPRA.CD_MOVIMENTACAO       IS NOT NULL THEN&#xa;         &#xa;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRA.CD_MOVIMENTACAO,&#xa;                                                      :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;                                                                            &#xa;      IF NVL(V_ST_ATIVO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;        V_CD_MOVIMENTACAO  := :ITEMCOMPRA.CD_MOVIMENTACAO;&#xa;         RAISE E_GERAL;&#xa;      END IF;&#xa;    END IF;    &#xa;  EXCEPTION&#xa;    WHEN E_GERAL THEN&#xa;      --A movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; possui restri&#xe7;&#xe3;o para o centro de custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique o programa TCB053.&#xa;      MENSAGEM_PADRAO(31068, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||V_CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;      :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#xa;      :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;  END;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="--RYT:06/06/2012:45340&#xa;DECLARE&#xa;  V_ST_VALIDAUTCCUSTOCOM001 VARCHAR2(1);&#xa;BEGIN&#xa;    &#xa;    V_ST_VALIDAUTCCUSTOCOM001 := NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,&#xa;                                                                     9,&#xa;                                                                     :GLOBAL.CD_USUARIO,&#xa;                                                                     NVL(:CONTROLE.CD_EMPRESA, :GLOBAL.CD_EMPRESA),&#xa;                                                                     &apos;ST_VALIDAUTCCUSTOCOM001&apos;),&apos;N&apos;);  &#xa;                                                                 &#xa;    -- VALIDA&#xc7;&#xd5;ES    &#xa;    IF V_ST_VALIDAUTCCUSTOCOM001 = &apos;A&apos; THEN&#xa;      IF :ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL OR (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR &lt;&gt; :CONTROLE.CD_AUTORIZADOR) THEN&#xa;        SET_ALERT_PROPERTY(&apos;MENSAGEM_MUDAR&apos;,ALERT_MESSAGE_TEXT,&apos;Pressione (Continuar) para incluir manualmente o Autorizador. Para mudar o Autorizador para o mesmo da Compra pressione (Mudar).&apos;);&#xa;        IF NOT SHOW_ALERT(&apos;MENSAGEM_MUDAR&apos;) = 88 THEN&#xa;          :ITEMCOMPRACCUSTO.CD_AUTORIZADOR := :CONTROLE.CD_AUTORIZADOR;&#xa;          &#xa;          IF PACK_GLOBAL.ST_APROVSOLIC = &apos;S&apos; AND NVL (PACK_GLOBAL.ST_VALIDACCUSTO,&apos;N&apos;) IN (&apos;C&apos;,&apos;A&apos;) &#xa;            AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN&#xa;            :ITEMCOMPRACCUSTO.CD_EMPRESAUTORIZ := :ITEMCOMPRA.CD_EMPRESA;&#xa;            /**GRA:09/03/2007:15399&#xa;             * Inclusa a valida&#xe7;&#xe3;o para n&#xe3;o deixar passar&#xa;             * se n&#xe3;o autorizador para o centro de custo informado.&#xa;             */&#xa;            IF (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN&#xa;              IF (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL) THEN  &#xa;                NULL;&#xa;                --MENSAGEM(&apos;Maxys&apos;, &apos;O autorizador do centro de custo deve ser informado&apos;,2);&#xa;              ELSE&#xa;                BEGIN&#xa;                  SELECT CCUSTOAUTORIZ.CD_USUARIO,USUARIO.NM_USUARIO&#xa;                    INTO :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,:ITEMCOMPRACCUSTO.NM_AUTORIZADOR&#xa;                    FROM CCUSTOAUTORIZ,USUARIO&#xa;                   WHERE USUARIO.CD_USUARIO            = CCUSTOAUTORIZ.CD_USUARIO&#xa;                     AND USUARIO.CD_USUARIO            = :ITEMCOMPRACCUSTO.CD_AUTORIZADOR&#xa;                     AND CCUSTOAUTORIZ.CD_EMPRESA      = :ITEMCOMPRACCUSTO.CD_EMPRESA&#xa;                     AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#xa;                     AND CCUSTOAUTORIZ.TP_AUTORIZADOR IN (&apos;A&apos;,&apos;T&apos;);      &#xa;                EXCEPTION&#xa;                  WHEN NO_DATA_FOUND THEN&#xa;                    --O Usu&#xe1;rio/Autorizador &#xa2;CD_USUARIO&#xa2; n&#xe3;o est&#xe1; autorizado para o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCO003.&#xa;                    MENSAGEM_PADRAO(3771,&apos;&#xa2;CD_USUARIO=&apos;||:ITEMCOMPRACCUSTO.CD_AUTORIZADOR||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;                     :ITEMCOMPRACCUSTO.CD_AUTORIZADOR := NULL;&#xa;                     :ITEMCOMPRACCUSTO.NM_AUTORIZADOR := NULL;&#xa;                     RAISE FORM_TRIGGER_FAILURE;&#xa;                  WHEN TOO_MANY_ROWS THEN&#xa;                    IF SHOW_LOV(&apos;LOV_AUTORIZADOR&apos;) THEN&#xa;                      NULL;&#xa;                    END IF;&#xa;                  WHEN OTHERS THEN&#xa;                    MENSAGEM(&apos;Maxys&apos;,SQLERRM,1);&#xa;                    RAISE FORM_TRIGGER_FAILURE;&#xa;                END;&#xa;              END IF;&#xa;            END IF;&#xa;          END IF;&#xa;        &#xa;        END IF;  &#xa;      END IF;&#xa;    END IF;&#xa;      GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_NEGOCIO&apos;);                                                                      &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN  &#xa;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_CC_USUARIO&apos;),&apos;N&apos;) = &apos;S&apos; THEN&#xa;    &#xa;    IF NOT SHOW_LOV(&apos;LOV_CENTROCUSTOUSUARIO&apos;) THEN&#xa;      NULL;&#xa;    END IF;&#xa;  ELSIF SHOW_LOV(&apos;LOV_CENTROCUSTO&apos;) THEN&#xa;    &#xa;    NULL;&#xa;  END IF;&#xa;  &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="DS_CENTROCUSTO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Descri&#xe7;&#xe3;o do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="CD_NEGOCIO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Neg&#xf3;cio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="LOV_NEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="/**CSL:21/12/2010:30317*/&#xa;BEGIN&#xa;  IF :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN  &#xa;    SELECT DS_NEGOCIO&#xa;      INTO :ITEMCOMPRACCUSTO.DS_NEGOCIO&#xa;      FROM NEGOCIO&#xa;     WHERE NEGOCIO.CD_NEGOCIO = :ITEMCOMPRACCUSTO.CD_NEGOCIO;     &#xa;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#xa;      VALIDA_CONTA_ORCAMENTO(&apos;ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRA.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;    END IF; &#xa;  ELSE&#xa;    :ITEMCOMPRACCUSTO.DS_NEGOCIO := NULL;&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    MENSAGEM_PADRAO(147,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRACCUSTO.CD_NEGOCIO||&apos;&#xa2;&apos;);--O Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o programa TCB001.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN TOO_MANY_ROWS THEN&#xa;    MENSAGEM_PADRAO(148,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRACCUSTO.CD_NEGOCIO||&apos;&#xa2;&apos;);--O Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; est&#xe1; cadastrado v&#xe1;rias vezes. Verifique o programa TCB001.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM_PADRAO(149,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRACCUSTO.CD_NEGOCIO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);--Ocorreu um erro inesperado ao consultar os dados do c&#xf3;digo de Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="DS_NEGOCIO: Char(60)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Neg&#xf3;cio">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="C&#xf3;d. Mov.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="LOV_PARMOVIMENT">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="DECLARE&#xa;  V_TP_PEDIDO    PARMOVIMENT.TP_PEDIDO%TYPE; --PHS:60051:11/07/2013&#xa;  I_CD_NATUREZA  PLANOCONTABIL.CD_NATUREZA%TYPE;&#xa;  I_MENSAGEM     VARCHAR2(32000);&#xa;  I_RETORNO       VARCHAR2(01);&#xa;  V_ST_ATIVO     RESTRINGIRMOV.ST_ATIVO%TYPE;&#xa;  E_GERAL        EXCEPTION;&#xa;BEGIN&#xa;&#xa;  IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NOT NULL THEN&#xa;      IF PACK_GLOBAL.TP_SELECAOCONTA = &apos;O&apos; THEN&#xa;        /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padr&#xe3;o da fun&#xe7;&#xe3;o VALIDA_SELECAOCONTA quando for &apos;CO&apos;*/&#xa;        I_MENSAGEM := VALIDA_SELECAOCONTA (NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:CONTROLE.CD_EMPRESA),&#xa;                                           :ITEMCOMPRACCUSTO.CD_ITEM,&#xa;                                           :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, &#xa;                                           NULL, &apos;CO&apos;);    &#xa;        IF (I_MENSAGEM IS NOT NULL) AND (I_MENSAGEM &lt;&gt; &apos;S&apos;) THEN&#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;      END IF;&#xa;      &#xa;      /* CSL:02/12/2013:64869&#xa;       * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO para n&#xe3;o permitir realizar lan&#xe7;amentos em contas, &#xa;       * que n&#xe3;o pertencem a vers&#xe3;o do plano de contas da empresa do lan&#xe7;amento.&#xa;       */&#xa;      PACK_VALIDA.VALIDA_CONTABIL_PLANO(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:GLOBAL.CD_EMPRESA), I_MENSAGEM);&#xa;    &#xa;      IF I_MENSAGEM IS NOT NULL THEN&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;      BEGIN&#xa;        /*CSL:30/12/2013:64869*/&#xa;        IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;                 PLANOCONTABIL.CD_NATUREZA,&#xa;                 PARMOVIMENT.TP_PEDIDO&#xa;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#xa;                 I_CD_NATUREZA,&#xa;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#xa;            FROM PARMOVIMENT,HISTCONTB,PLANOCONTABIL&#xa;           WHERE PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO&#xa;             AND HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#xa;             AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#xa;             AND PLANOCONTABIL.TP_CONTACONTABIL = &apos;CC&apos;;&#xa;        &#xa;        ELSE&#xa;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;                 PLANOCONTABILVERSAO.CD_NATUREZA,&#xa;                 PARMOVIMENT.TP_PEDIDO&#xa;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#xa;                 I_CD_NATUREZA,&#xa;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#xa;            FROM PARMOVIMENT, HISTCONTB, PLANOCONTABILVERSAO&#xa;           WHERE PARMOVIMENT.CD_MOVIMENTACAO           = :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO&#xa;             AND HISTCONTB.CD_HISTCONTB                = PARMOVIMENT.CD_HISTCONTB&#xa;             AND PLANOCONTABILVERSAO.CD_CONTACONTABIL  = HISTCONTB.CD_CONTACONTABIL&#xa;             AND PLANOCONTABILVERSAO.TP_CONTACONTABIL  = &apos;CC&apos;&#xa;             AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#xa;                 PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));  &#xa;        END IF;&#xa;        &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          --Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; n&#xe3;o cadastrada, n&#xe3;o &#xe9; de compra ou n&#xe3;o &#xe9; de Centro de Custo. Verifique TCB008.&#xa;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3775,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;      END;&#xa;    &#xa;      --PHS:60051:11/07/2013&#xa;      IF V_TP_PEDIDO &lt;&gt; PACK_GLOBAL.TP_PEDIDO THEN&#xa;        --A movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; possui o tipo de pedido &#xa2;TP_PEDIDO&#xa2; diferente do tipo de pedido &#xa2;TP_CADPEDIDO&#xa2; cadastrado para o programa. Verificar os programas TCB008 e ANV008.&#xa;        MENSAGEM_PADRAO(20737,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||&apos;&#xa2;TP_PEDIDO=&apos;||V_TP_PEDIDO||&apos;&#xa2;TP_CADPEDIDO=&apos;||PACK_GLOBAL.TP_PEDIDO||&apos;&#xa2;&apos;); &#xa;      END IF;  &#xa;    &#xa;      /*CLM:22/08/2014:76468 &#xa;      IF NATUREZA_CENTROCUSTO(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO) &lt;&gt; I_CD_NATUREZA THEN&#xa;        --A Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; n&#xe3;o &#xe9; compat&#xed;vel com o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCB008.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3776,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;*/&#xa;      &#xa;      I_RETORNO := RETORNA_NATUREZA (:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO,:GLOBAL.CD_EMPRESA); /*CSL:03/10/2013:62738*/&#xa;      IF I_RETORNO = &apos;I&apos; THEN&#xa;        --A natureza do Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2; &#xe9; incompat&#xed;vel com a natureza da Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2;. Verifique TCB007 e TCB008.&#xa;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20318, &apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;    &#xa;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#xa;      VALIDA_CONTA_ORCAMENTO(&apos;ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRA.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;    END IF;&#xa;          &#xa;  ELSE&#xa;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#xa;  END IF;&#xa;-----------------------------------------------------------------------------------------------------------------&#xa;--VALIDA SE A MOVIMENTA&#xc7;&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O PARA O CENTRO DE CUSTO (TCB053)&#xa;--AUG:122414:24/05/2018&#xa;-----------------------------------------------------------------------------------------------------------------      &#xa;      IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#xa;      &#xa;       /*RETORNO: S = POSSUI RESTRI&#xc7;&#xc3;O&#xa;        *          N = N&#xc3;O POSSUI RESTRI&#xc7;&#xc3;O CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#xa;        */&#xa;        &#xa;        V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#xa;                                                            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#xa;        IF NVL(V_ST_ATIVO,&apos;N&apos;) = &apos;S&apos; THEN&#xa;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, &apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||&apos;&#xa2;CD_CENTROCUSTO=&apos;|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;      END IF;                      &#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#xa;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#xa;    MENSAGEM(&apos;Maxys&apos;,I_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#xa;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN&#xa;  /*CSL:30/12/2013:64869*/&#xa;  IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN &#xa;    &#xa;    SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENT&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENT1&apos;);   &#xa;     &#xa;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;X&apos;) IN (&apos;O&apos;,&apos;S&apos;) &#xa;        AND SHOW_LOV(&apos;LOV_PARMOVIMENT&apos;) THEN&#xa;      NULL; &#xa;    ELSE&#xa;       SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENT&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENT&apos;);&#xa;       &#xa;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;S&apos;)= &apos;S&apos; &#xa;          AND SHOW_LOV(&apos;LOV_PARMOVIMENT&apos;) THEN&#xa;           NULL;&#xa;      END IF;&#xa;    END IF;&#xa;&#xa;  ELSE--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;    SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENTVERSAO&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENT1VERSAO&apos;);  &#xa;    &#xa;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;X&apos;) IN (&apos;O&apos;,&apos;S&apos;) &#xa;        AND SHOW_LOV(&apos;LOV_PARMOVIMENTVERSAO&apos;) THEN&#xa;      NULL; &#xa;    ELSE&#xa;       SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENTVERSAO&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENTVERSAO&apos;);&#xa;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;S&apos;)= &apos;S&apos; &#xa;          AND SHOW_LOV(&apos;LOV_PARMOVIMENTVERSAO&apos;) THEN&#xa;           NULL;&#xa;      END IF;&#xa;    END IF;&#xa;  END IF;--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN&#xa;  IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL THEN&#xa;    :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := :ITEMCOMPRA.CD_MOVIMENTACAO;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="DS_MOVIMENTACAO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Descri&#xe7;&#xe3;o da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="LOV_AUTORIZADOR">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="&#xa;BEGIN&#xa;    IF PACK_GLOBAL.ST_APROVSOLIC = &apos;S&apos; AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN&#xa;      IF (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL) AND (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL)&#xa;        AND (:ITEMCOMPRA.CD_AUTORIZADOR IS NOT NULL) THEN&#xa;        SELECT CCUSTOAUTORIZ.CD_USUARIO,USUARIO.NM_USUARIO&#xa;          INTO :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,:ITEMCOMPRACCUSTO.NM_AUTORIZADOR&#xa;          FROM CCUSTOAUTORIZ,USUARIO&#xa;         WHERE USUARIO.CD_USUARIO            = CCUSTOAUTORIZ.CD_USUARIO&#xa;           AND USUARIO.CD_USUARIO            = :ITEMCOMPRA.CD_AUTORIZADOR&#xa;           AND CCUSTOAUTORIZ.CD_EMPRESA      = :ITEMCOMPRACCUSTO.CD_EMPRESA&#xa;           AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#xa;           AND CCUSTOAUTORIZ.TP_AUTORIZADOR IN (&apos;A&apos;,&apos;T&apos;);&#xa;      END IF;    &#xa;    END IF;              &#xa;  EXCEPTION&#xa;    WHEN NO_DATA_FOUND THEN&#xa;      NULL;&#xa;    WHEN TOO_MANY_ROWS THEN&#xa;      IF SHOW_LOV(&apos;LOV_AUTORIZADOR&apos;) THEN&#xa;        NULL;&#xa;      END IF;&#xa;  END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="/*DECLARE  &#xa;  --I_MENSAGEM  VARCHAR2(2000);&#xa;  --E_GERAL     EXCEPTION;*/&#xa;--DECLARE &#xa;--  V_MENSAGEM VARCHAR2(32000);&#xa;--  V_CD_AUTORICCUSTO ITEMCOMPRACCUSTO.CD_AUTORIZADOR%TYPE;  &#xa;BEGIN&#xa;&#xa;  /**RSS:21/12/2007:17745&#xa;   * FOI ALTERADA A O IF DA VALIDA&#xc7;&#xc3;O, POIS A MANEIRA QUE ESTAVA NAO ATENDIA A VALIDA&#xc7;&#xc3;O &#xa;   * NA QUAL FOI REQUISITADA, OU SEJA, NAO ACONTECIA A VALIDA&#xc7;&#xc3;O QUANDO ERA NECESS&#xc1;RIA.&#xa;   */&#xa;  :ITEMCOMPRACCUSTO.CD_SOLICITANTE   := :GLOBAL.CD_USUARIO;&#xa;  :ITEMCOMPRACCUSTO.CD_EMPRESA       := :ITEMCOMPRA.CD_EMPRESA;&#xa;  :ITEMCOMPRACCUSTO.CD_EMPRESASOLIC  := :ITEMCOMPRA.CD_EMPRESA;&#xa;  &#xa;  IF PACK_GLOBAL.ST_APROVSOLIC = &apos;S&apos; AND NVL (PACK_GLOBAL.ST_VALIDACCUSTO,&apos;N&apos;) IN (&apos;C&apos;,&apos;A&apos;) &#xa;    AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN&#xa;    :ITEMCOMPRACCUSTO.CD_EMPRESAUTORIZ := :ITEMCOMPRA.CD_EMPRESA;&#xa;  /**GRA:09/03/2007:15399&#xa;   * Inclusa a valida&#xe7;&#xe3;o para n&#xe3;o deixar passar&#xa;   * se n&#xe3;o autorizador para o centro de custo informado.&#xa;   */&#xa;    IF (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN&#xa;      IF (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL) THEN  &#xa;        NULL;&#xa;        --MENSAGEM(&apos;Maxys&apos;, &apos;O autorizador do centro de custo deve ser informado&apos;,2);&#xa;      ELSE&#xa;        BEGIN&#xa;          SELECT CCUSTOAUTORIZ.CD_USUARIO,USUARIO.NM_USUARIO&#xa;            INTO :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,:ITEMCOMPRACCUSTO.NM_AUTORIZADOR&#xa;            FROM CCUSTOAUTORIZ,USUARIO&#xa;           WHERE USUARIO.CD_USUARIO            = CCUSTOAUTORIZ.CD_USUARIO&#xa;             AND USUARIO.CD_USUARIO            = :ITEMCOMPRACCUSTO.CD_AUTORIZADOR&#xa;             AND CCUSTOAUTORIZ.CD_EMPRESA      = :ITEMCOMPRACCUSTO.CD_EMPRESA&#xa;             AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#xa;             AND CCUSTOAUTORIZ.TP_AUTORIZADOR IN (&apos;A&apos;,&apos;T&apos;);      &#xa;        EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            --O Usu&#xe1;rio/Autorizador &#xa2;CD_USUARIO&#xa2; n&#xe3;o est&#xe1; autorizado para o Centro de Custo &#xa2;CD_CENTROCUSTO&#xa2;. Verifique TCO003.&#xa;            MENSAGEM_PADRAO(3771,&apos;&#xa2;CD_USUARIO=&apos;||:ITEMCOMPRACCUSTO.CD_AUTORIZADOR||&apos;&#xa2;CD_CENTROCUSTO=&apos;||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||&apos;&#xa2;&apos;);&#xa;             :ITEMCOMPRACCUSTO.CD_AUTORIZADOR := NULL;&#xa;             :ITEMCOMPRACCUSTO.NM_AUTORIZADOR := NULL;&#xa;             RAISE FORM_TRIGGER_FAILURE;&#xa;          WHEN TOO_MANY_ROWS THEN&#xa;            IF SHOW_LOV(&apos;LOV_AUTORIZADOR&apos;) THEN&#xa;              NULL;&#xa;            END IF;&#xa;          WHEN OTHERS THEN&#xa;            MENSAGEM(&apos;Maxys&apos;,SQLERRM,1);&#xa;            RAISE FORM_TRIGGER_FAILURE;&#xa;        END;&#xa;      END IF;&#xa;  END IF;&#xa;  &#xa;END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN&#xa;   IF PACK_GLOBAL.TP_ITEM = &apos;S&apos; THEN&#xa;      --:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL:=0;&#xa;      SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;, ENABLED, PROPERTY_TRUE);      &#xa;      SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;, NAVIGABLE, PROPERTY_TRUE);&#xa;      GO_ITEM(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;);    &#xa;   ELSE&#xa;      NEXT_ITEM;&#xa;   END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="NM_AUTORIZADOR: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="NM_EMPRESADEST: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="QT_PEDIDAUNIDSOL: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN&#xa;  IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL THEN       &#xa;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL  THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);  &#xa;       --A movimenta&#xe7;&#xe3;o deve ser informada.&#xa;       MENSAGEM_PADRAO(298,&apos;&apos;);&#xa;       GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_MOVIMENTACAO&apos;);&#xa;    ELSIF:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL THEN&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;        --O centro de custo deve ser informado.&#xa;        MENSAGEM_PADRAO(292,&apos;&apos;);&#xa;        GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_CENTROCUSTO&apos;);&#xa;    ELSE   &#xa;      IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL &lt; 0 THEN--AUG:126984:29/10/2018&#xa;        --O Peso ou Quantidade do item do pedido n&#xe3;o pode ser negativo.&#xa;        MENSAGEM_PADRAO(3282, NULL);&#xa;        RAISE FORM_TRIGGER_FAILURE;&#xa;      END IF;&#xa;    &#xa;      IF (:CONTROLE.LST_AUTOSUGESTAO = 2) THEN&#xa;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#xa;          SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;          SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;           GO_ITEM(&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;);&#xa;        ELSE &#xa;          IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;            SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_FALSE);&#xa;           END IF;&#xa;             NEXT_RECORD;&#xa;             GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_CENTROCUSTO&apos;);&#xa;        END IF;&#xa;      ELSE&#xa;        NEXT_ITEM;&#xa;      END IF;&#xa;    END IF;&#xa;  ELSE&#xa;    NEXT_ITEM;      &#xa;  END IF;     &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN   &#xa;  &#xa;  IF :SYSTEM.CURSOR_ITEM = &apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;  AND :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM THEN&#xa;    &#xa;    &#xa;    DECLARE&#xa;      V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE;&#xa;    BEGIN &#xa;      SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#xa;        INTO V_ST_UNIDMEDIDA&#xa;        FROM ITEM, UNIDMEDIDA&#xa;       WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#xa;         AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;          &#xa;      IF ( V_ST_UNIDMEDIDA = &apos;U&apos; AND (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) ) THEN&#xa;         :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL);&#xa;      END IF;         &#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        NULL;&#xa;    END;&#xa;    IF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL &lt;&gt; 0) THEN&#xa;      :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * (100 / ZVL(:ITEMCOMPRACCUSTO.QT_PREVISTA, 1));&#xa;    END IF;&#xa;    &#xa;    IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL,2) &gt; ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA,2)THEN&#xa;      :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL - (ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL,2) - ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA,2));&#xa;    END IF;&#xa;    &#xa;    IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL &lt; 0 THEN--AUG:126984:29/10/2018&#xa;      --O Peso ou Quantidade do item do pedido n&#xe3;o pode ser negativo.&#xa;      MENSAGEM_PADRAO(3282, NULL);&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;    &#xa;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (2,3)) THEN&#xa;      IF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NULL) THEN&#xa;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * 100 /&#xa;                                                   :ITEMCOMPRACCUSTO.QT_PREVISTA,3);&#xa;                                                &#xa;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#xa;           SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;           SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;        ELSE &#xa;          IF (GET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED) = &apos;TRUE&apos;) THEN&#xa;            SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_FALSE);&#xa;          END IF;&#xa;        END IF;        &#xa;        &#xa;        /* DCS:19/12/2013:67379 &#xa;         * faz o arredondamento no &#xfa;ltimo percentual, com base na autosugest&#xe3;o do percentual apos digitar a &#xfa;ltima quantidade d&#xa;         * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#xa;         */&#xa;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) AND&#xa;           NVL(:ITEMCOMPRACCUSTO.PC_TOTAL,0) &gt; 100 THEN&#xa;          :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.PC_PARTICIPACAO - (:ITEMCOMPRACCUSTO.PC_TOTAL - 100);&#xa;        END IF;&#xa;        &#xa;      ELSIF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NOT NULL) THEN&#xa;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * 100 /&#xa;                                                   :ITEMCOMPRACCUSTO.QT_PREVISTA,3);&#xa;        &#xa;        /* DCS:19/12/2013:67379 &#xa;         * faz o arredondamento no &#xfa;ltimo percentual, com base na autosugest&#xe3;o do percentual apos digitar a &#xfa;ltima quantidade do&#xa;         * centro de custo e quando o percentual total sumarizar mais de 100 %.&#xa;         */&#xa;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) AND&#xa;           NVL(:ITEMCOMPRACCUSTO.PC_TOTAL,0) &gt; 100 THEN&#xa;          :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.PC_PARTICIPACAO - (:ITEMCOMPRACCUSTO.PC_TOTAL - 100);&#xa;        END IF;        &#xa;        &#xa;      ELSIF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL) THEN&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_TRUE);&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;      END IF;&#xa;    END IF;&#xa;  END IF;&#xa;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN&#xa;   IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) &lt; ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;   ELSIF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) &gt; ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#xa;       --A soma dos valores lan&#xe7;ados em Centro de Custo &#xa2;VL_CCUSTO&#xa2; para o item &#xa2;CD_ITEM&#xa2; deve corresponder ao valor lan&#xe7;ados no pedido &#xa2;VL_TOTITEM&#xa2;.&#xa;      MENSAGEM_PADRAO(4526,&apos;&#xa2;VL_CCUSTO=&apos; ||ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL)||&#xa;                           &apos;&#xa2;CD_ITEM=&apos;   ||:ITEMCOMPRACCUSTO.CD_ITEM||&#xa;                           &apos;&#xa2;VL_TOTITEM=&apos;||ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA)||&apos;&#xa2;&apos;);&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;   ELSIF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;   END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN  &#xa;  IF (ERROR_TYPE = &apos;FRM&apos;) AND (ERROR_CODE = 40209) THEN&#xa;    MENSAGEM(&apos;&apos;,&apos;Os caracteres v&#xe1;lidos s&#xe3;o 0-9 - e +.&apos;,4);&#xa;  ELSE&#xa;    VALIDA_ERROS;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="PC_PARTICIPACAO: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="% Partic.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Percentual de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Percentual de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="DECLARE&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  E_GERAL      EXCEPTION;&#xa;  E_SAIDA      EXCEPTION;&#xa;BEGIN&#xa;  IF :SYSTEM.CURSOR_ITEM = &apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos; AND (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NOT NULL) THEN&#xa;    IF (NVL(:ITEMCOMPRACCUSTO.PC_PARTICIPACAO,0) &lt;= 0) THEN&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20921, NULL);&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;    &#xa;    /* ASF:19/02/2020:140506&#xa;     * Se estiver selecionado a op&#xe7;&#xe3;o &quot;Considerar apenas %&quot; no drop down &quot;Op&#xe7;&#xf5;es de auto-sugest&#xe3;o&quot;&#xa;     * nenhuma valida&#xe7;&#xe3;o, ou inser&#xe7;&#xe3;o de valor ser&#xe1; feita para a Quantidade do rateio do Centro de Custo&#xa;     */&#xa;    IF (:CONTROLE.LST_AUTOSUGESTAO = 5) THEN&#xa;      RAISE E_SAIDA;&#xa;    END IF;&#xa;      &#xa;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN     &#xa;      :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO / 100 ,3);&#xa;    END IF;&#xa;&#xa;    --RAN:07/01/2019:126984&#xa;     IF :SYSTEM.CURSOR_ITEM = &apos;ITEMCOMPRACCUSTO.PC_PARTICIPACAO&apos; THEN&#xa;      IF (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NOT NULL) THEN&#xa;        IF :ITEMCOMPRACCUSTO.PC_PARTICIPACAO &lt;&gt; 0  THEN&#xa;          :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO / 100 ,3);&#xa;          --:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(((:ITEMCOMPRACCUSTO.QT_PREVISTA / ZVL(:ITEMCOMPRACCUSTO.COUNT_ITEMCOMPRA,1)) * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO) / 100,2);&#xa;          --SYNCHRONIZE;    &#xa;        END IF;&#xa;      END IF;&#xa;    END IF;&#xa;&#xa;    IF NVL(PACK_GLOBAL.TP_ITEM,&apos;N&apos;) &lt;&gt; &apos;S&apos;  THEN&#xa;       &#xa;      DECLARE&#xa;        V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE;&#xa;      BEGIN &#xa;        SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#xa;          INTO V_ST_UNIDMEDIDA&#xa;          FROM ITEM, UNIDMEDIDA&#xa;         WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#xa;           AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#xa;             &#xa;        IF ( V_ST_UNIDMEDIDA = &apos;U&apos; ) AND (:CONTROLE.LST_AUTOSUGESTAO IN (1,3))  THEN&#xa;          :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL);&#xa;          :ITEMCOMPRACCUSTO.PC_PARTICIPACAO  := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * 100 / :ITEMCOMPRACCUSTO.QT_PREVISTA,3);&#xa;        END IF;&#xa;           &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          NULL;&#xa;      END;&#xa;                                                  &#xa;     ELSIF  GET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;,ENABLED,PROPERTY_FALSE);&#xa;     END IF;&#xa;&#xa;     /* DCS:19/12/2013:67379 &#xa;     * faz o arredondamento no &#xfa;ltimo percentual, com base na autosugest&#xe3;o do percentual apos digitar a &#xfa;ltima quantidade d&#xa;     * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#xa;     */&#xa;     IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN &#xa;       IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) AND&#xa;        NVL(:ITEMCOMPRACCUSTO.PC_TOTAL,0) &gt; 100 THEN&#xa;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.PC_PARTICIPACAO - (:ITEMCOMPRACCUSTO.PC_TOTAL - 100);&#xa;      END IF;&#xa;     END IF;&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN E_SAIDA THEN&#xa;    NULL;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN &#xa;  IF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) &lt; 100 THEN&#xa;    IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;    END IF;&#xa;  ELSIF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) &gt; 100 THEN&#xa;     --A soma do percentual de participa&#xe7;&#xe3;o dos centros de custos deve ser igual a 100%.&#xa;     MENSAGEM_PADRAO(4740,&apos;&apos;);     &#xa;    :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := NULL;&#xa;    :ITEMCOMPRACCUSTO.PC_PARTICIPACAO  := NULL;&#xa;    IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;    END IF;&#xa;   &#xa;  ELSIF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) = 100 THEN&#xa;    IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED) = &apos;FALSE&apos; THEN&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;    END IF;&#xa;  END IF;&#xa;  IF ROUND(:ITEMCOMPRACCUSTO.PC_PARTICIPACAO,3) = 100 AND (:CONTROLE.LST_AUTOSUGESTAO &lt;&gt; 5) THEN&#xa;     :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := :ITEMCOMPRACCUSTO.QT_PREVISTA;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN&#xa;  VALIDATE(ITEM_SCOPE);&#xa;  IF FORM_SUCCESS THEN&#xa;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL  THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);  &#xa;       --A movimenta&#xe7;&#xe3;o deve ser informada.&#xa;       MENSAGEM_PADRAO(298,&apos;&apos;);&#xa;       GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_MOVIMENTACAO&apos;);&#xa;    ELSIF:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL THEN&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;        --O centro de custo deve ser informado.&#xa;        MENSAGEM_PADRAO(292,&apos;&apos;);&#xa;        GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_CENTROCUSTO&apos;);&#xa;    ELSE&#xa;      IF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) &lt; 100 THEN&#xa;         NEXT_RECORD;&#xa;         --GDG:01/08/2011:28715&#xa;         IF GET_ITEM_PROPERTY(&apos;ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST&apos;, VISUAL_ATTRIBUTE) = &apos;VSA_CAMPOTEXTO&apos; THEN&#xa;           GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST&apos;);&#xa;         ELSE&#xa;           GO_ITEM(&apos;ITEMCOMPRACCUSTO.CD_CENTROCUSTO&apos;);&#xa;         END IF;&#xa;      ELSIF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) = 100 THEN&#xa;        GO_ITEM(&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;);&#xa;      END IF;    &#xa;    END IF;     &#xa;  ELSE            &#xa;    RETURN;&#xa;  END IF;&#xa;END;&#xa;"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="BEGIN  &#xa;  IF (ERROR_TYPE = &apos;FRM&apos;) AND (ERROR_CODE = 40209) THEN&#xa;    MENSAGEM(&apos;&apos;,&apos;Os caracteres v&#xe1;lidos s&#xe3;o 0-9 - e +.&apos;,4);&#xa;  ELSE&#xa;    VALIDA_ERROS;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="Complemento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="BTN_OK: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="@">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779084" FOLDED="true" MODIFIED="1607991779084" TEXT="body">
<node CREATED="1607991779084" MODIFIED="1607991779084" TEXT="DECLARE&#xa;  E_GERAL         EXCEPTION;&#xa;  E_ALERTA        EXCEPTION;&#xa;  V_MENSAGEM       VARCHAR2(32000);&#xa;  V_ST_EXIBEMSG    BOOLEAN DEFAULT FALSE;--MGK:61460:30/07/2013&#xa;  V_ALERT          NUMBER;--MGK:61460:30/07/2013&#xa;  COUNT_NULL       NUMBER;&#xa;  COUNT_NOT_NULL   NUMBER;&#xa;  COUNT_GERAL      NUMBER;&#xa;BEGIN&#xa;  GO_ITEM(&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;);&#xa;  --GDG:01/08/2011:28715  &#xa;  VALIDATE(ITEM_SCOPE);&#xa;  IF FORM_SUCCESS THEN&#xa;    VALIDATE(RECORD_SCOPE);&#xa;    IF NOT FORM_SUCCESS THEN&#xa;      RETURN;&#xa;    END IF;&#xa;  ELSE&#xa;    RETURN;&#xa;  END IF;&#xa;  &#xa;  IF (NVL(:ITEMCOMPRACCUSTO.QT_TOTAL,0) &gt; 0) THEN&#xa;    IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL)&lt;&gt; ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#xa;      --A  Quantidade tolal prevista para o centro de custo &#xa2;QT_PREVISTA&#xa2; &#xe9; diferente do total rateado  &#xa2;QT_TOTAL&#xa2;.                            &#xa;      MENSAGEM_PADRAO(32776, &apos;&#xa2;QT_PREVISTA=&apos;||ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA)||&apos;&#xa2;QT_TOTAL=&apos;||ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL)||&apos;&#xa2;&apos;);                                                         &#xa;      RAISE FORM_TRIGGER_FAILURE;               &#xa;     END IF;&#xa;  END IF;  &#xa;    &#xa;  IF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) = 100 THEN    &#xa;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL AND :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL /*AND :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL*/ THEN     &#xa;     DELETE_RECORD;&#xa;    END IF;&#xa;    --------------------------------------------------------------------&#xa;    --VERIFICA SE A MOVIMENTA&#xc7;&#xc3;O E O CENTRO DE CUSTO EST&#xc3;O PREENCHIDOS--&#xa;    --------------------------------------------------------------------&#xa;    COUNT_NULL      := 0;&#xa;    COUNT_NOT_NULL   := 0;&#xa;    COUNT_GERAL     := 0;&#xa;    &#xa;    FIRST_RECORD;&#xa;    LOOP&#xa;      --RAN:126984:07/01/2019  &#xa;      IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL THEN&#xa;        COUNT_NOT_NULL := COUNT_NOT_NULL+1;&#xa;      ELSIF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL THEN&#xa;        COUNT_NULL := COUNT_NULL+1;&#xa;      END IF;&#xa;      &#xa;      COUNT_GERAL := COUNT_GERAL+1;&#xa;       &#xa;      /**RSS:21/12/2007:17745&#xa;       * Condi&#xe7;&#xe3;o para valida&#xe7;&#xe3;o do centro de custo, assim como determinado no COM009. &#xa;       */&#xa;       /*ATR:115974:26/12/2017*/&#xa;     &#xa;      IF PACK_GLOBAL.ST_APROVSOLIC = &apos;S&apos; AND NVL(PACK_GLOBAL.ST_VALIDACCUSTO,&apos;N&apos;) IN (&apos;C&apos;,&apos;A&apos;) AND&#xa;         (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL) AND &#xa;        (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL) AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO(&apos;COM&apos;,9,&apos;MAX&apos;,:ITEMCOMPRA.CD_EMPRESA,&apos;ST_NAOBRIGAUTORIZ&apos;),&apos;N&apos;) = &apos;N&apos; THEN  &#xa;        --O autorizador do centro de custo deve ser informado.&#xa;        MENSAGEM_PADRAO(4739,&apos;&apos;);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;      IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL OR :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL THEN&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRACCUSTO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;      IF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL) THEN&#xa;        V_ST_EXIBEMSG := TRUE;&#xa;      END IF;&#xa;      &#xa;      EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;    &#xa;    IF ZVL(COUNT_NULL, COUNT_GERAL) &lt;&gt; COUNT_GERAL OR &#xa;       ZVL(COUNT_NOT_NULL, COUNT_GERAL) &lt;&gt; COUNT_GERAL THEN&#xa;      MENSAGEM_PADRAO(32001, NULL);&#xa;&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;    &#xa;    /* RBM: 05/09/2008&#xa;     * Incluida valida&#xe7;&#xe3;o para que n&#xe3;o insira no bloco ITECOMPRACCUSTO centros de custos repetido.&#xa;     */&#xa;     /**CSL:30317:22/12/2010&#xa;      * Esta valida&#xe7;&#xe3;o foi alterada para verificar o c&#xf3;digo do centro de custos e o c&#xf3;digo do neg&#xf3;cio, pois&#xa;      * apartir desta vers&#xe3;o ser&#xe1; permitido inserir mais de um registro com o mesmo centro de custos, por&#xe9;m &#xa;      * o c&#xf3;digo do neg&#xf3;cio deve ser diferente.&#xa;      */&#xa;    VALIDA_DUPLICADOS(V_MENSAGEM);&#xa;    &#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;    &#xa;    ADICIONA_GRUPO;&#xa;    GO_ITEM(&apos;ITEMCOMPRA.DS_OBSERVACAO&apos;);&#xa;  ELSE&#xa;     --A soma do percentual de participa&#xe7;&#xe3;o dos centros de custos deve ser igual a 100%.&#xa;     MENSAGEM_PADRAO(4740,&apos;&apos;);     &#xa;    GO_ITEM(&apos;ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&apos;);&#xa;  END IF;&#xa;  &#xa;  /*ASF:19/02/2020:140506*/&#xa;  --MGK:61460:30/07/2013&#xa;  IF (V_ST_EXIBEMSG) AND (:CONTROLE.LST_AUTOSUGESTAO &lt;&gt; 5) THEN&#xa;    V_ALERT := SHOW_ALERT(&apos;ALR_QTDENULA&apos;);&#xa;    IF (V_ALERT = ALERT_BUTTON1) THEN&#xa;      NULL;&#xa;    ELSIF (V_ALERT = ALERT_BUTTON2) THEN &#xa;      GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20836, NULL);&#xa;      RAISE E_ALERTA;&#xa;    ELSE&#xa;      NULL;&#xa;    END IF;&#xa;  END IF;&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_ALERTA THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN E_GERAL THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="BT_CANCELAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="BEGIN&#xa;  GO_BLOCK(&apos;ITEMCOMPRACCUSTO&apos;);&#xa;  CLEAR_BLOCK (NO_VALIDATE);&#xa;  --:ITEMCOMPRA.QT_PREVISTA := 0;  &#xa;  PACK_GRUPO.DELETA_GRUPO_CC(:ITEMCOMPRACCUSTO.CD_ITEM);&#xa;  GO_ITEM(&apos;ITEMCOMPRA.QT_PREVISTA&apos;);&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="QT_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Soma das Quantidades">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="PC_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Soma dos Percentuais de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Descri&#xe7;&#xe3;o do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="QT_PREVISTA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Quantidade Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Quantidade a Solicitar">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Nr Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESAUTORIZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Empresautoriz">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESASOLIC: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Empresasolic">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_SOLICITANTE: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT=":GLOBAL.CD_USUARIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="ST_ITEMCOMPRA: Number(2)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@"/>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_LIBERACAO: Date(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Atualizacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="ST_LIBERADO: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="St Liberado">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_RECORD: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="HR_RECORD: Char(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Hr Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_CONTAORCAMENTO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@"/>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_CAMINHO: Char(3200)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Importa&#xe7;&#xe3;o de Planilha">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="BTN_IMPORTAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="DECLARE&#xa;  V_MENSAGEM VARCHAR2(32000);&#xa;BEGIN&#xa;  IF(:ITEMCOMPRACCUSTO.DS_CAMINHO IS NOT NULL)THEN  &#xa;    IMPORTA_ARQUIVO(V_MENSAGEM);&#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      RAISE FORM_TRIGGER_FAILURE;&#xa;    END IF;&#xa;  ELSE&#xa;    --  &#xc9; necess&#xe1;rio informar o caminho do arquivo para importar os dados.&#xa;    MENSAGEM_PADRAO(4140, NULL);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  END IF;    &#xa;END;&#xa;&#xa;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_NEGOCIOCENTRO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Centro Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="ST_NEGOCIOPLANILHA: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="St Liberado">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="N">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" ID="ID_535539733" MODIFIED="1607991779085" TEXT="ULTIMASCOMPRAS">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@"/>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="BTN_FECHAR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="BEGIN&#xa;  GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_CLIFOR: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Fornecedor">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NM_CLIFOR: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@"/>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="PS_ATENDIDO: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Peso">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="QT_ATENDIDA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="VL_UNITITEM: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Valor Unit.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="VL_TOTITEM: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Valor Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_NFEMPR: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Nota">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_EMISSAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Data">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="PC_IPI: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="IPI %">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" ID="ID_1343382137" MODIFIED="1607991779085" TEXT="ITEMCOMPRA_AUX">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="VL_ESTIMADO_AUX: Number(21)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA_AUX.VL_ESTIMADO_AUX IS NULL THEN&#xa;    --Informe um valor estimado para compra por unidade do item.&#xa;    MENSAGEM_PADRAO(4741,&apos;&apos;);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  END IF;&#xa;  :ITEMCOMPRA.VL_ESTIMADO := :ITEMCOMPRA_AUX.VL_ESTIMADO_AUX;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="BTN_VOLTAR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="BEGIN&#xa;  IF :ITEMCOMPRA_AUX.VL_ESTIMADO_AUX IS NULL THEN&#xa;    --Informe um valor estimado para compra por unidade do item.&#xa;    MENSAGEM_PADRAO(4741,&apos;&apos;);&#xa;    GO_ITEM(&apos;ITEMCOMPRA_AUX.VL_ESTIMADO_AUX&apos;);&#xa;  ELSE&#xa;    GO_ITEM(&apos;ITEMCOMPRA.QT_PREVISTA&apos;);&#xa;    EXECUTE_TRIGGER(&apos;KEY-NEXT-ITEM&apos;);&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" ID="ID_1842515142" MODIFIED="1607991779085" TEXT="DEVOLUCAO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_LOTECOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@"/>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_BEMPAT: Char(7)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Bempat">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESAITEM: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Empresaitem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESASOLIC: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Empresasolic">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESAUTORIZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Empresautoriz">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_ENDERENTREGA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Enderentrega">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_PROJETO: Char(7)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_SOLICITANTE: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_ITEMSERVICO: Char(1000)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Ds Itemservico">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_ALTERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Alteracao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_CONSOLIDACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Consolidacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_LIBERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Liberacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_RECORD: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_SOLICITACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Solicitacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="HR_RECORD: Char(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Hr Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_ITEMPRORIGEM: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Nr Itemprorigem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_NEGOCIACAO: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Nr Negociacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="QT_NEGOCIADA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Qt Negociada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="ST_EMISSAONF: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="St Emissaonf">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="ST_ITEMCOMPRA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="St Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_STATUS: Char(32000)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Status">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_CANCELAMENTO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Cancelamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="TP_APROVSOLIC: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Tp Aprovsolic">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Solicita&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="N&#xfa;mero da Solicita&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Descri&#xe7;&#xe3;o do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="LOV_ITEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Mov.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NM_USUAUTORIZ: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Nome Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="QT_PREVISTA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Quantidade ">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Cd Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Ds Observacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DT_INICIO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Dt Inicio">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="DS_OBSCANCEL: Char(500)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Ds Obscancel">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="BT_FECHAR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="BEGIN&#xa;   --:CONTROLE.NR_ITEMCOMPRA:=:DEVOLUCAO.NR_ITEMCOMPRA;&#xa;   :CONTROLE.NR_LOTECOMPRA:= :DEVOLUCAO.NR_LOTECOMPRA;&#xa;   HIDE_WINDOW(&apos;WIN_SEL&apos;);&#xa;   --GO_BLOCK(&apos;CONTROLE&apos;);&#xa;   GO_ITEM(&apos;CONTROLE.NR_LOTECOMPRA&apos;);&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="CONS_ITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="C&#xf3;digo da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT=":GLOBAL.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="LOV_EMPRESA2">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="BEGIN&#xa;  IF :CONS_ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#xa;    :CONS_ITEMCOMPRA.NM_EMPRESA := PACK_VALIDATE.RETORNA_NM_EMPRESA(:CONS_ITEMCOMPRA.CD_EMPRESA);&#xa;  ELSE&#xa;    :CONS_ITEMCOMPRA.NM_EMPRESA := NULL;&#xa;  END IF;  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="DECLARE&#xa;  --V_INSTRUCAO       VARCHAR2(1000);&#xa;  E_GERAL            EXCEPTION;&#xa;  V_MENSAGEM        VARCHAR2(32000);     &#xa;  --V_COUNT            NUMBER;&#xa;  --V_CD_EMPRESA      ITEMCOMPRA.CD_EMPRESA%TYPE;&#xa;  --V_NR_LOTECOMPRA    ITEMCOMPRA.NR_ITEMCOMPRA%TYPE;&#xa;  --V_CD_AUTORIZADOR  ITEMCOMPRA.CD_AUTORIZADOR%TYPE;&#xa;  --V_CD_TIPOCOMPRA    ITEMCOMPRA.CD_TIPOCOMPRA%TYPE;&#xa;  --V_DT_DESEJADA      ITEMCOMPRA.DT_DESEJADA%TYPE;&#xa;  --V_DT_INICIO        ITEMCOMPRA.DT_INICIO%TYPE;&#xa;  --V_NR_CONTRATO      ITEMCOMPRA.NR_CONTRATO%TYPE;&#xa;  --V_CD_DEPARTAMENTO ITEMCOMPRA.CD_DEPARTAMENTO%TYPE;&#xa;  &#xa;BEGIN  &#xa;  IF :CONS_ITEMCOMPRA.NR_LOTECOMPRA IS NOT NULL AND :CONS_ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#xa;    PACK_PROCEDIMENTOS.CARREGA_ITEMCOMPRA(I_CD_EMPRESA     =&gt; :CONS_ITEMCOMPRA.CD_EMPRESA,&#xa;                                          I_NR_LOTECOMPRA =&gt; :CONS_ITEMCOMPRA.NR_LOTECOMPRA,&#xa;                                          O_MENSAGEM      =&gt; V_MENSAGEM);                                                &#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;  ELSE&#xa;    GO_ITEM(&apos;CONS_ITEMCOMPRA.NR_LOTECOMPRA&apos;);&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;MAXYS&apos;,V_MENSAGEM,2);&#xa;  WHEN OTHERS THEN&#xa;    NULL;    &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NM_EMPRESA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Nome da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT=":GLOBAL.DS_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_LOTECOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="N&#xfa;mero do Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="LOV_LOTECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="DECLARE&#xa;  E_GERAL            EXCEPTION;&#xa;  V_MENSAGEM        VARCHAR2(32000);       &#xa;BEGIN  &#xa;  IF :CONS_ITEMCOMPRA.NR_LOTECOMPRA IS NOT NULL AND :CONS_ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#xa;    PACK_PROCEDIMENTOS.CARREGA_ITEMCOMPRA(I_CD_EMPRESA     =&gt; :CONS_ITEMCOMPRA.CD_EMPRESA,&#xa;                                          I_NR_LOTECOMPRA =&gt; :CONS_ITEMCOMPRA.NR_LOTECOMPRA,&#xa;                                          O_MENSAGEM      =&gt; V_MENSAGEM);                                                &#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;  ELSE&#xa;    GO_ITEM(&apos;CONS_ITEMCOMPRA.CD_EMPRESA&apos;);&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;MAXYS&apos;,V_MENSAGEM,2);&#xa;  WHEN OTHERS THEN&#xa;    NULL;    &#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="BTN_CARREGA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="BEGIN&#xa;  IF :DUPLICAITEMCOMPRA.NR_LOTECOMPRA IS NOT NULL THEN&#xa;    PACK_PROCEDIMENTOS.CARREGA_LOTE;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="BTN_CANCELA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="body">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="&#xa;&#xa;GO_BLOCK(&apos;DUPLICAITEMCOMPRACC&apos;);&#xa;CLEAR_BLOCK(NO_VALIDATE);&#xa;GO_BLOCK(&apos;DUPLICAITEMCOMPRA&apos;);&#xa;CLEAR_BLOCK(NO_VALIDATE);&#xa;GO_ITEM(&apos;CONTROLE.CD_AUTORIZADOR&apos;);"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="DUPLICAITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@"/>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_LOTECOMPRA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@"/>
</node>
<node CREATED="1607991779085" FOLDED="true" MODIFIED="1607991779085" TEXT="NR_ITEMCOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="@">
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="Nr. Solicita&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="N&#xfa;mero da Solicita&#xe7;&#xe3;o de Compras">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="N&#xfa;mero da Solicita&#xe7;&#xe3;o de Compras">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779085" MODIFIED="1607991779085" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Descri&#xe7;&#xe3;o do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Moviment.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="QT_PREVISTA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade a Solicitar. Somente ser&#xe1; aceito casas decimais para este campo se o tipo de c&#xe1;lculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade a Solicitar.Somente ser&#xe1; aceito casas decimais para este campo se o tipo de c&#xe1;lculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  IF :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO IS NOT NULL THEN&#xa;    GO_ITEM(&apos;DUPLICAITEMCOMPRACC.CD_EMPRCCUSTODEST&apos;);&#xa;  ELSIF :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO IS NULL AND :SYSTEM.LAST_RECORD = &apos;FALSE&apos; THEN&#xa;    NEXT_RECORD;&#xa;  ELSE&#xa;    GO_ITEM(&apos;DUPLICAITEMCOMPRA.NR_ITEMCOMPRA&apos;);&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="DUPLICAITEMCOMPRACC">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@"/>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="NR_ITEMCOMPRA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@"/>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_EMPRCCUSTODEST: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Empresa&#xa;dest. custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_CENTROCUSTO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Centro Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_CENTROCUSTO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Descri&#xe7;&#xe3;o do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_NEGOCIO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Neg&#xf3;cio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Neg&#xf3;cio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;d. Mov.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_MOVIMENTACAO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Descri&#xe7;&#xe3;o da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="QT_PEDIDAUNIDSOL: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="PC_PARTICIPACAO: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="% Partic.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Percentual de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Percentual de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  IF :SYSTEM.LAST_RECORD = &apos;FALSE&apos; THEN&#xa;    NEXT_RECORD;&#xa;  ELSE&#xa;    GO_ITEM(&apos;DUPLICAITEMCOMPRA.NR_ITEMCOMPRA&apos;);&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" ID="ID_1757965301" MODIFIED="1607991779086" TEXT="ITEMCOMPRANEGOCIO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@"/>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Descri&#xe7;&#xe3;o do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="QT_PREVISTA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade a Solicitar">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_EMPRCCUSTODEST: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Empresa&#xa;Destino">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="LOV_EMPRESANEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  IF :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST IS NULL THEN&#xa;    :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST := :ITEMCOMPRA.CD_EMPRESA;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="&#xa;BEGIN&#xa;  IF :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST IS NOT NULL THEN&#xa;    :ITEMCOMPRANEGOCIO.NM_EMPRESADEST := PACK_VALIDATE.RETORNA_NM_EMPRESA(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST);&#xa;  ELSE&#xa;    :ITEMCOMPRANEGOCIO.NM_EMPRESADEST := NULL;&#xa;  END IF;&#xa;    &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  :ITEMCOMPRANEGOCIO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#xa;  :ITEMCOMPRANEGOCIO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#xa;  :ITEMCOMPRANEGOCIO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#xa;  :ITEMCOMPRANEGOCIO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#xa;  :ITEMCOMPRANEGOCIO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="NM_EMPRESADEST: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;d. Movto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="DECLARE&#xa;  V_TP_PEDIDO    PARMOVIMENT.TP_PEDIDO%TYPE; --PHS:60051:11/07/2013&#xa;  I_CD_NATUREZA  PLANOCONTABIL.CD_NATUREZA%TYPE;&#xa;  I_MENSAGEM     VARCHAR2(32000);&#xa;  E_GERAL        EXCEPTION; &#xa;BEGIN&#xa;&#xa;  IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NOT NULL THEN&#xa;      IF PACK_GLOBAL.TP_SELECAOCONTA = &apos;O&apos; THEN&#xa;        /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padr&#xe3;o da fun&#xe7;&#xe3;o VALIDA_SELECAOCONTA quando for &apos;CO&apos;*/&#xa;        I_MENSAGEM := VALIDA_SELECAOCONTA (NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST,:CONTROLE.CD_EMPRESA),&#xa;                                           :ITEMCOMPRANEGOCIO.CD_ITEM,&#xa;                                           :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO, &#xa;                                           NULL, &apos;CO&apos;);    &#xa;        IF (I_MENSAGEM IS NOT NULL) AND (I_MENSAGEM &lt;&gt; &apos;S&apos;) THEN&#xa;          RAISE E_GERAL;&#xa;        END IF;&#xa;      END IF;&#xa;      &#xa;      /* CSL:02/12/2013:64869&#xa;       * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO para n&#xe3;o permitir realizar lan&#xe7;amentos em contas, &#xa;       * que n&#xe3;o pertencem a vers&#xe3;o do plano de contas da empresa do lan&#xe7;amento.&#xa;       */&#xa;      PACK_VALIDA.VALIDA_CONTABIL_PLANO(:ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST,:GLOBAL.CD_EMPRESA), I_MENSAGEM);&#xa;    &#xa;      IF I_MENSAGEM IS NOT NULL THEN&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;      BEGIN&#xa;        /*CSL:30/12/2013:64869*/&#xa;        IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;                 PLANOCONTABIL.CD_NATUREZA,&#xa;                 PARMOVIMENT.TP_PEDIDO&#xa;            INTO :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO,&#xa;                 I_CD_NATUREZA,&#xa;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#xa;            FROM PARMOVIMENT,HISTCONTB,PLANOCONTABIL&#xa;           WHERE PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO&#xa;             AND HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#xa;             AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#xa;             /*AND PLANOCONTABIL.TP_CONTACONTABIL = &apos;CC&apos;*/;&#xa;        &#xa;        ELSE&#xa;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#xa;                 PLANOCONTABILVERSAO.CD_NATUREZA,&#xa;                 PARMOVIMENT.TP_PEDIDO&#xa;            INTO :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO,&#xa;                 I_CD_NATUREZA,&#xa;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#xa;            FROM PARMOVIMENT, HISTCONTB, PLANOCONTABILVERSAO&#xa;           WHERE PARMOVIMENT.CD_MOVIMENTACAO           = :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO&#xa;             AND HISTCONTB.CD_HISTCONTB                = PARMOVIMENT.CD_HISTCONTB&#xa;             AND PLANOCONTABILVERSAO.CD_CONTACONTABIL  = HISTCONTB.CD_CONTACONTABIL&#xa;             /*AND PLANOCONTABILVERSAO.TP_CONTACONTABIL  = &apos;CC&apos;*/&#xa;             AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#xa;                 PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));  &#xa;        END IF;&#xa;        &#xa;      EXCEPTION&#xa;        WHEN NO_DATA_FOUND THEN&#xa;          --Movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; n&#xe3;o cadastrada, n&#xe3;o &#xe9; de compra ou n&#xe3;o &#xe9; de Centro de Custo. Verifique TCB008.&#xa;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3775,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO||&apos;&#xa2;&apos;);&#xa;          RAISE E_GERAL;&#xa;      END;&#xa;    &#xa;      --PHS:60051:11/07/2013&#xa;      IF V_TP_PEDIDO &lt;&gt; PACK_GLOBAL.TP_PEDIDO THEN&#xa;        --A movimenta&#xe7;&#xe3;o &#xa2;CD_MOVIMENTACAO&#xa2; possui o tipo de pedido &#xa2;TP_PEDIDO&#xa2; diferente do tipo de pedido &#xa2;TP_CADPEDIDO&#xa2; cadastrado para o programa. Verificar os programas TCB008 e ANV008.&#xa;        MENSAGEM_PADRAO(20737,&apos;&#xa2;CD_MOVIMENTACAO=&apos;||:ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO||&apos;&#xa2;TP_PEDIDO=&apos;||V_TP_PEDIDO||&apos;&#xa2;TP_CADPEDIDO=&apos;||PACK_GLOBAL.TP_PEDIDO||&apos;&#xa2;&apos;); &#xa;      END IF;  &#xa;    &#xa;          &#xa;  ELSE&#xa;    :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO := NULL;&#xa;  END IF;&#xa;  &#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO := NULL;&#xa;     :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO := NULL;&#xa;    MENSAGEM(&apos;Maxys&apos;,I_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO := NULL;&#xa;     :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO := NULL;&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="KEYLISTVAL">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  /*CSL:30/12/2013:64869*/&#xa;  IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN &#xa;    SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENT&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENT1&apos;);   &#xa;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;X&apos;) IN (&apos;O&apos;,&apos;S&apos;) &#xa;        AND SHOW_LOV(&apos;LOV_PARMOVIMENT&apos;) THEN&#xa;      NULL; &#xa;    ELSE&#xa;       SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENT&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENT&apos;);&#xa;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;S&apos;)= &apos;S&apos; &#xa;          AND SHOW_LOV(&apos;LOV_PARMOVIMENT&apos;) THEN&#xa;           NULL;&#xa;      END IF;&#xa;    END IF;&#xa;&#xa;  ELSE--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN&#xa;    &#xa;    SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENTVERSAO&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENT1VERSAO&apos;);   &#xa;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;X&apos;) IN (&apos;O&apos;,&apos;S&apos;) &#xa;        AND SHOW_LOV(&apos;LOV_PARMOVIMENTVERSAO&apos;) THEN&#xa;      NULL; &#xa;    ELSE&#xa;       SET_LOV_PROPERTY(&apos;LOV_PARMOVIMENTVERSAO&apos;,GROUP_NAME, &apos;LOV_PARMOVIMENTVERSAO&apos;);&#xa;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,&apos;S&apos;)= &apos;S&apos; &#xa;          AND SHOW_LOV(&apos;LOV_PARMOVIMENTVERSAO&apos;) THEN&#xa;           NULL;&#xa;      END IF;&#xa;    END IF;&#xa;  END IF;--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,&apos;D&apos;) = &apos;D&apos; THEN  &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL THEN&#xa;    :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO := :ITEMCOMPRA.CD_MOVIMENTACAO;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_MOVIMENTACAO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Descri&#xe7;&#xe3;o da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="CD_NEGOCIO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Neg&#xf3;cio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="LOV_NEGOCIORATEIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  IF :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN  &#xa;    SELECT DS_NEGOCIO&#xa;      INTO :ITEMCOMPRANEGOCIO.DS_NEGOCIO&#xa;      FROM NEGOCIO&#xa;     WHERE NEGOCIO.CD_NEGOCIO = :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#xa;     &#xa;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#xa;      VALIDA_CONTA_ORCAMENTO(&apos;ITEMCOMPRANEGOCIO.CD_CONTAORCAMENTO&apos;, :ITEMCOMPRA.CD_MOVIMENTACAO, null,:ITEMCOMPRANEGOCIO.CD_NEGOCIO);&#xa;    END IF; &#xa;  ELSE&#xa;    :ITEMCOMPRANEGOCIO.DS_NEGOCIO := NULL;&#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN NO_DATA_FOUND THEN&#xa;    MENSAGEM_PADRAO(147,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||&apos;&#xa2;&apos;);--O Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; n&#xe3;o est&#xe1; cadastrado. Verifique o programa TCB001.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN TOO_MANY_ROWS THEN&#xa;    MENSAGEM_PADRAO(148,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||&apos;&#xa2;&apos;);--O Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2; est&#xe1; cadastrado v&#xe1;rias vezes. Verifique o programa TCB001.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM_PADRAO(149,&apos;&#xa2;CD_NEGOCIO=&apos;||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);--Ocorreu um erro inesperado ao consultar os dados do c&#xf3;digo de Neg&#xf3;cio &#xa2;CD_NEGOCIO&#xa2;. Erro: &#xa2;SQLERRM&#xa2;.&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_NEGOCIO: Char(60)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="LOV_NEGOCIORATEIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="QT_PEDIDAUNIDSOL: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  IF :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NOT NULL THEN       &#xa;    IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL  THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);  &#xa;       --A movimenta&#xe7;&#xe3;o deve ser informada. &#xa;       MENSAGEM_PADRAO(298,&apos;&apos;);&#xa;       GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO&apos;);&#xa;    ELSIF:ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;        --O centro de custo deve ser informado.&#xa;        MENSAGEM_PADRAO(292,&apos;&apos;);&#xa;        GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_NEGOCIO&apos;);&#xa;    ELSE   &#xa;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#xa;          SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;          SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;           GO_ITEM(&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;);&#xa;        ELSE &#xa;          IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.PC_PARTICIPACAO&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;            SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_FALSE);&#xa;           END IF;&#xa;             &#xa;             &#xa;           IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) &gt; ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#xa;                   --A soma dos valores lan&#xe7;ados em Centro de Custo &#xa2;VL_CCUSTO&#xa2; para o item &#xa2;CD_ITEM&#xa2; deve corresponder ao valor lan&#xe7;ados no pedido &#xa2;VL_TOTITEM&#xa2;.&#xa;                  MENSAGEM_PADRAO(29150,&apos;&#xa2;VL_CCUSTO=&apos; ||ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL)||&#xa;                                       &apos;&#xa2;CD_ITEM=&apos;   ||:ITEMCOMPRANEGOCIO.CD_ITEM||&#xa;                                       &apos;&#xa2;VL_TOTITEM=&apos;||ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA)||&apos;&#xa2;&apos;);&#xa;                  SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;                 RAISE FORM_TRIGGER_FAILURE;&#xa;               &#xa;            END IF;&#xa;             NEXT_RECORD;&#xa;             GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST&apos;);&#xa;             &#xa;        END IF;      &#xa;    END IF;&#xa;  ELSE&#xa;    NEXT_ITEM;      &#xa;  END IF;   &#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  IF :SYSTEM.CURSOR_ITEM = &apos;ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL&apos; THEN&#xa;    DECLARE&#xa;      V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE; &#xa;    BEGIN &#xa;      SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#xa;        INTO V_ST_UNIDMEDIDA&#xa;        FROM ITEM, UNIDMEDIDA&#xa;       WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#xa;         AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#xa;           &#xa;      IF ( V_ST_UNIDMEDIDA = &apos;U&apos; ) THEN&#xa;         :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL);&#xa;      END IF;         &#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        NULL;&#xa;    END;  &#xa;    &#xa;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (2,3)) THEN&#xa;      IF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO IS NULL) THEN&#xa;        :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL * 100 /&#xa;                                                   :ITEMCOMPRANEGOCIO.QT_PREVISTA,3);&#xa;                                                &#xa;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#xa;           SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;           SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;        ELSE &#xa;          IF (GET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.PC_PARTICIPACAO&apos;,ENABLED) = &apos;TRUE&apos;) THEN&#xa;             SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_FALSE);&#xa;          END IF;&#xa;        END IF;        &#xa;        &#xa;        /* DCS:19/12/2013:67379 &#xa;         * faz o arredondamento no &#xfa;ltimo percentual, com base na autosugest&#xe3;o do percentual apos digitar a &#xfa;ltima quantidade d&#xa;         * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#xa;         */&#xa;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) AND&#xa;           NVL(:ITEMCOMPRANEGOCIO.PC_TOTAL,0) &gt; 100 THEN&#xa;          :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO - (:ITEMCOMPRANEGOCIO.PC_TOTAL - 100);&#xa;        END IF;&#xa;        &#xa;      ELSIF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO IS NOT NULL) THEN&#xa;        :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL * 100 /&#xa;                                                   :ITEMCOMPRANEGOCIO.QT_PREVISTA,3);&#xa;        &#xa;        /* DCS:19/12/2013:67379 &#xa;         * faz o arredondamento no &#xfa;ltimo percentual, com base na autosugest&#xe3;o do percentual apos digitar a &#xfa;ltima quantidade d&#xa;         * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#xa;         */&#xa;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) AND&#xa;           NVL(:ITEMCOMPRANEGOCIO.PC_TOTAL,0) &gt; 100 THEN&#xa;          :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO - (:ITEMCOMPRANEGOCIO.PC_TOTAL - 100);&#xa;        END IF;        &#xa;        &#xa;      ELSIF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NULL) THEN&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRANEGOCIO.PC_PARTICIPACAO&apos;,ENABLED,PROPERTY_TRUE);&#xa;        SET_ITEM_PROPERTY(&apos;ITEMCOMPRANEGOCIO.PC_PARTICIPACAO&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;      END IF;&#xa;    END IF;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;   IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) &lt; ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) &gt; ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#xa;       --A soma dos valores lan&#xe7;ados em Centro de Custo &#xa2;VL_CCUSTO&#xa2; para o item &#xa2;CD_ITEM&#xa2; deve corresponder ao valor lan&#xe7;ados no pedido &#xa2;VL_TOTITEM&#xa2;.&#xa;      MENSAGEM_PADRAO(4526,&apos;&#xa2;VL_CCUSTO=&apos; ||ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL)||&#xa;                           &apos;&#xa2;CD_ITEM=&apos;   ||:ITEMCOMPRANEGOCIO.CD_ITEM||&#xa;                           &apos;&#xa2;VL_TOTITEM=&apos;||ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA)||&apos;&#xa2;&apos;);&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;      SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;   END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN  &#xa;  IF (ERROR_TYPE = &apos;FRM&apos;) AND (ERROR_CODE = 40209) THEN&#xa;    MENSAGEM(&apos;&apos;,&apos;Os caracteres v&#xe1;lidos s&#xe3;o 0-9 - e +.&apos;,4);&#xa;  ELSE&#xa;    VALIDA_ERROS;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="PC_PARTICIPACAO: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="% Partic.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Percentual de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Percentual de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="DECLARE&#xa;  V_MENSAGEM  VARCHAR2(32000);&#xa;  E_GERAL      EXCEPTION;&#xa;BEGIN&#xa;  IF :SYSTEM.CURSOR_ITEM = &apos;ITEMCOMPRANEGOCIO.PC_PARTICIPACAO&apos; AND (:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO IS NOT NULL) THEN&#xa;    &#xa;    IF (NVL(:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO,0) &lt;= 0) THEN&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20921, NULL);&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;    &#xa;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN     &#xa;      :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA * :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO / 100 ,3);&#xa;    END IF;                                              &#xa;       &#xa;     IF NVL(PACK_GLOBAL.TP_ITEM,&apos;N&apos;) &lt;&gt; &apos;S&apos;  THEN&#xa;       &#xa;       DECLARE&#xa;         V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE;&#xa;       BEGIN &#xa;         SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#xa;           INTO V_ST_UNIDMEDIDA&#xa;           FROM ITEM, UNIDMEDIDA&#xa;          WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#xa;            AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#xa;             &#xa;         IF ( V_ST_UNIDMEDIDA = &apos;U&apos; ) AND (:CONTROLE.LST_AUTOSUGESTAO IN (1,3))  THEN&#xa;            :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL);&#xa;            :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO  := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL * 100 /&#xa;                                                        :ITEMCOMPRANEGOCIO.QT_PREVISTA,3);&#xa;         END IF;&#xa;           &#xa;       EXCEPTION&#xa;          WHEN NO_DATA_FOUND THEN&#xa;            NULL;&#xa;       END;&#xa;                                                  &#xa;      ELSIF  GET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL&apos;,ENABLED,PROPERTY_FALSE);&#xa;      END IF;&#xa;      &#xa;      /* DCS:19/12/2013:67379 &#xa;      * faz o arredondamento no &#xfa;ltimo percentual, com base na autosugest&#xe3;o do percentual apos digitar a &#xfa;ltima quantidade d&#xa;      * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#xa;      */&#xa;      IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN &#xa;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) AND&#xa;          NVL(:ITEMCOMPRANEGOCIO.PC_TOTAL,0) &gt; 100 THEN&#xa;         :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO - (:ITEMCOMPRANEGOCIO.PC_TOTAL - 100);&#xa;       END IF;&#xa;      END IF;&#xa;      &#xa;  END IF;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN &#xa;   IF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) &lt; 100 THEN&#xa;      IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;         SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;      END IF;&#xa;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) &gt; 100 THEN&#xa;       --A soma do percentual de participa&#xe7;&#xe3;o dos centros de custos deve ser igual a 100%.&#xa;       MENSAGEM_PADRAO(4740,&apos;&apos;);     &#xa;      :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := NULL;&#xa;      :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO  := NULL;&#xa;      IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED) = &apos;TRUE&apos; THEN&#xa;         SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;      END IF;&#xa;     &#xa;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) = 100 THEN&#xa;      IF GET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED) = &apos;FALSE&apos; THEN&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_TRUE);&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,NAVIGABLE,PROPERTY_TRUE);&#xa;      END IF;&#xa;   END IF;&#xa;   IF ROUND(:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO,3) = 100 THEN&#xa;      :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL:=:ITEMCOMPRANEGOCIO.QT_PREVISTA;&#xa;   END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN&#xa;  VALIDATE(ITEM_SCOPE);&#xa;  IF FORM_SUCCESS THEN&#xa;    IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL  THEN&#xa;       SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);  &#xa;       --A movimenta&#xe7;&#xe3;o deve ser informada.&#xa;       MENSAGEM_PADRAO(298,&apos;&apos;);&#xa;       GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO&apos;);&#xa;    ELSIF:ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;        --O centro de custo deve ser informado.&#xa;        MENSAGEM_PADRAO(292,&apos;&apos;);&#xa;        GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_NEGOCIO&apos;);&#xa;    ELSE&#xa;      IF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) &lt; 100 THEN&#xa;         NEXT_RECORD;&#xa;         --GDG:01/08/2011:28715&#xa;         IF GET_ITEM_PROPERTY(&apos;ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST&apos;, VISUAL_ATTRIBUTE) = &apos;VSA_CAMPOTEXTO&apos; THEN&#xa;           GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST&apos;);&#xa;         ELSE&#xa;           GO_ITEM(&apos;ITEMCOMPRANEGOCIO.CD_NEGOCIO&apos;);&#xa;         END IF;&#xa;      ELSIF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) = 100 THEN&#xa;        GO_ITEM(&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;);&#xa;      END IF;    &#xa;    END IF;     &#xa;  ELSE            &#xa;    RETURN;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="BEGIN  &#xa;  IF (ERROR_TYPE = &apos;FRM&apos;) AND (ERROR_CODE = 40209) THEN&#xa;    MENSAGEM(&apos;&apos;,&apos;Os caracteres v&#xe1;lidos s&#xe3;o 0-9 - e +.&apos;,4);&#xa;  ELSE&#xa;    VALIDA_ERROS;&#xa;  END IF;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="Complemento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="BTN_OK: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="@">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779086" FOLDED="true" MODIFIED="1607991779086" TEXT="body">
<node CREATED="1607991779086" MODIFIED="1607991779086" TEXT="DECLARE&#xa;  E_GERAL       EXCEPTION;&#xa;  E_ALERTA      EXCEPTION;&#xa;  V_MENSAGEM     VARCHAR2(32000);&#xa;  V_ST_EXIBEMSG  BOOLEAN DEFAULT FALSE;--MGK:61460:30/07/2013&#xa;  &#xa;BEGIN&#xa;  --GDG:01/08/2011:28715&#xa;  VALIDATE(ITEM_SCOPE);&#xa;  IF FORM_SUCCESS THEN&#xa;    VALIDATE(RECORD_SCOPE);&#xa;    IF NOT FORM_SUCCESS THEN&#xa;      RETURN;&#xa;    END IF;&#xa;  ELSE&#xa;    RETURN;&#xa;  END IF;&#xa;  &#xa;  IF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) = 100 THEN&#xa;    IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL AND :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#xa;       DELETE_RECORD;&#xa;    END IF;&#xa;    --------------------------------------------------------------------&#xa;    --VERIFICA SE A MOVIMENTA&#xc7;&#xc3;O E O CENTRO DE CUSTO EST&#xc3;O PREENCHIDOS--&#xa;    --------------------------------------------------------------------&#xa;    FIRST_RECORD;&#xa;    LOOP &#xa;      IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL OR :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#xa;        SET_ITEM_PROPERTY (&apos;ITEMCOMPRANEGOCIO.BTN_OK&apos;,ENABLED,PROPERTY_FALSE);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;      IF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NULL) THEN&#xa;        V_ST_EXIBEMSG := TRUE;&#xa;      END IF;&#xa;      &#xa;      EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;      NEXT_RECORD;&#xa;    END LOOP;&#xa;    &#xa;    &#xa;    VALIDA_DUPLICADOS_NEGOCIO(V_MENSAGEM);&#xa;    &#xa;    IF V_MENSAGEM IS NOT NULL THEN&#xa;      MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;    &#xa;    ADICIONA_GRUPO_NEGOCIO;&#xa;    GO_ITEM(&apos;ITEMCOMPRA.DS_OBSERVACAO&apos;);&#xa;  ELSE&#xa;     --A soma do percentual de participa&#xe7;&#xe3;o dos centros de custos deve ser igual a 100%.&#xa;     MENSAGEM_PADRAO(4740,&apos;&apos;);     &#xa;    GO_ITEM(&apos;ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL&apos;);&#xa;  END IF;&#xa;  &#xa;  --MGK:61460:30/07/2013&#xa;  /*IF (V_ST_EXIBEMSG) THEN&#xa;    V_ALERT := SHOW_ALERT(&apos;ALR_QTDENULA&apos;);&#xa;    IF (V_ALERT = ALERT_BUTTON1) THEN&#xa;      NULL;&#xa;    ELSIF (V_ALERT = ALERT_BUTTON2) THEN &#xa;      GO_BLOCK(&apos;ITEMCOMPRANEGOCIO&apos;);&#xa;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20836, NULL);&#xa;      RAISE E_ALERTA;&#xa;    ELSE&#xa;      NULL;&#xa;    END IF;&#xa;  END IF;*/&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_ALERTA THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN E_GERAL THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="BT_CANCELAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="BEGIN&#xa;  CLEAR_BLOCK (NO_VALIDATE);&#xa;  --:ITEMCOMPRA.QT_PREVISTA := 0;&#xa;  PACK_GRUPO_NEGOCIO.DELETA_GRUPO_NEGOCIO(:ITEMCOMPRANEGOCIO.CD_ITEM);&#xa;  GO_ITEM(&apos;ITEMCOMPRA.QT_PREVISTA&apos;);&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="QT_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Soma das Quantidades">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="PC_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Soma dos Percentuais de Participa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_CONTAORCAMENTO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@"/>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" ID="ID_243779421" MODIFIED="1607991779087" TEXT="PROJETOITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@"/>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="QT_PREVISTA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Quantidade Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Quantidade a Solicitar">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_ESTUDO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="DECLARE&#xa;  V_MENSAGEM     VARCHAR2(32000);&#xa;  E_GERAL        EXCEPTION; &#xa;BEGIN&#xa;  BEGIN&#xa;    SELECT PROJETOMONI.CD_PROJETO, &#xa;           ESTUDOMONI.NM_ESTUDO&#xa;      INTO :PROJETOITEMCOMPRA.CD_PROJETO, &#xa;           :PROJETOITEMCOMPRA.DS_PROJETO&#xa;      FROM PROJETOMONI, ESTUDOMONI&#xa;     WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#xa;       AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#xa;       AND PROJETOMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#xa;                                       FROM PROJETOMONI PROJ&#xa;                                      WHERE PROJETOMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#xa;                                        AND PROJETOMONI.CD_PROJETO = PROJ.CD_PROJETO);&#xa;&#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      NULL;&#xa;  END;&#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_PROJETO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_PROJETOMONI">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="DECLARE&#xa;  V_MENSAGEM     VARCHAR2(32000);&#xa;  E_GERAL        EXCEPTION; &#xa;BEGIN&#xa;  IF :PROJETOITEMCOMPRA.CD_PROJETO IS NOT NULL THEN&#xa;    BEGIN&#xa;      SELECT DISTINCT PROJETOMONI.CD_ESTUDO, &#xa;                      PROJETOMONI.CD_PROJETO, &#xa;                      PROJETOMONI.NR_VERSAO, &#xa;                      ESTUDOMONI.NM_ESTUDO&#xa;        INTO :PROJETOITEMCOMPRA.CD_ESTUDO, &#xa;             :PROJETOITEMCOMPRA.CD_PROJETO, &#xa;             :PROJETOITEMCOMPRA.NR_VERSAO, &#xa;             :PROJETOITEMCOMPRA.DS_PROJETO&#xa;        FROM PROJETOMONI,&#xa;             ESTUDOMONI,&#xa;             ORCAMENTOMONI,&#xa;             GRUPOMOVIMENTACAOMONI,&#xa;             MOVIMENTACAOGRUPOMONI&#xa;       WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#xa;         AND ORCAMENTOMONI.CD_ESTUDO = PROJETOMONI.CD_ESTUDO&#xa;         AND ORCAMENTOMONI.CD_PROJETO = PROJETOMONI.CD_PROJETO&#xa;         AND ORCAMENTOMONI.NR_VERSAO = PROJETOMONI.NR_VERSAO&#xa;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#xa;             GRUPOMOVIMENTACAOMONI.CD_GRUPOMOVIMENTACAO&#xa;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#xa;             MOVIMENTACAOGRUPOMONI.CD_GRUPOMOVIMENTACAO&#xa;         AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;         AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#xa;         AND PROJETOMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#xa;                                         FROM PROJETOMONI PROJ&#xa;                                        WHERE PROJETOMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#xa;                                          AND PROJETOMONI.CD_PROJETO = PROJ.CD_PROJETO);&#xa;  &#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32294, &apos;&#xa2;CD_PROJETO=&apos;||:PROJETOITEMCOMPRA.CD_PROJETO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32295, &apos;&#xa2;CD_PROJETO=&apos;||:PROJETOITEMCOMPRA.CD_PROJETO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;  ELSE&#xa;    :PROJETOITEMCOMPRA.DS_PROJETO := NULL;&#xa;  END IF;&#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_VERSAO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="DECLARE&#xa;  V_MENSAGEM     VARCHAR2(32000);&#xa;  E_GERAL        EXCEPTION; &#xa;BEGIN&#xa;  BEGIN&#xa;    SELECT PROJETOMONI.CD_PROJETO, &#xa;           ESTUDOMONI.NM_ESTUDO&#xa;      INTO :PROJETOITEMCOMPRA.CD_PROJETO, &#xa;           :PROJETOITEMCOMPRA.DS_PROJETO&#xa;      FROM PROJETOMONI, ESTUDOMONI&#xa;     WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#xa;       AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#xa;       AND PROJETOMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#xa;                                       FROM PROJETOMONI PROJ&#xa;                                      WHERE PROJETOMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#xa;                                        AND PROJETOMONI.CD_PROJETO = PROJ.CD_PROJETO);&#xa;&#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      NULL;&#xa;  END;&#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_PROJETO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_ETAPA: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Etapa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_ETAPAMONI">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="DECLARE&#xa;  V_MENSAGEM     VARCHAR2(32000);&#xa;  E_GERAL        EXCEPTION; &#xa;BEGIN&#xa;    &#xa;  IF :PROJETOITEMCOMPRA.CD_ETAPA IS NOT NULL THEN&#xa;    BEGIN&#xa;      SELECT ETAPAMONI.CD_ETAPA, &#xa;             ETAPAMONI.DS_ETAPA&#xa;        INTO :PROJETOITEMCOMPRA.CD_ETAPA,&#xa;             :PROJETOITEMCOMPRA.DS_ETAPA&#xa;        FROM ETAPAMONI,&#xa;             PROJETOMONI,&#xa;             ESTUDOMONI,&#xa;             ORCAMENTOMONI,&#xa;             GRUPOMOVIMENTACAOMONI,&#xa;             MOVIMENTACAOGRUPOMONI&#xa;       WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#xa;         AND ORCAMENTOMONI.CD_ESTUDO = PROJETOMONI.CD_ESTUDO&#xa;         AND ORCAMENTOMONI.CD_PROJETO = PROJETOMONI.CD_PROJETO&#xa;         AND ORCAMENTOMONI.NR_VERSAO = PROJETOMONI.NR_VERSAO&#xa;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#xa;             GRUPOMOVIMENTACAOMONI.CD_GRUPOMOVIMENTACAO&#xa;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#xa;             MOVIMENTACAOGRUPOMONI.CD_GRUPOMOVIMENTACAO&#xa;         AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#xa;         AND PROJETOMONI.CD_ESTUDO = ETAPAMONI.CD_ESTUDO&#xa;         AND PROJETOMONI.CD_PROJETO = ETAPAMONI.CD_PROJETO&#xa;         AND PROJETOMONI.NR_VERSAO = ETAPAMONI.NR_VERSAO&#xa;         AND ETAPAMONI.CD_ETAPA = ORCAMENTOMONI.CD_ETAPA&#xa;         AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#xa;         AND ETAPAMONI.CD_ETAPA = :PROJETOITEMCOMPRA.CD_ETAPA&#xa;         AND ETAPAMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#xa;                                       FROM PROJETOMONI PROJ&#xa;                                      WHERE ETAPAMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#xa;                                        AND ETAPAMONI.CD_PROJETO = PROJ.CD_PROJETO);&#xa;    EXCEPTION&#xa;      WHEN NO_DATA_FOUND THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32296, &apos;&#xa2;CD_ETAPA=&apos;||:PROJETOITEMCOMPRA.CD_ETAPA||&apos;&#xa2;CD_PROJETO=&apos;||:PROJETOITEMCOMPRA.CD_PROJETO||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;      WHEN OTHERS THEN&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32297, &apos;&#xa2;CD_ETAPA=&apos;||:PROJETOITEMCOMPRA.CD_ETAPA||&apos;&#xa2;CD_PROJETO=&apos;||:PROJETOITEMCOMPRA.CD_PROJETO||&apos;&#xa2;SQLERRM=&apos;||SQLERRM||&apos;&#xa2;&apos;);&#xa;        RAISE E_GERAL;&#xa;    END;&#xa;  ELSE&#xa;    :PROJETOITEMCOMPRA.DS_ETAPA := NULL;&#xa;  END IF;&#xa;  &#xa;EXCEPTION  &#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys COM001 - Erro&apos;,SQLERRM,1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_ETAPA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o da Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="BTN_OK: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="DECLARE&#xa;  E_GERAL       EXCEPTION;&#xa;  E_ALERTA      EXCEPTION;&#xa;  V_MENSAGEM     VARCHAR2(32000);&#xa;  &#xa;BEGIN&#xa;  --GDG:01/08/2011:28715&#xa;  VALIDATE(ITEM_SCOPE);&#xa;  IF FORM_SUCCESS THEN&#xa;    VALIDATE(RECORD_SCOPE);&#xa;    IF NOT FORM_SUCCESS THEN&#xa;      RETURN;&#xa;    END IF;&#xa;  ELSE&#xa;    RETURN;&#xa;  END IF;&#xa;  &#xa;  IF :PROJETOITEMCOMPRA.CD_PROJETO IS NOT NULL AND :PROJETOITEMCOMPRA.CD_ETAPA IS NOT NULL THEN&#xa;    :ITEMCOMPRA.CD_ESTUDOMONI := :PROJETOITEMCOMPRA.CD_ESTUDO;&#xa;    :ITEMCOMPRA.CD_PROJETOMONI := :PROJETOITEMCOMPRA.CD_PROJETO;&#xa;    :ITEMCOMPRA.NR_VERSAOMONI := :PROJETOITEMCOMPRA.NR_VERSAO;&#xa;    :ITEMCOMPRA.CD_ETAPAMONI   := :PROJETOITEMCOMPRA.CD_ETAPA;&#xa;  END IF;&#xa;  :ITEMCOMPRA.ST_PROJETOMONI := &apos;S&apos;;&#xa;  GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;  EXECUTE_TRIGGER(&apos;KEY-COMMIT&apos;);&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_ALERTA THEN&#xa;    MENSAGEM(&apos;Maxys&apos;,V_MENSAGEM,2);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN E_GERAL THEN&#xa;    NULL;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="BT_CANCELAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="BEGIN&#xa;  CLEAR_BLOCK (NO_VALIDATE);&#xa;  --:ITEMCOMPRA.QT_PREVISTA := 0;&#xa;  GO_ITEM(&apos;ITEMCOMPRA.QT_PREVISTA&apos;);&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" ID="ID_1743196949" MODIFIED="1607991779087" TEXT="PREITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="ST_MARCADO: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="hint">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="tooltip">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="defaultValue">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="0">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_ITEMCOMPRA: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Item Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_PREITEMCOMPRA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_ITEMAXYS: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;d. Item &#xa;Maxys">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_ITEMPRECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT=":PREITEMCOMPRA.DS_ITEMAXYS := PACK_VALIDATE.RETORNA_DS_ITEM(I_CD_ITEM =&gt; :PREITEMCOMPRA.CD_ITEMAXYS);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="QT_ITEM: Number(15)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_OBSERVACAO: Char(600)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Observa&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_AGRUPAMENTO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Lote Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_ITEMAXYS: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o Item Maxys">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="valuesListName">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_ITEMPRECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="QT_SELECIONADOS: Number()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@"/>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="label">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="BT_CONFIRMAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="DECLARE&#xa;  TYPE R_PREITEMCOMPRA IS RECORD (NR_PREITEMCOMPRA PREITEMCOMPRA.NR_PREITEMCOMPRA%TYPE,&#xa;                                  CD_ITEM          PREITEMCOMPRA.CD_ITEM%TYPE,&#xa;                                  QT_ITEM          PREITEMCOMPRA.QT_ITEM%TYPE);&#xa;  &#xa;  TYPE T_PREITEMCOMPRA IS TABLE OF R_PREITEMCOMPRA INDEX BY BINARY_INTEGER;&#xa;  &#xa;  V_PREITEMCOMPRA  T_PREITEMCOMPRA;&#xa;  V_MENSAGEM       VARCHAR2(32000);&#xa;  E_GERAL           EXCEPTION;&#xa;  V                NUMBER;&#xa;  V_DT_DESEJADA     PREITEMCOMPRA.DT_DESEJADA%TYPE;&#xa;BEGIN&#xa;  IF NVL(:PREITEMCOMPRA.QT_SELECIONADOS, 0) = 0 THEN&#xa;    /*Deve ser selecionado ao menos um item.*/&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34157, NULL);&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;&#xa;  IF (SHOW_ALERT(&apos;CONFIRMA_PREITEMCOMPRA&apos;) &lt;&gt; ALERT_BUTTON1) THEN&#xa;    /*Processo abortado pelo usu&#xe1;rio.*/&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20773, NULL);&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;  &#xa;  V_PREITEMCOMPRA.DELETE;&#xa;  V := 1;&#xa;&#xa;  GO_BLOCK(&apos;PREITEMCOMPRA&apos;);&#xa;  FIRST_RECORD;&#xa;  &#xa;  LOOP&#xa;    IF (:PREITEMCOMPRA.ST_MARCADO = 1) THEN    &#xa;      IF (:PREITEMCOMPRA.CD_ITEMAXYS IS NULL) THEN&#xa;        /*O Item deve ser informado.*/&#xa;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2624, NULL);&#xa;        RAISE E_GERAL;&#xa;      END IF;&#xa;      &#xa;      V_PREITEMCOMPRA(V).NR_PREITEMCOMPRA := :PREITEMCOMPRA.NR_ITEMCOMPRA;&#xa;      V_PREITEMCOMPRA(V).CD_ITEM          := :PREITEMCOMPRA.CD_ITEMAXYS;&#xa;      V_PREITEMCOMPRA(V).QT_ITEM          := :PREITEMCOMPRA.QT_ITEM;&#xa;  &#xa;      IF ((V_DT_DESEJADA IS NULL) OR (V_DT_DESEJADA &gt; :PREITEMCOMPRA.DT_DESEJADA)) THEN&#xa;        V_DT_DESEJADA := :PREITEMCOMPRA.DT_DESEJADA;&#xa;      END IF;&#xa;    END IF;&#xa;    EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;    &#xa;    IF (:PREITEMCOMPRA.ST_MARCADO = 1) THEN&#xa;      V := V + 1;&#xa;    END IF;&#xa;&#xa;    NEXT_RECORD;&#xa;  END LOOP;&#xa;&#xa;  :CONTROLE.DT_DESEJADA := V_DT_DESEJADA;&#xa;  :CONTROLE.CD_EMPRESA := :GLOBAL.CD_EMPRESA;&#xa;&#xa;  GO_BLOCK(&apos;ITEMCOMPRA&apos;);&#xa;  FIRST_RECORD;&#xa;  &#xa;  FOR I IN 1..V_PREITEMCOMPRA.COUNT LOOP&#xa;    :ITEMCOMPRA.NR_PREITEMCOMPRA := V_PREITEMCOMPRA(I).NR_PREITEMCOMPRA;&#xa;    :ITEMCOMPRA.CD_ITEM          := V_PREITEMCOMPRA(I).CD_ITEM;&#xa;    :ITEMCOMPRA.QT_PREVISTA       := V_PREITEMCOMPRA(I).QT_ITEM;&#xa;    &#xa;    NEXT_RECORD;&#xa;  END LOOP;&#xa;  &#xa;  FIRST_RECORD;&#xa;&#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||&apos; - Erro&apos;, V_MENSAGEM, 1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||&apos; - Erro&apos;, SQLERRM, 1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="BT_FECHAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="GO_ITEM(&apos;CONTROLE.CD_EMPRESA&apos;);"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="ITEM189: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="trigger">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="body">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="DECLARE&#xa;  V_MENSAGEM             VARCHAR2(32000);&#xa;  E_GERAL                 EXCEPTION;&#xa;  V_COUNTITEMCOMPRA       NUMBER;&#xa;BEGIN&#xa;  IF NVL(:PREITEMCOMPRA.QT_SELECIONADOS, 0) = 0 THEN&#xa;    /*Deve ser selecionado ao menos um item.*/&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34157, NULL);&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;&#xa;  IF (SHOW_ALERT(&apos;CANCELA_PREITEMCOMPRA&apos;) &lt;&gt; ALERT_BUTTON1) THEN&#xa;    /*Processo abortado pelo usu&#xe1;rio.*/&#xa;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20773, NULL);&#xa;    RAISE E_GERAL;&#xa;  END IF;&#xa;&#xa;  GO_BLOCK(&apos;PREITEMCOMPRA&apos;);&#xa;  FIRST_RECORD;&#xa;  &#xa;  LOOP&#xa;    IF (:PREITEMCOMPRA.ST_MARCADO = 1) THEN&#xa;      BEGIN&#xa;      UPDATE PREITEMCOMPRA&#xa;         SET PREITEMCOMPRA.ST_PREITEMCOMPRA = &apos;9&apos;&#xa;       WHERE PREITEMCOMPRA.NR_PREITEMCOMPRA = :PREITEMCOMPRA.NR_ITEMCOMPRA;&#xa;      EXCEPTION&#xa;        WHEN OTHERS THEN&#xa;          NULL;&#xa;      END;&#xa;      &#xa;    END IF;&#xa;&#xa;    EXIT WHEN :SYSTEM.LAST_RECORD = &apos;TRUE&apos;;&#xa;    NEXT_RECORD;&#xa;  END LOOP;&#xa;&#xa;  FAZ_COMMIT;&#xa;  &#xa;  /*Solicita&#xe7;&#xf5;es de compra Canceladas.*/&#xa;  MENSAGEM_PADRAO(34180, NULL);&#xa;  &#xa;  BEGIN&#xa;    SELECT COUNT(*)&#xa;      INTO V_COUNTITEMCOMPRA&#xa;      FROM PREITEMCOMPRA&#xa;     WHERE PREITEMCOMPRA.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#xa;       AND PREITEMCOMPRA.ST_PREITEMCOMPRA = &apos;1&apos;;    &#xa;  EXCEPTION&#xa;    WHEN OTHERS THEN&#xa;      V_COUNTITEMCOMPRA := 0;&#xa;  END;&#xa;&#xa;  IF (V_COUNTITEMCOMPRA &gt; 0) THEN    &#xa;    PACK_PREITEMCOMPRA.CARREGA_PREITEMCOMPRA(V_MENSAGEM);&#xa;&#xa;    IF (V_MENSAGEM IS NOT NULL) THEN&#xa;      RAISE E_GERAL;&#xa;    END IF;&#xa;  ELSE&#xa;    CLEAR_BLOCK(NO_VALIDATE);&#xa;    GO_ITEM(&apos;CONTROLE.CD_EMPRESA&apos;);&#xa;  END IF;&#xa;  &#xa;EXCEPTION&#xa;  WHEN E_GERAL THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||&apos; - Erro&apos;, V_MENSAGEM, 1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;  WHEN OTHERS THEN&#xa;    MENSAGEM(&apos;Maxys &apos;||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||&apos; - Erro&apos;, SQLERRM, 1);&#xa;    RAISE FORM_TRIGGER_FAILURE;&#xa;END;"/>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" ID="ID_1322591213" MODIFIED="1607991779087" POSITION="right" TEXT="list of values">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_LOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Local Armazenagem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_TIPOLOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@"/>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_LOCALARMAZ: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ1: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ2: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ3: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 3">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ4: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 4">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_LOCALUSUARIO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_LOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Local Armazenagem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_TIPOLOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@"/>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_LOCALARMAZ: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ1: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ2: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ3: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 3">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_SUBLOCARMAZ4: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Sub 4">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_DEPCOMPRAAUTO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_DEPARTAMENTO: Button(675)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_DEPARTAMENTO: Button(45)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_ETAPAMONI">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_ETAPA: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Etapa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_ETAPA: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_PROJETOMONI">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NM_ESTUDO: Button(300)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_ESTUDO: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Estudo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_PROJETO: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NR_VERSAO: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Vers&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_EMPRCCUSTODEST">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NM_EMPRESA: Button(400)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Nome">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_EMPRESA: Button(50)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_EMPRESANEGOCIO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NM_EMPRESA: Button(400)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Nome">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_EMPRESA: Button(50)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_NEGOCIO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_NEGOCIO: Button(350)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_NEGOCIO: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_SOLICAUTORIZ_DEPTO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="NM_USUARIO: Button(350)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_USUARIO: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_NEGOCIORATEIO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_NEGOCIO: Button(350)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_NEGOCIO: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_MOVIMENTACAO: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_MOVIMENTACAO: Button(67)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_TIPOCOMPRA: Button(200)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="CD_TIPOCOMPRA: Button(35)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="LOV_MOVIMENTACAO1">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779087" FOLDED="true" MODIFIED="1607991779087" TEXT="DS_MOVIMENTACAO: Button(549)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="@">
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779087" MODIFIED="1607991779087" TEXT="Ds_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_MOVIMENTACAO: Button(54)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Cd_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_MOVIMENTACAO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_MOVIMENTACAO: Button(549)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Ds_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_MOVIMENTACAO: Button(54)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Cd_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_ITEMCOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_ITEM: Button(549)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Ds_Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_ITEM: Button(81)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Cd_Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NR_ITEMCOMPRA: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Nr_Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NR_LOTECOMPRA: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Nr_Lotecompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="ICRGGQ_0: Button(144)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Icrggq_0">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_GRUPOCC">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NR_REGISTRO: Button(54)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Registro">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_CENTROCUSTO: Button(1000)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Centrocusto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="PROFILE">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_PROGRAMA: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@"/>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="ICRGGQ_0: Button(198)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@"/>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_EMPRESA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_EMPRESA: Button(35)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_EMPRESA: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_EMPRESA2">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_EMPRESA: Button(35)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_EMPRESA: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_COMPRAS">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_EMPRESA: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NR_ITEMCOMPRA: Button(49)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Solicita&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="QT_PREVISTA: Button(53)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Qtde Prev.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NR_LOTECOMPRA: Button(24)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Lote">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_SOLICITANTE: Button(48)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_SOLICITANTE: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@"/>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_AUTORIZADOR: Button(55)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_AUTORIZADOR: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@"/>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DT_SOLICITACAO: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Data de Solicita&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_ITEM">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_ITEM: Button(227)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_ITEM: Button(45)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="ICRGGQ_0: Button(114)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Tipo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_EMPRESA: Button(36)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_USUARIO: Button(350)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_USUARIO: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_AUTORIZADOR">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_USUARIO: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Nome">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_USUARIO: Button(67)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_PARMOVIMENT">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_MOVIMENTACAO: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_MOVIMENTACAO: Button(67)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_PARMOVIMENTVERSAO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_MOVIMENTACAO: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_MOVIMENTACAO: Button(67)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_CENTROCUSTO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_CENTROCUSTO: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_CENTROCUSTO: Button(67)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_CENTROCUSTOUSUARIO">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_CENTROCUSTO: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_CENTROCUSTO: Button(67)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_DEPARTAMENTOCOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_DEPARTAMENTO: Button(675)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_DEPARTAMENTO: Button(45)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_LOTECOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_EMPRESA: Button(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NR_LOTECOMPRA: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DT_SOLICITACAO: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Data de Solicita&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_SOLICITANTE: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_SOLICITANTE: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@"/>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_AUTORIZADOR: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_AUTORIZADOR: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@"/>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_CONTAORC">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_CONTAORCAMENTO: Button(85)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Cod. Cta Orc.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_CONTAORCAMENTO: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_CONTACONTABIL: Button(85)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Cod. Cta Cont.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NM_CONTACONTABIL: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_ITEMPARMOV">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_MOVIMENTACAO: Button(450)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Movimenta&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_MOVIMENTACAO: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_ANOSAFRA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_ANOSAFRA: Button(200)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="NR_SEQUENCIAL: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Nr. Sequencial">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DT_ANOSAFRA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Ano Safra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DT_INISAFRA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Data In&#xed;cio">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DT_FIMSAFRA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Data Final">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_EMPRESA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="LOV_ITEMPRECOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="DS_ITEM: Button(600)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="Descri&#xe7;&#xe3;o">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node CREATED="1607991779088" FOLDED="true" MODIFIED="1607991779088" TEXT="CD_ITEM: Button(72)">
<icon BUILTIN="Mapping.unmapped"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="@">
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="title">
<icon BUILTIN="element"/>
<node CREATED="1607991779088" MODIFIED="1607991779088" TEXT="C&#xf3;digo">
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
