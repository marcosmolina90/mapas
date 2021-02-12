<map version="1.0.1">
<node TEXT="com001">
<icon BUILTIN="Package"/>
<node TEXT="COM001">
<icon BUILTIN="Descriptor.window.editor"/>
<node TEXT="Trigger">
<icon BUILTIN="Descriptor.grouping"/>
<node TEXT="WHEN-NEW-FORM-INSTANCE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;--  I_CD_EMPRESA       USUARIOEMPRESA.CD_EMPRESA%TYPE;&#10;  I_ST_SOLICITANTE   SOLICITANTE.ST_SOLICITANTE%TYPE;&#10; --  V_ST_LANCAMOV      PARMCOMPRA.ST_LANCAMOV%TYPE;&#10;  I_MENSAGEM         VARCHAR2(2000);&#10;  V_MENSAGEM         VARCHAR2(2000);&#10;  V_CD_USUARIO       USUARIO.CD_USUARIO%TYPE;&#10;  E_GERAL            EXCEPTION;&#10;  X                  NUMBER;&#10;  Y                  NUMBER;&#10;  V_ST_VALIDACCUSTO  VARCHAR2(32000);&#10;  V_ST_INCLUI        BOOLEAN;&#10;  V_ST_ALTERA        BOOLEAN;&#10;  V_ST_EXCLUI        BOOLEAN;&#10;  V_VL_PARAMETRO     VARCHAR2(10);&#10;  V_ST_APROVSOLIC    VARCHAR2(1);&#10;  V_ST_ALCADASDEPTO  VARCHAR2(1);  &#10;  V_COUNTITEMCOMPRA  NUMBER; /*MHU:05/05/2020:135245*/&#10;  BEGIN&#10;  &#10;  :GLOBAL.CD_PROGRAMA := 'COM'; &#10;  :GLOBAL.CD_MODULO := 1;&#10;  SET_WINDOW_PROPERTY(FORMS_MDI_WINDOW,WINDOW_STATE,MAXIMIZE);&#10;  SET_WINDOW_PROPERTY(FORMS_MDI_WINDOW,TITLE,'MAXYS - SISTEMA DE GESTÃO CORPORATIVA                                                                                  MAXICON SYSTEMS');&#10;  SET_WINDOW_PROPERTY('WIN_ITEMCOMPRA',WINDOW_STATE,NORMAL);&#10;  SET_WINDOW_PROPERTY('WIN_ITEMCOMPRA',POSITION,0,1);&#10;  SET_WINDOW_PROPERTY('WIN_ITEMCOMPRA',WINDOW_SIZE,1012,562);&#10;  SET_WINDOW_PROPERTY('WIN_ITEMCOMPRA',TITLE,:SYSTEM.CURRENT_FORM||' - '||:GLOBAL.DS_PROGRAMA||'                                                   '||:GLOBAL.CD_EMPRESA||'   '||:GLOBAL.CD_USUARIO||' - '||:GLOBAL.NM_USUARIO);&#10;&#10;  X := TRUNC(GET_WINDOW_PROPERTY('WIN_ITEMCOMPRA',WIDTH)/2) - TRUNC(GET_WINDOW_PROPERTY('WIN_SEL',WIDTH) / 2);&#10;  Y := TRUNC(GET_WINDOW_PROPERTY('WIN_ITEMCOMPRA',HEIGHT)/2) - TRUNC(GET_WINDOW_PROPERTY('WIN_SEL',HEIGHT) / 2);&#10;  Y := Y - TRUNC(Y * 0.30);&#10;  SET_WINDOW_PROPERTY('WIN_SEL',POSITION,X,Y);&#10;  &#10;  SET_MENU_ITEM_PROPERTY('TOOLBAR.GRAVA',ENABLED,PROPERTY_FALSE);&#10;  SET_MENU_ITEM_PROPERTY('TOOLBAR.NOVO',ENABLED,PROPERTY_FALSE);&#10;  SET_MENU_ITEM_PROPERTY('TOOLBAR.EXCLUI',ENABLED,PROPERTY_FALSE);&#10;  &#10;  /** WLV:13/08/2012:41514&#10;    * Trecho de código para desabilitar o campo DS_ITEMSERVICO quando é inicializado o programa&#10;    */   &#10;  MANIPULA_CAMPO('ITEMCOMPRA.DS_ITEMSERVICO','D');&#10;    &#10;  /*SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO' ,ENABLED,PROPERTY_FALSE);&#10;  SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO' ,REQUIRED,PROPERTY_FALSE);&#10;  SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;  SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',PROMPT_FONT_STYLE,FONT_PLAIN);*/&#10;  &#10;  :GLOBAL.CD_PROGRAMA := 1;&#10;  :GLOBAL.CD_MODULO   := 'COM';&#10;  &#10;  V_ST_INCLUI := PACK_VALIDA.VAL_PERMISSAO('I',:GLOBAL.CD_USUARIO,:GLOBAL.CD_EMPRESA,:GLOBAL.CD_MODULO,:GLOBAL.CD_PROGRAMA);&#10;  V_ST_ALTERA := PACK_VALIDA.VAL_PERMISSAO('A',:GLOBAL.CD_USUARIO,:GLOBAL.CD_EMPRESA,:GLOBAL.CD_MODULO,:GLOBAL.CD_PROGRAMA);&#10;  V_ST_EXCLUI := PACK_VALIDA.VAL_PERMISSAO('E',:GLOBAL.CD_USUARIO,:GLOBAL.CD_EMPRESA,:GLOBAL.CD_MODULO,:GLOBAL.CD_PROGRAMA);&#10;  &#10;  IF (V_ST_ALTERA OR V_ST_INCLUI OR V_ST_EXCLUI) THEN  &#10;    IF (V_ST_ALTERA OR V_ST_INCLUI) THEN&#10;      SET_MENU_ITEM_PROPERTY('TOOLBAR.GRAVA',ENABLED,PROPERTY_TRUE);&#10;    END IF;&#10;    IF (V_ST_INCLUI) THEN&#10;      SET_MENU_ITEM_PROPERTY('TOOLBAR.NOVO',ENABLED,PROPERTY_TRUE);&#10;    END IF;&#10;    IF (V_ST_EXCLUI) THEN&#10;      SET_MENU_ITEM_PROPERTY('TOOLBAR.EXCLUI',ENABLED,PROPERTY_TRUE);&#10;    END IF;  &#10;  END IF;&#10;  ------------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------------&#10;  SET_MENU_ITEM_PROPERTY('TOOLBAR.IMPRIME',ENABLED,PROPERTY_FALSE);&#10;  SET_MENU_ITEM_PROPERTY('TOOLBAR.PESQUISA',ENABLED,PROPERTY_FALSE);  &#10;  SET_MENU_ITEM_PROPERTY('TOOLBAR.CONSULTA',ENABLED,PROPERTY_FALSE);&#10;    &#10;    PACK_PROCEDIMENTOS.V_DUPLICADO := FALSE; /*ATR:80785:11/02/2015*/&#10;    &#10;    -------------------------------------------------------&#10;    -- SELECIONA O TIPO DE APROVADOR SE SOLICITACAO (S/N)--&#10;    -------------------------------------------------------&#10;    BEGIN&#10;      SELECT ST_APROVSOLIC, TP_APROVSOLIC, NVL(ST_VALIDACCUSTO,'N')&#10;        INTO PACK_GLOBAL.ST_APROVSOLIC, PACK_GLOBAL.TP_APROVSOLIC, PACK_GLOBAL.ST_VALIDACCUSTO&#10;        FROM PARMCOMPRA&#10;       WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --Os parâmetros de compras não estão cadastrados no COM009.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3470,'');&#10;        RAISE E_GERAL;&#10;    END;&#10;    /**GRA:26/09/2007:17137&#10;     * Está sendo atribuido o valor da PACK_GLOBAL.TP_SELECAOCONTA&#10;     * para o próprio campo.&#10;     */    &#10;     &#10;     /* CSL:24771:26/02/10 - Mensagem alterada para referenciar campo &#34;Filtro de seleção de Conta&#34; no programa REC010, page Geral*/&#10;     -- VERIFICA A OPÇÃO &#34;FILTRO DE SELEÇÃO DE CONTA&#34; NA PAGE GERAL DO REC010&#10;    BEGIN&#10;      SELECT TP_SELECAOCONTA&#10;        INTO PACK_GLOBAL.TP_SELECAOCONTA&#10;        FROM PARMRECEB&#10;       WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --Parâmetros de conta por item não cadastrados para a Empresa ¢CD_EMPRESA¢! Verifique o programa REC010, page Geral e campo &#34;Filtro de seleção de conta&#34;.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4681,'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;    -------------------------------------------------------------------&#10;    -------------------------------------------------------------------&#10;    BEGIN&#10;      SELECT CD_TIPOPEDIDO &#10;        INTO PACK_GLOBAL.TP_PEDIDO&#10;        FROM TIPOPEDPROGRAMA&#10;       WHERE CD_MODULO   = 'COM'&#10;         AND CD_PROGRAMA =  4;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --Tipo de Pedido não cadastrado para o Programa ¢CD_MODULO¢¢CD_PROGRAMA¢. Verifique ANV008.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(422,'¢CD_MODULO='||'COM'||'¢CD_PROGRAMA='||'4'||'¢');&#10;        RAISE E_GERAL;&#10;      --PHS:52886:21/12/2012  &#10;      WHEN TOO_MANY_ROWS THEN&#10;        --Tipo de Pedido cadastrado Várias Vezes para o Programa ¢CD_MODULO¢¢CD_PROGRAMA¢. Verifique ANV008.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(423,'¢CD_MODULO='||'COM'||'¢CD_PROGRAMA='||'4'||'¢'); &#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        --Erro ao pesquisar tipo de pedido para o Programa ¢CD_MODULO¢¢CD_PROGRAMA¢. Verifique ANV008. Erro: ¢SQLERRM¢.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(918,'¢CD_MODULO='||'COM'||'¢CD_PROGRAMA='||'4'||'¢SQLERRM='||SQLERRM||'¢'); &#10;        RAISE E_GERAL;  &#10;    END;&#10;    -------------------------------------------------------------------&#10;    -------------------------------------------------------------------&#10;    --HUS:31/05/2012:40331&#10;    BEGIN&#10;      SELECT DISTINCT SOLICITANTE.ST_SOLICITANTE &#10;        INTO I_ST_SOLICITANTE&#10;        FROM SOLICITANTE&#10;       WHERE SOLICITANTE.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#10;         AND SOLICITANTE.CD_USUARIO = :GLOBAL.CD_USUARIO&#10;         AND SOLICITANTE.ST_SOLICITANTE = 'S'; &#10;         &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        I_ST_SOLICITANTE := 'R';&#10;    END;&#10;    &#10;    IF I_ST_SOLICITANTE = 'R' THEN&#10;      --Usuário ¢CD_SOLICITANTE¢ não cadastrado como solicitante para a empresa ¢CD_EMPRESA¢. Verifique TCO002.&#10;      I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4517,'¢CD_SOLICITANTE='||:GLOBAL.CD_USUARIO||'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;      RAISE E_GERAL;&#10;    ELSIF (I_ST_SOLICITANTE = 'T') OR (I_ST_SOLICITANTE = 'S') THEN&#10;      IF :GLOBAL.NR_ITEMCOMPRA IS NOT NULL AND :GLOBAL.V_CD_EMPRESA IS NOT NULL THEN&#10;        SET_BLOCK_PROPERTY('ITEMCOMPRA', DEFAULT_WHERE, 'NR_ITEMCOMPRA = '||:GLOBAL.NR_ITEMCOMPRA||' AND CD_EMPRESA = '|| :GLOBAL.V_CD_EMPRESA);&#10;        EXECUTE_QUERY(NO_VALIDATE);&#10;      END IF;&#10;    END IF;&#10;    &#10;    PACK_GRUPO_NEGOCIO.CRIA_GRUPO_NEGOCIO;&#10;    --Cria o grupo de centro de custo &#10;    PACK_GRUPO.CRIA_GRUPO_CC;    &#10;    PACK_GRUPO.CRIA_GRUPO_LOVCC;&#10;    :GLOBAL.V_GRUPO_CC := NULL;&#10;    -----------------------------------------------------------------------------------------------------------&#10;    -----------------------------------------------------------------------------------------------------------&#10;    /**RSS:21/12/2007:17745&#10;     * VERIFICA A OPÇÃO SELECIONADA NA PAGE VALIDAÇÃO DO COM009 &#34;VALIDA AUTORIZADOR&#34;...&#10;     */&#10;    BEGIN&#10;      SELECT NVL(ST_VALIDACCUSTO,'N')&#10;        INTO V_ST_VALIDACCUSTO &#10;        FROM PARMCOMPRA&#10;       WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN &#10;        NULL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;        V_ST_VALIDACCUSTO := NULL;&#10;      WHEN OTHERS THEN&#10;        NULL;&#10;    END;&#10;    /**RSS:21/12/2007:17745&#10;     * APARTIR DO TIPO DE AUTORIZADOR, SERÁ DESABILITADO OU NAO O AUTORIZADOR DO CENTRO DE CUSTO..&#10;     */&#10;    IF V_ST_VALIDACCUSTO = 'S' THEN&#10;      SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_AUTORIZADOR',ENABLED,PROPERTY_FALSE);&#10;    ELSE&#10;      SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_AUTORIZADOR',ENABLED,PROPERTY_TRUE);&#10;    END IF;&#10;    /*ATR:115974:26/12/2017*/&#10;    &#10;    IF PACK_GLOBAL.ST_APROVSOLIC = 'S' AND NVL(PACK_GLOBAL.ST_VALIDACCUSTO,'N') IN ('C','A') &#10;      AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;      SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_AUTORIZADOR',PROMPT_FONT_STYLE,FONT_UNDERLINE);&#10;    ELSE&#10;      SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_AUTORIZADOR',PROMPT_FONT_STYLE,FONT_PLAIN);&#10;    END IF;&#10;&#10;    /** ALE:25/11/2011:36255&#10;     *  O Campo número do contrato só poderá ficar habilitado quando for efetuado uma compra&#10;     *  do tipo &#34;Juridica&#34;. O tipo do tipo da compra é definido no TCO020.&#10;     */&#10;    :CONTROLE.NR_CONTRATO   := NULL;&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',           ENABLED, PROPERTY_FALSE);&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',        NAVIGABLE, PROPERTY_FALSE);      &#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO', VISUAL_ATTRIBUTE, 'VSA_CAMPOEXIBICAO');      &#10;      &#10;  -------------------------------------------------------------------------------------------------------------&#10;  -------------------------------------------------------------------------------------------------------------&#10;  &#10;  /** WLV:15/08/2012:41514&#10;    * Adicionado para que o programa verifique se no COM009 esta marcado o parâmetro &#34;obriga informar observação no&#10;    * cadastro de solicitações&#34; e caso o mesmo estiver marcado irá sublinhar o campo Observação.&#10;    */  &#10;  BEGIN&#10;    SELECT PARMGENERICO.VL_PARAMETRO&#10;      INTO V_VL_PARAMETRO&#10;      FROM PARMGENERICO&#10;     WHERE PARMGENERICO.CD_PROGRAMA = 9&#10;       AND PARMGENERICO.CD_MODULO   = 'COM'&#10;       AND CD_VERSAOPARMGEN = :GLOBAL.CD_EMPRESA&#10;       AND RETORNA_VALORSTRING(NM_PARAMETRO,1,'#') = 'ST_OBRIGAOBS';&#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      V_VL_PARAMETRO := NULL;&#10;    WHEN OTHERS THEN &#10;      V_VL_PARAMETRO := NULL;&#10;  END; &#10;  &#10;  IF NVL(V_VL_PARAMETRO, 'N') = 'S' THEN&#10;    SET_ITEM_PROPERTY('ITEMCOMPRA.DS_OBSERVACAO', PROMPT_FONT_STYLE, FONT_UNDERLINE);&#10;  ELSE&#10;    SET_ITEM_PROPERTY('ITEMCOMPRA.DS_OBSERVACAO', PROMPT_FONT_STYLE, FONT_NORMAL);&#10;  END IF;&#10;  &#10;  ----------------------------------------------------------------------&#10;   --verifica o Autorizador&#10;  -----------------------------------------------------------------------&#10;  BEGIN &#10;    SELECT ST_APROVSOLIC&#10;      INTO V_ST_APROVSOLIC&#10;      FROM PARMCOMPRA&#10;     WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      NULL;&#10;  END;      &#10;  V_ST_ALCADASDEPTO := NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_ALCADASDEPTO'),'N');&#10;  /*ATR:115974:26/12/2017*/&#10;  IF (NVL(V_ST_APROVSOLIC,'N') = 'S' OR NVL(V_ST_ALCADASDEPTO,'N') = 'S') &#10;    AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N'  THEN&#10;    SET_ITEM_PROPERTY('CONTROLE.CD_AUTORIZADOR', PROMPT_FONT_STYLE, FONT_UNDERLINE);&#10;  ELSE&#10;    SET_ITEM_PROPERTY('CONTROLE.CD_AUTORIZADOR',PROMPT_FONT_STYLE,FONT_PLAIN);&#10;  END IF;&#10;  &#10;  --Verifica o Departamento&#10;  IF V_ST_ALCADASDEPTO = 'S' AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_PERMITEAPROVADORES'),'N') = 'S' THEN&#10;    SET_ITEM_PROPERTY('CONTROLE.CD_DEPARTAMENTO', PROMPT_FONT_STYLE, FONT_UNDERLINE);&#10;    &#10;    --Sugere o Departamento de Compra, caso possuir apenas um cadastrado para o usuário solicitante logado&#10;    BEGIN       &#10;      SELECT SOLICDEPARTCOMPRA.CD_DEPARTAMENTO, DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;        INTO :CONTROLE.CD_DEPARTAMENTO, :CONTROLE.DS_DEPARTAMENTO&#10;        FROM SOLICDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;       WHERE SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#10;         AND SOLICDEPARTCOMPRA.CD_SOLICITANTE  = :GLOBAL.CD_USUARIO;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        SYNCHRONIZE;&#10;        --O Usuário ¢CD_SOLICITANTE¢ não está cadastrado como solicitante de Departamento de Compra. Verifique o TCO024.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21661, '¢CD_SOLICITANTE='||:GLOBAL.CD_USUARIO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        :CONTROLE.CD_DEPARTAMENTO := NULL;&#10;        :CONTROLE.DS_DEPARTAMENTO := NULL;&#10;    END;&#10;    &#10;    IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#10;      &#10;      BEGIN&#10;        SELECT USUARIO.CD_USUARIO&#10;          INTO V_CD_USUARIO&#10;          FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA, SOLICDEPARTCOMPRA, USUARIO&#10;         WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#10;           AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR  = USUARIO.CD_USUARIO&#10;        --   AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = SOLICDEPARTCOMPRA.CD_DEPARTAMENTO&#10;         --  AND SOLICDEPARTCOMPRA.CD_SOLICITANTE    = :GLOBAL.CD_USUARIO   &#10;           AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR  = :GLOBAL.CD_USUARIO         &#10;           AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;           AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = 'S'; --Aprovador de Necedssidade&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          V_CD_USUARIO := NULL;&#10;        WHEN OTHERS THEN&#10;          :CONTROLE.CD_AUTORIZADOR := NULL;&#10;          :CONTROLE.NM_USUAUTORIZ  := NULL;&#10;      END;&#10;      &#10;      --Sugere um Usuário Aprovador de Necessidade como Autorizador, caso possuir apenas um cadastrado&#10;      IF V_CD_USUARIO IS NOT NULL THEN&#10;      BEGIN               &#10;          SELECT DISTINCT USUARIO.CD_USUARIO, USUARIO.NM_USUARIO&#10;            INTO :CONTROLE.CD_AUTORIZADOR, :CONTROLE.NM_USUAUTORIZ&#10;            FROM SOLICITANTE, PARMCOMPRA, USUARIO &#10;           WHERE SOLICITANTE.CD_EMPRESA     = PARMCOMPRA.CD_EMPRESA&#10;             AND USUARIO.CD_USUARIO         = SOLICITANTE.CD_USUARIO&#10;             AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.TP_APROVSOLIC&#10;             AND SOLICITANTE.CD_USUARIO     = V_CD_USUARIO&#10;             AND PARMCOMPRA.CD_EMPRESA      = :GLOBAL.CD_EMPRESA;&#10;          EXCEPTION&#10;            WHEN OTHERS THEN&#10;              :CONTROLE.CD_AUTORIZADOR := NULL;&#10;              :CONTROLE.NM_USUAUTORIZ  := NULL;&#10;          END;&#10;      IF(:CONTROLE.CD_AUTORIZADOR IS NOT NULL)THEN&#10;        :ITEMCOMPRA.CD_AUTORIZADOR := :CONTROLE.CD_AUTORIZADOR;&#10;        VALIDA_AUTORIZADORCOMPRA(:ITEMCOMPRA.CD_AUTORIZADOR, V_MENSAGEM);  &#10;        IF(V_MENSAGEM  IS NOT NULL)THEN&#10;          I_MENSAGEM := V_MENSAGEM;        &#10;          RAISE E_GERAL;&#10;        END IF;  &#10;      END IF;        &#10;      END IF;&#10;      &#10;  &#10;    END IF;&#10;    &#10;--/*EML:29/07/2019:13058  ELSE &#10;  --  SET_ITEM_PROPERTY('CONTROLE.CD_DEPARTAMENTO', PROMPT_FONT_STYLE, FONT_NORMAL);&#10;--    PACK_TELA.DESABILITA_ITEM('CONTROLE.CD_DEPARTAMENTO');&#10;  END IF;&#10;  &#10;  /* DCS:11/02/2014:58880&#10;   * o tipo de compra será buscado automático pelo cadastrado no TCO20, &#10;   pela diferença de dias entre a data de Emissão e data Prevista&#10;   */&#10;  IF NVL(PACK_COMPRAS.VALIDA_TIPOCOMPRAUTOMATICO,'N') = 'S' THEN&#10;    PACK_TELA.DESABILITA_ITEM('CONTROLE.CD_TIPOCOMPRA');&#10;    SET_ITEM_PROPERTY('CONTROLE.CD_TIPOCOMPRA', PROMPT_FONT_STYLE, FONT_NORMAL);&#10;  ELSE&#10;    SET_ITEM_PROPERTY('CONTROLE.CD_TIPOCOMPRA', PROMPT_FONT_STYLE, FONT_UNDERLINE);&#10;  END IF;&#10;  &#10;  IF :PARAMETER.DS_PROCESSO = 'PRODUCAO' THEN&#10;    FOR I IN (SELECT DISTINCT ITEM_TMP.CD_ITEM&#10;                FROM ITEM_TMP&#10;                WHERE NVL(ITEM_TMP.NR_AGRUPAMENTO,1) = NVL(:PARAMETER.NR_AGRUPAMENTO,0) ) LOOP&#10;      IF FORM_SUCCESS THEN&#10;        GO_BLOCK('ITEMCOMPRA');&#10;        IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;          NEXT_RECORD;&#10;        END IF;&#10;        GO_ITEM('ITEMCOMPRA.CD_ITEM');&#10;        :ITEMCOMPRA.CD_ITEM := I.CD_ITEM;&#10;        EXECUTE_TRIGGER('WHEN-VALIDATE-ITEM');&#10;      ELSE&#10;        EXIT;&#10;      END IF;              &#10;    END LOOP;                   &#10;  END IF;  &#10;&#10;  --FJC:05/07/2018:121701&#10;  IF :CONTROLE.CD_TIPOCOMPRA IS NULL THEN&#10;    BEGIN&#10;      SELECT TIPOCOMPRA.CD_TIPOCOMPRA,&#10;             TIPOCOMPRA.DS_TIPOCOMPRA,&#10;             NVL(TIPOCOMPRA.TP_COMPRA,'D') TP_COMPRA,&#10;             DECODE(TIPOCOMPRA.TP_COMPRA,'D','DIVERSAS',&#10;                                         'P','PATRIMONIAL',&#10;                                         'J','JURÍDICA',&#10;                                         'DIVERSAS') DS_TPCOMPRA&#10;        INTO :CONTROLE.CD_TIPOCOMPRA,&#10;             :CONTROLE.DS_TIPOCOMPRA,&#10;             :CONTROLE.TP_COMPRA,&#10;             :CONTROLE.DS_TPCOMPRA&#10;         FROM TIPOCOMPRA&#10;       WHERE NVL(TIPOCOMPRA.ST_ATIVO,'A') = 'A';&#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        :CONTROLE.CD_TIPOCOMPRA := NULL;&#10;        :CONTROLE.DS_TIPOCOMPRA := NULL;&#10;        :CONTROLE.TP_COMPRA     := NULL; &#10;        :CONTROLE.DS_TPCOMPRA   := NULL;&#10;    END;  &#10;  END IF;&#10;  &#10;  /*AUG:130776:20/02/2019*/&#10;  IF :PARAMETER.CD_MODULO = 'EMV' AND&#10;     :PARAMETER.CD_PROGRAMA = 78  THEN&#10;  &#10;    PACK_PROCEDIMENTOS.CARREGA_PEDIDOINTERNO_EMV078;&#10;  &#10;  END IF;&#10;  /* ASF:26/03/2019:132689 */ &#10;  PACK_PROCEDIMENTOS.CARREGA_ITENSSOLICCOMPRA_TMP;&#10;&#10;  BEGIN&#10;    SELECT COUNT(*)&#10;      INTO V_COUNTITEMCOMPRA&#10;      FROM PREITEMCOMPRA&#10;     WHERE PREITEMCOMPRA.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#10;       AND PREITEMCOMPRA.ST_PREITEMCOMPRA = '1';    &#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      V_COUNTITEMCOMPRA := 0;&#10;  END;&#10;  &#10;  IF (V_COUNTITEMCOMPRA > 0) THEN&#10;    GO_ITEM('PREITEMCOMPRA.NR_ITEMCOMPRA');&#10;    CENTRALIZA_FORM('WIN_ITEMCOMPRA', 'WIN_PREITEMCOMPRA');&#10;    &#10;    PACK_PREITEMCOMPRA.CARREGA_PREITEMCOMPRA(I_MENSAGEM);&#10;    &#10;    IF (I_MENSAGEM IS NOT NULL) THEN&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;  END IF;&#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Precaução',I_MENSAGEM,3);&#10;    EXIT_FORM(NO_VALIDATE);&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    EXIT_FORM(NO_VALIDATE);&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-COMMIT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_ST_OBRIGCONFIRMCOMPRA        PARMCOMPRA.ST_OBRIGCONFIRMCOMPRA%TYPE; --ALE:25/11/2011:36255 - Parâmetro &#34;Obrigar Confirmação da Compra.&#34; da página &#34;Validações&#34; do COM009.&#10;  --I_CD_CENTROCUSTO              ITEMCOMPRACCUSTO.CD_CENTROCUSTO%TYPE;  &#10;  I_ST_ITEMCOMPRA               ITEMCOMPRACCUSTO.ST_ITEMCOMPRA%TYPE;&#10;  V_ST_ITEMCOMPRA               ITEMCOMPRACCUSTO.ST_ITEMCOMPRA%TYPE;&#10;  V_DS_OBSERVACAO               ITEMCOMPRACCUSTO.DS_OBSERVACAO%TYPE;&#10;  I_TP_ITEM                     VARCHAR2(1);&#10;  I_DT_LIBERACAO                ITEMCOMPRA.DT_LIBERACAO%TYPE;&#10;  V_DT_LIBERACAO                ITEMCOMPRA.DT_LIBERACAO%TYPE;&#10;  CONTADOR                      NUMBER := 0;&#10;  I_MENSAGEM                    VARCHAR2(32000);&#10;  E_GERAL                       EXCEPTION;&#10;  E_SAIDA                        EXCEPTION;&#10;  V_INFORMACAO                  VARCHAR2(32000);&#10;  V_NR_ITEMCOMPRA                 NUMBER;&#10;  V_NR_ITEMCOMPRA_U             NUMBER;&#10;  V_NR_ITEMCOMPRA_AUX             ITEMCOMPRA.NR_ITEMCOMPRA%TYPE;&#10;  V_CD_OPERESTOQUE              CMI.CD_OPERESTOQUE%TYPE;&#10;  V_ST_APROVSOLIC               VARCHAR2(1);&#10;  V_ST_ALCADASDEPTO             VARCHAR2(1);&#10;  V_CAMPO                       VARCHAR2(60);&#10;  V_CD_CENTROCUSTO              NUMBER;&#10;  V_CD_NEGOCIO                  NUMBER;/*CSL:21/12/2010:30317*/&#10;  V_CD_MOVIMENTACAO             NUMBER;&#10;  V_QT_PEDIDAUNIDSOL            NUMBER;&#10;  V_PC_PARTICIPACAO             NUMBER;&#10;  V_CD_AUTORIZADOR              VARCHAR2(10); &#10;  NR_REG                        NUMBER;&#10;  I_NR_LOTECOMPRA                NUMBER;&#10;  V_QT_PONTOPEDIDO              NUMBER;&#10;  V_QT_ESTOQUEFISICO            NUMBER;&#10;  V_QT_ESTOQUEPONTOPEDIDO       NUMBER;&#10;  V_CD_EMPRLANCTO               EMPRESA.CD_EMPRESA%TYPE;    &#10;  V_CD_EMPRCENTRALIZ            EMPRESA.CD_EMPRESA%TYPE;    &#10;  V_CD_SOLCCUSTO                CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#10;  V_CD_CCUSTO                   CENTROCUSTO.CD_CENTROCUSTO%TYPE;&#10;  V_ST_ENVIAEMAIL               VARCHAR2(1);&#10;  V_ST_BLOQUEIONIVEL            NUMBER;  --RBM: 24044: 17/12/2009&#10; -- V_ST_INCLUI                   BOOLEAN := FALSE;&#10;  --V_ST_ALTERA                   BOOLEAN := FALSE;&#10;  V_CD_EMPRCCUSTODEST            EMPRESA.CD_EMPRESA%TYPE;&#10;  V_COUNT                        NUMBER;&#10;  V_ALERT                        NUMBER;  --WLV:07/02/2012:40906  &#10;  V_FLAG                        NUMBER;  --WLV:07/02/2012:40906         &#10;  V_FLAG2                        NUMBER;  --WLV:14/02/2012:40906     &#10;  V_RETORNO                      BOOLEAN; --WLV:15/02/2012:40906&#10;  V_RECORD                      NUMBER;&#10;  V_CD_EMPRESA                   EMPRESA.CD_EMPRESA%TYPE;&#10;  V_ITENS                       VARCHAR2(32000);&#10;  V_ST_BLOQUEIO                 VARCHAR2(1);&#10;  V_MSG_BLOQUEIO                VARCHAR2(32000);&#10;  V_CD_CONTAORCAMENTO           NUMBER; &#10;  V_MENSAGEMFINAL               VARCHAR2(32000);&#10;  V_ST_BLOQUEIOFINAL            VARCHAR2(32000) := 'N';&#10;  V_CONTEXTO                     PACK_INTEGRACAOPAA.T_CONTEXTO;/*ANS:05/06/2017:110683*/&#10;  V_ID_PROCESSO                  NUMBER;/*ANS:05/06/2017:110683*/&#10;  V_ROW_PEDIDOINTERNOINTECOMPRA PEDIDOINTERNOINTECOMPRA%ROWTYPE;/*AUG:130776:20/02/2019*/&#10;  V_DADOS_ENTRADA                PACK_PEDIDOINTERNO.R_DADOS_ENTRADA;/*AUG:130776:20/02/2019*/ &#10;  V_ROW_ITEMPEDIDOINTERNO        ITEMPEDIDOINTERNO%ROWTYPE;/*AUG:130776:20/02/2019*/&#10;  V_CD_ESTUDO                   NUMBER;&#10;  V_CD_PROJETO                  NUMBER;&#10;  V_NR_VERSAO                   NUMBER;&#10;  V_CD_ETAPA                    NUMBER;&#10;  V_MENSAGEM                     VARCHAR2(32000);&#10;  E_PMS                         EXCEPTION; &#10;  V_CD_EMPRESACOM77             EMPRESA.CD_EMPRESA%TYPE;&#10;  V_CD_ITEMCOM77                ITEMNF.CD_ITEM%TYPE;&#10;  V_CONT                        NUMBER;&#10;BEGIN&#10;  &#10;  V_FLAG2 := 0;&#10;  V_RETORNO := TRUE;&#10;  V_ITENS := NULL;&#10;  &#10;  VALIDATE(FORM_SCOPE);  --WLV:07/02/2012:40906&#10;  IF NOT FORM_SUCCESS THEN&#10;    RAISE E_SAIDA;&#10;  END IF;&#10;  /* STATUS DAS SOLICITAÇÕES:&#10;   *&#10;   * 0  - Aguardando liberação;&#10;   * 1  - Liberado;&#10;   * 2  - Recusado;&#10;   * 3  - Em cotação;&#10;   * 4  - Renegociar; &#10;   * 5  - Aguardando aprovação (COM007);&#10;   * 6  - Aprovado;&#10;   * 7  - Pedido Gerado;&#10;   * 11 - Devolvido para solicitação;&#10;   * 13 - Aguard. Confirmação Compra;&#10;   * 14 - Dentro do Ponto de Pedido;&#10;   * 99 - Cancelado;&#10;   */&#10;   V_FLAG := 0;&#10;  &#10;  IF ((:SYSTEM.RECORD_STATUS = 'CHANGED') AND NOT PACK_VALIDA.VAL_PERMISSAO('A',:GLOBAL.CD_USUARIO,:GLOBAL.CD_EMPRESA,:GLOBAL.CD_MODULO,:GLOBAL.CD_PROGRAMA)) THEN&#10;    I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(485,'¢CD_USUARIO = '||:GLOBAL.CD_USUARIO||&#10;                                                '¢CD_MODULO  = '||:GLOBAL.CD_MODULO||&#10;                                                '¢CD_PROGRAMA= '||:GLOBAL.CD_PROGRAMA||&#10;                                                '¢CD_EMPRESA = '||:GLOBAL.CD_EMPRESA||'¢');&#10;    RAISE E_GERAL;&#10;  ELSIF ((:SYSTEM.RECORD_STATUS = 'INSERT') AND NOT PACK_VALIDA.VAL_PERMISSAO('I',:GLOBAL.CD_USUARIO,:GLOBAL.CD_EMPRESA,:GLOBAL.CD_MODULO,:GLOBAL.CD_PROGRAMA)) THEN&#10;    I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(486,'¢CD_USUARIO = '||:GLOBAL.CD_USUARIO||&#10;                                                '¢CD_MODULO  = '||:GLOBAL.CD_MODULO||&#10;                                                '¢CD_PROGRAMA= '||:GLOBAL.CD_PROGRAMA||&#10;                                                '¢CD_EMPRESA = '||:GLOBAL.CD_EMPRESA||'¢');&#10;    RAISE E_GERAL;&#10;  END IF;&#10;  &#10;  &#10;  V_CAMPO := NULL;&#10;  IF :SYSTEM.CURSOR_BLOCK IN ('ITEMCOMPRA','CONTROLE') THEN&#10;&#10;    IF ((:CONTROLE.CD_AUTORIZADOR IS NOT NULL) AND (:CONTROLE.CD_DEPARTAMENTO IS NOT NULL)) THEN&#10;      BEGIN&#10;        SELECT COUNT(*)&#10;          INTO V_CONT&#10;          FROM AUTORIZDEPARTCOMPRA &#10;         WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;           AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR;&#10;      EXCEPTION&#10;        WHEN OTHERS THEN&#10;          V_CONT := 0;&#10;      END;&#10;&#10;      IF (V_CONT = 0) THEN&#10;        /*Autorizador ¢CD_AUTORIZADOR¢ não está liberado para o departamento ¢CD_DEPARTAMENTO¢*/&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34196, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    END IF;&#10;&#10;    &#10;    -------------------------------------------------------------------------------------------------------&#10;    -- VALIDA OS DADOS&#10;    -------------------------------------------------------------------------------------------------------&#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    &#10;    BEGIN&#10;      SELECT CD_EMPRCENTRALIZ&#10;        INTO V_CD_EMPRCENTRALIZ&#10;        FROM PARMCOMPRA &#10;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --Parâmetros de Compra não cadastrados para a empresa ¢CD_EMPRESA¢. Verifique o Programa COM009.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2586,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;        --Parâmetros de Compra cadastrado em duplicidade para empresa ¢CD_EMPRESA¢.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2587,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        --Erro ao pesquisar Parâmetros de Compra para a empresa ¢CD_EMPRESA¢. Erro ¢SQLERRM¢.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3769,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;    END;    &#10;&#10;    /** ALE:25/11/2011:36255&#10;     *  Verifica o parâmetro &#34;Obrigar Confirmação da Compra.&#34; da página &#34;Validações&#34; do COM009 e quando &#10;     *  estiver configurado, ao selecionar um tipo de compra &#34;Jurídica&#34;, o campo &#34;Nr. Contrato&#34; passa a&#10;     *  ser obrigatório.&#10;     */      &#10;    BEGIN&#10;      SELECT NVL(PARMCOMPRA.ST_OBRIGCONFIRMCOMPRA,'N')&#10;        INTO V_ST_OBRIGCONFIRMCOMPRA&#10;        FROM PARMCOMPRA&#10;       WHERE PARMCOMPRA.CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        V_ST_OBRIGCONFIRMCOMPRA := 'N';&#10;    END;&#10;    IF (NVL(V_ST_OBRIGCONFIRMCOMPRA,'N') = 'S') THEN&#10;      IF (NVL(:CONTROLE.TP_COMPRA,'D') = 'J') THEN --JURÍDICA&#10;        IF (:CONTROLE.NR_CONTRATO IS NULL) THEN&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(15405, NULL); --Quando o tipo da compra for &#34;Jurídica&#34;, é obrigatório ser informado o número do contrato no campo &#34;Nr. Contrato&#34; do quadro &#34;Dados da Solicitação de Compra&#34;.&#10;          RAISE E_GERAL;&#10;        END IF; --IF (:CONTROLE.NR_CONTRATO IS NULL) THEN&#10;      END IF; --IF (NVL(:CONTROLE.TP_COMPRA,'D') = 'J') THEN&#10;    END IF; --IF (NVL(V_ST_OBRIGCONFIRMCOMPRA,'N') = 'S') THEN&#10;    ----------------------------------------------------------&#10;    &#10;    --validação&#10;    LOOP&#10;      /**KRG:29/05/08:18311&#10;       * Alterada a comparação :ITEMCOMPRA.TP_ITEMCOMPRA  := :CONTROLE.TP_ITEMCOMPRA&#10;       * para :ITEMCOMPRA.CD_TIPOCOMPRA  := :CONTROLE.CD_TIPOCOMPRA.&#10;       */&#10;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN        &#10;        :ITEMCOMPRA.CD_AUTORIZADOR := :CONTROLE.CD_AUTORIZADOR;&#10;        VALIDA_AUTORIZADORCOMPRA(:ITEMCOMPRA.CD_AUTORIZADOR, V_MENSAGEM);  &#10;        IF(V_MENSAGEM  IS NOT NULL)THEN&#10;          I_MENSAGEM := V_MENSAGEM;        &#10;          RAISE E_GERAL;&#10;        END IF;  &#10;        :ITEMCOMPRA.DT_DESEJADA    := :CONTROLE.DT_DESEJADA;&#10;        :ITEMCOMPRA.CD_TIPOCOMPRA  := :CONTROLE.CD_TIPOCOMPRA; --KRG:29/05/08:18311&#10;      ELSIF :ITEMCOMPRA.CD_ITEM          IS NULL AND&#10;            :ITEMCOMPRA.DS_UNIDMED       IS NULL AND&#10;            :ITEMCOMPRA.CD_MOVIMENTACAO  IS NULL AND&#10;            :ITEMCOMPRA.QT_PREVISTA      IS NULL AND&#10;            :ITEMCOMPRA.DS_OBSERVACAOEXT IS NULL AND&#10;            :ITEMCOMPRA.DS_OBSERVACAO    IS NULL AND&#10;            :ITEMCOMPRA.DS_ITEMSERVICO   IS NULL THEN&#10;        DELETE_RECORD;&#10;      END IF;&#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    PACK_PROCEDIMENTOS.VALIDA_AUTORIZADOR(I_MENSAGEM); --EML:21/02/2020:139947&#10;      IF(I_MENSAGEM  IS NOT NULL)THEN  &#10;        V_CAMPO := 'CONTROLE.CD_AUTORIZADOR';&#10;        RAISE E_GERAL;&#10;      END IF;  &#10;    &#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    LOOP  &#10;      IF :ITEMCOMPRA.CD_ITEM         IS NOT NULL AND &#10;         :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND&#10;         :ITEMCOMPRA.QT_PREVISTA     IS NOT NULL THEN&#10;      &#10;        --VERIFICA O CENTRO DE CUSTO&#10;        -----------------------------------------------------------------------&#10;        IF :ITEMCOMPRA.TP_CONTACONTABIL = 'CC'  THEN&#10;          NR_REG := 0;&#10;           FOR I IN 1 ..GET_GROUP_ROW_COUNT('GRUPO_CC') LOOP&#10;            IF GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM', I) = :ITEMCOMPRA.CD_ITEM THEN&#10;              NR_REG := NR_REG + 1; &#10;              ----------------------------------------------------------------------------------------------------&#10;              /* RBM: 20405: 29/12/2008&#10;               * Em caso de for um item com Centro de Custo, verificar se o usuario tem permissão para solicitar&#10;               * o determinado item.&#10;               */&#10;              ----------------------------------------------------------------------------------------------------&#10;               V_CD_CCUSTO := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO', I);    &#10;               &#10;               /* RBM: 21554: 20/04/2009&#10;               * Verificar se antes é para validar o usuario conforme parametro no COM009.&#10;               */    &#10;               IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:CONTROLE.CD_EMPRESA,'ST_VALIDAUSERCC'),'N') = 'S' &#10;                 AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;                 BEGIN&#10;                   SELECT CCUSTOAUTORIZ.CD_USUARIO&#10;                     INTO V_CD_SOLCCUSTO&#10;                    FROM CCUSTOAUTORIZ&#10;                   WHERE CCUSTOAUTORIZ.CD_EMPRESA     = :GLOBAL.CD_EMPRESA&#10;                     AND CCUSTOAUTORIZ.CD_CENTROCUSTO = V_CD_CCUSTO&#10;                     AND CCUSTOAUTORIZ.CD_USUARIO     = :GLOBAL.CD_USUARIO&#10;                     AND CCUSTOAUTORIZ.TP_AUTORIZADOR IN ('S','A','T')&#10;                     AND ROWNUM = 1;&#10;                 EXCEPTION&#10;                   WHEN NO_DATA_FOUND THEN&#10;                     --O Usuário ¢CD_USUARIO¢ não está autorizado para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;                     I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3771,'¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢CD_CENTROCUSTO='||V_CD_CCUSTO||'¢');&#10;                     RAISE E_GERAL;&#10;                   WHEN TOO_MANY_ROWS THEN&#10;                     --O Usuário ¢CD_USUARIO¢ está autorizado várias vezes para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;                     I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3772,'¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢CD_CENTROCUSTO='||V_CD_CCUSTO||'¢');&#10;                     RAISE E_GERAL;&#10;                   WHEN OTHERS THEN &#10;                     --Erro ao pesquisar o Usuário ¢CD_USUARIO¢ para o Centro de Custo ¢CD_CENTROCUSTO¢. Erro ¢SQLERRM¢.&#10;                     I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3773,'¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢CD_CENTROCUSTO='||V_CD_CCUSTO||'¢SQLERRM='||SQLERRM||'¢');&#10;                     RAISE E_GERAL;&#10;                 END; &#10;              END IF;&#10;               --EXIT;&#10;            END IF;&#10;          END LOOP;   &#10;           IF NR_REG &#60; 1 THEN&#10;             --É Necessário Informar o centro de custo para o item ¢CD_ITEM¢!&#10;             I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4683,'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢');&#10;             RAISE E_GERAL;&#10;          END IF;    &#10;        ELSIF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_OBRIGARATEIONEGOCIO'),'N') = 'S' THEN&#10;          NR_REG := 0;&#10;          FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO') LOOP&#10;            IF :ITEMCOMPRA.CD_ITEM = GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_ITEM', I) THEN&#10;              NR_REG := NR_REG + 1;&#10;            END IF;               &#10;          END LOOP;&#10;          &#10;          IF NR_REG &#60; 1 THEN&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(29151, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢');&#10;            RAISE E_GERAL;&#10;          END IF;  &#10;        END IF;&#10;        -----------------------------------------------------------------------&#10;        --verifica o item&#10;        -----------------------------------------------------------------------&#10;        IF :ITEMCOMPRA.CD_ITEM IS NULL THEN&#10;          --É necessário informar o Item&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4162,'');&#10;          V_CAMPO    := 'ITEMCOMPRA.CD_ITEM';&#10;          RAISE E_GERAL;&#10;        END IF;&#10;        &#10;        ----------------------------------------------------------------------&#10;         --verifica o Autorizador&#10;        -----------------------------------------------------------------------&#10;        BEGIN &#10;          SELECT ST_APROVSOLIC&#10;            INTO V_ST_APROVSOLIC&#10;            FROM PARMCOMPRA&#10;           WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            NULL;&#10;        END;      &#10;        V_ST_ALCADASDEPTO := NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_ALCADASDEPTO'),'N');&#10;         /*ATR:115974:26/12/2017*/&#10;         IF ((NVL(V_ST_APROVSOLIC,'N') = 'S' OR NVL(V_ST_ALCADASDEPTO,'N') = 'S') AND :ITEMCOMPRA.CD_AUTORIZADOR IS NULL)&#10;           AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;          --O campo Autorizador deve ser informado.&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3760,'');&#10;          GO_ITEM('CONTROLE.CD_AUTORIZADOR');&#10;          RAISE E_GERAL;&#10;        END IF;&#10;        -----------------------------------------------------------------------------&#10;        -- Verifica se o parâmetro do COM009 está para obrigar a observação da sol --&#10;        -----------------------------------------------------------------------------&#10;        IF PACK_PARMGEN.CONSULTA_PARAMETRO('COM',009,'MAX',:GLOBAL.CD_EMPRESA,'ST_OBRIGAOBS') = 'S' THEN&#10;           IF REPLACE(REPLACE(:ITEMCOMPRA.DS_OBSERVACAO,CHR(13)),CHR(10)) IS NULL THEN&#10;             --A observação da solicitação deve ser informada.&#10;             I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4684,'');&#10;             GO_ITEM('ITEMCOMPRA.DS_OBSERVACAO');&#10;             RAISE E_GERAL;&#10;           END IF;&#10;        END IF;&#10;        ----------------------------------------------------------------------&#10;        IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN&#10;          BEGIN&#10;            SELECT CMI.CD_OPERESTOQUE&#10;              INTO V_CD_OPERESTOQUE&#10;              FROM PARMOVIMENT, CMI&#10;              WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;                AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#10;               AND CMI.TP_FATES                = '0';&#10;           EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              --A Movimentação ¢CD_MOVIMENTACAO¢ não está cadastrada. Verifique o programa TCB008.&#10;              I_MENSAGEM:= PACK_MENSAGEM.MENS_PADRAO(46,'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;              V_CAMPO   :='ITEMCOMPRA.CD_MOVIMENTACAO'; &#10;              RAISE E_GERAL;&#10;          END;&#10;           IF V_CD_OPERESTOQUE IS NOT NULL THEN &#10;            VALIDA_MOVIMENTACAO(I_MENSAGEM);&#10;            IF I_MENSAGEM IS NOT NULL THEN  &#10;              RAISE E_GERAL;&#10;            END IF;&#10;          END IF;&#10;         ELSE &#10;           --A movimentação deve ser informada.    &#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(298,'');&#10;          V_CAMPO    := 'ITEMCOMPRA.CD_MOVIMENTACAO';&#10;          RAISE E_GERAL;&#10;        END IF;     &#10;        --verifica data Desejada&#10;        -----------------------------------------------------------------------&#10;        IF :ITEMCOMPRA.DT_DESEJADA IS NULL THEN&#10;          --É necessário informar a data desejada!&#10;          I_MENSAGEM:= PACK_MENSAGEM.MENS_PADRAO(4685,'');&#10;          V_CAMPO   := 'CONTROLE.DT_DESEJADA';&#10;          /*AUG:130776:20/02/2019*/&#10;          IF NVL(:PARAMETER.CD_MODULO,'ZZZ') = 'EMV' AND&#10;             NVL(:PARAMETER.CD_PROGRAMA,-1)  = 78    THEN&#10;              SET_ITEM_PROPERTY('CONTROLE.DT_DESEJADA',VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO'); &#10;              SET_ITEM_PROPERTY('CONTROLE.DT_DESEJADA',INSERT_ALLOWED,PROPERTY_TRUE);  &#10;          END IF;&#10;        &#10;          RAISE E_GERAL;&#10;        ELSIF :ITEMCOMPRA.DT_DESEJADA &#60;= SYSDATE THEN&#10;          --A Data Desejada deve ser maior que a data atual!&#10;           I_MENSAGEM:= PACK_MENSAGEM.MENS_PADRAO(4686,'');&#10;           V_CAMPO   :='CONTROLE.DT_DESEJADA';&#10;           /*AUG:130776:20/02/2019*/&#10;          IF NVL(:PARAMETER.CD_MODULO,'ZZZ') = 'EMV' AND&#10;             NVL(:PARAMETER.CD_PROGRAMA,-1)  = 78    THEN&#10;              SET_ITEM_PROPERTY('CONTROLE.DT_DESEJADA',VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO'); &#10;              SET_ITEM_PROPERTY('CONTROLE.DT_DESEJADA',INSERT_ALLOWED,PROPERTY_TRUE);  &#10;          END IF;&#10;          &#10;           RAISE E_GERAL;&#10;        END IF;&#10;        &#10;        /* DCS:19/11/2013:63403&#10;         * Caso esteja ativo o controle de Alçadas por Departamento,&#10;         * o código do Departamento deve ser informado&#10;         */&#10;        IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_ALCADASDEPTO'),'N') = 'S' THEN&#10;          IF :CONTROLE.CD_DEPARTAMENTO IS NULL THEN&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1545, '¢NM_CAMPO='||'Código do Departamento'||'¢'); --O campo ¢NM_CAMPO¢ deve ser informado.&#10;            V_CAMPO    := 'CONTROLE.CD_DEPARTAMENTO';&#10;            RAISE E_GERAL;&#10;          END IF;&#10;        END IF;&#10;        &#10;        /* DCS:25/02/2014:68851&#10;         * Removida validação que obriga que o autorizador informado seja um aprovador de necessidade do TCO024&#10;         */&#10;        --Valida se o Autorizador está cadastrado para o Departamento&#10;        /*&#10;        IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL AND :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#10;          BEGIN&#10;            SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;              INTO :CONTROLE.DS_DEPARTAMENTO&#10;              FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;             WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#10;               AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;               AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#10;               AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = 'S'; --Aprovador de Necedssidade&#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              --O Usuário Autorizador ¢CD_AUTORIZADOR¢ não está cadastrado como Aprovador de Necessidade para o Departamento de Compra ¢CD_DEPARTAMENTO¢. Verifique o TCO024.&#10;              V_CAMPO    := 'CONTROLE.CD_DEPARTAMENTO';&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21638, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;              RAISE E_GERAL;&#10;            WHEN OTHERS THEN&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar o Departamento ¢CD_DEPARTAMENTO¢. Erro ¢SQLERRM¢. Verifique o TCO024, página Departamentos.&#10;              RAISE E_GERAL;&#10;          END;&#10;        END IF;&#10;        */&#10;        &#10;        IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#10;          &#10;          /* DCS:25/02/2014:68851&#10;           * valida se o departamento esta cadastrado para o Solicitante no TCO024&#10;           */&#10;          BEGIN&#10;            SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;              INTO :CONTROLE.DS_DEPARTAMENTO&#10;              FROM SOLICDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;             WHERE SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#10;               AND SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;               AND SOLICDEPARTCOMPRA.CD_SOLICITANTE  = :GLOBAL.CD_USUARIO;&#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22640, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢CD_SOLICITANTE='||:GLOBAL.CD_USUARIO||'¢'); --O Departamento de Compra ¢CD_DEPARTAMENTO¢ não está cadastrado para o Usuário Soliciante ¢CD_SOLICITANTE¢. Verifique o TCO024.&#10;              RAISE E_GERAL;&#10;            WHEN OTHERS THEN&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar o Departamento ¢CD_DEPARTAMENTO¢. Erro ¢SQLERRM¢. Verifique o TCO024, página Departamentos.&#10;              RAISE E_GERAL;&#10;          END;&#10;        &#10;          /* DCS:25/02/2014:68851&#10;           * Valida se o departamento possui pelo menos um usuário Aprovador de Necessidade e de Aprovador de Alçadas&#10;           */&#10;          SELECT COUNT(*)&#10;            INTO V_COUNT&#10;            FROM AUTORIZDEPARTCOMPRA&#10;           WHERE CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;             AND ST_APROVNECESSIDADE = 'S';&#10;          IF NVL(V_COUNT,0) = 0 THEN&#10;            --O Departamento de Compra ¢CD_DEPARTAMENTO¢ não possui Usuário cadastrado como Aprovador de Necessidade. Verifique o TCO024.&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21662, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;            RAISE E_GERAL;&#10;          END IF;&#10;          &#10;          SELECT COUNT(*)&#10;            INTO V_COUNT&#10;            FROM AUTORIZDEPARTCOMPRA&#10;           WHERE CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;             AND ST_APROVNECESSIDADE = 'N';&#10;          IF NVL(V_COUNT,0) = 0 THEN&#10;            --O Departamento de Compra ¢CD_DEPARTAMENTO¢ não possui Usuário cadastrado como Aprovador de Alçadas. Verifique o TCO024.&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22636, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;            RAISE E_GERAL;&#10;          END IF;&#10;          &#10;        END IF;&#10;      &#10;        ----------------------------------------------------------------------&#10;        --verifica qtde&#10;        -----------------------------------------------------------------------&#10;        IF :ITEMCOMPRA.QT_PREVISTA IS NULL THEN&#10;          --A quantidade deve ser informada.&#10;          I_MENSAGEM:= PACK_MENSAGEM.MENS_PADRAO(1827,'');&#10;          V_CAMPO   :='ITEMCOMPRA.QT_PREVISTA';&#10;          RAISE E_GERAL;&#10;        ELSIF :ITEMCOMPRA.QT_PREVISTA &#60;=0 THEN&#10;          --A Quantidade não pode ser Menor ou Igual a Zero.&#10;          I_MENSAGEM:= PACK_MENSAGEM.MENS_PADRAO(7910,'');&#10;          V_CAMPO   :='ITEMCOMPRA.QT_PREVISTA';&#10;          RAISE E_GERAL;&#10;        END IF;&#10;        ----------------------------------------------------------------------&#10;        --Verifica o tipo de compra&#10;        ----------------------------------------------------------------------&#10;        IF :ITEMCOMPRA.CD_TIPOCOMPRA IS NULL THEN&#10;          --É necessário informar o tipo da compra!&#10;          I_MENSAGEM:= PACK_MENSAGEM.MENS_PADRAO(4687,'');&#10;          V_CAMPO    := 'CONTROLE.CD_TIPOCOMPRA';&#10;          RAISE E_GERAL;&#10;        END IF;&#10;        ------------------------------------------------------------------------------------------------&#10;        -- VERIFICA O TIPO DO ITEM, VERIFICA SE É UM SERVIÇO, SENDO NECESSÁRIO A DESCRIÇÃO &#10;        ------------------------------------------------------------------------------------------------&#10;        BEGIN&#10;          SELECT ITEM.TP_ITEM&#10;            INTO I_TP_ITEM&#10;            FROM ITEM&#10;           WHERE ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            --O item ¢CD_ITEM¢ não está cadastrado. Verifique o programa TIT001.&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27,'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢');&#10;            RAISE E_GERAL;&#10;        END;   &#10;  &#10;        IF I_TP_ITEM = 'S' THEN &#10;          IF :ITEMCOMPRA.DS_ITEMSERVICO IS NULL THEN &#10;            --A descrição do serviço deve ser informada.&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4688,'');&#10;            MANIPULA_CAMPO('ITEMCOMPRA.DS_ITEMSERVICO','A');&#10;            /*SET_ITEM_PROPERTY ('ITEMCOMPR A.DS_ITEMSERVICO' ,ENABLED,PROPERTY_TRUE);&#10;            SET_ITEM_PROPERTY ('ITEMCOMPR A.DS_ITEMSERVICO',NAVIGABLE,PROPERTY_TRUE);&#10;            SET_ITEM_PROPERTY ('ITEMCOMP RA.DS_ITEMSERVICO',VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');&#10;            SET_ITEM_PROPERTY ('ITEMCOMP RA.DS_ITEMSERVICO',PROMPT_FONT_STYLE,FONT_UNDERLINE);*/&#10;            GO_ITEM('ITEMCOMPRA.DS_ITEMSERVICO');&#10;            RAISE E_GERAL;&#10;          END IF;&#10;  &#10;          IF :CONTROLE.DT_INICIO IS NULL THEN&#10;            --A Data de Inicio do Serviço deve ser informada.&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4689,'');&#10;            GO_ITEM('CONTROLE.DT_INICIO');&#10;            RAISE E_GERAL;&#10;          END IF;&#10;          :ITEMCOMPRA.DT_INICIO := :CONTROLE.DT_INICIO;&#10;          &#10;        END IF;&#10;        &#10;        IF PACK_GLOBAL.ST_APROVSOLIC = 'N' THEN -- IF3&#10;          I_ST_ITEMCOMPRA := 1;&#10;          I_DT_LIBERACAO   := SYSDATE;    &#10;        ELSE&#10;          /*ATR:115974:26/12/2017*/&#10;          IF :ITEMCOMPRA.CD_AUTORIZADOR IS NULL &#10;            AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN -- IF4&#10;          BEGIN            &#10;              SELECT SOLICITANTE.CD_USUARIO&#10;                INTO :ITEMCOMPRA.CD_AUTORIZADOR&#10;                FROM SOLICITANTE, &#10;                     PARMCOMPRA, &#10;                     USUARIO&#10;                WHERE SOLICITANTE.CD_EMPRESA      = PARMCOMPRA.CD_EMPRESA&#10;                 AND USUARIO.CD_USUARIO         = SOLICITANTE.CD_USUARIO&#10;                 AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.TP_APROVSOLIC&#10;                 AND SOLICITANTE.CD_EMPRESA     = :GLOBAL.CD_EMPRESA;&#10;            EXCEPTION&#10;              WHEN NO_DATA_FOUND THEN&#10;                --O solicitante não tem autorizador cadastrado para a empresa ¢CD_EMPRESA¢. Verifique TCO002.&#10;                I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3764,'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;                RAISE E_GERAL;&#10;              WHEN TOO_MANY_ROWS THEN&#10;                IF NOT SHOW_LOV('LOV_SOLICAUTORIZ') THEN&#10;                  NULL;&#10;                END IF;&#10;            END;&#10;            IF(:ITEMCOMPRA.CD_AUTORIZADOR IS NOT NULL)THEN&#10;              VALIDA_AUTORIZADORCOMPRA(:ITEMCOMPRA.CD_AUTORIZADOR, V_MENSAGEM);  &#10;              IF(V_MENSAGEM  IS NOT NULL)THEN&#10;                I_MENSAGEM := V_MENSAGEM;        &#10;                RAISE E_GERAL;&#10;              END IF;&#10;            END IF;&#10;          END IF;&#10;          I_ST_ITEMCOMPRA := 0;&#10;          I_DT_LIBERACAO   := NULL;&#10;        END IF;&#10;        &#10;        IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL AND :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;          BEGIN&#10;            SELECT QT_PONTOPEDIDO&#10;              INTO V_QT_PONTOPEDIDO&#10;              FROM PLANEJITEM&#10;             WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA&#10;               AND CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              --Planejamento de item não cadastrado para o Item ¢CD_ITEM¢ e Empresa ¢CD_EMPRESA¢. Verifique o programa TIT001.&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20051, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;              RAISE E_GERAL;&#10;            WHEN TOO_MANY_ROWS THEN&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20052, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;              RAISE E_GERAL;&#10;            WHEN OTHERS THEN&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20053, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢SQLERR='||SQLERRM||'¢');&#10;              RAISE E_GERAL;&#10;          END;&#10;        END IF;&#10;        &#10;        /* DCS:11/02/2014:58880&#10;         * Verifica se os Itens estão fora do cronograma do programa TCO025&#10;         */&#10;        IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_CRONOGRAMACOMPRA'),'N') = 'S' THEN&#10;          IF NVL(:ITEMCOMPRA.ST_ITEMCOMPRA,0) NOT IN (1,3,4,5,7,9,99) THEN&#10;            IF PACK_COMPRAS.VALIDA_CRONOGRAMACOMPRA(:ITEMCOMPRA.CD_ITEM,TRUNC(SYSDATE),'S') = 'N' THEN&#10;              :ITEMCOMPRA.ST_CRONOGRAMACOMPRA := 'N';&#10;                                               &#10;              IF V_ITENS IS NULL THEN&#10;                V_ITENS := :ITEMCOMPRA.CD_ITEM;&#10;              ELSE&#10;                V_ITENS := V_ITENS||', '||:ITEMCOMPRA.CD_ITEM;&#10;              END IF;&#10;            ELSE&#10;              :ITEMCOMPRA.ST_CRONOGRAMACOMPRA := 'S';&#10;            END IF;&#10;          END IF;&#10;        END IF;&#10;      &#10;      &#10;      ELSE&#10;        IF (:ITEMCOMPRA.CD_ITEM IS NULL) THEN&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4162, NULL); -- É necessário informar o Item!&#10;          V_CAMPO    := 'ITEMCOMPRA.CD_ITEM';&#10;          RAISE E_GERAL;&#10;        END IF; --IF (:ITEMCOMPRA.CD_ITEM IS NULL) THEN&#10;        -----------------------------------------------&#10;        &#10;        IF (:ITEMCOMPRA.CD_MOVIMENTACAO IS NULL) THEN&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21378, NULL); -- A Movimentação deve ser informada.&#10;          V_CAMPO    := 'ITEMCOMPRA.CD_MOVIMENTACAO';&#10;          RAISE E_GERAL;&#10;        END IF;  --IF (:ITEMCOMPRA.CD_MOVIMENTACAO IS NULL) THEN&#10;        -------------------------------------------------------&#10;        &#10;        IF (:ITEMCOMPRA.QT_PREVISTA IS NULL) THEN&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1827, NULL); -- A quantidade deve ser informada.&#10;          V_CAMPO   :='ITEMCOMPRA.QT_PREVISTA';&#10;          RAISE E_GERAL;&#10;        ELSIF (NVL(:ITEMCOMPRA.QT_PREVISTA,0) &#60;= 0) THEN&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7910, NULL); -- A Quantidade não pode ser Menor ou Igual a Zero.&#10;          V_CAMPO   :='ITEMCOMPRA.QT_PREVISTA';&#10;          RAISE E_GERAL;&#10;        END IF; --IF (:ITEMCOMPRA.QT_PREVISTA IS NULL) THEN    &#10;      &#10;      END IF;&#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    /* DCS:11/02/2014:58880&#10;     * Solicita ao usuário com um Alerta se deseja prosseguir com a Solicitação de Compra, caso possuir algum Item que esteja fora do cronograma do programa TCO025&#10;     */&#10;    IF V_ITENS IS NOT NULL THEN&#10;      V_ITENS := SUBSTR(V_ITENS,1,110); --pega apenas 110 caracteres para não estourar o tamanho no Alert&#10;      IF INSTR(V_ITENS,',') = 0 THEN&#10;        SET_ALERT_PROPERTY('MENSAGEM_CRONOGRAMA', ALERT_MESSAGE_TEXT, 'O Item ('||V_ITENS||') está fora do Cronograma. Deseja fazer a solicitação dele mesmo assim ?');&#10;      ELSE&#10;        SET_ALERT_PROPERTY('MENSAGEM_CRONOGRAMA', ALERT_MESSAGE_TEXT, 'Os Itens ('||V_ITENS||') estão fora do Cronograma. Deseja fazer a solicitação deles mesmo assim ?');&#10;      END IF;&#10;      V_ALERT := SHOW_ALERT('MENSAGEM_CRONOGRAMA');&#10;      IF NOT V_ALERT = ALERT_BUTTON1 THEN&#10;        RAISE E_SAIDA;&#10;      END IF;&#10;    END IF;&#10;    &#10;    -- MVP:12/04/2019 - GRAVA PROJETO&#10;    IF PACK_PARMGEN.CONSULTA_PARAMETRO('COM',&#10;                                       9,&#10;                                       'MAX',&#10;                                       :ITEMCOMPRA.CD_EMPRESA,&#10;                                       'ST_PROJETOMONI') = 'S' &#10;      AND PACK_PARMGEN.CONSULTA_PARAMETRO('COM',&#10;                                          9,&#10;                                          'MAX',&#10;                                          :ITEMCOMPRA.CD_EMPRESA,&#10;                                          'ST_PRJETORATEIO') = 'N' THEN&#10;      GO_BLOCK('ITEMCOMPRA');&#10;      FIRST_RECORD;&#10;      LOOP&#10;        IF :ITEMCOMPRA.CD_ITEM IS NOT NULL AND &#10;           :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND&#10;           :ITEMCOMPRA.ST_PROJETOMONI IS NULL THEN&#10;          BEGIN&#10;            SELECT DISTINCT ORCAMENTOMONI.CD_ESTUDO,&#10;                   ORCAMENTOMONI.CD_PROJETO,&#10;                   ORCAMENTOMONI.NR_VERSAO,&#10;                   ORCAMENTOMONI.CD_ETAPA&#10;              INTO V_CD_ESTUDO,&#10;                   V_CD_PROJETO,&#10;                   V_NR_VERSAO,&#10;                   V_CD_ETAPA&#10;              FROM PROJETOMONI, &#10;                   ORCAMENTOMONI, &#10;                   GRUPOMOVIMENTACAOMONI, &#10;                   MOVIMENTACAOGRUPOMONI&#10;             WHERE ORCAMENTOMONI.CD_ESTUDO = PROJETOMONI.CD_ESTUDO &#10;               AND ORCAMENTOMONI.CD_PROJETO = PROJETOMONI.CD_PROJETO &#10;               AND ORCAMENTOMONI.NR_VERSAO = PROJETOMONI.NR_VERSAO&#10;               AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO = GRUPOMOVIMENTACAOMONI.CD_GRUPOMOVIMENTACAO&#10;               AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO = MOVIMENTACAOGRUPOMONI.CD_GRUPOMOVIMENTACAO&#10;               AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;               AND PROJETOMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#10;                                               FROM PROJETOMONI PROJ&#10;                                              WHERE PROJETOMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#10;                                                AND PROJETOMONI.CD_PROJETO = PROJ.CD_PROJETO);&#10;            &#10;            :PROJETOITEMCOMPRA.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#10;            :PROJETOITEMCOMPRA.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#10;            :PROJETOITEMCOMPRA.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#10;            :PROJETOITEMCOMPRA.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#10;            :PROJETOITEMCOMPRA.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#10;            GO_BLOCK('PROJETOITEMCOMPRA');&#10;            &#10;            RAISE E_SAIDA;&#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              NULL;&#10;            WHEN TOO_MANY_ROWS THEN&#10;              :PROJETOITEMCOMPRA.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#10;              :PROJETOITEMCOMPRA.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#10;              :PROJETOITEMCOMPRA.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#10;              :PROJETOITEMCOMPRA.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#10;              :PROJETOITEMCOMPRA.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#10;              GO_BLOCK('PROJETOITEMCOMPRA');&#10;              RAISE E_SAIDA;&#10;            WHEN OTHERS THEN&#10;              NULL;&#10;          END;&#10;        END IF; &#10;        &#10;        EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;        NEXT_RECORD;&#10;      END LOOP;&#10;    END IF;&#10;    &#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    &#10;    BEGIN&#10;      SELECT CD_EMPRCENTRALIZ&#10;        INTO V_CD_EMPRCENTRALIZ&#10;        FROM PARMCOMPRA &#10;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        /*MVP:25/03/2013:56895*/&#10;        --Parâmetros de Compra não cadastrados para a empresa ¢CD_EMPRESA¢. Verifique o Programa COM009.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2586,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;        --Parâmetros de Compra cadastrado em duplicidade para empresa ¢CD_EMPRESA¢.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2587,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        --Erro ao pesquisar Parâmetros de Compra para a empresa ¢CD_EMPRESA¢. Erro ¢SQLERRM¢.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3769,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;    &#10;    IF V_CD_EMPRCENTRALIZ IS NOT NULL AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_AGRUPACOTACAOCENTRAL'),'N') = 'S' THEN&#10;      V_CD_EMPRLANCTO := :ITEMCOMPRA.CD_EMPRESA;&#10;    ELSIF V_CD_EMPRCENTRALIZ IS NOT NULL AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_AGRUPACOTACAOCENTRAL'),'N') = 'N' THEN&#10;      V_CD_EMPRLANCTO := V_CD_EMPRCENTRALIZ;&#10;    ELSE&#10;      V_CD_EMPRLANCTO := :ITEMCOMPRA.CD_EMPRESA;&#10;    END IF;&#10;    V_CD_EMPRLANCTO := NVL(V_CD_EMPRLANCTO,:ITEMCOMPRA.CD_EMPRESA);&#10;    &#10;    LOOP&#10;      &#10;      IF V_CD_EMPRLANCTO IS NOT NULL AND :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;        BEGIN&#10;          SELECT QT_PONTOPEDIDO&#10;            INTO V_QT_PONTOPEDIDO&#10;            FROM PLANEJITEM&#10;           WHERE CD_EMPRESA = V_CD_EMPRLANCTO&#10;             AND CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            --Planejamento de item não cadastrado para o Item ¢CD_ITEM¢ e Empresa ¢CD_EMPRESA¢. Verifique o programa TIT001.&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20051, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;            RAISE E_GERAL;&#10;          WHEN TOO_MANY_ROWS THEN&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20052, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;            RAISE E_GERAL;&#10;          WHEN OTHERS THEN&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20053, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢SQLERR='||SQLERRM||'¢');&#10;            RAISE E_GERAL;&#10;        END;&#10;      END IF;&#10;    &#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;     &#10;    ---------------------------------------&#10;    ---INFORMAÇÕES DO PROJETO MONI.-------    &#10;    ---------------------------------------    &#10;    INFORMA_PROJETO(V_CD_EMPRLANCTO, I_MENSAGEM);&#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      RAISE E_PMS;&#10;    END IF;     &#10;    &#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    CONTADOR := 0;&#10;    I_NR_LOTECOMPRA := NULL;&#10;    &#10;    -------------------------------------------------------------------------------------------------&#10;    -- INICIA INSERÇÃO&#10;    -------------------------------------------------------------------------------------------------      &#10;    LOOP &#10;      IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NULL THEN &#10;        -- RETORNA SEQUENCIA&#10;        &#10;        IF I_NR_LOTECOMPRA IS NULL THEN &#10;           IF :CONTROLE.NR_LOTECOMPRA IS NULL THEN&#10;            RETORNA_SEQUENCIA('NRLOTECOM',V_CD_EMPRLANCTO,I_NR_LOTECOMPRA,I_MENSAGEM);&#10;            IF I_MENSAGEM IS NOT NULL THEN&#10;              RAISE E_GERAL;&#10;            END IF;&#10;          ELSE&#10;            I_NR_LOTECOMPRA := :CONTROLE.NR_LOTECOMPRA;&#10;           END IF;   &#10;        END IF;&#10;        &#10;        RETORNA_SEQUENCIA('NRSOL',V_CD_EMPRLANCTO,:ITEMCOMPRA.NR_ITEMCOMPRA,I_MENSAGEM);&#10;        IF I_MENSAGEM IS NOT NULL THEN&#10;          RAISE E_GERAL;&#10;        END IF;&#10;        &#10;        ------------------------------------------------------------------------------------------------&#10;        IF CONTADOR = 0 THEN &#10;          V_NR_ITEMCOMPRA := :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;        END IF;   &#10;        CONTADOR          := CONTADOR + 1; &#10;        V_NR_ITEMCOMPRA_U := :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;      END IF;&#10;    &#10;      /**KRG:29/05/08:18311&#10;       * Acrescentado mais esse campo CD_TIPOCOMPRA e  :ITEMCOMPRA.CD_TIPOCOMPRA.&#10;       */&#10;      ------------------------------------------------------------------------------------------------&#10;      -- INSERE ITEMCOMPRA&#10;      ------------------------------------------------------------------------------------------------&#10;      IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NOT NULL AND :ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#10;        /* RBM: 22466: 13/08/2009&#10;         * Permitir atualizar somente Solicitações que não entraram em processo de compra;&#10;         */&#10;        IF NVL(:ITEMCOMPRA.ST_ITEMCOMPRA,0) NOT IN (0,2,11) THEN&#10;          IF V_INFORMACAO IS NULL THEN&#10;            V_INFORMACAO := :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;          ELSE  &#10;            V_INFORMACAO := V_INFORMACAO||', '||:ITEMCOMPRA.NR_ITEMCOMPRA;&#10;          END IF;&#10;        ELSE&#10;          &#10;          V_ST_ITEMCOMPRA := I_ST_ITEMCOMPRA;&#10;          V_DT_LIBERACAO  := I_DT_LIBERACAO;&#10;          &#10;          /* DCS:15/04/2013:55262&#10;           * Seta o status da solicitação de compra para 14 - 'Dentro do Ponto de Pedido', caso o item já existir no estoque&#10;           */&#10;          IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;            IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_PONTOPEDIDO'),'N') = 'S' THEN&#10;              &#10;              V_QT_PONTOPEDIDO := NULL;&#10;              BEGIN&#10;                SELECT QT_PONTOPEDIDO&#10;                  INTO V_QT_PONTOPEDIDO&#10;                  FROM PLANEJITEM&#10;                 WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA&#10;                   AND CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#10;              EXCEPTION&#10;                WHEN NO_DATA_FOUND THEN&#10;                  --Planejamento de item não cadastrado para o Item ¢CD_ITEM¢ e Empresa ¢CD_EMPRESA¢. Verifique o programa TIT001.&#10;                  I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20051, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;                  RAISE E_GERAL;&#10;                WHEN TOO_MANY_ROWS THEN&#10;                  I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20052, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;                  RAISE E_GERAL;&#10;                WHEN OTHERS THEN&#10;                  I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20053, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢SQLERR='||SQLERRM||'¢');&#10;                  RAISE E_GERAL;&#10;              END;&#10;              &#10;              IF V_QT_PONTOPEDIDO IS NOT NULL THEN&#10;                &#10;                IF V_CD_EMPRCENTRALIZ IS NOT NULL THEN&#10;                  &#10;                  V_QT_ESTOQUEFISICO := NVL(PACK_ESTOQUE.CONSULTA_ESTOQUE(V_CD_EMPRCENTRALIZ, :ITEMCOMPRA.CD_ITEM, TRUNC(SYSDATE), 'F', 'QT'),0);&#10;                  &#10;                  SELECT NVL(SUM(QT_PREVISTA),0)&#10;                    INTO V_QT_ESTOQUEPONTOPEDIDO&#10;                    FROM ITEMCOMPRA&#10;                   WHERE NOT EXISTS (SELECT *&#10;                                       FROM ITEMRESERVAMATERIAL&#10;                                      WHERE ITEMRESERVAMATERIAL.ST_ITEMRESERVAMATERIAL NOT IN ('9')&#10;                                        AND ITEMRESERVAMATERIAL.CD_EMPRITEMCOMPRA = ITEMCOMPRA.CD_EMPRESA&#10;                                        AND ITEMRESERVAMATERIAL.NR_ITEMCOMPRA     = ITEMCOMPRA.NR_ITEMCOMPRA&#10;                                        AND ITEMRESERVAMATERIAL.CD_ITEM           = ITEMCOMPRA.CD_ITEM)&#10;                     AND ITEMCOMPRA.CD_EMPRESA IN (SELECT CD_EMPRESA&#10;                                                     FROM PARMCOMPRA&#10;                                                    WHERE CD_EMPRCENTRALIZ = V_CD_EMPRCENTRALIZ)&#10;                     AND ITEMCOMPRA.CD_ITEM = :ITEMCOMPRA.CD_ITEM&#10;                     AND ITEMCOMPRA.ST_ITEMCOMPRA = 14; --dentro do ponto de pedido&#10;                &#10;                ELSE&#10;                  &#10;                  V_QT_ESTOQUEFISICO := NVL(PACK_ESTOQUE.CONSULTA_ESTOQUE(:ITEMCOMPRA.CD_EMPRESA, :ITEMCOMPRA.CD_ITEM, TRUNC(SYSDATE), 'F', 'QT'),0);&#10;                  &#10;                  SELECT NVL(SUM(QT_PREVISTA),0)&#10;                    INTO V_QT_ESTOQUEPONTOPEDIDO&#10;                    FROM ITEMCOMPRA &#10;                   WHERE NOT EXISTS (SELECT *&#10;                                       FROM ITEMRESERVAMATERIAL&#10;                                      WHERE ITEMRESERVAMATERIAL.ST_ITEMRESERVAMATERIAL NOT IN ('9')&#10;                                        AND ITEMRESERVAMATERIAL.CD_EMPRITEMCOMPRA = ITEMCOMPRA.CD_EMPRESA&#10;                                        AND ITEMRESERVAMATERIAL.NR_ITEMCOMPRA     = ITEMCOMPRA.NR_ITEMCOMPRA&#10;                                        AND ITEMRESERVAMATERIAL.CD_ITEM           = ITEMCOMPRA.CD_ITEM)&#10;                     AND ITEMCOMPRA.CD_ITEM       = :ITEMCOMPRA.CD_ITEM&#10;                     AND ITEMCOMPRA.CD_EMPRESA    = :ITEMCOMPRA.CD_EMPRESA&#10;                     AND ITEMCOMPRA.ST_ITEMCOMPRA = 14; --dentro do ponto de pedido&#10;                END IF;&#10;                &#10;                IF ROUND(NVL(V_QT_ESTOQUEFISICO,0) - NVL(V_QT_ESTOQUEPONTOPEDIDO,0) - NVL(:ITEMCOMPRA.QT_PREVISTA,0),2) >= ROUND(NVL(V_QT_PONTOPEDIDO,0),2) THEN&#10;                  V_ST_ITEMCOMPRA := 14;&#10;                  V_DT_LIBERACAO   := SYSDATE;&#10;                END IF;&#10;              END IF;&#10;            END IF;&#10;          END IF;&#10;          &#10;          /* DCS:03/10/2013:62048&#10;           * Caso esteja ativo o controle de Contrato de Compra e a solicitaçao não caiu em ponto de pedido&#10;           * a mesma será bloqueada para liberação no programa COM002, onde poderá gerar o pedido caso possuir contrato de compra&#10;           */&#10;           /*FJC:10/04/2017:105292 adicionado condição OR sobre processo de contrato compra por empresa*/&#10;          IF (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_CONTRATOCOMPRA')    ,'N') = 'S' OR&#10;              NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',V_CD_EMPRLANCTO,'ST_CONTRATOCOMPRA')       ,'N') = 'S' OR&#10;              NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CONTRATOCOMPRA'),'N') = 'S') &#10;            OR &#10;             (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_CONTRATOCOMPRAEMPR')    ,'N') = 'S' OR  &#10;              NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',V_CD_EMPRLANCTO,'ST_CONTRATOCOMPRAEMPR')       ,'N') = 'S' OR  &#10;              NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CONTRATOCOMPRAEMPR'),'N') = 'S') THEN&#10;             &#10;             &#10;            IF V_ST_ITEMCOMPRA &#60;> 14 THEN&#10;              V_ST_ITEMCOMPRA := 0;&#10;              V_DT_LIBERACAO   := NULL;&#10;            END IF;&#10;          END IF;&#10;                &#10;          &#10;          /* DCS:19/11/2013:63403&#10;           * Caso esteja ativo o controle de Alçadas por Departamento e a solicitação não caiu em ponto de pedido&#10;           * a mesma será bloqueada para liberação no programa COM002&#10;           */&#10;          IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_ALCADASDEPTO')    ,'N') = 'S' OR &#10;             NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',V_CD_EMPRLANCTO,'ST_ALCADASDEPTO')       ,'N') = 'S' OR&#10;             NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_ALCADASDEPTO'),'N') = 'S' THEN&#10;             &#10;            IF V_ST_ITEMCOMPRA &#60;> 14 THEN&#10;              V_ST_ITEMCOMPRA := 0;&#10;              V_DT_LIBERACAO   := NULL;&#10;            END IF;&#10;          END IF;&#10;          &#10;          &#10;          &#10;          IF PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:CONTROLE.CD_EMPRESA,'ST_BLOQUEIONIVEL') = 'S' THEN&#10;            V_ST_BLOQUEIONIVEL := 0;&#10;          END IF;&#10;          &#10;          BEGIN&#10;            SELECT ITEMCOMPRA.NR_ITEMCOMPRA&#10;              INTO V_NR_ITEMCOMPRA_AUX&#10;              FROM ITEMCOMPRA&#10;             WHERE ITEMCOMPRA.CD_EMPRESA    = V_CD_EMPRLANCTO&#10;                AND ITEMCOMPRA.NR_ITEMCOMPRA = :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;          EXCEPTION&#10;            WHEN OTHERS THEN&#10;              V_NR_ITEMCOMPRA_AUX := NULL;&#10;          END;&#10;          &#10;          BEGIN --eml:04/05:2020:140279&#10;            SELECT CD_EMPRESA, CD_ITEM&#10;              INTO V_CD_EMPRESACOM77, V_CD_ITEMCOM77&#10;              FROM ITEMAUTORIZADOR&#10;             WHERE ITEMAUTORIZADOR.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#10;               AND ITEMAUTORIZADOR.CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#10;          EXCEPTION&#10;            WHEN OTHERS THEN&#10;              NULL;&#10;          END;  &#10;          &#10;          IF V_CD_EMPRESACOM77 IS NOT NULL AND V_CD_ITEMCOM77 IS NOT NULL THEN&#10;            V_ST_ITEMCOMPRA := 0;&#10;          END IF;  &#10;            &#10;    &#10;          --Na Inserção valida caso acontecer de não gerar o número do Lote de Compra, não permitir prosseguir com o lançamento&#10;          IF V_NR_ITEMCOMPRA_AUX IS NULL AND I_NR_LOTECOMPRA IS NULL THEN&#10;            I_MENSAGEM := 'Não foi possível gerar o número do Lote de Compra para este lançamento. Verifique.';&#10;            RAISE E_GERAL;&#10;          &#10;          --Na Alteração valida  se o número do lote de compra não foi informado&#10;          ELSIF V_NR_ITEMCOMPRA_AUX IS NOT NULL AND :CONTROLE.NR_LOTECOMPRA IS NULL THEN&#10;            &#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21552, NULL); --O número do Lote de Compra deve ser informado.&#10;            RAISE E_GERAL;&#10;          END IF;&#10;          &#10;          /** WLV:16/02/2012:40906&#10;            * Verificação se o usuário alterou ou não a solicitação de compra, se ele alterou, então estoura&#10;            * o alerta, caso não alterou não faz nada.&#10;            */  &#10;          IF :CONTROLE.NR_LOTECOMPRA IS NOT NULL THEN&#10;            &#10;            V_RECORD := :SYSTEM.CURSOR_RECORD;&#10;            &#10;            PACK_GRAVALIBERACAO.VERIFICA_DADOS_MODIFICADOS(V_RETORNO, I_MENSAGEM);&#10;            &#10;            GO_RECORD(V_RECORD);&#10;            &#10;            IF NOT V_RETORNO THEN  /* WLV:07/02/2012:40906*/&#10;              IF V_FLAG = 0 THEN&#10;                V_FLAG := 1;&#10;                SET_ALERT_PROPERTY('MENSAGEM_CONFIRMACAO', ALERT_MESSAGE_TEXT, 'Tem certeza que deseja atualizar a(s) Solicitação(ões) de Compra(s) da Empresa '||V_CD_EMPRLANCTO||' e Lote de Compra '||:CONTROLE.NR_LOTECOMPRA||' ?');&#10;                V_ALERT := SHOW_ALERT('MENSAGEM_CONFIRMACAO');&#10;                IF V_ALERT=ALERT_BUTTON1 THEN&#10;                  NULL;&#10;                ELSE&#10;                  RAISE E_SAIDA;  &#10;                END IF;&#10;              ELSE&#10;                NULL;&#10;              END IF; --IF V_FLAG = 0 THEN  &#10;            ELSE          &#10;              MENSAGEM_PADRAO(15578, NULL);  &#10;              RAISE E_SAIDA;&#10;            END IF; -- IF NOT V_RETORNO THEN&#10;          END IF; --IF :CONTROLE.NR_LOTECOMPRA IS NOT NULL THEN&#10;          &#10;          &#10;          IF NVL(:ITEMCOMPRA.ST_CRONOGRAMACOMPRA,'X') = 'N' THEN&#10;            IF :GLOBAL.ST_AUDITORIA = 'S' THEN&#10;              PACK_AUDITA.INSERIR('I', 'O Usuário aceitou continuar com a geração da Solicitação de Compra ('||:ITEMCOMPRA.NR_ITEMCOMPRA||') da Empresa ('||V_CD_EMPRLANCTO||'), '||&#10;                                       'mesmo sabendo que o Item ('||:ITEMCOMPRA.CD_ITEM||'), está fora do Cronograma.',NULL);&#10;            END IF;&#10;          END IF;&#10;                    &#10;          BEGIN&#10;            INSERT INTO ITEMCOMPRA&#10;              (CD_AUTORIZADOR,&#10;               CD_BEMPAT,&#10;               CD_EMPRESA,&#10;               CD_EMPRESAITEM,&#10;               CD_EMPRESASOLIC,&#10;               CD_EMPRESAUTORIZ,&#10;               CD_ENDERENTREGA,&#10;               CD_ITEM,&#10;               CD_MOVIMENTACAO,&#10;               CD_PROJETO,&#10;               CD_SOLICITANTE,&#10;               DS_OBSERVACAOEXT,&#10;               DS_OBSERVACAO,&#10;               DS_ITEMSERVICO,&#10;               DT_ALTERACAO,&#10;               DT_CONSOLIDACAO,&#10;               DT_DESEJADA,&#10;               DT_INICIO,&#10;               DT_LIBERACAO,&#10;               DT_RECORD,&#10;               DT_SOLICITACAO,&#10;               HR_RECORD,&#10;               NR_ITEMCOMPRA,&#10;               NR_ITEMPRORIGEM,&#10;               NR_NEGOCIACAO,&#10;               QT_NEGOCIADA,&#10;               QT_PREVISTA,&#10;               ST_EMISSAONF,&#10;               ST_ITEMCOMPRA,&#10;               DS_OBSCANCEL,&#10;               DT_CANCELAMENTO,&#10;               TP_APROVSOLIC,&#10;               NR_LOTECOMPRA,&#10;               CD_TIPOCOMPRA,&#10;               VL_ESTIMADO,&#10;               ST_BLOQUEIONIVEL,&#10;               NR_CONTRATO, --ALE:25/11/2011:36255&#10;               CD_DEPARTAMENTO,&#10;               ST_CRONOGRAMACOMPRA,&#10;               CD_CONTAORCAMENTO,&#10;               CD_ESTUDOMONI,&#10;               CD_PROJETOMONI,&#10;               NR_VERSAOMONI,&#10;               CD_ETAPAMONI,&#10;               DT_ANOSAFRA,&#10;               CD_PROJETOCOMPRA, /* ASF:17/06/2019:134714 */ &#10;               CD_TIPOLOCALARMAZ, /*EML:26/05/2020:148401*/&#10;               CD_LOCALARMAZ,&#10;               NR_SUBLOCARMAZ1,&#10;               NR_SUBLOCARMAZ2,&#10;               NR_SUBLOCARMAZ3,&#10;               NR_SUBLOCARMAZ4)&#10;            VALUES&#10;              (:CONTROLE.CD_AUTORIZADOR,&#10;               NULL,&#10;               V_CD_EMPRLANCTO,&#10;               V_CD_EMPRLANCTO,&#10;               V_CD_EMPRLANCTO,&#10;               V_CD_EMPRLANCTO,&#10;               NULL,&#10;               :ITEMCOMPRA.CD_ITEM,&#10;               :ITEMCOMPRA.CD_MOVIMENTACAO,&#10;               NULL,&#10;               :GLOBAL.CD_USUARIO,&#10;               :ITEMCOMPRA.DS_OBSERVACAOEXT,&#10;               :ITEMCOMPRA.DS_OBSERVACAO,&#10;               :ITEMCOMPRA.DS_ITEMSERVICO,&#10;               NULL,&#10;               NULL,&#10;               :CONTROLE.DT_DESEJADA,--:ITEMCOMPRA.DT_DESEJADA,&#10;               :ITEMCOMPRA.DT_INICIO,&#10;               NULL,&#10;               SYSDATE,&#10;               SYSDATE, --RBM:19472:12/08/2008 Alterado para gravar a hora tambem.&#10;               TO_CHAR(SYSDATE, 'HH24:MI'),&#10;               :ITEMCOMPRA.NR_ITEMCOMPRA,&#10;               NULL,&#10;               NULL,&#10;               NULL,&#10;               :ITEMCOMPRA.QT_PREVISTA,&#10;               NULL,&#10;               V_ST_ITEMCOMPRA,&#10;               :ITEMCOMPRA.DS_OBSCANCEL,&#10;               NULL,&#10;               :ITEMCOMPRA.TP_APROVSOLIC,&#10;               I_NR_LOTECOMPRA,&#10;               :ITEMCOMPRA.CD_TIPOCOMPRA,&#10;               :ITEMCOMPRA.VL_ESTIMADO,&#10;               V_ST_BLOQUEIONIVEL,       --RBM:24044:17/12/2009&#10;               :CONTROLE.NR_CONTRATO,   --ALE:25/11/2011:36255&#10;               :CONTROLE.CD_DEPARTAMENTO,&#10;               :ITEMCOMPRA.ST_CRONOGRAMACOMPRA, --DCS:11/02/2014:58880&#10;               :ITEMCOMPRA.CD_CONTAORCAMENTO,&#10;               :ITEMCOMPRA.CD_ESTUDOMONI,&#10;               :ITEMCOMPRA.CD_PROJETOMONI,&#10;               :ITEMCOMPRA.NR_VERSAOMONI,&#10;               :ITEMCOMPRA.CD_ETAPAMONI,&#10;               :CONTROLE.DT_ANOSAFRA,/* ASF:17/06/2019:134714 */ &#10;               :CONTROLE.CD_PROJETOCOMPRA, /*GBO:20/12/2019:142153*/&#10;               :ITEMCOMPRA.CD_TIPOLOCALARMAZ, /*EML:26/05/2020:148401*/&#10;               :ITEMCOMPRA.CD_LOCALARMAZ,&#10;               :ITEMCOMPRA.NR_SUBLOCARMAZ1,&#10;               :ITEMCOMPRA.NR_SUBLOCARMAZ2,&#10;               :ITEMCOMPRA.NR_SUBLOCARMAZ3,&#10;               :ITEMCOMPRA.NR_SUBLOCARMAZ4);&#10;  &#10;            IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;              PACK_AUDITORIA.INSERE_LOGUSUARIO('Inseriu na tabela ITEMCOMPRA os valores: '||&#10;                                               'CD_AUTORIZADOR   = '||:CONTROLE.CD_AUTORIZADOR    ||', CD_BEMPAT = NULL , CD_EMPRESA = '||V_CD_EMPRLANCTO||', CD_EMPRESAITEM'||V_CD_EMPRLANCTO||', '||&#10;                                               'CD_EMPRESASOLIC  = '||V_CD_EMPRLANCTO              ||', CD_EMPRESAUTORIZ = '||V_CD_EMPRLANCTO||', CD_ENDERENTREGA =  NULL, CD_ITEM'||:ITEMCOMPRA.CD_ITEM||', '||&#10;                                               'CD_MOVIMENTACAO  = '||:ITEMCOMPRA.CD_MOVIMENTACAO ||', CD_PROJETO   = NULL , CD_SOLICITANTE  = '||:GLOBAL.CD_USUARIO||', DS_ITEMSERVICO = '||:ITEMCOMPRA.DS_ITEMSERVICO||', '||&#10;                                               'DS_OBSERVACAOEXT = '||:ITEMCOMPRA.DS_OBSERVACAOEXT||', DS_OBSERVACAO = '||:ITEMCOMPRA.DS_OBSERVACAO||', DT_ALTERACAO = NULL , DT_CONSOLIDACAO = NULL, DT_DESEJADA = '||:ITEMCOMPRA.DT_DESEJADA||', '||&#10;                                               'DT_INICIO        = '||:ITEMCOMPRA.DT_INICIO       ||', DT_LIBERACAO = NULL , DT_RECORD = '||SYSDATE||', DT_SOLICITACAO = '||SYSDATE||', '||&#10;                                               'HR_RECORD        = '||TO_CHAR(SYSDATE,'HH24:MI')  ||', NR_ITEMCOMPRA= '    ||:ITEMCOMPRA.NR_ITEMCOMPRA||', NR_ITEMPRORIGEM = NULL, NR_NEGOCIACAO = NULL, '||&#10;                                               'QT_NEGOCIADA     =  NULL, QT_PREVISTA = '         ||:ITEMCOMPRA.QT_PREVISTA||', ST_EMISSAONF = NULL, ST_ITEMCOMPRA = '||V_ST_ITEMCOMPRA||','||&#10;                                               'DS_OBSCANCEL     = '||:ITEMCOMPRA.DS_OBSCANCEL    ||', DT_CANCELAMENTO = NULL, TP_APROVSOLIC = '||:ITEMCOMPRA.TP_APROVSOLIC||', NR_LOTECOMPRA, '||&#10;                                               'CD_TIPOCOMPRA    = '||:ITEMCOMPRA.CD_TIPOCOMPRA   ||', VL_ESTIMADO = '     ||:ITEMCOMPRA.VL_ESTIMADO||', ST_BLOQUEIONIVEL ='||V_ST_BLOQUEIONIVEL||', NR_CONTRATO ='||:CONTROLE.NR_CONTRATO||', '||&#10;                                               'CD_ESTUDOMONI    = '||:ITEMCOMPRA.CD_ESTUDOMONI   ||', CD_PROJETOMONI = '     ||:ITEMCOMPRA.CD_PROJETOMONI||', NR_VERSAOMONI ='||:ITEMCOMPRA.NR_VERSAOMONI||', CD_ETAPAMONI ='||:ITEMCOMPRA.CD_ETAPAMONI||', '||&#10;                                               'ST_CRONOGRAMACOMPRA = '||:ITEMCOMPRA.ST_CRONOGRAMACOMPRA,&#10;                                               NULL,&#10;                                               'I'); &#10;            END IF;  --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN  &#10;          EXCEPTION&#10;            WHEN DUP_VAL_ON_INDEX THEN&#10;              BEGIN&#10;                UPDATE ITEMCOMPRA  &#10;                   SET ITEMCOMPRA.CD_AUTORIZADOR   = :CONTROLE.CD_AUTORIZADOR,&#10;                        ITEMCOMPRA.CD_BEMPAT        = NULL,&#10;                        ITEMCOMPRA.CD_EMPRESA       = V_CD_EMPRLANCTO,&#10;                        ITEMCOMPRA.CD_EMPRESAITEM   = V_CD_EMPRLANCTO,&#10;                       ITEMCOMPRA.CD_EMPRESASOLIC  = V_CD_EMPRLANCTO,           &#10;                       ITEMCOMPRA.CD_EMPRESAUTORIZ = V_CD_EMPRLANCTO,     &#10;                       ITEMCOMPRA.CD_ENDERENTREGA  = NULL,&#10;                       ITEMCOMPRA.CD_ITEM          = :ITEMCOMPRA.CD_ITEM,&#10;                       ITEMCOMPRA.CD_MOVIMENTACAO  = :ITEMCOMPRA.CD_MOVIMENTACAO,&#10;                       ITEMCOMPRA.CD_PROJETO       = NULL,&#10;                       ITEMCOMPRA.CD_SOLICITANTE   =  :GLOBAL.CD_USUARIO,&#10;                       ITEMCOMPRA.DS_OBSERVACAOEXT = :ITEMCOMPRA.DS_OBSERVACAOEXT,&#10;                       ITEMCOMPRA.DS_OBSERVACAO    = :ITEMCOMPRA.DS_OBSERVACAO,       &#10;                       ITEMCOMPRA.DS_ITEMSERVICO   = :ITEMCOMPRA.DS_ITEMSERVICO,&#10;                       ITEMCOMPRA.DT_ALTERACAO      = NULL,&#10;                       ITEMCOMPRA.DT_CONSOLIDACAO  = NULL, &#10;                       ITEMCOMPRA.DT_DESEJADA      = :ITEMCOMPRA.DT_DESEJADA,&#10;                       ITEMCOMPRA.DT_INICIO         = :ITEMCOMPRA.DT_INICIO,         &#10;                       ITEMCOMPRA.DT_LIBERACAO      = NULL,&#10;                       ITEMCOMPRA.DT_RECORD         =  SYSDATE,&#10;                       ITEMCOMPRA.DT_SOLICITACAO   = SYSDATE,&#10;                       ITEMCOMPRA.HR_RECORD         =  TO_CHAR(SYSDATE,'HH24:MI'),&#10;                       ITEMCOMPRA.NR_ITEMCOMPRA     = :ITEMCOMPRA.NR_ITEMCOMPRA,&#10;                       ITEMCOMPRA.NR_ITEMPRORIGEM   =  NULL,&#10;                       ITEMCOMPRA.NR_NEGOCIACAO    = NULL,&#10;                       ITEMCOMPRA.QT_NEGOCIADA     = NULL,          &#10;                       ITEMCOMPRA.QT_PREVISTA       = :ITEMCOMPRA.QT_PREVISTA,&#10;                       ITEMCOMPRA.ST_EMISSAONF     = NULL,&#10;                       ITEMCOMPRA.ST_ITEMCOMPRA    = V_ST_ITEMCOMPRA,&#10;                       ITEMCOMPRA.DS_OBSCANCEL     = :ITEMCOMPRA.DS_OBSCANCEL,&#10;                       ITEMCOMPRA.DT_CANCELAMENTO   =  NULL,&#10;                       ITEMCOMPRA.TP_APROVSOLIC    = :ITEMCOMPRA.TP_APROVSOLIC,&#10;                       ITEMCOMPRA.NR_LOTECOMPRA    = :CONTROLE.NR_LOTECOMPRA,        &#10;                       ITEMCOMPRA.CD_TIPOCOMPRA    = :ITEMCOMPRA.CD_TIPOCOMPRA,&#10;                       ITEMCOMPRA.VL_ESTIMADO      = :ITEMCOMPRA.VL_ESTIMADO,&#10;                       ITEMCOMPRA.ST_BLOQUEIONIVEL = V_ST_BLOQUEIONIVEL,       --RBM:24044:17/12/2009&#10;                       ITEMCOMPRA.NR_CONTRATO       = :CONTROLE.NR_CONTRATO,   --ALE:25/11/2011:36255&#10;                       ITEMCOMPRA.CD_DEPARTAMENTO  = :CONTROLE.CD_DEPARTAMENTO,&#10;                       ITEMCOMPRA.ST_CRONOGRAMACOMPRA = :ITEMCOMPRA.ST_CRONOGRAMACOMPRA,&#10;                       ITEMCOMPRA.CD_CONTAORCAMENTO   = :ITEMCOMPRA.CD_CONTAORCAMENTO,&#10;                       ITEMCOMPRA.CD_ESTUDOMONI       = :ITEMCOMPRA.CD_ESTUDOMONI,&#10;                       ITEMCOMPRA.CD_PROJETOMONI      = :ITEMCOMPRA.CD_PROJETOMONI,&#10;                       ITEMCOMPRA.NR_VERSAOMONI       = :ITEMCOMPRA.NR_VERSAOMONI,&#10;                       ITEMCOMPRA.CD_ETAPAMONI        = :ITEMCOMPRA.CD_ETAPAMONI,&#10;                       ITEMCOMPRA.CD_PROJETOCOMPRA    = :CONTROLE.CD_PROJETOCOMPRA, &#10;                       ITEMCOMPRA.CD_TIPOLOCALARMAZ   = :ITEMCOMPRA.CD_TIPOLOCALARMAZ,&#10;                       ITEMCOMPRA.CD_LOCALARMAZ       = :ITEMCOMPRA.CD_LOCALARMAZ,&#10;                       ITEMCOMPRA.NR_SUBLOCARMAZ1     = :ITEMCOMPRA.NR_SUBLOCARMAZ1,&#10;                       ITEMCOMPRA.NR_SUBLOCARMAZ2     = :ITEMCOMPRA.NR_SUBLOCARMAZ2,&#10;                       ITEMCOMPRA.NR_SUBLOCARMAZ3     = :ITEMCOMPRA.NR_SUBLOCARMAZ3,&#10;                       ITEMCOMPRA.NR_SUBLOCARMAZ4     = :ITEMCOMPRA.NR_SUBLOCARMAZ4&#10;                 WHERE ITEMCOMPRA.CD_EMPRESA        = V_CD_EMPRLANCTO&#10;                   AND ITEMCOMPRA.NR_ITEMCOMPRA     = :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;                &#10;                IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;                  PACK_AUDITORIA.INSERE_LOGUSUARIO('Atualizou a tabela ITEMCOMPRA no Registro da empresa: '||V_CD_EMPRLANCTO||', NR_ITEMCOMPRA = '||:ITEMCOMPRA.NR_ITEMCOMPRA||' Os Valores : '||&#10;                                                    &#10;                                                   'CD_AUTORIZADOR   = '||:CONTROLE.CD_AUTORIZADOR    ||', CD_BEMPAT = NULL , CD_EMPRESA = '||V_CD_EMPRLANCTO||', CD_EMPRESAITEM'||V_CD_EMPRLANCTO||', '||&#10;                                                   'CD_EMPRESASOLIC  = '||V_CD_EMPRLANCTO              ||', CD_EMPRESAUTORIZ = '||V_CD_EMPRLANCTO||', CD_ENDERENTREGA =  NULL, CD_ITEM'||:ITEMCOMPRA.CD_ITEM||', '||&#10;                                                   'CD_MOVIMENTACAO  = '||:ITEMCOMPRA.CD_MOVIMENTACAO ||', CD_PROJETO   = NULL , CD_SOLICITANTE  = '||:GLOBAL.CD_USUARIO||', DS_ITEMSERVICO = '||:ITEMCOMPRA.DS_ITEMSERVICO||', '||&#10;                                                   'DS_OBSERVACAOEXT = '||:ITEMCOMPRA.DS_OBSERVACAOEXT||', DS_OBSERVACAO = '||:ITEMCOMPRA.DS_OBSERVACAO||', DT_ALTERACAO = NULL , DT_CONSOLIDACAO = NULL, DT_DESEJADA = '||:ITEMCOMPRA.DT_DESEJADA||', '||&#10;                                                   'DT_INICIO        = '||:ITEMCOMPRA.DT_INICIO       ||', DT_LIBERACAO = NULL , DT_RECORD = '||SYSDATE||', DT_SOLICITACAO = '||SYSDATE||', '||&#10;                                                   'HR_RECORD        = '||TO_CHAR(SYSDATE,'HH24:MI')  ||', NR_ITEMCOMPRA= '    ||:ITEMCOMPRA.NR_ITEMCOMPRA||', NR_ITEMPRORIGEM = NULL, NR_NEGOCIACAO = NULL, '||&#10;                                                   'QT_NEGOCIADA     =  NULL, QT_PREVISTA = '         ||:ITEMCOMPRA.QT_PREVISTA||', ST_EMISSAONF = NULL, ST_ITEMCOMPRA = '||V_ST_ITEMCOMPRA||','||&#10;                                                   'DS_OBSCANCEL     = '||:ITEMCOMPRA.DS_OBSCANCEL    ||', DT_CANCELAMENTO = NULL, TP_APROVSOLIC = '||:ITEMCOMPRA.TP_APROVSOLIC||', NR_LOTECOMPRA, '||&#10;                                                   'CD_TIPOCOMPRA    = '||:ITEMCOMPRA.CD_TIPOCOMPRA   ||', VL_ESTIMADO = '     ||:ITEMCOMPRA.VL_ESTIMADO||', ST_BLOQUEIONIVEL ='||V_ST_BLOQUEIONIVEL||', NR_CONTRATO ='||:CONTROLE.NR_CONTRATO||', '||&#10;                                                   'ST_CRONOGRAMACOMPRA = '||:ITEMCOMPRA.ST_CRONOGRAMACOMPRA,&#10;                                                   NULL,&#10;                                                   'A');&#10;                END IF; --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;            EXCEPTION&#10;              WHEN OTHERS THEN&#10;                --Erro ao Atualizar o registro da Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢. ¥Detalhes ¢DS_DETALHE¢¥&#10;                I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864,'¢NM_TABELA='||'ITEMCOMPRA'||'¢SQLERRM='||SQLERRM||'¢DS_DETALHE='||'Gatilho KEY_COMMIT'||'¢');&#10;                RAISE E_GERAL;&#10;            END;&#10;          WHEN OTHERS THEN&#10;            --Erro ao inserir dados na tabela ¢NM_TABELA¢. Erro: ¢SQLERRM¢.§¥Local: ¢DS_LOCAL¢&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7314,'¢NM_TABELA='||'ITEMCOMPRA'||'¢SQLERRM='||SQLERRM||'¢DS_LOCAL='||'Gatilho KEY-COMMIT'||'¢');&#10;            RAISE E_GERAL;&#10;          END;&#10;&#10;          /*MHU:06/05/2020:135245*/&#10;          --Atualização dos itens usados&#10;            BEGIN&#10;              UPDATE PREITEMCOMPRA&#10;                 SET PREITEMCOMPRA.CD_EMPRITEM = :ITEMCOMPRA.CD_EMPRESA,&#10;                     PREITEMCOMPRA.NR_LOTECOMPRA = I_NR_LOTECOMPRA,&#10;                     PREITEMCOMPRA.ST_PREITEMCOMPRA = '7'&#10;               WHERE PREITEMCOMPRA.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#10;                 AND PREITEMCOMPRA.NR_PREITEMCOMPRA = :ITEMCOMPRA.NR_PREITEMCOMPRA;&#10;            EXCEPTION&#10;              WHEN OTHERS THEN &#10;                NULL;&#10;            END;&#10;          &#10;      &#10;          IF :ITEMCOMPRA.NR_REGBLOCO IS NOT NULL THEN&#10;            FOR PROJ IN 1..PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO.COUNT LOOP&#10;              IF PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO.EXISTS(PROJ) AND              &#10;                PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO(PROJ).NR_REGBLOCO  = :ITEMCOMPRA.NR_REGBLOCO THEN&#10;                &#10;                PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO(PROJ).CD_EMPRITEMCOMPRA := V_CD_EMPRLANCTO ;&#10;                PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO(PROJ).NR_ITEMCOMPRA     := :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;                PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO(PROJ).NR_LOTECOMPRA     := NVL(I_NR_LOTECOMPRA ,:CONTROLE.NR_LOTECOMPRA);        &#10;                PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO(PROJ).CD_ITEM           := :ITEMCOMPRA.CD_ITEM;&#10;                &#10;                PACK_PROJETOMONI.SET_VETOR_PROJETORATEIO(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO);&#10;                &#10;              END IF;&#10;            END LOOP; &#10;          END IF; &#10;          &#10;          /* DCS:19/11/2013:63403&#10;           * Caso esteja ativo o controle de Alçadas por Departamento e a solicitaçao não caiu em ponto de pedido&#10;           * será gerado o registro para controle de liberação por Autorizador de Necessidade no COM002&#10;           */&#10;          IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_ALCADASDEPTO')    ,'N') = 'S' OR &#10;             NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',V_CD_EMPRLANCTO,'ST_ALCADASDEPTO')       ,'N') = 'S' OR&#10;             NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_ALCADASDEPTO'),'N') = 'S' THEN&#10;            &#10;            IF V_ST_ITEMCOMPRA = 0 THEN&#10;              &#10;              --Limpa os Nives de Liberação, para inserir novamente&#10;              BEGIN&#10;                DELETE FROM ITEMCOMPRAUTORIZ&#10;                 WHERE CD_EMPRESA    = V_CD_EMPRLANCTO&#10;                   AND NR_ITEMCOMPRA = :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;              EXCEPTION&#10;                WHEN OTHERS THEN&#10;                  --Erro ao Excluir o registro da Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢. ¥Detalhes ¢DS_DETALHE¢¥.&#10;                  I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1782, '¢NM_TABELA='||'ITEMCOMPRAUTORIZ'||'¢SQLERRM='||SQLERRM||&#10;                                                                '¢DS_DETALHE='||'Erro ao Limpar o niveis de Liberação da Solicitação de compra ('||:ITEMCOMPRA.NR_ITEMCOMPRA||') '||&#10;                                                                                'da Empresa ('||V_CD_EMPRLANCTO||').'||'¢');&#10;                  RAISE E_GERAL;&#10;              END;&#10;              &#10;              FOR J IN (SELECT CD_AUTORIZADOR,ST_APROVNECESSIDADE&#10;                          FROM AUTORIZDEPARTCOMPRA&#10;                         WHERE CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;                           AND ST_APROVNECESSIDADE = 'S') LOOP&#10;                &#10;                BEGIN&#10;                  INSERT INTO ITEMCOMPRAUTORIZ&#10;                      (CD_EMPRESA,NR_ITEMCOMPRA,CD_AUTORIZADOR,ST_APROVNECESSIDADE,ST_LIBERACAO,DT_RECORD)&#10;                    VALUES&#10;                      (V_CD_EMPRLANCTO,&#10;                       :ITEMCOMPRA.NR_ITEMCOMPRA,&#10;                       J.CD_AUTORIZADOR,&#10;                       J.ST_APROVNECESSIDADE,&#10;                       0, --0 - Aguardando Liberação&#10;                       SYSDATE);&#10;                EXCEPTION&#10;                  WHEN DUP_VAL_ON_INDEX THEN&#10;                    &#10;                    BEGIN&#10;                      UPDATE ITEMCOMPRAUTORIZ&#10;                         SET ST_LIBERACAO = 0, --0 - Aguardando Liberação&#10;                             DT_RECORD    = SYSDATE&#10;                       WHERE CD_EMPRESA          = V_CD_EMPRLANCTO&#10;                         AND NR_ITEMCOMPRA       = :ITEMCOMPRA.NR_ITEMCOMPRA&#10;                         AND CD_AUTORIZADOR      = J.CD_AUTORIZADOR&#10;                         AND ST_APROVNECESSIDADE = J.ST_APROVNECESSIDADE;&#10;                    EXCEPTION&#10;                      WHEN OTHERS THEN&#10;                        --Erro ao Atualizar o registro da Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢. ¥Detalhes ¢DS_DETALHE¢¥.&#10;                        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864, '¢NM_TABELA='||'ITEMCOMPRAUTORIZ'||'¢SQLERRM='||SQLERRM||&#10;                                                                      '¢DS_DETALHE='||'Erro ao atualizar o nível de Liberação da Solicitação de compra ('||:ITEMCOMPRA.NR_ITEMCOMPRA||') '||&#10;                                                                                      'da Empresa ('||V_CD_EMPRLANCTO||').'||'¢');&#10;                        RAISE E_GERAL;&#10;                    END;&#10;                    &#10;                  WHEN OTHERS THEN&#10;                    --Erro ao Incluir Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢.¥Detalhes ¢DS_DETALHE¢¥.&#10;                    I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1451, '¢NM_TABELA='||'ITEMCOMPRAUTORIZ'||'¢SQLERRM='||SQLERRM||&#10;                                                                  '¢DS_DETALHE='||'Erro ao inserir o nível de Liberação da Solicitação de compra ('||:ITEMCOMPRA.NR_ITEMCOMPRA||') '||&#10;                                                                                  'da Empresa ('||V_CD_EMPRLANCTO||').'||'¢');&#10;                    RAISE E_GERAL;&#10;                END;&#10;              END LOOP;&#10;            END IF;&#10;          END IF;&#10;          &#10;          ------------------------------------------------------------------------------------------------&#10;          -- INSERE ITEMCOMPRACCUSTO&#10;          ------------------------------------------------------------------------------------------------&#10;          V_CD_CENTROCUSTO   := NULL;&#10;          V_CD_NEGOCIO       := NULL;/*CSL:21/12/2010:30317*/&#10;          V_CD_MOVIMENTACAO  := NULL;&#10;          V_CD_AUTORIZADOR   := NULL;&#10;          V_PC_PARTICIPACAO  := NULL;&#10;          V_QT_PEDIDAUNIDSOL := NULL;&#10;          &#10;          FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_CC') LOOP&#10;            V_CD_CENTROCUSTO    := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO'  ,I);&#10;            V_CD_NEGOCIO        := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_NEGOCIO'      ,I);/*CSL:21/12/2010:30317*/&#10;            V_CD_MOVIMENTACAO   := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_MOVIMENTACAO' ,I); &#10;            V_CD_AUTORIZADOR    := GET_GROUP_CHAR_CELL  ('GRUPO_CC.CD_AUTORIZADOR'  ,I);&#10;            V_PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL('GRUPO_CC.PC_PARTICIPACAO' ,I);&#10;            V_QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL('GRUPO_CC.QT_PEDIDAUNIDSOL',I);&#10;            V_CD_EMPRCCUSTODEST := NVL(GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_EMPRCCUSTODEST', I),V_CD_EMPRLANCTO);&#10;            V_DS_OBSERVACAO     := GET_GROUP_CHAR_CELL  ('GRUPO_CC.DS_OBSERVACAO'   ,I);&#10;            V_CD_CONTAORCAMENTO := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CONTAORCAMENTO',I);&#10;            &#10;            IF :ITEMCOMPRA.CD_ITEM = GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM', I) THEN&#10;              BEGIN&#10;                INSERT INTO ITEMCOMPRACCUSTO&#10;                  (CD_AUTORIZADOR,&#10;                   CD_CENTROCUSTO,&#10;                   CD_EMPRESA,&#10;                   CD_EMPRESASOLIC,&#10;                   CD_EMPRESAUTORIZ,&#10;                   CD_MOVIMENTACAO,&#10;                   CD_SOLICITANTE,&#10;                   DT_LIBERACAO,&#10;                   DT_RECORD,&#10;                   HR_RECORD,&#10;                   NR_ITEMCOMPRA,&#10;                   PC_PARTICIPACAO,&#10;                   QT_PEDIDAUNIDSOL,&#10;                   ST_ITEMCOMPRA,&#10;                   CD_NEGOCIO /*CSL:21/12/2010:30317*/,&#10;                   CD_EMPRCCUSTODEST /*GDG:22/07/2011:28715*/,&#10;                   CD_TIPOCOMPRA, --ALE:25/11/2011:36255&#10;                   NR_CONTRATO, --ALE:25/11/2011:36255&#10;                   DS_OBSERVACAO, --DCS:11/02/2014:58880&#10;                   CD_CONTAORCAMENTO)&#10;                VALUES&#10;                  (V_CD_AUTORIZADOR,&#10;                   V_CD_CENTROCUSTO,&#10;                   V_CD_EMPRLANCTO,&#10;                   V_CD_EMPRLANCTO,&#10;                   V_CD_EMPRLANCTO,&#10;                   V_CD_MOVIMENTACAO,&#10;                   :GLOBAL.CD_USUARIO,&#10;                   V_DT_LIBERACAO,&#10;                   SYSDATE,&#10;                   TO_CHAR(SYSDATE, 'HH24:MI'),&#10;                   :ITEMCOMPRA.NR_ITEMCOMPRA,&#10;                   V_PC_PARTICIPACAO,&#10;                   V_QT_PEDIDAUNIDSOL,&#10;                   V_ST_ITEMCOMPRA,&#10;                   V_CD_NEGOCIO /*CSL:21/12/2010:30317*/,&#10;                   V_CD_EMPRCCUSTODEST /*GDG:22/07/2011:28715*/,&#10;                   :CONTROLE.CD_TIPOCOMPRA, --ALE:25/11/2011:36255&#10;                   :CONTROLE.NR_CONTRATO,   --ALE:25/11/2011:36255&#10;                   V_DS_OBSERVACAO,&#10;                   V_CD_CONTAORCAMENTO);&#10;                &#10;                IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;                  PACK_AUDITORIA.INSERE_LOGUSUARIO('Inseriu na tabela ITEMCOMPRACCUSTO os valores: '||&#10;                                                   'CD_AUTORIZADOR  = '||V_CD_AUTORIZADOR           ||', CD_CENTROCUSTO   = '||V_CD_CENTROCUSTO          ||', CD_EMPRESA = '     ||V_CD_EMPRLANCTO||', '||         &#10;                                                   'CD_EMPRESASOLIC = '||V_CD_EMPRLANCTO           ||', CD_EMPRESAUTORIZ = '||V_CD_EMPRLANCTO            ||', CD_MOVIMENTACAO = '||V_CD_MOVIMENTACAO   ||', '||       &#10;                                                   'CD_SOLICITANTE  = '||:GLOBAL.CD_USUARIO         ||',  DT_LIBERACAO     = '||V_DT_LIBERACAO            ||', DT_RECORD = '      ||SYSDATE||',  '||               &#10;                                                   'HR_RECORD       = '||TO_CHAR(SYSDATE,'HH24:MI')||', NR_ITEMCOMPRA    = '||:ITEMCOMPRA.NR_ITEMCOMPRA ||', PC_PARTICIPACAO = '||V_PC_PARTICIPACAO||', '||&#10;                                                   'QT_PEDIDAUNIDSOL= '||V_QT_PEDIDAUNIDSOL        ||', ST_ITEMCOMPRA    = '||V_ST_ITEMCOMPRA           ||', ST_LIBERADO = NULL , '||         &#10;                                                   'DS_OBSCANCEL    = NULL, CD_NEGOCIO = '||V_CD_NEGOCIO||', CD_TIPOCOMPRA  = '||:CONTROLE.CD_TIPOCOMPRA   ||', NR_CONTRATO    = '||:CONTROLE.NR_CONTRATO||', '||&#10;                                                   'DS_OBSERVACAO   = '||V_DS_OBSERVACAO,&#10;                                                   NULL,&#10;                                                   'I'); &#10;                END IF;  --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN &#10;              EXCEPTION&#10;                WHEN DUP_VAL_ON_INDEX THEN&#10;                  BEGIN&#10;                    UPDATE ITEMCOMPRACCUSTO&#10;                       SET ITEMCOMPRACCUSTO.CD_AUTORIZADOR   = V_CD_AUTORIZADOR,             &#10;                           ITEMCOMPRACCUSTO.CD_CENTROCUSTO   = V_CD_CENTROCUSTO,       &#10;                           ITEMCOMPRACCUSTO.CD_EMPRESA        = V_CD_EMPRLANCTO,&#10;                           ITEMCOMPRACCUSTO.CD_EMPRESASOLIC  = V_CD_EMPRLANCTO,       &#10;                           ITEMCOMPRACCUSTO.CD_EMPRESAUTORIZ = V_CD_EMPRLANCTO,        &#10;                           ITEMCOMPRACCUSTO.CD_MOVIMENTACAO  = V_CD_MOVIMENTACAO,&#10;                           ITEMCOMPRACCUSTO.CD_SOLICITANTE   = :GLOBAL.CD_USUARIO,         &#10;                           ITEMCOMPRACCUSTO.DT_LIBERACAO     = V_DT_LIBERACAO,   &#10;                           ITEMCOMPRACCUSTO.ST_ITEMCOMPRA    = V_ST_ITEMCOMPRA,      &#10;                           ITEMCOMPRACCUSTO.DT_RECORD         =  SYSDATE,&#10;                           ITEMCOMPRACCUSTO.HR_RECORD         = TO_CHAR(SYSDATE,'HH24:MI'),&#10;                           ITEMCOMPRACCUSTO.NR_ITEMCOMPRA     = :ITEMCOMPRA.NR_ITEMCOMPRA,    &#10;                           ITEMCOMPRACCUSTO.PC_PARTICIPACAO  = V_PC_PARTICIPACAO,&#10;                           ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL = V_QT_PEDIDAUNIDSOL,&#10;                           ITEMCOMPRACCUSTO.CD_NEGOCIO       = V_CD_NEGOCIO,  /*CSL:21/12/2010:30317*/                             &#10;                           ITEMCOMPRACCUSTO.CD_TIPOCOMPRA     = :CONTROLE.CD_TIPOCOMPRA, --ALE:25/11/2011:36255&#10;                           ITEMCOMPRACCUSTO.NR_CONTRATO       = :CONTROLE.NR_CONTRATO, --ALE:25/11/2011:36255    &#10;                           ITEMCOMPRACCUSTO.DS_OBSERVACAO    = V_DS_OBSERVACAO  ,&#10;                           ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO= V_CD_CONTAORCAMENTO                       &#10;                     WHERE ITEMCOMPRACCUSTO.NR_ITEMCOMPRA      = :ITEMCOMPRA.NR_ITEMCOMPRA&#10;                       AND ITEMCOMPRACCUSTO.CD_EMPRESA         = V_CD_EMPRLANCTO&#10;                       AND ITEMCOMPRACCUSTO.CD_CENTROCUSTO     = V_CD_CENTROCUSTO&#10;                       AND ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST = V_CD_EMPRCCUSTODEST/*GDG:22/07/2011:28715*/;&#10;                  &#10;                  IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;                    PACK_AUDITORIA.INSERE_LOGUSUARIO('Atualizou a tabela ITEMCOMPRACCUSTO no Registro da Empresa: '||V_CD_EMPRLANCTO||&#10;                                                     'NR_ITEMCOMPRA   = '||:ITEMCOMPRA.NR_ITEMCOMPRA ||', CD_CENTROCUSTO   = '||V_CD_CENTROCUSTO||' Os Valores : '||&#10;                                                     'CD_AUTORIZADOR  = '||V_CD_AUTORIZADOR           ||', CD_CENTROCUSTO   = '||V_CD_CENTROCUSTO          ||', CD_EMPRESA = '     ||V_CD_EMPRLANCTO||', '||         &#10;                                                     'CD_EMPRESASOLIC = '||V_CD_EMPRLANCTO           ||', CD_EMPRESAUTORIZ = '||V_CD_EMPRLANCTO            ||', CD_MOVIMENTACAO = '||V_CD_MOVIMENTACAO   ||', '||       &#10;                                                     'CD_SOLICITANTE  = '||:GLOBAL.CD_USUARIO         ||',  DT_LIBERACAO     = '||V_DT_LIBERACAO            ||', DT_RECORD = '      ||SYSDATE||',  '||               &#10;                                                     'HR_RECORD       = '||TO_CHAR(SYSDATE,'HH24:MI')||', NR_ITEMCOMPRA    = '||:ITEMCOMPRA.NR_ITEMCOMPRA ||', PC_PARTICIPACAO = '||V_PC_PARTICIPACAO||', '||&#10;                                                     'QT_PEDIDAUNIDSOL= '||V_QT_PEDIDAUNIDSOL        ||', ST_ITEMCOMPRA    = '||V_ST_ITEMCOMPRA           ||', ST_LIBERADO = NULL , '||         &#10;                                                     'DS_OBSCANCEL    = NULL, CD_NEGOCIO = '||V_CD_NEGOCIO||', CD_TIPOCOMPRA  = '||:CONTROLE.CD_TIPOCOMPRA   ||', NR_CONTRATO    = '||:CONTROLE.NR_CONTRATO||', '||&#10;                                                     'DS_OBSERVACAO   = '||V_DS_OBSERVACAO,&#10;                                                     NULL,&#10;                                                     'A'); &#10;                  END IF;  --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN &#10;                  EXCEPTION&#10;                    WHEN OTHERS THEN&#10;                      --Erro ao Atualizar o registro da Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢. ¥Detalhes ¢DS_DETALHE¢¥&#10;                      I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864,'¢NM_TABELA='||'ITEMCOMPRACCUSTO'||'¢SQLERRM='||SQLERRM||'¢DS_DETALHE='||'Gatilho KEY_COMMIT'||'¢');&#10;                      RAISE E_GERAL;&#10;                  END;&#10;              WHEN OTHERS THEN&#10;                --Erro ao inserir dados na tabela ¢NM_TABELA¢. Erro: ¢SQLERRM¢.§¥Local: ¢DS_LOCAL¢&#10;                I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7314,'¢NM_TABELA='||'ITEMCOMPRACCUSTO'||'¢SQLERRM='||SQLERRM||'¢DS_LOCAL='||'Gatilho KEY-COMMIT'||'¢');&#10;                RAISE E_GERAL;&#10;              END;&#10;            END IF;               &#10;          END LOOP;&#10;----------------------------------------------          &#10;          ------------------------------------------------------------------------------------------------&#10;          -- INSERE ITEMCOMPRANEGOCIO&#10;          ------------------------------------------------------------------------------------------------&#10;          V_CD_CENTROCUSTO   := NULL;&#10;          V_CD_NEGOCIO       := NULL;&#10;          V_CD_MOVIMENTACAO  := NULL;&#10;          V_CD_AUTORIZADOR   := NULL;&#10;          V_PC_PARTICIPACAO  := NULL;&#10;          V_QT_PEDIDAUNIDSOL := NULL;&#10;          &#10;          FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO') LOOP&#10;            ---V_CD_CENTROCUSTO    := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO'  ,I);&#10;            V_CD_NEGOCIO        := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_NEGOCIO'      ,I);/*CSL:21/12/2010:30317*/&#10;            V_CD_MOVIMENTACAO   := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_MOVIMENTACAO' ,I); &#10;            V_CD_AUTORIZADOR    := GET_GROUP_CHAR_CELL  ('GRUPO_NEGOCIO.CD_AUTORIZADOR'  ,I);&#10;            V_PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.PC_PARTICIPACAO' ,I);&#10;            V_QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.QT_PEDIDAUNIDSOL',I);&#10;            V_CD_EMPRCCUSTODEST := NVL(GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_EMPRCCUSTODEST', I),V_CD_EMPRLANCTO);&#10;            V_DS_OBSERVACAO     := GET_GROUP_CHAR_CELL  ('GRUPO_NEGOCIO.DS_OBSERVACAO'   ,I);&#10;            V_CD_CONTAORCAMENTO := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_CONTAORCAMENTO',I);&#10;            &#10;            IF :ITEMCOMPRA.CD_ITEM = GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_ITEM', I) THEN&#10;              BEGIN&#10;                INSERT INTO ITEMCOMPRANEGOCIO&#10;                  ( NR_ITEMCOMPRA       ,&#10;                    CD_EMPRESA          ,&#10;                    CD_SOLICITANTE      ,&#10;                    QT_PEDIDAUNIDSOL    ,&#10;                    PC_PARTICIPACAO     ,&#10;                    CD_MOVIMENTACAO     ,&#10;                    DT_LIBERACAO        ,&#10;                    ST_LIBERADO         ,&#10;                    ST_ITEMCOMPRA       ,&#10;                    DT_RECORD           ,&#10;                    QT_SOLICITADA       ,&#10;                    CD_NEGOCIO          ,&#10;                    CD_EMPRCCUSTODEST   ,&#10;                    DS_OBSERVACAO       ,&#10;                    CD_CONTAORCAMENTO   )&#10;                VALUES&#10;                  ( :ITEMCOMPRA.NR_ITEMCOMPRA ,&#10;                    V_CD_EMPRLANCTO           ,&#10;                    :GLOBAL.CD_USUARIO        ,&#10;                    V_QT_PEDIDAUNIDSOL        ,&#10;                    V_PC_PARTICIPACAO         ,&#10;                    V_CD_MOVIMENTACAO         ,&#10;                    SYSDATE                   ,&#10;                    null                      ,    &#10;                    V_ST_ITEMCOMPRA           ,&#10;                    SYSDATE                   ,&#10;                    :ITEMCOMPRA.QT_PREVISTA   ,&#10;                    V_CD_NEGOCIO              ,&#10;                    V_CD_EMPRCCUSTODEST       ,&#10;                    V_DS_OBSERVACAO           ,&#10;                    V_CD_CONTAORCAMENTO   );&#10;                &#10;                IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;                  PACK_AUDITORIA.INSERE_LOGUSUARIO('INSERT INTO ITEMCOMPRANEGOCIO&#10;                  ( NR_ITEMCOMPRA       = '||:ITEMCOMPRA.NR_ITEMCOMPRA&#10;                  ||' CD_EMPRESA          = '||V_CD_EMPRLANCTO          &#10;                  ||' CD_SOLICITANTE      = '||:GLOBAL.CD_USUARIO       &#10;                  ||' QT_PEDIDAUNIDSOL    = '||V_QT_PEDIDAUNIDSOL       &#10;                  ||' PC_PARTICIPACAO     = '||V_PC_PARTICIPACAO        &#10;                  ||' CD_MOVIMENTACAO     = '||V_CD_MOVIMENTACAO        &#10;                  ||' DT_LIBERACAO        = '||SYSDATE                  &#10;                  ||' ST_LIBERADO         = '||null                     &#10;                  ||' ST_ITEMCOMPRA       = '||V_ST_ITEMCOMPRA          &#10;                  ||' DT_RECORD           = '||SYSDATE                  &#10;                  ||' QT_SOLICITADA       = '||:ITEMCOMPRA.QT_PREVISTA  &#10;                  ||' CD_NEGOCIO          = '||V_CD_NEGOCIO             &#10;                  ||' CD_EMPRCCUSTODEST   = '||V_CD_EMPRCCUSTODEST      &#10;                  ||' DS_OBSERVACAO       = '||V_DS_OBSERVACAO          &#10;                  ||' CD_CONTAORCAMENTO   = '||V_CD_CONTAORCAMENTO ||'  );',&#10;                                                   NULL,&#10;                                                   'I'); &#10;                END IF;  --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN &#10;              EXCEPTION&#10;                WHEN DUP_VAL_ON_INDEX THEN&#10;                  BEGIN&#10;                    UPDATE ITEMCOMPRANEGOCIO&#10;                       SET   CD_SOLICITANTE      = :GLOBAL.CD_USUARIO        ,&#10;                            QT_PEDIDAUNIDSOL    = V_QT_PEDIDAUNIDSOL        ,&#10;                            PC_PARTICIPACAO     = V_PC_PARTICIPACAO         ,&#10;                            CD_MOVIMENTACAO     = V_CD_MOVIMENTACAO         ,&#10;                            DT_LIBERACAO        = SYSDATE                   ,&#10;                            ST_LIBERADO         = null                      ,&#10;                            ST_ITEMCOMPRA       = V_ST_ITEMCOMPRA           ,&#10;                            DT_RECORD           = SYSDATE                   ,&#10;                            QT_SOLICITADA       = :ITEMCOMPRA.QT_PREVISTA   ,&#10;                            DS_OBSERVACAO       = V_DS_OBSERVACAO           ,&#10;                            CD_CONTAORCAMENTO   = V_CD_CONTAORCAMENTO                                         &#10;                     WHERE ITEMCOMPRANEGOCIO.NR_ITEMCOMPRA     = :ITEMCOMPRA.NR_ITEMCOMPRA&#10;                       AND ITEMCOMPRANEGOCIO.CD_EMPRESA        = V_CD_EMPRLANCTO&#10;                       AND ITEMCOMPRANEGOCIO.CD_NEGOCIO        = V_CD_NEGOCIO&#10;                       AND ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST = V_CD_EMPRCCUSTODEST ;&#10;                  &#10;                    IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;                      PACK_AUDITORIA.INSERE_LOGUSUARIO('Atualizou a tabela ITEMCOMPRANEGOCIO ( NR_ITEMCOMPRA       = '||:ITEMCOMPRA.NR_ITEMCOMPRA&#10;                                                      ||' CD_EMPRESA          = '||V_CD_EMPRLANCTO          &#10;                                                      ||' CD_SOLICITANTE      = '||:GLOBAL.CD_USUARIO       &#10;                                                      ||' QT_PEDIDAUNIDSOL    = '||V_QT_PEDIDAUNIDSOL       &#10;                                                      ||' PC_PARTICIPACAO     = '||V_PC_PARTICIPACAO        &#10;                                                      ||' CD_MOVIMENTACAO     = '||V_CD_MOVIMENTACAO        &#10;                                                      ||' DT_LIBERACAO        = '||SYSDATE                  &#10;                                                      ||' ST_LIBERADO         = '||null                     &#10;                                                      ||' ST_ITEMCOMPRA       = '||V_ST_ITEMCOMPRA          &#10;                                                      ||' DT_RECORD           = '||SYSDATE                  &#10;                                                      ||' QT_SOLICITADA       = '||:ITEMCOMPRA.QT_PREVISTA  &#10;                                                      ||' CD_NEGOCIO          = '||V_CD_NEGOCIO             &#10;                                                      ||' CD_EMPRCCUSTODEST   = '||V_CD_EMPRCCUSTODEST      &#10;                                                      ||' DS_OBSERVACAO       = '||V_DS_OBSERVACAO          &#10;                                                      ||' CD_CONTAORCAMENTO   = '||V_CD_CONTAORCAMENTO ||'  );',&#10;                                                       NULL,&#10;                                                       'A'); &#10;                    END IF;  --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN &#10;                    &#10;                  EXCEPTION&#10;                    WHEN OTHERS THEN&#10;                      --Erro ao Atualizar o registro da Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢. ¥Detalhes ¢DS_DETALHE¢¥&#10;                      I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864,'¢NM_TABELA='||'ITEMCOMPRANEGOCIO'||'¢SQLERRM='||SQLERRM||'¢DS_DETALHE='||'Gatilho KEY_COMMIT'||'¢');&#10;                      RAISE E_GERAL;&#10;                  END;&#10;              WHEN OTHERS THEN&#10;                --Erro ao inserir dados na tabela ¢NM_TABELA¢. Erro: ¢SQLERRM¢.§¥Local: ¢DS_LOCAL¢&#10;                I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7314,'¢NM_TABELA='||'ITEMCOMPRANEGOCIO'||'¢SQLERRM='||SQLERRM||'¢DS_LOCAL='||'Gatilho KEY-COMMIT'||'¢');&#10;                RAISE E_GERAL;&#10;              END;&#10;            END IF;               &#10;          END LOOP;&#10;          &#10;          &#10;----------------------------------------------          &#10;          PACK_ORCOMPRAS.GRAVA_ITEMCOMPRARC(:ITEMCOMPRA.CD_EMPRESA, &#10;                                            :ITEMCOMPRA.CD_EMPRESA, /*JFB: 46883: 16/07/2012 */&#10;                                            /*:GLOBAL.CD_EMPRESA,*/&#10;                                            :ITEMCOMPRA.NR_ITEMCOMPRA,&#10;                                            SYSDATE,&#10;                                            :GLOBAL.CD_USUARIO,&#10;                                            V_ST_BLOQUEIO,&#10;                                            I_MENSAGEM);&#10;          V_MSG_BLOQUEIO := NULL;&#10;          IF NVL(V_ST_BLOQUEIO,'N') = 'S' THEN&#10;            V_MSG_BLOQUEIO := I_MENSAGEM;&#10;            I_MENSAGEM     := NULL;&#10;            &#10;            IF V_MSG_BLOQUEIO IS NOT NULL THEN&#10;              V_MSG_BLOQUEIO := REPLACE(V_MSG_BLOQUEIO,'¢MPM=MAX014405¢');&#10;              V_MSG_BLOQUEIO := REPLACE(V_MSG_BLOQUEIO,'¢MPM=MAX013915¢');&#10;              IF V_MENSAGEMFINAL IS NOT NULL THEN&#10;                V_ST_BLOQUEIOFINAL := 'S';&#10;                V_MENSAGEMFINAL := V_MENSAGEMFINAL||' '||CHR(13)||CHR(10)||V_MSG_BLOQUEIO;&#10;              ELSE&#10;                V_ST_BLOQUEIOFINAL := 'S';&#10;                V_MENSAGEMFINAL := V_MSG_BLOQUEIO;&#10;              END IF;&#10;            END IF;  &#10;          END IF; &#10;          &#10;          IF I_MENSAGEM IS NOT NULL THEN &#10;            RAISE E_GERAL;&#10;          END IF;&#10;          /**FLA:17/12/2019:140632&#10;           * Retirada do FAZ_COMMIT para possibilidade de cancelamento da SEL403 sem INSERIR dados. Há um FAZ_COMMIT no fim do código que realiza o commit&#10;           */&#10;          --FAZ_COMMIT;&#10;          &#10;          /*ANS:01/06/2017:110683 -- GERA PROCESSO DE APROVAÇÃO PELO PAA*/&#10;          IF ((V_MSG_BLOQUEIO IS NULL) AND (V_ST_ITEMCOMPRA = 0) AND &#10;            (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_PAAITEMCOMPRA'),'N') = 'S')) THEN&#10;            &#10;            IF (NVL(PACK_ORCOMPRAS.IS_ITEMCOMPRA_CENTRO_CUSTO(V_CD_EMPRLANCTO,&#10;                                                              :ITEMCOMPRA.NR_ITEMCOMPRA,:ITEMCOMPRA.CD_ITEM),'N') = 'S') THEN&#10;              &#10;              V_CD_CENTROCUSTO := NULL;                                           &#10;              FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_CC') LOOP&#10;                V_CD_CENTROCUSTO := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO'  ,I);&#10;                &#10;                IF :ITEMCOMPRA.CD_ITEM = GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM', I) THEN&#10;                  -- ITEMCOMPRA&#10;                  V_CONTEXTO.DELETE;&#10;                  &#10;                  V_CONTEXTO(1).NM_CAMPO := 'TP_APROVACAO';&#10;                  V_CONTEXTO(1).VL_CAMPO := 'SOLICITACAO';&#10;                  &#10;                  V_CONTEXTO(2).NM_CAMPO := 'DS_DADOSAPROVACAO';&#10;                  V_CONTEXTO(2).VL_CAMPO := 'CD_EMPRESA|'||V_CD_EMPRLANCTO||&#10;                                            '|NR_ITEMCOMPRA|'||:ITEMCOMPRA.NR_ITEMCOMPRA||&#10;                                            '|CD_CENTROCUSTO|'||V_CD_CENTROCUSTO;&#10;                  &#10;                  IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN                                  &#10;                    V_CONTEXTO(3).NM_CAMPO := 'CD_DEPARTAMENTO';&#10;                    V_CONTEXTO(3).VL_CAMPO := :CONTROLE.CD_DEPARTAMENTO;&#10;                  END IF;                &#10;                &#10;                  PACK_PAA_COMPRAS.SET_CONTEXTO(V_CONTEXTO);&#10;                  &#10;                  PACK_PAA_ORIGINACAO.POST_PAA('COM',&#10;                                               1,&#10;                                               'LIBERA_SOLICITACAO',&#10;                                               V_CONTEXTO,&#10;                                               V_CD_EMPRLANCTO,&#10;                                               I_MENSAGEM,&#10;                                               V_ID_PROCESSO);&#10;                  &#10;                  IF I_MENSAGEM IS NOT NULL THEN&#10;                    RAISE E_GERAL;&#10;                  END IF;&#10;                    &#10;                END IF;&#10;              END LOOP;&#10;            ELSE&#10;              -- ITEMCOMPRA&#10;              V_CONTEXTO.DELETE;&#10;              &#10;              V_CONTEXTO(1).NM_CAMPO := 'TP_APROVACAO';&#10;              V_CONTEXTO(1).VL_CAMPO := 'SOLICITACAO';&#10;              &#10;              V_CONTEXTO(2).NM_CAMPO := 'DS_DADOSAPROVACAO';&#10;              V_CONTEXTO(2).VL_CAMPO := 'CD_EMPRESA|'||V_CD_EMPRLANCTO||&#10;                                        '|NR_ITEMCOMPRA|'||:ITEMCOMPRA.NR_ITEMCOMPRA||&#10;                                        '|CD_CENTROCUSTO|'||NULL;&#10;                    &#10;              IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN                    &#10;                V_CONTEXTO(3).NM_CAMPO := 'CD_DEPARTAMENTO';&#10;                V_CONTEXTO(3).VL_CAMPO := :CONTROLE.CD_DEPARTAMENTO;&#10;              END IF;&#10;            &#10;              PACK_PAA_COMPRAS.SET_CONTEXTO(V_CONTEXTO);&#10;              &#10;              PACK_PAA_ORIGINACAO.POST_PAA('COM',&#10;                                           1,&#10;                                           'LIBERA_SOLICITACAO',&#10;                                           V_CONTEXTO,&#10;                                           V_CD_EMPRLANCTO,&#10;                                           I_MENSAGEM,&#10;                                           V_ID_PROCESSO);&#10;              &#10;              IF I_MENSAGEM IS NOT NULL THEN&#10;                RAISE E_GERAL;&#10;              END IF;&#10;            END IF;  &#10;          END IF;&#10;          &#10;          /*AUG:130776:20/02/2019*/&#10;          IF NVL(:PARAMETER.CD_MODULO,'ZZZ') = 'EMV' AND&#10;             NVL(:PARAMETER.CD_PROGRAMA,-1)  = 78    THEN&#10;            V_DADOS_ENTRADA.CD_MODULO     := :GLOBAL.CD_MODULO;   &#10;            V_DADOS_ENTRADA.CD_PROGRAMA   := :GLOBAL.CD_PROGRAMA; &#10;            V_DADOS_ENTRADA.CD_EMPRESA    := :GLOBAL.CD_EMPRESA;  &#10;            V_DADOS_ENTRADA.CD_USUARIO    := :GLOBAL.CD_USUARIO;  &#10;            V_DADOS_ENTRADA.ST_AUDITORIA  := :GLOBAL.ST_AUDITORIA;&#10;            &#10;            V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO := :PARAMETER.CD_EMPRPEDIDOINTERNO; --emprpedidointerno&#10;            V_ROW_PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO  := :PARAMETER.NR_PEDIDOINTERNO;&#10;            V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA     := :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;            V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRCOMPRA     := :ITEMCOMPRA.CD_EMPRESA;&#10;&#10;            PACK_PEDIDOINTERNO.GRAVA_PEDIDOINTERNOINTECOMPRA(V_DADOS_ENTRADA,&#10;                                                             V_ROW_PEDIDOINTERNOINTECOMPRA,&#10;                                                             I_MENSAGEM);&#10;&#10;            IF I_MENSAGEM IS NOT NULL THEN&#10;              RAISE E_GERAL;&#10;            END IF; &#10;            &#10;            BEGIN&#10;              SELECT *&#10;                INTO V_ROW_ITEMPEDIDOINTERNO&#10;                FROM ITEMPEDIDOINTERNO&#10;               WHERE ITEMPEDIDOINTERNO.CD_EMPRPEDINTERNO  = V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO&#10;                  AND ITEMPEDIDOINTERNO.NR_PEDIDOINTERNO    = V_ROW_PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO&#10;                  AND ITEMPEDIDOINTERNO.CD_ITEM            = :ITEMCOMPRA.CD_ITEM;&#10;            EXCEPTION&#10;              WHEN OTHERS THEN&#10;                I_MENSAGEM := 'Erro desconhecido ao buscar dados do item do pedido interno..: '||SQLERRM;&#10;                RAISE E_GERAL;&#10;            END;&#10;            &#10;            IF (V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA IS NOT NULL AND V_ROW_ITEMPEDIDOINTERNO.PS_ATENDIDO IS NOT NULL) OR &#10;               (V_ROW_ITEMPEDIDOINTERNO.QT_PEDIDA    IS NOT NULL AND V_ROW_ITEMPEDIDOINTERNO.PS_PEDIDO    IS NOT NULL) THEN&#10;              ---&#10;              V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA := NVL(V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA,0) + :ITEMCOMPRA.QT_PREVISTA;&#10;              V_ROW_ITEMPEDIDOINTERNO.PS_ATENDIDO := NVL(V_ROW_ITEMPEDIDOINTERNO.PS_ATENDIDO,0) + :ITEMCOMPRA.QT_PREVISTA;&#10;              ---&#10;            ELSIF (V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA IS NOT NULL AND V_ROW_ITEMPEDIDOINTERNO.PS_ATENDIDO IS NULL) OR&#10;                  (V_ROW_ITEMPEDIDOINTERNO.QT_PEDIDA   IS NOT NULL AND V_ROW_ITEMPEDIDOINTERNO.PS_PEDIDO   IS NULL) THEN&#10;              ---&#10;              V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA := NVL(V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA,0) + :ITEMCOMPRA.QT_PREVISTA;&#10;              ---&#10;            ELSIF (V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA IS NULL AND V_ROW_ITEMPEDIDOINTERNO.PS_ATENDIDO IS NOT NULL) OR&#10;                  (V_ROW_ITEMPEDIDOINTERNO.QT_PEDIDA   IS NULL AND V_ROW_ITEMPEDIDOINTERNO.PS_PEDIDO   IS NOT NULL) THEN&#10;              ---&#10;              V_ROW_ITEMPEDIDOINTERNO.PS_ATENDIDO := NVL(V_ROW_ITEMPEDIDOINTERNO.PS_ATENDIDO,0) + :ITEMCOMPRA.QT_PREVISTA;  &#10;              ---&#10;            END IF;&#10;            &#10;            PACK_PEDIDOINTERNO.GRAVA_ITEMPEDIDOINTERNO(V_DADOS_ENTRADA,&#10;                                                       V_ROW_ITEMPEDIDOINTERNO,&#10;                                                       I_MENSAGEM);&#10;             IF I_MENSAGEM IS NOT NULL THEN&#10;               RAISE E_GERAL;&#10;             END IF;  &#10;             &#10;             PACK_PEDIDOINTERNO.ARRUMA_STATUS_PEDIDO(I_NR_PEDIDO  => V_ROW_ITEMPEDIDOINTERNO.NR_PEDIDOINTERNO,&#10;                                                I_CD_EMPRESA => V_ROW_ITEMPEDIDOINTERNO.CD_EMPRPEDINTERNO,&#10;                                               O_MSG        => I_MENSAGEM,&#10;                                               I_CD_ITEM    => NULL );&#10;            IF I_MENSAGEM IS NOT NULL THEN&#10;               RAISE E_GERAL;&#10;            END IF;&#10;          END IF;--IF NVL(:PARAMETER.CD_MODULO,'ZZZ') = 'EMV'&#10;        END IF;&#10;      END IF; -- IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NOT NULL AND :ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#10;       &#10;      &#10;       &#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    &#10;    &#10;    &#10;    /**GRA: Projeto mensagens para autorizador: 17/05/2007&#10;     * Será enviado uma mensagem de solicitação pendente &#10;     * ao autorizador informado na tela.&#10;     */&#10;    &#10;    IF FORM_SUCCESS THEN&#10;      &#10;        IF NVL(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO.COUNT, 0) > 0 THEN&#10;          PACK_PROJETOMONI.INSERE_PROJETORATEIO(I_MENSAGEM);&#10;          IF I_MENSAGEM IS NOT NULL THEN &#10;            RAISE E_GERAL;&#10;          END IF;&#10;        END IF;&#10;      &#10;      FAZ_COMMIT;&#10;      &#10;      IF CONTADOR = 1 THEN&#10;        PACK_ENVIAMSG.ENVIA( :GLOBAL.CD_USUARIO, &#10;                              :ITEMCOMPRA.CD_AUTORIZADOR,&#10;                             'AUTORIZAÇÃO PENDENTE',&#10;                             PACK_MENSAGEM.MENS_ALERTA(1776,'¢NR_ITEMCOMPRA='||:ITEMCOMPRA.NR_ITEMCOMPRA||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢'),&#10;                             I_MENSAGEM);&#10;    &#10;        IF I_MENSAGEM IS NOT NULL THEN &#10;          MENSAGEM('Maxys',I_MENSAGEM,2);&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;        &#10;        FAZ_COMMIT;&#10;        &#10;        IF NVL(V_ST_BLOQUEIO, 'N') = 'S' THEN --ATF:31/08/2011:33772&#10;          -- Lançamento ultrapassou Orçamento estipulado, Favor entrar em contato com o departamento responsável.&#10;          IF V_MENSAGEMFINAL IS NOT NULL THEN&#10;            --Foi encontrato inconsistências no Controle Orçamentário. Verique o detalhe da mensagem. Origem ¢DS_ORIGEM¢&#10;            MENSAGEM_PADRAO(28475, '¢DS_ORIGEM='||'Compras'||'¥'||V_MENSAGEMFINAL||'¥'||'¢');    &#10;            --MENSAGEM_PADRAO(20157, '¢NR_ITEMCOMPRA='||:ITEMCOMPRA.NR_ITEMCOMPRA||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;          ELSE&#10;            --Lançamento ultrapassou Orçamento estipulado, Favor entrar em contato com o departamento responsável.&#10;            MENSAGEM_PADRAO(26854, NULL);&#10;          END IF;  &#10;          --Solicitação de Compra ¢NR_ITEMCOMPRA¢ com número de lote ¢NR_LOTECOMPRA¢ da Empresa ¢CD_EMPRESA¢ salva com Sucesso.&#10;          MENSAGEM_PADRAO(20157, '¢NR_ITEMCOMPRA='||:ITEMCOMPRA.NR_ITEMCOMPRA||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;        ELSE&#10;          --Solicitação de Compra ¢NR_ITEMCOMPRA¢ com número de lote ¢NR_LOTECOMPRA¢ da Empresa ¢CD_EMPRESA¢ salva com Sucesso.&#10;          MENSAGEM_PADRAO(20157, '¢NR_ITEMCOMPRA='||:ITEMCOMPRA.NR_ITEMCOMPRA||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;        END IF;        &#10;      ELSIF CONTADOR > 1 THEN    &#10;        PACK_ENVIAMSG.ENVIA(:GLOBAL.CD_USUARIO, &#10;                            :ITEMCOMPRA.CD_AUTORIZADOR,&#10;                            'AUTORIZAÇÃO PENDENTE',&#10;                            PACK_MENSAGEM.MENS_ALERTA(1776,'¢NR_ITEMCOMPRA='||V_NR_ITEMCOMPRA||' - '||V_NR_ITEMCOMPRA_U||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢'),&#10;                            I_MENSAGEM);&#10;    &#10;        IF I_MENSAGEM IS NOT NULL THEN &#10;          MENSAGEM('Maxys',I_MENSAGEM,2);&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;        &#10;        FAZ_COMMIT;  &#10;        &#10;        IF NVL(V_ST_BLOQUEIOFINAL, 'N') = 'S' THEN --ATF:31/08/2011:33772&#10;            &#10;          IF V_MENSAGEMFINAL IS NOT NULL THEN&#10;            --MENSAGEM('MAXYS',V_MSG_BLOQUEIO,2);&#10;            MENSAGEM_PADRAO(28475, '¢DS_ORIGEM='||'Compras'||'¥'||V_MENSAGEMFINAL||'¥'||'¢');    &#10;            MENSAGEM_PADRAO(20160, '¢NR_ITEMCOMPRA='||V_NR_ITEMCOMPRA||'¢NR_ITEMCOMPRA_U='||V_NR_ITEMCOMPRA_U||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;          ELSE&#10;            MENSAGEM_PADRAO(20160, '¢NR_ITEMCOMPRA='||V_NR_ITEMCOMPRA||'¢NR_ITEMCOMPRA_U='||V_NR_ITEMCOMPRA_U||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;          END IF;  &#10;        ELSE&#10;          --Solicitação de Compra de ¢NR_ITEMCOMPRA¢ até ¢NR_ITEMCOMPRA_U¢ com número de lote ¢NR_LOTECOMPRA¢ da Empresa ¢CD_EMPRESA¢ salva com Sucesso!&#10;          MENSAGEM_PADRAO(20160, '¢NR_ITEMCOMPRA='||V_NR_ITEMCOMPRA||'¢NR_ITEMCOMPRA_U='||V_NR_ITEMCOMPRA_U||'¢NR_LOTECOMPRA='||I_NR_LOTECOMPRA||'¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢');&#10;        END IF;&#10;       ELSE&#10;        PACK_ENVIAMSG.ENVIA(:GLOBAL.CD_USUARIO, &#10;                            :ITEMCOMPRA.CD_AUTORIZADOR,&#10;                            'AUTORIZAÇÃO PENDENTE',&#10;                            PACK_MENSAGEM.MENS_ALERTA(1776,'¢NR_ITEMCOMPRA='||:ITEMCOMPRA.NR_ITEMCOMPRA||&#10;                            '¢CD_EMPRESA='||V_CD_EMPRLANCTO||'¢'),&#10;                            I_MENSAGEM);&#10;          &#10;        IF I_MENSAGEM IS NOT NULL THEN &#10;          MENSAGEM('Maxys',I_MENSAGEM,2);&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;        &#10;        FAZ_COMMIT;&#10;        &#10;        IF NVL(V_ST_BLOQUEIO, 'N') = 'S' THEN &#10;          IF V_MSG_BLOQUEIO IS NOT NULL THEN&#10;            MENSAGEM('MAXYS',V_MSG_BLOQUEIO,2);&#10;          END IF;  &#10;        END IF;&#10;        IF V_INFORMACAO IS NOT NULL THEN  &#10;          --Lote de compra ¢NR_LOTECOMPRA¢ alterado com Sucesso! ¥ Solicitações em processo de compra: ¢V_INFORMACAO¢ § § § §&#10;          MENSAGEM_PADRAO(4694,'¢NR_LOTECOMPRA='||:CONTROLE.NR_LOTECOMPRA||'¢V_INFORMACAO='|| V_INFORMACAO||'¢');&#10;        ELSE &#10;          --Lote de compra ¢NR_LOTECOMPRA¢ alterado com Sucesso!&#10;          MENSAGEM_PADRAO(4695,'¢NR_LOTECOMPRA='||:CONTROLE.NR_LOTECOMPRA||'¢');&#10;        END IF;&#10;      END IF;    &#10;    END IF;&#10;  &#10;    /*ASF:24/06/2019:134720 - Alteração para gravar anexo em solicitação de compra*/&#10;    PACK_PROCEDIMENTOS.SALVA_ANEXO(I_MENSAGEM);       &#10;      &#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    IF FORM_SUCCESS THEN&#10;      FAZ_COMMIT;&#10;    END IF;  &#10;&#10;    --Conforme parametro deve-se enviar email aos autorizadores.&#10;    V_ST_ENVIAEMAIL := PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA),'CHK_ALERTAEMAIL');&#10;    &#10;    IF NVL(V_ST_ENVIAEMAIL,'N') = 'S' THEN&#10;      MESSAGE('Enviando email ao autorizador... Aguarde.',NO_ACKNOWLEDGE);&#10;       BEGIN&#10;         SELECT PARMCOMPRA.CD_EMPRCENTRALIZ &#10;           INTO V_CD_EMPRCENTRALIZ&#10;           FROM PARMCOMPRA&#10;          WHERE PARMCOMPRA.CD_EMPRESA = NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA);&#10;       EXCEPTION&#10;         WHEN OTHERS THEN&#10;           V_CD_EMPRCENTRALIZ := NULL;&#10;       END;&#10;       &#10;       IF (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_AGRUPACOTACAOCENTRAL'),'N') = 'S') THEN&#10;         V_CD_EMPRESA := NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA);&#10;       ELSE&#10;         V_CD_EMPRESA := NVL(V_CD_EMPRCENTRALIZ,NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA));&#10;       END IF;&#10;       &#10;       ENVIA_EMAIL(I_CD_EMPRESA    => V_CD_EMPRESA,&#10;                   I_NR_LOTECOMPRA => NVL(I_NR_LOTECOMPRA,:CONTROLE.NR_LOTECOMPRA));  &#10;       &#10;       MESSAGE('Email enviado...',NO_ACKNOWLEDGE);&#10;    END IF;&#10;    &#10;    V_NR_ITEMCOMPRA := :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;    &#10;    GO_BLOCK('ITEMCOMPRA');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    GO_BLOCK('CONTROLE');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    PACK_GRUPO.CRIA_GRUPO_CC;&#10;    PACK_GRUPO_NEGOCIO.CRIA_GRUPO_NEGOCIO;&#10;    :GLOBAL.V_GRUPO_CC :=NULL;&#10;    PACK_PROCEDIMENTOS.V_DUPLICADO := FALSE; /*ATR:80785:11/02/2015*/&#10;    GO_ITEM('CONTROLE.CD_EMPRESA');&#10;    &#10;    PACK_PROCEDIMENTOS.ARQUIVOS.DELETE;&#10;    &#10;    IF NVL(:PARAMETER.DS_PROCESSO,'X') = 'PRODUCAO' THEN&#10;      EXIT_FORM(NO_VALIDATE,FULL_ROLLBACK);&#10;    END IF;&#10;  END IF;&#10;  &#10;EXCEPTION&#10;  WHEN E_SAIDA THEN --WLV:07/02/2012:40906&#10;    /**FLA:06/12/2019:142176&#10;     * Adicionado para impedir o travamento da sessão da tela&#10;     */&#10;    FAZ_ROLLBACK;&#10;    --NULL;&#10;  WHEN E_PMS THEN&#10;    -- MENSAGEM('Maxys','Projeto não informado!',2);&#10;    NULL;     &#10;  WHEN E_GERAL THEN&#10;    FAZ_ROLLBACK;&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA,I_MENSAGEM,2);&#10;    IF V_CAMPO IS NOT NULL THEN&#10;      GO_ITEM(V_CAMPO);&#10;    END IF;   &#10;  WHEN OTHERS THEN&#10;    FAZ_ROLLBACK;&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||:GLOBAL.CD_PROGRAMA||' - Erro',SQLERRM,1);&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-DELREC">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE &#10;  V_ST_EXCLUI   BOOLEAN := FALSE;  &#10;  --V_ALERT       NUMBER;&#10;  V_MENSAGEM    VARCHAR2(32000);&#10;  E_GERAL        EXCEPTION;  &#10;BEGIN  &#10;  &#10;  V_ST_EXCLUI := PACK_VALIDA.VAL_PERMISSAO (V_TIPO         => 'E',&#10;                                            V_CD_USUARIO   => :GLOBAL.CD_USUARIO,&#10;                                            V_CD_EMPRESA   => :GLOBAL.CD_EMPRESA,&#10;                                            V_CD_MODULO   => :GLOBAL.CD_MODULO,&#10;                                            V_CD_PROGRAMA => :GLOBAL.CD_PROGRAMA);  &#10;  IF NOT (V_ST_EXCLUI) THEN&#10;    --O usuário ¢CD_USUARIO¢ não tem permissão de EXCLUSÃO para o módulo ¢CD_MODULO¢,  programa ¢CD_PROGRAMA¢ e Empresa ¢CD_EMPRESA¢. Verifique o Programa ANV053.&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(487,'¢CD_USUARIO=' ||:GLOBAL.CD_USUARIO||&#10;                                                '¢CD_MODULO='  ||:GLOBAL.CD_MODULO||&#10;                                                '¢CD_PROGRAMA='||:GLOBAL.CD_PROGRAMA||&#10;                                                '¢CD_EMPRESA=' ||:GLOBAL.CD_EMPRESA||'¢');&#10;    RAISE E_GERAL;&#10;  END IF; --IF NOT (V_ST_EXCLUI) THEN&#10;  -----------------------------------&#10;  &#10;  :GLOBAL.MD_BLOCO := :SYSTEM.CURRENT_BLOCK;&#10;  &#10;  IF (:GLOBAL.TP_ACESSO = 'M') THEN    &#10;    IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL AND &#10;       :ITEMCOMPRA.NR_ITEMCOMPRA IS NOT NULL AND &#10;       :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;      GO_ITEM('ITEMCOMPRA.DS_OBSCANCEL');&#10;    ELSE&#10;      GO_BLOCK ('ITEMCOMPRA');&#10;    END IF;&#10;  END IF; --IF (:GLOBAL.TP_ACESSO = 'M') THEN    &#10;  -------------------------------------------&#10;  &#10;  &#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM_PADRAO(2627,'GATILHO KEY-DELREC: ¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-CLRREC">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :GLOBAL.MD_BLOCO = 'ITEMCOMPRACCUSTO' THEN&#10;    IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#10;      FOR I IN 1.. GET_GROUP_ROW_COUNT('REC_CCUSTO') LOOP&#10;        IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO = GET_GROUP_NUMBER_CELL('REC_CCUSTO.CD_CENTROCUSTO', I) THEN&#10;           DELETE_GROUP_ROW('REC_CCUSTO');&#10;        END IF;     &#10;      END LOOP;&#10;    END IF;   &#10;  END IF;&#10;&#10;  PACK_GRUPO.DELETA_GRUPO_CC(:ITEMCOMPRACCUSTO.CD_ITEM);&#10;  CLEAR_RECORD;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-CQUERY">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  NULL;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-DUP-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="PACK_PROCEDIMENTOS.SOLICITACAO_DEVOLVIDA;">
</node>
</node>
</node>
<node TEXT="WHEN-WINDOW-CLOSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :SYSTEM.CURSOR_BLOCK = 'ITEMCOMPRACCUSTO' THEN&#10;    &#10;    GO_BLOCK('ITEMCOMPRA');&#10;    &#10;  ELSE&#10;    EXIT_FORM(NO_VALIDATE,FULL_ROLLBACK);&#10;  END IF;  &#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-CREREC">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF ((:SYSTEM.RECORD_STATUS = 'INSERT') AND NOT PACK_VALIDA.VAL_PERMISSAO('I',:GLOBAL.CD_USUARIO,:GLOBAL.CD_EMPRESA,:GLOBAL.CD_MODULO,:GLOBAL.CD_PROGRAMA)) THEN&#10;    MENSAGEM_PADRAO(486,'¢CD_USUARIO = '||:GLOBAL.CD_USUARIO||&#10;                        '¢CD_MODULO  = '||:GLOBAL.CD_MODULO||&#10;                        '¢CD_PROGRAMA= '||:GLOBAL.CD_PROGRAMA||&#10;                        '¢CD_EMPRESA = '||:GLOBAL.CD_EMPRESA||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  END IF;&#10;  &#10;  IF :SYSTEM.CURSOR_BLOCK = 'ITEMCOMPRA' THEN&#10;    NEXT_RECORD;&#10;  END IF;&#10;END;">
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
<node TEXT="KEY-MENU">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  &#10;  IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NULL THEN&#10;    PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.DELETE;&#10;    PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.DELETE; &#10;&#10;    &#10;    GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    GO_BLOCK('DUPLICAITEMCOMPRA');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    GO_BLOCK('CONS_ITEMCOMPRA');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    &#10;    CENTRALIZA_FORM('WIN_ITEMCOMPRA', 'WIN_DUPLICALOTECOMPRA');&#10;    GO_ITEM('CONS_ITEMCOMPRA.CD_EMPRESA');&#10;  ELSE&#10;    --Duplicação só é permitada quando não há consulta de Lote de Compra em Tela.&#10;    MENSAGEM_PADRAO(24789, NULL);&#10;  END IF;&#10;  &#10;END;">
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
<node TEXT="KEY-EXIT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN  &#10;  EXIT_FORM(NO_VALIDATE,FULL_ROLLBACK);&#10;END;">
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
<node TEXT="KEY-CLRBLK">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NULL;">
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
<node TEXT="KEY-PRINT">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  NULL;&#10;END;">
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
<node TEXT="KEY-EDIT">
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
<node TEXT="KEY-HELP">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_DS_AJUDA  VARCHAR2(32000);&#10;  V_DS_TITULO VARCHAR2(32000);&#10;  V_NM_ITEM   VARCHAR2(32000);&#10;  V_NM_BLOCO  VARCHAR2(32000);&#10;&#10;BEGIN&#10;&#10;  IF (:SYSTEM.MOUSE_ITEM IS NOT NULL) THEN&#10;    V_NM_BLOCO := SUBSTR(:SYSTEM.MOUSE_ITEM, 1, INSTR(:SYSTEM.MOUSE_ITEM, '.') - 1);&#10;    V_NM_ITEM  := SUBSTR(:SYSTEM.MOUSE_ITEM, INSTR(:SYSTEM.MOUSE_ITEM, '.') + 1, LENGTH(:SYSTEM.MOUSE_ITEM));&#10;    BEGIN&#10;      SELECT AJUDAMAXYS.DS_AJUDA, AJUDAMAXYS.DS_TITULO&#10;        INTO V_DS_AJUDA, V_DS_TITULO&#10;        FROM ITEMAJUDAMAXYS, AJUDAMAXYS&#10;       WHERE AJUDAMAXYS.CD_AJUDA = ITEMAJUDAMAXYS.CD_AJUDA&#10;         AND ITEMAJUDAMAXYS.CD_PROGRAMA = :GLOBAL.CD_PROGRAMA&#10;         AND ITEMAJUDAMAXYS.CD_MODULO = :GLOBAL.CD_MODULO&#10;         AND ITEMAJUDAMAXYS.CD_BLOCO = V_NM_BLOCO&#10;         AND ITEMAJUDAMAXYS.CD_ITEM = V_NM_ITEM;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        V_DS_AJUDA  := 'Não foi localizada ajuda para este campo.';&#10;        V_DS_TITULO := V_NM_BLOCO||'.'||V_NM_ITEM;&#10;    END;&#10;    HOST(:GLOBAL.VL_CURRENTPATH||'\KAMIKAZE.EXE &#34;S:\MAXYAJUDA\JRE1.6\BIN\JAVAW&#34; -JAR &#34;S:\MAXYAJUDA\MAXYAJUDA.JAR&#34; &#34;'||V_DS_TITULO||'&#34; &#34;'||V_DS_AJUDA||'&#34;', NO_SCREEN);&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-F9">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF SHOW_LOV('PROFILE') THEN&#10;    DECLARE&#10;      I_CD_MODULO      PROFILE.CD_MODULO%TYPE;&#10;      I_CD_PROGRAMA    PROFILE.CD_PROGRAMA%TYPE;&#10;      I_TP_ACESSO      PROFILE.TP_ACESSO%TYPE;&#10;      I_DS_PROGRAMA    PROGRAMA.DS_PROGRAMA%TYPE;&#10;      I_ST_AUDITORIA   PROGRAMA.ST_AUDITORIA%TYPE;&#10;      AUX_ST_AUDITORIA PROGRAMA.ST_AUDITORIA%TYPE;&#10;      AUX_CD_MODULO    PROGRAMA.CD_MODULO%TYPE;&#10;      AUX_CD_PROGRAMA  PROGRAMA.CD_PROGRAMA%TYPE;&#10;      AUX_TP_ACESSO    PROFILE.TP_ACESSO%TYPE;&#10;      --I_MOSTRA_LOV     BOOLEAN;&#10;    BEGIN&#10;      IF :GLOBAL.EXEC_PROGRAMA IS NOT NULL THEN&#10;        I_CD_MODULO   := SUBSTR(:GLOBAL.EXEC_PROGRAMA,1,3);&#10;        I_CD_PROGRAMA := SUBSTR(:GLOBAL.EXEC_PROGRAMA,4,3);&#10;        &#10;        SELECT PROFILE.TP_ACESSO&#10;          INTO I_TP_ACESSO&#10;          FROM PROFILE&#10;         WHERE (PROFILE.CD_EMPRESA = :GLOBAL.CD_EMPRESA)&#10;           AND (PROFILE.CD_USUARIO = :GLOBAL.CD_USUARIO)&#10;           AND (PROFILE.CD_MODULO = I_CD_MODULO)&#10;           AND (PROFILE.CD_PROGRAMA = I_CD_PROGRAMA);&#10;        &#10;        SELECT PROGRAMA.DS_PROGRAMA,&#10;               PROGRAMA.ST_AUDITORIA&#10;          INTO I_DS_PROGRAMA,&#10;               I_ST_AUDITORIA&#10;          FROM PROGRAMA&#10;         WHERE (PROGRAMA.CD_MODULO = I_CD_MODULO)&#10;           AND (PROGRAMA.CD_PROGRAMA = I_CD_PROGRAMA);&#10;&#10;        :GLOBAL.DS_PROGRAMA  := I_DS_PROGRAMA;&#10;        AUX_TP_ACESSO        := :GLOBAL.TP_ACESSO;&#10;        AUX_ST_AUDITORIA     := :GLOBAL.ST_AUDITORIA;&#10;        AUX_CD_MODULO        := :GLOBAL.CD_MODULO;&#10;        AUX_CD_PROGRAMA      := :GLOBAL.CD_PROGRAMA;&#10;        :GLOBAL.TP_ACESSO    := I_TP_ACESSO;&#10;        :GLOBAL.ST_AUDITORIA := I_ST_AUDITORIA;&#10;        :GLOBAL.CD_MODULO    := I_CD_MODULO;&#10;        :GLOBAL.CD_PROGRAMA  := I_CD_PROGRAMA;&#10;        &#10;        /*IF I_CD_PROGRAMA &#60;= 09 THEN&#10;           CALL_FORM(I_CD_MODULO||'00'||I_CD_PROGRAMA,HIDE,DO_REPLACE,NO_QUERY_ONLY);&#10;        ELSIF (I_CD_PROGRAMA >=10) AND (I_CD_PROGRAMA &#60;= 99) THEN&#10;           CALL_FORM(I_CD_MODULO||'0'||I_CD_PROGRAMA,HIDE,DO_REPLACE,NO_QUERY_ONLY);&#10;        ELSIF (I_CD_PROGRAMA > 99) THEN&#10;           CALL_FORM(I_CD_MODULO||I_CD_PROGRAMA,HIDE,DO_REPLACE,NO_QUERY_ONLY);&#10;        END IF;*/&#10;        &#10;        /** ALG:13/07/2015:89115&#10;         * Adicionado tratamento para atualizar a conexão na tabela SESSAO.&#10;         ***/&#10;        PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                     :GLOBAL.CD_EMPRESA,&#10;                                     :GLOBAL.CD_MODULO,&#10;                                     :GLOBAL.CD_PROGRAMA);&#10;        &#10;        CALL_FORM(I_CD_MODULO||LPAD(I_CD_PROGRAMA, 3, '0'), HIDE, DO_REPLACE, NO_QUERY_ONLY);&#10;        &#10;        I_DS_PROGRAMA         := NULL;&#10;        :GLOBAL.ST_AUDITORIA  := AUX_ST_AUDITORIA;&#10;        :GLOBAL.CD_MODULO     := AUX_CD_MODULO;&#10;        :GLOBAL.CD_PROGRAMA   := AUX_CD_PROGRAMA;&#10;        :GLOBAL.TP_ACESSO     := AUX_TP_ACESSO;&#10;        :GLOBAL.EXEC_PROGRAMA := NULL;&#10;        &#10;        PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                     :GLOBAL.CD_EMPRESA,&#10;                                     :GLOBAL.CD_MODULO,&#10;                                     :GLOBAL.CD_PROGRAMA);&#10;        &#10;      END IF;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        -- RRW:05/08/2011:32921: Padronização.&#10;        --MESSAGE ('Usuário não tem acesso ao programa, ou programa não existe');&#10;        /*O Usuário ¢CD_USUARIO¢ não tem acesso ao programa ¢NM_PROGRAMA¢ ou programa não está cadastrado.*/&#10;        MENSAGEM_PADRAO(13320, '¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢NM_PROGRAMA='||I_CD_MODULO||LPAD(I_CD_PROGRAMA,3,0)||'¢');&#10;    END;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-DUPREC">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="PACK_PROCEDIMENTOS.MOSTRA_ULTIMAS_COMPRAS;">
</node>
</node>
</node>
<node TEXT="GATILHO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM            VARCHAR2(2000);&#10;  E_GERAL                EXCEPTION;&#10;BEGIN&#10;&#10;  NULL;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
<node TEXT="Alert">
<icon BUILTIN="Descriptor.grouping"/>
<node TEXT="EXCLUSAO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Confirmação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Confirma exclusão ?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="MENSAGEM_OBSERVACAO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="OK">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="MENSAGEM_CONFIRMACAO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Confirmação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="MENSAGEM_CRONOGRAMA">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Confirmação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="MENSAGEM_MUDAR">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Maxys - Atenção!">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Continuar">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Mudar">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="MENSAGEM_PRECAUCAO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Fechar">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao3">
<icon BUILTIN="element"/>
<node TEXT="Ajuda">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="MENSAGEM_EDICAO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Atenção!">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Atenção!">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="MENSAGEM_ERRO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Fechar">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao3">
<icon BUILTIN="element"/>
<node TEXT="Ajuda">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="INCLUIPEDIDO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Maxys">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Já existe uma solicitação de compra para este item.&#10;&#10;&#10;Deseja incluir a quantidade  na mesma solicitação?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="ALR_DIMINUIR">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Atenção">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Tem certeza que deseja diminuir a quantidade Solicitada?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="OK">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Cancelar">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="ANEXOITEMCOMPRA">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Maxys">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Deseja anexar arquivo na solicitação de compra?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="BotaoPadrao">
<icon BUILTIN="element"/>
<node TEXT="Botão 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="ALR_QTDENULA">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Atenção">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Existem centros de custos cuja quantidade não foi informada. Deseja prosseguir?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="ALR_EXISTEPEDIDO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Atenção">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="O Item possui pedido em aberto para a empresa. Deseja prosseguir com lançamento ou remover o item?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Prosseguir">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Remover">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="ALERTA_TIPORATEIO">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Atenção">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Deseja informar o Rateio de ?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao3">
<icon BUILTIN="element"/>
<node TEXT="Cancelar">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="CONFIRMA_PREITEMCOMPRA">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Confirmação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Deseja carregar os itens selecionados ?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node TEXT="CANCELA_PREITEMCOMPRA">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Confirmação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="alertMessage">
<icon BUILTIN="element"/>
<node TEXT="Deseja cancelar os itens selecionados ?">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao1">
<icon BUILTIN="element"/>
<node TEXT="Sim">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="Botao2">
<icon BUILTIN="element"/>
<node TEXT="Não">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
<node TEXT="métodos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="MENSAGEM_PADRAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE MENSAGEM_PADRAO(I_CD_MENSAGEM IN VARCHAR2,&#10;                          I_PARAMETRO   IN VARCHAR2) AS -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#10;/* &#10;    &#10;  I_CD_MENSAGEM = -- AQUI SOMENTE PASSA O NUMERO DA MENSAGEM TIPO SE EH MAX000001 SOMENTE PASSA 1&#10;&#10;*/&#10;&#10;  ALERT_ID       ALERT;&#10;  MENSAGEM       VARCHAR2(32000);&#10;  RETORNO        NUMBER;&#10;  I_MENSAGEM    VARCHAR2(32000);&#10;  V_TP_MENSAGEM VARCHAR2(32000);&#10;  V_DS_MENSAGEM VARCHAR2(32000);&#10;  J_DS_MENSAGEM VARCHAR2(32000);&#10;  V_CD_MENSAGEM VARCHAR2(32000);&#10;  V_TITULO      VARCHAR2(32000);&#10;  &#10;  V_DEFAULT_BROWSER    VARCHAR2(32000);&#10;  V_TP_CONEXAO        VARCHAR2(32000);&#10;  V_CAMINHO_AJUDA      VARCHAR2(32000);&#10;  ARQUIVO_NAO_EXISTE  EXCEPTION;&#10;&#10;&#10;  V_ST_MENSPRONTA VARCHAR2(1) := 'N'; -- 'S' - SIM 'N' - NÃO&#10;  V_NR_POSISAO    NUMBER;&#10;&#10;&#10;BEGIN&#10;  V_ST_MENSPRONTA := 'N';&#10;  &#10;  &#10;  -- TESTA SE A MENSAGEM EH PADÇÃO OU NAUM --&#10;  IF INSTR(I_PARAMETRO,'¢MPM=') > 0 THEN&#10;    V_ST_MENSPRONTA   := 'S'; -- EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;  ELSE&#10;    V_ST_MENSPRONTA := 'N'; -- NÃO EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;  END IF;&#10;  &#10;  IF V_ST_MENSPRONTA = 'N' THEN&#10;    -- Pesquisa Mensagem --&#10;    PACK_MENSAGEM.MONTA_MENSAGEM(I_CD_MENSAGEM,I_PARAMETRO,V_TP_MENSAGEM,V_DS_MENSAGEM,I_MENSAGEM);&#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;    PACK_MENSAGEM.ARRUMA_CD_MENSAGEM(I_CD_MENSAGEM,V_CD_MENSAGEM,I_MENSAGEM);&#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;  ELSIF V_ST_MENSPRONTA = 'S' THEN&#10;&#10;    V_DS_MENSAGEM := SUBSTR(I_PARAMETRO,1,LENGTH(I_PARAMETRO)/*-15*/);&#10;    V_CD_MENSAGEM := I_CD_MENSAGEM;&#10;    &#10;    -- Pesquisa TP_MENSAGEM --&#10;    PACK_MENSAGEM.MONTA_MENSAGEM(V_CD_MENSAGEM,'¢¢',V_TP_MENSAGEM,J_DS_MENSAGEM,I_MENSAGEM);&#10;    IF I_MENSAGEM IS NOT NULL THEN&#10;      MESSAGE(I_MENSAGEM,ACKNOWLEDGE);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;  END IF;  &#10;&#10;  MENSAGEM := 'MENSAGEM_';&#10;  IF V_TP_MENSAGEM = 'E' THEN&#10;    MENSAGEM := MENSAGEM||'ERRO';&#10;    V_TITULO := 'ERRO';&#10;  ELSIF V_TP_MENSAGEM = 'O' THEN&#10;    MENSAGEM := MENSAGEM||'OBSERVACAO';&#10;    V_TITULO := 'Observação';&#10;  ELSIF V_TP_MENSAGEM = 'P' THEN&#10;    MENSAGEM := MENSAGEM||'PRECAUCAO';&#10;    V_TITULO := 'Precaução';&#10;  END IF;&#10;  --MENSAGEM := MENSAGEM||'_NOVA';&#10;  V_TITULO := V_TITULO||' - '||V_CD_MENSAGEM;&#10;  &#10;  /**JMS:28/09/2006:14099&#10;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USUÁRIO ELE ABRA O MEU FORM COM A MENSAGEM&#10;   * E NÃO A JANELA PADRÃO DO FORMS, DESTA FORMA É POSSÍVEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#10;   */&#10;  IF (V_TP_MENSAGEM &#60;> 'A') THEN&#10;    PACK_MENSAGEM.SET_TITULO(V_TITULO);&#10;    PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#10;    PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#10;    PACK_MENSAGEM.SET_CODIGO_MENSAGEM(V_CD_MENSAGEM);&#10;    CALL_FORM('ABT002', NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#10;  ELSE&#10;    CLEAR_MESSAGE;&#10;    MESSAGE(V_DS_MENSAGEM,ACKNOWLEDGE);&#10;  END IF;&#10;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#10;  &#10;EXCEPTION&#10;  WHEN ARQUIVO_NAO_EXISTE THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="MENSAGEM">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE MENSAGEM (V_DS_TITULO IN VARCHAR2,V_DS_MENSAGEM IN VARCHAR2,V_TP_MENSAGEM IN NUMBER) IS&#10;/* &#10;    &#10;     Como usar?&#10;     &#10;     MENSAGEM (TITULO,MENSAGEM,ESTILO);&#10;     &#10;     TITULO(varchar2)   = titulo da janela de mensagem&#10;     MENSAGEM(varchar2) = mensagem central&#10;     ESTILO(Number)     = estilo da mensagem (icone)&#10;       - 1 = Erro&#10;       - 2 = Observacao&#10;       - 3 = Precaucao&#10;       - 4 = Aparece na barra (Não utiliza titulo) &#10;&#10;*/&#10;  ALERT_ID ALERT;&#10;  MENSAGEM VARCHAR2(32000);&#10;  RETORNO  NUMBER;&#10;  &#10;  V_ST_PADRAO   VARCHAR2(1) := 'N'; -- 'S' - SIM 'N' - NÃO&#10;  V_CD_MENSAGEM VARCHAR2(32000);&#10;  V_NR_POSISAO  NUMBER;&#10;  &#10;BEGIN&#10;  &#10;  V_ST_PADRAO := 'N';&#10;  &#10;  -- TESTA SE A MENSAGEM EH PADÇÃO OU NAUM --&#10;  IF INSTR(V_DS_MENSAGEM,'¢MPM=') > 0 THEN&#10;    V_ST_PADRAO   := 'S'; -- EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;    V_NR_POSISAO  := INSTR(V_DS_MENSAGEM,'¢MPM=') + 5;&#10;    V_CD_MENSAGEM := SUBSTR(V_DS_MENSAGEM,V_NR_POSISAO,9);&#10;  ELSE&#10;    V_ST_PADRAO := 'N'; -- NÃO EH MENSAGEM PADRÃO Q VEIO DO BANCO DE DADOS&#10;  END IF;&#10;  &#10;  /**JMS:28/09/2006:14099&#10;   * MODIFICADO PARA QUANDO FOR CHAMAR A MENSAGEM NA TELA PARA O USUÁRIO ELE ABRA O MEU FORM COM A MENSAGEM&#10;   * E NÃO A JANELA PADRÃO DO FORMS, DESTA FORMA É POSSÍVEL TRAZER MAIS DE 256 CAMPOS NA TELA.&#10;   */&#10;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#10;  IF (V_TP_MENSAGEM &#60;> 4) THEN&#10;    IF NVL(V_ST_PADRAO,'N') = 'N' THEN&#10;      PACK_MENSAGEM.SET_TITULO(V_DS_TITULO);&#10;      PACK_MENSAGEM.SET_MENSAGEM(V_DS_MENSAGEM);&#10;      PACK_MENSAGEM.SET_TIPO_MENSAGEM(V_TP_MENSAGEM);&#10;      CALL_FORM ('ABT002', NO_HIDE, DO_REPLACE, NO_QUERY_ONLY);&#10;    ELSE&#10;      MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#10;    END IF;&#10;  ELSE&#10;    CLEAR_MESSAGE;&#10;    MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#10;  END IF;&#10;  PACK_MENSAGEM.SET_CODIGO_MENSAGEM(NULL);&#10;&#10;  /*&#10;  IF V_ST_PADRAO = 'N' THEN&#10;    MENSAGEM := 'MENSAGEM_';&#10;    IF (V_TP_MENSAGEM = 1) THEN&#10;      MENSAGEM := MENSAGEM || 'ERRO';&#10;    ELSIF (V_TP_MENSAGEM = 2) THEN&#10;      MENSAGEM := MENSAGEM || 'OBSERVACAO';&#10;    ELSIF (V_TP_MENSAGEM = 3) THEN&#10;      MENSAGEM := MENSAGEM || 'PRECAUCAO';&#10;    END IF;  &#10;    IF (V_TP_MENSAGEM &#60;> 4) THEN&#10;      ALERT_ID := FIND_ALERT(MENSAGEM);&#10;      SET_ALERT_PROPERTY(ALERT_ID,ALERT_MESSAGE_TEXT,V_DS_MENSAGEM);&#10;      SET_ALERT_PROPERTY(ALERT_ID,TITLE,V_DS_TITULO);&#10;      RETORNO := SHOW_ALERT(ALERT_ID);&#10;    ELSE&#10;      CLEAR_MESSAGE;&#10;      MESSAGE(V_DS_MENSAGEM,NO_ACKNOWLEDGE);&#10;    END IF;&#10;  ELSIF V_ST_PADRAO = 'S' THEN&#10;    MENSAGEM_PADRAO(V_CD_MENSAGEM,V_DS_MENSAGEM);&#10;  END IF;  &#10;  */&#10;  &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_MENSAGEM">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_MENSAGEM IS&#10;  TIPO_MENSAGEM   VARCHAR2(03) := MESSAGE_TYPE;&#10;  CODIGO_MENSAGEM NUMBER       := MESSAGE_CODE;&#10;BEGIN&#10;  IF (TIPO_MENSAGEM = 'FRM') AND (CODIGO_MENSAGEM = 40400) THEN&#10;      --Registro aplicado e salvo&#10;      NULL;&#10;  ELSE&#10;     MESSAGE (MESSAGE_TYPE||'-'||MESSAGE_CODE||' '||MESSAGE_TEXT);&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="AUDITA_GRAVACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE AUDITA_GRAVACAO IS&#10;  PRIM_ITEM      VARCHAR2(80);&#10;  ULTI_ITEM      VARCHAR2(80);&#10;  STATUS         VARCHAR2(15);&#10;  PROX_BLOCO     VARCHAR2(80);&#10;  ULTI_BLOCO     VARCHAR2(80);&#10;  TABELA         VARCHAR2(80);&#10;  I_DS_DML       VARCHAR2(32000);&#10;  I_TP_EVENTO    LOGUSUARIO.TP_EVENTO%TYPE;&#10;  I_DS_EVENTO    VARCHAR2(32000);&#10;  I_REGISTRO     VARCHAR2(32000);&#10;  I_CAMPOS_INS   VARCHAR2(32000);&#10;  I_VALORES_INS  VARCHAR2(32000);&#10;  I_INSERT       VARCHAR2(32000);&#10;  I_CONTADOR_INS NUMBER;&#10;  I_CAMPOS_UPD   VARCHAR2(32000);&#10;  I_VALORES_UPD  VARCHAR2(32000);&#10;  I_UPDATE       VARCHAR2(32000);&#10;  I_WHERE        VARCHAR2(32000);&#10;  I_CONTADOR_UPD NUMBER;&#10;BEGIN&#10;  --DHG:22411:Incluida verificação para que sempre volte para o bloco origem após terminar a verificação&#10;  :GLOBAL.MD_BLOCO := :SYSTEM.CURSOR_BLOCK;&#10;  PROX_BLOCO := GET_FORM_PROPERTY(:SYSTEM.CURRENT_FORM,FIRST_BLOCK);&#10;  ULTI_BLOCO := GET_FORM_PROPERTY(:SYSTEM.CURRENT_FORM,LAST_BLOCK);&#10;  IF PROX_BLOCO IS NOT NULL THEN&#10;    WHILE (PROX_BLOCO &#60;> ULTI_BLOCO) LOOP&#10;      /* MRH:17/12/2008:20503&#10;       * Verifico se o bloco atual não é um bloco padrão usado no Maxys.&#10;       * Essa verificação evita que um desses blocos seja exibido na tela&#10;       * caso o WHILE termine sobre um deles.&#10;       */&#10;      IF PROX_BLOCO NOT IN ('IMPRESSAO','CONSULTA','PROGRESSAO','PROGRESSAO2','VERSAO_REL','BALANCA') THEN&#10;        /* MWE:18/09/2007:15149&#10;         * ao alterar o TGR012, encontrei um erro neste procedimento.&#10;         * O TGR012 tem um bloco que não tem item navegáveis e ocorre &#10;         * erro ao entrar no bloco.&#10;         * adicionado o comando para retornar true caso o bloco seja nevegável&#10;         */ &#10;        IF GET_BLOCK_PROPERTY(PROX_BLOCO,ENTERABLE) = 'TRUE' THEN&#10;          GO_BLOCK (PROX_BLOCO);&#10;          I_TP_EVENTO    := '';&#10;          I_REGISTRO     := '';&#10;          I_DS_EVENTO    := '';&#10;          I_CAMPOS_INS   := '';&#10;          I_VALORES_INS  := '';&#10;          I_INSERT       := '';&#10;          I_CONTADOR_INS := 0;&#10;          I_CAMPOS_UPD   := '';&#10;          I_VALORES_UPD  := '';&#10;          I_UPDATE       := '';&#10;          I_CONTADOR_UPD := 0;&#10;          I_WHERE        := '';&#10;          TABELA         := GET_BLOCK_PROPERTY(PROX_BLOCO,DML_DATA_TARGET_NAME);&#10;          PRIM_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,FIRST_ITEM);&#10;          ULTI_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,LAST_ITEM);&#10;          STATUS         := :SYSTEM.RECORD_STATUS;&#10;          LOOP&#10;            IF STATUS = 'INSERT' THEN&#10;              --GDG:05/01/2010:32828 Adicionada verificação para gravar auditoria dos campos sublinhados(por padrão, são campos obrigatórios)&#10;              IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' OR&#10;                 GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PROMPT_FONT_STYLE) = 'UNDERLINE' THEN&#10;                I_TP_EVENTO := 'I';&#10;                I_REGISTRO  := I_REGISTRO||' '||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PROMPT_TEXT)||' '||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;                I_DS_EVENTO := ('Inseriu na tabela ' || TABELA || ' o registro ' || I_REGISTRO);&#10;              END IF;&#10;              IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NOT NULL THEN&#10;                IF (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'TEXT ITEM') OR&#10;                   (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'LIST') OR  &#10;                   (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'RADIO GROUP') OR &#10;                   (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'CHECK BOX') THEN&#10;                  IF I_CONTADOR_INS = 0 THEN&#10;                    I_CAMPOS_INS  := ' ( '||PRIM_ITEM;&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;                      I_VALORES_INS := ' ( '||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;                    ELSE&#10;                      I_VALORES_INS := ' ( '||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;                    END IF;&#10;                  ELSE&#10;                    I_CAMPOS_INS := I_CAMPOS_INS||', '||PRIM_ITEM;&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;                      I_VALORES_INS := I_VALORES_INS||', '||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;                    ELSE&#10;                      I_VALORES_INS := I_VALORES_INS||', '||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;                    END IF;&#10;                  END IF;&#10;                  I_INSERT := 'INSERT INTO '||TABELA;&#10;                END IF;&#10;                I_CONTADOR_INS := I_CONTADOR_INS + 1;&#10;              END IF;&#10;            ELSIF STATUS = 'CHANGED' THEN&#10;              IF (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'TEXT ITEM') OR&#10;                 (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'LIST') OR&#10;                 (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'RADIO GROUP') OR&#10;                 (GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,ITEM_TYPE) = 'CHECK BOX') THEN&#10;                 GO_ITEM (PROX_BLOCO||'.'||PRIM_ITEM);&#10;                --GDG:05/01/2010:32828 Adicionada verificação para gravar auditoria dos campos sublinhados(por padrão, são campos obrigatórios)&#10;                IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' OR&#10;                   GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PROMPT_FONT_STYLE) = 'UNDERLINE' THEN&#10;                  I_TP_EVENTO := 'A';&#10;                  I_REGISTRO  := I_REGISTRO||' '||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PROMPT_TEXT)||' '||:SYSTEM.CURSOR_VALUE;&#10;                  I_DS_EVENTO := ('Atualizou o registro ' || I_REGISTRO || ' na tabela ' || TABELA);&#10;                END IF;&#10;                IF (:SYSTEM.CURSOR_VALUE IS NOT NULL) THEN&#10;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) &#60;> 'TRUE' THEN&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;                      IF (PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.HR_RECORD') THEN&#10;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||' = '||CHR(39)||TO_CHAR(RETORNA_DATAHORA,'HH24:MI')||CHR(39)||', ';&#10;                      ELSE&#10;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||' = '||CHR(39)||:SYSTEM.CURSOR_VALUE||CHR(39)||', ';&#10;                      END IF;&#10;                    ELSE&#10;                      IF (PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.DT_RECORD') THEN&#10;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||' = '||RETORNA_DATAHORA||', ';&#10;                      ELSE&#10;                        I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||' = '||:SYSTEM.CURSOR_VALUE||', ';&#10;                      END IF;&#10;                    END IF;&#10;                  END IF;&#10;                ELSIF (:SYSTEM.CURSOR_VALUE IS NULL) THEN&#10;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) &#60;> 'TRUE' THEN&#10;                    I_VALORES_UPD := I_VALORES_UPD||PRIM_ITEM||' = '||CHR(39)||' '||CHR(39)||', ';&#10;                  END IF;&#10;                END IF;&#10;              END IF;&#10;              IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;                IF I_CONTADOR_UPD = 0 THEN&#10;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;                    I_CAMPOS_UPD := I_CAMPOS_UPD||PRIM_ITEM||' = '||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;                  ELSE&#10;                    I_CAMPOS_UPD := I_CAMPOS_UPD||PRIM_ITEM||' = '||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;                  END IF;&#10;                ELSE&#10;                  IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;                    I_CAMPOS_UPD := I_CAMPOS_UPD||' AND '||PRIM_ITEM||' = '||CHR(39)||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;                  ELSE&#10;                    I_CAMPOS_UPD := I_CAMPOS_UPD||' AND '||PRIM_ITEM||' = '||GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;                  END IF;&#10;                END IF;&#10;                I_CONTADOR_UPD := I_CONTADOR_UPD + 1;&#10;                I_WHERE        := ' WHERE '||I_CAMPOS_UPD;&#10;              END IF;&#10;            END IF;&#10;            EXIT WHEN PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.'||ULTI_ITEM;&#10;            PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,NEXTITEM);&#10;          END LOOP;&#10;          IF (I_CAMPOS_INS IS NOT NULL) AND (I_VALORES_INS IS NOT NULL) THEN&#10;            I_CAMPOS_INS  := I_CAMPOS_INS||')';&#10;            I_VALORES_INS := I_VALORES_INS||')';&#10;            I_INSERT      := I_INSERT||I_CAMPOS_INS||' VALUES '||I_VALORES_INS||';';&#10;          END IF;&#10;          IF (I_VALORES_UPD IS NOT NULL) THEN&#10;            I_VALORES_UPD := SUBSTR(I_VALORES_UPD,1,LENGTH(I_VALORES_UPD)-2);&#10;            I_UPDATE      := 'UPDATE '||TABELA||' SET '||I_VALORES_UPD||' '||I_WHERE||';';&#10;          END IF;&#10;          IF I_TP_EVENTO = 'I' THEN&#10;            I_DS_DML := I_INSERT;&#10;          ELSE&#10;            I_DS_DML := I_UPDATE;&#10;          END IF;&#10;          IF I_DS_EVENTO IS NOT NULL THEN&#10;            /*RDS:19/08/2008:18621&#10;            * Alterado para gravar mais de uma linha na logusuario, caso ultrapasse os 2000 caracteres do campo ds_dml&#10;            */&#10;            /*RDS:29177:06/10/2010&#10;             * Acertado laço na gravação do log no procedimento audita_gravacao&#10;            */&#10;            FOR I IN 1.. NVL((TRUNC(LENGTH(I_DS_DML) / 2000) + 1),1) LOOP   &#10;              BEGIN&#10;                INSERT INTO LOGUSUARIO (CD_EMPRESA,CD_USUARIO,CD_MODULO,CD_PROGRAMA,&#10;                                        DT_EVENTO,SQ_EVENTO,HR_EVENTO,DS_EVENTO,TP_EVENTO,DS_DML)&#10;                        VALUES (:GLOBAL.CD_EMPRESA,:GLOBAL.CD_USUARIO,:GLOBAL.CD_MODULO,&#10;                                :GLOBAL.CD_PROGRAMA,RETORNA_DATAHORA,SEQ_AUDITORIA.NEXTVAL,&#10;                                TO_CHAR(RETORNA_DATAHORA,'HH24:MI'),I_DS_EVENTO,I_TP_EVENTO,SUBSTR(I_DS_DML,((I - 1) * 2000 + 1),2000));&#10;              EXCEPTION&#10;                WHEN OTHERS THEN&#10;                  DEBUG_PROGRAMA('AUDITA_GRAVACAO - Erro durante tentativa de inserção na tabela LOGUSUARIO: '||SQLERRM);&#10;              END;&#10;            END LOOP;&#10;          END IF;&#10;        END IF;&#10;      END IF; --IF PROX_BLOCO NOT IN ('IMPRESSAO','CONSULTA','PROGRESSAO','PROGRESSAO2','VERSAO_REL','BALANCA') THEN  &#10;      -- pega o próximo bloco&#10;      PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#10;    END LOOP;&#10;  END IF;&#10;  --DHG:22411:Incluida verificação para que sempre volte para o bloco origem após terminar a verificação&#10;  GO_BLOCK(:GLOBAL.MD_BLOCO);&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="HABILITA_GRAVACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE HABILITA_GRAVACAO&#10;   (BLOCO_INICIAL  IN VARCHAR2,&#10;    BLOCO_FINAL    IN VARCHAR2,&#10;    ITEM_EXCECAO   IN VARCHAR2,&#10;    VERIFICA_CHAVE IN VARCHAR2) IS&#10;    PRIM_ITEM     VARCHAR2(80);&#10;    ULTI_ITEM     VARCHAR2(80);&#10;    PROX_BLOCO    VARCHAR2(80);&#10;    ULTI_BLOCO    VARCHAR2(80);&#10;BEGIN&#10;  PROX_BLOCO := BLOCO_INICIAL;&#10;  ULTI_BLOCO := BLOCO_FINAL;&#10;  IF :GLOBAL.TP_ACESSO = 'M' THEN&#10;     SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_TRUE);&#10;     IF (:SYSTEM.RECORD_STATUS = 'NEW') AND (:SYSTEM.LAST_RECORD = 'FALSE') THEN&#10;        SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;     ELSIF (:SYSTEM.RECORD_STATUS = 'NEW') AND (:SYSTEM.LAST_RECORD = 'TRUE') THEN&#10;        IF PROX_BLOCO IS NOT NULL THEN&#10;          LOOP&#10;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#10;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#10;            LOOP&#10;              IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' THEN&#10;                 IF VERIFICA_CHAVE = 'S' THEN&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                      END IF;&#10;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'FALSE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    END IF;&#10;                 END IF;&#10;              END IF;&#10;              EXIT WHEN PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.'||ULTI_ITEM;&#10;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,NEXTITEM);&#10;            END LOOP;&#10;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#10;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#10;          END LOOP;&#10;        END IF;  &#10;     ELSIF (:SYSTEM.RECORD_STATUS = 'QUERY') AND (:SYSTEM.LAST_RECORD = 'FALSE') THEN&#10;        IF PROX_BLOCO IS NOT NULL THEN&#10;          LOOP&#10;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#10;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#10;            LOOP&#10;              IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' THEN&#10;                 IF VERIFICA_CHAVE = 'S' THEN&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'FALSE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    END IF;&#10;                 END IF;&#10;              END IF;&#10;              EXIT WHEN PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.'||ULTI_ITEM;&#10;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,NEXTITEM);&#10;            END LOOP;&#10;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#10;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#10;          END LOOP;&#10;        END IF;  &#10;     ELSIF (:SYSTEM.RECORD_STATUS = 'QUERY') AND (:SYSTEM.LAST_RECORD = 'TRUE') THEN&#10;        IF PROX_BLOCO IS NOT NULL THEN&#10;           LOOP&#10;             PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#10;             ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#10;             LOOP&#10;               IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' THEN&#10;                 IF VERIFICA_CHAVE = 'S' THEN&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'FALSE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    END IF;&#10;                 END IF;&#10;              END IF;&#10;              EXIT WHEN PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.'||ULTI_ITEM;&#10;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,NEXTITEM);&#10;            END LOOP;&#10;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#10;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#10;          END LOOP;&#10;        END IF;  &#10;     ELSIF (:SYSTEM.RECORD_STATUS = 'INSERT') AND (:SYSTEM.LAST_RECORD = 'TRUE') THEN&#10;        IF PROX_BLOCO IS NOT NULL THEN&#10;          LOOP&#10;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#10;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#10;            LOOP&#10;              IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' THEN&#10;                 IF VERIFICA_CHAVE = 'S' THEN&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'FALSE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    END IF;&#10;                 END IF;&#10;              END IF;&#10;              EXIT WHEN PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.'||ULTI_ITEM;&#10;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,NEXTITEM);&#10;            END LOOP;&#10;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#10;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#10;          END LOOP;&#10;        END IF;  &#10;     ELSIF (:SYSTEM.RECORD_STATUS = 'INSERT') AND (:SYSTEM.LAST_RECORD = 'FALSE') THEN&#10;        IF PROX_BLOCO IS NOT NULL THEN&#10;          LOOP&#10;            PRIM_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,FIRST_ITEM);&#10;            ULTI_ITEM := GET_BLOCK_PROPERTY(PROX_BLOCO,LAST_ITEM);&#10;            LOOP&#10;              IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' THEN&#10;                 IF VERIFICA_CHAVE = 'S' THEN&#10;                    IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    ELSIF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,PRIMARY_KEY) = 'FALSE' THEN&#10;                       IF PROX_BLOCO||'.'||PRIM_ITEM &#60;> ITEM_EXCECAO THEN&#10;                          IF GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,DATABASE_VALUE) IS NULL THEN&#10;                             SET_ITEM_PROPERTY('TOOLBAR.BTN_GRAVA',ENABLED,PROPERTY_FALSE);&#10;                          END IF;&#10;                       END IF;&#10;                    END IF;&#10;                 END IF;&#10;              END IF;&#10;              EXIT WHEN PROX_BLOCO||'.'||PRIM_ITEM = PROX_BLOCO||'.'||ULTI_ITEM;&#10;              PRIM_ITEM := GET_ITEM_PROPERTY(PROX_BLOCO||'.'||PRIM_ITEM,NEXTITEM);&#10;            END LOOP;&#10;            EXIT WHEN PROX_BLOCO = ULTI_BLOCO;&#10;            PROX_BLOCO := GET_BLOCK_PROPERTY(PROX_BLOCO,NEXTBLOCK);&#10;          END LOOP;&#10;        END IF;  &#10;     END IF;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="AUDITA_EXCLUSAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE AUDITA_EXCLUSAO IS&#10;  PRIM_ITEM   VARCHAR2(80);&#10;  ULTI_ITEM   VARCHAR2(80);&#10;  ULTI_BLOCO  VARCHAR2(80);&#10;  TABELA      VARCHAR2(80);&#10;  I_TP_EVENTO LOGUSUARIO.TP_EVENTO%TYPE;&#10;  I_DS_EVENTO LOGUSUARIO.DS_EVENTO%TYPE;&#10;  I_REGISTRO  LOGUSUARIO.DS_EVENTO%TYPE;&#10;  I_INSTRUCAO LOGUSUARIO.DS_DML%TYPE; --Armazena a instrução de delete completa&#10;  I_CHAVE     LOGUSUARIO.DS_DML%TYPE; --Armazena e é zerada com os atributos chave&#10;  I_CONTADOR  NUMBER;&#10;BEGIN&#10;  --DHG:22411:Incluida verificação para que sempre volte para o bloco origem após terminar a verificação&#10;  :GLOBAL.MD_BLOCO := :SYSTEM.CURSOR_BLOCK;&#10;  I_REGISTRO  := NULL;&#10;  I_DS_EVENTO := NULL;&#10;  I_TP_EVENTO := NULL;&#10;  TABELA      := GET_BLOCK_PROPERTY(:SYSTEM.CURSOR_BLOCK,DML_DATA_TARGET_NAME);&#10;  PRIM_ITEM   := GET_BLOCK_PROPERTY(:SYSTEM.CURSOR_BLOCK,FIRST_ITEM);&#10;  ULTI_ITEM   := GET_BLOCK_PROPERTY(:SYSTEM.CURSOR_BLOCK,LAST_ITEM);&#10;  I_CONTADOR  := 0;&#10;  I_CHAVE     := NULL;&#10;  LOOP&#10;    --GDG:05/01/2010:32828 Adicionada verificação para gravar auditoria dos campos sublinhados(por padrão, são campos obrigatórios)&#10;    IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,REQUIRED) = 'TRUE' OR&#10;       GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,PROMPT_FONT_STYLE) = 'UNDERLINE' THEN&#10;      I_TP_EVENTO := 'E';&#10;      I_REGISTRO  := I_REGISTRO||' '||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,PROMPT_TEXT)||' '||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;      I_DS_EVENTO := ('Excluiu o registro ' || I_REGISTRO || ' da tabela ' || TABELA);&#10;    END IF;&#10;    IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;      IF I_CONTADOR = 0 THEN&#10;        IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;          I_CHAVE := GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,ITEM_NAME)||' = '||&#10;                    CHR(39)||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;        ELSE&#10;          I_CHAVE := GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,ITEM_NAME)||' = '||&#10;                    GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;        END IF;&#10;      ELSIF I_CONTADOR >= 1 THEN&#10;        IF GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;          I_CHAVE := I_CHAVE||' AND '||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,ITEM_NAME)||' = '||&#10;                    CHR(39)||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;        ELSE&#10;          I_CHAVE := I_CHAVE||' AND '||GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,ITEM_NAME)||' = '||&#10;                    GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,DATABASE_VALUE);&#10;        END IF;&#10;      END IF;&#10;      I_INSTRUCAO := 'DELETE FROM '||TABELA||' WHERE '||I_CHAVE;&#10;      I_CONTADOR  := I_CONTADOR + 1;&#10;    END IF;&#10;    &#10;    EXIT WHEN :SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM = :SYSTEM.CURSOR_BLOCK||'.'||ULTI_ITEM;&#10;    PRIM_ITEM := GET_ITEM_PROPERTY(:SYSTEM.CURSOR_BLOCK||'.'||PRIM_ITEM,NEXTITEM);&#10;  END LOOP;&#10;  &#10;  --DHG:22411:Incluida verificação para que sempre volte para o bloco origem após terminar a verificação&#10;  GO_BLOCK(:GLOBAL.MD_BLOCO);&#10;      &#10;  IF I_INSTRUCAO IS NOT NULL THEN&#10;    I_INSTRUCAO := I_INSTRUCAO||';';&#10;  END IF;&#10;  &#10;  BEGIN&#10;    INSERT INTO LOGUSUARIO (CD_EMPRESA,CD_USUARIO,CD_MODULO,CD_PROGRAMA,&#10;                            DT_EVENTO,SQ_EVENTO,HR_EVENTO,DS_EVENTO,TP_EVENTO,DS_DML)&#10;             VALUES (:GLOBAL.CD_EMPRESA,:GLOBAL.CD_USUARIO,:GLOBAL.CD_MODULO,&#10;                     :GLOBAL.CD_PROGRAMA,RETORNA_DATAHORA,SEQ_AUDITORIA.NEXTVAL,&#10;                     TO_CHAR(RETORNA_DATAHORA,'HH24:MI:SS'),I_DS_EVENTO,I_TP_EVENTO,I_INSTRUCAO);&#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      DEBUG_PROGRAMA('AUDITA_EXCLUSAO - Erro durante tentativa de inserção na tabela LOGUSUARIO: '||SQLERRM);&#10;  END;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="AUDITORIA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE AUDITORIA(&#10;V_TP_EVENTO IN LOGUSUARIO.TP_EVENTO%TYPE,&#10;V_DS_EVENTO IN LOGUSUARIO.DS_EVENTO%TYPE) IS&#10;BEGIN  &#10;   INSERT INTO LOGUSUARIO(CD_EMPRESA,&#10;                          CD_USUARIO, &#10;                          CD_MODULO,&#10;                          CD_PROGRAMA,&#10;                          DT_EVENTO, &#10;                          TP_EVENTO, &#10;                          DS_EVENTO,&#10;                          SQ_EVENTO,&#10;                          HR_EVENTO)&#10;     VALUES            (:GLOBAL.CD_EMPRESA,&#10;                        :GLOBAL.CD_USUARIO,&#10;                        :GLOBAL.CD_MODULO,&#10;                        :GLOBAL.CD_PROGRAMA,&#10;                        SYSDATE,&#10;                        V_TP_EVENTO,&#10;                        V_DS_EVENTO,&#10;                        SEQ_AUDITORIA.NEXTVAL,&#10;                        TO_CHAR(SYSDATE,'HH24:MI'));&#10;   &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="CRIA_RECORDGROUP">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE CRIA_RECORDGROUP(  NM_GRUPO IN VARCHAR2,V_INSTRUCAO  IN VARCHAR2,V_ERRO OUT NUMBER) IS&#10;  V_GRUPO             RECORDGROUP;&#10;BEGIN&#10;&#10;  V_GRUPO :=  FIND_GROUP(NM_GRUPO);&#10;  IF NOT ID_NULL(V_GRUPO) THEN&#10;    DELETE_GROUP(V_GRUPO);&#10;  END IF;  &#10;  V_GRUPO:= CREATE_GROUP_FROM_QUERY(NM_GRUPO,V_INSTRUCAO); &#10;  V_ERRO := POPULATE_GROUP(V_GRUPO);&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VERIFICA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VERIFICA(&#10;V_CD_CENTROCUSTO IN ITEMCOMPRACCUSTO.CD_CENTROCUSTO%TYPE,&#10;EXISTE OUT BOOLEAN)  IS&#10;BEGIN&#10;   EXISTE := FALSE;&#10;   FIRST_RECORD;&#10;   WHILE :SYSTEM.LAST_RECORD = 'FALSE' LOOP&#10;      IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO = V_CD_CENTROCUSTO THEN&#10;         EXISTE := TRUE;&#10;      END IF;&#10;   END LOOP;   &#10;END;">
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
<node FOLDED="true" TEXT="VALIDA_ERROS">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_ERROS IS&#10;  TIPO_ERRO   VARCHAR2(03)    := ERROR_TYPE;&#10;  CODIGO_ERRO NUMBER          := ERROR_CODE;&#10;  DBMSERRCODE NUMBER          := DBMS_ERROR_CODE;&#10;  DBMSERRTEXT VARCHAR2(32000) := DBMS_ERROR_TEXT;&#10;  V_DS_PROMPT  VARCHAR2(200);&#10;  V_MASCARA    VARCHAR2(30);&#10;  V_DS_ITEM    VARCHAR2(30);&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL      EXCEPTION;&#10;&#10;BEGIN&#10;  /**&#10;   * Última alteração : 14/11/2008&#10;   * Programador      : RBS - Rubens Sertage&#10;   * Modificação      : Trata a mensagem de erro quando a sessão do usuário expirar.&#10;   */&#10;   /** RBS:SOL20158:14/11/2008&#10;   *  Trata a mensagem de erro quando a sessão do usuário expirar.&#10;   *  Mostra a mensagem apenas uma vez. Deve estar no começo do código.&#10;   *  Se for necessário colocar algum procedimento anterior a este,&#10;   *  o procedimento não deve fazer consulta ao banco. Vai funcionar &#10;   *   normalmente da outra maneira, mas se a sessão expirar os erros não &#10;   *  serão tratados.&#10;   */&#10;  IF (DBMSERRCODE IN (-1012,-28)) THEN &#10;    --Verifica se a mensagem já foi mostrada.&#10;    IF (:GLOBAL.ST_SESSAO_EXPIRADA = 'N') THEN&#10;      MESSAGE('A sua sessão expirou, a aplicação deve ser reiniciada!');&#10;      MESSAGE(' ');&#10;      :GLOBAL.ST_SESSAO_EXPIRADA := 'S';&#10;    END IF;&#10;  ELSE&#10;    /** EDU:03/04/2007&#10;     * Adicionado apenas para verificar o que passa nas variáveis,&#10;     * para facilitar uma futura alteração.&#10;     */&#10;    DEBUG_PROGRAMA(:SYSTEM.CURRENT_FORM||'.'||'VALIDA_ERROS : ERROR_TYPE: '||TIPO_ERRO||' - ERROR_CODE: '||CODIGO_ERRO);&#10;    DEBUG_PROGRAMA(:SYSTEM.CURRENT_FORM||'.'||'VALIDA_ERROS : DBMS_ERROR_CODE: '||DBMSERRCODE||' - DBMS_ERROR_TEXT: '||DBMSERRTEXT);&#10;    &#10;    IF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41803) THEN&#10;      --Não há registro anterior a partir do qual copiar valor&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40209) THEN&#10;      --O campo deve ser da tela FM999G999G999D000.&#10;      IF (:SYSTEM.TRIGGER_ITEM IS NOT NULL) THEN&#10;        V_DS_ITEM   := :SYSTEM.TRIGGER_ITEM;&#10;        V_DS_PROMPT  := GET_ITEM_PROPERTY(V_DS_ITEM,PROMPT_TEXT);&#10;        V_MASCARA   := GET_ITEM_PROPERTY(V_DS_ITEM,FORMAT_MASK);&#10;        V_MENSAGEM := 'O Campo '||V_DS_PROMPT||' deve estar no Formato '||V_MASCARA||'. Favor Verifique!'||:system.record_status;&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 42100) THEN&#10;      --Não foram encontrados erros recentemente&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41003) THEN&#10;      --Esta função não pode ser executada aqui&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40815) THEN&#10;      --A variável %s não existe&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40222) THEN&#10;      --Item desativado %s falhou na validação&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40738) THEN&#10;      --Argumento 1 para incorporar GO_BLOCK não pode ser nulo&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41058) THEN&#10;      --Esta propriedade não existe para GET_ITEM_PROPERTY&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40104) THEN&#10;      --No such block %s&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41045) THEN&#10;      --Não é possível localizar o item : ID inválido&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41332) THEN&#10;      --List element index out of range&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40401) THEN&#10;      --Não há alterações a salvar&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40105) THEN&#10;      --Não foi possível decompor referência ao item ..&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41830) THEN&#10;      IF ( :SYSTEM.CURSOR_ITEM = 'ITEMCOMPRA.CD_MOVIMENTACAO' ) THEN&#10;        BELL;&#10;        MESSAGE('Nenhuma Movimentação cadastrada com o para a Empresa e o Item Selecionados ');&#10;      ELSE&#10;        MESSAGE (ERROR_TYPE||'-'||ERROR_CODE||' '||ERROR_TEXT);  &#10;      END IF;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 41009) THEN&#10;      --Tecla de função não permitida&#10;      NULL;&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40510) THEN&#10;      IF INSTR(DBMSERRTEXT,'ORA-02292',1) > 0 THEN&#10;        BELL;&#10;        MESSAGE('Não foi possivel deletar o registro, registro filho localizado.');&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;      ELSE&#10;        BELL;&#10;        MESSAGE('Não foi possivel deletar o registro.');&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;       END IF;&#10;    /**JMS:26/12/2006:13363&#10;     * COLOCADO ESTE IF AQUI PARA QUE SE CASO VIER ALGUMA MSG DA PACK_ERRO.LEVANTA_ERRO&#10;     * ELE ESTOURE A MENSAGEM Q ELA ESTOUROU NÃO A MSG COM O ORA-20999&#10;     * QUEM DESENVOLVEU O &#34;IF&#34; FOI O &#34;EDU&#34; EU SOH COLOQUEI NO MODELO2 POR O EDU ESTAVA&#10;     * DE FÉRIAS&#10;     */&#10;    /** EDU:03/04/2007:13363&#10;     * Foi removida a verificação da condição do DBMS_ERROR_CODE.&#10;     * Por hora, vai ficar assim, que é mais garantido, mas pode acontecer casos&#10;     * que não deve passar por aqui, então será necessário alterar esta condição.&#10;     * Deixei assim justamente porque não sei quais são estes casos ainda.&#10;     * O DEBUG_PROGRAMA no início do procedimento foi colocado para verificar&#10;     * o que está passando nas variáveis para facilitar a alteração.&#10;     */&#10;    ELSIF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO = 40735) AND (DBMSERRTEXT IS NOT NULL) THEN&#10;      /**JMS:11/05/2007:15981&#10;       * MODIFICAO PARA CONCATENAR O ERROR_TEXT PARA QUE MESMO QUE ESTOURE 1403&#10;       * NO DBMSERRTEXT ELE VAI ESTOURAR O ERRO CORRETO QUE OCORREU DENTRO &#10;       * DE ALGUM GATILHO DENTRO DO FORMS MESMO, DAE É POSSIVEL&#10;       * VER DENTRO DO BOTÃO DETALHES DA MENSAGEM.&#10;       */&#10;      MENSAGEM('Erro',DBMSERRTEXT||' - '||ERROR_TEXT,1);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    ELSE&#10;      MESSAGE(ERROR_TYPE||'-'||ERROR_CODE||' '||ERROR_TEXT);&#10;      /** EDU:05/10/2007&#10;       * Adicionado a verificação de acordo com o erro para dar um RAISE, pois assim,&#10;       * conseguimos tratar para no momento de gravar um bloco de banco, não ficar&#10;       * dando a mensagem várias vezes.&#10;       * Fiquei na dúvida se neste ELSE eu deixava o RAISE direto ou colocava uma condição.&#10;       * Optei por colocar a condição, assim posso evitar de dar problemas generalizados.&#10;       */&#10;      IF (TIPO_ERRO = 'FRM') AND (CODIGO_ERRO IN (40202, 40102)) THEN&#10;        -- 40202 - O campo deve ser informado.&#10;        -- 40102 - O registro deve ser informado ou excluído primeiro.&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;      END IF;&#10;    END IF;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    IF NOT (PACK_PROCEDIMENTOS.V_MSG) THEN&#10;      MENSAGEM('Maxys',V_MENSAGEM,4);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;      PACK_PROCEDIMENTOS.V_MSG := TRUE;&#10;    END IF;&#10;    &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_GLOBAL">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_GLOBAL IS&#10;&#10;  TP_PEDIDO        TIPOPEDIDO.CD_TIPOPEDIDO%TYPE;&#10;  ST_APROVSOLIC    VARCHAR2(1);&#10;  TP_ITEM          VARCHAR2(1);&#10;  QT_PREVISTA      NUMBER;&#10;  TP_SELECAOCONTA  PARMRECEB.TP_SELECAOCONTA%TYPE;&#10;  TP_APROVSOLIC    VARCHAR2(1);&#10;  ST_VALIDACCUSTO  VARCHAR2(1);&#10;  VALIDA_QUANTIDADE  BOOLEAN := TRUE;&#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_TELA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE BODY PACK_TELA IS&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  PROCEDURE VALIDA_OBRIGATORIO(I_NM_BLOCO IN VARCHAR2,&#10;                               O_MENSAGEM IN OUT VARCHAR2) IS&#10;  &#10;    V_TP_BLOCO         NUMBER;&#10;    V_BL_VALIDA        BOOLEAN := TRUE;&#10;    V_ITEMINI           VARCHAR2(61); -- Item Inicial&#10;    V_ITEM             VARCHAR2(61); -- Item Atual&#10;    V_NR_REGISTRO      NUMBER;&#10;    V_NR_REGISTROMSG   NUMBER;&#10;    V_ITEMMSG          VARCHAR2(61);&#10;    V_MENSAGEM         VARCHAR2(2000);&#10;    E_GERAL            EXCEPTION;&#10;  &#10;  BEGIN&#10;    &#10;    V_TP_BLOCO := GET_BLOCK_PROPERTY(FIND_BLOCK(I_NM_BLOCO),RECORDS_DISPLAYED);&#10;    -- Deleta registros em branco quando o bloco for do tipo Grid --&#10;    IF (V_TP_BLOCO &#60;> 1) THEN&#10;      GO_BLOCK(I_NM_BLOCO);&#10;      LOOP&#10;        &#10;        V_ITEMINI := GET_BLOCK_PROPERTY(I_NM_BLOCO, FIRST_ITEM) ;&#10;        V_ITEM    := I_NM_BLOCO || '.' || V_ITEMINI ;&#10;        &#10;        -- Para cada item&#10;        WHILE V_ITEMINI IS NOT NULL LOOP&#10;          -- Verifica se o Item é visivel --&#10;          IF (GET_ITEM_PROPERTY(V_ITEM, VISIBLE) = 'TRUE') AND (GET_ITEM_PROPERTY(V_ITEM, ITEM_CANVAS) IS NOT NULL) THEN&#10;            -- Verifica se o Item pode ser manipulado pelo usuário --&#10;            IF GET_ITEM_PROPERTY(V_ITEM, ITEM_TYPE) NOT IN ('DISPLAY ITEM','BUTTON','OLE OBJECT') THEN&#10;              -- Verifica se o Item está preenchido&#10;              IF NAME_IN(V_ITEM) IS NOT NULL AND (GET_ITEM_PROPERTY(V_ITEM, ENABLED) = 'TRUE') THEN&#10;                V_BL_VALIDA := FALSE;&#10;              END IF;      &#10;            END IF;&#10;          END IF;&#10;          &#10;          -- Próximo item --&#10;          V_ITEMINI   := NULL;&#10;          V_ITEMINI   := GET_ITEM_PROPERTY(V_ITEM, NEXTITEM);&#10;          V_ITEM      := I_NM_BLOCO || '.' || V_ITEMINI;&#10;        END LOOP;&#10;        &#10;        IF V_BL_VALIDA THEN&#10;          DELETE_RECORD;&#10;          FIRST_RECORD;&#10;        END IF;&#10;        &#10;        IF (:SYSTEM.LAST_RECORD = 'TRUE' AND V_BL_VALIDA) THEN&#10;          DELETE_RECORD;&#10;          EXIT;&#10;        END IF;&#10;  &#10;        EXIT WHEN (:SYSTEM.LAST_RECORD = 'TRUE');&#10;        V_BL_VALIDA := TRUE;&#10;        NEXT_RECORD;&#10;      END LOOP;&#10;      CLEAR_MESSAGE;&#10;      FIRST_RECORD;&#10;    END IF;&#10;    &#10;    -- Apenas valida bloco informado, se a variavel de mensagem estiver nula, &#10;    -- indicando que as validações de bloco anteriores não tiveram erro nenhum.&#10;    IF O_MENSAGEM IS NULL THEN&#10;      GO_BLOCK(I_NM_BLOCO);&#10;      FIRST_RECORD;&#10;      LOOP&#10;        &#10;        V_NR_REGISTRO := :SYSTEM.CURSOR_RECORD;&#10;        V_ITEMINI := GET_BLOCK_PROPERTY(I_NM_BLOCO, FIRST_ITEM) ;&#10;        V_ITEM    := I_NM_BLOCO || '.' || V_ITEMINI ;&#10;        &#10;        -- Para cada item&#10;        WHILE V_ITEMINI IS NOT NULL LOOP&#10;          -- Verifica se o Item é visivel --&#10;          IF (GET_ITEM_PROPERTY(V_ITEM, VISIBLE) = 'TRUE') AND (GET_ITEM_PROPERTY(V_ITEM, ITEM_CANVAS) IS NOT NULL) THEN&#10;            -- Verifica se o Item pode ser manipulado pelo usuário --&#10;            IF (GET_ITEM_PROPERTY(V_ITEM, ITEM_TYPE) NOT IN ('DISPLAY ITEM','BUTTON','OLE OBJECT')) THEN&#10;              -- Verifica se o Item é obrigatório (UNDERLINE) e está preenchido&#10;              IF (GET_ITEM_PROPERTY(V_ITEM, PROMPT_FONT_STYLE) = 'UNDERLINE' AND NAME_IN(V_ITEM) IS NULL AND GET_ITEM_PROPERTY(V_ITEM, ENABLED) = 'TRUE') THEN&#10;                IF (V_NR_REGISTROMSG IS NULL AND V_ITEMMSG IS NULL) THEN&#10;                  V_NR_REGISTROMSG := V_NR_REGISTRO;&#10;                  V_ITEMMSG        := V_ITEM;&#10;                END IF;&#10;                V_MENSAGEM := V_MENSAGEM||PACK_MENSAGEM.MENS_PADRAO(1710,'¢DS_VARIAVEL='||GET_ITEM_PROPERTY(V_ITEM, PROMPT_TEXT)||'¢')||'§'; --É Obrigatório Informar o Campo ¢DS_VARIAVEL¢.;&#10;              END IF;      &#10;            END IF;&#10;          END IF;&#10;          &#10;          -- Próximo item --&#10;          V_ITEMINI   := NULL;&#10;          V_ITEMINI   := GET_ITEM_PROPERTY(V_ITEM, NEXTITEM);&#10;          V_ITEM      := I_NM_BLOCO || '.' || V_ITEMINI;&#10;        END LOOP;&#10;        &#10;        IF V_MENSAGEM IS NOT NULL THEN&#10;          GO_RECORD(V_NR_REGISTROMSG);&#10;          GO_ITEM(V_ITEMMSG);&#10;          RAISE E_GERAL;&#10;        END IF;&#10;        &#10;        EXIT WHEN (:SYSTEM.LAST_RECORD = 'TRUE');&#10;        NEXT_RECORD;&#10;      END LOOP;&#10;      FIRST_RECORD;&#10;    END IF;&#10;    &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      O_MENSAGEM := V_MENSAGEM;&#10;    WHEN OTHERS THEN&#10;      -- RRW:05/08/2011:32921: Padronização.&#10;      /*Erro ao validar campos obrigatórios. Erro: ¢SQLERRM¢.¥Local: ¢DS_LOCAL¢*/&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8034, '¢SQLERRM='||SQLERRM||'¢DS_LOCAL=NÃO INFORMADO¢');&#10;      --O_MENSAGEM := SQLERRM;&#10;  END;&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  PROCEDURE HABILITA_ITEM(V_DS_ITEM VARCHAR2,V_NR_REGISTRO NUMBER DEFAULT NULL) IS&#10;  BEGIN&#10;    IF V_NR_REGISTRO IS NULL THEN&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,UPDATE_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,NAVIGABLE,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,VISUAL_ATTRIBUTE,'');&#10;    ELSE&#10;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,UPDATE_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,NAVIGABLE,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,VISUAL_ATTRIBUTE,'');&#10;    END IF;&#10;  END;&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  PROCEDURE DESABILITA_ITEM(V_DS_ITEM VARCHAR2,V_NR_REGISTRO NUMBER DEFAULT NULL) IS&#10;  BEGIN&#10;    IF V_NR_REGISTRO IS NULL THEN&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,UPDATE_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,NAVIGABLE,PROPERTY_FALSE);&#10;      IF GET_ITEM_PROPERTY(V_DS_ITEM,ITEM_TYPE) NOT IN ('RADIO GROUP','CHECKBOX','LIST') THEN&#10;        SET_ITEM_PROPERTY(V_DS_ITEM,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;      END IF;&#10;    ELSE&#10;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,UPDATE_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,NAVIGABLE,PROPERTY_FALSE);&#10;      IF GET_ITEM_PROPERTY(V_DS_ITEM,ITEM_TYPE) NOT IN ('RADIO GROUP','CHECKBOX','LIST') THEN&#10;        SET_ITEM_INSTANCE_PROPERTY(V_DS_ITEM,V_NR_REGISTRO,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;      END IF;&#10;    END IF;&#10;  END;&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  PROCEDURE MOSTRA_ITEM(V_DS_ITEM VARCHAR2) IS&#10;  BEGIN&#10;    IF GET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE) = 'FALSE' THEN&#10;      SET_ITEM_PROPERTY(V_DS_ITEM||'__F',VISIBLE,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,ENABLED,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,NAVIGABLE,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,UPDATE_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,INSERT_ALLOWED,PROPERTY_TRUE);&#10;    END IF;&#10;  END;&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  PROCEDURE OCULTA_ITEM(V_DS_ITEM VARCHAR2) IS&#10;  BEGIN&#10;    IF GET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE) = 'TRUE' THEN&#10;      SET_ITEM_PROPERTY(V_DS_ITEM||'__F',VISIBLE,PROPERTY_FALSE);&#10;      SET_ITEM_PROPERTY(V_DS_ITEM,VISIBLE,PROPERTY_FALSE);&#10;    END IF;&#10;  END;&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_TELA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_TELA IS&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  /* DHG:20/07/2010:21411&#10;   * Criação de um procedimento padrão que valida preenchimento de campos obrigatórios.&#10;   * Para ser considerado campo obrigatório, o programa deve estar padronizado para tal,&#10;   * ou seja, para campos obrigatórios, o prompt do item deve estar sublinhado, indicando&#10;   * a obrigatoriedade.&#10;   * Utilização: antes de efetuar inclusões ou alterações.&#10;   * EX.: Utilizado no KEY-COMMIT:&#10;     -- Quando validamos apenas um bloco.&#10;     VALIDA_OBRIGATORIO('NOME_DO_BLOCO',V_MENSAGEM);&#10;     IF V_MENSAGEM IS NOT NULL THEN&#10;       RAISE E_GERAL; -- RAISE FORM_TRIGGER_FAILURE;&#10;     END IF;&#10;     &#10;     -- Quando queremos validar varios blocos na sequencia&#10;     VALIDA_OBRIGATORIO('NOME_DO_BLOCO_1',V_MENSAGEM);&#10;     VALIDA_OBRIGATORIO('NOME_DO_BLOCO_2',V_MENSAGEM);&#10;     VALIDA_OBRIGATORIO('NOME_DO_BLOCO_N',V_MENSAGEM);&#10;     IF V_MENSAGEM IS NOT NULL THEN&#10;       RAISE E_GERAL; -- RAISE FORM_TRIGGER_FAILURE;&#10;     END IF;&#10;   */&#10;  PROCEDURE VALIDA_OBRIGATORIO(I_NM_BLOCO IN VARCHAR2, O_MENSAGEM IN OUT VARCHAR2);&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  /* DHG:20/07/2010:21411&#10;   * Procedimento utilizado para habilitar as propriedades INSERT, UPDATE e NAVIGABLE do item informado&#10;   */&#10;  PROCEDURE HABILITA_ITEM(V_DS_ITEM VARCHAR2, V_NR_REGISTRO NUMBER DEFAULT NULL);&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  /* DHG:20/07/2010:21411&#10;   * Procedimento utilizado para desabilitar as propriedades INSERT, UPDATE e NAVIGABLE do item informado&#10;   */&#10;  PROCEDURE DESABILITA_ITEM(V_DS_ITEM VARCHAR2, V_NR_REGISTRO NUMBER DEFAULT NULL);&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  /* DHG:20/07/2010:21411&#10;   * Procedimento utilizado para mostrar o item informado. Seta propriedade VISIBLE e dependências.&#10;   * Padrão de utilização: para poder usar este recurso, é preciso ter um item do mesmo tipo criado&#10;                           antes do item que irá ser exibido ao usuário. Este item, obrigatoriamente&#10;                           deve ser o PREVIOUS_ITEM no nível de bloco para o item a ser ocultado e possuir&#10;                           o mesmo nome do item com a adição dos caracteres: &#34;__F&#34;. &#10;   * Motivo do padrão &#34;__F&#34;: esses itens não serão armazenados no dicionario de dados para internacionalização.&#10;   * EX: Item de Fundo/Sombra do tipo TEXT_ITEM: CD_EMPRESA__F. Propriedade ATIVADO deve estar NÃO!&#10;         Item para o usuário do tipo TEXT_ITEM: CD_EMPRESA.&#10;         &#10;         Item de Fundo/Sombra do tipo DISPLAY_ITEM: NM_EMPRESA__F.&#10;         Item para o usuário do tipo DISPLAY_ITEM: NM_EMPRESA.&#10;     Obs: LIST_BOX, BUTTON e CHECK_BOX não necessitam de fundo, porém caso seja preciso, utilizar DISPLAY_ITEM. &#10;   */&#10;  PROCEDURE MOSTRA_ITEM(V_DS_ITEM VARCHAR2);&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;  /* DHG:20/07/2010:21411&#10;   * Procedimento utilizado para mostrar o item informado. Seta propriedade VISIBLE e dependências.&#10;   * Padrão de utilização: para poder usar este recurso, é preciso ter um item do mesmo tipo criado&#10;                           antes do item que irá ser exibido ao usuário. Este item, obrigatoriamente&#10;                           deve ser o PREVIOUS_ITEM no nível de bloco para o item a ser ocultado e possuir&#10;                           o mesmo nome do item com a adição dos caracteres: &#34;__F&#34;.&#10;   * Motivo do padrão &#34;__F&#34;: esses itens não serão armazenados no dicionario de dados para internacionalização.&#10;   * EX: Item de Fundo/Sombra do tipo TEXT_ITEM: CD_EMPRESA__F. Propriedade ATIVADO deve estar NÃO!&#10;         Item para o usuário do tipo TEXT_ITEM: CD_EMPRESA.&#10;         &#10;         Item de Fundo/Sombra do tipo DISPLAY_ITEM: NM_EMPRESA__F.&#10;         Item para o usuário do tipo DISPLAY_ITEM: NM_EMPRESA.&#10;     Obs: LIST_BOX, BUTTON e CHECK_BOX não necessitam de fundo, porém caso seja preciso, utilizar DISPLAY_ITEM. &#10;   */&#10;  PROCEDURE OCULTA_ITEM(V_DS_ITEM VARCHAR2);&#10;  ------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_MOVIMENTACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_MOVIMENTACAO (V_MENSAGEM OUT VARCHAR2) IS&#10;  V_CD_CONTACONTABIL     HISTCONTB.CD_CONTACONTABIL%TYPE;&#10;  E_GERAL                EXCEPTION;&#10;  V_DS_MOVIMENTACAO      VARCHAR2(60);  &#10;&#10;BEGIN&#10;  &#10;  /** WLV:13/08/2012:41514&#10;    * Padronização de mensagens.&#10;    */   &#10;  &#10;  /* RBM: 21356: 25/03/2009&#10;   * Tratamento de consultas abaixo.&#10;   */       &#10;  IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN&#10;    BEGIN&#10;      SELECT PARMOVIMENT.DS_MOVIMENTACAO &#10;        INTO V_DS_MOVIMENTACAO &#10;        FROM PARMOVIMENT&#10;       WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        V_DS_MOVIMENTACAO := NULL;&#10;        --V_MENSAGEM := 'Código de Movimentação não Cadastrado';&#10;        --A Movimentação ¢CD_MOVIMENTACAO¢ não está cadastrada. Verifique o programa TCB008.&#10;        V_MENSAGEM :=PACK_MENSAGEM.MENS_PADRAO(46, '¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;         V_DS_MOVIMENTACAO := NULL;&#10;        --V_MENSAGEM := 'Código de movimentação encontrado em duplicidade.';&#10;        --A Movimentação ¢CD_MOVIMENTACAO¢ está cadastrada várias vezes. Verifique TCB008.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(47, '¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;         V_DS_MOVIMENTACAO := NULL;&#10;        --V_MENSAGEM := 'Erro ao consultar descrição da movimentação - '||SQLERRM;&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(48, '¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢SQLERRM='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;    &#10;    /** WLV:13/08/2012:41514&#10;      * Comentado NEGOCIO do from e da clausula WHERE o N.CD_NEGOCIO = ITEMCONTANEG.CD_NEGOCIO&#10;      * pois estava retornando TOO_MANY_ROWS mesmo com os NEGOCIOS diferentes.&#10;      */   &#10;    BEGIN &#10;      /*CSL:30/12/2013:64869*/&#10;      IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;        SELECT HISTCONTB.CD_CONTACONTABIL&#10;          INTO V_CD_CONTACONTABIL&#10;          FROM PARMOVIMENT,HISTCONTB,ITEMCONTANEG,PLANOCONTABIL&#10;         WHERE HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#10;           AND PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;           AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#10;           AND ITEMCONTANEG.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#10;           AND ITEMCONTANEG.CD_ITEM           = :ITEMCOMPRA.CD_ITEM   &#10;           AND ITEMCONTANEG.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA&#10;           AND ITEMCONTANEG.ST_SITUACAO       = 'A'&#10;           AND ITEMCONTANEG.CD_NEGOCIO        = (SELECT MIN(I.CD_NEGOCIO) &#10;                                                    FROM /*NEGOCIO N,*/ ITEMCONTANEG I &#10;                                                   WHERE /*N.CD_NEGOCIO     = ITEMCONTANEG.CD_NEGOCIO&#10;                                                     AND */I.CD_ITEM        = ITEMCONTANEG.CD_ITEM&#10;                                                     AND I.CD_EMPRESA       = ITEMCONTANEG.CD_EMPRESA&#10;                                                     AND I.ST_SITUACAO       = 'A'&#10;                                                     AND I.CD_CONTACONTABIL = ITEMCONTANEG.CD_CONTACONTABIL); &#10;      ELSE&#10;        SELECT HISTCONTB.CD_CONTACONTABIL&#10;          INTO V_CD_CONTACONTABIL&#10;          FROM PARMOVIMENT, HISTCONTB, ITEMCONTANEG, PLANOCONTABILVERSAO&#10;         WHERE HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#10;           AND PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;           AND PLANOCONTABILVERSAO.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#10;           AND ITEMCONTANEG.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#10;           AND ITEMCONTANEG.CD_ITEM           = :ITEMCOMPRA.CD_ITEM   &#10;           AND ITEMCONTANEG.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA&#10;           AND ITEMCONTANEG.ST_SITUACAO       = 'A'&#10;           AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE))&#10;           AND ITEMCONTANEG.CD_NEGOCIO        = (SELECT MIN(I.CD_NEGOCIO) &#10;                                                   FROM ITEMCONTANEG I &#10;                                                  WHERE I.CD_ITEM          = ITEMCONTANEG.CD_ITEM&#10;                                                    AND I.CD_EMPRESA       = ITEMCONTANEG.CD_EMPRESA&#10;                                                    AND I.ST_SITUACAO      = 'A'&#10;                                                    AND I.CD_CONTACONTABIL = ITEMCONTANEG.CD_CONTACONTABIL);   &#10;      END IF;      &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --Conta Contábil não associada ao item ¢CD_ITEM¢, na empresa ¢CD_EMPRESA¢ e movimentação ¢CD_MOVIMENTACAO¢. Verifique os programas TCB008 e TIT001.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7955, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;         V_DS_MOVIMENTACAO := NULL;&#10;        --Conta Contábil associada várias vezes ao item ¢CD_ITEM¢, na empresa ¢CD_EMPRESA¢ e movimentação ¢CD_MOVIMENTACAO¢.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7956, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;         V_DS_MOVIMENTACAO := NULL;&#10;        --Erro ao pesquisar conta contábil ¢CD_CONTACONTABIL¢. Erro ¢SQLERRM¢.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(144, '¢CD_CONTACONTABIL='||V_CD_CONTACONTABIL||'¢SQLERRM='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END; &#10;  ELSE&#10;    V_DS_MOVIMENTACAO := NULL;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_SOLICITACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_SOLICITACAO IS  &#10;BEGIN&#10;  IF :ITEMCOMPRA.CD_EMPRESA IS NULL THEN&#10;      mensagem('Maxys','Informe o código da empresa',2);&#10;      GO_ITEM('ITEMCOMPRA.CD_EMPRESA');&#10;      --RAISE E_GERAL;         &#10;  END IF;     &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_GRUPO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_GRUPO IS&#10;  --CENTRO CUSTO&#10;  PROCEDURE CRIA_GRUPO_CC;&#10;  PROCEDURE ADICIONA_GRUPO_CC(I_CD_EMPRCCUSTODEST IN NUMBER,&#10;                              I_CD_ITEM            IN NUMBER,&#10;                              I_CD_CENTROCUSTO    IN NUMBER,&#10;                              I_CD_MOVIMENTACAO   IN NUMBER,&#10;                              I_CD_AUTORIZADOR    IN VARCHAR2,&#10;                              I_QT_PEDIDAUNIDSOL  IN NUMBER,&#10;                               I_PC_PARTICIPACAO   IN NUMBER,&#10;                               I_CD_NEGOCIO        IN NUMBER,&#10;                               I_DS_OBSERVACAO     IN VARCHAR2,&#10;                               I_CD_CONTAORCAMENTO IN NUMBER);&#10;                              &#10;  PROCEDURE DELETA_GRUPO_CC  (I_CD_ITEM    IN NUMBER);&#10;  PROCEDURE CARREGA_DADOS_CC (I_CD_ITEM    IN NUMBER);&#10;  &#10;&#10;  --LOVS DO CENTRO DE CUSTO&#10;  PROCEDURE CRIA_GRUPO_LOVCC;&#10;  PROCEDURE ADICIONA_GRUPO_LOVCC(I_CD_ITEM     IN NUMBER,&#10;                                  I_CD_CENTROCUSTO  IN NUMBER,&#10;                                 I_PC_PARTICIPACAO IN NUMBER);&#10;  PROCEDURE DELETA_GRUPO_LOVCC;&#10;&#10;  --PROCEDURE CARREGA_DADOS_NG (I_CD_ITEM    IN NUMBER);  &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_GRUPO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE BODY PACK_GRUPO IS&#10;-----------------------------------------------------------------------------&#10;-----------------------------------------------------------------------------&#10;                             -- CENTRO CUSTO --&#10;-----------------------------------------------------------------------------&#10;-----------------------------------------------------------------------------&#10;  PROCEDURE CRIA_GRUPO_CC IS&#10;    GRP_REPLICA RECORDGROUP;&#10;    COL_REPLICA GROUPCOLUMN;&#10;  BEGIN&#10;    GRP_REPLICA := FIND_GROUP('GRUPO_CC');&#10;    IF NOT ID_NULL(GRP_REPLICA) THEN &#10;      DELETE_GROUP(GRP_REPLICA); &#10;    END IF;&#10;    &#10;    GRP_REPLICA := CREATE_GROUP('GRUPO_CC');&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'CD_ITEM'          , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'CD_CENTROCUSTO'   , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'CD_NEGOCIO'       , NUMBER_COLUMN);/*CSL:21/12/2010:30317*/&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'CD_MOVIMENTACAO'  , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'CD_AUTORIZADOR'   , CHAR_COLUMN,4);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'QT_PEDIDAUNIDSOL' , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'PC_PARTICIPACAO'  , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'CD_EMPRCCUSTODEST', NUMBER_COLUMN);--GDG:22/07/2011:28715&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'DS_OBSERVACAO'    , CHAR_COLUMN,150);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_CC', 'CD_CONTAORCAMENTO', NUMBER_COLUMN);&#10;    &#10;  END CRIA_GRUPO_CC;&#10;  ---------------------------------------------------------------------------------------------&#10;  &#10;  PROCEDURE ADICIONA_GRUPO_CC(I_CD_EMPRCCUSTODEST IN NUMBER,&#10;                              I_CD_ITEM            IN NUMBER,&#10;                              I_CD_CENTROCUSTO    IN NUMBER,&#10;                              I_CD_MOVIMENTACAO   IN NUMBER,&#10;                              I_CD_AUTORIZADOR    IN VARCHAR2,&#10;                              I_QT_PEDIDAUNIDSOL  IN NUMBER,&#10;                               I_PC_PARTICIPACAO   IN NUMBER,&#10;                               I_CD_NEGOCIO        IN NUMBER/*CSL:21/12/2010:30317*/,&#10;                               I_DS_OBSERVACAO     IN VARCHAR2,&#10;                               I_CD_CONTAORCAMENTO IN NUMBER) IS&#10;  BEGIN&#10;    ADD_GROUP_ROW('GRUPO_CC',END_OF_GROUP);&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.CD_EMPRCCUSTODEST', GET_GROUP_ROW_COUNT('GRUPO_CC'), I_CD_EMPRCCUSTODEST);--GDG:22/07/2011:28715&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM'          , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_CD_ITEM         );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO'   , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_CD_CENTROCUSTO  );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.CD_NEGOCIO'       , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_CD_NEGOCIO      );/*CSL:21/12/2010:30317*/&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.CD_MOVIMENTACAO'  , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_CD_MOVIMENTACAO );&#10;    SET_GROUP_CHAR_CELL  ('GRUPO_CC.CD_AUTORIZADOR'   , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_CD_AUTORIZADOR  );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.QT_PEDIDAUNIDSOL' , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_QT_PEDIDAUNIDSOL);&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.PC_PARTICIPACAO'  , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_PC_PARTICIPACAO );&#10;    SET_GROUP_CHAR_CELL  ('GRUPO_CC.DS_OBSERVACAO'    , GET_GROUP_ROW_COUNT('GRUPO_CC'), I_DS_OBSERVACAO   );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CONTAORCAMENTO', GET_GROUP_ROW_COUNT('GRUPO_CC'), I_CD_CONTAORCAMENTO);&#10;    &#10;  END ADICIONA_GRUPO_CC;&#10;  ---------------------------------------------------------------------------------------------&#10;  PROCEDURE DELETA_GRUPO_CC( I_CD_ITEM IN NUMBER ) IS&#10;    NR_REG NUMBER;&#10;    NR_TOT NUMBER;&#10;  BEGIN&#10;    &#10;    LOOP&#10;      NR_TOT := GET_GROUP_ROW_COUNT('GRUPO_CC');&#10;      NR_REG := 0;&#10;      FOR I IN 1 ..GET_GROUP_ROW_COUNT('GRUPO_CC') LOOP&#10;        NR_REG := NR_REG + 1;&#10;        IF GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM', I) = I_CD_ITEM THEN&#10;          DELETE_GROUP_ROW('GRUPO_CC', I);&#10;          EXIT;&#10;        END IF;&#10;      END LOOP;&#10;      EXIT WHEN NR_TOT = NR_REG;&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;  END DELETA_GRUPO_CC;&#10;  &#10;  ---------------------------------------------------------------------------------------------&#10;  PROCEDURE CARREGA_DADOS_CC (I_CD_ITEM IN NUMBER) IS&#10;  I_EXISTE   BOOLEAN;&#10;  BEGIN  &#10;    I_EXISTE := FALSE;&#10;    GO_BLOCK('ITEMCOMPRACCUSTO');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    FIRST_RECORD;    &#10;    IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN /*ATR:80785:11/02/2015*/&#10;      FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_CC') LOOP&#10;        IF NVL(GET_GROUP_ROW_COUNT('GRUPO_CC'),0) > 0 THEN&#10;          IF I_CD_ITEM = GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM', I) THEN&#10;            :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_EMPRCCUSTODEST', I);&#10;            :ITEMCOMPRACCUSTO.CD_ITEM           := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM'           , I);&#10;            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO    := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO'   , I);&#10;            :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO   := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_MOVIMENTACAO'  , I);&#10;            :ITEMCOMPRACCUSTO.CD_AUTORIZADOR    := GET_GROUP_CHAR_CELL  ('GRUPO_CC.CD_AUTORIZADOR'   , I);  &#10;            :ITEMCOMPRACCUSTO.PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL('GRUPO_CC.PC_PARTICIPACAO'  , I);&#10;            :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL('GRUPO_CC.QT_PEDIDAUNIDSOL' , I);            &#10;            :ITEMCOMPRACCUSTO.CD_NEGOCIO        := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_NEGOCIO'       , I);&#10;            :ITEMCOMPRACCUSTO.DS_OBSERVACAO     := GET_GROUP_CHAR_CELL  ('GRUPO_CC.DS_OBSERVACAO'    , I);&#10;            I_EXISTE := TRUE;&#10;            NEXT_RECORD;&#10;          END IF;&#10;        END IF;&#10;      END LOOP;&#10;      FIRST_RECORD;&#10;    ELSE --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN  /*ATR:80785:11/02/2015*/&#10;      FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#10;        IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT > 0 THEN&#10;          IF :ITEMCOMPRA.CD_EMPRESA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRESA AND&#10;            :ITEMCOMPRA.NR_ITEMCOMPRA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).NR_ITEMCOMPRA THEN    &#10;            :ITEMCOMPRACCUSTO.CD_ITEM             :=   PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_ITEM;    &#10;            :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRCCUSTODEST;                      &#10;            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO      :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_CENTROCUSTO;         &#10;            :ITEMCOMPRACCUSTO.CD_NEGOCIO          :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_NEGOCIO;                &#10;            :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_MOVIMENTACAO;          &#10;            :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).QT_PEDIDAUNIDSOL;     &#10;            :ITEMCOMPRACCUSTO.PC_PARTICIPACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).PC_PARTICIPACAO;&#10;            I_EXISTE := TRUE;    &#10;            NEXT_RECORD;&#10;          END IF;&#10;        END IF; --IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT > 0 THEN&#10;      END LOOP; --FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#10;      FIRST_RECORD;&#10;    END IF; --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN   &#10;    IF NOT I_EXISTE THEN&#10;      IF  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#10;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO :=  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#10;        GO_ITEM('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL');&#10;      END IF;&#10;     ELSE&#10;      GO_ITEM('ITEMCOMPRACCUSTO.CD_CENTROCUSTO');&#10;    END IF;  &#10;  END;&#10;  &#10;  -----------------------------------------------------------------------------&#10;  -----------------------------------------------------------------------------&#10;                               -- L O V CENTRO CUSTO --&#10;  -----------------------------------------------------------------------------&#10;  -----------------------------------------------------------------------------&#10;  PROCEDURE CRIA_GRUPO_LOVCC IS&#10;    GRP_REPLICA RECORDGROUP;&#10;    COL_REPLICA GROUPCOLUMN;&#10;  BEGIN&#10;    GRP_REPLICA := FIND_GROUP('GRUPO_LOVCC');&#10;    IF NOT ID_NULL(GRP_REPLICA) THEN DELETE_GROUP(GRP_REPLICA); END IF;&#10;    GRP_REPLICA := CREATE_GROUP('GRUPO_LOVCC');&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_LOVCC', 'CD_ITEM'        , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_LOVCC', 'CD_CENTROCUSTO', CHAR_COLUMN, 2000);&#10;  END CRIA_GRUPO_LOVCC;&#10;  ---------------------------------------------------------------------------------------------&#10;  PROCEDURE ADICIONA_GRUPO_LOVCC(I_CD_ITEM          IN NUMBER,&#10;                                 I_CD_CENTROCUSTO   IN NUMBER,&#10;                                  I_PC_PARTICIPACAO  IN NUMBER) IS&#10;  V_CD_CENTROCUSTO VARCHAR2(2000);&#10;  V_EXISTE         NUMBER;&#10;  V_GRUPO          NUMBER;&#10;  BEGIN&#10;    V_CD_CENTROCUSTO := NULL;&#10;    V_EXISTE         := 0;&#10;    -- VERIFICA SE A CONTA ESTA NO RECORD GROUP --&#10;    FOR I IN 1 ..GET_GROUP_ROW_COUNT('GRUPO_LOVCC') LOOP&#10;      IF NVL(GET_GROUP_ROW_COUNT('GRUPO_LOVCC'),0) > 0 THEN&#10;        IF GET_GROUP_NUMBER_CELL('GRUPO_LOVCC.CD_ITEM' ,I) = I_CD_ITEM THEN&#10;          V_CD_CENTROCUSTO := V_CD_CENTROCUSTO||', '||GET_GROUP_CHAR_CELL('GRUPO_LOVCC.CD_CENTROCUSTO', I);&#10;          V_GRUPO  := I;&#10;          V_EXISTE := 1;&#10;        END IF;&#10;      END IF;&#10;    END LOOP;&#10;    IF V_EXISTE = 0 THEN&#10;      ADD_GROUP_ROW('GRUPO_LOVCC',END_OF_GROUP);&#10;      SET_GROUP_NUMBER_CELL('GRUPO_LOVCC.CD_ITEM'     , GET_GROUP_ROW_COUNT('GRUPO_LOVCC'), I_CD_ITEM);&#10;      SET_GROUP_CHAR_CELL('GRUPO_LOVCC.CD_CENTROCUSTO', GET_GROUP_ROW_COUNT('GRUPO_LOVCC'), I_CD_CENTROCUSTO||' x '||I_PC_PARTICIPACAO||'%') ;&#10;    ELSIF V_EXISTE = 1 THEN&#10;      SET_GROUP_CHAR_CELL('GRUPO_LOVCC.CD_CENTROCUSTO', V_GRUPO, SUBSTR(V_CD_CENTROCUSTO,3,LENGTH(V_CD_CENTROCUSTO))||', '||&#10;                                                                 I_CD_CENTROCUSTO||' x '||I_PC_PARTICIPACAO||'%');&#10;    END IF;&#10;  END ADICIONA_GRUPO_LOVCC;&#10;  ---------------------------------------------------------------------------------------------&#10;  PROCEDURE DELETA_GRUPO_LOVCC IS&#10;  BEGIN&#10;    DELETE_GROUP('GRUPO_LOVCC');&#10;    PACK_GRUPO.CRIA_GRUPO_LOVCC;&#10;  END DELETA_GRUPO_LOVCC;&#10;&#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="ADICIONA_GRUPO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE ADICIONA_GRUPO IS&#10;BEGIN      &#10;  --Adiciona novas linhas no grupo com os dados do bloco e nr_registro = :GLOBAL.NR_REGISTRO&#10;  GO_BLOCK('ITEMCOMPRACCUSTO');&#10;  FIRST_RECORD;&#10;  --Deleta o quem tem no grupo com nr_registro = :GLOBAL.NR_REGISTRO&#10;  PACK_GRUPO.DELETA_GRUPO_CC(:ITEMCOMPRACCUSTO.CD_ITEM);&#10;  FIRST_RECORD;&#10;  LOOP&#10;    IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN        &#10;      PACK_GRUPO.ADICIONA_GRUPO_CC(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,--GDG:22/07/2011:28715&#10;                                   :ITEMCOMPRACCUSTO.CD_ITEM,&#10;                                   :ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#10;                                   :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#10;                                   :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,&#10;                                   :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL,&#10;                                    :ITEMCOMPRACCUSTO.PC_PARTICIPACAO,&#10;                                    :ITEMCOMPRACCUSTO.CD_NEGOCIO,&#10;                                    :ITEMCOMPRACCUSTO.DS_OBSERVACAO,&#10;                                    :ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO);&#10;    END IF;&#10;    EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;    NEXT_RECORD;  &#10;  END LOOP;  &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_PROCEDIMENTOS">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_PROCEDIMENTOS IS &#10;  &#10;  V_MSG  BOOLEAN := FALSE;&#10;  &#10;  V_VT_PROJETORATEIO     PACK_PROJETOMONI.REG_PROJETORATEIO;  &#10;  NR_REGBLOCO           NUMBER;&#10;  &#10;  TYPE TB_ITENS IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;&#10;  T_ITENS   TB_ITENS;&#10;  &#10;  TYPE TB_STRING IS TABLE OF VARCHAR2(32000) INDEX BY BINARY_INTEGER;&#10;  T_ERROS   TB_STRING;&#10;  &#10;  V_VERIFICA_CHAMADA_RCO6  BOOLEAN := FALSE;&#10;  V_DUPLICADO   BOOLEAN := FALSE; /*ATR:80785:11/02/2015*/&#10;  V_CCUSTO      BOOLEAN := FALSE; &#10;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE MOSTRA_ULTIMAS_COMPRAS;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE SOLICITACAO_DEVOLVIDA;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  FUNCTION RETORNA_TP_PEDIDO RETURN VARCHAR2;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  FUNCTION PERMITE_COMPRA(I_QT_ESTOQUEMAX  IN NUMBER,&#10;                          I_QT_SALDO      IN NUMBER,&#10;                          I_QT_ESTOQUE    IN NUMBER,&#10;                          I_QT_PEDIDA      IN NUMBER) RETURN BOOLEAN;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE CARREGA_ITEMCOMPRA(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                               I_NR_LOTECOMPRA  IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,&#10;                               O_MENSAGEM       OUT VARCHAR2);&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE CARREGA_ITEMCOMPRACCUSTO(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                                     I_NR_ITEMCOMPRA  IN ITEMCOMPRA.NR_ITEMCOMPRA%TYPE);&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE CARREGA_LOTE;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------  &#10;  TYPE R_ITEMCOMPRA IS RECORD(NR_ITEMCOMPRA   ITEMCOMPRA.NR_ITEMCOMPRA%TYPE,&#10;                              CD_EMPRESA      ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                              CD_ITEM           ITEMCOMPRA.CD_ITEM%TYPE,&#10;                              CD_MOVIMENTACAO  ITEMCOMPRA.CD_MOVIMENTACAO%TYPE,&#10;                              QT_PREVISTA      ITEMCOMPRA.QT_PREVISTA%TYPE&#10;                              );&#10;  &#10;  TYPE T_ITEMCOMPRA IS TABLE OF R_ITEMCOMPRA INDEX BY BINARY_INTEGER;&#10;  &#10;  VET_ITEMCOMPRA T_ITEMCOMPRA;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------  &#10;  TYPE R_ITEMCOMPRACCUSTO IS RECORD(NR_ITEMCOMPRA      ITEMCOMPRACCUSTO.NR_ITEMCOMPRA%TYPE,&#10;                                    CD_EMPRESA        ITEMCOMPRACCUSTO.CD_EMPRESA%TYPE,&#10;                                    CD_ITEM            ITEMCOMPRA.CD_ITEM%TYPE,&#10;                                    CD_EMPRCCUSTODEST  ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST%TYPE,&#10;                                    CD_CENTROCUSTO    ITEMCOMPRACCUSTO.CD_CENTROCUSTO%TYPE,   &#10;                                    CD_NEGOCIO        ITEMCOMPRACCUSTO.CD_NEGOCIO%TYPE,&#10;                                    CD_MOVIMENTACAO   ITEMCOMPRACCUSTO.CD_MOVIMENTACAO%TYPE,   &#10;                                    QT_PEDIDAUNIDSOL  ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL%TYPE,&#10;                                    PC_PARTICIPACAO    ITEMCOMPRACCUSTO.PC_PARTICIPACAO%TYPE&#10;                                    );   &#10;  &#10;  TYPE T_ITEMCOMPRACCUSTO IS TABLE OF R_ITEMCOMPRACCUSTO INDEX BY BINARY_INTEGER;&#10;  &#10;  VET_ITEMCOMPRACCUSTO   T_ITEMCOMPRACCUSTO;&#10;  VET_ITEMCOMPRANEGOCIO  T_ITEMCOMPRACCUSTO;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------  &#10;  PROCEDURE CARREGA_PEDIDOINTERNO_EMV078;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------  &#10;  /* ASF:25/03/2019:132689 */  &#10;   PROCEDURE CARREGA_ITENSSOLICCOMPRA_TMP;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------  &#10;  /* ASF:17/06/2019:134714 */ &#10;  ST_VALIDA_ANOSAFRA BOOLEAN DEFAULT FALSE;&#10;   &#10;   PROCEDURE VALIDA_ANOSAFRA(O_MENSAGEM OUT VARCHAR2);&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  /*ASF:08/07/2019:134720*/&#10;  PROCEDURE SALVA_ANEXO(O_MENSAGEM OUT VARCHAR2); &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  /*ASF:09/07/2019:134720*/&#10;  TYPE TDSARQUIVOS IS RECORD(&#10;      CD_EMPRESA    NUMBER,&#10;      NR_ITEMCOMPRA NUMBER,&#10;      DS_ARQUIVO    VARCHAR2(32000));&#10;      &#10;  TYPE T_DSARQUIVOS IS TABLE OF TDSARQUIVOS INDEX BY BINARY_INTEGER;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ARQUIVOS T_DSARQUIVOS;  &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE GRAVA_ARQUIVOS_VETOR(V_CD_EMPRESA    IN NUMBER,&#10;                                 V_NR_ITEMCOMPRA IN NUMBER, &#10;                                 V_DS_ARQUIVO    IN VARCHAR2,&#10;                                 O_MENSAGEM     OUT VARCHAR2);  &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  FUNCTION EXISTE_ARQUIVOS(V_CD_EMPRESA    IN NUMBER,&#10;                           V_NR_ITEMCOMPRA IN NUMBER) RETURN BOOLEAN;  &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE VALIDA_AUTORIZADOR(I_MENSAGEM OUT VARCHAR2);&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  PROCEDURE VALIDA_LOCALARMAZ(V_MENSAGEM OUT VARCHAR2); &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  PROCEDURE CONSULTA_NM_LOCALARMAZENAGEM;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_PROCEDIMENTOS">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE BODY PACK_PROCEDIMENTOS IS&#10;  PROCEDURE MOSTRA_ULTIMAS_COMPRAS IS&#10;    I_QT_PEDEXIBIR  PARMCOMPRA.QT_PEDEXIBIR%TYPE;&#10;    I_MENSAGEM      VARCHAR2(2000);&#10;    E_GERAL         EXCEPTION;&#10;      &#10;  BEGIN&#10;    IF :ITEMCOMPRA.CD_ITEM IS NULL THEN&#10;      --Informe o item para visualizar as últimas compras!&#10;      I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4678,'');&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    SELECT QT_PEDEXIBIR &#10;      INTO I_QT_PEDEXIBIR&#10;      FROM PARMCOMPRA&#10;     WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;    &#10;    DECLARE&#10;      CURSOR CUR_ULTIMASCOMPRAS IS&#10;      SELECT CD_CLIFOR, &#10;             NM_CLIFOR, &#10;             NR_NFFORNEC, &#10;             DT_EMISSAO,&#10;             PS_ATENDIDO, &#10;             QT_ATENDIDA, &#10;             VL_UNITITEM, &#10;             VL_TOTITEM,PC_IPI&#10;        FROM VIEW_ULTIMASCOMPRAS&#10;       WHERE CD_EMPRESA  = :GLOBAL.CD_EMPRESA&#10;         AND CD_ITEM     = :ITEMCOMPRA.CD_ITEM&#10;       ORDER BY TRUNC(DT_EMISSAO) DESC, NM_CLIFOR;&#10;  &#10;      BEGIN&#10;        GO_BLOCK('ULTIMASCOMPRAS');&#10;        SET_BLOCK_PROPERTY('ULTIMASCOMPRAS',INSERT_ALLOWED,PROPERTY_TRUE);&#10;        CLEAR_BLOCK(NO_VALIDATE);&#10;        FOR I IN CUR_ULTIMASCOMPRAS LOOP&#10;          :ULTIMASCOMPRAS.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#10;          :ULTIMASCOMPRAS.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#10;          :ULTIMASCOMPRAS.NR_NFEMPR   := I.NR_NFFORNEC;&#10;          :ULTIMASCOMPRAS.CD_CLIFOR   := I.CD_CLIFOR;&#10;          :ULTIMASCOMPRAS.NM_CLIFOR   := I.NM_CLIFOR;&#10;          :ULTIMASCOMPRAS.PS_ATENDIDO := I.PS_ATENDIDO;&#10;          :ULTIMASCOMPRAS.QT_ATENDIDA := I.QT_ATENDIDA;&#10;          :ULTIMASCOMPRAS.VL_UNITITEM := I.VL_UNITITEM;&#10;          :ULTIMASCOMPRAS.VL_TOTITEM  := I.VL_TOTITEM;&#10;          :ULTIMASCOMPRAS.DT_EMISSAO  := I.DT_EMISSAO;&#10;          :ULTIMASCOMPRAS.PC_IPI      := I.PC_IPI;&#10;          NEXT_RECORD;&#10;        END LOOP;&#10;        FIRST_RECORD;&#10;        SET_BLOCK_PROPERTY('ULTIMASCOMPRAS',INSERT_ALLOWED,PROPERTY_FALSE);&#10;    END;&#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      mensagem('Maxys',I_MENSAGEM,2);&#10;    WHEN OTHERS THEN&#10;      MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;  END MOSTRA_ULTIMAS_COMPRAS;&#10;  &#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  &#10;  PROCEDURE SOLICITACAO_DEVOLVIDA IS&#10;  &#10;  BEGIN&#10;     GO_BLOCK('ITEMCOMPRA');&#10;     CLEAR_BLOCK(NO_VALIDATE);&#10;     &#10;     --:CONTROLE.DS_OBSCANCEL := NULL;&#10;  &#10;     GO_BLOCK('DEVOLUCAO');&#10;     EXECUTE_QUERY;&#10;  END SOLICITACAO_DEVOLVIDA;&#10;&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  &#10;  FUNCTION RETORNA_TP_PEDIDO RETURN VARCHAR2 IS&#10;    BEGIN&#10;      RETURN PACK_GLOBAL.TP_PEDIDO;&#10;    END RETORNA_TP_PEDIDO;&#10;  &#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  /* MGK:60876:26/07/2013  &#10;   * Determina se é possível lançar o item numa compra através da fórmula:&#10;   *&#10;   * Estoque atual do item(I_QT_ESTOQUE) + &#10;   * Solicitações cujo pedido ainda não foi recebido no REC001(I_QT_SALDO) + &#10;   * Quantidade pedida na solicitação de compra atual(I_QT_PEDIDA).&#10;   * &#10;   * Caso o resultado deste cálculo seja superior à quantidade máxima planejada para o item (I_QT_ESTOQUEMAX), não será possível &#10;   * adicioná-lo na solicitação de compra.&#10;   */&#10;  FUNCTION PERMITE_COMPRA(I_QT_ESTOQUEMAX  IN NUMBER,&#10;                          I_QT_SALDO      IN NUMBER,&#10;                          I_QT_ESTOQUE    IN NUMBER,&#10;                          I_QT_PEDIDA      IN NUMBER) RETURN BOOLEAN IS&#10;  &#10;  V_NOVO_SALDO  NUMBER;&#10;  &#10;  BEGIN&#10;    V_NOVO_SALDO := NVL(I_QT_SALDO,0) + NVL(I_QT_ESTOQUE,0) + NVL(I_QT_PEDIDA,0);&#10;    &#10;    IF NVL(V_NOVO_SALDO,0) > NVL(I_QT_ESTOQUEMAX,0) THEN&#10;      RETURN (FALSE);&#10;    ELSE&#10;      RETURN (TRUE);&#10;    END IF;&#10;      &#10;  END;                          &#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  /*ATR:80785:11/02/2015 -- Procedimento criado para carregar os dados da solicitação de&#10;   *compra para a tela de duplicação de lote*/&#10;  PROCEDURE CARREGA_ITEMCOMPRA(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                               I_NR_LOTECOMPRA  IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,&#10;                               O_MENSAGEM       OUT VARCHAR2) IS&#10;  V_INSTRUCAO       VARCHAR2(1000);&#10;  E_GERAL            EXCEPTION;&#10;  V_ERRO            NUMBER;&#10;  V_MENSAGEM        VARCHAR2(32000);  &#10;  BEGIN&#10;    V_INSTRUCAO := 'SELECT ITEMCOMPRA.CD_EMPRESA,&#10;                           ITEMCOMPRA.NR_LOTECOMPRA,&#10;                           ITEMCOMPRA.NR_ITEMCOMPRA,&#10;                           ITEMCOMPRA.CD_ITEM,&#10;                           ITEMCOMPRA.CD_MOVIMENTACAO,&#10;                           ITEMCOMPRA.QT_PREVISTA&#10;                      FROM ITEMCOMPRA&#10;                     WHERE ITEMCOMPRA.CD_EMPRESA = '||I_CD_EMPRESA||'&#10;                       AND ITEMCOMPRA.NR_LOTECOMPRA = '||I_NR_LOTECOMPRA;  &#10;                                            &#10;    CRIA_RECORDGROUP('GRUPO_ITEMCOMPRA_DUPL',V_INSTRUCAO,V_ERRO);&#10;    IF V_ERRO &#60;> 0 THEN&#10;      IF V_ERRO = 1403 THEN&#10;        --A consulta não retornou dados para os parâmetros informados.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1544,NULL);&#10;        RAISE E_GERAL;&#10;      ELSE  &#10;        --Ocorreu um erro inesperado ao criar o grupo de registros. Erro: '||SQLERRM&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1853,'¢SQLERRM='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    END IF; --IF V_ERRO &#60;> 0 THEN&#10;    &#10;    GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    GO_BLOCK('DUPLICAITEMCOMPRA');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    &#10;    FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_ITEMCOMPRA_DUPL') LOOP&#10;        :DUPLICAITEMCOMPRA.CD_EMPRESA       := GET_GROUP_NUMBER_CELL('GRUPO_ITEMCOMPRA_DUPL.CD_EMPRESA',I);&#10;        :DUPLICAITEMCOMPRA.NR_LOTECOMPRA   := GET_GROUP_NUMBER_CELL('GRUPO_ITEMCOMPRA_DUPL.NR_LOTECOMPRA',I);&#10;        :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA   := GET_GROUP_NUMBER_CELL('GRUPO_ITEMCOMPRA_DUPL.NR_ITEMCOMPRA',I);&#10;        :DUPLICAITEMCOMPRA.CD_ITEM         := GET_GROUP_NUMBER_CELL('GRUPO_ITEMCOMPRA_DUPL.CD_ITEM',I);&#10;        :DUPLICAITEMCOMPRA.CD_MOVIMENTACAO := GET_GROUP_NUMBER_CELL('GRUPO_ITEMCOMPRA_DUPL.CD_MOVIMENTACAO',I);&#10;        :DUPLICAITEMCOMPRA.QT_PREVISTA     := GET_GROUP_NUMBER_CELL('GRUPO_ITEMCOMPRA_DUPL.QT_PREVISTA',I);&#10;        &#10;        IF :DUPLICAITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;          :DUPLICAITEMCOMPRA.DS_ITEM := PACK_VALIDATE.RETORNA_DS_ITEM(:DUPLICAITEMCOMPRA.CD_ITEM);&#10;        END IF;&#10;        &#10;        NEXT_RECORD;  &#10;    END LOOP;&#10;    FIRST_RECORD;&#10;&#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      O_MENSAGEM := 'CARREGA_ITEMCOMPRA: '||V_MENSAGEM;&#10;      GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;      CLEAR_BLOCK(NO_VALIDATE);&#10;      GO_BLOCK('DUPLICAITEMCOMPRA');&#10;      CLEAR_BLOCK(NO_VALIDATE);&#10;      GO_ITEM('CONS_ITEMCOMPRA.NR_LOTECOMPRA');&#10;    WHEN OTHERS THEN&#10;      --Ocorreu um erro inesperado ao criar o grupo de registros. Erro ¢SQLERRM¢.&#10;      O_MENSAGEM := 'CARREGA_ITEMCOMPRA: '||PACK_MENSAGEM.MENS_PADRAO(1853, '¢SQLERRM='||SQLERRM||'¢');&#10;       GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;      CLEAR_BLOCK(NO_VALIDATE);&#10;      GO_BLOCK('DUPLICAITEMCOMPRA');&#10;      CLEAR_BLOCK(NO_VALIDATE);&#10;      GO_ITEM('CONS_ITEMCOMPRA.NR_LOTECOMPRA');&#10;  END CARREGA_ITEMCOMPRA;&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  /*ATR:80785:11/02/2015 -- Procedimento criado para carregar os dados de centro de custo&#10;   *para a tela de duplicação de lote*/&#10;  PROCEDURE CARREGA_ITEMCOMPRACCUSTO(I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                                     I_NR_ITEMCOMPRA  IN ITEMCOMPRA.NR_ITEMCOMPRA%TYPE) IS&#10;  V_COUNT            NUMBER;&#10;  &#10;  CURSOR CUR_ITEMCOMPRACCUSTO IS&#10;    SELECT ITEMCOMPRACCUSTO.NR_ITEMCOMPRA,&#10;           ITEMCOMPRACCUSTO.CD_EMPRESA,&#10;           ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,&#10;           ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#10;           ITEMCOMPRACCUSTO.CD_NEGOCIO,&#10;           ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#10;           ITEMCOMPRACCUSTO.CD_AUTORIZADOR,&#10;           ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL,&#10;           ITEMCOMPRACCUSTO.PC_PARTICIPACAO&#10;      FROM ITEMCOMPRACCUSTO&#10;     WHERE ITEMCOMPRACCUSTO.CD_EMPRESA = I_CD_EMPRESA&#10;       AND ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA;&#10;    &#10;  BEGIN&#10;  BEGIN&#10;      SELECT COUNT(*)&#10;        INTO V_COUNT&#10;        FROM ITEMCOMPRACCUSTO&#10;       WHERE ITEMCOMPRACCUSTO.CD_EMPRESA = I_CD_EMPRESA&#10;         AND ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA;&#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        V_COUNT := 0;&#10;    END;&#10;    &#10;    &#10;    &#10;    IF V_COUNT > 0 THEN&#10;      V_CCUSTO := TRUE;&#10;      GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;      CLEAR_BLOCK(NO_VALIDATE);&#10;      FIRST_RECORD;&#10;      FOR I IN CUR_ITEMCOMPRACCUSTO LOOP&#10;          :DUPLICAITEMCOMPRACC.NR_ITEMCOMPRA     := I.NR_ITEMCOMPRA;  &#10;          :DUPLICAITEMCOMPRACC.CD_EMPRESA        := I.CD_EMPRESA;         &#10;          :DUPLICAITEMCOMPRACC.CD_EMPRCCUSTODEST := I.CD_EMPRCCUSTODEST;  &#10;          :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO    := I.CD_CENTROCUSTO;     &#10;          :DUPLICAITEMCOMPRACC.CD_NEGOCIO        := I.CD_NEGOCIO;         &#10;          :DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO   := I.CD_MOVIMENTACAO;    &#10;          :DUPLICAITEMCOMPRACC.CD_AUTORIZADOR    := I.CD_AUTORIZADOR;     &#10;          :DUPLICAITEMCOMPRACC.QT_PEDIDAUNIDSOL  := I.QT_PEDIDAUNIDSOL;         &#10;          :DUPLICAITEMCOMPRACC.PC_PARTICIPACAO   := I.PC_PARTICIPACAO;  &#10;                  &#10;          IF :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO IS NOT NULL THEN&#10;            :DUPLICAITEMCOMPRACC.DS_CENTROCUSTO := PACK_VALIDATE.RETORNA_DS_CENTROCUSTO(:DUPLICAITEMCOMPRACC.CD_CENTROCUSTO);&#10;          END IF;&#10;          &#10;          IF :DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO IS NOT NULL THEN&#10;            :DUPLICAITEMCOMPRACC.DS_MOVIMENTACAO := PACK_VALIDATE.RETORNA_DS_MOVIMENTACAO(:DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO);&#10;          END IF;&#10;          &#10;          NEXT_RECORD;  &#10;      END LOOP; --FOR I IN CUR_ITEMCOMPRACCUSTO LOOP&#10;      FIRST_RECORD;&#10;    ELSE&#10;      V_CCUSTO := FALSE;&#10;      GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;      CLEAR_BLOCK(NO_VALIDATE);&#10;      GO_BLOCK('DUPLICAITEMCOMPRA');  &#10;    END IF; --IF V_COUNT > 0 THEN&#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      NULL;&#10;  END CARREGA_ITEMCOMPRACCUSTO;&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  /*ATR:80785:11/02/2015 -- Procedimento criado para carregar os dados do lote de compra &#10;   *para a tela principal do COM001*/&#10;  PROCEDURE CARREGA_LOTE IS &#10;  V_ITEM VARCHAR2(100); &#10;  BEGIN&#10;&#10;    PACK_PROCEDIMENTOS.V_DUPLICADO := TRUE;   &#10;    &#10;    PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.DELETE;&#10;    PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.DELETE;&#10;    GO_BLOCK('DUPLICAITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    LOOP&#10;      V_ITEM := :SYSTEM.CURSOR_ITEM;&#10;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT + 1).NR_ITEMCOMPRA    := :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA;      &#10;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).CD_EMPRESA       := :DUPLICAITEMCOMPRA.CD_EMPRESA;        &#10;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).CD_ITEM          := :DUPLICAITEMCOMPRA.CD_ITEM;      &#10;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).CD_MOVIMENTACAO := :DUPLICAITEMCOMPRA.CD_MOVIMENTACAO;      &#10;      PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT    ).QT_PREVISTA     := :DUPLICAITEMCOMPRA.QT_PREVISTA;        &#10;       &#10;       &#10;      PACK_PROCEDIMENTOS.CARREGA_ITEMCOMPRACCUSTO(:DUPLICAITEMCOMPRA.CD_EMPRESA,&#10;                                                  :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA);&#10;       IF V_CCUSTO = TRUE THEN&#10;         GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;        FIRST_RECORD;&#10;        LOOP                                    &#10;          IF :DUPLICAITEMCOMPRA.NR_ITEMCOMPRA = :DUPLICAITEMCOMPRACC.NR_ITEMCOMPRA AND&#10;            :DUPLICAITEMCOMPRA.CD_EMPRESA = :DUPLICAITEMCOMPRACC.CD_EMPRESA THEN&#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT + 1).NR_ITEMCOMPRA       := :DUPLICAITEMCOMPRACC.NR_ITEMCOMPRA;      &#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_EMPRESA          := :DUPLICAITEMCOMPRACC.CD_EMPRESA;&#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_ITEM             := :DUPLICAITEMCOMPRA.CD_ITEM;        &#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_EMPRCCUSTODEST := :DUPLICAITEMCOMPRACC.CD_EMPRCCUSTODEST;      &#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_CENTROCUSTO    := :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO;      &#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_NEGOCIO          := :DUPLICAITEMCOMPRACC.CD_NEGOCIO;        &#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).CD_MOVIMENTACAO    := :DUPLICAITEMCOMPRACC.CD_MOVIMENTACAO;      &#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).QT_PEDIDAUNIDSOL   := :DUPLICAITEMCOMPRACC.QT_PEDIDAUNIDSOL;    &#10;            PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT    ).PC_PARTICIPACAO    := :DUPLICAITEMCOMPRACC.PC_PARTICIPACAO;  &#10;                        &#10;            EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;            NEXT_RECORD;&#10;          END IF;&#10;        END LOOP; --Loop Bloco DUPLICAITEMCOMPRACC&#10;        &#10;        GO_ITEM(V_ITEM);&#10;        &#10;       END IF; --IF V_CCUSTO = TRUE THEN&#10;       &#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP; --Loop Bloco DUPLICAITEMCOMPRA&#10;    &#10;    &#10;    FIRST_RECORD;   &#10;    GO_BLOCK('CONTROLE');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    GO_BLOCK('ITEMCOMPRA');&#10;    CLEAR_BLOCK(NO_VALIDATE);  &#10;    FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT LOOP&#10;      IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT > 0 THEN&#10;         :ITEMCOMPRA.NR_ITEMCOMPRA_AUX   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).NR_ITEMCOMPRA;               &#10;         :ITEMCOMPRA.CD_EMPRESA_AUX      :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).CD_EMPRESA;                   &#10;         :ITEMCOMPRA.CD_ITEM             :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).CD_ITEM;                 &#10;         :ITEMCOMPRA.CD_MOVIMENTACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).CD_MOVIMENTACAO;               &#10;         :ITEMCOMPRA.QT_PREVISTA        :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRA(I).QT_PREVISTA;          &#10;      END IF;&#10;      NEXT_RECORD;&#10;    END LOOP; --FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRA.COUNT LOOP&#10;    FIRST_RECORD;    &#10;  /*  GO_BLOCK('ITEMCOMPRACCUSTO');&#10;    CLEAR_BLOCK(NO_VALIDATE);  &#10;    FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#10;      IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT > 0 THEN&#10;        :ITEMCOMPRACCUSTO.NR_ITEMCOMPRA       :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).NR_ITEMCOMPRA;      &#10;        :ITEMCOMPRACCUSTO.CD_EMPRESA          :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRESA;         &#10;        :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_EMPRCCUSTODEST;          &#10;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO      :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_CENTROCUSTO;         &#10;        :ITEMCOMPRACCUSTO.CD_NEGOCIO          :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_NEGOCIO;                &#10;        :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).CD_MOVIMENTACAO;          &#10;        :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL   :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).QT_PEDIDAUNIDSOL;       &#10;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(J).PC_PARTICIPACAO;&#10;        PACK_PROCEDIMENTOS.V_DUPLICADO := TRUE;   &#10;      END IF;&#10;      NEXT_RECORD; &#10;    END LOOP;&#10;    FIRST_RECORD;    */  &#10;    &#10;       &#10;    GO_ITEM('CONTROLE.CD_EMPRESA');&#10;        &#10;  END CARREGA_LOTE;&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------AUG:130776:20/02/2019---------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  PROCEDURE CARREGA_PEDIDOINTERNO_EMV078 IS&#10;    CURSOR CUR_ITEMPEDIDOINTERNO_TMP IS &#10;      SELECT CD_EMPRPEDINTERNO ,&#10;             NR_PEDIDOINTERNO  ,&#10;             CD_ITEM           ,&#10;             QT_PEDIDA         ,&#10;             PS_PEDIDO         &#10;        FROM ITEMPEDIDOINTERNO_TMP;&#10;&#10;  BEGIN&#10;    IF :PARAMETER.CD_MODULO   = 'EMV' AND &#10;       :PARAMETER.CD_PROGRAMA = 78    THEN&#10;        &#10;      :CONTROLE.CD_EMPRESA     := :PARAMETER.CD_EMPRCENTRODISTRIB;&#10;    &#10;      SET_ITEM_PROPERTY('CONTROLE.CD_EMPRESA',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO'); &#10;      SET_ITEM_PROPERTY('CONTROLE.CD_EMPRESA',INSERT_ALLOWED,PROPERTY_FALSE);  &#10;      &#10;      GO_ITEM('CONTROLE.DT_DESEJADA');&#10;      :CONTROLE.DT_DESEJADA    := :PARAMETER.DT_DESEJADA;&#10;      SET_ITEM_PROPERTY('CONTROLE.DT_DESEJADA',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO'); &#10;      SET_ITEM_PROPERTY('CONTROLE.DT_DESEJADA',INSERT_ALLOWED,PROPERTY_FALSE);  &#10;        &#10;      GO_BLOCK('ITEMCOMPRA');  &#10;      FIRST_RECORD;&#10;        &#10;      FOR I IN CUR_ITEMPEDIDOINTERNO_TMP LOOP&#10;        :ITEMCOMPRA.CD_EMPRESA   := :PARAMETER.CD_EMPRCENTRODISTRIB;&#10;        :ITEMCOMPRA.CD_ITEM       := I.CD_ITEM;&#10;        :ITEMCOMPRA.QT_PREVISTA := NVL(I.QT_PEDIDA , I.PS_PEDIDO);&#10;        &#10;        NEXT_RECORD;&#10;      END LOOP;&#10;      FIRST_RECORD;&#10;      &#10;      SET_ITEM_PROPERTY('ITEMCOMPRA.CD_ITEM',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO'); &#10;      SET_ITEM_PROPERTY('ITEMCOMPRA.CD_ITEM',INSERT_ALLOWED,PROPERTY_FALSE);  &#10;      &#10;      SET_ITEM_PROPERTY('ITEMCOMPRA.QT_PREVISTA',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO'); &#10;      SET_ITEM_PROPERTY('ITEMCOMPRA.QT_PREVISTA',INSERT_ALLOWED,PROPERTY_FALSE);  &#10;      &#10;      &#10;    END IF;    &#10;  END CARREGA_PEDIDOINTERNO_EMV078;&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  /* ASF:25/03/2019:132689 */  &#10;    PROCEDURE CARREGA_ITENSSOLICCOMPRA_TMP IS&#10;      CURSOR CUR_ITENSSOLICCOMPRA_TMP IS&#10;        SELECT ITENSGERARSOLICCOMPRA_TMP.CD_ITEM,   &#10;               ITEM.DS_ITEM,      &#10;               ITENSGERARSOLICCOMPRA_TMP.QT_SOLICITADA&#10;          FROM ITENSGERARSOLICCOMPRA_TMP, ITEM&#10;         WHERE ITENSGERARSOLICCOMPRA_TMP.CD_ITEM = ITEM.CD_ITEM;&#10;    &#10;    BEGIN&#10;      &#10;      IF NVL(:PARAMETER.CD_MODULO,'XXX') = 'RCO' AND NVL(:PARAMETER.CD_PROGRAMA,0) = 6 THEN&#10;        &#10;        PACK_PROCEDIMENTOS.V_VERIFICA_CHAMADA_RCO6 := TRUE;&#10;        &#10;        GO_BLOCK('ITEMCOMPRA');&#10;        FIRST_RECORD;&#10;        FOR I IN CUR_ITENSSOLICCOMPRA_TMP LOOP &#10;          :ITEMCOMPRA.CD_ITEM      := I.CD_ITEM;&#10;          :ITEMCOMPRA.QT_PREVISTA   := I.QT_SOLICITADA;&#10;           NEXT_RECORD;&#10;        END LOOP;&#10;        FIRST_RECORD;&#10;        &#10;        PACK_PROCEDIMENTOS.V_VERIFICA_CHAMADA_RCO6 := FALSE;&#10;      END IF;  &#10;    END;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------    &#10;  /* ASF:17/06/2019:134714 */  &#10;  PROCEDURE VALIDA_ANOSAFRA(O_MENSAGEM OUT VARCHAR2) IS  &#10;    V_ST_VALIDA_ANOSAFRA VARCHAR2(1);  &#10;  BEGIN&#10;      &#10;    V_ST_VALIDA_ANOSAFRA := PACK_PARMGEN.CONSULTA_PARAMETRO('VFT',4,'MAX',1,'LST_ANOSAFRA');&#10;    &#10;    IF (NVL(V_ST_VALIDA_ANOSAFRA,'N') IN ('S','I')) THEN --Parâmetro &#34;Utilizar cadastro de Ano Safra/Obrigar Informe&#34; - Página VFT004 do VFT028.&#10;      IF (:CONTROLE.DT_ANOSAFRA IS NOT NULL) THEN&#10;        BEGIN&#10;          SELECT ANOSAFRA.NR_SEQUENCIAL,&#10;                 ANOSAFRA.DT_ANOSAFRA||' - '||ANOSAFRA.DS_ANOSAFRA&#10;            INTO :CONTROLE.DT_ANOSAFRA,&#10;                 :CONTROLE.DS_ANOSAFRA&#10;            FROM ANOSAFRA&#10;           WHERE ANOSAFRA.CD_EMPRESA     = NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA)&#10;             AND ANOSAFRA.NR_SEQUENCIAL = :CONTROLE.DT_ANOSAFRA;&#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            :CONTROLE.DS_ANOSAFRA := NULL;&#10;            O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20997, '¢NR_SEQUENCIAL='||:CONTROLE.DT_ANOSAFRA||'¢');&#10;          WHEN TOO_MANY_ROWS THEN&#10;            O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20998, '¢NR_SEQUENCIAL='||:CONTROLE.DT_ANOSAFRA||'¢');&#10;        END;&#10;        &#10;        IF (O_MENSAGEM IS NOT NULL) AND (NOT ST_VALIDA_ANOSAFRA) THEN&#10;          :CONTROLE.DS_ANOSAFRA := 'SEM CADASTRO DE ANO SAFRA.';&#10;          ST_VALIDA_ANOSAFRA  := TRUE;&#10;          O_MENSAGEM := NULL;&#10;          RETURN;&#10;        ELSIF (O_MENSAGEM IS NOT NULL) THEN&#10;          RETURN;&#10;        END IF;&#10;&#10;      ELSE&#10;        IF (:SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM) THEN&#10;          :CONTROLE.DS_ANOSAFRA := NULL;&#10;        END IF;&#10;      END IF;&#10;    ELSE&#10;      IF (:CONTROLE.DT_ANOSAFRA IS NOT NULL) THEN&#10;        :CONTROLE.DS_ANOSAFRA := 'SEM CADASTRO DE ANO SAFRA.';&#10;      ELSE&#10;        :CONTROLE.DS_ANOSAFRA := NULL;&#10;      END IF;&#10;    END IF;&#10;  END;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------  &#10;    ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------&#10;  /*ASF:08/07/2019:134720*/&#10;  PROCEDURE SALVA_ANEXO(O_MENSAGEM OUT VARCHAR2) IS    &#10;    V_DS_EVENTO    VARCHAR2(32000);&#10;    V_NM_ARQUIVO   VARCHAR2(32000);&#10;    V_NM_GRAVACAO  VARCHAR2(32000);&#10;&#10;    E_GERAL         EXCEPTION;&#10;  BEGIN&#10;&#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    LOOP  &#10;      &#10;      FOR J IN 1..ARQUIVOS.COUNT LOOP&#10;        IF ARQUIVOS(J).CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA AND ARQUIVOS(J).NR_ITEMCOMPRA = :SYSTEM.CURSOR_RECORD THEN&#10;          &#10;          V_NM_GRAVACAO := NEW_SYSGUID()||'\'||ARQUIVOS(J).DS_ARQUIVO;&#10;          &#10;          PACK_FILELOADER.UPLOAD_ARQUIVOBD(I_DS_ARQUIVO  => ARQUIVOS(J).DS_ARQUIVO,&#10;                                           I_NM_GRAVACAO => V_NM_GRAVACAO,&#10;                                           O_MENSAGEM     => O_MENSAGEM);&#10;                                                                                                                    &#10;          IF O_MENSAGEM IS NOT NULL THEN&#10;            RAISE E_GERAL;&#10;          END IF;  &#10;          &#10;          V_NM_ARQUIVO := PACK_ARQUIVOUTILS.RETORNA_NOMEARQUIVO(ARQUIVOS(J).DS_ARQUIVO);&#10;          &#10;          BEGIN &#10;            INSERT INTO ANEXOITEMCOMPRA&#10;                   (NR_ITEMCOMPRA,&#10;                    CD_EMPRESA,&#10;                    DS_ARQUIVO,&#10;                    NM_ARQUIVO,&#10;                    DT_RECORD) &#10;            VALUES (:ITEMCOMPRA.NR_ITEMCOMPRA,&#10;                    :ITEMCOMPRA.CD_EMPRESA,&#10;                    V_NM_GRAVACAO,&#10;                    V_NM_ARQUIVO,&#10;                    SYSDATE);       &#10;          EXCEPTION&#10;            WHEN DUP_VAL_ON_INDEX THEN&#10;              --O Anexo ¢V_NM_ARQUIVO¢ já foi inserido nessa solicitação de compra!&#10;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32684, '¢V_NM_ARQUIVO='||V_NM_ARQUIVO||'¢');&#10;              RAISE E_GERAL;                &#10;            WHEN OTHERS THEN&#10;               /*Ocorreu o seguinte erro ao inserir na tabela ¢TABELA¢: ¢SQLERRM¢*/&#10;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6980, '¢TABELA=ANEXOITEMCOMPRA¢SQLERRM='||SQLERRM||'¢');&#10;              RAISE E_GERAL;&#10;          END;          &#10;          &#10;          V_DS_EVENTO := 'O USUARIO ('||:GLOBAL.CD_USUARIO||') INSERIU NA TABELA ANEXO DE SOLICITAÇÃO DE COMPRA, COM O NR_ITEMCOMPRA '||&#10;                         '('||:ITEMCOMPRA.NR_ITEMCOMPRA||'), COM O EMPRESA ('||:ITEMCOMPRA.CD_EMPRESA||').' ;&#10;      &#10;          PACK_LOGUSUARIO.AUDITAR_INSERCAO(V_CD_EMPRESA  => :GLOBAL.CD_EMPRESA,&#10;                                           V_CD_MODULO   => :GLOBAL.CD_MODULO,&#10;                                           V_CD_PROGRAMA => :GLOBAL.CD_PROGRAMA,&#10;                                           V_CD_USUARIO  => :GLOBAL.CD_USUARIO,&#10;                                           V_DS_EVENTO   => V_DS_EVENTO,&#10;                                           V_NM_ENTIDADE => 'ANEXOITEMCOMPRA',&#10;                                           V_DS_DML      => NULL);&#10;        END IF;  &#10;      &#10;      END LOOP;&#10;&#10;      EXIT WHEN (:SYSTEM.LAST_RECORD = 'TRUE');&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    FIRST_RECORD;  &#10;  &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      NULL;&#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(25697, '¢SQLERRM='||SQLERRM||'¢');&#10;  END SALVA_ANEXO;  &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE GRAVA_ARQUIVOS_VETOR(V_CD_EMPRESA    IN NUMBER,&#10;                                 V_NR_ITEMCOMPRA IN NUMBER, &#10;                                 V_DS_ARQUIVO    IN VARCHAR2,&#10;                                 O_MENSAGEM     OUT VARCHAR2) IS&#10;    V_NR_ITENS     NUMBER;&#10;    V_NM_ARQUIVO   VARCHAR2(32000);  &#10;    &#10;    E_GERAL         EXCEPTION;                  &#10;  BEGIN&#10;    &#10;    IF V_CD_EMPRESA IS NOT NULL AND V_NR_ITEMCOMPRA IS NOT NULL AND V_DS_ARQUIVO IS NOT NULL THEN&#10;      V_NM_ARQUIVO := PACK_ARQUIVOUTILS.RETORNA_NOMEARQUIVO(V_DS_ARQUIVO);&#10;      V_NR_ITENS := 0;&#10;      -- Verifica se o item adicional, com a chave da combo principal já foi gravado no vetor&#10;      FOR J IN 1..ARQUIVOS.COUNT LOOP&#10;        IF ARQUIVOS(J).DS_ARQUIVO = V_DS_ARQUIVO &#10;          AND ARQUIVOS(J).NR_ITEMCOMPRA = V_NR_ITEMCOMPRA&#10;          AND ARQUIVOS(J).CD_EMPRESA = V_CD_EMPRESA THEN&#10;          O_MENSAGEM := 'O Anexo ('||V_NM_ARQUIVO||') já foi inserido';&#10;          RAISE E_GERAL;&#10;        END IF;        &#10;      END LOOP;&#10;      V_NR_ITENS := NVL(ARQUIVOS.COUNT,0) + 1;&#10;      &#10;      ARQUIVOS(V_NR_ITENS).DS_ARQUIVO    := V_DS_ARQUIVO; &#10;      ARQUIVOS(V_NR_ITENS).NR_ITEMCOMPRA := V_NR_ITEMCOMPRA;&#10;      ARQUIVOS(V_NR_ITENS).CD_EMPRESA    := V_CD_EMPRESA;  &#10;    END IF;   &#10;  &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      NULL;&#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM := '¥[PACK_PROCEDIMENTOS.GRAVA_ARQUIVOS_VETOR: Erro] ¥'||SQLERRM;     &#10;  END;          &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  FUNCTION EXISTE_ARQUIVOS(V_CD_EMPRESA    IN NUMBER,&#10;                           V_NR_ITEMCOMPRA IN NUMBER) RETURN BOOLEAN IS&#10;   EXISTE BOOLEAN := FALSE;                           &#10;  BEGIN                              &#10;      &#10;    FOR I IN 1..ARQUIVOS.COUNT LOOP&#10;      IF ARQUIVOS(I).CD_EMPRESA = V_CD_EMPRESA AND ARQUIVOS(I).NR_ITEMCOMPRA = V_NR_ITEMCOMPRA THEN&#10;        EXISTE := TRUE;&#10;      END IF;  &#10;    END LOOP;&#10;    &#10;    RETURN EXISTE;&#10;    &#10;  END;  &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------  &#10;  PROCEDURE VALIDA_AUTORIZADOR(I_MENSAGEM OUT VARCHAR2) IS&#10;  &#10;  V_CD_AUTORICCUSTO  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#10;  V_CD_AUTORICCUSTO2 AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#10;  E_GERAL EXCEPTION; &#10;    &#10;  BEGIN&#10;     IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#10;      GO_BLOCK('ITEMCOMPRACCUSTO');&#10;      FIRST_RECORD;&#10;      &#10;      LOOP&#10;        IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947  &#10;          BEGIN  &#10;            SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)  &#10;              INTO V_CD_AUTORICCUSTO&#10;              FROM AUTORIZCCUSTORESTRITO&#10;             WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO &#10;               AND AUTORIZCCUSTORESTRITO.CD_EMPRESA = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#10;               AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = 'S';  &#10;            EXCEPTION &#10;              WHEN OTHERS THEN&#10;                V_CD_AUTORICCUSTO := NULL;  &#10;          END;&#10;   &#10;          IF V_CD_AUTORICCUSTO IS NOT NULL THEN &#10;            IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN &#10;              /*O autorizador da tela principal deve ser informado.*/&#10;              I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33735, NULL);&#10;              RAISE E_GERAL; &#10;            END IF; -- IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN &#10;            BEGIN  &#10;              SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#10;                INTO V_CD_AUTORICCUSTO2&#10;                FROM AUTORIZCCUSTORESTRITO&#10;               WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO  &#10;                 AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR&#10;                 AND AUTORIZCCUSTORESTRITO.CD_EMPRESA = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#10;                 AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = 'S';  &#10;            EXCEPTION&#10;              WHEN NO_DATA_FOUND THEN  &#10;                I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');  &#10;                RAISE E_GERAL;  &#10;            END;&#10;          END IF;  --IF V_CD_AUTORICCUSTO IS NOT NULL THEN &#10;        END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN &#10;        GO_BLOCK('ITEMCOMPRACCUSTO');&#10;        EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;        NEXT_RECORD;&#10;      END LOOP;&#10;    END IF;  -- IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#10;    &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      NULL;&#10;    WHEN OTHERS THEN&#10;      I_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(16084, '¢SQLERRM='||SQLERRM||'¢');&#10;  &#10;  END;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;  PROCEDURE VALIDA_LOCALARMAZ(V_MENSAGEM OUT VARCHAR2) IS --eml:22/05/2020:148401&#10;&#10;  V_COUNT                NUMBER;&#10;  E_GERAL                EXCEPTION;&#10;&#10;  BEGIN&#10;  &#10;    IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN&#10;      BEGIN&#10;        SELECT COUNT(*)&#10;          INTO V_COUNT&#10;          FROM PARMOVIMENT, CMI&#10;         WHERE PARMOVIMENT.CD_CMI = CMI.CD_CMI&#10;           AND CMI.CD_OPERESTOQUE IS NOT NULL&#10;           AND  PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO;&#10;      EXCEPTION&#10;        WHEN OTHERS THEN&#10;          V_COUNT := 0;&#10;      END;&#10;      &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_TIPOLOCALARMAZ',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_TIPOLOCALARMAZ',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_TIPOLOCALARMAZ',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');     &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_LOCALARMAZ',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_LOCALARMAZ',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);     &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_LOCALARMAZ',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ1',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ1',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);   &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ1',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');  &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ2',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ2',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);   &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ2',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');  &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ3',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ3',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE);   &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ3',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');  &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ4',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_FALSE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ4',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_FALSE); &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ4',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;      &#10;      IF V_COUNT > 0 THEN --V_COUNT 1&#10;        BEGIN&#10;          SELECT COUNT(*)&#10;            INTO V_COUNT&#10;            FROM LOCALARMAZENAGEMUSUARIO&#10;           WHERE (LOCALARMAZENAGEMUSUARIO.CD_EMPRESA = :CONTROLE.CD_EMPRESA OR LOCALARMAZENAGEMUSUARIO.CD_EMPRESA IS NULL)&#10;             AND LOCALARMAZENAGEMUSUARIO.CD_USUARIO = :GLOBAL.CD_USUARIO&#10;             AND NVL(LOCALARMAZENAGEMUSUARIO.ST_ATIVO, 'N') = 'S';&#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            V_COUNT := 0;&#10;        END;&#10; &#10;        IF V_COUNT > 0  THEN --V_COUNT &#10;          BEGIN&#10;            SELECT LOCALARMAZENAGEMUSUARIO.CD_TIPOLOCALARMAZ,&#10;                   LOCALARMAZENAGEMUSUARIO.CD_LOCALARMAZ,&#10;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ1,&#10;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ2,&#10;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ3,&#10;                   LOCALARMAZENAGEMUSUARIO.NR_SUBLOCARMAZ4&#10;              INTO :ITEMCOMPRA.CD_TIPOLOCALARMAZ,&#10;                   :ITEMCOMPRA.CD_LOCALARMAZ,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ1,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ2,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ3,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ4&#10;              FROM LOCALARMAZENAGEMUSUARIO&#10;             WHERE (LOCALARMAZENAGEMUSUARIO.CD_EMPRESA = :CONTROLE.CD_EMPRESA OR LOCALARMAZENAGEMUSUARIO.CD_EMPRESA IS NULL)&#10;               AND LOCALARMAZENAGEMUSUARIO.CD_USUARIO = :GLOBAL.CD_USUARIO&#10;               AND NVL(LOCALARMAZENAGEMUSUARIO.ST_ATIVO, 'N') = 'S';&#10;          EXCEPTION&#10;            WHEN TOO_MANY_ROWS THEN&#10;              IF SHOW_LOV('LOV_LOCALUSUARIO') THEN&#10;                NULL;&#10;              ELSE&#10;                /*O Local de Armazenagem deve ser informado.*/&#10;                 V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3619, NULL);&#10;                 RAISE E_GERAL;&#10;              END IF;&#10;            WHEN OTHERS THEN&#10;              :ITEMCOMPRA.CD_TIPOLOCALARMAZ  := NULL;&#10;              :ITEMCOMPRA.CD_LOCALARMAZ      := NULL;&#10;              :ITEMCOMPRA.NR_SUBLOCARMAZ1    := NULL;&#10;              :ITEMCOMPRA.NR_SUBLOCARMAZ2    := NULL;&#10;              :ITEMCOMPRA.NR_SUBLOCARMAZ3    := NULL;&#10;              :ITEMCOMPRA.NR_SUBLOCARMAZ4    := NULL;&#10;          END;&#10;                          &#10;          BEGIN &#10;            SELECT COUNT(*)&#10;              INTO V_COUNT&#10;              FROM ITEMLOCALARMAZ&#10;             WHERE (ITEMLOCALARMAZ.CD_EMPRESA        = :GLOBAL.CD_EMPRESA)&#10;               AND (ITEMLOCALARMAZ.CD_ITEM           = :ITEMCOMPRA.CD_ITEM)&#10;               AND (ITEMLOCALARMAZ.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ)&#10;               AND (ITEMLOCALARMAZ.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ)&#10;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1)&#10;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2)&#10;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3)&#10;               AND (ITEMLOCALARMAZ.NR_SUBLOCARMAZ4   = :ITEMCOMPRA.NR_SUBLOCARMAZ4)&#10;               AND (NVL(ITEMLOCALARMAZ.ST_ITEMLOCAL , 'A') = 'A');&#10;          EXCEPTION&#10;            WHEN OTHERS THEN&#10;              MENSAGEM_PADRAO(15996, '¢NM_TABELA='||'ITEMLOCALARMAZ'||'¢SQLERRM='||SQLERRM||'¢');&#10;               RAISE E_GERAL;&#10;          END;&#10;&#10;&#10;           IF V_COUNT = 0 THEN&#10;              /*O Local de Armazenagem ¢CD_TIPOLOCALARMAZ¢ - ¢CD_LOCALARMAZ¢- ¢NR_SUBLOCALARMAZ1¢ - ¢NR_SUBLOCALARMAZ2¢ - ¢NR_SUBLOCALARMAZ3¢ - ¢NR_SUBLOCALARMAZ4¢ não está cadastrado para o item ¢CD_ITEM¢ e empresa ¢CD_EMPRESA¢ . Verifique TIT001.*/&#10;             V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(393, '¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ||'¢CD_LOCALARMAZ='||:ITEMCOMPRA.CD_LOCALARMAZ||'¢NR_SUBLOCALARMAZ1='||:ITEMCOMPRA.NR_SUBLOCARMAZ1||'¢NR_SUBLOCALARMAZ2='||:ITEMCOMPRA.NR_SUBLOCARMAZ2||'¢NR_SUBLOCALARMAZ3='||:ITEMCOMPRA.NR_SUBLOCARMAZ3||'¢NR_SUBLOCALARMAZ4='||:ITEMCOMPRA.NR_SUBLOCARMAZ4||'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢');&#10;              RAISE E_GERAL;&#10;           END IF;&#10;&#10;        ELSIF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('TES',25,'MAX',:GLOBAL.CD_EMPRESA,'ST_VALIDALOCAL'),'N') = 'S' THEN --V_COUNT 2&#10;          BEGIN&#10;            SELECT ITEMLOCALARMAZ.CD_TIPOLOCALARMAZ,&#10;                   ITEMLOCALARMAZ.CD_LOCALARMAZ,&#10;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ1,&#10;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ2,&#10;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ3,&#10;                   ITEMLOCALARMAZ.NR_SUBLOCARMAZ4&#10;              INTO :ITEMCOMPRA.CD_TIPOLOCALARMAZ,&#10;                   :ITEMCOMPRA.CD_LOCALARMAZ,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ1,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ2,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ3,&#10;                   :ITEMCOMPRA.NR_SUBLOCARMAZ4           &#10;              FROM ITEMLOCALARMAZ&#10;             WHERE (ITEMLOCALARMAZ.CD_EMPRESA        = :GLOBAL.CD_EMPRESA)&#10;               AND (ITEMLOCALARMAZ.CD_ITEM           = :ITEMCOMPRA.CD_ITEM)&#10;               AND (NVL(ITEMLOCALARMAZ.ST_ITEMLOCAL , 'A') = 'A');&#10;          EXCEPTION&#10;            WHEN TOO_MANY_ROWS THEN&#10;              IF SHOW_LOV('LOV_LOCALUSUARIO') THEN --FZZER UMA LOV NOVA&#10;                NULL;&#10;              ELSE&#10;               /*O Local de Armazenagem deve ser informado.*/&#10;                V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3619, NULL);&#10;                RAISE E_GERAL;&#10;              END IF;&#10;            WHEN OTHERS THEN&#10;              /*O Local de Armazenagem ¢CD_TIPOLOCALARMAZ¢ - ¢CD_LOCALARMAZ¢- ¢NR_SUBLOCALARMAZ1¢ - ¢NR_SUBLOCALARMAZ2¢ - ¢NR_SUBLOCALARMAZ3¢ - ¢NR_SUBLOCALARMAZ4¢ não está cadastrado para o item ¢CD_ITEM¢ e empresa ¢CD_EMPRESA¢ . Verifique TIT001.*/&#10;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(393, '¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ||'¢CD_LOCALARMAZ='||:ITEMCOMPRA.CD_LOCALARMAZ||'¢NR_SUBLOCALARMAZ1='||:ITEMCOMPRA.NR_SUBLOCARMAZ1||'¢NR_SUBLOCALARMAZ2='||:ITEMCOMPRA.NR_SUBLOCARMAZ2||'¢NR_SUBLOCALARMAZ3='||:ITEMCOMPRA.NR_SUBLOCARMAZ3||'¢NR_SUBLOCALARMAZ4='||:ITEMCOMPRA.NR_SUBLOCARMAZ4||'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢');&#10;              RAISE E_GERAL;&#10;          END;    &#10;        END IF; -- IF V_COUNT 2&#10;      END IF; --IF V_COUNT 1&#10;    ELSE&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_TIPOLOCALARMAZ',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_TIPOLOCALARMAZ',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_TIPOLOCALARMAZ',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');     &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_LOCALARMAZ',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_LOCALARMAZ',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);     &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.CD_LOCALARMAZ',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ1',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ1',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);   &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ1',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');  &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ2',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ2',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);   &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ2',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');  &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ3',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ3',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE);   &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ3',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');  &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ4',CURRENT_RECORD,INSERT_ALLOWED,PROPERTY_TRUE);&#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ4',CURRENT_RECORD,UPDATE_ALLOWED,PROPERTY_TRUE); &#10;      SET_ITEM_INSTANCE_PROPERTY ('ITEMCOMPRA.NR_SUBLOCARMAZ4',CURRENT_RECORD,VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');&#10;    END IF; --:ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      :ITEMCOMPRA.CD_TIPOLOCALARMAZ  := NULL;&#10;      :ITEMCOMPRA.CD_LOCALARMAZ      := NULL;&#10;      :ITEMCOMPRA.NR_SUBLOCARMAZ1    := NULL;&#10;      :ITEMCOMPRA.NR_SUBLOCARMAZ2    := NULL;&#10;      :ITEMCOMPRA.NR_SUBLOCARMAZ3    := NULL;&#10;      :ITEMCOMPRA.NR_SUBLOCARMAZ4    := NULL;&#10;    MENSAGEM('Maxys',V_MENSAGEM,2); &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM_PADRAO(16084, '¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;&#10;  END VALIDA_LOCALARMAZ;&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------   &#10;  PROCEDURE CONSULTA_NM_LOCALARMAZENAGEM IS&#10;  &#10;  BEGIN&#10;    &#10;    IF :ITEMCOMPRA.CD_TIPOLOCALARMAZ IS NOT NULL AND&#10;       :ITEMCOMPRA.CD_LOCALARMAZ   IS NOT NULL /*AND&#10;      -- :ITEMCOMPRA.NR_SUBLOCARMAZ1 IS NOT NULL AND&#10;      -- :ITEMCOMPRA.NR_SUBLOCARMAZ2 IS NOT NULL AND&#10;      -- :ITEMCOMPRA.NR_SUBLOCARMAZ3 IS NOT NULL AND&#10;      /* :ITEMCOMPRA.NR_SUBLOCARMAZ4 IS NOT NULL*/ THEN  &#10;      BEGIN&#10;        SELECT DISTINCT LOCALARMAZENAGEM.DS_LOCALARMAZ&#10;          INTO :ITEMCOMPRA.NM_LOCALARMAZENAGEM&#10;          FROM LOCALARMAZENAGEM&#10;         WHERE LOCALARMAZENAGEM.CD_EMPRESA        = :CONTROLE.CD_EMPRESA&#10;           AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#10;           AND LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ   &#10;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1 &#10;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2 &#10;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3 &#10;           AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ4   = :ITEMCOMPRA.NR_SUBLOCARMAZ4&#10;           AND LOCALARMAZENAGEM.ST_OCUPACAO = 'A';&#10;      EXCEPTION &#10;        WHEN OTHERS THEN&#10;          :ITEMCOMPRA.NM_LOCALARMAZENAGEM := NULL;&#10;      END;    &#10;       &#10;    END IF;     &#10;  END CONSULTA_NM_LOCALARMAZENAGEM;  &#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------ &#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_DUPLICADOS">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_DUPLICADOS (O_MENSAGEM    OUT VARCHAR2) IS&#10;&#10;  V_NR_REGISTRO     NUMBER;&#10;  V_CD_CENTROCUSTO  ITEMCOMPRACCUSTO.CD_CENTROCUSTO%TYPE;&#10;  V_CD_NEGOCIO      ITEMCOMPRACCUSTO.CD_NEGOCIO%TYPE; /*CSL:22/12/2010:30317*/&#10;  V_MENSAGEM        VARCHAR2(32000);&#10;  E_GERAL            EXCEPTION;&#10;  V_CD_EMPRCCUSTODEST  EMPRESA.CD_EMPRESA%TYPE;&#10;BEGIN&#10;  &#10;  GO_BLOCK('ITEMCOMPRACCUSTO');&#10;  FIRST_RECORD;&#10;  LOOP&#10;    V_NR_REGISTRO    := :SYSTEM.CURSOR_RECORD;&#10;    V_CD_CENTROCUSTO := :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#10;    V_CD_NEGOCIO     := :ITEMCOMPRACCUSTO.CD_NEGOCIO;&#10;    --GDG:22/07/2011:28715    &#10;    V_CD_EMPRCCUSTODEST := NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :ITEMCOMPRACCUSTO.CD_EMPRESA);&#10;    FIRST_RECORD;&#10;    LOOP&#10;      IF (V_NR_REGISTRO &#60;> :SYSTEM.CURSOR_RECORD) THEN&#10;        /**CSL:22/12/2010:30317&#10;         * Alterado para passar a comparar também o código do negócio, pois poderá ser &#10;         * informado varios centros de custos iguais, porém com códigos de negócio diferentes.&#10;         */&#10;        IF V_CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO AND V_CD_NEGOCIO = :ITEMCOMPRACCUSTO.CD_NEGOCIO&#10;          --GDG:22/07/2011:28715 VALIDAÇÃO DE REGISTRO DUPLICADO&#10;          AND V_CD_EMPRCCUSTODEST = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :ITEMCOMPRACCUSTO.CD_EMPRESA) THEN&#10;          --V_MENSAGEM := 'O Centro de Custo ('||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||') e o Negócio ('||:ITEMCOMPRACCUSTO.CD_NEGOCIO||') do registro atual ('||:SYSTEM.CURSOR_RECORD||') é igual ao do registro ('||V_NR_REGISTRO||'). Por favor verifique e altere.'; &#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6353,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢CD_NEGOCIO='||:ITEMCOMPRACCUSTO.CD_NEGOCIO||'¢NR_REGATUAL='||:SYSTEM.CURSOR_RECORD||'¢NR_REGISTRO='||V_NR_REGISTRO||'¢');--O Centro de Custo ¢CD_CENTROCUSTO¢ e o Negócio ¢CD_NEGOCIO¢ do registro atual ¢NR_REGATUAL¢ é igual ao do registro ¢NR_REGISTRO¢. Por favor verifique e altere. &#10;          RAISE E_GERAL;&#10;        END IF;&#10;      END IF;&#10;     &#10;      EXIT WHEN (:SYSTEM.LAST_RECORD = 'TRUE');&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    GO_RECORD(V_NR_REGISTRO);&#10;    EXIT WHEN (:SYSTEM.LAST_RECORD = 'TRUE');&#10;    NEXT_RECORD;&#10;  END LOOP;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    O_MENSAGEM := V_MENSAGEM; &#10;  WHEN OTHERS THEN&#10;    O_MENSAGEM := SQLERRM;   &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="ENVIA_EMAIL">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE ENVIA_EMAIL(I_CD_EMPRESA    IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                      I_NR_LOTECOMPRA  IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE) IS&#10;                      &#10;  V_VET_DESTINATARIOS  PACK_DADOS_EMAIL.R_DESTINATARIOS;&#10;  V_VET_ANEXOEMAIL      PACK_DADOS_EMAIL.R_ANEXOEMAIL;&#10;  V_REMETENTE          PACK_DADOS_EMAIL.T_REMETENTE;&#10;  V_NM_USUARIO         USUARIO.NM_USUARIO%TYPE;&#10;  V_CORPOEMAIL         VARCHAR2(32000);&#10;  V_MENSAGEM           VARCHAR2(32000);&#10;  V_DS_MENSAGEMEMAIL   VARCHAR2(2000);&#10;  V_NM_CONTAEMAIL      VARCHAR2(600);&#10;  V_NM_EXIBICAOEMAIL   VARCHAR2(600);&#10;  V_NM_USUARIOEMAIL    VARCHAR2(600);&#10;  V_DS_SENHAEMAIL      VARCHAR2(600);&#10;  V_NM_HOSTEMAIL       VARCHAR2(600);&#10;  V_NR_PORTA           VARCHAR2(600);&#10;  V_NM_CONTAEMAILDEST  VARCHAR2(60);&#10;  V_NM_BASE            VARCHAR2(60);&#10;  V_ST_CONEXAO         VARCHAR2(1);&#10;  V_COUNTFORNEC         NUMBER; /*ATR:115974:26/12/2017*/&#10;  V_COUNT               NUMBER; /*ATR:115974:26/12/2017*/&#10;  E_GERAL              EXCEPTION;&#10;  V_NR_SID             NUMBER;&#10;  --V_NR_SEQUENCIA       NUMBER;&#10;  ----------------------------------------------------------------------------------------&#10;  /* MGK:63701:10/10/2013&#10;   * Estrutura utilizada para armazenar os dados das solicitações de compras. &#10;   * Esses dados serão utilizados na composição do e-mail que será enviado ao autorizador.&#10;   */&#10;&#10;  CURSOR CUR_USUARIOS IS &#10;    SELECT DISTINCT USUARIO.NM_CONTAEMAIL&#10;      FROM USUARIO, SOLICITANTE, PARMCOMPRA&#10;     WHERE USUARIO.NM_CONTAEMAIL IS NOT NULL&#10;       AND USUARIO.CD_USUARIO = SOLICITANTE.CD_USUARIO&#10;       AND SOLICITANTE.CD_EMPRESA = PARMCOMPRA.CD_EMPRESA&#10;       AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.ST_APROVSOLIC&#10;       AND (SOLICITANTE.DT_VENCIMENTO IS NULL OR TRUNC(SOLICITANTE.DT_VENCIMENTO) >= TRUNC(SYSDATE))&#10;       AND PARMCOMPRA.CD_EMPRESA = I_CD_EMPRESA;&#10;  &#10;  CURSOR CUR_DADOS_SOLICITACOES IS&#10;    SELECT (ITEMCOMPRA.CD_TIPOCOMPRA||' - '||TIPOCOMPRA.DS_TIPOCOMPRA) DS_TIPOCOMPRA,&#10;           (NVL(ITEMCOMPRA.DS_OBSERVACAO,'Sem observação')) DS_OBSERVACAO,&#10;           (ITEMCOMPRA.CD_ITEM||' - '||ITEM.DS_ITEM) DS_ITEM, &#10;           (NVL(ITEMCOMPRA.QT_PREVISTA,0)) QT_PREVISTA, &#10;           ITEMCOMPRA.NR_LOTECOMPRA,&#10;           ITEMCOMPRA.NR_ITEMCOMPRA,&#10;           ITEMCOMPRA.ST_ITEMCOMPRA,&#10;           ITEMCOMPRA.CD_EMPRESA&#10;      FROM ITEMCOMPRA, &#10;           ITEM, &#10;           TIPOCOMPRA&#10;     WHERE ITEMCOMPRA.CD_ITEM       = ITEM.CD_ITEM&#10;       AND ITEMCOMPRA.CD_TIPOCOMPRA  = TIPOCOMPRA.CD_TIPOCOMPRA&#10;       AND ITEMCOMPRA.CD_EMPRESA    = I_CD_EMPRESA&#10;       AND ITEMCOMPRA.NR_LOTECOMPRA = I_NR_LOTECOMPRA;&#10;     &#10;  V_MSG_EMAIL          VARCHAR2(32000);&#10;  V_MSG_EMAIL_1       VARCHAR2(32000) := 'O número de lote ('||I_NR_LOTECOMPRA||') possui As seguintes solicitações de compras: ';&#10;  V_MSG_EMAIL_2        VARCHAR2(32000);&#10;  V_MSG_EMAIL_3       VARCHAR2(32000) := 'Estas solicitações de compras estão aguardando sua autorização. Verifique os programas indicados para cada solicitação.';&#10;  V_NM_PROGRAMA       VARCHAR2(10);&#10;  V_ST_APROVSOLIC     VARCHAR2(1);&#10;  ----------------------------------------------------------------------------------------&#10;&#10;  BEGIN&#10;    &#10;    -- Buscando configuração de email do compras para a empresa logada.&#10;    BEGIN&#10;      SELECT RETORNA_VALORSTRING(VL_PARAMETRO,1,'¢') NM_CONTAEMAIL,&#10;             RETORNA_VALORSTRING(VL_PARAMETRO,2,'¢') NM_EXIBICAOEMAIL,&#10;             RETORNA_VALORSTRING(VL_PARAMETRO,3,'¢') NM_USUARIOEMAIL,&#10;             RETORNA_VALORSTRING(VL_PARAMETRO,4,'¢') DS_SENHAEMAIL,&#10;             RETORNA_VALORSTRING(VL_PARAMETRO,5,'¢') NM_HOSTEMAIL,&#10;             RETORNA_VALORSTRING(VL_PARAMETRO,6,'¢') NR_PORTA,&#10;             RETORNA_VALORSTRING(VL_PARAMETRO,7,'¢') ST_CONEXAO&#10;        INTO V_NM_CONTAEMAIL,&#10;             V_NM_EXIBICAOEMAIL,&#10;             V_NM_USUARIOEMAIL,&#10;             V_DS_SENHAEMAIL,&#10;             V_NM_HOSTEMAIL,&#10;             V_NR_PORTA,&#10;             V_ST_CONEXAO&#10;        FROM PARMGENERICO&#10;       WHERE RETORNA_VALORSTRING(NM_PARAMETRO,1,'¢') = 'EMAILCOMPRAS'&#10;         AND RETORNA_VALORSTRING(NM_PARAMETRO,2,'¢') = :GLOBAL.CD_EMPRESA&#10;         AND PARMGENERICO.CD_MODULO                  = 'COM'&#10;         AND PARMGENERICO.CD_PROGRAMA                = 9;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        V_NM_CONTAEMAIL    := NULL;&#10;        V_NM_EXIBICAOEMAIL := NULL;&#10;        V_NM_USUARIOEMAIL  := NULL;&#10;        V_DS_SENHAEMAIL    := NULL;&#10;        V_NM_HOSTEMAIL     := NULL;&#10;        V_NR_PORTA         := NULL;&#10;        V_ST_CONEXAO       := NULL;&#10;        --Não foram encontrados os parâmetros de envio de email para a  empresa ¢CD_EMPRESA¢. Verifique o Programa COM009 Página &#34;Envio Email&#34;.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8356,'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN &#10;        V_NM_CONTAEMAIL    := NULL;&#10;        V_NM_EXIBICAOEMAIL := NULL;&#10;        V_NM_USUARIOEMAIL  := NULL;&#10;        V_DS_SENHAEMAIL    := NULL;&#10;        V_NM_HOSTEMAIL     := NULL;&#10;        V_NR_PORTA         := NULL;&#10;        V_ST_CONEXAO       := NULL;&#10;        --Ocorreu um erro ao consultar os parâmetros de envio de email para a  empresa ¢CD_EMPRESA¢. Verifique o Programa COM009 Página &#34;Envio Email&#34;. Erro ¢SQLERRM¢.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8357,'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢SQLERRM='||SQLERRM||'¢');&#10;    END; &#10;    IF V_NM_USUARIOEMAIL IS NOT NULL THEN&#10;      BEGIN&#10;        SELECT PARMGENERICO.NM_PARAMETRO DS_MENSAGEMEMAIL&#10;          INTO V_DS_MENSAGEMEMAIL&#10;          FROM PARMGENERICO&#10;         WHERE RETORNA_VALORSTRING(VL_PARAMETRO,1,'¢') = 'EMAILCOMPRAS'&#10;           AND RETORNA_VALORSTRING(VL_PARAMETRO,2,'¢') = :GLOBAL.CD_EMPRESA&#10;           AND PARMGENERICO.CD_PROGRAMA                = 9&#10;           AND PARMGENERICO.CD_MODULO                  = 'COM';&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          V_DS_MENSAGEMEMAIL := NULL;&#10;        WHEN OTHERS THEN &#10;          V_DS_MENSAGEMEMAIL := NULL;&#10;      END; &#10;      &#10;      /**MPB:09/04/2012:43880&#10;       * Realizado alteração de tabela para compatibilizar as operações com a estrutura do Oracle RAC.&#10;       */&#10;    &#10;      -- busca do SID do logado..&#10;      BEGIN&#10;        SELECT DISTINCT MAX$MYSTAT.SID&#10;          INTO V_NR_SID&#10;          FROM MAX$MYSTAT;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          NULL;&#10;      END;&#10;      &#10;      -- Qual base esta logado&#10;      BEGIN&#10;        SELECT NM_HOST&#10;          INTO V_NM_BASE&#10;          FROM HOST;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          V_NM_BASE := 'MAXYS_PROD';          &#10;      END;&#10;      V_COUNTFORNEC := 0;&#10;      IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN &#10;        BEGIN&#10;          SELECT COUNT(*)&#10;            INTO V_COUNTFORNEC&#10;            FROM USUARIO&#10;           WHERE USUARIO.NM_CONTAEMAIL IS NOT NULL&#10;             AND USUARIO.CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            V_COUNTFORNEC := 0;&#10;        END;&#10;      ELSE &#10;        BEGIN&#10;          SELECT COUNT(*)&#10;            INTO V_COUNTFORNEC&#10;            FROM USUARIO, SOLICITANTE, PARMCOMPRA&#10;           WHERE USUARIO.NM_CONTAEMAIL IS NOT NULL&#10;             AND USUARIO.CD_USUARIO = SOLICITANTE.CD_USUARIO&#10;             AND SOLICITANTE.CD_EMPRESA = PARMCOMPRA.CD_EMPRESA&#10;             AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.ST_APROVSOLIC&#10;             AND (SOLICITANTE.DT_VENCIMENTO IS NULL OR TRUNC(SOLICITANTE.DT_VENCIMENTO) >= TRUNC(SYSDATE))&#10;             AND PARMCOMPRA.CD_EMPRESA = I_CD_EMPRESA;&#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            V_COUNTFORNEC := 0;&#10;        END;&#10;      END IF;&#10;    /*  --buscando dados do email do fornecedor.&#10;      BEGIN&#10;        SELECT USUARIO.NM_CONTAEMAIL, &#10;               USUARIO.NM_USUARIO &#10;          INTO V_NM_CONTAEMAILDEST,&#10;               V_NM_USUARIO&#10;          FROM USUARIO&#10;         WHERE CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          --Autorizador ¢CD_AUTORIZADOR¢ não possui email configurado. Verifique ANV001.&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4751,'¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||' - '||:CONTROLE.NM_USUAUTORIZ||'¢');&#10;          RAISE E_GERAL;&#10;        WHEN OTHERS THEN&#10;          V_MENSAGEM := 'Impossível buscar email de autorizador '||SQLERRM;&#10;          RAISE E_GERAL;&#10;      END;*/&#10;      IF V_COUNTFORNEC > 0 THEN&#10;        /*RETORNA_SEQUENCIA('SQEMAIL',:GLOBAL.CD_EMPRESA,V_NR_SEQUENCIA,V_MENSAGEM);&#10;        IF V_MENSAGEM IS NOT NULL THEN&#10;          RAISE E_GERAL;      &#10;        END IF;*/&#10;        &#10;        --Buscar o parâmetro &#34;Aprovar solicitação de Compras&#34;, da página &#34;Validações&#34; do COM009.&#10;        BEGIN  &#10;          SELECT NVL(PARMCOMPRA.ST_APROVSOLIC,'N')&#10;            INTO V_ST_APROVSOLIC&#10;            FROM PARMCOMPRA&#10;           WHERE PARMCOMPRA.CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;        EXCEPTION &#10;          WHEN OTHERS THEN&#10;            V_ST_APROVSOLIC := 'N';&#10;        END;&#10;        &#10;        --MGK:63701:10/10/2013 - Incluído o código abaixo, cuja finalidade é compor a mensagem que será enviada ao autorizador da solicitação de compra.&#10;        FOR I IN CUR_DADOS_SOLICITACOES LOOP&#10;          IF ((NVL(V_ST_APROVSOLIC,'N') = 'S') OR (I.ST_ITEMCOMPRA = 0)) THEN&#10;            V_NM_PROGRAMA := 'COM002';&#10;          ELSIF ((NVL(V_ST_APROVSOLIC,'N') = 'N') OR (I.ST_ITEMCOMPRA IN (1,14))) THEN&#10;            V_NM_PROGRAMA := 'COM006';&#10;          END IF;&#10;          &#10;          IF (V_MSG_EMAIL_2 IS NULL) THEN&#10;            V_MSG_EMAIL_2 := CHR(10)||&#10;                             '>> Solicitação ('||I.NR_ITEMCOMPRA||&#10;                              ') da empresa ('||I.CD_EMPRESA||&#10;                              '), item ('||I.DS_ITEM||&#10;                              '), quantidade ('||I.QT_PREVISTA||&#10;                              '), tipo de compra ('||I.DS_TIPOCOMPRA||&#10;                              ') observação ('||I.DS_OBSERVACAO||&#10;                              '). (Verificar o programa '||V_NM_PROGRAMA||')';&#10;          ELSE&#10;            V_MSG_EMAIL_2 := V_MSG_EMAIL_2||'; '||&#10;                             CHR(10)||&#10;                             CHR(10)||&#10;                             '>> Solicitação ('||I.NR_ITEMCOMPRA||&#10;                             ') da empresa ('||I.CD_EMPRESA||&#10;                             '), item ('||I.DS_ITEM||&#10;                             '), quantidade ('||I.QT_PREVISTA  ||&#10;                             '), tipo de compra ('||I.DS_TIPOCOMPRA||&#10;                             ') observação ('||I.DS_OBSERVACAO||&#10;                             '). (Verificar o programa '||V_NM_PROGRAMA||')';&#10;          END IF;&#10;        END LOOP;&#10;        &#10;        --MGK:63701:10/10/2013 - Junção das variáveis&#10;        V_MSG_EMAIL := V_MSG_EMAIL_1||&#10;                       CHR(10)||&#10;                       V_MSG_EMAIL_2||'.'||&#10;                       CHR(10)||&#10;                       CHR(10)||&#10;                       V_MSG_EMAIL_3;&#10;        &#10;        --Mensagem do corpo do email.&#10;        V_CORPOEMAIL := CHR(10)||&#10;                        'Atenção:'||&#10;                        CHR(10)||&#10;                        V_MSG_EMAIL||&#10;                        CHR(10)||&#10;                        CHR(10)||&#10;                        'Solicitado por: '||:GLOBAL.CD_USUARIO||' - '||:GLOBAL.NM_USUARIO||&#10;                        CHR(10)||&#10;                        CHR(10)||&#10;                        'Obs.: '||&#10;                        CHR(10)||&#10;                        V_DS_MENSAGEMEMAIL;&#10;        &#10;        --MGK:63701:10/10/2013 - preenchimento das variáveis que serão passadas para o procedimento INCLUI_FILAEMAIL.&#10;        IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#10;           --buscando dados do email do fornecedor.&#10;          BEGIN&#10;            SELECT USUARIO.NM_CONTAEMAIL, &#10;                   USUARIO.NM_USUARIO &#10;              INTO V_NM_CONTAEMAILDEST,&#10;                   V_NM_USUARIO&#10;              FROM USUARIO&#10;             WHERE CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              --Autorizador ¢CD_AUTORIZADOR¢ não possui email configurado. Verifique ANV001.&#10;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4751,'¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||' - '||:CONTROLE.NM_USUAUTORIZ||'¢');&#10;              RAISE E_GERAL;&#10;            WHEN OTHERS THEN&#10;              V_MENSAGEM := 'Impossível buscar email de autorizador '||SQLERRM;&#10;              RAISE E_GERAL;&#10;          END;          &#10;          V_REMETENTE.DS_ASSUNTO                  := 'Solicitações aguardando sua liberação.';&#10;          V_REMETENTE.NM_EXIBICAOEMAIL            := V_NM_EXIBICAOEMAIL;&#10;          V_REMETENTE.NM_USUARIOEMAIL             := V_NM_USUARIOEMAIL;&#10;          V_REMETENTE.DS_CONTAEMAIL               := V_NM_CONTAEMAIL;&#10;          V_REMETENTE.DS_SENHAEMAIL               := V_DS_SENHAEMAIL;&#10;          V_REMETENTE.NM_HOSTEMAIL                := V_NM_HOSTEMAIL;&#10;          V_REMETENTE.NR_PORTAEMAIL               := V_NR_PORTA;&#10;          V_REMETENTE.ST_CONEXAO                  := V_ST_CONEXAO;&#10;          V_REMETENTE.DS_COMPLEMENSAGEM            := V_CORPOEMAIL;&#10;          V_REMETENTE.DS_MENSAGEMEMAIL            := 'Solicitações aguardando sua liberação.'||CHR(10);&#10;          V_VET_DESTINATARIOS(1).DS_EMAIL         := V_NM_CONTAEMAILDEST;&#10;          V_VET_DESTINATARIOS(1).NM_EXIBICAOEMAIL := NULL;&#10;          V_VET_DESTINATARIOS(1).NR_DESTINATARIO  := 1;        &#10;        ELSE&#10;          V_COUNT := 0;&#10;          FOR I IN CUR_USUARIOS LOOP&#10;            V_COUNT := V_COUNT + 1;&#10;            V_REMETENTE.DS_ASSUNTO                  := 'Solicitações aguardando sua liberação.';&#10;            V_REMETENTE.NM_EXIBICAOEMAIL            := V_NM_EXIBICAOEMAIL;&#10;            V_REMETENTE.NM_USUARIOEMAIL             := V_NM_USUARIOEMAIL;&#10;            V_REMETENTE.DS_CONTAEMAIL               := V_NM_CONTAEMAIL;&#10;            V_REMETENTE.DS_SENHAEMAIL               := V_DS_SENHAEMAIL;&#10;            V_REMETENTE.NM_HOSTEMAIL                := V_NM_HOSTEMAIL;&#10;            V_REMETENTE.NR_PORTAEMAIL               := V_NR_PORTA;&#10;            V_REMETENTE.ST_CONEXAO                  := V_ST_CONEXAO;&#10;            V_REMETENTE.DS_COMPLEMENSAGEM            := V_CORPOEMAIL;&#10;            V_REMETENTE.DS_MENSAGEMEMAIL            := 'Solicitações aguardando sua liberação.'||CHR(10);&#10;            V_VET_DESTINATARIOS(V_COUNT).DS_EMAIL         := I.NM_CONTAEMAIL;&#10;            V_VET_DESTINATARIOS(V_COUNT).NM_EXIBICAOEMAIL := NULL;&#10;            V_VET_DESTINATARIOS(V_COUNT).NR_DESTINATARIO  := V_COUNT;            &#10;          END LOOP;&#10;        END IF;&#10;          --MGK:63701:10/10/2013 - gravação na tabela EMAIL e DESTINATARIO_EMAIL.&#10;          PACK_DADOS_EMAIL.INCLUI_FILAEMAIL(I_CD_EMPRESA         => :GLOBAL.CD_EMPRESA,&#10;                                            I_CD_USUARIO         => :GLOBAL.CD_USUARIO,&#10;                                            I_SID               => V_NR_SID,&#10;                                            I_REMETENTE         => V_REMETENTE,&#10;                                            I_VET_DESTINATARIOS => V_VET_DESTINATARIOS,&#10;                                            I_VET_ANEXOEMAIL     => V_VET_ANEXOEMAIL,&#10;                                            I_TP_PRIORIDADE     => 4,&#10;                                            O_MENSAGEM           => V_MENSAGEM);&#10;      END IF;&#10;    END IF;&#10;    /**FLA:06/12/2019:142176&#10;     * Adicionado para impedir o travamento da sessão da tela&#10;     */&#10;    FAZ_COMMIT;&#10;     &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;     /**FLA:06/12/2019:142176&#10;      * Adicionado para impedir o travamento da sessão da tela&#10;      */&#10;      FAZ_ROLLBACK;&#10;      MENSAGEM('Maxys',V_MENSAGEM,2);&#10;  END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_AUDITORIA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="/**FZA:29085:09/11/2010&#10;***Criado pacote para gravacao de logs de todos os campos alterados nos blocos de banco do programa.&#10;***A chamada dos procedimentos dessa PACK estao nos gatilhos PRE-INSERT  e PRE-UPDATE de cada bloco, &#10;***assim ele grava log de todos os registros alterados dentro do bloco, pois todos regitros alterados passam&#10;***por esses gatilhos.&#10;***Na procedure AUDITA_GRAVACAO, foi ajustado para nao inserir LOG dos blocos que sao inseridos por essa PACK.&#10;***A gravacao dos Log referente as exclusoes estao sendo gravados na Procedure AUDITA_EXCLUSAO normalmente&#10;**/&#10;PACKAGE BODY PACK_AUDITORIA IS&#10;  --Procedimento que insere os dados atualizados do bloco.&#10;  PROCEDURE AUDITA_ATUALIZACAO (V_BLOCO IN VARCHAR2) IS&#10;    DS_TABELA       VARCHAR2(32000);&#10;    DS_PRIM_ITEM    VARCHAR2(32000);&#10;    DS_ULTI_ITEM    VARCHAR2(32000);&#10;    I_UPDATE        VARCHAR2(32000);&#10;    I_VALORES_UPD   VARCHAR2(32000);&#10;    I_REGISTRO      VARCHAR2(32000);&#10;    I_DS_EVENTO     VARCHAR2(32000);&#10;    I_DS_VALOR      VARCHAR2(32000);&#10;    I_DS_DML        VARCHAR2(32000);&#10;    I_CAMPOS_UPD    VARCHAR2(32000);&#10;    I_WHERE         VARCHAR2(32000);&#10;    I_CONTADOR_UPD  NUMBER := 0;&#10;  BEGIN&#10;    DS_TABELA         := GET_BLOCK_PROPERTY(V_BLOCO,DML_DATA_TARGET_NAME);&#10;    DS_PRIM_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,FIRST_ITEM);&#10;    DS_ULTI_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,LAST_ITEM);&#10;    LOOP                &#10;      IF (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'TEXT ITEM') OR&#10;         (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'LIST') OR&#10;         (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'RADIO GROUP') OR&#10;         (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'CHECK BOX') THEN&#10;        --Verifica se o campo é uma coluna da tabela&#10;        IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,COLUMN_NAME) IS NOT NULL THEN          &#10;          --Busca o valor do campo e concatena a mensagem que ira aparecer no anv7&#10;          I_DS_VALOR :=  NAME_IN(V_BLOCO||'.'||DS_PRIM_ITEM);&#10;          I_REGISTRO  := I_REGISTRO||' '||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,PROMPT_TEXT)||' '||I_DS_VALOR;&#10;          I_DS_EVENTO := ('Atualizou o registro ' || I_REGISTRO || ' na tabela ' || DS_TABELA);&#10;        END IF;&#10;        --Monta o WHERE da SQL referente a alteracao efetuada.&#10;        IF (I_DS_VALOR IS NOT NULL) THEN&#10;          IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,PRIMARY_KEY) &#60;> 'TRUE' THEN&#10;            IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;              IF (V_BLOCO||'.'||DS_PRIM_ITEM = V_BLOCO||'.HR_RECORD') THEN&#10;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||' = '||CHR(39)||TO_CHAR(RETORNA_DATAHORA,'HH24:MI')||CHR(39)||', ';&#10;              ELSE&#10;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||' = '||CHR(39)||:SYSTEM.CURSOR_VALUE||CHR(39)||', ';&#10;              END IF;&#10;            ELSE&#10;              IF (V_BLOCO||'.'||DS_PRIM_ITEM = V_BLOCO||'.DT_RECORD') THEN&#10;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||' = '||RETORNA_DATAHORA||', ';&#10;              ELSE&#10;                I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||' = '||:SYSTEM.CURSOR_VALUE||', ';&#10;              END IF;&#10;            END IF;&#10;          END IF;&#10;        ELSIF (I_DS_VALOR IS NULL) THEN&#10;          IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,PRIMARY_KEY) &#60;> 'TRUE' THEN&#10;            I_VALORES_UPD := I_VALORES_UPD||DS_PRIM_ITEM||' = '||CHR(39)||' '||CHR(39)||', ';&#10;          END IF;&#10;        END IF;&#10;        --Monta os Campos atualizados da SQL&#10;        IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,PRIMARY_KEY) = 'TRUE' THEN&#10;          IF I_CONTADOR_UPD = 0 THEN&#10;            IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;              I_CAMPOS_UPD := I_CAMPOS_UPD||DS_PRIM_ITEM||' = '||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;            ELSE&#10;              I_CAMPOS_UPD := I_CAMPOS_UPD||DS_PRIM_ITEM||' = '||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE);&#10;            END IF;&#10;          ELSE&#10;            IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;              I_CAMPOS_UPD := I_CAMPOS_UPD||' AND '||DS_PRIM_ITEM||' = '||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;            ELSE&#10;              I_CAMPOS_UPD := I_CAMPOS_UPD||' AND '||DS_PRIM_ITEM||' = '||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE);&#10;            END IF;&#10;          END IF;&#10;          I_CONTADOR_UPD := I_CONTADOR_UPD + 1;&#10;          I_WHERE        := ' WHERE '||I_CAMPOS_UPD;&#10;        END IF;        &#10;      END IF;      &#10;      EXIT WHEN V_BLOCO||'.'||DS_PRIM_ITEM = V_BLOCO||'.'||DS_ULTI_ITEM;&#10;      DS_PRIM_ITEM := GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,NEXTITEM);&#10;    END LOOP;        &#10;    --Contatena os valores que foram alterados&#10;    IF (I_VALORES_UPD IS NOT NULL) THEN&#10;      I_VALORES_UPD := SUBSTR(I_VALORES_UPD,1,LENGTH(I_VALORES_UPD)-2);&#10;      I_UPDATE      := 'UPDATE '||DS_TABELA||' SET '||I_VALORES_UPD||' '||I_WHERE||';';&#10;      I_DS_DML      := I_UPDATE;&#10;    END IF;  &#10;    &#10;    --Chama o procedimento para inserir na tabela LOGUSUARIO&#10;    PACK_AUDITORIA.INSERE_LOGUSUARIO(I_DS_EVENTO,I_DS_DML,'A');  &#10;    &#10;  END;&#10;  ------------------------------------------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------------------------------------------  &#10;  ------------------------------------------------------------------------------------------------------------------------------------------------&#10;  &#10;  PROCEDURE AUDITA_INSERCAO(V_BLOCO IN VARCHAR2) IS&#10;    --Procedimento que grava os dados inseridos no Bloco&#10;    DS_TABELA       VARCHAR2(32000);&#10;    DS_PRIM_ITEM    VARCHAR2(32000);&#10;    DS_ULTI_ITEM    VARCHAR2(32000);&#10;    I_INSERT        VARCHAR2(32000);&#10;    I_VALORES_INS   VARCHAR2(32000);&#10;    I_REGISTRO      VARCHAR2(32000);&#10;    I_DS_EVENTO     VARCHAR2(32000);&#10;    I_DS_DML        VARCHAR2(32000);&#10;    I_CAMPOS_INS    VARCHAR2(32000);&#10;    I_CONTADOR_INS  NUMBER:=0;  &#10;  BEGIN&#10;    DS_TABELA         := GET_BLOCK_PROPERTY(V_BLOCO,DML_DATA_TARGET_NAME);&#10;    DS_PRIM_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,FIRST_ITEM);&#10;    DS_ULTI_ITEM      := GET_BLOCK_PROPERTY(:SYSTEM.CURRENT_BLOCK,LAST_ITEM);&#10;    LOOP&#10;      --Verifica se o campo é uma coluna da tabela&#10;      IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,COLUMN_NAME) IS NOT NULL THEN  &#10;        --Busca o valor do campo e concatena a mensagem que ira aparecer no anv7              &#10;        I_REGISTRO  := I_REGISTRO||' '||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,PROMPT_TEXT)||' '||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE);&#10;        I_DS_EVENTO := ('Inseriu na tabela ' || DS_TABELA || ' o registro ' || I_REGISTRO);&#10;      END IF;&#10;      --Verifica se foi inserido valor nessa coluna&#10;      IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE) IS NOT NULL THEN&#10;        IF (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'TEXT ITEM') OR&#10;           (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'LIST') OR  &#10;           (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'RADIO GROUP') OR &#10;           (GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,ITEM_TYPE) = 'CHECK BOX') THEN&#10;          IF I_CONTADOR_INS = 0 THEN&#10;            I_CAMPOS_INS  := ' ( '||DS_PRIM_ITEM;&#10;            IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;              I_VALORES_INS := ' ( '||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;            ELSE&#10;              I_VALORES_INS := ' ( '||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE);&#10;            END IF;&#10;          ELSE&#10;            I_CAMPOS_INS := I_CAMPOS_INS||', '||DS_PRIM_ITEM;&#10;            IF GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATATYPE) = 'CHAR' THEN&#10;              I_VALORES_INS := I_VALORES_INS||', '||CHR(39)||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE)||CHR(39);&#10;            ELSE&#10;              I_VALORES_INS := I_VALORES_INS||', '||GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,DATABASE_VALUE);&#10;            END IF;&#10;          END IF;&#10;          I_INSERT := 'INSERT INTO '||DS_TABELA;&#10;        END IF;&#10;        I_CONTADOR_INS := I_CONTADOR_INS + 1;&#10;      END IF;&#10;      EXIT WHEN V_BLOCO||'.'||DS_PRIM_ITEM = V_BLOCO||'.'||DS_ULTI_ITEM;&#10;      DS_PRIM_ITEM := GET_ITEM_PROPERTY(V_BLOCO||'.'||DS_PRIM_ITEM,NEXTITEM);      &#10;    END LOOP;&#10;    --Contatena os valores que foram inseridos&#10;    IF (I_CAMPOS_INS IS NOT NULL) AND (I_VALORES_INS IS NOT NULL) THEN&#10;      I_CAMPOS_INS  := I_CAMPOS_INS||')';&#10;      I_VALORES_INS := I_VALORES_INS||')';&#10;      I_INSERT      := I_INSERT||I_CAMPOS_INS||' VALUES '||I_VALORES_INS||';';&#10;      I_DS_DML       := I_INSERT;&#10;    END IF;&#10;    &#10;    --Chama o procedimento para inserir na tabela LOGUSUARIO&#10;    PACK_AUDITORIA.INSERE_LOGUSUARIO(I_DS_EVENTO,I_DS_DML,'I');  &#10;    &#10;  END;&#10;  ------------------------------------------------------------------------------------------------------------------------------------------------&#10;  ------------------------------------------------------------------------------------------------------------------------------------------------  &#10;  ------------------------------------------------------------------------------------------------------------------------------------------------&#10;  --Procedimento que insere as alteracoes feitas na tabela LOGUSUARIO&#10;  PROCEDURE INSERE_LOGUSUARIO(I_DS_EVENTO   IN LOGUSUARIO.DS_EVENTO%TYPE,&#10;                              I_DS_DML      IN LOGUSUARIO.DS_DML%TYPE   ,&#10;                              I_TP_EVENTO   IN LOGUSUARIO.TP_EVENTO%TYPE) IS&#10;    I_TAM_EVENTO NUMBER;&#10;  BEGIN&#10;    &#10;    --Verifica qual das duas descricoes tem o tamanho maior para quebrar em duas linhas caso seja maior que 2000 caracteres&#10;    IF LENGTH(I_DS_DML) >= LENGTH(I_DS_EVENTO) THEN&#10;      I_TAM_EVENTO := LENGTH(I_DS_DML);&#10;    ELSE&#10;      I_TAM_EVENTO := LENGTH(I_DS_EVENTO);&#10;    END IF;&#10;    IF I_DS_EVENTO IS NOT NULL THEN&#10;       FOR I IN 1.. NVL((TRUNC(I_TAM_EVENTO / 2000) + 1),1) LOOP   &#10;        BEGIN&#10;          --Insere os dados no Log.&#10;          INSERT INTO LOGUSUARIO (CD_EMPRESA,&#10;                                  CD_USUARIO,&#10;                                  CD_MODULO,&#10;                                  CD_PROGRAMA,&#10;                                  DT_EVENTO,&#10;                                  SQ_EVENTO,&#10;                                  HR_EVENTO,&#10;                                  DS_EVENTO,&#10;                                  TP_EVENTO,&#10;                                  DS_DML)&#10;                          VALUES (:GLOBAL.CD_EMPRESA,&#10;                                  :GLOBAL.CD_USUARIO,&#10;                                  :GLOBAL.CD_MODULO,&#10;                                  :GLOBAL.CD_PROGRAMA,&#10;                                  RETORNA_DATAHORA,&#10;                                  SEQ_AUDITORIA.NEXTVAL,&#10;                                  TO_CHAR(RETORNA_DATAHORA,'HH24:MI'),&#10;                                  SUBSTR(I_DS_EVENTO,((I - 1) * 2000 + 1),2000),&#10;                                  I_TP_EVENTO,&#10;                                  SUBSTR(I_DS_DML   ,((I - 1) * 2000 + 1),2000));&#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            DEBUG_PROGRAMA('AUDITA_GRAVACAO - Erro durante tentativa de inserção na tabela LOGUSUARIO: '||SQLERRM);&#10;        END;&#10;      END LOOP;&#10;    END IF;&#10;  END;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_AUDITORIA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_AUDITORIA IS&#10;&#10;  PROCEDURE AUDITA_ATUALIZACAO(V_BLOCO IN VARCHAR2);&#10;  ---------------------------------------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------------------------------------&#10;  PROCEDURE AUDITA_INSERCAO(V_BLOCO IN VARCHAR2);&#10;  ---------------------------------------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------------------------------------&#10;  PROCEDURE INSERE_LOGUSUARIO(I_DS_EVENTO   IN LOGUSUARIO.DS_EVENTO%TYPE,&#10;                              I_DS_DML      IN LOGUSUARIO.DS_DML%TYPE   ,&#10;                              I_TP_EVENTO   IN LOGUSUARIO.TP_EVENTO%TYPE);&#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_GRAVALIBERACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="/** WLV:15/02/2012:40906&#10;  * Criado para fazer a verificação se foi alterado a solicitação de compra.&#10;  * pois antes mesmo quando não se alterava nada na solicitação ele estourava o alerta de confirmação&#10;  */ &#10;PACKAGE PACK_GRAVALIBERACAO IS &#10;   TYPE R_DADOSGRAVACAO IS RECORD(CD_EMPRESA              ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                                   CD_AUTORIZADOR          ITEMCOMPRA.CD_AUTORIZADOR%TYPE,&#10;                                   CD_TIPOCOMPRA           ITEMCOMPRA.CD_TIPOCOMPRA%TYPE,&#10;                                   DT_DESEJADA              ITEMCOMPRA.DT_DESEJADA%TYPE,&#10;                                   NR_LOTECOMPRA             ITEMCOMPRA.NR_LOTECOMPRA%TYPE,&#10;                                   DT_INICIO                ITEMCOMPRA.DT_INICIO%TYPE,&#10;                                   NR_CONTRATO             ITEMCOMPRA.NR_CONTRATO%TYPE,&#10;                                   CD_DEPARTAMENTO         ITEMCOMPRA.CD_DEPARTAMENTO%TYPE);&#10;                                                        &#10;   TYPE T_DADOSGRAVACAO IS TABLE OF R_DADOSGRAVACAO INDEX BY BINARY_INTEGER;&#10;   VET_DADOSGRAVACAO    T_DADOSGRAVACAO;&#10;   &#10;   PROCEDURE GRAVA_VETOR(I_CD_EMPRESA            IN ITEMCOMPRA.CD_EMPRESA%TYPE,     &#10;                         I_CD_AUTORIZADOR       IN ITEMCOMPRA.CD_AUTORIZADOR%TYPE, &#10;                         I_CD_TIPOCOMPRA        IN ITEMCOMPRA.CD_TIPOCOMPRA%TYPE,  &#10;                         I_DT_DESEJADA          IN ITEMCOMPRA.DT_DESEJADA%TYPE,    &#10;                         I_NR_LOTECOMPRA        IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,  &#10;                         I_DT_INICIO            IN ITEMCOMPRA.DT_INICIO%TYPE,      &#10;                         I_NR_CONTRATO          IN ITEMCOMPRA.NR_CONTRATO%TYPE,&#10;                         I_CD_DEPARTAMENTO      IN ITEMCOMPRA.CD_DEPARTAMENTO%TYPE,&#10;                         O_MENSAGEM             OUT VARCHAR2);   &#10;    &#10;    &#10;   TYPE R2_DADOSGRAVACAO IS RECORD(CD_ITEM                   ITEMCOMPRA.CD_ITEM%TYPE,&#10;                                   CD_MOVIMENTACAO          ITEMCOMPRA.CD_MOVIMENTACAO%TYPE,&#10;                                   QT_PREVISTA              ITEMCOMPRA.QT_PREVISTA%TYPE,&#10;                                   DS_OBSERVACAOEXT          ITEMCOMPRA.DS_OBSERVACAOEXT%TYPE,&#10;                                   DS_OBSERVACAO            ITEMCOMPRA.DS_OBSERVACAO%TYPE);&#10;                                   &#10;   TYPE T2_DADOSGRAVACAO IS TABLE OF R2_DADOSGRAVACAO INDEX BY BINARY_INTEGER;&#10;   VET2_DADOSGRAVACAO    T2_DADOSGRAVACAO;                               &#10;    &#10;    &#10;   PROCEDURE GRAVA_VETOR_ITENS(O_MENSAGEM OUT VARCHAR2); &#10;    &#10;    &#10;   PROCEDURE VERIFICA_DADOS_MODIFICADOS(RETORNO OUT BOOLEAN, O_MENSAGEM OUT VARCHAR2);&#10;   &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_GRAVALIBERACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="/** WLV:15/02/2012:40906&#10;  * Criado para fazer a verificação se foi alterado a solicitação de compra.&#10;  * pois antes mesmo quando não se alterava nada na solicitação ele estourava o alerta de confirmação&#10;  */ &#10;PACKAGE BODY PACK_GRAVALIBERACAO IS&#10;  &#10;  &#10;  PROCEDURE GRAVA_VETOR(I_CD_EMPRESA            IN ITEMCOMPRA.CD_EMPRESA%TYPE,     &#10;                        I_CD_AUTORIZADOR        IN ITEMCOMPRA.CD_AUTORIZADOR%TYPE, &#10;                        I_CD_TIPOCOMPRA         IN ITEMCOMPRA.CD_TIPOCOMPRA%TYPE,  &#10;                        I_DT_DESEJADA            IN ITEMCOMPRA.DT_DESEJADA%TYPE,    &#10;                        I_NR_LOTECOMPRA          IN ITEMCOMPRA.NR_LOTECOMPRA%TYPE,  &#10;                        I_DT_INICIO              IN ITEMCOMPRA.DT_INICIO%TYPE,      &#10;                        I_NR_CONTRATO           IN ITEMCOMPRA.NR_CONTRATO%TYPE,&#10;                        I_CD_DEPARTAMENTO       IN ITEMCOMPRA.CD_DEPARTAMENTO%TYPE,&#10;                        O_MENSAGEM             OUT VARCHAR2) IS&#10;  BEGIN&#10;      &#10;    VET_DADOSGRAVACAO.DELETE;&#10;    VET_DADOSGRAVACAO(1).CD_EMPRESA       := I_CD_EMPRESA; &#10;    VET_DADOSGRAVACAO(1).CD_AUTORIZADOR   := I_CD_AUTORIZADOR;&#10;    VET_DADOSGRAVACAO(1).CD_TIPOCOMPRA    := I_CD_TIPOCOMPRA;&#10;    VET_DADOSGRAVACAO(1).DT_DESEJADA      := I_DT_DESEJADA;&#10;    VET_DADOSGRAVACAO(1).NR_LOTECOMPRA    := I_NR_LOTECOMPRA;&#10;    VET_DADOSGRAVACAO(1).DT_INICIO        := I_DT_INICIO;&#10;    VET_DADOSGRAVACAO(1).NR_CONTRATO      := I_NR_CONTRATO;&#10;    VET_DADOSGRAVACAO(1).CD_DEPARTAMENTO  := I_CD_DEPARTAMENTO;&#10;  &#10;  EXCEPTION    &#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM := 'Não foi possível gravar vetor. '||SQLERRM;  &#10;  END;&#10;      &#10;  PROCEDURE GRAVA_VETOR_ITENS(O_MENSAGEM OUT VARCHAR2) IS&#10;   V_COUNT                     NUMBER;  &#10;   &#10;  BEGIN&#10;    &#10;    VET2_DADOSGRAVACAO.DELETE;&#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    &#10;    LOOP&#10;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;        V_COUNT := NVL(VET2_DADOSGRAVACAO.LAST,0) + 1;&#10;        VET2_DADOSGRAVACAO(V_COUNT).CD_ITEM          := :ITEMCOMPRA.CD_ITEM;&#10;        VET2_DADOSGRAVACAO(V_COUNT).CD_MOVIMENTACAO  := :ITEMCOMPRA.CD_MOVIMENTACAO;&#10;        VET2_DADOSGRAVACAO(V_COUNT).QT_PREVISTA      := :ITEMCOMPRA.QT_PREVISTA;  &#10;        VET2_DADOSGRAVACAO(V_COUNT).DS_OBSERVACAOEXT := :ITEMCOMPRA.DS_OBSERVACAOEXT;  &#10;        VET2_DADOSGRAVACAO(V_COUNT).DS_OBSERVACAO     := :ITEMCOMPRA.DS_OBSERVACAO;&#10;      END IF;&#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;  EXCEPTION    &#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM := 'Não foi possível gravar vetor. '||SQLERRM;&#10;  END;&#10;      &#10;      &#10;  PROCEDURE VERIFICA_DADOS_MODIFICADOS(RETORNO OUT BOOLEAN, O_MENSAGEM OUT VARCHAR2) IS&#10;    V_FLAG_BLOCO1 BOOLEAN;&#10;    V_FLAG_BLOCO2 BOOLEAN;&#10;    &#10;    V_COUNT  NUMBER;&#10;  BEGIN&#10;    V_FLAG_BLOCO1 := TRUE;&#10;    RETORNO        := TRUE;&#10;    GO_BLOCK('CONTROLE');&#10;    FIRST_RECORD;&#10;    &#10;    IF NVL(VET_DADOSGRAVACAO(1).CD_EMPRESA,0)                                   = NVL(:CONTROLE.CD_EMPRESA,0)         AND&#10;       NVL(VET_DADOSGRAVACAO(1).CD_AUTORIZADOR,'-1')                             = NVL(:CONTROLE.CD_AUTORIZADOR,'-1')  AND&#10;       NVL(VET_DADOSGRAVACAO(1).CD_TIPOCOMPRA,'-1')                             = NVL(:CONTROLE.CD_TIPOCOMPRA,'-1')   AND&#10;       NVL(VET_DADOSGRAVACAO(1).DT_DESEJADA,TO_DATE('01/01/1900','DD/MM/RRRR')) = NVL(:CONTROLE.DT_DESEJADA,TO_DATE('01/01/1900','DD/MM/RRRR'))AND   &#10;       VET_DADOSGRAVACAO(1).NR_LOTECOMPRA                                        = :CONTROLE.NR_LOTECOMPRA              AND &#10;       NVL(VET_DADOSGRAVACAO(1).DT_INICIO,TO_DATE('01/01/1900','DD/MM/RRRR'))    = NVL(:CONTROLE.DT_INICIO,TO_DATE('01/01/1900','DD/MM/RRRR'))AND     &#10;       NVL(VET_DADOSGRAVACAO(1).NR_CONTRATO,0)                                   = NVL(:CONTROLE.NR_CONTRATO,0) AND&#10;       NVL(VET_DADOSGRAVACAO(1).CD_DEPARTAMENTO,0)                               = NVL(:CONTROLE.CD_DEPARTAMENTO,0) THEN&#10;       &#10;       V_FLAG_BLOCO1 := TRUE;&#10;    ELSE&#10;       V_FLAG_BLOCO1 := FALSE;&#10;    END IF; &#10;    &#10;    V_COUNT := 0;&#10;    V_FLAG_BLOCO2 := TRUE;&#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    LOOP&#10;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;        V_COUNT := NVL(V_COUNT,0) + 1;&#10;      END IF;&#10;      &#10;      FOR I IN 1..NVL(VET2_DADOSGRAVACAO.COUNT,0)LOOP&#10;        IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;          IF VET2_DADOSGRAVACAO(I).CD_ITEM            = :ITEMCOMPRA.CD_ITEM THEN &#10;            IF VET2_DADOSGRAVACAO(I).CD_MOVIMENTACAO  = :ITEMCOMPRA.CD_MOVIMENTACAO AND    &#10;               VET2_DADOSGRAVACAO(I).QT_PREVISTA      = :ITEMCOMPRA.QT_PREVISTA AND&#10;               NVL(VET2_DADOSGRAVACAO(I).DS_OBSERVACAOEXT,' ') = NVL(:ITEMCOMPRA.DS_OBSERVACAOEXT,' ') AND&#10;               NVL(VET2_DADOSGRAVACAO(I).DS_OBSERVACAO,' ')    = NVL(:ITEMCOMPRA.DS_OBSERVACAO,' ') THEN&#10;               NULL;&#10;            ELSE &#10;              V_FLAG_BLOCO2 := FALSE;&#10;            END IF;&#10;          END IF;&#10;        END IF;&#10;      END LOOP;&#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    --caso a quantidade de itens do Lote de Compra for difrente do Vetor, entende que foi inserido&#10;    IF NVL(V_COUNT,0) &#60;> NVL(VET2_DADOSGRAVACAO.COUNT,0) THEN&#10;      V_FLAG_BLOCO2 := FALSE;&#10;    END IF;&#10;&#10;    IF V_FLAG_BLOCO1 AND V_FLAG_BLOCO2 THEN&#10;      RETORNO := TRUE;&#10;    ELSE&#10;      RETORNO := FALSE;&#10;    END IF;&#10;    &#10;  EXCEPTION    &#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM := 'Erro ao verificar dados '||SQLERRM;&#10;  END;&#10;      &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="DEFINIR_ROUND">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE DEFINIR_ROUND (I_CD_ITEM  IN  ITEMEMPRESA.CD_ITEM%TYPE,&#10;                         O_MENSAGEM  OUT  VARCHAR2) IS&#10;&#10;  V_TP_UNIDMED       TIPOCALCULOPRECO.TP_UNIDMED%TYPE;&#10;  V_CD_TIPOCALCULO  ITEMEMPRESA.CD_TIPOCALCULO%TYPE;&#10;  E_GERAL            EXCEPTION;&#10;  &#10;BEGIN&#10;  /* MGK:52401:03/12/2012&#10;  ** Criado procedimento para controlar o arredondamento do campo QT_PREVISTA.&#10;  */&#10;  BEGIN&#10;    SELECT ITEMEMPRESA.CD_TIPOCALCULO&#10;      INTO V_CD_TIPOCALCULO&#10;      FROM ITEMEMPRESA&#10;     WHERE ITEMEMPRESA.CD_ITEM    = I_CD_ITEM&#10;        AND ITEMEMPRESA.CD_EMPRESA = :CONTROLE.CD_EMPRESA;&#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      V_CD_TIPOCALCULO := NULL;&#10;      --Não existe um tipo de cálculo válido para o item ¢CD_ITEM¢ na empresa ¢CD_EMPRESA¢. Verifique TIT001, aba Empresa.&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1348, '¢CD_ITEM='||I_CD_ITEM||'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢');&#10;    WHEN TOO_MANY_ROWS THEN&#10;      ----Mais de um Tipo de Cálculo para o Item (¢CD_ITEM¢) e Empresa (¢CD_EMPRESA¢) encontrados. Verifique TIT001!&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12220, '¢CD_ITEM='||I_CD_ITEM||'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢');&#10;    WHEN OTHERS THEN&#10;      --Ocorreu um erro durante a consulta dos dados do item ¢CD_ITEM¢. Erro: ¢SQLERRM¢.&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(60, '¢CD_ITEM='||I_CD_ITEM||'¢SQLERRM='||SQLERRM||'¢');&#10;  END;&#10;  &#10;  BEGIN&#10;    SELECT TIPOCALCULOPRECO.TP_UNIDMED&#10;      INTO V_TP_UNIDMED&#10;      FROM TIPOCALCULOPRECO&#10;     WHERE TIPOCALCULOPRECO.CD_TIPOCALCULO = V_CD_TIPOCALCULO;&#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      V_TP_UNIDMED := NULL;&#10;      --Unidade de medida não está cadastrada para o item ¢CD_ITEM¢. Verifique TIT001.&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(302, '¢CD_ITEM='||I_CD_ITEM||'¢');&#10;    WHEN TOO_MANY_ROWS THEN&#10;      --Unidade de medida cadastrada várias vezes para o item ¢CD_ITEM¢. Verifique TIT001&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(303, '¢CD_ITEM='||I_CD_ITEM||'¢');&#10;    WHEN OTHERS THEN&#10;      --Erro ao buscar do tipo de unidade de medida para o item ¢CD_ITEM¢ na empresa ¢CD_EMPRMOVTO¢. Erro: ¢SQLERRM¢.&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(7191, '¢CD_ITEM='||I_CD_ITEM||'¢CD_EMPRMOVTO='||:CONTROLE.CD_EMPRESA||'¢SQLERRM='||SQLERRM||'¢');&#10;  END;&#10;  &#10;  IF (V_TP_UNIDMED = '1') THEN -- Item é por peso&#10;    NULL;&#10;  ELSIF (V_TP_UNIDMED = '2') THEN -- Item é por qtde&#10;    :ITEMCOMPRA.QT_PREVISTA := ROUND(:ITEMCOMPRA.QT_PREVISTA);&#10;  ELSE&#10;    O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(471, '¢CD_ITEM='||I_CD_ITEM||'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢');&#10;    RAISE E_GERAL;&#10;  END IF;--IF (V_TP_UNIDMED = 1) THEN&#10;  &#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    NULL;&#10;    &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="CANCELAR_ITEMCOMPRA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE CANCELAR_ITEMCOMPRA (I_NR_ITEMCOMPRA  IN ITEMCOMPRA.NR_ITEMCOMPRA%TYPE,&#10;                               I_CD_EMPRESA     IN ITEMCOMPRA.CD_EMPRESA%TYPE,&#10;                               I_CD_ITEM         IN ITEMCOMPRA.CD_ITEM%TYPE,&#10;                               O_MENSAGEM       OUT VARCHAR2) IS &#10;  &#10;  V_COUNT_PONTOPEDIDO              NUMBER;&#10;  V_COUNT_ITEMCOMPRACCUSTO        NUMBER;&#10;  V_COUNT                          NUMBER;&#10;  V_MENSAGEM                       VARCHAR2(32000);&#10;  E_GERAL                          EXCEPTION;&#10;  V_DADOS_ENTRADA                  PACK_PEDIDOINTERNO.R_DADOS_ENTRADA;&#10;  V_ROW_PEDIDOINTERNOINTECOMPRA    PEDIDOINTERNOINTECOMPRA%ROWTYPE;&#10;  V_ROW_ITEMPEDIDOINTERNO          ITEMPEDIDOINTERNO%ROWTYPE;&#10;  V_NR_PEDIDOINTERNO              PEDIDOINTERNO.NR_PEDIDOINTERNO%TYPE;&#10;  V_QTDE_PESO_RECALCULADO          NUMBER;&#10;  V_CD_UNIDMEDESTQ                 VARCHAR2(10);&#10;  V_TP_UNIDMED                    VARCHAR2(10);  &#10;BEGIN&#10;&#10;  BEGIN&#10;    UPDATE ITEMCOMPRA&#10;       SET ITEMCOMPRA.ST_ITEMCOMPRA = 99,&#10;           ITEMCOMPRA.DS_OBSCANCEL  = :ITEMCOMPRA.DS_OBSCANCEL&#10;     WHERE ITEMCOMPRA.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA &#10;       AND ITEMCOMPRA.CD_EMPRESA    = I_CD_EMPRESA;&#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      -- Erro ao Atualizar o registro da Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢. ¥Detalhes ¢DS_DETALHE¢¥.&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864, '¢NM_TABELA='||'ITEMCOMPRA'||'¢SQLERRM='||SQLERRM||'¢DS_DETALHE='||'Houve erro ao atualizar a solicitação de Compra ('||I_NR_ITEMCOMPRA||') na empresa ('||I_CD_EMPRESA||').'||'¢'); &#10;      RAISE E_GERAL;&#10;  END;&#10;&#10;  IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;    PACK_LOGUSUARIO.AUDITAR_ATUALIZACAO (V_CD_EMPRESA  => :GLOBAL.CD_EMPRESA,&#10;                                         V_CD_MODULO    => :GLOBAL.CD_MODULO,&#10;                                         V_CD_PROGRAMA => :GLOBAL.CD_PROGRAMA,&#10;                                         V_CD_USUARIO  => :GLOBAL.CD_USUARIO,&#10;                                         V_DS_EVENTO    => 'O usuário ('||:GLOBAL.CD_USUARIO||') efetuou o cancelamento da solicitação de compra ('||I_NR_ITEMCOMPRA||') na empresa ('||I_CD_EMPRESA||').',&#10;                                         V_NM_ENTIDADE => 'ITEMCOMPRA',&#10;                                         V_DS_DML      => 'UPDATE ITEMCOMPRA&#10;                                                              SET ITEMCOMPRA.ST_ITEMCOMPRA = 99&#10;                                                            WHERE ITEMCOMPRA.NR_ITEMCOMPRA = '||I_NR_ITEMCOMPRA||' &#10;                                                              AND ITEMCOMPRA.CD_EMPRESA    = '||I_CD_EMPRESA);&#10;  END IF; --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;  ----------------------------------------------&#10;  &#10;   BEGIN &#10;     SELECT COUNT(*) &#10;       INTO V_COUNT_ITEMCOMPRACCUSTO &#10;       FROM ITEMCOMPRACCUSTO &#10;     WHERE ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA &#10;       AND ITEMCOMPRACCUSTO.CD_EMPRESA    = I_CD_EMPRESA; &#10;   EXCEPTION &#10;     WHEN OTHERS THEN &#10;       V_COUNT_ITEMCOMPRACCUSTO := 0; &#10;   END; &#10;   &#10;   IF (NVL(V_COUNT_ITEMCOMPRACCUSTO,0) > 0) THEN&#10;    BEGIN&#10;      UPDATE ITEMCOMPRACCUSTO&#10;         SET ITEMCOMPRACCUSTO.ST_ITEMCOMPRA = 99&#10;       WHERE ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = I_NR_ITEMCOMPRA &#10;         AND ITEMCOMPRACCUSTO.CD_EMPRESA    = I_CD_EMPRESA;&#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        -- Erro ao Atualizar o registro da Tabela ¢NM_TABELA¢. Erro ¢SQLERRM¢. ¥Detalhes ¢DS_DETALHE¢¥.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1864, '¢NM_TABELA='||'ITEMCOMPRACCUSTO'||'¢SQLERRM='||SQLERRM||'¢DS_DETALHE='||'Houve erro ao atualizar a solicitação de Compra ('||I_NR_ITEMCOMPRA||') na empresa ('||I_CD_EMPRESA||').'||'¢'); &#10;        RAISE E_GERAL;&#10;    END;  &#10;    &#10;    IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;      PACK_LOGUSUARIO.AUDITAR_ATUALIZACAO (V_CD_EMPRESA  => :GLOBAL.CD_EMPRESA,&#10;                                           V_CD_MODULO    => :GLOBAL.CD_MODULO,&#10;                                           V_CD_PROGRAMA => :GLOBAL.CD_PROGRAMA,&#10;                                           V_CD_USUARIO  => :GLOBAL.CD_USUARIO,&#10;                                           V_DS_EVENTO    => 'O usuário ('||:GLOBAL.CD_USUARIO||') efetuou o cancelamento da solicitação de compra ('||I_NR_ITEMCOMPRA||') na empresa ('||I_CD_EMPRESA||') e os centros de custo associados a esta solicitação de compra.',&#10;                                           V_NM_ENTIDADE => 'ITEMCOMPRACCUSTO',&#10;                                           V_DS_DML      => 'UPDATE ITEMCOMPRACCUSTO&#10;                                                                SET ITEMCOMPRACCUSTO.ST_ITEMCOMPRA = 99&#10;                                                              WHERE ITEMCOMPRACCUSTO.NR_ITEMCOMPRA = '||I_NR_ITEMCOMPRA||' &#10;                                                                AND ITEMCOMPRACCUSTO.CD_EMPRESA    = '||I_CD_EMPRESA);&#10;    END IF; --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;  END IF; --IF (NVL(V_COUNT_ITEMCOMPRACCUSTO,0) > 0) THEN&#10;  -------------------------------------------------------&#10;  &#10;  /** ALE:27/07/2013:59721&#10;   *  Quando o parâmetro &#34;Ativar Controle de Ponto de Pedido&#34; estiver configurado na página &#34;Validações&#34; do COM009, será&#10;   *  realizado o reprocesso de solicitação de compras.&#10;   *&#10;   *  O calculo que o Maxys realizar para definir o status da solicitação para &#34;Dentro do Ponto de Pedido&#34; é o seguinte: &#10;   *  &#34;Quantidade em estoque - Soma total das solicitações de compras com status &#34;Dentro do Ponto de Pedido&#34; - Quando solicitada &#10;   *  na solicitação que está realizada no momento&#34;.&#10;   * &#10;   *  Se o resultado dessa fórmula for maior ou igual ao a quantidade configurada para o ponto de pedido do item no TIT001, &#10;   *  a solicitação de compras ficará com o status &#34;Dentro do Ponto de Pedido&#34;. Se o resultado dessa fórmula for menor que a &#10;   *  quantidade configurada para o ponto de pedido do item no TIT001, a solicitação ficará com o status &#34;Liberado&#34;. &#10;   *&#10;   *  No cotidiano das empresas, é comum o estoque dos itens sofrerem alterações de seus saldos no estoque, uma vez que são &#10;   *  realizadas entradas e saídas do item. Como o item pode sofrer essas alterações de saldo, o status da solicitação de compra &#10;   *  que estiver dentro do ponto do pedido ou liberada para o processo de compras, pode se tornar obsoleto e para resolver &#10;   *  esse problema, a cada alteração no estoque, os status devem ser reprocessados para representar a situação atual da empresa.&#10;   *&#10;   *  O reprocesso dos status de solicitações de compras sempre irá ocorrer em dois momentos: &#10;   *  - Quando a quantidade em estoque do item for atualizada (compra, venda e cancelamento de movimentação de estoque);&#10;   *  - Cancelamento de solicitações de compras com status ¿Liberado¿, ¿Em Cotação¿ e ¿Dentro do Ponto de Pedido¿.   &#10;   */  &#10;  IF (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',I_CD_EMPRESA,'ST_PONTOPEDIDO'),'N') = 'S') THEN    &#10;    BEGIN&#10;      SELECT COUNT(ITEMCOMPRA.NR_ITEMCOMPRA)&#10;        INTO V_COUNT_PONTOPEDIDO&#10;        FROM ITEMCOMPRA&#10;       WHERE ITEMCOMPRA.ST_ITEMCOMPRA IN (1,3,14)&#10;         AND ITEMCOMPRA.CD_ITEM = I_CD_ITEM;&#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        V_COUNT_PONTOPEDIDO := 0;&#10;    END;&#10;    &#10;    IF (NVL(V_COUNT_PONTOPEDIDO,0) > 0) THEN&#10;      PACK_COMPRAS.VERIFICA_PONTOPEDIDO (I_CD_ITEM  => I_CD_ITEM,&#10;                                         O_MENSAGEM => V_MENSAGEM);                  &#10;      IF (V_MENSAGEM IS NOT NULL) THEN&#10;        RAISE E_GERAL;&#10;      END IF; --IF (V_MENSAGEM IS NOT NULL) THEN&#10;    END IF; --IF (NVL(V_COUNT_PONTOPEDIDO,0) > 0) THEN&#10;  END IF; --IF (NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',V_CD_EMPRESA,'ST_PONTOPEDIDO'),'N') = 'S') THEN  &#10;  ---------------------------------------------------------------------------------------------------------------&#10;  &#10;  &#10;  /*AUG:130776:20/02/2019*/&#10;  BEGIN&#10;    SELECT NR_PEDIDOINTERNO&#10;      INTO V_NR_PEDIDOINTERNO &#10;      FROM PEDIDOINTERNOINTECOMPRA&#10;     WHERE PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO = :CONTROLE.CD_EMPRESA&#10;       --AND PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO  = :PARAMETER.NR_PEDIDOINTERNO   &#10;       AND PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA     = :ITEMCOMPRA.CD_ITEM          &#10;       AND PEDIDOINTERNOINTECOMPRA.CD_EMPRCOMPRA     = :ITEMCOMPRA.CD_EMPRESA;&#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      V_COUNT := 0;&#10;  END;&#10;  &#10;  IF V_NR_PEDIDOINTERNO IS NOT NULL THEN  &#10;    V_DADOS_ENTRADA.CD_MODULO     := :GLOBAL.CD_MODULO;   &#10;    V_DADOS_ENTRADA.CD_PROGRAMA   := :GLOBAL.CD_PROGRAMA; &#10;    V_DADOS_ENTRADA.CD_EMPRESA    := :GLOBAL.CD_EMPRESA;  &#10;    V_DADOS_ENTRADA.CD_USUARIO    := :GLOBAL.CD_USUARIO;  &#10;    V_DADOS_ENTRADA.ST_AUDITORIA  := :GLOBAL.ST_AUDITORIA;&#10;    &#10;    V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO := :CONTROLE.CD_EMPRESA;&#10;    V_ROW_PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO  :=  V_NR_PEDIDOINTERNO;&#10;    V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA     := :ITEMCOMPRA.CD_ITEM;&#10;    V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRCOMPRA     := :ITEMCOMPRA.CD_EMPRESA;&#10;    &#10;    /*AUG:130776:20/02/2019*/&#10;    PACK_PEDIDOINTERNO.CANCELA_PEDINTERNOINTECOMPRA(V_DADOS_ENTRADA,&#10;                                                    V_ROW_PEDIDOINTERNOINTECOMPRA,&#10;                                                    :CONTROLE.NR_LOTECOMPRA,&#10;                                                    V_MENSAGEM);&#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    BEGIN&#10;      SELECT *&#10;        INTO V_ROW_ITEMPEDIDOINTERNO&#10;        FROM ITEMPEDIDOINTERNO&#10;       WHERE ITEMPEDIDOINTERNO.CD_EMPRPEDINTERNO  = V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO&#10;         AND ITEMPEDIDOINTERNO.NR_PEDIDOINTERNO    = V_ROW_PEDIDOINTERNOINTECOMPRA.NR_PEDIDOINTERNO&#10;         AND ITEMPEDIDOINTERNO.CD_ITEM            = V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA;&#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        O_MENSAGEM := 'Erro desconhecido ao alterar a tabela ITEMPEDIDOINTERNO..: '||SQLERRM;&#10;        RAISE E_GERAL;&#10;    END;&#10;    &#10;    PACK_PEDIDOINTERNO.RETORNA_UNIDMED( V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO,  &#10;                                        V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA,&#10;                                        V_TP_UNIDMED,&#10;                                        V_CD_UNIDMEDESTQ);&#10;                 &#10;    IF NVL(V_TP_UNIDMED, '1') = '2' AND V_CD_UNIDMEDESTQ IS NULL THEN&#10;      PACK_PEDIDOINTERNO.VALIDA_QTDE_PESO(V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO,&#10;                                          V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA,&#10;                                          :ITEMCOMPRA.QT_PREVISTA,&#10;                                          V_QTDE_PESO_RECALCULADO,&#10;                                          'Q',&#10;                                          O_MENSAGEM);&#10;      IF O_MENSAGEM IS NOT NULL THEN&#10;        RAISE E_GERAL;&#10;      END IF;          &#10;      &#10;      V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA := V_ROW_ITEMPEDIDOINTERNO.QT_ATENDIDA - V_QTDE_PESO_RECALCULADO;&#10;    ELSE&#10;      PACK_PEDIDOINTERNO.VALIDA_QTDE_PESO(V_ROW_PEDIDOINTERNOINTECOMPRA.CD_EMPRPEDINTERNO,&#10;                                          V_ROW_PEDIDOINTERNOINTECOMPRA.NR_ITEMCOMPRA,  &#10;                                          V_QTDE_PESO_RECALCULADO,  &#10;                                          :ITEMCOMPRA.QT_PREVISTA,&#10;                                          'P',&#10;                                          O_MENSAGEM);&#10;      IF O_MENSAGEM IS NOT NULL THEN&#10;        RAISE E_GERAL;&#10;      END IF;                                                     &#10;      &#10;      V_ROW_ITEMPEDIDOINTERNO.PS_PEDIDO := V_ROW_ITEMPEDIDOINTERNO.PS_PEDIDO - V_QTDE_PESO_RECALCULADO;&#10;     END IF;  &#10;    &#10;    PACK_PEDIDOINTERNO.GRAVA_ITEMPEDIDOINTERNO(V_DADOS_ENTRADA,&#10;                                               V_ROW_ITEMPEDIDOINTERNO,&#10;                                               O_MENSAGEM);&#10;    IF O_MENSAGEM IS NOT NULL THEN&#10;      RAISE E_GERAL;&#10;    END IF;                                    &#10;  END IF;--IF NVL(V_COUNT,0) > 0 THEN  &#10;  /* WLV:16/02/2012:40906 - Adicionado para mostrar ao usuário que o item foi cancelado*/  &#10;  --O item ¢CD_ITEM¢ da solicitação de compra ¢NR_ITEMCOMPRA¢ da empresa ¢CD_EMPRESA¢ foi cancelada com sucesso. Verifique se status no COM003.&#10;  MENSAGEM_PADRAO(16208, '¢CD_ITEM='||I_CD_ITEM||'¢NR_ITEMCOMPRA='||I_NR_ITEMCOMPRA||'¢CD_EMPRESA='||I_CD_EMPRESA||'¢');&#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    O_MENSAGEM := '[CANCELAR_ITEMCOMPRA] - '||V_MENSAGEM;&#10;  WHEN OTHERS THEN&#10;    O_MENSAGEM := '[CANCELAR_ITEMCOMPRA] - '||SQLERRM;&#10;END CANCELAR_ITEMCOMPRA;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_CONTA_ORCAMENTO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_CONTA_ORCAMENTO(I_TRIGGER_ITEM    IN VARCHAR2, &#10;                                 I_CD_MOVIMENTACAO IN NUMBER, &#10;                               ---  &#10;                                 I_CD_CENTROCUSTO  IN VARCHAR2,&#10;                                 I_CD_NEGOCIO      IN NUMBER DEFAULT NULL ) IS                                &#10;BEGIN&#10;  IF PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,'COMPRAS') = 'S' AND &#10;     PACK_ORC051.RETORNA_TIPO_ORCAMENTO(SYSDATE) = 'O' AND &#10;     NVL(PACK_PARMGEN.CONSULTA_PARAMETRO ('ORC',50,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CONTAORCCOMPRAS'),'N') = 'S' THEN      &#10;    BEGIN&#10;      SELECT HISTCONTB.CD_CONTACONTABIL&#10;        INTO :CONTROLE.CD_CONTACONTABIL&#10;        FROM PARMOVIMENT,&#10;             HISTCONTB&#10;       WHERE PARMOVIMENT.CD_MOVIMENTACAO = I_CD_MOVIMENTACAO&#10;         AND PARMOVIMENT.CD_HISTCONTB     = HISTCONTB.CD_HISTCONTB;&#10;         &#10;      :CONTROLE.CD_CONTAORCAMENTO := NULL;&#10;            &#10;      BEGIN &#10;        SELECT R.CD_CONTAORCAMENTO&#10;          INTO :CONTROLE.CD_CONTAORCAMENTO&#10;          FROM RELACAOCONTASORCCTB R, PLANOCONTASORCAMENTO P , PLANOCONTABIL&#10;         WHERE R.CD_CONTACONTABIL  = :CONTROLE.CD_CONTACONTABIL                           &#10;           AND R.CD_CONTAORCAMENTO = P.CD_CONTAORCAMENTO&#10;           AND R.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#10;           AND ((I_CD_CENTROCUSTO IS NOT NULL &#10;                 AND EXISTS (SELECT PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO&#10;                               FROM PLANOCONTASORCAMENTOCUSTO&#10;                              WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO&#10;                                AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO    = I_CD_CENTROCUSTO&#10;                              )) &#10;               OR&#10;               (I_CD_CENTROCUSTO IS NULL &#10;                 AND 0 = (SELECT COUNT(PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO)&#10;                            FROM PLANOCONTASORCAMENTOCUSTO&#10;                           WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO &#10;                             AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO IS NULL))                                                               &#10;                            );   &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          :CONTROLE.CD_CONTAORCAMENTO := NULL;&#10;          MENSAGEM_PADRAO(28965, '¢CD_CONTACONTABIL='||:CONTROLE.CD_CONTACONTABIL||'¢CD_CENTROCUSTO='||NVL(I_CD_CENTROCUSTO,'Não Informado')||'¢');&#10;        WHEN TOO_MANY_ROWS THEN&#10;          LOOP&#10;            IF SHOW_LOV('LOV_CONTAORC') THEN&#10;              EXIT;&#10;            END IF;&#10;          END LOOP;              &#10;      END;&#10;          &#10;      IF :CONTROLE.CD_CONTAORCAMENTO IS NOT NULL THEN&#10;        COPY(:CONTROLE.CD_CONTAORCAMENTO, I_TRIGGER_ITEM);&#10;      END IF;    &#10;      &#10;         &#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        NULL;&#10;    END;    &#10;  END IF;        &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="MANIPULA_CAMPO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE MANIPULA_CAMPO(I_DS_CAMPO IN VARCHAR2,&#10;                         I_TIPO     IN VARCHAR2) IS&#10;BEGIN &#10;  IF I_TIPO = 'A' THEN&#10;    IF GET_ITEM_PROPERTY(I_DS_CAMPO,ENABLED) = 'FALSE' THEN&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,ENABLED          ,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,NAVIGABLE        ,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,VISUAL_ATTRIBUTE ,'VSA_CAMPOTEXTO');&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,PROMPT_FONT_STYLE,FONT_UNDERLINE);  &#10;    END IF;  &#10;  ELSE&#10;    IF GET_ITEM_PROPERTY(I_DS_CAMPO,ENABLED) = 'TRUE' THEN&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,ENABLED          ,PROPERTY_FALSE);&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,REQUIRED         ,PROPERTY_FALSE);&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,VISUAL_ATTRIBUTE ,'VSA_CAMPOEXIBICAO');&#10;      SET_ITEM_PROPERTY (I_DS_CAMPO,PROMPT_FONT_STYLE,FONT_PLAIN);&#10;    END IF;&#10;  END IF;        &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_GRUPO_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_GRUPO_NEGOCIO IS&#10;  --CENTRO CUSTO&#10;  PROCEDURE CRIA_GRUPO_NEGOCIO;&#10;  PROCEDURE ADICIONA_GRUPO_NEGOCIO( I_CD_EMPRCCUSTODEST IN NUMBER,&#10;                                    I_CD_ITEM            IN NUMBER,&#10;                                    I_CD_CENTROCUSTO    IN NUMBER,&#10;                                    I_CD_MOVIMENTACAO   IN NUMBER,&#10;                                    I_CD_AUTORIZADOR    IN VARCHAR2,&#10;                                    I_QT_PEDIDAUNIDSOL  IN NUMBER,&#10;                                     I_PC_PARTICIPACAO   IN NUMBER,&#10;                                     I_CD_NEGOCIO        IN NUMBER,&#10;                                     I_DS_OBSERVACAO     IN VARCHAR2,&#10;                                     I_CD_CONTAORCAMENTO IN NUMBER);&#10;                              &#10;  PROCEDURE DELETA_GRUPO_NEGOCIO  (I_CD_ITEM    IN NUMBER);&#10;  PROCEDURE CARREGA_DADOS_NEGOCIO (I_CD_ITEM    IN NUMBER);&#10;  &#10;&#10;  --LOVS DO CENTRO DE CUSTO&#10;  /*PROCEDURE CRIA_GRUPO_LOVCC;&#10;  PROCEDURE ADICIONA_GRUPO_LOVCC(I_CD_ITEM     IN NUMBER,&#10;                                  I_CD_CENTROCUSTO  IN NUMBER,&#10;                                 I_PC_PARTICIPACAO IN NUMBER);&#10;  PROCEDURE DELETA_GRUPO_LOVCC;*/&#10;&#10;  --PROCEDURE CARREGA_DADOS_NG (I_CD_ITEM    IN NUMBER);  &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_GRUPO_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE BODY PACK_GRUPO_NEGOCIO IS&#10;-----------------------------------------------------------------------------&#10;-----------------------------------------------------------------------------&#10;                             -- CENTRO CUSTO --&#10;-----------------------------------------------------------------------------&#10;-----------------------------------------------------------------------------&#10;  PROCEDURE CRIA_GRUPO_NEGOCIO IS&#10;    GRP_REPLICA RECORDGROUP;&#10;    COL_REPLICA GROUPCOLUMN;&#10;  BEGIN&#10;    GRP_REPLICA := FIND_GROUP('GRUPO_NEGOCIO');&#10;    IF NOT ID_NULL(GRP_REPLICA) THEN &#10;      DELETE_GROUP(GRP_REPLICA); &#10;    END IF;&#10;    &#10;    GRP_REPLICA := CREATE_GROUP('GRUPO_NEGOCIO');&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'CD_ITEM'          , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'CD_CENTROCUSTO'   , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'CD_NEGOCIO'       , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'CD_MOVIMENTACAO'  , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'CD_AUTORIZADOR'   , CHAR_COLUMN,4);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'QT_PEDIDAUNIDSOL' , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'PC_PARTICIPACAO'  , NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'CD_EMPRCCUSTODEST', NUMBER_COLUMN);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'DS_OBSERVACAO'    , CHAR_COLUMN,150);&#10;    COL_REPLICA := ADD_GROUP_COLUMN('GRUPO_NEGOCIO', 'CD_CONTAORCAMENTO', NUMBER_COLUMN);&#10;    &#10;  END CRIA_GRUPO_NEGOCIO;&#10;  ---------------------------------------------------------------------------------------------&#10;  &#10;  PROCEDURE ADICIONA_GRUPO_NEGOCIO( I_CD_EMPRCCUSTODEST IN NUMBER,&#10;                                    I_CD_ITEM            IN NUMBER,&#10;                                    I_CD_CENTROCUSTO    IN NUMBER,&#10;                                    I_CD_MOVIMENTACAO   IN NUMBER,&#10;                                    I_CD_AUTORIZADOR    IN VARCHAR2,&#10;                                    I_QT_PEDIDAUNIDSOL  IN NUMBER,&#10;                                     I_PC_PARTICIPACAO   IN NUMBER,&#10;                                     I_CD_NEGOCIO        IN NUMBER/*CSL:21/12/2010:30317*/,&#10;                                     I_DS_OBSERVACAO     IN VARCHAR2,&#10;                                     I_CD_CONTAORCAMENTO IN NUMBER) IS&#10;  BEGIN&#10;    ADD_GROUP_ROW('GRUPO_NEGOCIO',END_OF_GROUP);&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_EMPRCCUSTODEST', GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_CD_EMPRCCUSTODEST);--GDG:22/07/2011:28715&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_ITEM'          , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_CD_ITEM         );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_CENTROCUSTO'   , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_CD_CENTROCUSTO  );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_NEGOCIO'       , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_CD_NEGOCIO      );/*CSL:21/12/2010:30317*/&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_MOVIMENTACAO'  , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_CD_MOVIMENTACAO );&#10;    SET_GROUP_CHAR_CELL  ('GRUPO_NEGOCIO.CD_AUTORIZADOR'   , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_CD_AUTORIZADOR  );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.QT_PEDIDAUNIDSOL' , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_QT_PEDIDAUNIDSOL);&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.PC_PARTICIPACAO'  , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_PC_PARTICIPACAO );&#10;    SET_GROUP_CHAR_CELL  ('GRUPO_NEGOCIO.DS_OBSERVACAO'    , GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_DS_OBSERVACAO   );&#10;    SET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_CONTAORCAMENTO', GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'), I_CD_CONTAORCAMENTO);&#10;    &#10;  END ADICIONA_GRUPO_NEGOCIO;&#10;  ---------------------------------------------------------------------------------------------&#10;  PROCEDURE DELETA_GRUPO_NEGOCIO( I_CD_ITEM IN NUMBER ) IS&#10;    NR_REG NUMBER;&#10;    NR_TOT NUMBER;&#10;  BEGIN&#10;    &#10;    LOOP&#10;      NR_TOT := GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO');&#10;      NR_REG := 0;&#10;      FOR I IN 1 ..GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO') LOOP&#10;        NR_REG := NR_REG + 1;&#10;        IF GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_ITEM', I) = I_CD_ITEM THEN&#10;          DELETE_GROUP_ROW('GRUPO_NEGOCIO', I);&#10;          EXIT;&#10;        END IF;&#10;      END LOOP;&#10;      EXIT WHEN NR_TOT = NR_REG;&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;  END DELETA_GRUPO_NEGOCIO;&#10;  &#10;  ---------------------------------------------------------------------------------------------&#10;  PROCEDURE CARREGA_DADOS_NEGOCIO (I_CD_ITEM IN NUMBER) IS&#10;  I_EXISTE   BOOLEAN;&#10;  BEGIN  &#10;    I_EXISTE := FALSE;&#10;    GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    FIRST_RECORD;    &#10;    IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN &#10;      FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO') LOOP&#10;        IF NVL(GET_GROUP_ROW_COUNT('GRUPO_NEGOCIO'),0) > 0 THEN&#10;          IF I_CD_ITEM = GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_ITEM', I) THEN&#10;            :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_EMPRCCUSTODEST', I);&#10;            :ITEMCOMPRANEGOCIO.CD_ITEM            := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_ITEM'           , I);&#10;           -- :ITEMCOMPRANEGOCIO.CD_CENTROCUSTO    := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_CENTROCUSTO'   , I);&#10;            :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO   := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_MOVIMENTACAO'  , I);&#10;            --:ITEMCOMPRANEGOCIO.CD_AUTORIZADOR    := GET_GROUP_CHAR_CELL  ('GRUPO_NEGOCIO.CD_AUTORIZADOR'   , I);&#10;            :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.PC_PARTICIPACAO'  , I);&#10;            :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.QT_PEDIDAUNIDSOL' , I);&#10;            :ITEMCOMPRANEGOCIO.CD_NEGOCIO         := GET_GROUP_NUMBER_CELL('GRUPO_NEGOCIO.CD_NEGOCIO'       , I);&#10;            :ITEMCOMPRANEGOCIO.DS_OBSERVACAO     := GET_GROUP_CHAR_CELL  ('GRUPO_NEGOCIO.DS_OBSERVACAO'    , I);&#10;            I_EXISTE := TRUE;&#10;            NEXT_RECORD;&#10;          END IF;&#10;        END IF;&#10;      END LOOP;&#10;      FIRST_RECORD;&#10;    ELSE --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN  /*ATR:80785:11/02/2015*/&#10;      FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.COUNT LOOP&#10;        IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.COUNT > 0 THEN&#10;          IF :ITEMCOMPRA.CD_EMPRESA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_EMPRESA AND&#10;            :ITEMCOMPRA.NR_ITEMCOMPRA_AUX = PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).NR_ITEMCOMPRA THEN    &#10;            :ITEMCOMPRANEGOCIO.CD_ITEM            :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_ITEM;    &#10;            :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST  :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_EMPRCCUSTODEST;          &#10;            --:ITEMCOMPRANEGOCIO.CD_CENTROCUSTO     :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_CENTROCUSTO;         &#10;            :ITEMCOMPRANEGOCIO.CD_NEGOCIO           :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_NEGOCIO;                &#10;            :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO     :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).CD_MOVIMENTACAO;          &#10;            :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).QT_PEDIDAUNIDSOL;       &#10;            :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO    :=  PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(J).PC_PARTICIPACAO;&#10;            I_EXISTE := TRUE;    &#10;            NEXT_RECORD;&#10;          END IF;&#10;        END IF; --IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT > 0 THEN&#10;      END LOOP; --FOR J IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#10;      FIRST_RECORD;&#10;    END IF; --IF NOT PACK_PROCEDIMENTOS.V_DUPLICADO THEN   &#10;    &#10;    IF NOT I_EXISTE THEN&#10;      IF  :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#10;        :ITEMCOMPRANEGOCIO.CD_NEGOCIO :=  :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#10;        GO_ITEM('ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL');&#10;      END IF;&#10;     ELSE&#10;      GO_ITEM('ITEMCOMPRANEGOCIO.CD_NEGOCIO');&#10;    END IF;  &#10;  END;&#10;  &#10; &#10;&#10;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_DUPLICADOS_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_DUPLICADOS_NEGOCIO (O_MENSAGEM    OUT VARCHAR2) IS&#10;&#10;  V_NR_REGISTRO     NUMBER;&#10;  V_CD_NEGOCIO      ITEMCOMPRACCUSTO.CD_NEGOCIO%TYPE; /*CSL:22/12/2010:30317*/&#10;  V_MENSAGEM        VARCHAR2(32000);&#10;  E_GERAL            EXCEPTION;&#10;  V_CD_EMPRCCUSTODEST  EMPRESA.CD_EMPRESA%TYPE;&#10;BEGIN&#10;  &#10;  GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;  FIRST_RECORD;&#10;  LOOP&#10;    V_NR_REGISTRO    := :SYSTEM.CURSOR_RECORD;&#10;    --V_CD_CENTROCUSTO := :ITEMCOMPRANEGOCIO.CD_CENTROCUSTO;&#10;    V_CD_NEGOCIO     := :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#10;    --GDG:22/07/2011:28715    &#10;    V_CD_EMPRCCUSTODEST := NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST, :ITEMCOMPRANEGOCIO.CD_EMPRESA);&#10;    FIRST_RECORD;&#10;    LOOP&#10;      IF (V_NR_REGISTRO &#60;> :SYSTEM.CURSOR_RECORD) THEN&#10;        IF V_CD_NEGOCIO = :ITEMCOMPRANEGOCIO.CD_NEGOCIO/*&#10;          AND V_CD_EMPRCCUSTODEST = NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST, :ITEMCOMPRANEGOCIO.CD_EMPRESA)*/ THEN&#10;          --V_MENSAGEM := 'O Centro de Custo ('||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||') e o Negócio ('||:ITEMCOMPRACCUSTO.CD_NEGOCIO||') do registro atual ('||:SYSTEM.CURSOR_RECORD||') é igual ao do registro ('||V_NR_REGISTRO||'). Por favor verifique e altere.'; &#10;          --V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6353,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢CD_NEGOCIO='||:ITEMCOMPRACCUSTO.CD_NEGOCIO||'¢NR_REGATUAL='||:SYSTEM.CURSOR_RECORD||'¢NR_REGISTRO='||V_NR_REGISTRO||'¢');--O Centro de Custo ¢CD_CENTROCUSTO¢ e o Negócio ¢CD_NEGOCIO¢ do registro atual ¢NR_REGATUAL¢ é igual ao do registro ¢NR_REGISTRO¢. Por favor verifique e altere. &#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(16603, '¢CD_ITEM='||:ITEMCOMPRANEGOCIO.CD_ITEM||'¢');&#10;          RAISE E_GERAL;&#10;        END IF;&#10;      END IF;&#10;     &#10;      EXIT WHEN (:SYSTEM.LAST_RECORD = 'TRUE');&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    GO_RECORD(V_NR_REGISTRO);&#10;    EXIT WHEN (:SYSTEM.LAST_RECORD = 'TRUE');&#10;    NEXT_RECORD;&#10;  END LOOP;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    O_MENSAGEM := V_MENSAGEM; &#10;  WHEN OTHERS THEN&#10;    O_MENSAGEM := SQLERRM;   &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="ADICIONA_GRUPO_NEGOCIO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE ADICIONA_GRUPO_NEGOCIO IS&#10;BEGIN      &#10;  --Adiciona novas linhas no grupo com os dados do bloco e nr_registro = :GLOBAL.NR_REGISTRO&#10;  GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;  FIRST_RECORD;&#10;  --Deleta o quem tem no grupo com nr_registro = :GLOBAL.NR_REGISTRO&#10;  PACK_GRUPO_NEGOCIO.DELETA_GRUPO_NEGOCIO(:ITEMCOMPRANEGOCIO.CD_ITEM);&#10;  &#10;  FIRST_RECORD;&#10;  LOOP&#10;    IF :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#10;      PACK_GRUPO_NEGOCIO.ADICIONA_GRUPO_NEGOCIO(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST,--GDG:22/07/2011:28715&#10;                                   :ITEMCOMPRANEGOCIO.CD_ITEM,&#10;                                   NULL, --:ITEMCOMPRANEGOCIO.CD_CENTROCUSTO,&#10;                                   :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO,&#10;                                   NULL, --:ITEMCOMPRANEGOCIO.CD_AUTORIZADOR,&#10;                                   :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL,&#10;                                    :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO,&#10;                                    :ITEMCOMPRANEGOCIO.CD_NEGOCIO,&#10;                                    :ITEMCOMPRANEGOCIO.DS_OBSERVACAO,&#10;                                    :ITEMCOMPRANEGOCIO.CD_CONTAORCAMENTO);&#10;    END IF;&#10;    EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;    NEXT_RECORD;  &#10;  END LOOP;  &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="IMPORTA_ARQUIVO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE IMPORTA_ARQUIVO(O_MENSAGEM OUT VARCHAR2) IS&#10;  E_GERAL EXCEPTION;      &#10;  V_CMD              VARCHAR2(32000);&#10;  V_CAMINHOARQUIVO  VARCHAR2(32000);&#10;BEGIN&#10;  -- valida instação do aplicativo&#10;  PACK_ARQUIVOUTILS.VALIDA_ARQUIVOSERVIDOR(:GLOBAL.VL_UNCMAXYS||'\LeitorArquivos\LeitorArquivos.exe', O_MENSAGEM);&#10;  IF O_MENSAGEM IS NOT NULL THEN&#10;    RETURN;      &#10;  END IF;&#10;  &#10;  MENSAGEM('Maxys','Processando Arquivo ('||RETORNA_NOME_ARQUIVO(REPLACE(:ITEMCOMPRACCUSTO.DS_CAMINHO,'\','/'))||'). Aguarde...', 4);&#10;  SYNCHRONIZE;&#10;  &#10;  V_CAMINHOARQUIVO := :ITEMCOMPRACCUSTO.DS_CAMINHO;&#10;  IF WEBUTIL_FILE_TRANSFER.CLIENT_TO_AS(:ITEMCOMPRACCUSTO.DS_CAMINHO,&#10;                                        :GLOBAL.VL_REPORTPATH||'\'||RETORNA_NOMEARQUIVO(:ITEMCOMPRACCUSTO.DS_CAMINHO)) THEN&#10;    V_CAMINHOARQUIVO := :GLOBAL.VL_REPORTPATH||'\'||RETORNA_NOMEARQUIVO(:ITEMCOMPRACCUSTO.DS_CAMINHO);&#10;  END IF;&#10;  &#10;  --Chama o leitor&#10;  V_CMD := :GLOBAL.VL_UNCMAXYS||'\LeitorArquivos\LeitorArquivos.exe  --base '||PACK_SESSAO.VL_CURRENTHOST||' '||--nome da base&#10;                                                                   ' --modulo '||:GLOBAL.CD_MODULO||&#10;                                                                   ' --programa '||:GLOBAL.CD_PROGRAMA||&#10;                                                                   ' --usuario '||:GLOBAL.CD_USUARIO||&#10;                                                                   ' --sid '||PACK_SESSAO.RETORNA_SID||' '||--id da conexão do usuário&#10;                                                                   ' --caminhoArquivo &#34;'||V_CAMINHOARQUIVO||'&#34; '||--caminho completo do arquivo&#10;                                                                   ' --usuarioBanco='||PACK_SESSAO.VL_CURRENTSCHEMA||&#10;                                                                   ' --layout '||:CONTROLE.CD_LAYOUT; --código do layout da tabela LAYOUTARQUIVO&#10;  &#10;  HOST_SERVIDOR(V_CMD, NO_SCREEN);    &#10;  &#10;  IF O_MENSAGEM IS NULL THEN&#10;    IF WEBUTIL_FILE_TRANSFER.AS_TO_CLIENT(:GLOBAL.VL_REPORTPATHCLIENT||'\'||RETORNA_NOMEARQUIVO(V_CAMINHOARQUIVO),&#10;                                          V_CAMINHOARQUIVO) THEN&#10;      V_CAMINHOARQUIVO := :GLOBAL.VL_REPORTPATHCLIENT||'\'||RETORNA_NOMEARQUIVO(V_CAMINHOARQUIVO);&#10;    END IF;&#10;    --PACK_ARQUIVOUTILS.VISUALIZA_ARQUIVO(V_CAMINHOARQUIVO, O_MENSAGEM);&#10;    IF O_MENSAGEM IS NOT NULL THEN &#10;      RAISE E_GERAL;&#10;    END IF;&#10;  END IF;  &#10;  &#10;    GO_BLOCK('ITEMCOMPRACCUSTO');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    :CONTROLE.DS_LOG := NULL;&#10;     CARREGA_PLANILHA_CENTROCUSTO(O_MENSAGEM);    &#10;    IF(O_MENSAGEM IS NOT NULL)THEN       &#10;       GO_BLOCK('ITEMCOMPRACCUSTO');&#10;      CLEAR_BLOCK(NO_VALIDATE);         &#10;      CENTRALIZA_FORM('WIN_ITEMCOMPRA','WIN_IMPORTACAOLOG');    &#10;      MENSAGEM_PADRAO(32755,NULL);&#10;      GO_ITEM('CONTROLE.BTN_VOLTARLOG');  &#10;    RAISE E_GERAL;&#10;   END IF;&#10;&#10;  &#10;  IF O_MENSAGEM IS NOT NULL THEN&#10;    RAISE E_GERAL;&#10;  END IF;&#10;  &#10;  GO_BLOCK('ITEMCOMPRACCUSTO');&#10;  FIRST_RECORD;&#10;  &#10;  CLEAR_MESSAGE;&#10;  SYNCHRONIZE;&#10;                    &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    CLEAR_MESSAGE;&#10;    O_MENSAGEM := '¥IMPORTA_ARQUIVO¥'||O_MENSAGEM;&#10;  WHEN OTHERS THEN&#10;    /*Ocorreu um erro inesperado. Erro ¢SQLERRM¢.¥Detalhes: ¢DS_DETALHES¢¥.*/&#10;    O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8388, '¢SQLERRM='||SQLERRM||'¢DS_DETALHES=IMPORTA_ARQUIVO¢');&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="RETORNA_NOME_ARQUIVO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="FUNCTION RETORNA_NOME_ARQUIVO(I_DS_CAMINHO VARCHAR2) RETURN VARCHAR2 IS&#10;BEGIN&#10;  RETURN SUBSTR(I_DS_CAMINHO,INSTR(I_DS_CAMINHO,'/',-1,1)+1,LENGTH(I_DS_CAMINHO));&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="CARREGA_PLANILHA_CENTROCUSTO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE CARREGA_PLANILHA_CENTROCUSTO(O_MENSAGEM OUT VARCHAR2) IS           &#10;  GRUPO              RECORDGROUP;&#10;  ERRO                    NUMBER;&#10;  V_CONSULTA              VARCHAR2(32000);  &#10;  V_NR_LINHAINI            NUMBER := 0;  &#10;  V_CD_MOVIMENTACAO        ITEMCOMPRACCUSTO.CD_MOVIMENTACAO%TYPE;  &#10;  V_MENSAGEM               VARCHAR2(32000);    &#10;  V_CD_CENTROCUSTO        VARCHAR2(10);&#10;    -- adiciona lunha de log&#10;  PROCEDURE ADD_LOG(I_NR_LINHA IN NUMBER, I_DS_LOG   IN VARCHAR2) IS&#10;    V_LENGTH NUMBER;&#10;  BEGIN&#10;    V_LENGTH := LENGTH(:CONTROLE.DS_LOG);&#10;    IF NVL(V_LENGTH,0) + LENGTH('Linha '||LPAD(V_NR_LINHAINI+I_NR_LINHA,3,'0')||': '||I_DS_LOG|| CHR(10)) > 32676 THEN&#10;      NULL;&#10;    ELSE  &#10;      :CONTROLE.DS_LOG := :CONTROLE.DS_LOG || 'Linha '||LPAD(V_NR_LINHAINI+I_NR_LINHA,3,'0')||': '||I_DS_LOG|| CHR(10);&#10;    END IF;  &#10;  END;    &#10;&#10;BEGIN  &#10;&#10;  &#10; V_CONSULTA :='SELECT ROWNUM NR_LINHA,&#10;               RETORNA_VALORSTRING(DS_LINHA, 01, ''¢'') CD_CENTROCUSTO,  &#10;               RETORNA_VALORSTRING(DS_LINHA, 02, ''¢'') PC_PARTICIPACAO,   &#10;               RETORNA_VALORSTRING(DS_LINHA, 03, ''¢'') CD_EMPRESA,  &#10;               RETORNA_VALORSTRING(DS_LINHA, 04, ''¢'') CD_NEGOCIO,         &#10;               RETORNA_VALORSTRING(DS_LINHA, 05, ''¢'') CD_MOVIMENTACAO,     &#10;               RETORNA_VALORSTRING(DS_LINHA, 06, ''¢'') QT_PARTICIPACAO,&#10;               DS_LINHA    &#10;            FROM PARMREPORTSTMP&#10;           WHERE PARMREPORTSTMP.CD_MODULO   = '||QUOTES(:GLOBAL.CD_MODULO)||'&#10;             AND PARMREPORTSTMP.CD_PROGRAMA = '||:GLOBAL.CD_PROGRAMA||'&#10;             AND PARMREPORTSTMP.CD_USUARIO   = '||QUOTES(:GLOBAL.CD_USUARIO)||'&#10;             AND PARMREPORTSTMP.NR_SID       = '||PACK_SESSAO.RETORNA_SID;  &#10;  GRUPO := FIND_GROUP('GRUPO');&#10;  &#10;  IF NOT ID_NULL(GRUPO) THEN&#10;    DELETE_GROUP(GRUPO);&#10;  END IF;&#10;&#10;  GRUPO := CREATE_GROUP_FROM_QUERY('GRUPO', V_CONSULTA);&#10;  ERRO   := POPULATE_GROUP(GRUPO);&#10;&#10;  IF ERRO = 1403 THEN&#10;    --A consulta não retornou dados.&#10;     O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12065, NULL);&#10;    RETURN; &#10;  ELSIF ERRO NOT IN (0,1403) THEN&#10;    --Ocorreu um erro ao realizar a consulta conforme filtros/parâmetros informados. Erro: ¢SQLERRM¢.&#10;    O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(25697, '¢SQLERRM='||SQLERRM||'¢');&#10;    RETURN;      &#10;  END IF;&#10;&#10;  &#10;  GO_BLOCK('ITEMCOMPRACCUSTO');&#10;  CLEAR_BLOCK(NO_VALIDATE);&#10;  FIRST_RECORD;&#10;  FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO') LOOP&#10;  BEGIN    &#10;    BEGIN            &#10;      --Realiza a validação antes de inserir as colunas.&#10;      IF GET_GROUP_CHAR_CELL('GRUPO.CD_CENTROCUSTO',I) IS NOT NULL THEN      &#10;        V_CD_CENTROCUSTO := REPLACE(GET_GROUP_CHAR_CELL('GRUPO.CD_CENTROCUSTO',I),'.','');            &#10;        :ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO := NULL;&#10;        :ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO     := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.CD_NEGOCIO',I),'.',''));&#10;        IF(:ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO &#60;> 0)THEN&#10;          :ITEMCOMPRACCUSTO.ST_NEGOCIOPLANILHA  := 'S';&#10;        END IF;  &#10;        VALIDA_CENTROCUSTO(TO_NUMBER(V_CD_CENTROCUSTO),  :ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO,V_MENSAGEM);&#10;        IF(V_MENSAGEM IS NOT NULL) THEN &#10;          ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),V_MENSAGEM);  &#10;        ELSE                                                                     &#10;          :ITEMCOMPRACCUSTO.CD_CENTROCUSTO     := TO_NUMBER(V_CD_CENTROCUSTO);                                              &#10;          :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.CD_EMPRESA',I),'.',''));                         &#10;          &#10;            :ITEMCOMPRACCUSTO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#10;            :ITEMCOMPRACCUSTO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#10;            :ITEMCOMPRACCUSTO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#10;            :ITEMCOMPRACCUSTO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#10;            :ITEMCOMPRACCUSTO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;                  &#10;                    &#10;          &#10;          IF TO_NUMBER(GET_GROUP_CHAR_CELL('GRUPO.PC_PARTICIPACAO',I)) IS NULL THEN  &#10;            --O percentual  de participação deve ser informado.&#10;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3720, NULL);     &#10;            ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),V_MENSAGEM);          &#10;          ELSIF TO_NUMBER(GET_GROUP_CHAR_CELL('GRUPO.PC_PARTICIPACAO',I)) > 100 &#10;             OR TO_NUMBER(GET_GROUP_CHAR_CELL('GRUPO.PC_PARTICIPACAO',I)) &#60;= 0  THEN&#10;          --Total do Percentual de Participação deve estar entre 0 e 100%.&#10;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32801, NULL);           &#10;             ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),V_MENSAGEM);&#10;          ELSE            &#10;            :ITEMCOMPRACCUSTO.PC_PARTICIPACAO     := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.PC_PARTICIPACAO',I),'.',''));             &#10;            &#10;            IF :ITEMCOMPRACCUSTO.PC_PARTICIPACAO &#60;> 0  THEN                          &#10;              :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO / 100 ,3);                        &#10;            END IF;              &#10;              V_CD_MOVIMENTACAO := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.CD_MOVIMENTACAO',I),'.',''));                         &#10;               --Caso exista problema ao buscar a movimentação é considerada a movimentação da informada na tela inicial.&#10;               IF V_CD_MOVIMENTACAO &#60;> 0 AND V_CD_MOVIMENTACAO IS NOT NULL  THEN            &#10;                VALIDA_MOV_IMP(V_CD_MOVIMENTACAO,V_MENSAGEM);                           &#10;                IF(V_MENSAGEM IS NOT NULL)THEN&#10;                  :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO     :=   :ITEMCOMPRA.CD_MOVIMENTACAO;  &#10;                ELSE  &#10;                   :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO     := ZVL(TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.CD_MOVIMENTACAO',I),'.','')),:ITEMCOMPRA.CD_MOVIMENTACAO);                           &#10;                END IF;&#10;                ELSE &#10;                  :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO     :=   :ITEMCOMPRA.CD_MOVIMENTACAO;  &#10;              END IF;              &#10;            &#10;          IF TO_NUMBER(GET_GROUP_CHAR_CELL('GRUPO.QT_PARTICIPACAO',I)) &#60; 0 THEN&#10;            --O Peso ou Quantidade do item do pedido não pode ser negativo.&#10;            V_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(3282, NULL);&#10;            ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),V_MENSAGEM);  &#10;          ELSE &#10;            IF TO_NUMBER(GET_GROUP_CHAR_CELL('GRUPO.QT_PARTICIPACAO',I)) IS NOT NULL THEN&#10;              :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL    := ZVL(TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.QT_PARTICIPACAO',I),'.','')), :ITEMCOMPRA.QT_PREVISTA);                        &#10;            END IF;  &#10;          END IF;              &#10;          IF TO_NUMBER(GET_GROUP_CHAR_CELL('GRUPO.CD_NEGOCIO',I)) IS NOT NULL THEN            &#10;            VALIDA_NEGOCIO_IMP(TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.CD_NEGOCIO',I),'.','')),V_MENSAGEM);           &#10;            IF (V_MENSAGEM IS NOT NULL)THEN                      &#10;              ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),V_MENSAGEM);  &#10;            ELSE &#10;              :ITEMCOMPRACCUSTO.CD_NEGOCIO  := TO_NUMBER(REPLACE(GET_GROUP_CHAR_CELL('GRUPO.CD_NEGOCIO',I),'.',''));              &#10;            END IF;  &#10;          END IF;                  &#10;            END IF;                &#10;        END IF;                &#10;        ELSE           &#10;          V_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(292, NULL);&#10;          ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),V_MENSAGEM);  &#10;        END IF; --IF TO_NUMBER(GET_GROUP_CHAR_CELL('GRUPO.CD_CENTROCUSTO',I)) IS NOT NULL THEN    &#10;              &#10;    EXCEPTION&#10;    WHEN OTHERS THEN&#10;        ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),'Erro ao inserir registros');&#10;    END;          &#10;                       &#10;    EXCEPTION &#10;      WHEN OTHERS THEN&#10;        --Ocorreu erro no processamento do arquivo. Erro: ¢SQLERRM¢.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(26848, '¢SQLERRM='||SQLERRM||'¢');&#10;        ADD_LOG(GET_GROUP_NUMBER_CELL('GRUPO.NR_LINHA',I),V_MENSAGEM);&#10;    END;      &#10;    IF(:CONTROLE.DS_LOG IS NULL)THEN&#10;    -- EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END IF;  &#10;    &#10;  END LOOP;&#10;  &#10;  &#10;  BEGIN&#10;    DELETE FROM PARMREPORTSTMP&#10;    WHERE PARMREPORTSTMP.CD_MODULO   = :GLOBAL.CD_MODULO&#10;      AND PARMREPORTSTMP.CD_PROGRAMA = :GLOBAL.CD_PROGRAMA&#10;      AND PARMREPORTSTMP.CD_USUARIO  = :GLOBAL.CD_USUARIO               &#10;      AND PARMREPORTSTMP.NR_SID      = PACK_SESSAO.RETORNA_SID;    &#10;    FAZ_COMMIT;&#10;    &#10;    &#10;  IF :CONTROLE.DS_LOG IS NOT NULL THEN&#10;    O_MENSAGEM := 'Erro na importação do arquivo.';&#10;    return;&#10;  END IF;  &#10;    &#10;    &#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      NULL;&#10;  END;         &#10;    &#10;  ---------------------------------------------------------------------------------------------&#10;  ---------------------------------------------------------------------------------------------&#10;  -----------------------------------------------------------------------------------------------&#10;end; ">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_EMPCC">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_EMPCC (I_CD_EMPRESA IN NUMBER) IS&#10;BEGIN&#10;  null;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_CENTROCUSTO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_CENTROCUSTO (V_CD_CENTROCUSTO NUMBER,&#10;                              V_CD_NEGOCIO     NUMBER,&#10;                              O_MENSAGEM OUT VARCHAR2) IS&#10;BEGIN&#10;  /**FZA:15/02/2011:33648&#10;*** Ajustado tratamento de erros, as validacoes estavam aparecendo mais de uma vez.&#10;**/&#10;DECLARE&#10;  V_ST_VALIDACCUSTO PARMCOMPRA.ST_VALIDACCUSTO%TYPE;&#10;  V_CD_AUTORIZADOR  CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#10;  V_CD_USUARIO      CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#10;  V_ST_ATIVO        RESTRINGIRMOV.ST_ATIVO%TYPE;    &#10;  V_CD_MOVIMENTACAO  NUMBER;&#10;  V_MENSAGEM        VARCHAR2(2000);&#10;--  V_CD_EMPRESA      AUTORIZCCUSTORESTRITO.CD_EMPRESA%TYPE;&#10;  V_CD_AUTORICCUSTO  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#10;  V_CD_CENTROCUSTO  AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO%TYPE;&#10;  V_CD_AUTORICCUSTO2  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#10;--  V_ST_REGISTRO     AUTORIZCCUSTORESTRITO.ST_REGISTRO%TYPE;&#10;  &#10;BEGIN&#10;  IF V_CD_CENTROCUSTO IS NOT NULL THEN&#10;    --FJC:05/07/2018:121701&#10;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CC_USUARIO'),'N') = 'S'  THEN    &#10;       BEGIN&#10;        SELECT CCUSTOAUTORIZ.CD_USUARIO&#10;           INTO V_CD_USUARIO&#10;           FROM CENTROCUSTO, CCUSTOAUTORIZ&#10;          WHERE CENTROCUSTO.CD_CENTROCUSTO    = CCUSTOAUTORIZ.CD_CENTROCUSTO&#10;            AND CCUSTOAUTORIZ.CD_USUARIO      = :GLOBAL.CD_USUARIO&#10;            AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#10;            AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = V_CD_CENTROCUSTO&#10;            AND NVL(CENTROCUSTO.ST_CENTROCUSTO, 'A') = 'A';                   &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN          &#10;          --O Usuário ¢CD_USUARIO¢ não está autorizado para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;           V_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(3771,'¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');                      &#10;          WHEN TOO_MANY_ROWS THEN&#10;           V_CD_USUARIO := NULL;&#10;          WHEN OTHERS THEN               &#10;            --Ocorreu um erro inesperado na busca dos dados do usuário autorizador. Erro: ¢SQLERRM¢.&#10;           V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3958,'¢SQLERRM='||SQLERRM||'¢');           &#10;      END;            &#10;    END IF;&#10;        &#10;    IF V_MENSAGEM IS NOT NULL THEN  &#10;      O_MENSAGEM := O_MENSAGEM||V_MENSAGEM;&#10;      RETURN; &#10;    END IF;&#10;        &#10;    DECLARE&#10;      V_ST_CENTROCUSTO  CENTROCUSTO.ST_CENTROCUSTO%TYPE;&#10;      E_GERAL EXCEPTION;&#10;    BEGIN&#10;        &#10;      /**GRA:13783:27/12/2006&#10;       * O PROCEDIMENTO ABAIXO VERIFICA SE O CENTRO DE&#10;       * CUSTO ESTÁ CADASTRADO PARA A EMPRESA INFORMADA.&#10;       */ &#10;      PACK_VALIDA.VAL_CCUSTOEMPR(V_CD_CENTROCUSTO,&#10;                                 NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRACCUSTO.CD_EMPRESA),--GDG:22/07/2011:28715&#10;                                  :GLOBAL.CD_MODULO,&#10;                                  :GLOBAL.CD_PROGRAMA,&#10;                                  :ITEMCOMPRACCUSTO.DS_CENTROCUSTO,&#10;                                  V_MENSAGEM);           &#10;      IF V_MENSAGEM IS NOT NULL THEN  &#10;        O_MENSAGEM := O_MENSAGEM||V_MENSAGEM;&#10;        RETURN; &#10;      END IF;                                                                                    &#10;&#10;    &#10;      SELECT ST_CENTROCUSTO, DS_CENTROCUSTO&#10;        INTO V_ST_CENTROCUSTO, :ITEMCOMPRACCUSTO.DS_CENTROCUSTO &#10;        FROM CENTROCUSTO&#10;       WHERE CENTROCUSTO.CD_CENTROCUSTO = V_CD_CENTROCUSTO;&#10;       IF NVL(V_ST_CENTROCUSTO,'A') = 'I' THEN&#10;           --O centro de custo ¢CD_CENTROCUSTO¢ encontra-se inativo e não pode ser usado. Verifique TCB007.&#10;           O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1509,'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');&#10;           :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;           &#10;           RETURN;&#10;       END IF;&#10;     &#10;    EXCEPTION&#10;      WHEN E_GERAL THEN&#10;        O_MENSAGEM := V_MENSAGEM;&#10;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#10;        RAISE FORM_TRIGGER_FAILURE;     &#10;      WHEN NO_DATA_FOUND THEN&#10;        --O Centro de Custo ¢CD_CENTROCUSTO¢ não está cadastrado. Verifique o programa TCB007.&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(254,'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');&#10;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#10;        :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;                &#10;        RETURN;&#10;      WHEN OTHERS THEN&#10;        --Ocorreu um erro inesperado ao consultar os dados do centro de custo ¢CD_CENTROCUSTO¢. Erro: ¢SQLERRM¢.&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(999,'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢SQLERREM='||SQLERRM||'¢');              &#10;        RETURN;&#10;    END;&#10; &#10; -----------------------------------------------------------------------------------------------------------------&#10; --VALIDA CENTRO DE CUSTO&#10; -----------------------------------------------------------------------------------------------------------------&#10;   IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;    DECLARE&#10;      E_GERAL  EXCEPTION;&#10;    BEGIN       &#10;      SELECT NVL(ST_VALIDACCUSTO,'N')&#10;        INTO V_ST_VALIDACCUSTO&#10;        FROM PARMCOMPRA&#10;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA;&#10;        /* CSL:22264:30/06/09 - COMPARAÇÃO INADEQUADA */&#10;        --IF V_ST_VALIDACCUSTO = 'S' THEN&#10;        IF V_ST_VALIDACCUSTO = 'C' THEN        &#10;         BEGIN&#10;          SELECT CCUSTOAUTORIZ.CD_USUARIO&#10;             INTO V_CD_AUTORIZADOR&#10;             FROM CCUSTOAUTORIZ&#10;            WHERE CCUSTOAUTORIZ.CD_USUARIO      = :CONTROLE.CD_AUTORIZADOR&#10;              AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)--GDG:22/07/2011:28715&#10;              AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = V_CD_CENTROCUSTO&#10;             AND CCUSTOAUTORIZ.TP_AUTORIZADOR  IN ('A','S','T');          &#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            --O Usuário ¢CD_USUARIO¢ não está autorizado para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;             O_MENSAGEM :=  PACK_MENSAGEM.MENS_PADRAO(3771,'¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR ||' - '||:CONTROLE.NM_USUAUTORIZ||&#10;                                                          '¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');&#10;             :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#10;             :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#10;             RETURN;         &#10;            WHEN OTHERS THEN&#10;              --Ocorreu um erro inesperado na busca dos dados do usuário autorizador. Erro: ¢SQLERRM¢.&#10;             O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3958,'¢SQLERRM='||SQLERRM||'¢');&#10;             RETURN;&#10;        END;&#10;        END IF; &#10;      &#10;  /*     BEGIN --eml:13/01/2019:139947         &#10;         SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                               &#10;           INTO  V_CD_AUTORICCUSTO&#10;            FROM AUTORIZCCUSTORESTRITO&#10;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#10;           --  AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#10;              AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = :ITEMCOMPRACCUSTO.CD_EMPRESA&#10;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = 'S'; &#10;&#10;           IF(V_CD_AUTORICCUSTO IS  NOT NULL)THEN&#10;             IF(:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NOT NULL)THEN&#10;                SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR                               &#10;                INTO V_CD_AUTORICCUSTO&#10;                 FROM AUTORIZCCUSTORESTRITO&#10;                WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#10;                  AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :ITEMCOMPRACCUSTO.CD_AUTORIZADOR&#10;                   AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = :ITEMCOMPRACCUSTO.CD_EMPRESA&#10;                  AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = 'S';&#10;               IF V_CD_AUTORICCUSTO IS NULL THEN           &#10;               --O Autorizador ¢CD_AUTORIZADOR¢ não tem permissão, para o centro de Custo  ¢CD_CENTROCUSTO¢  verifique TCO035.&#10;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢');&#10;              RETURN; &#10;             END IF;                   &#10;            ELSE &#10;              --Centro de Custo ¢CD_CENTROCUSTO¢ restrito, informe o Autorizador!&#10;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731,'¢SQLERRM='||SQLERRM||'¢');&#10;             RETURN;&#10;            END IF;      &#10;          END IF;           &#10;       END;   */&#10;       &#10;      IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947             &#10;       BEGIN  &#10;        SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                                        &#10;            INTO V_CD_AUTORICCUSTO&#10;            FROM AUTORIZCCUSTORESTRITO&#10;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO--EMLLL               &#10;              AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#10;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = 'S';               &#10;         EXCEPTION &#10;           WHEN OTHERS THEN             &#10;            V_CD_AUTORICCUSTO := NULL;                                     &#10;         END;           &#10;        IF V_CD_AUTORICCUSTO IS NOT NULL THEN           &#10;          IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN                                             &#10;          /*O autorizador da tela principal deve ser informado.*/&#10;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33735, NULL);&#10;            RETURN;          &#10;          END IF;&#10;          &#10;        BEGIN           &#10;          SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#10;            INTO V_CD_AUTORICCUSTO2&#10;            FROM AUTORIZCCUSTORESTRITO&#10;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO            &#10;            AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#10;             AND AUTORIZCCUSTORESTRITO.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#10;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO     = 'S';             &#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;               O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');  &#10;          RETURN;          &#10;        END;  &#10;       END IF;    &#10;    END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN     &#10;   &#10;    EXCEPTION      &#10;      WHEN E_GERAL THEN&#10;        O_MENSAGEM := V_MENSAGEM;&#10;        RETURN;&#10;       WHEN NO_DATA_FOUND THEN &#10;         NULL;  &#10;            &#10;       WHEN TOO_MANY_ROWS THEN&#10;         V_MENSAGEM := 'A consulta retornou mais de uma empresa para esta condição.';&#10;        RETURN;&#10;      WHEN OTHERS THEN&#10;        V_MENSAGEM := 'Erro inesperado: '||SQLERRM;&#10;        RETURN;&#10;    END;  &#10;   END IF; --IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN  &#10;   IF V_CD_NEGOCIO = 0 THEN&#10;    /**CSL:21/12/2010:30317&#10;     * Adicionado campo cd_negocio para permitir ou não que o usuário altere o negócio para o qual &#10;     * vai ser destinado o valor do centro de custo, de acordo com o status do parametro ST_NEGOCIOCCUSTO (N - Negado, S - Permitido) do CTI010.&#10;     */   &#10;    BEGIN&#10;      SELECT CENTROCUSTO.CD_NEGOCIO,&#10;             NEGOCIO.DS_NEGOCIO&#10;        INTO :ITEMCOMPRACCUSTO.CD_NEGOCIO,&#10;             :ITEMCOMPRACCUSTO.DS_NEGOCIO&#10;        FROM CENTROCUSTO, NEGOCIO&#10;       WHERE CENTROCUSTO.CD_NEGOCIO     = NEGOCIO.CD_NEGOCIO&#10;         AND CENTROCUSTO.CD_CENTROCUSTO = V_CD_CENTROCUSTO;&#10;      &#10;      IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('CTI',10,'MAX',100,'ST_NEGOCIOCCUSTO'),'N') = 'N' THEN&#10;        SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',ENABLED,PROPERTY_FALSE);&#10;        SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');  &#10;      ELSE&#10;        SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',ENABLED,PROPERTY_TRUE);&#10;        SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');  &#10;      END IF;&#10;    &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(5243,'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');--Nenhum negócio associado ao centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCB007.&#10;        RETURN;&#10;      WHEN TOO_MANY_ROWS THEN&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6306,'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');--Existe mais de um negócio associado ao centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCB007.&#10;        RETURN;&#10;      WHEN OTHERS THEN&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(6307,'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢SQLERRM='||SQLERRM||'¢');--Ocorreu um erro inesperado ao tentar localizar o código de negócio associado ao Centro de Custo ¢CD_CENTROCUSTO¢. Erro: ¢SQLERRM¢.&#10;        RETURN;&#10;    END;&#10;    END IF;    &#10;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  V_CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#10;    --VALIDA_CONTA_ORCAMENTO('ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO', :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, V_CD_CENTROCUSTO);&#10;      VALIDA_ORCAMENTO_IMP('ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO', NVL(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, :ITEMCOMPRA.CD_MOVIMENTACAO),V_CD_CENTROCUSTO, V_MENSAGEM);    &#10;      IF V_MENSAGEM IS NOT NULL THEN  &#10;        O_MENSAGEM := O_MENSAGEM||V_MENSAGEM;&#10;        RETURN; &#10;      END IF;&#10;    END IF;&#10;  &#10;  ELSE &#10;    :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#10;  END IF;&#10;&#10;-----------------------------------------------------------------------------------------------------------------&#10;--VALIDA SE A MOVIMENTAÇÃO POSSUI RESTRIÇÃO PARA O CENTRO DE CUSTO (TCB053)&#10;--AUG:122414:24/05/2018&#10;-----------------------------------------------------------------------------------------------------------------      &#10;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NOT NULL AND&#10;       V_CD_CENTROCUSTO  IS NOT NULL THEN&#10;    &#10;      /*RETORNO: S = POSSUI RESTRIÇÃO&#10;       *          N = NÃO POSSUI RESTRIÇÃO CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#10;       */&#10;        &#10;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#10;                                                      V_CD_CENTROCUSTO);&#10;                                                                                                           &#10;      IF NVL(V_ST_ATIVO,'N') = 'S' THEN&#10;        V_CD_MOVIMENTACAO := :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO;&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, '¢CD_MOVIMENTACAO='||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');&#10;        RETURN;&#10;      END IF;&#10;    END IF;  &#10;      &#10;    IF V_CD_CENTROCUSTO  IS NOT NULL AND&#10;       :ITEMCOMPRA.CD_MOVIMENTACAO       IS NOT NULL THEN&#10;         &#10;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRA.CD_MOVIMENTACAO,&#10;                                                      V_CD_CENTROCUSTO);&#10;                                                                            &#10;      IF NVL(V_ST_ATIVO,'N') = 'S' THEN&#10;        O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, '¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='||V_CD_CENTROCUSTO||'¢');&#10;         RETURN;&#10;      END IF;&#10;    END IF;    &#10;END;&#10;END;&#10;      &#10;&#10;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_ORCAMENTO_IMP">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_ORCAMENTO_IMP(I_TRIGGER_ITEM    IN VARCHAR2, &#10;                               I_CD_MOVIMENTACAO IN NUMBER,                   &#10;                               I_CD_CENTROCUSTO  IN VARCHAR2,                               &#10;                               O_MENSAGEM OUT VARCHAR) IS&#10;BEGIN&#10;     ----Valida Oraçamento&#10;        IF PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,'COMPRAS') = 'S' AND &#10;         PACK_ORC051.RETORNA_TIPO_ORCAMENTO(SYSDATE) = 'O' AND &#10;         NVL(PACK_PARMGEN.CONSULTA_PARAMETRO ('ORC',50,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CONTAORCCOMPRAS'),'N') = 'S' THEN      &#10;        BEGIN&#10;          SELECT HISTCONTB.CD_CONTACONTABIL&#10;            INTO :CONTROLE.CD_CONTACONTABIL&#10;            FROM PARMOVIMENT,&#10;                 HISTCONTB&#10;           WHERE PARMOVIMENT.CD_MOVIMENTACAO = I_CD_MOVIMENTACAO&#10;             AND PARMOVIMENT.CD_HISTCONTB     = HISTCONTB.CD_HISTCONTB;&#10;             &#10;          :CONTROLE.CD_CONTAORCAMENTO := NULL;&#10;                &#10;          BEGIN &#10;            SELECT R.CD_CONTAORCAMENTO&#10;              INTO :CONTROLE.CD_CONTAORCAMENTO&#10;              FROM RELACAOCONTASORCCTB R, PLANOCONTASORCAMENTO P , PLANOCONTABIL&#10;             WHERE R.CD_CONTACONTABIL  = :CONTROLE.CD_CONTACONTABIL                           &#10;               AND R.CD_CONTAORCAMENTO = P.CD_CONTAORCAMENTO&#10;               AND R.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#10;               AND ((I_CD_CENTROCUSTO IS NOT NULL &#10;                     AND EXISTS (SELECT PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO&#10;                                   FROM PLANOCONTASORCAMENTOCUSTO&#10;                                  WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO&#10;                                    AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO    = I_CD_CENTROCUSTO&#10;                                  )) &#10;                   OR&#10;                   (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL &#10;                     AND 0 = (SELECT COUNT(PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO)&#10;                                FROM PLANOCONTASORCAMENTOCUSTO&#10;                               WHERE PLANOCONTASORCAMENTOCUSTO.CD_CONTAORCAMENTO = R.CD_CONTAORCAMENTO &#10;                                 AND PLANOCONTASORCAMENTOCUSTO.CD_CENTROCUSTO IS NULL))                                                               &#10;                                );   &#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              :CONTROLE.CD_CONTAORCAMENTO := NULL;&#10;              O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(28965, '¢CD_CONTACONTABIL='||:CONTROLE.CD_CONTACONTABIL||'¢CD_CENTROCUSTO='||NVL(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO,'Não Informado')||'¢');&#10;              RETURN;&#10;            WHEN TOO_MANY_ROWS THEN&#10;              LOOP&#10;                IF SHOW_LOV('LOV_CONTAORC') THEN&#10;                  EXIT;&#10;                END IF;&#10;              END LOOP;              &#10;          END;&#10;              &#10;          IF :CONTROLE.CD_CONTAORCAMENTO IS NOT NULL THEN&#10;            COPY(:CONTROLE.CD_CONTAORCAMENTO, I_TRIGGER_ITEM);&#10;          END IF;    &#10;          &#10;             &#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            NULL;&#10;        END;    &#10;      END IF;                           &#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_MOV_IMP">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_MOV_IMP(V_CD_MOVIMENTACAO NUMBER, &#10;                         O_DS_MENSAGEM OUT VARCHAR2) IS&#10;BEGIN&#10;  DECLARE&#10;  V_TP_PEDIDO    PARMOVIMENT.TP_PEDIDO%TYPE; --PHS:60051:11/07/2013&#10;  I_CD_NATUREZA  PLANOCONTABIL.CD_NATUREZA%TYPE;&#10;  I_MENSAGEM     VARCHAR2(32000);&#10;  I_RETORNO       VARCHAR2(01);&#10;  V_ST_ATIVO     RESTRINGIRMOV.ST_ATIVO%TYPE;&#10;  E_GERAL        EXCEPTION;&#10;BEGIN&#10;&#10;  IF V_CD_MOVIMENTACAO IS NOT NULL THEN&#10;      IF PACK_GLOBAL.TP_SELECAOCONTA = 'O' THEN&#10;        /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padrão da função VALIDA_SELECAOCONTA quando for 'CO'*/&#10;        I_MENSAGEM := VALIDA_SELECAOCONTA (NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:CONTROLE.CD_EMPRESA),&#10;                                           :ITEMCOMPRACCUSTO.CD_ITEM,&#10;                                           V_CD_MOVIMENTACAO, &#10;                                           NULL, 'CO');    &#10;        IF (I_MENSAGEM IS NOT NULL) AND (I_MENSAGEM &#60;> 'S') THEN&#10;          O_DS_MENSAGEM := I_MENSAGEM;&#10;          RETURN;&#10;        END IF;&#10;      END IF;&#10;      &#10;      /* CSL:02/12/2013:64869&#10;       * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO para não permitir realizar lançamentos em contas, &#10;       * que não pertencem a versão do plano de contas da empresa do lançamento.&#10;       */&#10;      PACK_VALIDA.VALIDA_CONTABIL_PLANO(V_CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:GLOBAL.CD_EMPRESA), I_MENSAGEM);&#10;    &#10;      IF I_MENSAGEM IS NOT NULL THEN&#10;        O_DS_MENSAGEM := I_MENSAGEM;&#10;        RETURN;&#10;      END IF;&#10;      &#10;      BEGIN&#10;        /*CSL:30/12/2013:64869*/&#10;        IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;                 PLANOCONTABIL.CD_NATUREZA,&#10;                 PARMOVIMENT.TP_PEDIDO&#10;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#10;                 I_CD_NATUREZA,&#10;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#10;            FROM PARMOVIMENT,HISTCONTB,PLANOCONTABIL&#10;           WHERE PARMOVIMENT.CD_MOVIMENTACAO    = V_CD_MOVIMENTACAO&#10;             AND HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#10;             AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#10;             AND PLANOCONTABIL.TP_CONTACONTABIL = 'CC';&#10;        &#10;        ELSE&#10;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;                 PLANOCONTABILVERSAO.CD_NATUREZA,&#10;                 PARMOVIMENT.TP_PEDIDO&#10;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#10;                 I_CD_NATUREZA,&#10;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#10;            FROM PARMOVIMENT, HISTCONTB, PLANOCONTABILVERSAO&#10;           WHERE PARMOVIMENT.CD_MOVIMENTACAO           = V_CD_MOVIMENTACAO&#10;             AND HISTCONTB.CD_HISTCONTB                = PARMOVIMENT.CD_HISTCONTB&#10;             AND PLANOCONTABILVERSAO.CD_CONTACONTABIL  = HISTCONTB.CD_CONTACONTABIL&#10;             AND PLANOCONTABILVERSAO.TP_CONTACONTABIL  = 'CC'&#10;             AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#10;                 PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));  &#10;        END IF;&#10;        &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          --Movimentação ¢CD_MOVIMENTACAO¢ não cadastrada, não é de compra ou não é de Centro de Custo. Verifique TCB008.&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3775,'¢CD_MOVIMENTACAO='||V_CD_MOVIMENTACAO||'¢');&#10;          O_DS_MENSAGEM := I_MENSAGEM;&#10;          RETURN;      &#10;      END;&#10;    &#10;      --PHS:60051:11/07/2013&#10;      IF V_TP_PEDIDO &#60;> PACK_GLOBAL.TP_PEDIDO THEN&#10;        --A movimentação ¢CD_MOVIMENTACAO¢ possui o tipo de pedido ¢TP_PEDIDO¢ diferente do tipo de pedido ¢TP_CADPEDIDO¢ cadastrado para o programa. Verificar os programas TCB008 e ANV008.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20737,'¢CD_MOVIMENTACAO='||V_CD_MOVIMENTACAO||'¢TP_PEDIDO='||V_TP_PEDIDO||'¢TP_CADPEDIDO='||PACK_GLOBAL.TP_PEDIDO||'¢'); &#10;        O_DS_MENSAGEM := I_MENSAGEM;&#10;        RETURN;&#10;      END IF;  &#10;    &#10;      /*CLM:22/08/2014:76468 &#10;      IF NATUREZA_CENTROCUSTO(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO) &#60;> I_CD_NATUREZA THEN&#10;        --A Movimentação ¢CD_MOVIMENTACAO¢ não é compatível com o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCB008.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3776,'¢CD_MOVIMENTACAO='||V_CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;*/&#10;      &#10;      I_RETORNO := RETORNA_NATUREZA (V_CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO,:GLOBAL.CD_EMPRESA); /*CSL:03/10/2013:62738*/&#10;      IF I_RETORNO = 'I' THEN&#10;        --A natureza do Centro de Custo ¢CD_CENTROCUSTO¢ é incompatível com a natureza da Movimentação ¢CD_MOVIMENTACAO¢. Verifique TCB007 e TCB008.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20318, '¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢CD_MOVIMENTACAO='||V_CD_MOVIMENTACAO||'¢');&#10;        O_DS_MENSAGEM := I_MENSAGEM;&#10;        RETURN;&#10;      END IF;&#10;    &#10;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#10;      VALIDA_ORCAMENTO_IMP('ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO', :ITEMCOMPRA.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO, I_MENSAGEM);&#10;      IF (I_MENSAGEM  IS NOT NULL)THEN&#10;        O_DS_MENSAGEM := I_MENSAGEM;&#10;        RETURN;&#10;      END IF; &#10;    END IF;&#10;          &#10;  ELSE&#10;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#10;  END IF;&#10;-----------------------------------------------------------------------------------------------------------------&#10;--VALIDA SE A MOVIMENTAÇÃO POSSUI RESTRIÇÃO PARA O CENTRO DE CUSTO (TCB053)&#10;--AUG:122414:24/05/2018&#10;-----------------------------------------------------------------------------------------------------------------      &#10;      IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#10;      &#10;       /*RETORNO: S = POSSUI RESTRIÇÃO&#10;        *          N = NÃO POSSUI RESTRIÇÃO CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#10;        */&#10;        &#10;        V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(V_CD_MOVIMENTACAO,&#10;                                                            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;        IF NVL(V_ST_ATIVO,'N') = 'S' THEN&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, '¢CD_MOVIMENTACAO='||V_CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;          O_DS_MENSAGEM := I_MENSAGEM;&#10;          RETURN;&#10;        END IF;&#10;      END IF;                      &#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#10;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#10;    O_DS_MENSAGEM := I_MENSAGEM;&#10;    RETURN;&#10;  WHEN OTHERS THEN&#10;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#10;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#10;    O_DS_MENSAGEM := 'Maxys COM001 - Erro'||SQLERRM;&#10;    RETURN;&#10;END;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_NEGOCIO_IMP">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_NEGOCIO_IMP(V_CD_NEGOCIO NUMBER, &#10;                             O_DS_MENSAGEM OUT VARCHAR2 ) IS&#10;BEGIN&#10;  BEGIN&#10;  IF :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN  &#10;    SELECT DS_NEGOCIO&#10;      INTO :ITEMCOMPRANEGOCIO.DS_NEGOCIO&#10;      FROM NEGOCIO&#10;     WHERE NEGOCIO.CD_NEGOCIO = :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#10;     &#10;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#10;      VALIDA_CONTA_ORCAMENTO('ITEMCOMPRANEGOCIO.CD_CONTAORCAMENTO', :ITEMCOMPRA.CD_MOVIMENTACAO, null,:ITEMCOMPRANEGOCIO.CD_NEGOCIO);&#10;    END IF; &#10;  ELSE&#10;    :ITEMCOMPRANEGOCIO.DS_NEGOCIO := NULL;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    O_DS_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(147,'¢CD_NEGOCIO='||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||'¢');--O Negócio ¢CD_NEGOCIO¢ não está cadastrado. Verifique o programa TCB001.&#10;    RETURN;&#10;  WHEN TOO_MANY_ROWS THEN&#10;   O_DS_MENSAGEM :=   PACK_MENSAGEM.MENS_PADRAO(148,'¢CD_NEGOCIO='||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||'¢');--O Negócio ¢CD_NEGOCIO¢ está cadastrado várias vezes. Verifique o programa TCB001.&#10;   RETURN;&#10;  WHEN OTHERS THEN&#10;    O_DS_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(149,'¢CD_NEGOCIO='||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||'¢SQLERRM='||SQLERRM||'¢');--Ocorreu um erro inesperado ao consultar os dados do código de Negócio ¢CD_NEGOCIO¢. Erro: ¢SQLERRM¢.&#10;    RETURN;&#10;END;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="MSG_CONFIRMACAO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="FUNCTION MSG_CONFIRMACAO (V_DESCRICAO IN VARCHAR2) RETURN BOOLEAN IS&#10;  RETORNO NUMBER; &#10;BEGIN&#10;    /*&#10;    V_MENSAGEM := 'Já Existem Dados Gravados Para Este Período,
</node>
</node>
</node>
<node FOLDED="true" TEXT="VALIDA_AUTORIZADORCOMPRA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE VALIDA_AUTORIZADORCOMPRA(I_CD_AUTORIZADOR VARCHAR2, &#10;                                    O_MENSAGEM OUT VARCHAR2)    IS&#10;                                  &#10;BEGIN &#10;  DECLARE&#10;  E_GERAL EXCEPTION;&#10;  V_VALIDOU VARCHAR2(1);&#10;BEGIN      &#10;    IF   I_CD_AUTORIZADOR IS NOT NULL THEN &#10;      V_VALIDOU := 'N';&#10;  /*    BEGIN&#10;        SELECT USUARIO.NM_USUARIO &#10;          INTO :ITEMCOMPRA.NM_USUAUTORIZ &#10;          FROM USUARIO&#10;         WHERE USUARIO.CD_USUARIO = I_CD_AUTORIZADOR;&#10;      EXCEPTION                      &#10;        WHEN NO_DATA_FOUND THEN  /&#10;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32765, NULL);&#10;        --  mensagem('Maxys','Autorizador não cadastrado',2);&#10;          RAISE E_GERAL;&#10;      END;  */&#10;      /** WLV:22/08/2012:41514&#10;        * Adicionado o DISTINCT na consulta, pois quando ha um usuário autorizador mais de uma vez cadastrada para mesma &#10;        * empresa com grupos diferentes estourava TOO_MANY_ROWS.&#10;        */    &#10;      BEGIN  &#10;        SELECT DISTINCT USUARIO.NM_USUARIO&#10;          INTO :ITEMCOMPRA.NM_USUAUTORIZ&#10;          FROM SOLICITANTE, &#10;               PARMCOMPRA,&#10;               USUARIO &#10;         WHERE SOLICITANTE.CD_EMPRESA     = PARMCOMPRA.CD_EMPRESA&#10;           AND USUARIO.CD_USUARIO         = SOLICITANTE.CD_USUARIO&#10;           AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.TP_APROVSOLIC&#10;           AND SOLICITANTE.CD_USUARIO     = I_CD_AUTORIZADOR &#10;           AND PARMCOMPRA.CD_EMPRESA      = :GLOBAL.CD_EMPRESA;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN          &#10;          --O Usuário Informado ¢CD_USUARIO¢ não é um Autorizador Cadastrado para a empresa ¢CD_EMPRESA¢. Verifique TCO002.          &#10;          O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4737, '¢CD_USUARIO='||I_CD_AUTORIZADOR||'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');             &#10;          RETURN;&#10;      END;  &#10;    ELSE &#10;      :ITEMCOMPRA.NM_USUAUTORIZ:=NULL;&#10;    END IF;    &#10;EXCEPTION                      &#10;    WHEN E_GERAL THEN&#10;      RETURN;&#10;    WHEN OTHERS THEN&#10;      O_MENSAGEM :=  'Maxys COM001 - Erro'||SQLERRM;&#10;      RETURN;&#10;END;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="INFORMA_PROJETO">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PROCEDURE INFORMA_PROJETO (I_CD_EMPRESA IN NUMBER, O_MENSAGEM OUT VARCHAR2) IS&#10;/*GBO:13/09/19:138077*/&#10;  I_PARAMETROS            PARAMLIST;   &#10;  E_SAIDA                  EXCEPTION;&#10;  V_COUNT                  NUMBER;&#10;  V_CD_CCUSTO             NUMBER;&#10;  V_VT_REGISTRO           PACK_PROJETOMONI.REG_REGISTRO;&#10;  V_POSVET                NUMBER;&#10;  V_NR_CONTROLE           NUMBER;&#10;  V_DS_CCUSTO             VARCHAR2(32000);&#10;  &#10;  /*CURSOR CUR_DADOS_PROJETO (C_CD_CENTRODECUSTO  IN NUMBER)IS&#10;      SELECT PROJETORATEIO.NR_SEQUENCIAL,&#10;             PROJETORATEIO.CD_PROJETO,&#10;             PROJETORATEIO.CD_ESTUDO,&#10;             ESTUDOMONI.DS_ESTUDO,&#10;             ESTUDOMONI.NM_ESTUDO,&#10;             PROJETORATEIO.CD_ETAPA,&#10;             ETAPAMONI.DS_ETAPA,&#10;             PROJETORATEIO.VL_RATEIO,&#10;             PROJETORATEIO.NR_VERSAO,&#10;             PROJETORATEIO.PC_RATEIO,&#10;             PROJETORATEIO.NR_ITEMCOMPRA,&#10;             PROJETORATEIO.NR_LOTECOMPRA&#10;        FROM PROJETORATEIO,&#10;             ESTUDOMONI,&#10;             ETAPAMONI,&#10;             PROJETOMONI,&#10;             CENTROCUSTOMONI&#10;       WHERE PROJETOMONI.CD_ESTUDO           = ESTUDOMONI.CD_ESTUDO&#10;         AND PROJETOMONI.CD_PROJETO          = ETAPAMONI.CD_PROJETO&#10;         AND PROJETOMONI.CD_ESTUDO           = ETAPAMONI.CD_ESTUDO&#10;         AND PROJETOMONI.NR_VERSAO           = ETAPAMONI.NR_VERSAO&#10;         AND PROJETORATEIO.CD_ETAPA          = ETAPAMONI.CD_ETAPA&#10;         AND PROJETORATEIO.CD_PROJETO        = PROJETOMONI.CD_PROJETO&#10;         AND PROJETORATEIO.CD_ESTUDO         = PROJETOMONI.CD_ESTUDO&#10;         AND PROJETORATEIO.NR_VERSAO         = PROJETOMONI.NR_VERSAO&#10;         AND PROJETORATEIO.CD_CENTROCUSTO    = CENTROCUSTOMONI.CD_CENTROCUSTO&#10;         AND CENTROCUSTOMONI.ST_ATIVA        = 1&#10;         AND PROJETORATEIO.CD_EMPRITEMCOMPRA = NVL(I_CD_EMPRESA,:GLOBAL.CD_EMPRESA)&#10;         AND PROJETORATEIO.NR_ITEMCOMPRA     = :ITEMCOMPRA.NR_ITEMCOMPRA&#10;         --AND NVL(PROJETORATEIO.NR_LOTECOMPRA,-1)= I_NR_LOTECOMPRA&#10;         AND PROJETORATEIO.CD_CENTROCUSTO    = C_CD_CENTRODECUSTO;*/&#10;  &#10;BEGIN  &#10;  IF PACK_PARMGEN.CONSULTA_PARAMETRO('COM', 9, 'MAX', NVL(I_CD_EMPRESA,:GLOBAL.CD_EMPRESA), 'ST_PROJETOMONI') = 'S' AND &#10;     PACK_PARMGEN.CONSULTA_PARAMETRO('COM', 9, 'MAX', NVL(I_CD_EMPRESA,:GLOBAL.CD_EMPRESA), 'ST_PRJETORATEIO') = 'S' THEN&#10;     &#10;    V_COUNT  := 0;  &#10;    -- VALIDA SE ALGUM REGISTRO HAVERA RATEIO.&#10;    GO_BLOCK('ITEMCOMPRA');&#10;    FIRST_RECORD;&#10;    LOOP  &#10;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL AND :ITEMCOMPRA.TP_CONTACONTABIL = 'CC' THEN         &#10;         FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_CC') LOOP&#10;          IF GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM', I) = :ITEMCOMPRA.CD_ITEM THEN&#10;            V_CD_CCUSTO := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO', I);    &#10;            &#10;            BEGIN&#10;              SELECT COUNT(1)&#10;                INTO V_COUNT&#10;                FROM CENTROCUSTOMONI,&#10;                     MOVIMENTACAOGRUPOMONI&#10;               WHERE CENTROCUSTOMONI.ST_ATIVA       = 1&#10;                 AND CENTROCUSTOMONI.CD_CENTROCUSTO = V_CD_CCUSTO&#10;                 AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;                 AND EXISTS ( SELECT *&#10;                                FROM PROJETOCENTROCUSTOMONI,PROJETOMONI&#10;                               WHERE CENTROCUSTOMONI.CD_CENTROCUSTO    = PROJETOCENTROCUSTOMONI.CD_CENTROCUSTO &#10;                                 AND PROJETOCENTROCUSTOMONI.CD_PROJETO     = PROJETOMONI.CD_PROJETO     &#10;                                 AND PROJETOCENTROCUSTOMONI.CD_ESTUDO      = PROJETOMONI.CD_ESTUDO      &#10;                                 AND PROJETOCENTROCUSTOMONI.NR_VERSAO      = PROJETOMONI.NR_VERSAO &#10;                                 AND PROJETOMONI.ST_ATIVA                  = 1&#10;                                 AND PROJETOMONI.ST_ESTADO                 IN (5,6,7));&#10;            EXCEPTION&#10;              WHEN OTHERS THEN&#10;                V_COUNT := 0;&#10;            END;&#10;            &#10;            EXIT WHEN V_COUNT > 0;  &#10;          END IF;&#10;        END LOOP;        &#10;        EXIT WHEN V_COUNT > 0;  &#10;      END IF;   &#10;      GO_BLOCK('ITEMCOMPRA');           &#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';    &#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    IF NVL(V_COUNT, 0) > 0 THEN &#10;          &#10;      PACK_PROJETOMONI.LIMPA_CACHE;&#10;      &#10;      V_COUNT       := 0;&#10;      V_NR_CONTROLE := 0;&#10;      -- VALIDA SE ALGUM REGISTRO HAVERA RATEIO.&#10;      GO_BLOCK('ITEMCOMPRA');&#10;      FIRST_RECORD;&#10;      LOOP  &#10;        IF :ITEMCOMPRA.CD_ITEM IS NOT NULL AND :ITEMCOMPRA.TP_CONTACONTABIL = 'CC'  THEN         &#10;           &#10;           FOR I IN 1 ..GET_GROUP_ROW_COUNT('GRUPO_CC') LOOP&#10;            IF GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_ITEM', I) = :ITEMCOMPRA.CD_ITEM THEN&#10;              V_CD_CCUSTO := GET_GROUP_NUMBER_CELL('GRUPO_CC.CD_CENTROCUSTO', I);    &#10;              &#10;              BEGIN&#10;                SELECT COUNT(1)&#10;                  INTO V_COUNT&#10;                  FROM CENTROCUSTOMONI,&#10;                       MOVIMENTACAOGRUPOMONI&#10;                 WHERE CENTROCUSTOMONI.ST_ATIVA       = 1&#10;                   AND CENTROCUSTOMONI.CD_CENTROCUSTO = V_CD_CCUSTO&#10;                   AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;                   AND EXISTS ( SELECT *&#10;                                FROM PROJETOCENTROCUSTOMONI,PROJETOMONI&#10;                               WHERE CENTROCUSTOMONI.CD_CENTROCUSTO    = PROJETOCENTROCUSTOMONI.CD_CENTROCUSTO &#10;                                 AND PROJETOCENTROCUSTOMONI.CD_PROJETO     = PROJETOMONI.CD_PROJETO     &#10;                                 AND PROJETOCENTROCUSTOMONI.CD_ESTUDO      = PROJETOMONI.CD_ESTUDO      &#10;                                 AND PROJETOCENTROCUSTOMONI.NR_VERSAO      = PROJETOMONI.NR_VERSAO &#10;                                 AND PROJETOMONI.ST_ATIVA                  = 1&#10;                                 AND PROJETOMONI.ST_ESTADO                 IN (5,6,7));&#10;              EXCEPTION&#10;                WHEN OTHERS THEN&#10;                  V_COUNT := 0;&#10;              END;&#10;                &#10;              --- PREECNHE VETOR&#10;              IF V_COUNT > 0 THEN&#10;                BEGIN&#10;                  SELECT DS_CENTROCUSTO&#10;                    INTO V_DS_CCUSTO&#10;                    FROM CENTROCUSTO &#10;                   WHERE CD_CENTROCUSTO = V_CD_CCUSTO;&#10;                EXCEPTION&#10;                  WHEN OTHERS THEN&#10;                    V_DS_CCUSTO := NULL;&#10;                END;    &#10;                &#10;                IF :ITEMCOMPRA.NR_REGBLOCO IS NULL THEN&#10;                  PACK_PROCEDIMENTOS.NR_REGBLOCO := NVL(PACK_PROCEDIMENTOS.NR_REGBLOCO,0) + 1;&#10;                  :ITEMCOMPRA.NR_REGBLOCO        := PACK_PROCEDIMENTOS.NR_REGBLOCO;&#10;                END IF;  &#10;                &#10;                V_NR_CONTROLE := NVL(V_NR_CONTROLE,0) + 1;&#10;                V_POSVET      := NVL(V_VT_REGISTRO.COUNT,0) + 1;&#10;                &#10;                V_VT_REGISTRO(V_POSVET).NR_CONTROLE       := V_NR_CONTROLE;&#10;                V_VT_REGISTRO(V_POSVET).NR_ITEMCOMPRA     := 0;&#10;                V_VT_REGISTRO(V_POSVET).CD_ITEM           := :ITEMCOMPRA.CD_ITEM;&#10;                V_VT_REGISTRO(V_POSVET).DS_ITEM           := :ITEMCOMPRA.DS_ITEM;&#10;                V_VT_REGISTRO(V_POSVET).CD_UNIDMED        := :ITEMCOMPRA.DS_UNIDMED;&#10;                V_VT_REGISTRO(V_POSVET).CD_EMPRESA        := NVL(I_CD_EMPRESA, :GLOBAL.CD_EMPRESA);&#10;                V_VT_REGISTRO(V_POSVET).CD_CENTROCUSTO    := V_CD_CCUSTO;&#10;                V_VT_REGISTRO(V_POSVET).DS_CENTROCUSTO    := V_DS_CCUSTO;&#10;                V_VT_REGISTRO(V_POSVET).QT_PEDIDAUNIDSOL  := GET_GROUP_NUMBER_CELL('GRUPO_CC.QT_PEDIDAUNIDSOL', I);&#10;                V_VT_REGISTRO(V_POSVET).PC_PARTICIPACAO   := GET_GROUP_NUMBER_CELL('GRUPO_CC.PC_PARTICIPACAO', I);&#10;                V_VT_REGISTRO(V_POSVET).NR_REGBLOCO       := :ITEMCOMPRA.NR_REGBLOCO;&#10;              &#10;              END IF;  &#10;            END IF;&#10;          END LOOP;        &#10;          &#10;        END IF;   &#10;        GO_BLOCK('ITEMCOMPRA');           &#10;        EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';    &#10;        NEXT_RECORD;&#10;      END LOOP;&#10;    &#10;      -- PREENCHE VETOR CC CUSTO REGISTRO&#10;       PACK_PROJETOMONI.SET_VETOR_REGISTRO(V_VT_REGISTRO, PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO);&#10;       &#10;      I_PARAMETROS := GET_PARAMETER_LIST('PARAMPROJETOETAPA');&#10;      IF (NOT ID_NULL(I_PARAMETROS)) THEN&#10;        DESTROY_PARAMETER_LIST(I_PARAMETROS);&#10;      END IF;&#10;      &#10;      I_PARAMETROS := CREATE_PARAMETER_LIST('PARAMPROJETOETAPA');&#10;      &#10;      --ADD_PARAMETER(I_PARAMETROS,'CD_EMPRITEMCOMPRA', TEXT_PARAMETER,I_CD_EMPRESA);&#10;      --ADD_PARAMETER(I_PARAMETROS,'NR_LOTEITEMCOMPRA', TEXT_PARAMETER,I_NR_LOTECOMPRA);&#10;      ADD_PARAMETER(I_PARAMETROS,'ST_VETOR', TEXT_PARAMETER,'S'); &#10;      &#10;      --:GLOBAL.ST_CANCELADOFORMSEL403 := 'FALSE';&#10;      CALL_FORM('SEL403', NO_HIDE ,NO_REPLACE, NO_QUERY_ONLY, I_PARAMETROS);&#10;      /**FLA:16/12/2019:140632&#10;       * Verificação de do botão cancelar na SEL403&#10;       */&#10;      /*IF NVL(:GLOBAL.ST_CANCELADOFORMSEL403, 'FALSE') = 'TRUE' THEN&#10;        O_MENSAGEM := 'TRUE';&#10;      END IF;  &#10;      ERASE('GLOBAL.ST_CANCELADOFORMSEL403');*/&#10;      &#10;      PACK_PROJETOMONI.GET_VETOR_PROJETORATEIO(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO);&#10;          &#10;      /*IF NVL(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO.COUNT, 0) > 0 THEN&#10;        PACK_PROJETOMONI.INSERE_PROJETORATEIO(O_MENSAGEM);&#10;      ELS*/&#10;      IF NVL(PACK_PROCEDIMENTOS.V_VT_PROJETORATEIO.COUNT, 0) = 0 THEN&#10;        O_MENSAGEM := 'TRUE';&#10;      END IF;  &#10;      &#10;    END IF ; --IF NVL(V_COUNT,0) > 0 ...&#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_SAIDA THEN &#10;    NULL;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="MAX_CALL_FORM">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="FUNCTION MAX_CALL_FORM(I_CD_MODULO           IN PROGRAMA.CD_MODULO%TYPE,&#10;                       I_CD_PROGRAMA         IN PROGRAMA.CD_PROGRAMA%TYPE,&#10;                       I_TP_DISPLAY          IN NUMBER DEFAULT HIDE,&#10;                       I_TP_MENU             IN NUMBER DEFAULT DO_REPLACE,&#10;                       I_TP_QUERY            IN NUMBER DEFAULT NO_QUERY_ONLY,&#10;                       I_PARAMLIST           IN PARAMLIST DEFAULT NULL,&#10;                       I_ST_VALPERMISSAO     IN BOOLEAN DEFAULT TRUE,&#10;                       I_ST_ATUALIZACONEXAO IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2 IS&#10;  &#10;  V_NM_PROGRAMA DESKPROGRAMA.NM_PROGRAMA%TYPE;&#10;  V_NM_ARQUIVO  DESKPROGRAMA.NM_ARQUIVO%TYPE;&#10;  V_CD_MODULO   PROGRAMA.CD_MODULO%TYPE;&#10;  V_CD_PROGRAMA PROGRAMA.CD_PROGRAMA%TYPE;&#10;  E_GERAL       EXCEPTION;&#10;  V_MENSAGEM    VARCHAR2(32000);&#10;BEGIN&#10;  IF ((I_CD_MODULO IS NULL) OR (I_CD_PROGRAMA IS NULL)) THEN&#10;    V_MENSAGEM := 'Informe módulo e programa.';&#10;    RAISE E_GERAL;&#10;  END IF;&#10;  &#10;  --Monta o nome do programa (módulo + programa)&#10;  V_NM_PROGRAMA := I_CD_MODULO||TO_CHAR(I_CD_PROGRAMA, 'FM000');&#10;  &#10;  --Verifica o acesso ao programa&#10;  IF I_ST_VALPERMISSAO THEN&#10;    IF (NVL(PACK_DESK.TEM_ACESSO_PROGRAMA(:GLOBAL.CD_USUARIO, V_NM_PROGRAMA, :GLOBAL.CD_EMPRESA), 'N') = 'N') THEN&#10;      --O usuário ¢CD_USUARIO¢ não tem permissão para usar o programa ¢CD_MODULO¢¢CD_PROGRAMA¢ na empresa ¢CD_EMPRESA¢.&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(335, '¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢CD_MODULO='||I_CD_MODULO||'¢CD_PROGRAMA='||I_CD_PROGRAMA||'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;      RAISE E_GERAL;&#10;    END IF;&#10;  END IF; --IF I_ST_VALPERMISSAO THEN&#10;  &#10;  --Busca o nome do arquivo (FMX) do programa, cadastrado no ANV052&#10;  BEGIN&#10;    SELECT DESKPROGRAMA.NM_ARQUIVO&#10;      INTO V_NM_ARQUIVO&#10;      FROM DESKPROGRAMA&#10;     WHERE DESKPROGRAMA.NM_PROGRAMA = V_NM_PROGRAMA;&#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      --O programa ¢NM_PROGRAMA¢ não esta cadastrado. Verifique ANV052.&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4773, '¢NM_PROGRAMA='||V_NM_PROGRAMA||'¢');&#10;      RAISE E_GERAL;&#10;    WHEN OTHERS THEN&#10;      --Ocorreu um erro ao pesquisar o programa ¢NM_PROGRAMA¢. Verifique ANV003 ou ANV052. Erro ¢SQLERRM¢.&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(8496, '¢NM_PROGRAMA='||V_NM_PROGRAMA||'¢SQLERRM='||SQLERRM||'¢');&#10;      RAISE E_GERAL;&#10;  END;  &#10;  &#10;  --Gravo as globais atuais e altero para o programa chamado&#10;  IF I_ST_ATUALIZACONEXAO THEN&#10;    V_CD_MODULO         := :GLOBAL.CD_MODULO;&#10;    V_CD_PROGRAMA       := :GLOBAL.CD_PROGRAMA;&#10;    :GLOBAL.CD_MODULO   := I_CD_MODULO;&#10;    :GLOBAL.CD_PROGRAMA  := I_CD_PROGRAMA;&#10;    &#10;    PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                 :GLOBAL.CD_EMPRESA,&#10;                                 I_CD_MODULO,&#10;                                 I_CD_PROGRAMA);&#10;  END IF; --IF I_ST_ATUALIZACONEXAO THEN&#10;  &#10;  --Chama o form&#10;  CALL_FORM(V_NM_ARQUIVO, I_TP_DISPLAY, I_TP_MENU, I_TP_QUERY, I_PARAMLIST);&#10;  &#10;  IF I_ST_ATUALIZACONEXAO THEN&#10;    PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                 :GLOBAL.CD_EMPRESA,&#10;                                 V_CD_MODULO,&#10;                                 V_CD_PROGRAMA);&#10;  &#10;    --Retorno os valores das globais&#10;    :GLOBAL.CD_MODULO    := V_CD_MODULO;&#10;    :GLOBAL.CD_PROGRAMA := V_CD_PROGRAMA;&#10;  &#10;  END IF; --IF I_ST_ATUALIZACONEXAO THEN&#10;  &#10;  RETURN NULL; --Sucesso&#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    --Retorno os valores das globais&#10;    IF ((V_CD_MODULO IS NOT NULL) AND (V_CD_PROGRAMA IS NOT NULL)) THEN&#10;      :GLOBAL.CD_MODULO    := V_CD_MODULO;&#10;      :GLOBAL.CD_PROGRAMA := V_CD_PROGRAMA;&#10;      &#10;      PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                   :GLOBAL.CD_EMPRESA,&#10;                                   V_CD_MODULO,&#10;                                   V_CD_PROGRAMA);&#10;    END IF;&#10;    RETURN V_MENSAGEM;&#10;  WHEN OTHERS THEN&#10;    --Retorno os valores das globais&#10;    IF ((V_CD_MODULO IS NOT NULL) AND (V_CD_PROGRAMA IS NOT NULL)) THEN&#10;      :GLOBAL.CD_MODULO    := V_CD_MODULO;&#10;      :GLOBAL.CD_PROGRAMA := V_CD_PROGRAMA;&#10;      &#10;      PACK_SESSAO.ATUALIZA_CONEXAO(:GLOBAL.CD_USUARIO,&#10;                                   :GLOBAL.CD_EMPRESA,&#10;                                   V_CD_MODULO,&#10;                                   V_CD_PROGRAMA);&#10;    END IF;&#10;    RETURN '[MAX_CALL_FORM] Ocorreu um erro não tratado: '||SQLERRM;&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_PREITEMCOMPRA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE PACK_PREITEMCOMPRA IS&#10;  &#10;  PROCEDURE CARREGA_PREITEMCOMPRA(O_MENSAGEM       OUT VARCHAR2);&#10;  ----------------------------------------------------------------------------------------------------&#10;  ----------------------------------------------------------------------------------------------------&#10;  ----------------------------------------------------------------------------------------------------&#10;END;">
</node>
</node>
</node>
<node FOLDED="true" TEXT="PACK_PREITEMCOMPRA">
<icon BUILTIN="Method.public"/>
<node TEXT="body">
<node TEXT="PACKAGE BODY PACK_PREITEMCOMPRA IS&#10;  &#10;  PROCEDURE CARREGA_PREITEMCOMPRA(O_MENSAGEM       OUT VARCHAR2) IS&#10;    E_GERAL            EXCEPTION;&#10;    V_INSTRUCAO       VARCHAR2(32000);&#10;    GRUPO             RECORDGROUP;&#10;    ERRO              NUMBER;&#10;  BEGIN&#10;    V_INSTRUCAO := 'SELECT PREITEMCOMPRA.NR_PREITEMCOMPRA, '||CHR(10)||&#10;                   '       PREITEMCOMPRA.NR_AGRUPAMENTO, '||CHR(10)||&#10;                   '       PREITEMCOMPRA.DS_ITEM, '||CHR(10)||&#10;                   '       PREITEMCOMPRA.CD_ITEM, '||CHR(10)||&#10;                   '       PREITEMCOMPRA.QT_ITEM, '||CHR(10)||&#10;                   '       PREITEMCOMPRA.DS_OBSERVACAO, '||CHR(10)||&#10;                   '       ITEM.DS_ITEM DS_ITEMMAXYS, '||CHR(10)||&#10;                   '       PREITEMCOMPRA.DT_DESEJADA '||CHR(10)||&#10;                   '  FROM PREITEMCOMPRA, '||CHR(10)||&#10;                   '       ITEM '||CHR(10)||&#10;                   ' WHERE PREITEMCOMPRA.CD_ITEM = ITEM.CD_ITEM (+) '||CHR(10)||&#10;                   '   AND PREITEMCOMPRA.ST_PREITEMCOMPRA = ''1'' '||CHR(10)||&#10;                   '   AND PREITEMCOMPRA.CD_EMPRESA = '||:GLOBAL.CD_EMPRESA||CHR(10)||&#10;                   ' ORDER BY PREITEMCOMPRA.NR_AGRUPAMENTO, '||CHR(10)||&#10;                   '          PREITEMCOMPRA.NR_PREITEMCOMPRA ';  &#10;  &#10;    GRUPO := FIND_GROUP('GRUPO_PREITEM');&#10;    IF NOT ID_NULL(GRUPO) THEN&#10;      DELETE_GROUP(GRUPO);&#10;    END IF;&#10;&#10;    GRUPO := CREATE_GROUP_FROM_QUERY('GRUPO_PREITEM', V_INSTRUCAO);&#10;    ERRO  := POPULATE_GROUP(GRUPO);&#10;  &#10;    IF ERRO = 1403 THEN&#10;      --A consulta não retornou dados com base nos filtros/parâmetros informados.&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1544, NULL);&#10;      RAISE E_GERAL;&#10;    ELSIF ERRO NOT IN (0, 1403) THEN&#10;      --Ocorreu um erro ao realizar a consulta conforme filtros/parâmetros informados. Erro: ¢SQLERRM¢.&#10;      O_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(25697, '¢SQLERRM='||ERRO||'¢');&#10;      RAISE E_GERAL;&#10;    END IF;&#10;&#10;    GO_BLOCK('PREITEMCOMPRA');&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    FIRST_RECORD;&#10;&#10;    FOR I IN 1..GET_GROUP_ROW_COUNT('GRUPO_PREITEM') LOOP&#10;&#10;      :PREITEMCOMPRA.NR_ITEMCOMPRA    := GET_GROUP_NUMBER_CELL('GRUPO_PREITEM.NR_PREITEMCOMPRA', I);&#10;      :PREITEMCOMPRA.DS_PREITEMCOMPRA := GET_GROUP_CHAR_CELL('GRUPO_PREITEM.DS_ITEM', I);&#10;      :PREITEMCOMPRA.CD_ITEMAXYS      := GET_GROUP_NUMBER_CELL('GRUPO_PREITEM.CD_ITEM', I);&#10;      :PREITEMCOMPRA.DS_ITEMAXYS      := GET_GROUP_CHAR_CELL('GRUPO_PREITEM.DS_ITEMMAXYS', I);&#10;      :PREITEMCOMPRA.QT_ITEM          := GET_GROUP_NUMBER_CELL('GRUPO_PREITEM.QT_ITEM', I); &#10;      :PREITEMCOMPRA.DS_OBSERVACAO    := GET_GROUP_CHAR_CELL('GRUPO_PREITEM.DS_OBSERVACAO', I);&#10;      :PREITEMCOMPRA.NR_AGRUPAMENTO   := GET_GROUP_NUMBER_CELL('GRUPO_PREITEM.NR_AGRUPAMENTO', I);&#10;      :PREITEMCOMPRA.DT_DESEJADA      := GET_GROUP_DATE_CELL('GRUPO_PREITEM.DT_DESEJADA', I);&#10;&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;  &#10;    IF (:SYSTEM.CURSOR_RECORD > 1) THEN&#10;      FIRST_RECORD;&#10;    END IF;&#10;  &#10;  EXCEPTION&#10;      WHEN E_GERAL THEN&#10;        O_MENSAGEM := '¥[CARREGA_PREITEMCOMPRA] ¥'||O_MENSAGEM;&#10;      WHEN OTHERS THEN&#10;        O_MENSAGEM := '¥[CARREGA_PREITEMCOMPRA: Erro] ¥. Erro: '||SQLERRM;&#10;  END CARREGA_PREITEMCOMPRA;&#10;  ----------------------------------------------------------------------------------------------------&#10;  ----------------------------------------------------------------------------------------------------&#10;  ----------------------------------------------------------------------------------------------------  &#10;END;">
</node>
</node>
</node>
</node>
<node TEXT="blocks">
<icon BUILTIN="Descriptor.grouping"/>
<node TEXT="CONTROLE">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":GLOBAL.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="/* MGK:52401:03/12/12&#10;** Ao validar o campo CD_EMPRESA sem informar nada, será exibida uma mensagem alertando esse fato, &#10;** ao invés de limpar o campo, como estava sendo feito anteriormente.&#10;*/&#10;DECLARE&#10;    I_CD_EMPRESA USUARIOEMPRESA.CD_EMPRESA%TYPE;&#10;    V_MENSAGEM         VARCHAR2(32000);&#10;    E_GERAL             EXCEPTION;&#10;    V_DT_FECHAMENTO   EMPRESA.DT_FECHAMENTO%TYPE;&#10;BEGIN&#10;  IF (:CONTROLE.CD_EMPRESA IS NOT NULL) THEN&#10;      SELECT USUARIOEMPRESA.CD_EMPRESA &#10;        INTO I_CD_EMPRESA &#10;        FROM USUARIOEMPRESA&#10;       WHERE (USUARIOEMPRESA.CD_EMPRESA = :CONTROLE.CD_EMPRESA) &#10;         AND (USUARIOEMPRESA.CD_USUARIO = :GLOBAL.CD_USUARIO);&#10;        &#10;    IF (I_CD_EMPRESA IS NOT NULL) THEN&#10;      SELECT EMPRESA.NM_EMPRESA, DT_FECHAMENTO &#10;        INTO :CONTROLE.NM_EMPRESA, V_DT_FECHAMENTO&#10;         FROM EMPRESA&#10;       WHERE EMPRESA.CD_EMPRESA = I_CD_EMPRESA;&#10;    &#10;      :ITEMCOMPRA.CD_EMPRESAITEM   := :CONTROLE.CD_EMPRESA;&#10;      :ITEMCOMPRA.CD_EMPRESAUTORIZ := :CONTROLE.CD_EMPRESA;&#10;      :ITEMCOMPRA.CD_EMPRESA       := :CONTROLE.CD_EMPRESA;&#10;    END IF;--IF (I_CD_EMPRESA IS NOT NULL) THEN&#10;    &#10;    /*CSL:12/12/2013:64048 - Validação para não permitir lançamentos posteriores a data de fechamento da empresa.*/&#10;    IF :CONTROLE.DT_DESEJADA IS NOT NULL THEN&#10;      IF ((V_DT_FECHAMENTO IS NOT NULL) AND (TRUNC(V_DT_FECHAMENTO) &#60;= TRUNC(:CONTROLE.DT_DESEJADA))) THEN&#10;        --A Empresa ¢CD_EMPRESA¢ está com a data de fechamento ¢DT_FECHAMENTO¢ informada, não é possível realizar a operação. Verifique TCB012.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21846, '¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢DT_FECHAMENTO='||TO_CHAR(V_DT_FECHAMENTO,'DD/MM/RRRR')||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    END IF;    &#10;  ELSE&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4957, NULL);&#10;    RAISE E_GERAL;&#10;  END IF;--IF (:CONTROLE.CD_EMPRESA IS NOT NULL) THEN&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    :CONTROLE.NM_EMPRESA := NULL;&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN NO_DATA_FOUND THEN&#10;    :CONTROLE.NM_EMPRESA := NULL;&#10;    --Empresa ¢CD_EMPRESA¢ não cadastrada ou Usuário não tem acesso à Empresa.&#10;    MENSAGEM_PADRAO(278,'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN TOO_MANY_ROWS THEN&#10;    :CONTROLE.NM_EMPRESA := NULL;&#10;    --A consulta retornou mais de um resultado ao tentar localizar os dados da empresa ¢CD_EMPRESA¢. Verifique o programa TCB012.&#10;    MENSAGEM_PADRAO(216,'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;  &#10;  WHEN OTHERS THEN       &#10;    --Erro ao buscar os dados da empresa  ¢CD_EMPRESA¢. Erro: ¢SQLERRM¢.&#10;    MENSAGEM_PADRAO(35,'¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE; &#10;    &#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('ITEMCOMPRA.DS_OBSERVACAO');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_EMPRESA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":GLOBAL.DS_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_SOLICAUTORIZ_DEPTO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE &#10;  V_VALIDARALCADA VARCHAR2(1);&#10;  V_MENSAGEM       VARCHAR2(3200);&#10;  E_GERAL          EXCEPTION;&#10;  V_CONT          NUMBER;&#10;  &#10;BEGIN&#10;  IF   :CONTROLE.CD_AUTORIZADOR IS NOT NULL THEN&#10;    IF (:CONTROLE.CD_DEPARTAMENTO IS NOT NULL) THEN&#10;      BEGIN&#10;        SELECT COUNT(*)&#10;          INTO V_CONT&#10;          FROM AUTORIZDEPARTCOMPRA &#10;         WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;           AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR;&#10;      EXCEPTION&#10;        WHEN OTHERS THEN&#10;          V_CONT := 0;&#10;      END;&#10;      &#10;      IF (V_CONT = 0) THEN&#10;        /*Autorizador ¢CD_AUTORIZADOR¢ não está liberado para o departamento ¢CD_DEPARTAMENTO¢*/&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34196, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    END IF;&#10;&#10;    BEGIN&#10;      SELECT USUARIO.NM_USUARIO &#10;        INTO :CONTROLE.NM_USUAUTORIZ &#10;        FROM USUARIO&#10;       WHERE USUARIO.CD_USUARIO = :CONTROLE.CD_AUTORIZADOR;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN  &#10;        --O Usuário ¢CD_USUARIO¢ não está cadastrado. Verifique o programa  ANV001.&#10;        MENSAGEM_PADRAO(245,'¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR||'¢');&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;    END;&#10;&#10;    BEGIN&#10;     SELECT DISTINCT USUARIO.NM_USUARIO&#10;        INTO :CONTROLE.NM_USUAUTORIZ&#10;        FROM SOLICITANTE, PARMCOMPRA, USUARIO &#10;       WHERE SOLICITANTE.CD_EMPRESA     = PARMCOMPRA.CD_EMPRESA&#10;         AND USUARIO.CD_USUARIO         = SOLICITANTE.CD_USUARIO&#10;        --AND SOLICITANTE.ST_SOLICITANTE = PARMCOMPRA.TP_APROVSOLIC&#10;         AND SOLICITANTE.CD_USUARIO     = :CONTROLE.CD_AUTORIZADOR&#10;         AND PARMCOMPRA.CD_EMPRESA      = :GLOBAL.CD_EMPRESA;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          --O Usuário ¢CD_USUARIO¢ não é autorizador para a empresa ¢CD_EMPRESA¢. Verifique  o tipo de aprovador no COM009 e o autorizador no TCO002.&#10;           MENSAGEM_PADRAO(3956, '¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR||'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        WHEN OTHERS THEN&#10;          --Erro ao pesquisar se o usuário ¢CD_USUARIO¢ está cadastrado como solicitante/autorizador. Verifique TCO002. Erro: ¢SQLERRM¢.  &#10;          MENSAGEM_PADRAO(15350, '¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR||'¢SQLERRM='||SQLERRM||'¢');&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;    END; &#10;   /* WLV:22/08/2012:41514&#10;    * Adicionado o DISTINCT na consulta, pois quando ha um usuário autorizador mais de uma vez cadastrada para mesma &#10;    * empresa com grupos diferentes estourava TOO_MANY_ROWS.&#10;    */  &#10;  BEGIN&#10;  SELECT ST_ALCADA&#10;  INTO V_VALIDARALCADA&#10;   FROM PARMCOMPRA &#10;  WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;  EXCEPTION &#10;    WHEN OTHERS THEN&#10;    V_VALIDARALCADA := 'N';&#10;    &#10;  END;&#10;&#10;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_PERMITEAPROVADORES'),'N') = 'S' THEN&#10;    IF V_VALIDARALCADA = 'S' THEN&#10;      IF(:CONTROLE.CD_DEPARTAMENTO IS NOT NULL)THEN             &#10;        BEGIN                  &#10;          SELECT DISTINCT USUARIO.NM_USUARIO&#10;            INTO :CONTROLE.NM_USUAUTORIZ&#10;            FROM SOLICITANTE, PARMCOMPRA , USUARIO, AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA &#10;           WHERE SOLICITANTE.CD_EMPRESA                  = PARMCOMPRA.CD_EMPRESA&#10;             AND USUARIO.CD_USUARIO                      = SOLICITANTE.CD_USUARIO&#10;          --   AND SOLICITANTE.ST_SOLICITANTE              = PARMCOMPRA.TP_APROVSOLIC SOL 137497&#10;             AND SOLICITANTE.CD_USUARIO                  = :CONTROLE.CD_AUTORIZADOR&#10;             AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO       = :CONTROLE.CD_DEPARTAMENTO&#10;             AND DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO       = AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO&#10;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR       = SOLICITANTE.CD_USUARIO&#10;             AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = 'S'&#10;             AND PARMCOMPRA.CD_EMPRESA                   = :GLOBAL.CD_EMPRESA;&#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            /*EML:29/07/2019:13058      --O Usuário ¢CD_USUARIO¢ não é autorizador para a empresa ¢CD_EMPRESA¢. Verifique  o tipo de aprovador no COM009 e o autorizador no TCO002.&#10;             MENSAGEM_PADRAO(3956, '¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR||'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;            RAISE FORM_TRIGGER_FAILURE;*/&#10;           --O Usuário Autorizador ¢CD_AUTORIZADOR¢ não está cadastrado como Aprovador de Necessidade para o Departamento de Compra ¢CD_DEPARTAMENTO¢. Verifique o TCO024.&#10;            MENSAGEM_PADRAO(21638, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;            RAISE FORM_TRIGGER_FAILURE;&#10;          WHEN OTHERS THEN&#10;            --Erro ao pesquisar se o usuário ¢CD_USUARIO¢ está cadastrado como solicitante/autorizador. Verifique TCO002. Erro: ¢SQLERRM¢.  &#10;            MENSAGEM_PADRAO(15350, '¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR||'¢SQLERRM='||SQLERRM||'¢');&#10;            RAISE FORM_TRIGGER_FAILURE;              &#10;        END;                            &#10;      ELSE         &#10;         BEGIN                  &#10;         SELECT DISTINCT USUARIO.NM_USUARIO&#10;           INTO :CONTROLE.NM_USUAUTORIZ&#10;           FROM SOLICITANTE, PARMCOMPRA , USUARIO, AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA &#10;          WHERE SOLICITANTE.CD_EMPRESA                   = PARMCOMPRA.CD_EMPRESA&#10;            AND USUARIO.CD_USUARIO                       = SOLICITANTE.CD_USUARIO&#10;            AND SOLICITANTE.ST_SOLICITANTE              = PARMCOMPRA.TP_APROVSOLIC&#10;            AND SOLICITANTE.CD_USUARIO                   = :CONTROLE.CD_AUTORIZADOR&#10;            AND DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO      = AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO            &#10;            AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR      = SOLICITANTE.CD_USUARIO&#10;            AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = 'S'&#10;            AND PARMCOMPRA.CD_EMPRESA                    = :GLOBAL.CD_EMPRESA;&#10;       EXCEPTION&#10;         WHEN NO_DATA_FOUND THEN           &#10;           --O Usuário Autorizador ¢CD_AUTORIZADOR¢ não está cadastrado como Aprovador de Necessidade.&#10;           MENSAGEM_PADRAO(32829, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢');&#10;           RAISE FORM_TRIGGER_FAILURE;&#10;         WHEN OTHERS THEN&#10;           --Erro ao pesquisar se o usuário ¢CD_USUARIO¢ está cadastrado como solicitante/autorizador. Verifique TCO002. Erro: ¢SQLERRM¢.  &#10;           MENSAGEM_PADRAO(15350, '¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR||'¢SQLERRM='||SQLERRM||'¢');&#10;           RAISE FORM_TRIGGER_FAILURE;              &#10;       END;            &#10;        --Sugere o Departamento de Compra, caso possuir apenas um cadastrado para o usuário solicitante logado&#10;        BEGIN       &#10;           SELECT DISTINCT DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO, DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;          INTO :CONTROLE.CD_DEPARTAMENTO, :CONTROLE.DS_DEPARTAMENTO  &#10;          FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;         WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO =  DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO         &#10;          /* AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO IN&#10;               (SELECT SOLICDEPARTCOMPRA.CD_DEPARTAMENTO&#10;                  FROM SOLICDEPARTCOMPRA&#10;                 WHERE SOLICDEPARTCOMPRA.CD_SOLICITANTE =:GLOBAL.CD_USUARIO)*/&#10;           AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR       &#10;           AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = 'S';              &#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            :CONTROLE.CD_DEPARTAMENTO := NULL;&#10;            :CONTROLE.DS_DEPARTAMENTO := NULL;&#10;        END;    &#10;       &#10;     END IF;         &#10;       END IF;&#10;    END IF;&#10;    &#10;    /* DCS:25/02/2014:68851&#10;     * Removida validação que obriga que o autorizador informado seja um aprovador de necessidade do TCO024&#10;     */&#10;    /* DCS:19/11/2013:63403&#10;     * Caso esteja ativo o controle de Alçadas por Departamento,&#10;     * O Autorizador e Departamento devem estar cadastrados no TCO024&#10;     */&#10;/*EML:29/07/2019:13058    &#10;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_ALCADASDEPTO'),'N') = 'S' THEN&#10;      IF :CONTROLE.CD_AUTORIZADOR IS NOT NULL AND :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#10;        BEGIN&#10;          SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;            INTO :CONTROLE.DS_DEPARTAMENTO&#10;            FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;           WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#10;             AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#10;             AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = 'S'; --Aprovador de Necedssidade&#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            --O Usuário Autorizador ¢CD_AUTORIZADOR¢ não está cadastrado como Aprovador de Necessidade para o Departamento de Compra ¢CD_DEPARTAMENTO¢. Verifique o TCO024.&#10;            MENSAGEM_PADRAO(21638, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;            RAISE FORM_TRIGGER_FAILURE;&#10;          WHEN OTHERS THEN&#10;            MENSAGEM_PADRAO(21599, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar o Departamento ¢CD_DEPARTAMENTO¢. Erro ¢SQLERRM¢. Verifique o TCO024, página Departamentos.&#10;            RAISE FORM_TRIGGER_FAILURE;&#10;        END;&#10;      END IF;&#10;    END IF;&#10;--/*EML:29/07/2019:13058 */    &#10;  &#10;     IF(NVL(:CONTROLE.ST_MUDAUTORIZADOR,'S') = 'S')THEN               &#10;      VALIDA_AUTORIZADORCOMPRA(:CONTROLE.CD_AUTORIZADOR, V_MENSAGEM);  &#10;      IF(V_MENSAGEM  IS NOT NULL)THEN              &#10;        RAISE E_GERAL;&#10;      END IF;                           &#10;    END IF;&#10;  ELSE &#10;    :CONTROLE.NM_USUAUTORIZ:=NULL;&#10;  END IF;  &#10;  &#10;EXCEPTION                      &#10;  WHEN E_GERAL THEN&#10;    :CONTROLE.NM_USUAUTORIZ:=NULL;&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN NO_DATA_FOUND THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);                 &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN &#10;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_PERMITEAPROVADORES')    ,'N') = 'S' THEN&#10;     IF SHOW_LOV('LOV_SOLICAUTORIZ_DEPTO') THEN&#10;       NULL;&#10;     END IF;  &#10;  ELSE&#10;   IF SHOW_LOV('LOV_SOLICAUTORIZ') THEN&#10;     NULL;&#10;   END IF;&#10; END IF;&#10;END;&#10;&#10;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_USUAUTORIZ: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_TIPOCOMPRA: Number(3)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Tipo Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM    VARCHAR2(32000);&#10;  E_GERAL        EXCEPTION;&#10;BEGIN&#10;  &#10;  IF (:CONTROLE.CD_TIPOCOMPRA IS NOT NULL) THEN&#10;    BEGIN&#10;      SELECT TIPOCOMPRA.DS_TIPOCOMPRA,&#10;             NVL(TIPOCOMPRA.TP_COMPRA,'D') TP_COMPRA,&#10;             DECODE(TIPOCOMPRA.TP_COMPRA,'D','DIVERSAS',&#10;                                         'P','PATRIMONIAL',&#10;                                         'J','JURÍDICA',&#10;                                         'DIVERSAS') DS_TPCOMPRA&#10;        INTO :CONTROLE.DS_TIPOCOMPRA,&#10;             :CONTROLE.TP_COMPRA,&#10;             :CONTROLE.DS_TPCOMPRA&#10;         FROM TIPOCOMPRA&#10;       WHERE TIPOCOMPRA.CD_TIPOCOMPRA  = :CONTROLE.CD_TIPOCOMPRA&#10;         AND NVL(TIPOCOMPRA.ST_ATIVO, 'A') = 'A';&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;         --Tipo de compra ¢CD_TIPOCOMPRA¢ não encontrado. Verifique o programa TCO020.&#10;         V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2693,'¢CD_TIPOCOMPRA='||:CONTROLE.CD_TIPOCOMPRA||'¢');&#10;         RAISE E_GERAL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;        --Tipo de compra ¢CD_TIPOCOMPRA¢ está cadastrado várias vezes. Verifique TCO020.&#10;         V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3752,'¢CD_TIPOCOMPRA='||:CONTROLE.CD_TIPOCOMPRA||'¢');&#10;         RAISE E_GERAL; &#10;       WHEN OTHERS THEN&#10;         --Ocorreu um erro inesperado ao tentar localizar o tipo de compra  ¢CD_TIPOCOMPRA¢. Erro: ¢SQLERRM¢.&#10;         V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2695,'¢CD_TIPOCOMPRA='||:CONTROLE.CD_TIPOCOMPRA||'¢SQLERRM='||SQLERRM||'¢');    &#10;         RAISE E_GERAL;&#10;    END;&#10;    &#10;    IF (NVL(:CONTROLE.TP_COMPRA,'D') = 'J') THEN&#10;      SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',           ENABLED, PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',         NAVIGABLE, PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO', VISUAL_ATTRIBUTE, 'VSA_CAMPOTEXTO');  &#10;    ELSE&#10;      :CONTROLE.NR_CONTRATO := NULL;      &#10;      SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',           ENABLED, PROPERTY_FALSE);&#10;      SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',        NAVIGABLE, PROPERTY_FALSE);      &#10;      SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO', VISUAL_ATTRIBUTE, 'VSA_CAMPOEXIBICAO');      &#10;    END IF; --IF (NVL(:CONTROLE.TP_COMPRA,'D') = 'J') THEN&#10;  ELSE&#10;    :CONTROLE.DS_TIPOCOMPRA := NULL;    &#10;    :CONTROLE.TP_COMPRA      := NULL;&#10;    :CONTROLE.DS_TPCOMPRA    := NULL;&#10;    :CONTROLE.NR_CONTRATO   := NULL;&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',           ENABLED, PROPERTY_FALSE);&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',        NAVIGABLE, PROPERTY_FALSE);      &#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO', VISUAL_ATTRIBUTE, 'VSA_CAMPOEXIBICAO');        &#10;  END IF; --IF (:CONTROLE.CD_TIPOCOMPRA IS NOT NULL) THEN&#10;    &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    :CONTROLE.DS_TIPOCOMPRA := NULL;    &#10;    :CONTROLE.TP_COMPRA      := NULL;&#10;    :CONTROLE.DS_TPCOMPRA    := NULL;&#10;    :CONTROLE.NR_CONTRATO   := NULL;&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',           ENABLED, PROPERTY_FALSE);&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',        NAVIGABLE, PROPERTY_FALSE);      &#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO', VISUAL_ATTRIBUTE, 'VSA_CAMPOEXIBICAO');      &#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);    &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    :CONTROLE.DS_TIPOCOMPRA := NULL;    &#10;    :CONTROLE.TP_COMPRA      := NULL;&#10;    :CONTROLE.DS_TPCOMPRA    := NULL;&#10;    :CONTROLE.NR_CONTRATO   := NULL;&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',           ENABLED, PROPERTY_FALSE);&#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO',        NAVIGABLE, PROPERTY_FALSE);      &#10;    SET_ITEM_PROPERTY ('CONTROLE.NR_CONTRATO', VISUAL_ATTRIBUTE, 'VSA_CAMPOEXIBICAO');      &#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);    &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_TIPOCOMPRA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_TPCOMPRA: Char(12)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TP_COMPRA: Char(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_DT_FECHAMENTO  EMPRESA.DT_FECHAMENTO%TYPE;&#10;  V_CD_TIPOCOMPRA  TIPOCOMPRA.CD_TIPOCOMPRA%TYPE;&#10;  V_DS_TIPOCOMPRA  TIPOCOMPRA.DS_TIPOCOMPRA%TYPE;&#10;  V_MENSAGEM       VARCHAR2(32000);&#10;  E_GERAL          EXCEPTION;&#10;BEGIN&#10;  IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM THEN&#10;    IF :CONTROLE.DT_DESEJADA IS NOT NULL THEN     &#10;       /*AUG:130776:15/03/2019 VERIFICA SE O COM001 FOI CHAMADO PELO EMV078 PARA NÃO VALIDAR A DATA DESEJADA DO PEDIDO INTERNO.&#10;        *ESTA VALIDAÇÃO ESTÁ SENDO FEITA AO FINAL DA SOLICITAÇÃO DE COMPRA.&#10;        */&#10;      IF :PARAMETER.CD_MODULO   &#60;> 'EMV' AND&#10;          :PARAMETER.CD_PROGRAMA &#60;> 78    AND    &#10;          TRUNC(:CONTROLE.DT_DESEJADA) &#60;= TRUNC(SYSDATE) THEN&#10;          :CONTROLE.DT_DESEJADA := SYSDATE;&#10;          --A Data Desejada deve ser maior que a data atual!&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4686,'');        &#10;          RAISE E_GERAL;&#10;      END IF;&#10;      &#10;      /*CSL:12/12/2013:64048 - Validação para não permitir lançamentos posteriores a data de fechamento da empresa.*/&#10;      IF :CONTROLE.CD_EMPRESA IS NOT NULL THEN&#10;        BEGIN&#10;          SELECT EMPRESA.DT_FECHAMENTO&#10;            INTO V_DT_FECHAMENTO&#10;            FROM EMPRESA&#10;           WHERE EMPRESA.CD_EMPRESA = :CONTROLE.CD_EMPRESA;&#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3214, NULL);&#10;            RAISE E_GERAL;&#10;        END;&#10;      &#10;        IF ((V_DT_FECHAMENTO IS NOT NULL) AND (TRUNC(V_DT_FECHAMENTO) &#60;= TRUNC(:CONTROLE.DT_DESEJADA))) THEN&#10;          --A Empresa ¢CD_EMPRESA¢ está com a data de fechamento ¢DT_FECHAMENTO¢ informada, não é possível realizar a operação. Verifique TCB012.&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21846, '¢CD_EMPRESA='||:CONTROLE.CD_EMPRESA||'¢DT_FECHAMENTO='||TO_CHAR(V_DT_FECHAMENTO,'DD/MM/RRRR')||'¢');&#10;          RAISE E_GERAL;&#10;        END IF;&#10;      END IF;&#10;      &#10;      /* DCS:11/02/2014:58880&#10;       * busca o tipo de compra automático cadastrado no TCO20, pela diferença de dias entre a data de Emissão e data Desejada&#10;       */       &#10;      IF NVL(PACK_COMPRAS.VALIDA_TIPOCOMPRAUTOMATICO,'N') = 'S' THEN&#10;        PACK_COMPRAS.DEFINE_TIPOCOMPRAUTOMATICO(TRUNC(SYSDATE),&#10;                                                TRUNC(:CONTROLE.DT_DESEJADA),&#10;                                                V_CD_TIPOCOMPRA,&#10;                                                V_DS_TIPOCOMPRA,&#10;                                                V_MENSAGEM);&#10;        &#10;        IF V_MENSAGEM IS NOT NULL THEN&#10;          RAISE E_GERAL;&#10;        END IF;        &#10;        :CONTROLE.CD_TIPOCOMPRA := V_CD_TIPOCOMPRA;&#10;        :CONTROLE.DS_TIPOCOMPRA := V_DS_TIPOCOMPRA;&#10;      END IF;&#10;      &#10;    ELSE&#10;      IF NVL(PACK_COMPRAS.VALIDA_TIPOCOMPRAUTOMATICO,'N') = 'S' THEN&#10;        :CONTROLE.CD_TIPOCOMPRA := NULL;&#10;        :CONTROLE.DS_TIPOCOMPRA := NULL;&#10;        :CONTROLE.TP_COMPRA      := NULL;&#10;        :CONTROLE.DS_TPCOMPRA    := NULL;&#10;      END IF;&#10;    END IF;&#10;  END IF;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0),V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM_PADRAO(2627, '¢SQLERRM='||SQLERRM||'¢'); --Ocorreu um erro inesperado. Erro ¢SQLERRM¢.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_INICIO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data de Início p/ Serviço">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Data de Início dos Serviços">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Data de Início dos Serviços">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF (:CONTROLE.DT_DESEJADA IS NOT NULL) AND (:CONTROLE.DT_INICIO   IS NOT NULL) THEN&#10;    IF :CONTROLE.DT_INICIO > :CONTROLE.DT_DESEJADA THEN&#10;      --Data de início da obra deve ser menor que data desejada.&#10;      MENSAGEM_PADRAO(4698,'');&#10;      :CONTROLE.DT_INICIO := :CONTROLE.DT_DESEJADA;&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;  END IF;&#10;  &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_CONTRATO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nr. Contrato">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_DEPARTAMENTO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Departamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Departamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_DEPCOMPRAAUTO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  V_CD_AUTORIZADOR VARCHAR2(3);&#10;  E_GERAL     EXCEPTION;&#10;  V_COUNT      NUMBER;&#10;  V_CONT      NUMBER;&#10;BEGIN&#10;  &#10;  IF :SYSTEM.TRIGGER_ITEM = :SYSTEM.CURSOR_ITEM THEN&#10;    IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#10;      BEGIN&#10;        SELECT DS_DEPARTAMENTO&#10;          INTO :CONTROLE.DS_DEPARTAMENTO&#10;          FROM DEPARTAMENTOCOMPRA&#10;         WHERE CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21597, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢'); --O Departamento ¢CD_DEPARTAMENTO¢ não está cadastrado. Verifique o TCO024, página Departamentos.&#10;          RAISE E_GERAL;&#10;        WHEN OTHERS THEN&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar o Departamento ¢CD_DEPARTAMENTO¢. Erro ¢SQLERRM¢. Verifique o TCO024, página Departamentos.&#10;          RAISE E_GERAL;&#10;      END;&#10;      &#10;     /* DCS:25/02/2014:68851&#10;      * valida se o departamento esta cadastrado para o Solicitante no TCO024&#10;      */&#10;      BEGIN&#10;        SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;          INTO :CONTROLE.DS_DEPARTAMENTO&#10;          FROM SOLICDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;         WHERE SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#10;           AND SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;           AND SOLICDEPARTCOMPRA.CD_SOLICITANTE  = :GLOBAL.CD_USUARIO;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22640, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢CD_SOLICITANTE='||:GLOBAL.CD_USUARIO||'¢'); --O Departamento de Compra ¢CD_DEPARTAMENTO¢ não está cadastrado para o Usuário Soliciante ¢CD_SOLICITANTE¢. Verifique o TCO024.&#10;          RAISE E_GERAL;&#10;        WHEN OTHERS THEN&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar o Departamento ¢CD_DEPARTAMENTO¢. Erro ¢SQLERRM¢. Verifique o TCO024, página Departamentos.&#10;          RAISE E_GERAL;&#10;      END;&#10;&#10;      IF (:CONTROLE.CD_AUTORIZADOR IS NOT NULL) THEN&#10;        BEGIN&#10;          SELECT COUNT(*)&#10;            INTO V_CONT&#10;            FROM AUTORIZDEPARTCOMPRA &#10;           WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = :CONTROLE.CD_AUTORIZADOR;&#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            V_CONT := 0;&#10;        END;&#10;&#10;        IF (V_CONT = 0) THEN&#10;          /*Autorizador ¢CD_AUTORIZADOR¢ não está liberado para o departamento ¢CD_DEPARTAMENTO¢*/&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34196, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢');&#10;          RAISE E_GERAL;&#10;        END IF;&#10;      END IF;&#10;&#10;        IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_PERMITEAPROVADORES')    ,'N') = 'S' THEN   &#10;          IF(:CONTROLE.CD_AUTORIZADOR IS NOT NULL)THEN&#10;            V_CD_AUTORIZADOR := :CONTROLE.CD_AUTORIZADOR;&#10;           ELSE                                           &#10;             V_CD_AUTORIZADOR := :GLOBAL.CD_USUARIO;&#10;          END IF;    &#10;                  &#10;                &#10;          /* DCS:25/02/2014:68851&#10;          * valida se o departamento esta cadastrado para o Solicitante no TCO024&#10;          */&#10;          BEGIN&#10;            SELECT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;              INTO :CONTROLE.DS_DEPARTAMENTO&#10;              FROM SOLICDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;             WHERE SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO&#10;               AND SOLICDEPARTCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;               AND SOLICDEPARTCOMPRA.CD_SOLICITANTE  = :GLOBAL.CD_USUARIO;&#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22640, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢CD_SOLICITANTE='||V_CD_AUTORIZADOR||'¢'); --O Departamento de Compra ¢CD_DEPARTAMENTO¢ não está cadastrado para o Usuário Soliciante ¢CD_SOLICITANTE¢. Verifique o TCO024.&#10;              RAISE E_GERAL;&#10;            WHEN OTHERS THEN&#10;              V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar o Departamento ¢CD_DEPARTAMENTO¢. Erro ¢SQLERRM¢. Verifique o TCO024, página Departamentos.&#10;              RAISE E_GERAL;&#10;          END;&#10;            &#10;        BEGIN                              &#10;          SELECT DISTINCT DEPARTAMENTOCOMPRA.DS_DEPARTAMENTO&#10;            INTO :CONTROLE.DS_DEPARTAMENTO  &#10;            FROM AUTORIZDEPARTCOMPRA, DEPARTAMENTOCOMPRA&#10;           WHERE AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO =  DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO         &#10;           /*  AND AUTORIZDEPARTCOMPRA.CD_DEPARTAMENTO IN&#10;                 (SELECT SOLICDEPARTCOMPRA.CD_DEPARTAMENTO&#10;                    FROM SOLICDEPARTCOMPRA&#10;                   WHERE SOLICDEPARTCOMPRA.CD_SOLICITANTE = V_CD_AUTORIZADOR  )*/&#10;             AND AUTORIZDEPARTCOMPRA.CD_AUTORIZADOR = V_CD_AUTORIZADOR&#10;             AND DEPARTAMENTOCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;             AND AUTORIZDEPARTCOMPRA.ST_APROVNECESSIDADE = 'S';         &#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(22640, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢CD_SOLICITANTE='||V_CD_AUTORIZADOR||'¢'); --O Departamento de Compra ¢CD_DEPARTAMENTO¢ não está cadastrado para o Usuário Soliciante ¢CD_SOLICITANTE¢. Verifique o TCO024.&#10;            RAISE E_GERAL;&#10;          WHEN OTHERS THEN&#10;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(21599, '¢CD_DEPARTAMENTO='||:CONTROLE.CD_DEPARTAMENTO||'¢SQLERRM='||SQLERRM||'¢'); --Erro ao pesquisar o Departamento ¢CD_DEPARTAMENTO¢. Erro ¢SQLERRM¢. Verifique o TCO024, página Departamentos.&#10;            RAISE E_GERAL;&#10;        END;              &#10;      END IF;&#10;      &#10;      /*GBO:20/12/2019:142153*/&#10;      IF :CONTROLE.NR_LOTECOMPRA IS NULL THEN&#10;        BEGIN&#10;          SELECT COUNT(*) &#10;            INTO V_COUNT&#10;            FROM PROJETOCOMPRA&#10;           WHERE PROJETOCOMPRA.CD_EMPRESA      = :CONTROLE.CD_EMPRESA&#10;             AND PROJETOCOMPRA.CD_DEPARTAMENTO = :CONTROLE.CD_DEPARTAMENTO&#10;             AND PROJETOCOMPRA.ST_PROJETO     IN ('A', 'B');&#10;        EXCEPTION&#10;          WHEN OTHERS THEN&#10;            V_COUNT := 0;&#10;        END;&#10;        IF V_COUNT > 0 THEN&#10;          SET_ITEM_PROPERTY('CONTROLE.BTN_CAPEX',VISIBLE,PROPERTY_TRUE);&#10;          SET_ITEM_PROPERTY('CONTROLE.BTN_CAPEX',ENABLED,PROPERTY_TRUE);&#10;        ELSE&#10;          SET_ITEM_PROPERTY('CONTROLE.BTN_CAPEX',VISIBLE,PROPERTY_FALSE);&#10;          SET_ITEM_PROPERTY('CONTROLE.BTN_CAPEX',ENABLED,PROPERTY_FALSE);&#10;          :CONTROLE.CD_PROJETOCOMPRA := NULL;&#10;        END IF;&#10;      END IF;&#10;    ELSE&#10;      :CONTROLE.CD_DEPARTAMENTO := NULL;&#10;      :CONTROLE.DS_DEPARTAMENTO := NULL;&#10;      SET_ITEM_PROPERTY('CONTROLE.BTN_CAPEX',VISIBLE,PROPERTY_FALSE);&#10;      SET_ITEM_PROPERTY('CONTROLE.BTN_CAPEX',ENABLED,PROPERTY_FALSE);&#10;      :CONTROLE.CD_PROJETOCOMPRA := NULL;&#10;    END IF;&#10;  END IF;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0),V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM_PADRAO(2627, '¢SQLERRM='||SQLERRM||'¢'); --Ocorreu um erro inesperado. Erro ¢SQLERRM¢.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN &#10;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_PERMITEAPROVADORES')    ,'N') = 'S' THEN&#10;     IF SHOW_LOV('LOV_DEPCOMPRAAUTO') THEN&#10;       NULL;&#10;     END IF;  &#10;  ELSE&#10;   IF SHOW_LOV('LOV_DEPARTAMENTOCOMPRA') THEN&#10;     NULL;&#10;   END IF;&#10; END IF;&#10;END;&#10;&#10;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_DEPARTAMENTO: Char(120)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do tipo de compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_LOTECOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Número do Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_COMPRAS">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_ANOSAFRA: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Ano Safra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_INSTRUCAO       VARCHAR2(1000);&#10;  V_ERRO            NUMBER;&#10;  V_MENSAGEM        VARCHAR2(32000);     &#10;  V_CD_EMPRESA      ITEMCOMPRA.CD_EMPRESA%TYPE;&#10;  V_NR_LOTECOMPRA    ITEMCOMPRA.NR_ITEMCOMPRA%TYPE;  &#10;BEGIN  &#10;  IF :CONTROLE.NR_LOTECOMPRA IS NOT NULL AND :CONTROLE.CD_EMPRESA IS NOT NULL THEN&#10;    PACK_PROCEDIMENTOS.V_DUPLICADO := FALSE; /*ATR:80785:11/02/2015*/&#10;    V_NR_LOTECOMPRA := :CONTROLE.NR_LOTECOMPRA;&#10;    V_CD_EMPRESA    := :CONTROLE.CD_EMPRESA;&#10;    CLEAR_FORM(NO_VALIDATE);      &#10;    /**KRG:03/06/2008:18311&#10;     * Comentado pois o campo é de fórmula, e na fórmula já faz receber a PACK_GLOBAL.TP_PEDIDO.&#10;     */&#10;    --:CONTROLE.TP_PEDIDO := PACK_GLOBAL.TP_PEDIDO; &#10;    SET_BLOCK_PROPERTY('ITEMCOMPRA',DEFAULT_WHERE,'     CD_EMPRESA    = '||V_CD_EMPRESA||&#10;                                                  ' AND NR_LOTECOMPRA = '||V_NR_LOTECOMPRA);&#10;    &#10;    GO_BLOCK('ITEMCOMPRA'); &#10;    &#10;    EXECUTE_QUERY;  &#10;    LAST_RECORD;  &#10;    :CONTROLE.CD_EMPRESA    := V_CD_EMPRESA;&#10;    :CONTROLE.NR_LOTECOMPRA := V_NR_LOTECOMPRA;   &#10;    V_INSTRUCAO := 'SELECT  ITEMCOMPRA.CD_ITEM,&#10;                            ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#10;                             ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#10;                             ITEMCOMPRACCUSTO.CD_AUTORIZADOR,&#10;                             ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL,&#10;                             ITEMCOMPRACCUSTO.PC_PARTICIPACAO,&#10;                             ITEMCOMPRACCUSTO.NR_ITEMCOMPRA,&#10;                             ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,&#10;                             ITEMCOMPRACCUSTO.CD_NEGOCIO,&#10;                             ITEMCOMPRACCUSTO.DS_OBSERVACAO,&#10;                             ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO&#10;                       FROM ITEMCOMPRACCUSTO,&#10;                             ITEMCOMPRA&#10;                      WHERE ITEMCOMPRA.CD_EMPRESA     = ITEMCOMPRACCUSTO.CD_EMPRESA&#10;                        AND ITEMCOMPRA.NR_ITEMCOMPRA = ITEMCOMPRACCUSTO.NR_ITEMCOMPRA &#10;                        AND ITEMCOMPRA.CD_EMPRESA    = '||V_CD_EMPRESA||'&#10;                        AND ITEMCOMPRA.NR_LOTECOMPRA = '||V_NR_LOTECOMPRA; &#10;      -- Removido pois está trazendo as compras apenas status 11 e 2&#10;      -- AND ITEMCOMPRACCUSTO.ST_ITEMCOMPRA  &#60;> 2&#10;      --------------------------------------------------------------------------&#10;      -- CARREGA RECORDGROUP&#10;      --------------------------------------------------------------------------              &#10;      &#10;    &#10;    CRIA_RECORDGROUP('GRUPO_CC',V_INSTRUCAO,V_ERRO);&#10;    DELETE ITEMCOMPRACCUSTO                              &#10;     WHERE (CD_EMPRESA,NR_ITEMCOMPRA) IN (SELECT CD_EMPRESA,NR_ITEMCOMPRA&#10;                                            FROM ITEMCOMPRA&#10;                                           WHERE CD_EMPRESA    = V_CD_EMPRESA&#10;                                             AND NR_LOTECOMPRA = V_NR_LOTECOMPRA) ;&#10;    &#10;&#10;    PACK_GRAVALIBERACAO.GRAVA_VETOR(:CONTROLE.CD_EMPRESA,     &#10;                                    :CONTROLE.CD_AUTORIZADOR, &#10;                                    :CONTROLE.CD_TIPOCOMPRA,  &#10;                                    :CONTROLE.DT_DESEJADA,&#10;                                    :CONTROLE.NR_LOTECOMPRA,&#10;                                    :CONTROLE.DT_INICIO,&#10;                                    :CONTROLE.NR_CONTRATO,&#10;                                    :CONTROLE.CD_DEPARTAMENTO,&#10;                                    V_MENSAGEM);         &#10;                                             &#10;    PACK_GRAVALIBERACAO.GRAVA_VETOR_ITENS(V_MENSAGEM);                         &#10;                                             &#10;  ELSE&#10;    GO_ITEM('ITEMCOMPRA.CD_ITEM');&#10;  END IF;  &#10;&#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM           VARCHAR2(32000);&#10;  E_GERAL               EXCEPTION;&#10;BEGIN&#10;  &#10;  &#10;  PACK_PROCEDIMENTOS.VALIDA_ANOSAFRA(V_MENSAGEM);&#10;  IF (V_MENSAGEM IS NOT NULL) THEN&#10;    RAISE E_GERAL;&#10;  END IF;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM           VARCHAR2(32000);&#10;  E_GERAL               EXCEPTION;&#10;  V_ST_VALIDA_ANOSAFRA VARCHAR2(1);&#10;BEGIN&#10;&#10;  V_ST_VALIDA_ANOSAFRA := PACK_PARMGEN.CONSULTA_PARAMETRO('VFT',4,'MAX',1,'LST_ANOSAFRA');&#10;&#10;  IF (NVL(V_ST_VALIDA_ANOSAFRA,'N') IN ('S','I')) THEN&#10;    IF SHOW_LOV('LOV_ANOSAFRA') THEN&#10;      NULL;&#10;    END IF;&#10;    VALIDATE(ITEM_SCOPE);&#10;  END IF;&#10;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ANOSAFRA: Char(70)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="BTN_CAPEX: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="CAPEX">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_PARAMPROJETOCOMPRA  PARAMLIST;&#10;  V_MENSAGEM            VARCHAR2(32000);&#10;BEGIN&#10;  IF :CONTROLE.CD_DEPARTAMENTO IS NOT NULL THEN&#10;    V_PARAMPROJETOCOMPRA := GET_PARAMETER_LIST('V_PARAMPROJETOCOMPRA');&#10;    IF ( NOT ID_NULL(V_PARAMPROJETOCOMPRA) ) THEN&#10;      DESTROY_PARAMETER_LIST(V_PARAMPROJETOCOMPRA);&#10;    END IF;&#10;    V_PARAMPROJETOCOMPRA := CREATE_PARAMETER_LIST('V_PARAMPROJETOCOMPRA');&#10;    ADD_PARAMETER(V_PARAMPROJETOCOMPRA,'CD_DEPARTAMENTO' ,TEXT_PARAMETER, :CONTROLE.CD_DEPARTAMENTO );&#10;    V_MENSAGEM := MAX_CALL_FORM('SEL',392, NO_HIDE, NO_REPLACE, NO_QUERY_ONLY, V_PARAMPROJETOCOMPRA);&#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      MENSAGEM('MAX',V_MENSAGEM,2);&#10;    END IF;&#10;    IF PACK_PROJETO_COMPRAS.GET_PROJETO_SELECIONADO IS NULL THEN&#10;      /*Procedimento cancelado pelo usuário.*/&#10;      MENSAGEM_PADRAO(588, NULL);&#10;    ELSE&#10;      :CONTROLE.CD_PROJETOCOMPRA := PACK_PROJETO_COMPRAS.GET_PROJETO_SELECIONADO;&#10;    END IF;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('ITEMCOMPRA.CD_ITEM');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TP_PEDIDO: Char(2)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSCANCEL: Char(500)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Motivo Devolução">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_INCLUIR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;   GO_BLOCK('ITEMCOMPRACCUSTO');&#10;   SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_GRAFICO: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE  &#10;  PARAMETROS PARAMLIST; &#10;      &#10;BEGIN&#10;  &#10;  PARAMETROS := GET_PARAMETER_LIST('PARAMETROS');&#10;  IF NOT ID_NULL(PARAMETROS) THEN&#10;    DESTROY_PARAMETER_LIST('PARAMETROS');&#10;  END IF;&#10;&#10;  PARAMETROS := CREATE_PARAMETER_LIST('PARAMETROS');&#10;  ADD_PARAMETER(PARAMETROS, 'V_CD_ITEM',      TEXT_PARAMETER,:ITEMCOMPRA.CD_ITEM);&#10;  ADD_PARAMETER(PARAMETROS, 'DESNAME',        TEXT_PARAMETER,'Gráfico de Cotação Anual');&#10;  ADD_PARAMETER(PARAMETROS, 'WINDOW_STATE',   TEXT_PARAMETER,'MAXIMIZE');&#10;  RUN_PRODUCT(GRAPHICS,:GLOBAL.VL_CURRENTPATH||'\COTACAO.OGD',ASYNCHRONOUS,RUNTIME,FILESYSTEM,PARAMETROS,'');&#10;  &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="LST_AUTOSUGESTAO: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Opções de auto-sugestão (Quantidade e % Partic.)">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="2">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-LIST-CHANGED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL      EXCEPTION;&#10;BEGIN&#10;&#10;  PACK_PARMGEN.AJUSTA_PARAMETRO(I_CD_MODULO        => :GLOBAL.CD_MODULO,&#10;                                I_CD_PROGRAMA      => :GLOBAL.CD_PROGRAMA,&#10;                                I_CD_USUARIO        => 'MAX',&#10;                                I_CD_VERSAOPARMGEN => :GLOBAL.CD_EMPRESA,&#10;                                I_NM_PARAMETRO      => 'ST_AUTOSUGESTAO',&#10;                                I_VL_PARAMETRO      => :CONTROLE.LST_AUTOSUGESTAO,&#10;                                O_DS_MENSAGEM      => V_MENSAGEM);&#10;  FAZ_COMMIT;&#10;&#10;  IF (:CONTROLE.LST_AUTOSUGESTAO = 2) THEN&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED,PROPERTY_FALSE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',NAVIGABLE,PROPERTY_FALSE);  &#10;    &#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',ENABLED,PROPERTY_TRUE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',NAVIGABLE,PROPERTY_TRUE);  &#10;  ELSIF (:CONTROLE.LST_AUTOSUGESTAO = 5) THEN&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',ENABLED,PROPERTY_FALSE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',NAVIGABLE,PROPERTY_FALSE);    &#10;    &#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED,PROPERTY_TRUE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',NAVIGABLE,PROPERTY_TRUE);&#10;  ELSE  &#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',ENABLED,PROPERTY_TRUE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',NAVIGABLE,PROPERTY_TRUE);&#10;    &#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED,PROPERTY_TRUE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',NAVIGABLE,PROPERTY_TRUE);&#10;  END IF;&#10;  &#10;  /*ASF:19/02/2020:140506&#10;  IF (:CONTROLE.LST_AUTOSUGESTAO = 5) THEN&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',ENABLED,PROPERTY_FALSE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',NAVIGABLE,PROPERTY_FALSE);&#10;    &#10;    SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.PC_PARTICIPACAO', ENABLED, PROPERTY_TRUE);      &#10;    SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.PC_PARTICIPACAO', NAVIGABLE, PROPERTY_TRUE);&#10;  ELSE&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',ENABLED,PROPERTY_TRUE);&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',NAVIGABLE,PROPERTY_TRUE);&#10;    &#10;    SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.PC_PARTICIPACAO', ENABLED, PROPERTY_TRUE);     &#10;  END IF;*/&#10;  &#10;  GO_ITEM('ITEMCOMPRACCUSTO.DS_OBSERVACAO');&#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',V_MENSAGEM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('ITEMCOMPRACCUSTO.DS_OBSERVACAO');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_SALVAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM                    VARCHAR2(32000);&#10;  E_GERAL                       EXCEPTION;    &#10;BEGIN&#10;  &#10;  IF (:ITEMCOMPRA.DS_OBSCANCEL IS NULL) THEN&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12107, NULL); -- O Campo Descrição da Observação não pode ser nulo!&#10;    GO_ITEM('ITEMCOMPRA.DS_OBSCANCEL');&#10;    RAISE E_GERAL;&#10;  END IF; --IF (:CONTROLE.DS_OBSCANCEL IS NULL) THEN&#10;  --------------------------------------------------&#10;  /**FLA:24/02/2020:144838&#10;   * Adição de condição para não permitir cancelamento de solicitação de compra caso esteja em algum status&#10;   * além de 'Não Atendido' e 'Parcialmente Atendido'&#10;   */&#10;  IF :ITEMCOMPRA.ST_ITEMCOMPRA IN (1, 2) THEN&#10;    &#10;    IF (SHOW_ALERT('EXCLUSAO') = ALERT_BUTTON1) THEN&#10;      IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;        GO_BLOCK(:GLOBAL.MD_BLOCO);&#10;        AUDITA_EXCLUSAO;&#10;      END IF; --IF (:GLOBAL.ST_AUDITORIA = 'S') THEN&#10;      ----------------------------------------------&#10;      &#10;      CANCELAR_ITEMCOMPRA (I_NR_ITEMCOMPRA => :ITEMCOMPRA.NR_ITEMCOMPRA,&#10;                           I_CD_EMPRESA    => :ITEMCOMPRA.CD_EMPRESA,&#10;                           I_CD_ITEM        => :ITEMCOMPRA.CD_ITEM,&#10;                           O_MENSAGEM       => V_MENSAGEM);&#10;      IF (V_MENSAGEM IS NOT NULL) THEN&#10;        RAISE E_GERAL;&#10;      END IF; --IF (V_MENSAGEM IS NOT NULL) THEN&#10;    &#10;      ------------------------------------------&#10;      &#10;      CLEAR_RECORD;&#10;      IF (FORM_SUCCESS) THEN&#10;        COMMIT;&#10;        GO_ITEM('CONTROLE.NR_LOTECOMPRA'); /*WLV:16/02/2012:40906 - Adicionado para atualizar a janela apos o cancelamento do item*/&#10;        EXECUTE_TRIGGER('KEY-NEXT-ITEM');&#10;      END IF; --IF (FORM_SUCCESS) THEN&#10;    END IF; --IF (V_ALERT = ALERT_BUTTON1) THEN&#10;      &#10;  ELSE&#10;    /*Não foi possível Cancelar a Solicitação Nº ¢NR_ITEMCOMPRA¢, pois ele esta com Status ¢ST_ITEMCOMPRA¢.*/&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(12106, '¢NR_ITEMCOMPRA='||:ITEMCOMPRA.NR_ITEMCOMPRA||&#10;                                                   '¢ST_ITEMCOMPRA='||:ITEMCOMPRA.ST_ITEMCOMPRA ||' - '||PACK_COMPRAS.RETORNA_ST_ITEMCOMPRACCUSTO(:ITEMCOMPRA.ST_ITEMCOMPRA)||'¢');&#10;    RAISE E_GERAL;&#10;  END IF;&#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    FAZ_ROLLBACK;&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('CONTROLE.BT_VOLTAR');">
</node>
</node>
</node>
<node TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('ITEMCOMPRA.DS_OBSCANCEL');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_VOLTAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  :ITEMCOMPRA.DS_OBSCANCEL := NULL;&#10;  GO_BLOCK('ITEMCOMPRA');&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('ITEMCOMPRA.DS_OBSCANCEL');">
</node>
</node>
</node>
<node TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('CONTROLE.BT_SALVAR');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CONTAORCAMENTO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_CONTACONTABIL: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="BTN_CAMINHOITEM: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Abrir o Arquivo de Retorno">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;   V_NOMEARQ       VARCHAR2(255); -- recebe o arquivo texto&#10;   V_NM_ARQRETORNO VARCHAR2(60);&#10;   V_TP_ARQUIVO     LAYOUTARQUIVO.TP_ARQUIVO%TYPE;&#10;   V_DS_EXTENSAO   VARCHAR2(32000);&#10;   V_MENSAGEM       VARCHAR2(32000);&#10;   E_GERAL EXCEPTION;&#10;BEGIN&#10;  :CONTROLE.CD_LAYOUT := PACK_PARMGEN.CONSULTA_PARAMETRO('REC',10,'MAX',:ITEMCOMPRA.CD_EMPRESA,'CD_LAYOUT');&#10;  IF(:CONTROLE.CD_LAYOUT IS NULL)THEN     &#10;  --Necessário informar um layout de importação de planilha no REC010, page Compras.&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32845, NULL);&#10;    RAISE E_GERAL;&#10;  END IF;    &#10;  &#10;  BEGIN  &#10;    SELECT LAYOUTARQUIVO.TP_ARQUIVO&#10;      INTO V_TP_ARQUIVO&#10;      FROM LAYOUTARQUIVO&#10;     WHERE LAYOUTARQUIVO.CD_LAYOUT = :CONTROLE.CD_LAYOUT; &#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      V_TP_ARQUIVO := NULL;&#10;  END ;&#10;  /*&#10;  1 - Texto com largura fixa&#10;  2 - Texto com separadores&#10;  3 - Excel (XLS ou XLSX)&#10;  4 - XML;&#10;  */&#10;  IF NVL(V_TP_ARQUIVO, 0) = 1 THEN&#10;    V_DS_EXTENSAO := 'Arquivo de Texto  (*.txt)|*.txt|';&#10;  ELSIF NVL(V_TP_ARQUIVO, 0) = 2 THEN&#10;    V_DS_EXTENSAO := 'Arquivo CSV  (*.csv)|*.csv|'||&#10;                     'Arquivo de Texto  (*.txt)|*.txt|';&#10;  ELSIF NVL(V_TP_ARQUIVO, 0) = 3 THEN&#10;    V_DS_EXTENSAO := 'Arquivo do Excel (*.xlsx)|*.xlsx|'||&#10;                     'Arquivo do Excel 2003-2007  (*.xls)|*.xls|'||                     &#10;                     'Arquivo CSV  (*.csv)|*.csv|';&#10;  ELSIF NVL(V_TP_ARQUIVO, 0) = 4 THEN&#10;    V_DS_EXTENSAO := 'Arquivo XML  (*.xml)|*.xml|';                 &#10;  ELSE&#10;    V_DS_EXTENSAO := 'Arquivo de Texto  (*.txt)|*.txt|'||&#10;                     'Arquivo CSV  (*.csv)|*.csv|'||&#10;                     'Arquivo do Excel 2003-2007  (*.xls)|*.xls|'||&#10;                     'Arquivo do Excel (*.xlsx)|*.xlsx|'||&#10;                     'Arquivo XML  (*.xml)|*.xml|';&#10;  END IF;&#10;  &#10;   -- Chama o Arquivo Texto pela Função Open_File&#10;   /*&#10;   V_NOMEARQ := GET_FILE_NAME(V_NM_ARQRETORNO,&#10;                              NULL,&#10;                              'Arquivo de Texto  (*.txt)|*.txt|'||&#10;                              'Arquivo CSV  (*.csv)|*.csv|'||&#10;                              'Arquivo do Excel 2003-2007  (*.xls)|*.xls|'||&#10;                              'Arquivo do Excel (*.xlsx)|*.xlsx|'||&#10;                              'Arquivo XML  (*.xml)|*.xml|'&#10;                              ,NULL,&#10;                              OPEN_FILE,&#10;                              TRUE);&#10;   */                               &#10;   V_NOMEARQ := GET_FILE_NAME(V_NM_ARQRETORNO,&#10;                              NULL,&#10;                              V_DS_EXTENSAO,&#10;                              NULL,&#10;                              OPEN_FILE,&#10;                              TRUE);                      &#10;   :ITEMCOMPRACCUSTO.DS_CAMINHO := V_NOMEARQ;    &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;   &#10;END;&#10;  &#10;  &#10;  &#10;&#10;&#10;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_LOG: Button(32676)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_VOLTARLOG: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_BLOCK('ITEMCOMPRACCUSTO');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_LAYOUT: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="ST_MUDAUTORIZADOR: Button(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="S">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_PROJETOCOMPRA: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CHK_MARCARTODOS: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Marcar Todos">
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
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="N">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-CHECKBOX-CHANGED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_REG_ATUAL      NUMBER;&#10;BEGIN&#10;  V_REG_ATUAL   := :SYSTEM.CURSOR_RECORD;&#10;  GO_BLOCK('PREITEMCOMPRA');&#10;  FIRST_RECORD;&#10;&#10;  LOOP&#10;    IF (GET_ITEM_PROPERTY('CONTROLE.CHK_MARCARTODOS', PROMPT_TEXT) = 'Marcar Todos') THEN&#10;      :PREITEMCOMPRA.ST_MARCADO := 1;&#10;    ELSE&#10;      :PREITEMCOMPRA.ST_MARCADO := 0;&#10;    END IF; --IF (GET_ITEM_PROPERTY('CONTROLE.CHK_MARCARTODOS',PROMPT_TEXT) = 'Marcar Todos') THEN&#10;&#10;    EXIT WHEN (:SYSTEM.LAST_RECORD =  'TRUE');&#10;    NEXT_RECORD;&#10;  END LOOP;&#10;&#10;   GO_RECORD(V_REG_ATUAL);&#10;&#10;  IF (GET_ITEM_PROPERTY('CONTROLE.CHK_MARCARTODOS', PROMPT_TEXT) = 'Marcar Todos') THEN&#10;    SET_ITEM_PROPERTY('CONTROLE.CHK_MARCARTODOS', PROMPT_TEXT, 'Desmarcar Todos');&#10;  ELSE&#10;    SET_ITEM_PROPERTY('CONTROLE.CHK_MARCARTODOS', PROMPT_TEXT, 'Marcar Todos');&#10;  END IF; --IF (GET_ITEM_PROPERTY('CONTROLE.CHK_MARCARTODOS',PROMPT_TEXT) = 'Marcar Todos') THEN&#10;&#10;EXCEPTION&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||' - Erro', SQLERRM, 1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="ITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NR_REGBLOCO: Number()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="150">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;    I_CD_EMPRESA USUARIOEMPRESA.CD_EMPRESA%TYPE;&#10;BEGIN&#10;  IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#10;    SELECT USUARIOEMPRESA.CD_EMPRESA &#10;      INTO I_CD_EMPRESA &#10;      FROM USUARIOEMPRESA&#10;     WHERE (USUARIOEMPRESA.CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA) &#10;       AND (USUARIOEMPRESA.CD_USUARIO = :GLOBAL.CD_USUARIO);&#10;          &#10;    IF I_CD_EMPRESA IS NOT NULL THEN&#10;      SELECT EMPRESA.NM_EMPRESA &#10;        INTO :ITEMCOMPRA.NM_EMPRESA&#10;        FROM EMPRESA&#10;       WHERE EMPRESA.CD_EMPRESA = I_CD_EMPRESA;&#10;  &#10;      :ITEMCOMPRA.CD_EMPRESAITEM   := :ITEMCOMPRA.CD_EMPRESA;&#10;      :ITEMCOMPRA.CD_EMPRESAUTORIZ := :ITEMCOMPRA.CD_EMPRESA;&#10;    END IF;&#10;   END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;     :ITEMCOMPRA.NM_EMPRESA := NULL;&#10;     --Empresa ¢CD_EMPRESA¢ não cadastrada ou Usuário não tem acesso à Empresa.&#10;     MENSAGEM_PADRAO(278,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;     RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN TOO_MANY_ROWS THEN&#10;     :ITEMCOMPRA.NM_EMPRESA := NULL;&#10;     --A consulta retornou mais de um resultado ao tentar localizar os dados da empresa ¢CD_EMPRESA¢. Verifique o programa TCB012.&#10;     MENSAGEM_PADRAO(216,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;     RAISE FORM_TRIGGER_FAILURE;  &#10;   WHEN OTHERS THEN       &#10;     --Erro ao buscar os dados da empresa  ¢CD_EMPRESA¢. Erro: ¢SQLERRM¢.&#10;     MENSAGEM_PADRAO(35,'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢SQLERRM='||SQLERRM||'¢');&#10;     RAISE FORM_TRIGGER_FAILURE; &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_EMPRESA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":GLOBAL.DS_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
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
<node TEXT="DECLARE&#10;    I_CD_UNIDMED       UNIDMEDIDA.CD_UNIDMED%TYPE;&#10;    I_DT_CANCELAMENTO  ITEMEMPRESA.DT_CANCELAMENTO%TYPE;&#10;    I_MENSAGEM         VARCHAR2(2000);&#10;    E_GERAL            EXCEPTION;&#10;    V_CD_GRUPO         GRUPO.CD_GRUPO%TYPE;&#10;    V_CD_SUBGRUPO       SUBGRUPO.CD_SUBGRUPO%TYPE;&#10;    V_CD_ITEM           ITEMNF.CD_ITEM%TYPE; &#10;    V_TP_ITEM           VARCHAR2(2);&#10;    V_COUNT             NUMBER; &#10;    V_TAB_PRECO         TABPRECO.CD_TABPRECO%TYPE;/*ATR:71810:29/01/2016*/&#10;    V_EXISTE           VARCHAR2(1);/*ATR:71810:29/01/2016*/&#10;    V_NR_SEQ           ITEMREGRAPARMOV.NR_SEQUENCIAL%TYPE;--AUG:127526:03/01/2019&#10;    &#10;BEGIN&#10;  /*WLV:08/08/2012:41514 - Consulta para pegar os dados gravados no TIT001*/&#10;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#10;    BEGIN         &#10;       SELECT ITEM.CD_GRUPO, ITEM.CD_SUBGRUPO, ITEM.TP_ITEM, ITEM.CD_ITEM&#10;          INTO V_CD_GRUPO, V_CD_SUBGRUPO, V_TP_ITEM, V_CD_ITEM&#10;         FROM ITEM&#10;        WHERE ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;    &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --A consulta fez com que nenhum registro fosse recuperado.    &#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3129, NULL);&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        --Ocorreu um erro não esperado ao efetuar a consulta. Erro: ¢NR_ERRO¢.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(13778, '¢NR_ERRO='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;    &#10;    V_COUNT := 0;&#10;    /*WLV:08/08/2012:41514 - Consulta para verificar se tem alguma regra no TCO002 para o usuário/empresa logados */&#10;    BEGIN          &#10;      SELECT COUNT(*)&#10;       INTO V_COUNT&#10;       FROM SOLICITANTE&#10;      WHERE SOLICITANTE.CD_EMPRESA      = :GLOBAL.CD_EMPRESA&#10;        AND SOLICITANTE.CD_USUARIO      = :GLOBAL.CD_USUARIO&#10;        AND SOLICITANTE.ST_SOLICITANTE = 'S'&#10;        AND (SOLICITANTE.CD_GRUPO       = V_CD_GRUPO OR SOLICITANTE.CD_GRUPO IS NULL)&#10;        AND (SOLICITANTE.CD_SUBGRUPO   = V_CD_SUBGRUPO OR SOLICITANTE.CD_SUBGRUPO IS NULL)&#10;        AND (SOLICITANTE.TP_ITEM        = V_TP_ITEM OR SOLICITANTE.TP_ITEM IS NULL)&#10;        AND (SOLICITANTE.CD_ITEM        = :ITEMCOMPRA.CD_ITEM OR SOLICITANTE.CD_ITEM IS NULL); &#10;  &#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        --Ocorreu um erro não esperado ao efetuar a consulta. Erro: ¢NR_ERRO¢.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(13778, '¢NR_ERRO='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;    &#10;    /*WLV:08/08/2012:41514 - Caso o resultado do select acima for maior que 0 significa que existe uma regra para o usuário/empresa*/&#10;    IF V_COUNT = 0 THEN&#10;      --O item ¢CD_ITEM¢ não possui regra no TCO002 relacionado para o usuário ¢CD_USUARIO¢ para empresa ¢CD_EMPRESA¢. Verfique o TCO002.&#10;      I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(17811, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢CD_EMPRESA='||:GLOBAL.CD_EMPRESA||'¢');&#10;      :ITEMCOMPRA.DS_ITEM := NULL;&#10;      :ITEMCOMPRA.DS_UNIDMED := NULL;&#10;      RAISE E_GERAL;&#10;    END IF;--IF V_COUNT = 0 THEN    &#10;  END IF;--IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#10;  ------------------------------------------------------------------------------------&#10;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#10;    BEGIN&#10;      SELECT TP_ITEM, &#10;             DS_ITEM, &#10;             CD_UNIDMED &#10;        INTO PACK_GLOBAL.TP_ITEM,  &#10;             :ITEMCOMPRA.DS_ITEM,  &#10;             I_CD_UNIDMED&#10;        FROM ITEM&#10;        WHERE ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --O item ¢CD_ITEM¢ não está cadastrado. Verifique o programa TIT001.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27,'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;          &#10;      ------------------------------------------------------------------------------------&#10;    BEGIN&#10;      SELECT DT_CANCELAMENTO &#10;        INTO I_DT_CANCELAMENTO&#10;        FROM ITEMEMPRESA&#10;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA&#10;         AND CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#10;         &#10;      /*AUG:121710:11/06/2018 Adicionada condição para verificar se a data de cancelamento é menor ou igual a data atual*/&#10;      IF I_DT_CANCELAMENTO IS NOT NULL AND  &#10;         I_DT_CANCELAMENTO &#60;= SYSDATE THEN&#10;        --O Item ¢CD_ITEM¢ está cancelado para a empresa ¢CD_EMPRESA¢. Verifique TIT001.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(184,'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --O Item ¢CD_ITEM¢ não está cadastrado ou está cancelado. Verifique o programa TIT001.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3662,'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;      &#10;      ------------------------------------------------------------------------------------&#10;    BEGIN&#10;      SELECT CD_ITEM &#10;        INTO :ITEMCOMPRA.CD_ITEM&#10;        FROM PLANEJITEM&#10;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA&#10;         AND CD_ITEM    = :ITEMCOMPRA.CD_ITEM;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --Planejamento de item não cadastrado para o Item ¢CD_ITEM¢ e Empresa ¢CD_EMPRESA¢. Verifique o programa TIT001.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20051, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20052, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20053, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢SQLERR='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;  &#10;    &#10;    /*AUG:127526:03/01/2019*/&#10;    V_NR_SEQ := PACK_TCB054.RETORNA_SEQ_ITEMPARMOV(:ITEMCOMPRA.CD_ITEM,&#10;                                                   :CONTROLE.CD_EMPRESA,&#10;                                                   :GLOBAL.CD_USUARIO,&#10;                                                   :GLOBAL.CD_MODULO,&#10;                                                   :GLOBAL.CD_PROGRAMA);                               &#10;    IF V_NR_SEQ IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NULL THEN&#10;      BEGIN&#10;        SELECT CD_MOVIMENTACAO&#10;          INTO :ITEMCOMPRA.CD_MOVIMENTACAO&#10;          FROM ITEMPARMOV&#10;          WHERE ITEMPARMOV.NR_SEQUENCIAL = V_NR_SEQ;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          :ITEMCOMPRA.CD_MOVIMENTACAO := NULL;&#10;        WHEN TOO_MANY_ROWS THEN&#10;          IF SHOW_LOV('LOV_ITEMPARMOV') THEN&#10;            NULL;&#10;          END IF;&#10;        WHEN OTHERS THEN&#10;          MENSAGEM('Maxys', SQLERRM,2);&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;      END;  &#10;      &#10;    ELSE-----&#10;    &#10;     /*FJC:02/07/2018:121705&#10;        busca a ultima movimentação utilizada para o item em lançamento de recebimento valido.&#10;      */&#10;      &#10;      IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NULL AND &#10;         NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',NVL(:ITEMCOMPRA.CD_EMPRESA, :GLOBAL.CD_EMPRESA),'ST_ULTIMAMOVIMENTACAO'),'N') = 'S' THEN&#10;        :ITEMCOMPRA.CD_MOVIMENTACAO := PACK_COMPRAS.RETORNA_ULTIMAMOVIMENTACAO(I_CD_EMPRESA => NVL(:ITEMCOMPRA.CD_EMPRESA, :GLOBAL.CD_EMPRESA), &#10;                                                                                I_CD_ITEM    => :ITEMCOMPRA.CD_ITEM,&#10;                                                                                I_CD_CLIFOR  => NULL);&#10;       END IF;&#10;    END IF;--IF V_NR_SEQ IS NOT NULL THEN&#10;    &#10;    /*ATR:71810:29/01/2016*/&#10;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CONTROLEORC051'),'N') = 'S' THEN&#10;      IF PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'CD_TABELAPRECORC051') IS NOT NULL THEN&#10;        V_TAB_PRECO := PACK_PARMGEN.CONSULTA_PARAMETRO('COM',009,'MAX',:ITEMCOMPRA.CD_EMPRESA,'CD_TABELAPRECORC051');&#10;        BEGIN&#10;          SELECT 'S'&#10;            INTO V_EXISTE&#10;            FROM PRECOVENDA, TABPRECO &#10;           WHERE (PRECOVENDA.CD_TABPRECO = TABPRECO.CD_TABPRECO)&#10;             AND (PRECOVENDA.CD_TABPRECO = V_TAB_PRECO)&#10;             AND (PRECOVENDA.CD_ITEM = :ITEMCOMPRA.CD_ITEM)&#10;             AND (PRECOVENDA.DT_EMVIGOR IS NULL OR&#10;                 TRUNC(PRECOVENDA.DT_EMVIGOR) &#60;= TRUNC(SYSDATE)) &#10;             AND (PRECOVENDA.DT_CANCELAMENTO IS NULL OR&#10;                 TRUNC(PRECOVENDA.DT_CANCELAMENTO) > TRUNC(SYSDATE))&#10;             AND (PRECOVENDA.DT_VENCIMENTO IS NULL OR &#10;                  TRUNC(PRECOVENDA.DT_VENCIMENTO) > TRUNC(SYSDATE));        &#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            --O Item Informado ¢CD_ITEM¢ não está cadastrado para a Tabela de Preços ¢CD_TABPRECO¢ ou o preço está cancelado, vencido, ou não está em vigor. Favor verificar TVE003&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27044, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_TABPRECO='||V_TAB_PRECO||'¢');&#10;            RAISE E_GERAL;&#10;          WHEN OTHERS THEN&#10;            --Erro ao consultar a Tabela de Preço ¢CD_CD_TABPRECO¢ para o Item ¢CD_ITEM¢. Erro: ¢SQLERRM¢.&#10;            I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27026, '¢CD_CD_TABPRECO='||V_TAB_PRECO||'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢SQLERRM='||SQLERRM||'¢');&#10;            RAISE E_GERAL;&#10;        END;&#10;      ELSE&#10;        --O Controle por Orçamento está ativo porém a tabela de preço não foi informada. Favor verificar COM009.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(27043, NULL);&#10;        RAISE E_GERAL;          &#10;      END IF; --IF PACK_PARMGEN.CONSULTA_PARAMETRO('COM',009,'MAX',:ITEMCOMPRA.CD_EMPRESA,'CD_TABELAPRECORC051') IS NOT NULL THEN    &#10;    END IF; --IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CONTROLEORC051'),'N') = 'S' THEN&#10;&#10;    :ITEMCOMPRA.DS_UNIDMED := I_CD_UNIDMED;&#10;  ELSE&#10;    :ITEMCOMPRA.DS_ITEM:= NULL;&#10;    :ITEMCOMPRA.DS_UNIDMED := NULL;&#10;  END IF;&#10;  &#10;  ------------------------------------------------------------------------------------&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',I_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN NO_DATA_FOUND THEN&#10;    MENSAGEM('Maxys COM001',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;    I_CD_UNIDMED  VARCHAR2(2);&#10;    I_TP_ITEM     VARCHAR2(1); &#10;    I_MENSAGEM    VARCHAR2(2000);&#10;    E_GERAL       EXCEPTION;&#10;    V_COUNTPEDIDO NUMBER; /*ATR:88023:24/06/2015*/&#10;    E_REMOVE      EXCEPTION; /*ATR:88023:24/06/2015*/&#10;  ------------------------------------------------------------------------------------&#10;  CURSOR CUR_QT_CCUSTO IS&#10;  SELECT ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL&#10;    FROM ITEMCOMPRACCUSTO&#10;   WHERE :ITEMCOMPRA.NR_ITEMCOMPRA = ITEMCOMPRACCUSTO.NR_ITEMCOMPRA&#10;     AND :ITEMCOMPRA.CD_EMPRESA    = ITEMCOMPRACCUSTO.CD_EMPRESA;&#10;BEGIN  &#10;  VALIDATE(ITEM_SCOPE);&#10;  IF NOT FORM_SUCCESS THEN&#10;    RETURN;&#10;  END IF;&#10;  &#10;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;    IF :SYSTEM.RECORD_STATUS = 'INSERT' THEN&#10;      BEGIN&#10;        SELECT DISTINCT ITEMCOMPRA.CD_ITEM &#10;          INTO :ITEMCOMPRA.CD_ITEM&#10;          FROM ITEMCOMPRA&#10;         WHERE ITEMCOMPRA.CD_ITEM          = :ITEMCOMPRA.CD_ITEM&#10;           AND ITEMCOMPRA.CD_EMPRESA       = :ITEMCOMPRA.CD_EMPRESA&#10;           AND (ITEMCOMPRA.ST_ITEMCOMPRA   = 1 OR ITEMCOMPRA.ST_ITEMCOMPRA IS NULL);&#10;           &#10;           /*WLV:15/08/2012:41514 - Adicionado para que mostre a msg padrão em vez do alerta normal*/&#10;           SET_ALERT_PROPERTY('INCLUIPEDIDO',ALERT_MESSAGE_TEXT,PACK_MENSAGEM.MENS_ALERTA(17882, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢'));&#10;           IF SHOW_ALERT('INCLUIPEDIDO')   = ALERT_BUTTON1 THEN&#10;               /*CSL:22059:05/06/09&#10;                *Se  houver alguma  solicitação  em aberto com o item que o usuário  digitou/selecionou e o mesmo &#10;                *desejar  incluir o  item em uma  das solicitações em  aberto, o programa exibe uma LOV  com a(s) &#10;                *solicitação(ões) em aberto para que o usuário possa adicionar o ítem que ia pedir  na quantidade &#10;                *da solicitação selecionada .&#10;                */&#10;                &#10;              &#10;               --MENSAGEM('Maxys COM001 - Aviso','Já existe uma solicitação de compra para este item.'||CHR(10)||CHR(10)||'Inclua a quantidade desejada na mesma solicitação.',3);&#10;               --SET_BLOCK_PROPERTY('ITEMCOMPRA', DEFAULT_WHERE, ' CD_ITEM = '||:ITEMCOMPRA.CD_ITEM||' AND CD_EMPRESA = '||:ITEMCOMPRA.CD_EMPRESA||' AND ( ST_ITEMCOMPRA &#60; 4 OR ST_ITEMCOMPRA IS NULL ) AND ROWNUM = 1 ');&#10;               --EXECUTE_QUERY(NO_VALIDATE);&#10;               IF SHOW_LOV('LOV_COMPRAS') THEN&#10;                NULL;&#10;               END IF;&#10;               GO_ITEM('CONTROLE.NR_LOTECOMPRA');&#10;               Execute_Trigger ('KEY-NEXT-ITEM'); &#10;           ELSE&#10;               NULL;&#10;           END IF;&#10;           IF :ITEMCOMPRA.QT_PREVISTA = 0 THEN&#10;              FOR I IN CUR_QT_CCUSTO LOOP&#10;                :ITEMCOMPRA.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA + I.QT_PEDIDAUNIDSOL;&#10;             END LOOP;&#10;           END IF;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN        &#10;          NULL;&#10;        WHEN TOO_MANY_ROWS THEN&#10;          :ITEMCOMPRA.CD_ITEM := NULL;&#10;      END;&#10;    END IF;&#10;    -------------------------------------------------------------------------------------------&#10;    BEGIN&#10;      &#10;      SELECT ITEMEMPRESA.CD_ITEM &#10;        INTO :ITEMCOMPRA.CD_ITEM&#10;        FROM ITEMEMPRESA&#10;       WHERE ITEMEMPRESA.CD_ITEM    = :ITEMCOMPRA.CD_ITEM&#10;         AND ITEMEMPRESA.CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESAITEM;&#10;      &#10;      SELECT ITEM.TP_ITEM,&#10;              ITEM.DS_ITEM,          &#10;              ITEM.CD_UNIDMED&#10;        INTO I_TP_ITEM,      &#10;             :ITEMCOMPRA.DS_ITEM,  &#10;             I_CD_UNIDMED&#10;        FROM ITEM&#10;       WHERE ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;&#10;      IF I_TP_ITEM = 'A' THEN&#10;        MANIPULA_CAMPO('ITEMCOMPRA.DS_ITEMSERVICO','D');&#10;        /*SET_ITEM_PROPERTY ('ITEMCO MPRA.DS_ITEMSERVICO',ENABLED,PROPERTY_FALSE);&#10;        SET_ITEM_PROPERTY ('ITEMCO MPRA.DS_ITEMSERVICO',REQUIRED,PROPERTY_FALSE);&#10;        SET_ITEM_PROPERTY ('ITEMCO MPRA.DS_ITEMSERVICO',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;        SET_ITEM_PROPERTY ('ITEMCO MPRA.DS_ITEMSERVICO',PROMPT_FONT_STYLE,FONT_PLAIN);        */&#10;        :ITEMCOMPRA.DS_ITEMSERVICO     := NULL;&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',ENABLED,PROPERTY_FALSE);&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',REQUIRED,PROPERTY_FALSE);&#10;        :ITEMCOMPRA.DT_INICIO         := NULL;&#10;&#10;      ELSIF I_TP_ITEM = 'S' THEN&#10;        MANIPULA_CAMPO('ITEMCOMPRA.DS_ITEMSERVICO','A');&#10;        /*SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',ENABLED,PROPERTY_TRUE);&#10;        SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',NAVIGABLE,PROPERTY_TRUE);&#10;        SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');&#10;        SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',PROMPT_FONT_STYLE,FONT_UNDERLINE);*/&#10;        &#10;        --SET_ITEM_PROPERTY ('ITEMC OMPRA.DS_ITEMSERVICO',REQUIRED,PROPERTY_TRUE);&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',ENABLED,PROPERTY_TRUE);&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',NAVIGABLE,PROPERTY_TRUE);&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',REQUIRED,PROPERTY_TRUE);&#10;&#10;      ELSIF I_TP_ITEM IN ('P','I') THEN&#10;        MANIPULA_CAMPO('ITEMCOMPRA.DS_ITEMSERVICO','D');&#10;        /*SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',ENABLED,PROPERTY_FALSE);&#10;        SET_ITEM_PROPERTY ('ITEMCOM PRA.DS_ITEMSERVICO',REQUIRED,PROPERTY_FALSE);&#10;        SET_ITEM_PROPERTY ('ITEMCO MPRA.DS_ITEMSERVICO',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;        SET_ITEM_PROPERTY ('ITEMCO MPRA.DS_ITEMSERVICO',PROMPT_FONT_STYLE,FONT_PLAIN);*/&#10;        &#10;        :ITEMCOMPRA.DS_ITEMSERVICO     := NULL;&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',ENABLED,PROPERTY_FALSE);&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',REQUIRED,PROPERTY_FALSE);&#10;        :ITEMCOMPRA.DT_INICIO         := NULL;&#10;&#10;--      ELSIF I_TP_ITEM = 'I' THEN&#10;  --      MANIPULA_CAMPO('ITEMCOMPRA.DS_ITEMSERVICO','D');&#10;        /*SET_ITEM_PROPERTY ('ITE MCOMPRA.DS_ITEMSERVICO',ENABLED,PROPERTY_FALSE);&#10;        SET_ITEM_PROPERTY ('ITEM COMPRA.DS_ITEMSERVICO',REQUIRED,PROPERTY_FALSE);&#10;        SET_ITEM_PROPERTY ('ITEM COMPRA.DS_ITEMSERVICO',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');&#10;        SET_ITEM_PROPERTY ('ITEM COMPRA.DS_ITEMSERVICO',PROMPT_FONT_STYLE,FONT_PLAIN);*/&#10;        &#10;--        :ITEMCOMPRA.DS_ITEMSERVICO     := NULL;&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',ENABLED,PROPERTY_FALSE);&#10;        --SET_ITEM_PROPERTY ('ITEMCOMPRA.DT_INICIO',REQUIRED,PROPERTY_FALSE);&#10;--        :ITEMCOMPRA.DT_INICIO         := NULL;&#10;      END IF;&#10;&#10;      SELECT UNIDMEDIDA.DS_UNIDMEDIDA &#10;        INTO :ITEMCOMPRA.DS_UNIDMED&#10;        FROM UNIDMEDIDA&#10;       WHERE UNIDMEDIDA.CD_UNIDMED = I_CD_UNIDMED;&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        --Item ¢CD_ITEM¢ não cadastrado, não associado a empresa ¢CD_EMPRESA¢, sem Item Similar ou sem movimentação.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(250,'¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;  END IF; &#10;    &#10;  /*ATR:88023:24/06/2015*/&#10;  IF :CONTROLE.CD_EMPRESA IS NOT NULL AND :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN &#10;    BEGIN&#10;      SELECT COUNT(*)&#10;        INTO V_COUNTPEDIDO&#10;        FROM ITEMPEDIDOCOMPRA&#10;       WHERE ITEMPEDIDOCOMPRA.ST_ITEMPEDIDO IN ('1','2')&#10;         AND ITEMPEDIDOCOMPRA.CD_EMPRESA = :CONTROLE.CD_EMPRESA&#10;         AND ITEMPEDIDOCOMPRA.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;    EXCEPTION&#10;      WHEN OTHERS THEN&#10;        V_COUNTPEDIDO := 0;&#10;    END;&#10;    &#10;    IF NVL(V_COUNTPEDIDO,0) > 0 THEN&#10;      SET_ALERT_PROPERTY('ALR_EXISTEPEDIDO',ALERT_MESSAGE_TEXT,'O Item '||(:ITEMCOMPRA.CD_ITEM)||' possui pedido em aberto para a Empresa '||(:CONTROLE.CD_EMPRESA)||'. Deseja prosseguir com lançamento ou remover o item?');&#10;      IF SHOW_ALERT('ALR_EXISTEPEDIDO')   = ALERT_BUTTON1 THEN&#10;        NULL;&#10;      ELSE&#10;        RAISE E_REMOVE;&#10;      END IF;&#10;    END IF;  --IF NVL(V_COUNTPEDIDO,0) > 0 THEN  &#10;  END IF; --IF :CONTROLE.CD_EMPRESA IS NOT NULL AND :ITEMCOMPRA.CD_ITEM THEN     &#10;&#10;  NEXT_ITEM;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys COM001 - Aviso',I_MENSAGEM,3);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  /*ATR:88023:24/06/2015*/&#10;  WHEN E_REMOVE THEN&#10;    CLEAR_RECORD;&#10;    GO_ITEM('ITEMCOMPRA.CD_ITEM');&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_USUAUTORIZ: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TP_APROVSOLIC: Char(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Moviment.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Somente Movimentações do Tipo de Pedido do Programa COM004">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMPARMOV">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE &#10;  V_MENSAGEM           VARCHAR2(32000);&#10;  V_CD_OPERESTOQUE    CMI.CD_OPERESTOQUE%TYPE;&#10;  V_DS_MOVIMENTACAO   VARCHAR2(60);&#10;  V_ST_ATIVO          VARCHAR2(01);&#10;  E_GERAL             EXCEPTION;&#10;  V_NR_SEQ          ITEMREGRAPARMOV.NR_SEQUENCIAL%TYPE;--AUG:127526:03/01/2019&#10;  V_ST_OBRIGATORIO   BOOLEAN;--AUG:127526:03/01/2019&#10;  &#10;  CURSOR CUR_ITEMPARMOV(C_NR_SEQ IN NUMBER) IS&#10;    SELECT ST_OBRIGATORIO,&#10;           CD_MOVIMENTACAO&#10;      FROM ITEMPARMOV&#10;     WHERE ITEMPARMOV.NR_SEQUENCIAL = C_NR_SEQ;     &#10;BEGIN&#10;  IF :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL THEN &#10;    &#10;    /*AUG:127526:03/01/2019*/&#10;    V_NR_SEQ := PACK_TCB054.RETORNA_SEQ_ITEMPARMOV(:ITEMCOMPRA.CD_ITEM,&#10;                                                   :CONTROLE.CD_EMPRESA,&#10;                                                   :GLOBAL.CD_USUARIO,&#10;                                                   :GLOBAL.CD_MODULO,&#10;                                                   :GLOBAL.CD_PROGRAMA);                               &#10;    &#10;    &#10;    IF V_NR_SEQ IS NOT NULL THEN&#10;      V_ST_OBRIGATORIO := FALSE;&#10;      &#10;      /* Verifico se existe pelo menos uma movimentação obrigatória&#10;       * pois se possuir, deverá obrigatóriamente informar alguma movimentação&#10;       * cadastrada no TCB054. Caso não possua, o usuário terá a opção de &#10;       * apertar o esc e o processo segue como era antes.&#10;       */&#10;      FOR I IN CUR_ITEMPARMOV(V_NR_SEQ) LOOP&#10;        IF NVL(I.ST_OBRIGATORIO,'N') = 'S' THEN&#10;          V_ST_OBRIGATORIO := TRUE;&#10;          EXIT;&#10;        END IF;&#10;      END LOOP;&#10;    &#10;      IF V_ST_OBRIGATORIO THEN&#10;        FOR I IN CUR_ITEMPARMOV(V_NR_SEQ) LOOP&#10;          IF I.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO THEN&#10;            V_ST_OBRIGATORIO := FALSE;&#10;            EXIT;&#10;          END IF;&#10;        END LOOP;&#10;        /*Se a variavel ainda for verdadeira, quer dizer que a movimentacao n existe no TCB054*/&#10;        IF V_ST_OBRIGATORIO THEN&#10;          BEGIN&#10;            SELECT STRING_AGG(CD_MOVIMENTACAO)&#10;              INTO V_DS_MOVIMENTACAO&#10;              FROM ITEMPARMOV&#10;             WHERE ITEMPARMOV.NR_SEQUENCIAL = V_NR_SEQ;&#10;          EXCEPTION&#10;            WHEN NO_DATA_FOUND THEN&#10;              V_DS_MOVIMENTACAO := NULL;&#10;            WHEN OTHERS THEN&#10;             V_DS_MOVIMENTACAO := NULL;&#10;          END;&#10;          --Como existe pelo menos uma movimentação parametrizada para o item ¢CD_ITEM¢ como obrigatória no TCB054, &#10;          --é necessário informar um das seguintes movimentações ¢DS_MOVIMENTACOES¢&#10;          V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32020, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢DS_MOVIMENTACOES='||V_DS_MOVIMENTACAO||'¢');&#10;          RAISE E_GERAL;&#10;          &#10;          --GO_ITEM('ITEMPEDIDO.CD_ITEM');&#10;        END IF;  &#10;      END IF;&#10;    END IF;&#10;    &#10;     IF PACK_GLOBAL.TP_SELECAOCONTA = 'O' THEN&#10;       /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padrão da função VALIDA_SELECAOCONTA quando for 'CO'*/&#10;       V_MENSAGEM := VALIDA_SELECAOCONTA (:CONTROLE.CD_EMPRESA,&#10;                                         :ITEMCOMPRA.CD_ITEM,&#10;                                         :ITEMCOMPRA.CD_MOVIMENTACAO, &#10;                                         NULL, 'CO');&#10;      IF (V_MENSAGEM IS NOT NULL) AND (V_MENSAGEM &#60;> 'S') THEN&#10;        RAISE E_GERAL;&#10;      END IF;                                                                   &#10;    END IF;&#10;    /* DCS:05/04/2012:34604&#10;     * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO, ao inves do VALIDA_CONTABIL&#10;     * este possui validação para não permitir realizar lançamentos em contas, &#10;     * que não pertencem a versão do plano de contas da empresa do lançamento&#10;     */&#10;    --PACK_VALIDA.VALIDA_CONTABIL(:ITEMCOMPRA.CD_MOVIMENTACAO,NULL,TRUNC(SYSDATE),I_MENSAGEM);&#10;    PACK_VALIDA.VALIDA_CONTABIL_PLANO(:ITEMCOMPRA.CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA), V_MENSAGEM);&#10;    &#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      RAISE E_GERAL;&#10;    END IF;&#10;&#10;    BEGIN&#10;      /*CSL:30/12/2013:64869*/&#10;      IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;        SELECT CMI.CD_OPERESTOQUE, &#10;               PARMOVIMENT.DS_MOVIMENTACAO,&#10;               PLANOCONTABIL.TP_CONTACONTABIL&#10;          INTO V_CD_OPERESTOQUE, &#10;               V_DS_MOVIMENTACAO,&#10;               :ITEMCOMPRA.TP_CONTACONTABIL&#10;          FROM PARMOVIMENT, &#10;               CMI,&#10;               HISTCONTB,&#10;               PLANOCONTABIL&#10;          WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;             AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#10;             AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#10;            AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#10;           AND CMI.TP_FATES                = '0';&#10;      ELSE&#10;        SELECT CMI.CD_OPERESTOQUE, &#10;               PARMOVIMENT.DS_MOVIMENTACAO,&#10;               PLANOCONTABILVERSAO.TP_CONTACONTABIL&#10;          INTO V_CD_OPERESTOQUE, &#10;               V_DS_MOVIMENTACAO,&#10;               :ITEMCOMPRA.TP_CONTACONTABIL&#10;          FROM PARMOVIMENT, &#10;               CMI,&#10;               HISTCONTB,&#10;               PLANOCONTABILVERSAO&#10;          WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;             AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#10;             AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#10;            AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#10;            AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#10;                PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE))&#10;           AND CMI.TP_FATES                = '0';&#10;      END IF;      &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        /*CSL:22115:10/06/09&#10;         *Alterada a mensagem: 'Caracteristicas da movimentação :ITEMCOMPRA.CD_MOVIMENTACAO não encontrados.' &#10;         */&#10;        --Movimentação ¢CD_MOVIMENTACAO¢ inválida para esta operação. Verifique se o CMI desta movimentação é do tipo ENTRADA. Verifique TCB008/TCB002. &#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4723,'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN TOO_MANY_ROWS THEN&#10;        --A Movimentação ¢CD_MOVIMENTACAO¢ está cadastrada várias vezes. Verifique TCB008.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(47,'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        --Erro ao Pesquisar a Movimentação ¢CD_MOVIMENTACAO¢. Verifique TCB008. Erro ¢SQLERRM¢.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(48,'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢SQLERRM='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;      IF V_CD_OPERESTOQUE IS NOT NULL THEN&#10;        VALIDA_MOVIMENTACAO(V_MENSAGEM);&#10;        IF V_MENSAGEM IS NOT NULL THEN&#10;          RAISE E_GERAL;&#10;        --  RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;      END IF;&#10;      &#10;      IF NVL(:ITEMCOMPRA.TP_CONTACONTABIL,'XXX') &#60;> 'CC' THEN&#10;        VALIDA_CONTA_ORCAMENTO('ITEMCOMPRA.CD_CONTAORCAMENTO', :ITEMCOMPRA.CD_MOVIMENTACAO, NULL);&#10;      END IF;  &#10;      &#10;  -----------------------------------------------------------------------------------------------------------------&#10;  --VALIDA SE A MOVIMENTAÇÃO POSSUI RESTRIÇÃO PARA O CENTRO DE CUSTO (TCB053)&#10;  --AUG:122414:24/05/2018&#10;  -----------------------------------------------------------------------------------------------------------------      &#10;    IF :ITEMCOMPRA.CD_MOVIMENTACAO       IS NOT NULL AND&#10;       :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#10;    &#10;    /*RETORNO: S = POSSUI RESTRIÇÃO&#10;     *          N = NÃO POSSUI RESTRIÇÃO CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#10;     */&#10;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRA.CD_MOVIMENTACAO,&#10;                                                       :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;      IF NVL(V_ST_ATIVO,'N') = 'S' THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, '¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    END IF;      &#10;  ELSE&#10;    V_DS_MOVIMENTACAO := NULL;&#10;  END IF;&#10;&#10;  PACK_PROCEDIMENTOS.VALIDA_LOCALARMAZ(V_MENSAGEM);  --eml:25/05/2020:148401&#10;  IF V_MENSAGEM IS NOT NULL THEN&#10;    RAISE E_GERAL;&#10;  END IF;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);  &#10;    RAISE FORM_TRIGGER_FAILURE;  &#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_NR_SEQ          ITEMREGRAPARMOV.NR_SEQUENCIAL%TYPE;--AUG:127526:03/01/2019&#10;  V_ST_OBRIGATORIO   BOOLEAN;--AUG:127526:03/01/2019&#10;  &#10;  CURSOR CUR_ITEMPARMOV(C_NR_SEQ IN NUMBER) IS&#10;    SELECT ST_OBRIGATORIO,&#10;           CD_MOVIMENTACAO&#10;      FROM ITEMPARMOV&#10;     WHERE ITEMPARMOV.NR_SEQUENCIAL = C_NR_SEQ;&#10;BEGIN&#10;    /*AUG:127526:03/01/2019*/&#10;  V_NR_SEQ := PACK_TCB054.RETORNA_SEQ_ITEMPARMOV(:ITEMCOMPRA.CD_ITEM,&#10;                                                 :CONTROLE.CD_EMPRESA,&#10;                                                 :GLOBAL.CD_USUARIO,&#10;                                                 :GLOBAL.CD_MODULO,&#10;                                                 :GLOBAL.CD_PROGRAMA);                                                                   &#10;  /* Verifico se existe pelo menos uma movimentação obrigatória&#10;   * pois se possuir, deverá obrigatóriamente informar alguma movimentação&#10;   * cadastrada no TCB054. Caso não possua, o usuário terá a opção de &#10;   * apertar o esc e o processo segue como era antes.&#10;   */&#10;  FOR I IN CUR_ITEMPARMOV(V_NR_SEQ) LOOP&#10;    IF NVL(I.ST_OBRIGATORIO,'N') = 'S' THEN&#10;      V_ST_OBRIGATORIO := TRUE;&#10;      EXIT;&#10;    END IF;&#10;  END LOOP;&#10;  &#10;  IF V_ST_OBRIGATORIO THEN&#10;    SET_LOV_PROPERTY('LOV_ITEMPARMOV',GROUP_NAME,'LOV_ITEMPARMOV');    &#10;     IF SHOW_LOV('LOV_ITEMPARMOV') THEN&#10;          NULL;&#10;     END IF;&#10;     ELSE--&#10;&#10;   SET_LOV_PROPERTY('LOV_MOVIMENTACAO1',GROUP_NAME, 'LOV_MOVIMENTACAO1');         &#10;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'X') IN ('O','S') &#10;      AND SHOW_LOV('LOV_MOVIMENTACAO1') THEN&#10;       NULL; &#10;    ELSE            &#10;     SET_LOV_PROPERTY('LOV_MOVIMENTACAO',GROUP_NAME, 'LOV_MOVIMENTACAO');&#10;        IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'S')= 'S' &#10;          AND SHOW_LOV('LOV_MOVIMENTACAO') THEN&#10;           NULL;&#10;       END IF;&#10;   END IF;&#10;  END IF;  &#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  VALIDATE(ITEM_SCOPE);&#10;  IF NOT FORM_SUCCESS THEN&#10;    RETURN;&#10;  END IF;&#10;  NEXT_ITEM;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PREVISTA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Quantidade a Solicitar. Somente será aceito casas decimais para este campo se o tipo de cálculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade a Solicitar.Somente será aceito casas decimais para este campo se o tipo de cálculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;    V_TP_UNIDMED   TIPOCALCULOPRECO.TP_UNIDMED%TYPE;  &#10;BEGIN  &#10;    IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL AND :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;      BEGIN&#10;        SELECT TIPOCALCULOPRECO.TP_UNIDMED&#10;          INTO V_TP_UNIDMED&#10;          FROM TIPOCALCULOPRECO, &#10;               ITEMEMPRESA&#10;          WHERE TIPOCALCULOPRECO.CD_TIPOCALCULO = ITEMEMPRESA.CD_TIPOCALCULO&#10;            AND ITEMEMPRESA.CD_EMPRESA          = :ITEMCOMPRA.CD_EMPRESA&#10;            AND ITEMEMPRESA.CD_ITEM             = :ITEMCOMPRA.CD_ITEM;&#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;           --O item ¢CD_ITEM¢ na empresa ¢CD_EMPRESA¢ não possui tipo de cálculo cadastrado. Verifique TIT001, page Empresas.&#10;          MENSAGEM_PADRAO(2886, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        WHEN TOO_MANY_ROWS THEN&#10;          --O item ¢CD_ITEM¢ na empresa ¢CD_EMPRESA¢ possui vários tipos de cálculo cadastrado. Verifique TIT001.&#10;          MENSAGEM_PADRAO(4487, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢');&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        WHEN OTHERS THEN&#10;          --Ocorreu erro ao pesquisar tipo de cálculo para o item ¢CD_ITEM¢ na empresa ¢CD_EMPRESA¢ possui vários tipo de cálculo cadastrado. Erro ¢SQLERRM¢.&#10;          MENSAGEM_PADRAO(4488, '¢CD_ITEM='||:ITEMCOMPRA.CD_ITEM||'¢CD_EMPRESA='||:ITEMCOMPRA.CD_EMPRESA||'¢SQLERRM='||SQLERRM||'¢');&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;      END;&#10;    PACK_GLOBAL.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#10;    PACK_GLOBAL.VALIDA_QUANTIDADE := TRUE;&#10;    SYNCHRONIZE;    &#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;V_ST_UNIDADEITENS  VARCHAR2(1);&#10;&#10;BEGIN  &#10;  --Foi modificado este conceito do compras&#10;  --Pois na Averama pode diminuir uma quantidade Solicitada&#10;  IF :ITEMCOMPRA.QT_PREVISTA IS NOT NULL THEN &#10;    IF :ITEMCOMPRA.QT_PREVISTA &#60; PACK_GLOBAL.QT_PREVISTA AND PACK_GLOBAL.VALIDA_QUANTIDADE THEN&#10;      IF SHOW_ALERT('ALR_DIMINUIR')  = ALERT_BUTTON2 THEN&#10;        :ITEMCOMPRA.QT_PREVISTA  :=  PACK_GLOBAL.QT_PREVISTA;&#10;      ELSE&#10;        PACK_GLOBAL.VALIDA_QUANTIDADE := FALSE;&#10;      END IF;  &#10;    END IF;&#10;    /**FLA:26/11/2019:141242&#10;     * Lógica do Parâmetro que permite informar mais de uma unidade para Item de serviço&#10;     */&#10;    V_ST_UNIDADEITENS := NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'ST_UNIDADEITENS'), 'N');&#10;    IF PACK_GLOBAL.TP_ITEM = 'S' AND V_ST_UNIDADEITENS = 'N' THEN&#10;      :ITEMCOMPRA.QT_PREVISTA := 1;&#10;    END IF;&#10;    IF (:ITEMCOMPRA.QT_PREVISTA IS NULL) OR  (:ITEMCOMPRA.QT_PREVISTA = 0)THEN &#10;      --A quantidade deve ser informada.&#10;      MENSAGEM_PADRAO(1827,'');&#10;    /** WLV:13/08/2012:41514&#10;      * Comentado o GO_ITEM abaixo pois não há a necessidade, e estava errado com os dois pontos na frente do nome do bloco&#10;      */   &#10;      --GO_ITEM(':ITEMCOMPRA.QT_PREVISTA');&#10;      :ITEMCOMPRA.QT_PREVISTA := NULL;    &#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_DS_MOVIMENTACAO VARCHAR2(60);&#10;  VL_ESTIMADO       NUMBER;&#10;  V_MENSAGEM        VARCHAR2(32000);&#10;  E_GERAL            EXCEPTION;&#10;BEGIN  &#10;  VALIDATE (ITEM_SCOPE);&#10;  IF NOT FORM_SUCCESS THEN&#10;    RETURN;&#10;  END IF;&#10;  &#10;  VALIDATE (RECORD_SCOPE);&#10;  IF NOT FORM_SUCCESS THEN&#10;    RETURN;&#10;  END IF;&#10;  &#10;  IF (:ITEMCOMPRA.QT_PREVISTA > 0) THEN&#10;    /*MGK:52401:03/12/12 - Adicionada verificação para que itens de quantidade tenham a QT_PREVISTA arredondada.*/&#10;    DEFINIR_ROUND(I_CD_ITEM  => :ITEMCOMPRA.CD_ITEM,&#10;                  O_MENSAGEM => V_MENSAGEM);&#10;  &#10;    IF (V_MENSAGEM IS NOT NULL) THEN                      &#10;      RAISE E_GERAL;&#10;    END IF;&#10;  END IF;--IF (:ITEMCOMPRA.QT_PREVISTA > 0) THEN&#10;  &#10;  BEGIN&#10;    /*CSL:30/12/2013:64869*/&#10;    IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;      SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;             PLANOCONTABIL.TP_CONTACONTABIL&#10;        INTO V_DS_MOVIMENTACAO,&#10;             :ITEMCOMPRA.TP_CONTACONTABIL&#10;        FROM PARMOVIMENT,&#10;             HISTCONTB,&#10;             PLANOCONTABIL&#10;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#10;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL;&#10;    ELSE&#10;      SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;             PLANOCONTABILVERSAO.TP_CONTACONTABIL&#10;        INTO V_DS_MOVIMENTACAO,&#10;             :ITEMCOMPRA.TP_CONTACONTABIL&#10;        FROM PARMOVIMENT,&#10;             HISTCONTB,&#10;             PLANOCONTABILVERSAO&#10;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#10;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#10;          AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#10;             PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));&#10;    END IF;    &#10;  EXCEPTION &#10;    WHEN NO_DATA_FOUND THEN&#10;      NULL;&#10;  END;  &#10;  /* GDG: 22978 : 13/11/2009 &#10;   * Quando for realizado o pedido de um novo item(item este em que não há registro de compra na empresa)&#10;   * o programa abrirá uma janela para que o usuário que está abrindo a solicitação de compra informe&#10;   * um valor estimado de quanto vai custar cada unidade do referido item.&#10;   * Quando esse item já tiver um registro de compra, o programa pegará automaticamente o ultimo valor&#10;   * negociado para o item (valor unitário da ultima compra).&#10;   * Esses valores serão gravados somente se o parâmetro do COM009 estiver marcado ('Permitir inserir valor estimado (COM009)').&#10;   * Quando essa informação ser gravada, será possivel visualizá-la no COM002, em datelhes da solicitação.&#10;   */&#10;  IF :ITEMCOMPRA.QT_PREVISTA > 0 &#10;   AND :ITEMCOMPRA.VL_ESTIMADO IS NULL &#10;   AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:GLOBAL.CD_EMPRESA,'CHK_VLESTIMADO_COM001'),'N') = 'S' THEN&#10;    BEGIN      &#10;      SELECT ITEMPEDIDOCOMPRA.VL_UNITITEM&#10;        INTO VL_ESTIMADO&#10;         FROM ITEMPEDIDOCOMPRA&#10;        WHERE ITEMPEDIDOCOMPRA.CD_ITEM    = :ITEMCOMPRA.CD_ITEM&#10;          AND ITEMPEDIDOCOMPRA.CD_EMPRESA = :CONTROLE.CD_EMPRESA&#10;          AND ITEMPEDIDOCOMPRA.NR_PEDIDO  = (SELECT MAX(ITEMPEDIDOCOMPRA.NR_PEDIDO)&#10;                                              FROM ITEMPEDIDOCOMPRA&#10;                                             WHERE ITEMPEDIDOCOMPRA.CD_EMPRESA = :CONTROLE.CD_EMPRESA&#10;                                               AND ITEMPEDIDOCOMPRA.CD_ITEM    = :ITEMCOMPRA.CD_ITEM);&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;         VL_ESTIMADO := NULL;&#10;    END;  &#10;    IF VL_ESTIMADO IS NULL THEN&#10;      CENTRALIZA_FORM('WIN_ITEMCOMPRA', 'WIN_VLESTIMADO');&#10;      GO_ITEM('ITEMCOMPRA_AUX.VL_ESTIMADO_AUX');&#10;    ELSE      &#10;      :ITEMCOMPRA.VL_ESTIMADO := VL_ESTIMADO;&#10;    END IF;&#10;  ELSE      &#10;    IF :ITEMCOMPRA.TP_CONTACONTABIL = 'CC'  THEN&#10;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;        IF :ITEMCOMPRA.QT_PREVISTA > 0 THEN&#10;          --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#10;          GO_BLOCK('ITEMCOMPRACCUSTO');&#10;          SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;          PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM); &#10;        ELSE&#10;          --O campo Quantidade deve ser informado.&#10;          MENSAGEM_PADRAO(3654,'');&#10;          GO_ITEM('ITEMCOMPRA.QT_PREVISTA');&#10;        END IF;  &#10;      END IF;&#10;        &#10;    ELSIF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_OBRIGARATEIONEGOCIO'),'N') = 'S' THEN&#10;      -- TRATAMENTO DE RATEIO POR NEGOCIO    &#10;      GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;      PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM);   &#10;    ELSE&#10;  --    NEXT_RECORD;&#10;     -- GO_ITEM('ITEMCOMPRA.CD_ITEM');&#10;     GO_ITEM('ITEMCOMPRA.CD_TIPOLOCALARMAZ');&#10;    END IF;&#10;  END IF;&#10;  :CONTROLE.ST_MUDAUTORIZADOR := 'S';&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
<node TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL      EXCEPTION;&#10;&#10;BEGIN  &#10;  IF (:ITEMCOMPRA.QT_PREVISTA > 0) THEN&#10;    /*MGK:52401:07/12/12 - Adicionada verificação para que itens de quantidade tenham a QT_PREVISTA arredondada.*/&#10;    DEFINIR_ROUND(I_CD_ITEM  => :ITEMCOMPRA.CD_ITEM,&#10;                  O_MENSAGEM => V_MENSAGEM);&#10;  &#10;    IF (V_MENSAGEM IS NOT NULL) THEN                      &#10;      RAISE E_GERAL;&#10;    END IF;&#10;  END IF;--IF (:ITEMCOMPRA.QT_PREVISTA > 0) THEN&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="VL_ESTIMADO: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="BTN_CENTROCUSTO: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE &#10;  V_CD_OPERESTOQUE    CMI.CD_OPERESTOQUE%TYPE;&#10;  V_DS_MOVIMENTACAO   VARCHAR2(60);&#10;  V_MENSAGEM           VARCHAR2(32000);&#10;  E_GERAL             EXCEPTION;&#10;  V_ST_LANCAMOV VARCHAR2(10);&#10;  V_ALERT       NUMBER;&#10;  V_TP_INFORME  VARCHAR2(10);&#10;BEGIN  &#10;  VALIDATE(RECORD_SCOPE);&#10;  IF NOT FORM_SUCCESS THEN&#10;    RETURN;&#10;  END IF;&#10;  &#10;  BEGIN&#10;    /*CSL:30/12/2013:64869*/&#10;    IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;      SELECT CMI.CD_OPERESTOQUE, &#10;             PARMOVIMENT.DS_MOVIMENTACAO,&#10;             PLANOCONTABIL.TP_CONTACONTABIL&#10;        INTO V_CD_OPERESTOQUE, &#10;             V_DS_MOVIMENTACAO,&#10;             :ITEMCOMPRA.TP_CONTACONTABIL&#10;        FROM PARMOVIMENT, &#10;             CMI,&#10;             HISTCONTB,&#10;             PLANOCONTABIL&#10;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;           AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#10;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#10;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABIL.CD_CONTACONTABIL&#10;         AND CMI.TP_FATES                = '0';&#10;    ELSE&#10;      SELECT CMI.CD_OPERESTOQUE, &#10;             PARMOVIMENT.DS_MOVIMENTACAO,&#10;             PLANOCONTABILVERSAO.TP_CONTACONTABIL&#10;        INTO V_CD_OPERESTOQUE, &#10;             V_DS_MOVIMENTACAO,&#10;             :ITEMCOMPRA.TP_CONTACONTABIL&#10;        FROM PARMOVIMENT, &#10;             CMI,&#10;             HISTCONTB,&#10;             PLANOCONTABILVERSAO&#10;        WHERE PARMOVIMENT.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;           AND PARMOVIMENT.CD_CMI          = CMI.CD_CMI&#10;           AND PARMOVIMENT.CD_HISTCONTB    = HISTCONTB.CD_HISTCONTB&#10;          AND HISTCONTB.CD_CONTACONTABIL  = PLANOCONTABILVERSAO.CD_CONTACONTABIL&#10;          AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#10;              PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:CONTROLE.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE))&#10;         AND CMI.TP_FATES                = '0';&#10;    END IF;      &#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      /*CSL:22115:10/06/09&#10;       *Alterada a mensagem: 'Caracteristicas da movimentação :ITEMCOMPRA.CD_MOVIMENTACAO não encontrados.' &#10;       */&#10;      --Movimentação ¢CD_MOVIMENTACAO¢ inválida para esta operação. Verifique se o CMI desta movimentação é do tipo ENTRADA. Verifique TCB008/TCB002. &#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(4723,'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;      RAISE E_GERAL;&#10;    WHEN TOO_MANY_ROWS THEN&#10;      --A Movimentação ¢CD_MOVIMENTACAO¢ está cadastrada várias vezes. Verifique TCB008.&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(47,'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢');&#10;      RAISE E_GERAL;&#10;    WHEN OTHERS THEN&#10;      --Erro ao Pesquisar a Movimentação ¢CD_MOVIMENTACAO¢. Verifique TCB008. Erro ¢SQLERRM¢.&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(48,'¢CD_MOVIMENTACAO='||:ITEMCOMPRA.CD_MOVIMENTACAO||'¢SQLERRM='||SQLERRM||'¢');&#10;      RAISE E_GERAL;&#10;  END;&#10;  &#10;  SELECT NVL(ST_LANCAMOV,'N') &#10;    INTO V_ST_LANCAMOV&#10;    FROM PARMCOMPRA&#10;   WHERE CD_EMPRESA = :GLOBAL.CD_EMPRESA;&#10;  &#10;  --- IF PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,'COMPRAS') = 'S' AND &#10;  ---   NVL(PACK_PARMGEN.CONSULTA_PARAMETRO ('ORC',50,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CONTAORCCOMPRAS'),'N') = 'S' THEN      &#10;  V_TP_INFORME := 'S';&#10;  FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.COUNT LOOP&#10;    IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO.EXISTS(I) AND PACK_PROCEDIMENTOS.VET_ITEMCOMPRACCUSTO(I).CD_ITEM = :ITEMCOMPRA.CD_ITEM THEN&#10;      V_TP_INFORME := 'C';&#10;      EXIT;&#10;    END IF;  &#10;  END LOOP;  &#10;  &#10;  IF V_TP_INFORME = 'S' THEN&#10;    FOR I IN 1..PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.COUNT LOOP&#10;      IF PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO.EXISTS(I) AND PACK_PROCEDIMENTOS.VET_ITEMCOMPRANEGOCIO(I).CD_ITEM = :ITEMCOMPRA.CD_ITEM THEN&#10;        V_TP_INFORME := 'N';&#10;        EXIT;&#10;      END IF;  &#10;    END LOOP;  &#10;  END IF;&#10;  &#10;  IF V_TP_INFORME = 'C' THEN&#10;    --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#10;    GO_BLOCK('ITEMCOMPRACCUSTO');&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;    PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM); &#10;  ELSIF V_TP_INFORME = 'N' THEN&#10;    -- TRATAMENTO DE RATEIO POR NEGOCIO&#10;    GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;    SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;  &#10;    PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM); &#10;  ELSE&#10;    &#10;    IF V_ST_LANCAMOV = 'S' OR :ITEMCOMPRA.TP_CONTACONTABIL = 'CC' OR &#10;      PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,'COMPRAS') = 'S' THEN  &#10;      IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;        IF :ITEMCOMPRA.QT_PREVISTA > 0 THEN&#10;          &#10;          IF :ITEMCOMPRA.TP_CONTACONTABIL &#60;> 'CC' &#10;            AND (PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,'COMPRAS') = 'S' AND  V_ST_LANCAMOV = 'S' ) THEN&#10;            V_ALERT := SHOW_ALERT('ALERTA_TIPORATEIO');&#10;            &#10;            IF V_ALERT = ALERT_BUTTON1 THEN&#10;              -- TRATAMENTO DE RATEIO POR NEGOCIO&#10;              GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;              SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;            &#10;              PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM); &#10;                                   &#10;            ELSIF V_ALERT = ALERT_BUTTON2 THEN&#10;              --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#10;              GO_BLOCK('ITEMCOMPRACCUSTO');&#10;              SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;              PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM);              &#10;            ELSE  &#10;              NULL;&#10;            END IF;&#10;          ELSIF :ITEMCOMPRA.TP_CONTACONTABIL &#60;> 'CC' &#10;            AND (PACK_ORCOMPRAS.VALIDA_CONTROLE_ORC051(:ITEMCOMPRA.CD_EMPRESA,'COMPRAS') = 'S' AND  V_ST_LANCAMOV = 'N' ) THEN&#10;              -- TRATAMENTO DE RATEIO POR NEGOCIO&#10;            GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;            SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;            PACK_GRUPO_NEGOCIO.CARREGA_DADOS_NEGOCIO(:ITEMCOMPRA.CD_ITEM); &#10;            &#10;          ELSE  &#10;            &#10;            --Preenche o bloco com os dados do grupo para as linhas com nr_registro = :GLOBAL.NR_REGISTRO&#10;            GO_BLOCK('ITEMCOMPRACCUSTO');&#10;            SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;            PACK_GRUPO.CARREGA_DADOS_CC(:ITEMCOMPRA.CD_ITEM);          &#10;          END IF;&#10;        ELSE&#10;          --A quantidade deve ser informada.&#10;          MENSAGEM_PADRAO(1827,'');&#10;          GO_ITEM('ITEMCOMPRA.QT_PREVISTA');&#10;        END IF;  &#10;      END IF;  &#10;    END IF;&#10;  END IF;  &#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN &#10;    NULL;  &#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);  &#10;    RAISE FORM_TRIGGER_FAILURE;  &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_SEL_ANEXO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_ANEXO     ARQUIVO.DS_ARQUIVO%TYPE;&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL     EXCEPTION;&#10;BEGIN  &#10;  IF :ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#10;    &#10;    IF NOT PACK_PROCEDIMENTOS.EXISTE_ARQUIVOS(:ITEMCOMPRA.CD_EMPRESA,:SYSTEM.CURSOR_RECORD) THEN&#10;      V_ANEXO := GET_FILE_NAME(NULL, NULL, NULL, 'Arquivo para Anexo', OPEN_FILE, TRUE);&#10;      &#10;      --:ITEMCOMPRA.DS_ARQUIVO := V_ANEXO;&#10;      PACK_PROCEDIMENTOS.GRAVA_ARQUIVOS_VETOR(:ITEMCOMPRA.CD_EMPRESA,&#10;                                              :SYSTEM.CURSOR_RECORD, &#10;                                              V_ANEXO,&#10;                                              V_MENSAGEM);&#10;          &#10;      IF V_MENSAGEM IS NOT NULL THEN&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    ELSE&#10;      IF NOT MSG_CONFIRMACAO('Essa solicitação já tem um anexo salvo, deseja cadastrar mais um?') THEN&#10;        RETURN;&#10;      END IF;&#10;      &#10;      V_ANEXO := GET_FILE_NAME(NULL, NULL, NULL, 'Arquivo para Anexo', OPEN_FILE, TRUE);&#10;    &#10;      PACK_PROCEDIMENTOS.GRAVA_ARQUIVOS_VETOR(:ITEMCOMPRA.CD_EMPRESA,&#10;                                              :SYSTEM.CURSOR_RECORD, &#10;                                              V_ANEXO,                                                &#10;                                              V_MENSAGEM);&#10;    &#10;      IF V_MENSAGEM IS NOT NULL THEN&#10;        RAISE E_GERAL;&#10;      END IF;&#10;      &#10;    END IF;  &#10;      &#10;  ELSE&#10;    -- Só é possível verificar se o anexo é permitido após ser informado o número da empresa, &#10;    -- portanto se for nulo alertar o usuário&#10;    /*O campo ¢NM_CAMPO¢ deve ser informado.*/&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1545, '¢NM_CAMPO='||'Empresa'||'¢');&#10;    RAISE E_GERAL;&#10;  END IF;                    &#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Observação', V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA,3,0)||' - Erro', SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_TIPOLOCALARMAZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Tipo Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA.CD_TIPOLOCALARMAZ IS NOT NULL THEN    &#10;    SELECT DISTINCT LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ&#10;      INTO :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#10;      FROM LOCALARMAZENAGEM&#10;     WHERE LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ &#10;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;&#10;       &#10;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;         &#10;  END IF;  &#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    --O Tipo de Local de Armazenagem ¢CD_TIPOLOCALARMAZ¢ não está cadastrado. Verifique TES001.&#10;    MENSAGEM_PADRAO(123,'¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ||'¢');    &#10;    :ITEMCOMPRA.CD_TIPOLOCALARMAZ := NULL;&#10;    RAISE FORM_TRIGGER_FAILURE; &#10;  WHEN OTHERS THEN&#10;    --Ocorreu um erro inesperado ao buscar dados tipo de local de armazenagem. Erro: ¢SQLERRM¢.&#10;    MENSAGEM_PADRAO(3120,'¢SQLERRM='||SQLERRM||'¢');    &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-MOUSE-DOUBLECLICK">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM   VARCHAR2(32000);&#10;BEGIN  &#10;  PACK_PROCEDIMENTOS.VALIDA_LOCALARMAZ(V_MENSAGEM);  --eml:25/05/2020:148401&#10;  IF V_MENSAGEM IS NOT NULL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  END IF;&#10;END;  ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_LOCALARMAZ: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA.CD_LOCALARMAZ IS NOT NULL THEN&#10;    SELECT DISTINCT LOCALARMAZENAGEM.CD_LOCALARMAZ&#10;      INTO :ITEMCOMPRA.CD_LOCALARMAZ&#10;      FROM LOCALARMAZENAGEM&#10;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ   &#10;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ &#10;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA; &#10; &#10;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;     &#10;  END IF;    &#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    --O local de armazenagem (Tipo: ¢CD_TIPOLOCALARMAZ¢, ¢CD_LOCALARMAZ¢) não está cadastrado. Verifique TES002.&#10;    MENSAGEM_PADRAO(233,'¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||'¢CD_LOCALARMAZ='||:ITEMCOMPRA.CD_LOCALARMAZ||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: ¢SQLERRM¢.&#10;     MENSAGEM_PADRAO(3120,'¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ1: Char(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Sub 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ1 IS NOT NULL THEN&#10;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ1&#10;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ1&#10;      FROM LOCALARMAZENAGEM&#10;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ    &#10;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#10;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;    &#10;  &#10;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;&#10;    &#10;  END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    --O local de armazenagem (Tipo: ¢CD_TIPOLOCALARMAZ¢, ¢CD_LOCALARMAZ¢) não está cadastrado. Verifique TES002.&#10;    MENSAGEM_PADRAO(233,'¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||'¢CD_LOCALARMAZ='||:ITEMCOMPRA.CD_LOCALARMAZ||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: ¢SQLERRM¢.&#10;     MENSAGEM_PADRAO(3120,'¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;    &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ2: Button(7)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Sub 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ2 IS NOT NULL THEN&#10;&#10;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ2&#10;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ2&#10;      FROM LOCALARMAZENAGEM&#10;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ    &#10;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2  &#10;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;  &#10;&#10;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    --O local de armazenagem (Tipo: ¢CD_TIPOLOCALARMAZ¢, ¢CD_LOCALARMAZ¢) não está cadastrado. Verifique TES002.&#10;    MENSAGEM_PADRAO(233,'¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||'¢CD_LOCALARMAZ='||:ITEMCOMPRA.CD_LOCALARMAZ||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: ¢SQLERRM¢.&#10;     MENSAGEM_PADRAO(3120,'¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ3: Button(2)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Sub 3">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ3 IS NOT NULL THEN&#10;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ3&#10;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ3&#10;      FROM LOCALARMAZENAGEM&#10;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ     &#10;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2  &#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3  &#10;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA;      &#10;  &#10;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM; &#10;  END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    --O local de armazenagem (Tipo: ¢CD_TIPOLOCALARMAZ¢, ¢CD_LOCALARMAZ¢) não está cadastrado. Verifique TES002.&#10;    MENSAGEM_PADRAO(233,'¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||'¢CD_LOCALARMAZ='||:ITEMCOMPRA.CD_LOCALARMAZ||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: ¢SQLERRM¢.&#10;     MENSAGEM_PADRAO(3120,'¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ4: Button(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Sub 4">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA.NR_SUBLOCARMAZ4 IS NOT NULL THEN&#10;    SELECT DISTINCT LOCALARMAZENAGEM.NR_SUBLOCARMAZ4&#10;      INTO :ITEMCOMPRA.NR_SUBLOCARMAZ4&#10;      FROM LOCALARMAZENAGEM&#10;     WHERE LOCALARMAZENAGEM.CD_LOCALARMAZ     = :ITEMCOMPRA.CD_LOCALARMAZ     &#10;       AND LOCALARMAZENAGEM.CD_TIPOLOCALARMAZ = :ITEMCOMPRA.CD_TIPOLOCALARMAZ&#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ1   = :ITEMCOMPRA.NR_SUBLOCARMAZ1  &#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ2   = :ITEMCOMPRA.NR_SUBLOCARMAZ2  &#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ3   = :ITEMCOMPRA.NR_SUBLOCARMAZ3  &#10;       AND LOCALARMAZENAGEM.NR_SUBLOCARMAZ4   = :ITEMCOMPRA.NR_SUBLOCARMAZ4&#10;       AND LOCALARMAZENAGEM.CD_EMPRESA        = :ITEMCOMPRA.CD_EMPRESA; &#10;       &#10;    PACK_PROCEDIMENTOS.CONSULTA_NM_LOCALARMAZENAGEM;    &#10;  END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    --O local de armazenagem (Tipo: ¢CD_TIPOLOCALARMAZ¢, ¢CD_LOCALARMAZ¢) não está cadastrado. Verifique TES002.&#10;    MENSAGEM_PADRAO(233,'¢CD_TIPOLOCALARMAZ='||:ITEMCOMPRA.CD_TIPOLOCALARMAZ ||'¢CD_LOCALARMAZ='||:ITEMCOMPRA.CD_LOCALARMAZ||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    --Ocorreu um erro inesperado ao buscar dados do local de armazenagem. Erro: ¢SQLERRM¢.&#10;     MENSAGEM_PADRAO(3120,'¢SQLERRM='||SQLERRM||'¢');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="NEXT_RECORD;                          &#10;GO_ITEM('ITEMCOMPRA.CD_ITEM');        ">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_LOCALARMAZENAGEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_HISTCONTB">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_INICIO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data Início">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Data de Início dos Serviços">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Data de Início dos Serviços">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF (:ITEMCOMPRA.DT_DESEJADA IS NOT NULL) AND (:ITEMCOMPRA.DT_INICIO IS NOT NULL) THEN&#10;    IF :ITEMCOMPRA.DT_INICIO > :ITEMCOMPRA.DT_DESEJADA THEN&#10;       --Data de início da obra deve ser menor que data desejada.&#10;       MENSAGEM_PADRAO(4698,'');&#10;       :ITEMCOMPRA.DT_INICIO := :ITEMCOMPRA.DT_DESEJADA;&#10;       RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSERVACAOEXT: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Observação Externa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Observação Externa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Observação Externa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Observação Interna">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Observação Interna">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Observação Interna">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF PACK_GLOBAL.TP_ITEM = 'S' THEN&#10;    NEXT_ITEM;&#10;  ELSE&#10;    NEXT_RECORD;&#10;    GO_ITEM('ITEMCOMPRA.CD_ITEM');&#10;  END IF;  &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEMSERVICO: Char(1000)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Descrição Serviço">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Descrição dos Serviços">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição dos Serviços">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  I_TP_ITEM VARCHAR2(01);&#10;BEGIN&#10;  IF :ITEMCOMPRA.CD_ITEM IS NOT NULL THEN&#10;    BEGIN&#10;      SELECT ITEM.TP_ITEM &#10;        INTO I_TP_ITEM &#10;        FROM ITEM &#10;       WHERE (ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM); &#10;    EXCEPTION&#10;      WHEN OTHERS THEN &#10;        NULL;&#10;    END;&#10;  &#10;    IF I_TP_ITEM = 'S' THEN&#10;      IF  :ITEMCOMPRA.DS_ITEMSERVICO IS NULL THEN&#10;         --A descrição do serviço deve ser informada.&#10;         MENSAGEM_PADRAO(4688,'');&#10;         RAISE FORM_TRIGGER_FAILURE;&#10;      END IF;&#10;      --GO_BLOCK ('ITEMCOMPRACCUSTO');&#10;      NEXT_RECORD;&#10;      GO_ITEM('ITEMCOMPRA.CD_ITEM');&#10;    END IF;&#10;  &#10;  END IF;&#10;&#10;  /*IF PACK_GLOBAL.TP_ITEM IS NOT NULL THEN &#10;    IF PACK_GLOBAL.TP_ITEM = 'S' THEN&#10;       GO_BLOCK ('ITEMCOMPRACCUSTO');   &#10;    END IF;&#10;  ELSIF PACK_GLOBAL.TP_ITEM IS NULL THEN&#10;    IF (:ITEMCOMPRA.CD_ITEM IS NOT NULL) THEN&#10;        &#10;        IF I_TP_ITEM = 'S' THEN&#10;          GO_BLOCK ('ITEMCOMPRACCUSTO');   &#10;        END IF;&#10;    END IF;&#10;  END IF;*/&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESAITEM: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresaitem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESAUTORIZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresaautoriz">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":ITEMCOMPRA.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_SOLICITANTE: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Usuasolicita">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":GLOBAL.CD_USUARIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESASOLIC: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":ITEMCOMPRA.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_SOLICITACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data Solicitação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="$$DATE$$">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_CONSOLIDACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Consolidacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_NEGOCIADA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Qt Negociada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ENDERENTREGA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Enderentrega">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_ITEMCOMPRA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="St Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="0">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_CRONOGRAMACOMPRA: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="St Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_ALTERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Alteracao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_LIBERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Liberacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_EMISSAONF: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="St Emissaonf">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMPRORIGEM: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nr Itemprorigem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_NEGOCIACAO: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nr Negociacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_RECORD: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="HR_RECORD: Char(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Hr Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSCANCEL: Char(500)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Informe o Motivo do Cancelamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('CONTROLE.BT_SALVAR');">
</node>
</node>
</node>
<node TEXT="KEY-PREV-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('CONTROLE.BT_VOLTAR');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_ST_ITEMCOMPRA    ITEMCOMPRA.ST_ITEMCOMPRA%TYPE;  &#10;BEGIN&#10;&#10;IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NOT NULL THEN&#10;     &#10;     SELECT CD_EMPRESA,              ST_ITEMCOMPRA&#10;      INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#10;      FROM ITEMCOMPRA&#10;     WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#10;       AND CD_SOLICITANTE    =    :GLOBAL.CD_USUARIO&#10;       AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;       &#10;       --Cancelado&#10;       IF V_ST_ITEMCOMPRA    =   99 THEN&#10;         mensagem('Maxys','Solicitação de compra, CANCELADA  não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;       END IF;&#10;       &#10;       --Aguardando Liberação&#10;       IF V_ST_ITEMCOMPRA   =   0  THEN&#10;         mensagem('Maxys','Status, Aguardando Liberação  não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Recusada&#10;       IF V_ST_ITEMCOMPRA   =   2  THEN&#10;         mensagem('Maxys','Status, Recusada não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Em Cotação&#10;       IF V_ST_ITEMCOMPRA   =   3  THEN&#10;         mensagem('Maxys','Status, Em Cotação não é possível atualizar... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Em Negociação ...&#10;       IF V_ST_ITEMCOMPRA   =   4  THEN&#10;         mensagem('Maxys','Status, Em Negociação não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Em Aprovação ... &#10;       IF V_ST_ITEMCOMPRA   = 5  THEN&#10;         mensagem('Maxys','Status, Em Aprovação não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Aprovação ...&#10;       IF V_ST_ITEMCOMPRA   = 6  THEN&#10;         mensagem('Maxys','Status, Aprovação não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;        &#10;       --Solicitação, Pedido Gerado ... &#10;       IF V_ST_ITEMCOMPRA   = 7  THEN&#10;         mensagem('Maxys','Status, Pedido foi Gerado não é possível atualizar, aguardando chegada  ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;         CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       -- Cotação &#10;       IF V_ST_ITEMCOMPRA   IN (1,11)  THEN&#10;         SET_BLOCK_PROPERTY('ITEMCOMPRA',DEFAULT_WHERE,'NR_ITEMCOMPRA = '||:ITEMCOMPRA.NR_ITEMCOMPRA);&#10;         EXECUTE_QUERY(NO_VALIDATE);&#10;           ---Atualiza para aguandando solicitaçao a solicitação devolvida &#10;           --------------------------------------------------------------------&#10;           IF V_ST_ITEMCOMPRA = 11 THEN &#10;             :ITEMCOMPRA.ST_ITEMCOMPRA:=0;            &#10;           END IF; &#10;           -------------------------------------------------------------------&#10;       END IF;&#10;  END IF;&#10;  NEXT_ITEM;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;     BEGIN  &#10;        SELECT CD_EMPRESA,            ST_ITEMCOMPRA&#10;         INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#10;         FROM ITEMCOMPRA&#10;        WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#10;          AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;    &#10;    mensagem('Maxys','Solicitação de compra pertence a outro Solicitante !',2);    &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;    &#10;    EXCEPTION&#10;         WHEN NO_DATA_FOUND THEN&#10;          mensagem('Maxys','Solicitação de compra não cadastrada !',2);    &#10;          RAISE FORM_TRIGGER_FAILURE;&#10;    END;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_DEPARTAMENTO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_ST_ITEMCOMPRA    ITEMCOMPRA.ST_ITEMCOMPRA%TYPE;  &#10;BEGIN&#10;&#10;IF :ITEMCOMPRA.NR_ITEMCOMPRA IS NOT NULL THEN&#10;     &#10;     SELECT CD_EMPRESA,              ST_ITEMCOMPRA&#10;      INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#10;      FROM ITEMCOMPRA&#10;     WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#10;       AND CD_SOLICITANTE    =    :GLOBAL.CD_USUARIO&#10;       AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;       &#10;       --Cancelado&#10;       IF V_ST_ITEMCOMPRA    =   99 THEN&#10;         mensagem('Maxys','Solicitação de compra, CANCELADA  não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;       END IF;&#10;       &#10;       --Aguardando Liberação&#10;       IF V_ST_ITEMCOMPRA   =   0  THEN&#10;         mensagem('Maxys','Status, Aguardando Liberação  não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Recusada&#10;       IF V_ST_ITEMCOMPRA   =   2  THEN&#10;         mensagem('Maxys','Status, Recusada não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Em Cotação&#10;       IF V_ST_ITEMCOMPRA   =   3  THEN&#10;         mensagem('Maxys','Status, Em Cotação não é possível atualizar... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Em Negociação ...&#10;       IF V_ST_ITEMCOMPRA   =   4  THEN&#10;         mensagem('Maxys','Status, Em Negociação não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Em Aprovação ... &#10;       IF V_ST_ITEMCOMPRA   = 5  THEN&#10;         mensagem('Maxys','Status, Em Aprovação não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       --Solicitação, Aprovação ...&#10;       IF V_ST_ITEMCOMPRA   = 6  THEN&#10;         mensagem('Maxys','Status, Aprovação não é possível atualizar ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;        CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;        &#10;       --Solicitação, Pedido Gerado ... &#10;       IF V_ST_ITEMCOMPRA   = 7  THEN&#10;         mensagem('Maxys','Status, Pedido foi Gerado não é possível atualizar, aguardando chegada  ... Solicitação número  '||:ITEMCOMPRA.NR_ITEMCOMPRA,2);&#10;         CLEAR_FORM(NO_VALIDATE);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;        END IF;&#10;       &#10;       -- Cotação &#10;       IF V_ST_ITEMCOMPRA   IN (1,11)  THEN&#10;         SET_BLOCK_PROPERTY('ITEMCOMPRA',DEFAULT_WHERE,'NR_ITEMCOMPRA = '||:ITEMCOMPRA.NR_ITEMCOMPRA);&#10;         EXECUTE_QUERY(NO_VALIDATE);&#10;           ---Atualiza para aguandando solicitaçao a solicitação devolvida &#10;           --------------------------------------------------------------------&#10;           IF V_ST_ITEMCOMPRA = 11 THEN &#10;             :ITEMCOMPRA.ST_ITEMCOMPRA:=0;            &#10;           END IF; &#10;           -------------------------------------------------------------------&#10;       END IF;&#10;  END IF;&#10;  NEXT_ITEM;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;     BEGIN  &#10;        SELECT CD_EMPRESA,            ST_ITEMCOMPRA&#10;         INTO :ITEMCOMPRA.CD_EMPRESA,  V_ST_ITEMCOMPRA&#10;         FROM ITEMCOMPRA&#10;        WHERE CD_EMPRESA        =   :GLOBAL.CD_EMPRESA&#10;          AND NR_ITEMCOMPRA     =   :ITEMCOMPRA.NR_ITEMCOMPRA;&#10;    &#10;    mensagem('Maxys','Solicitação de compra pertence a outro Solicitante !',2);    &#10;    RAISE FORM_TRIGGER_FAILURE;&#10;    &#10;    EXCEPTION&#10;         WHEN NO_DATA_FOUND THEN&#10;          mensagem('Maxys','Solicitação de compra não cadastrada !',2);    &#10;          RAISE FORM_TRIGGER_FAILURE;&#10;    END;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;    I_CD_AUTORIZADOR VARCHAR2(03);&#10;    MOSTRA_LOV       BOOLEAN;&#10;    &#10;BEGIN&#10;  IF :SYSTEM.RECORD_STATUS = 'INSERT' THEN -- ok                              &#10;    IF PACK_GLOBAL.ST_APROVSOLIC = 'S' THEN --OK&#10;       IF (:ITEMCOMPRA.CD_EMPRESAUTORIZ IS NOT NULL) AND (:ITEMCOMPRA.CD_EMPRESASOLIC IS NOT NULL) &#10;                                                     AND (:ITEMCOMPRA.CD_SOLICITANTE  IS NOT NULL) THEN&#10;           &#10;         I_CD_AUTORIZADOR := NULL;&#10;        MOSTRA_LOV := SHOW_LOV('LOV_AUTORIZADOR');                         &#10;       END IF;&#10;    ELSE&#10;       :ITEMCOMPRA.CD_SOLICITANTE := NULL;  &#10;       :ITEMCOMPRA.NM_USUAUTORIZ  := NULL;  &#10;    END IF;     &#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="null;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TP_CONTACONTABIL: Char(2)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_TIPOCOMPRA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DS_TIPOCOMPRA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="NR_REGISTRO: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_GRUPOCC">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA_AUX: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA_AUX: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_CONTAORCAMENTO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM THEN&#10;    IF :ITEMCOMPRA.DT_DESEJADA IS NOT NULL THEN     &#10;      IF :ITEMCOMPRA.DT_DESEJADA &#60; SYSDATE - 1 THEN&#10;        --A Data Desejada deve ser maior que a data atual!&#10;        MENSAGEM_PADRAO(4686,'');&#10;        :ITEMCOMPRA.DT_DESEJADA := SYSDATE;&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;      END IF;&#10;    END IF;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ESTUDOMONI: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_PROJETOMONI: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="NR_VERSAOMONI: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_ETAPAMONI: Number(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="ST_PROJETOMONI: Char(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_PROJETOCOMPRA: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="NR_PREITEMCOMPRA: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
</node>
</node>
<node TEXT="ITEMCOMPRACCUSTO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRCCUSTODEST: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Empresa&#10;dest. custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRCCUSTODEST">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE &#10;  V_CD_AUTORICCUSTO  ITEMCOMPRACCUSTO.CD_AUTORIZADOR%TYPE;&#10;  V_CD_AUTORICCUSTO2 ITEMCOMPRACCUSTO.CD_AUTORIZADOR%TYPE;&#10;--  V_MENSAGEM VARCHAR2(32000);&#10;BEGIN&#10;  IF :ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST IS NOT NULL THEN&#10;    :ITEMCOMPRACCUSTO.NM_EMPRESADEST := PACK_VALIDATE.RETORNA_NM_EMPRESA(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST);      &#10;    IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947             &#10;       BEGIN  &#10;        SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                                        &#10;            INTO V_CD_AUTORICCUSTO&#10;            FROM AUTORIZCCUSTORESTRITO&#10;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO--EMLLL               &#10;              AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#10;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = 'S';               &#10;         EXCEPTION &#10;           WHEN OTHERS THEN             &#10;            V_CD_AUTORICCUSTO := NULL;                                     &#10;         END;           &#10;        IF V_CD_AUTORICCUSTO IS NOT NULL THEN           &#10;          IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN                                             &#10;          /*O autorizador da tela principal deve ser informado.*/&#10;            MENSAGEM_PADRAO(33735, NULL);&#10;            RAISE FORM_TRIGGER_FAILURE;                 &#10;          END IF;&#10;          &#10;        BEGIN           &#10;          SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#10;            INTO V_CD_AUTORICCUSTO2&#10;            FROM AUTORIZCCUSTORESTRITO&#10;           WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO            &#10;            AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#10;             AND AUTORIZCCUSTORESTRITO.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#10;             AND AUTORIZCCUSTORESTRITO.ST_REGISTRO     = 'S';             &#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;             MENSAGEM_PADRAO(33731, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');  &#10;            RAISE FORM_TRIGGER_FAILURE;              &#10;        END;  &#10;       END IF;    &#10;    END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN               &#10;  ELSE&#10;    :ITEMCOMPRACCUSTO.NM_EMPRESADEST := NULL;&#10;  END IF;    &#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  :ITEMCOMPRACCUSTO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#10;  :ITEMCOMPRACCUSTO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#10;  :ITEMCOMPRACCUSTO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#10;  :ITEMCOMPRACCUSTO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#10;  :ITEMCOMPRACCUSTO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CENTROCUSTO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Centro Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  :ITEMCOMPRACCUSTO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#10;  :ITEMCOMPRACCUSTO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#10;  :ITEMCOMPRACCUSTO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#10;  :ITEMCOMPRACCUSTO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#10;  :ITEMCOMPRACCUSTO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="/**FZA:15/02/2011:33648&#10;*** Ajustado tratamento de erros, as validacoes estavam aparecendo mais de uma vez.&#10;**/&#10;DECLARE&#10;  V_ST_VALIDACCUSTO  PARMCOMPRA.ST_VALIDACCUSTO%TYPE;&#10;  V_CD_AUTORIZADOR   CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#10;  V_CD_USUARIO       CCUSTOAUTORIZ.CD_USUARIO%TYPE;&#10;  V_ST_ATIVO         RESTRINGIRMOV.ST_ATIVO%TYPE;    &#10;  V_CD_MOVIMENTACAO   NUMBER;&#10;  E_GERAL             EXCEPTION;&#10;  V_MENSAGEM         VARCHAR2(2000);&#10;--  V_CD_EMPRESA       AUTORIZCCUSTORESTRITO.CD_EMPRESA%TYPE;&#10;  V_CD_AUTORICCUSTO  AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#10;--  V_CD_AUTORICCUSTO3 AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#10;  V_CD_AUTORICCUSTO2 AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR%TYPE;&#10;--  V_CD_CENTROCUSTO   AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO%TYPE;&#10;--  V_ST_REGISTRO      AUTORIZCCUSTORESTRITO.ST_REGISTRO%TYPE;&#10;  &#10;  &#10;BEGIN&#10;  IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#10;    --FJC:05/07/2018:121701&#10;    IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CC_USUARIO'),'N') = 'S'  THEN    &#10;       BEGIN&#10;        SELECT CCUSTOAUTORIZ.CD_USUARIO&#10;           INTO V_CD_USUARIO&#10;           FROM CENTROCUSTO, CCUSTOAUTORIZ&#10;          WHERE CENTROCUSTO.CD_CENTROCUSTO    = CCUSTOAUTORIZ.CD_CENTROCUSTO&#10;            AND CCUSTOAUTORIZ.CD_USUARIO      = :GLOBAL.CD_USUARIO&#10;            AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)&#10;            AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#10;            AND NVL(CENTROCUSTO.ST_CENTROCUSTO, 'A') = 'A';          &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN          &#10;          --O Usuário ¢CD_USUARIO¢ não está autorizado para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;           MENSAGEM_PADRAO(3771,'¢CD_USUARIO='||:GLOBAL.CD_USUARIO||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;           :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#10;           :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#10;           RAISE FORM_TRIGGER_FAILURE;&#10;          WHEN TOO_MANY_ROWS THEN&#10;           V_CD_USUARIO := NULL;&#10;          WHEN OTHERS THEN&#10;            --Ocorreu um erro inesperado na busca dos dados do usuário autorizador. Erro: ¢SQLERRM¢.&#10;           MENSAGEM_PADRAO(3958,'¢SQLERRM='||SQLERRM||'¢');&#10;           RAISE FORM_TRIGGER_FAILURE;&#10;      END;            &#10;    END IF;&#10;        &#10;    DECLARE&#10;      V_ST_CENTROCUSTO  CENTROCUSTO.ST_CENTROCUSTO%TYPE;&#10;      E_GERAL EXCEPTION;&#10;    BEGIN&#10;        &#10;      /**GRA:13783:27/12/2006&#10;       * O PROCEDIMENTO ABAIXO VERIFICA SE O CENTRO DE&#10;       * CUSTO ESTÁ CADASTRADO PARA A EMPRESA INFORMADA.&#10;       */ &#10;      PACK_VALIDA.VAL_CCUSTOEMPR(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO,&#10;                                 NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRACCUSTO.CD_EMPRESA),--GDG:22/07/2011:28715&#10;                                  :GLOBAL.CD_MODULO,&#10;                                  :GLOBAL.CD_PROGRAMA,&#10;                                  :ITEMCOMPRACCUSTO.DS_CENTROCUSTO,&#10;                                  V_MENSAGEM);                            &#10;      IF V_MENSAGEM IS NOT NULL THEN  &#10;         RAISE E_GERAL;&#10;      END IF;&#10;     /* CSL:22264:30/06/09 - As duas consultas foram substituidas por uma.*/&#10;    /*SELECT CENTROCUSTO.ST_CENTROCUSTO&#10;        INTO V_ST_CENTROCUSTO&#10;        FROM CENTROCUSTO&#10;       WHERE CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#10;       &#10;      SELECT CENTROCUSTO.DS_CENTROCUSTO ,CENTROCUSTO.ST_CENTROCUSTO&#10;        INTO :ITEMCOMPRACCUSTO.DS_CENTROCUSTO,V_ST_CENTROCUSTO&#10;        FROM CENTROCUSTO&#10;       WHERE CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;*/&#10;    &#10;      SELECT ST_CENTROCUSTO, DS_CENTROCUSTO&#10;        INTO V_ST_CENTROCUSTO, :ITEMCOMPRACCUSTO.DS_CENTROCUSTO &#10;        FROM CENTROCUSTO&#10;       WHERE CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;&#10;       IF NVL(V_ST_CENTROCUSTO,'A') = 'I' THEN&#10;           --O centro de custo ¢CD_CENTROCUSTO¢ encontra-se inativo e não pode ser usado. Verifique TCB007.&#10;           V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(1509,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;           :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#10;           RAISE E_GERAL;&#10;       END IF;&#10;     &#10;    EXCEPTION&#10;      WHEN E_GERAL THEN&#10;        MENSAGEM('Maxys',V_MENSAGEM,2);&#10;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#10;        RAISE FORM_TRIGGER_FAILURE;     &#10;      WHEN NO_DATA_FOUND THEN&#10;        --O Centro de Custo ¢CD_CENTROCUSTO¢ não está cadastrado. Verifique o programa TCB007.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(254,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;        :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#10;        :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#10;        MENSAGEM('Maxys',V_MENSAGEM,2);&#10;        RAISE FORM_TRIGGER_FAILURE;     &#10;      WHEN OTHERS THEN&#10;        --Ocorreu um erro inesperado ao consultar os dados do centro de custo ¢CD_CENTROCUSTO¢. Erro: ¢SQLERRM¢.&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(999,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢SQLERREM='||SQLERRM||'¢');&#10;        MENSAGEM('Maxys',V_MENSAGEM,2);&#10;        RAISE FORM_TRIGGER_FAILURE;     &#10;    END;&#10; &#10; -----------------------------------------------------------------------------------------------------------------&#10; --VALIDA CENTRO DE CUSTO&#10; -----------------------------------------------------------------------------------------------------------------&#10;   IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;    DECLARE&#10;      E_GERAL  EXCEPTION;&#10;    BEGIN       &#10;      SELECT NVL(ST_VALIDACCUSTO,'N')&#10;        INTO V_ST_VALIDACCUSTO&#10;        FROM PARMCOMPRA&#10;       WHERE CD_EMPRESA = :ITEMCOMPRA.CD_EMPRESA;&#10;        /* CSL:22264:30/06/09 - COMPARAÇÃO INADEQUADA */&#10;        --IF V_ST_VALIDACCUSTO = 'S' THEN&#10;        IF V_ST_VALIDACCUSTO = 'C' THEN        &#10;         BEGIN&#10;          SELECT CCUSTOAUTORIZ.CD_USUARIO&#10;             INTO V_CD_AUTORIZADOR&#10;             FROM CCUSTOAUTORIZ&#10;            WHERE CCUSTOAUTORIZ.CD_USUARIO      = :CONTROLE.CD_AUTORIZADOR&#10;              AND CCUSTOAUTORIZ.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:ITEMCOMPRA.CD_EMPRESA)--GDG:22/07/2011:28715&#10;              AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#10;             AND CCUSTOAUTORIZ.TP_AUTORIZADOR  IN ('A','S','T');          &#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            --O Usuário ¢CD_USUARIO¢ não está autorizado para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;             V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3771,'¢CD_USUARIO='||:CONTROLE.CD_AUTORIZADOR ||' - '||:CONTROLE.NM_USUAUTORIZ||&#10;                                                          '¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;             :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#10;             :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#10;             RAISE E_GERAL;&#10;            WHEN TOO_MANY_ROWS THEN&#10;            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO:= NULL;&#10;            :ITEMCOMPRACCUSTO.DS_CENTROCUSTO:= NULL;&#10;            WHEN OTHERS THEN&#10;              --Ocorreu um erro inesperado na busca dos dados do usuário autorizador. Erro: ¢SQLERRM¢.&#10;             V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3958,'¢SQLERRM='||SQLERRM||'¢');&#10;             RAISE E_GERAL;&#10;        END;&#10;        END IF;&#10; &#10;       IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN --EML:13/01/2020:139947             &#10;           BEGIN  &#10;             SELECT MAX(AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR)                                        &#10;              INTO V_CD_AUTORICCUSTO&#10;              FROM AUTORIZCCUSTORESTRITO&#10;             WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO               &#10;                AND AUTORIZCCUSTORESTRITO.CD_EMPRESA  = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#10;               AND AUTORIZCCUSTORESTRITO.ST_REGISTRO = 'S';               &#10;           EXCEPTION &#10;             WHEN OTHERS THEN&#10;               V_CD_AUTORICCUSTO := NULL;                                     &#10;           END;&#10;                                        &#10;        IF V_CD_AUTORICCUSTO IS NOT NULL THEN           &#10;          IF :CONTROLE.CD_AUTORIZADOR IS NULL THEN                                             &#10;          /*O autorizador da tela principal deve ser informado.*/&#10;            V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33735, NULL);&#10;            RAISE E_GERAL;               &#10;          END IF;&#10;          &#10;          BEGIN           &#10;             SELECT AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR&#10;               INTO V_CD_AUTORICCUSTO2&#10;              FROM AUTORIZCCUSTORESTRITO&#10;             WHERE AUTORIZCCUSTORESTRITO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO            &#10;              AND AUTORIZCCUSTORESTRITO.CD_AUTORIZADOR  = :CONTROLE.CD_AUTORIZADOR&#10;               AND AUTORIZCCUSTORESTRITO.CD_EMPRESA      = NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST, :GLOBAL.CD_EMPRESA)&#10;               AND AUTORIZCCUSTORESTRITO.ST_REGISTRO     = 'S';               &#10;           EXCEPTION&#10;             WHEN NO_DATA_FOUND THEN                              &#10;               V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(33731, '¢CD_AUTORIZADOR='||:CONTROLE.CD_AUTORIZADOR||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');  &#10;              RAISE E_GERAL;              &#10;           END;  &#10;         END IF;    &#10;       END IF; --IF(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN     &#10;    EXCEPTION      &#10;      WHEN E_GERAL THEN&#10;        MENSAGEM('Maxys',V_MENSAGEM,2);&#10;        RAISE FORM_TRIGGER_FAILURE;     &#10;       WHEN NO_DATA_FOUND THEN &#10;         NULL;  &#10;       /* CSL:22264:30/06/09&#10;       * Tratamentos de exceção &#10;       */&#10;       WHEN TOO_MANY_ROWS THEN&#10;        MENSAGEM('Maxys','A consulta retornou mais de uma empresa para esta condição.',1);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;      WHEN OTHERS THEN&#10;        MENSAGEM('Maxys','Erro inesperado: '||SQLERRM,1);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;    END;  &#10;   END IF; --IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN  &#10;   &#10;    /**CSL:21/12/2010:30317&#10;     * Adicionado campo cd_negocio para permitir ou não que o usuário altere o negócio para o qual &#10;     * vai ser destinado o valor do centro de custo, de acordo com o status do parametro ST_NEGOCIOCCUSTO (N - Negado, S - Permitido) do CTI010.&#10;     */  &#10;      &#10;    IF(  NVL(:ITEMCOMPRACCUSTO.CD_NEGOCIOCENTRO,0) = 0) AND NVL(:ITEMCOMPRACCUSTO.ST_NEGOCIOPLANILHA,'N')  = 'N' THEN &#10;      BEGIN&#10;        SELECT CENTROCUSTO.CD_NEGOCIO,&#10;               NEGOCIO.DS_NEGOCIO&#10;          INTO :ITEMCOMPRACCUSTO.CD_NEGOCIO,&#10;               :ITEMCOMPRACCUSTO.DS_NEGOCIO&#10;          FROM CENTROCUSTO, NEGOCIO&#10;         WHERE CENTROCUSTO.CD_NEGOCIO     = NEGOCIO.CD_NEGOCIO&#10;           AND CENTROCUSTO.CD_CENTROCUSTO = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO;      &#10;        IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('CTI',10,'MAX',100,'ST_NEGOCIOCCUSTO'),'N') = 'N' THEN&#10;          SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',ENABLED,PROPERTY_FALSE);&#10;          SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',VISUAL_ATTRIBUTE,'VSA_CAMPOEXIBICAO');  &#10;        ELSE&#10;          SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',ENABLED,PROPERTY_TRUE);&#10;          SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_NEGOCIO',VISUAL_ATTRIBUTE,'VSA_CAMPOTEXTO');  &#10;        END IF;&#10;      &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          MENSAGEM_PADRAO(5243,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');--Nenhum negócio associado ao centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCB007.&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        WHEN TOO_MANY_ROWS THEN&#10;          MENSAGEM_PADRAO(6306,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');--Existe mais de um negócio associado ao centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCB007.&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;        WHEN OTHERS THEN&#10;          MENSAGEM_PADRAO(6307,'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢SQLERRM='||SQLERRM||'¢');--Ocorreu um erro inesperado ao tentar localizar o código de negócio associado ao Centro de Custo ¢CD_CENTROCUSTO¢. Erro: ¢SQLERRM¢.&#10;          RAISE FORM_TRIGGER_FAILURE;&#10;      END;&#10;   END IF;&#10;   &#10;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#10;      VALIDA_CONTA_ORCAMENTO('ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO', :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;    END IF;&#10;  &#10;  ELSE &#10;    :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#10;  END IF;&#10;&#10;-----------------------------------------------------------------------------------------------------------------&#10;--VALIDA SE A MOVIMENTAÇÃO POSSUI RESTRIÇÃO PARA O CENTRO DE CUSTO (TCB053)&#10;--AUG:122414:24/05/2018&#10;-----------------------------------------------------------------------------------------------------------------      &#10;  BEGIN&#10;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NOT NULL AND&#10;       :ITEMCOMPRACCUSTO.CD_CENTROCUSTO  IS NOT NULL THEN&#10;    &#10;      /*RETORNO: S = POSSUI RESTRIÇÃO&#10;       *          N = NÃO POSSUI RESTRIÇÃO CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#10;       */&#10;        &#10;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#10;                                                      :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;                                                                                                           &#10;      IF NVL(V_ST_ATIVO,'N') = 'S' THEN&#10;        V_CD_MOVIMENTACAO := :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO;&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    END IF;  &#10;      &#10;    IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO  IS NOT NULL AND&#10;       :ITEMCOMPRA.CD_MOVIMENTACAO       IS NOT NULL THEN&#10;         &#10;      V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRA.CD_MOVIMENTACAO,&#10;                                                      :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;                                                                            &#10;      IF NVL(V_ST_ATIVO,'N') = 'S' THEN&#10;        V_CD_MOVIMENTACAO  := :ITEMCOMPRA.CD_MOVIMENTACAO;&#10;         RAISE E_GERAL;&#10;      END IF;&#10;    END IF;    &#10;  EXCEPTION&#10;    WHEN E_GERAL THEN&#10;      --A movimentação ¢CD_MOVIMENTACAO¢ possui restrição para o centro de custo ¢CD_CENTROCUSTO¢. Verifique o programa TCB053.&#10;      MENSAGEM_PADRAO(31068, '¢CD_MOVIMENTACAO='||V_CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;      :ITEMCOMPRACCUSTO.CD_CENTROCUSTO := NULL;&#10;      :ITEMCOMPRACCUSTO.DS_CENTROCUSTO := NULL;&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;  END;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="--RYT:06/06/2012:45340&#10;DECLARE&#10;  V_ST_VALIDAUTCCUSTOCOM001 VARCHAR2(1);&#10;BEGIN&#10;    &#10;    V_ST_VALIDAUTCCUSTOCOM001 := NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',&#10;                                                                     9,&#10;                                                                     :GLOBAL.CD_USUARIO,&#10;                                                                     NVL(:CONTROLE.CD_EMPRESA, :GLOBAL.CD_EMPRESA),&#10;                                                                     'ST_VALIDAUTCCUSTOCOM001'),'N');  &#10;                                                                 &#10;    -- VALIDAÇÕES    &#10;    IF V_ST_VALIDAUTCCUSTOCOM001 = 'A' THEN&#10;      IF :ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL OR (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR &#60;> :CONTROLE.CD_AUTORIZADOR) THEN&#10;        SET_ALERT_PROPERTY('MENSAGEM_MUDAR',ALERT_MESSAGE_TEXT,'Pressione (Continuar) para incluir manualmente o Autorizador. Para mudar o Autorizador para o mesmo da Compra pressione (Mudar).');&#10;        IF NOT SHOW_ALERT('MENSAGEM_MUDAR') = 88 THEN&#10;          :ITEMCOMPRACCUSTO.CD_AUTORIZADOR := :CONTROLE.CD_AUTORIZADOR;&#10;          &#10;          IF PACK_GLOBAL.ST_APROVSOLIC = 'S' AND NVL (PACK_GLOBAL.ST_VALIDACCUSTO,'N') IN ('C','A') &#10;            AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;            :ITEMCOMPRACCUSTO.CD_EMPRESAUTORIZ := :ITEMCOMPRA.CD_EMPRESA;&#10;            /**GRA:09/03/2007:15399&#10;             * Inclusa a validação para não deixar passar&#10;             * se não autorizador para o centro de custo informado.&#10;             */&#10;            IF (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN&#10;              IF (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL) THEN  &#10;                NULL;&#10;                --MENSAGEM('Maxys', 'O autorizador do centro de custo deve ser informado',2);&#10;              ELSE&#10;                BEGIN&#10;                  SELECT CCUSTOAUTORIZ.CD_USUARIO,USUARIO.NM_USUARIO&#10;                    INTO :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,:ITEMCOMPRACCUSTO.NM_AUTORIZADOR&#10;                    FROM CCUSTOAUTORIZ,USUARIO&#10;                   WHERE USUARIO.CD_USUARIO            = CCUSTOAUTORIZ.CD_USUARIO&#10;                     AND USUARIO.CD_USUARIO            = :ITEMCOMPRACCUSTO.CD_AUTORIZADOR&#10;                     AND CCUSTOAUTORIZ.CD_EMPRESA      = :ITEMCOMPRACCUSTO.CD_EMPRESA&#10;                     AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#10;                     AND CCUSTOAUTORIZ.TP_AUTORIZADOR IN ('A','T');      &#10;                EXCEPTION&#10;                  WHEN NO_DATA_FOUND THEN&#10;                    --O Usuário/Autorizador ¢CD_USUARIO¢ não está autorizado para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;                    MENSAGEM_PADRAO(3771,'¢CD_USUARIO='||:ITEMCOMPRACCUSTO.CD_AUTORIZADOR||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;                     :ITEMCOMPRACCUSTO.CD_AUTORIZADOR := NULL;&#10;                     :ITEMCOMPRACCUSTO.NM_AUTORIZADOR := NULL;&#10;                     RAISE FORM_TRIGGER_FAILURE;&#10;                  WHEN TOO_MANY_ROWS THEN&#10;                    IF SHOW_LOV('LOV_AUTORIZADOR') THEN&#10;                      NULL;&#10;                    END IF;&#10;                  WHEN OTHERS THEN&#10;                    MENSAGEM('Maxys',SQLERRM,1);&#10;                    RAISE FORM_TRIGGER_FAILURE;&#10;                END;&#10;              END IF;&#10;            END IF;&#10;          END IF;&#10;        &#10;        END IF;  &#10;      END IF;&#10;    END IF;&#10;      GO_ITEM('ITEMCOMPRACCUSTO.CD_NEGOCIO');                                                                      &#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN  &#10;  IF NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_CC_USUARIO'),'N') = 'S' THEN&#10;    &#10;    IF NOT SHOW_LOV('LOV_CENTROCUSTOUSUARIO') THEN&#10;      NULL;&#10;    END IF;&#10;  ELSIF SHOW_LOV('LOV_CENTROCUSTO') THEN&#10;    &#10;    NULL;&#10;  END IF;&#10;  &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_CENTROCUSTO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_NEGOCIO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_NEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="/**CSL:21/12/2010:30317*/&#10;BEGIN&#10;  IF :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN  &#10;    SELECT DS_NEGOCIO&#10;      INTO :ITEMCOMPRACCUSTO.DS_NEGOCIO&#10;      FROM NEGOCIO&#10;     WHERE NEGOCIO.CD_NEGOCIO = :ITEMCOMPRACCUSTO.CD_NEGOCIO;     &#10;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#10;      VALIDA_CONTA_ORCAMENTO('ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO', :ITEMCOMPRA.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;    END IF; &#10;  ELSE&#10;    :ITEMCOMPRACCUSTO.DS_NEGOCIO := NULL;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    MENSAGEM_PADRAO(147,'¢CD_NEGOCIO='||:ITEMCOMPRACCUSTO.CD_NEGOCIO||'¢');--O Negócio ¢CD_NEGOCIO¢ não está cadastrado. Verifique o programa TCB001.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN TOO_MANY_ROWS THEN&#10;    MENSAGEM_PADRAO(148,'¢CD_NEGOCIO='||:ITEMCOMPRACCUSTO.CD_NEGOCIO||'¢');--O Negócio ¢CD_NEGOCIO¢ está cadastrado várias vezes. Verifique o programa TCB001.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM_PADRAO(149,'¢CD_NEGOCIO='||:ITEMCOMPRACCUSTO.CD_NEGOCIO||'¢SQLERRM='||SQLERRM||'¢');--Ocorreu um erro inesperado ao consultar os dados do código de Negócio ¢CD_NEGOCIO¢. Erro: ¢SQLERRM¢.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_NEGOCIO: Char(60)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cód. Mov.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PARMOVIMENT">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_TP_PEDIDO    PARMOVIMENT.TP_PEDIDO%TYPE; --PHS:60051:11/07/2013&#10;  I_CD_NATUREZA  PLANOCONTABIL.CD_NATUREZA%TYPE;&#10;  I_MENSAGEM     VARCHAR2(32000);&#10;  I_RETORNO       VARCHAR2(01);&#10;  V_ST_ATIVO     RESTRINGIRMOV.ST_ATIVO%TYPE;&#10;  E_GERAL        EXCEPTION;&#10;BEGIN&#10;&#10;  IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NOT NULL THEN&#10;      IF PACK_GLOBAL.TP_SELECAOCONTA = 'O' THEN&#10;        /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padrão da função VALIDA_SELECAOCONTA quando for 'CO'*/&#10;        I_MENSAGEM := VALIDA_SELECAOCONTA (NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:CONTROLE.CD_EMPRESA),&#10;                                           :ITEMCOMPRACCUSTO.CD_ITEM,&#10;                                           :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, &#10;                                           NULL, 'CO');    &#10;        IF (I_MENSAGEM IS NOT NULL) AND (I_MENSAGEM &#60;> 'S') THEN&#10;          RAISE E_GERAL;&#10;        END IF;&#10;      END IF;&#10;      &#10;      /* CSL:02/12/2013:64869&#10;       * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO para não permitir realizar lançamentos em contas, &#10;       * que não pertencem a versão do plano de contas da empresa do lançamento.&#10;       */&#10;      PACK_VALIDA.VALIDA_CONTABIL_PLANO(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST,:GLOBAL.CD_EMPRESA), I_MENSAGEM);&#10;    &#10;      IF I_MENSAGEM IS NOT NULL THEN&#10;        RAISE E_GERAL;&#10;      END IF;&#10;      &#10;      BEGIN&#10;        /*CSL:30/12/2013:64869*/&#10;        IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;                 PLANOCONTABIL.CD_NATUREZA,&#10;                 PARMOVIMENT.TP_PEDIDO&#10;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#10;                 I_CD_NATUREZA,&#10;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#10;            FROM PARMOVIMENT,HISTCONTB,PLANOCONTABIL&#10;           WHERE PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO&#10;             AND HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#10;             AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#10;             AND PLANOCONTABIL.TP_CONTACONTABIL = 'CC';&#10;        &#10;        ELSE&#10;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;                 PLANOCONTABILVERSAO.CD_NATUREZA,&#10;                 PARMOVIMENT.TP_PEDIDO&#10;            INTO :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO,&#10;                 I_CD_NATUREZA,&#10;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#10;            FROM PARMOVIMENT, HISTCONTB, PLANOCONTABILVERSAO&#10;           WHERE PARMOVIMENT.CD_MOVIMENTACAO           = :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO&#10;             AND HISTCONTB.CD_HISTCONTB                = PARMOVIMENT.CD_HISTCONTB&#10;             AND PLANOCONTABILVERSAO.CD_CONTACONTABIL  = HISTCONTB.CD_CONTACONTABIL&#10;             AND PLANOCONTABILVERSAO.TP_CONTACONTABIL  = 'CC'&#10;             AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#10;                 PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));  &#10;        END IF;&#10;        &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          --Movimentação ¢CD_MOVIMENTACAO¢ não cadastrada, não é de compra ou não é de Centro de Custo. Verifique TCB008.&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3775,'¢CD_MOVIMENTACAO='||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||'¢');&#10;          RAISE E_GERAL;&#10;      END;&#10;    &#10;      --PHS:60051:11/07/2013&#10;      IF V_TP_PEDIDO &#60;> PACK_GLOBAL.TP_PEDIDO THEN&#10;        --A movimentação ¢CD_MOVIMENTACAO¢ possui o tipo de pedido ¢TP_PEDIDO¢ diferente do tipo de pedido ¢TP_CADPEDIDO¢ cadastrado para o programa. Verificar os programas TCB008 e ANV008.&#10;        MENSAGEM_PADRAO(20737,'¢CD_MOVIMENTACAO='||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||'¢TP_PEDIDO='||V_TP_PEDIDO||'¢TP_CADPEDIDO='||PACK_GLOBAL.TP_PEDIDO||'¢'); &#10;      END IF;  &#10;    &#10;      /*CLM:22/08/2014:76468 &#10;      IF NATUREZA_CENTROCUSTO(:ITEMCOMPRACCUSTO.CD_CENTROCUSTO) &#60;> I_CD_NATUREZA THEN&#10;        --A Movimentação ¢CD_MOVIMENTACAO¢ não é compatível com o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCB008.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3776,'¢CD_MOVIMENTACAO='||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;*/&#10;      &#10;      I_RETORNO := RETORNA_NATUREZA (:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO,:GLOBAL.CD_EMPRESA); /*CSL:03/10/2013:62738*/&#10;      IF I_RETORNO = 'I' THEN&#10;        --A natureza do Centro de Custo ¢CD_CENTROCUSTO¢ é incompatível com a natureza da Movimentação ¢CD_MOVIMENTACAO¢. Verifique TCB007 e TCB008.&#10;        I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20318, '¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢CD_MOVIMENTACAO='||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||'¢');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;    &#10;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL AND :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRACCUSTO.CD_NEGOCIO IS NOT NULL THEN&#10;      VALIDA_CONTA_ORCAMENTO('ITEMCOMPRACCUSTO.CD_CONTAORCAMENTO', :ITEMCOMPRA.CD_MOVIMENTACAO, :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;    END IF;&#10;          &#10;  ELSE&#10;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#10;  END IF;&#10;-----------------------------------------------------------------------------------------------------------------&#10;--VALIDA SE A MOVIMENTAÇÃO POSSUI RESTRIÇÃO PARA O CENTRO DE CUSTO (TCB053)&#10;--AUG:122414:24/05/2018&#10;-----------------------------------------------------------------------------------------------------------------      &#10;      IF :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL THEN&#10;      &#10;       /*RETORNO: S = POSSUI RESTRIÇÃO&#10;        *          N = NÃO POSSUI RESTRIÇÃO CADASTRADA NO TCB053 TABELA **RESTRINGIRMOV** &#10;        */&#10;        &#10;        V_ST_ATIVO := PACK_COMPRAS.VALIDA_RESTRICAOMOV(:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO,&#10;                                                            :ITEMCOMPRACCUSTO.CD_CENTROCUSTO);&#10;        IF NVL(V_ST_ATIVO,'N') = 'S' THEN&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(31068, '¢CD_MOVIMENTACAO='||:ITEMCOMPRACCUSTO.CD_MOVIMENTACAO||'¢CD_CENTROCUSTO='|| :ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;          RAISE E_GERAL;&#10;        END IF;&#10;      END IF;                      &#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#10;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#10;    MENSAGEM('Maxys',I_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    :ITEMCOMPRACCUSTO.DS_MOVIMENTACAO := NULL;&#10;     :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := NULL;&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-LISTVAL">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  /*CSL:30/12/2013:64869*/&#10;  IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN &#10;    &#10;    SET_LOV_PROPERTY('LOV_PARMOVIMENT',GROUP_NAME, 'LOV_PARMOVIMENT1');   &#10;     &#10;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'X') IN ('O','S') &#10;        AND SHOW_LOV('LOV_PARMOVIMENT') THEN&#10;      NULL; &#10;    ELSE&#10;       SET_LOV_PROPERTY('LOV_PARMOVIMENT',GROUP_NAME, 'LOV_PARMOVIMENT');&#10;       &#10;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'S')= 'S' &#10;          AND SHOW_LOV('LOV_PARMOVIMENT') THEN&#10;           NULL;&#10;      END IF;&#10;    END IF;&#10;&#10;  ELSE--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;    SET_LOV_PROPERTY('LOV_PARMOVIMENTVERSAO',GROUP_NAME, 'LOV_PARMOVIMENT1VERSAO');  &#10;    &#10;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'X') IN ('O','S') &#10;        AND SHOW_LOV('LOV_PARMOVIMENTVERSAO') THEN&#10;      NULL; &#10;    ELSE&#10;       SET_LOV_PROPERTY('LOV_PARMOVIMENTVERSAO',GROUP_NAME, 'LOV_PARMOVIMENTVERSAO');&#10;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'S')= 'S' &#10;          AND SHOW_LOV('LOV_PARMOVIMENTVERSAO') THEN&#10;           NULL;&#10;      END IF;&#10;    END IF;&#10;  END IF;--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN  &#10;END;">
</node>
</node>
</node>
<node TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL THEN&#10;    :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO := :ITEMCOMPRA.CD_MOVIMENTACAO;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_AUTORIZADOR">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="&#10;BEGIN&#10;    IF PACK_GLOBAL.ST_APROVSOLIC = 'S' AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;      IF (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL) AND (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL)&#10;        AND (:ITEMCOMPRA.CD_AUTORIZADOR IS NOT NULL) THEN&#10;        SELECT CCUSTOAUTORIZ.CD_USUARIO,USUARIO.NM_USUARIO&#10;          INTO :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,:ITEMCOMPRACCUSTO.NM_AUTORIZADOR&#10;          FROM CCUSTOAUTORIZ,USUARIO&#10;         WHERE USUARIO.CD_USUARIO            = CCUSTOAUTORIZ.CD_USUARIO&#10;           AND USUARIO.CD_USUARIO            = :ITEMCOMPRA.CD_AUTORIZADOR&#10;           AND CCUSTOAUTORIZ.CD_EMPRESA      = :ITEMCOMPRACCUSTO.CD_EMPRESA&#10;           AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#10;           AND CCUSTOAUTORIZ.TP_AUTORIZADOR IN ('A','T');&#10;      END IF;    &#10;    END IF;              &#10;  EXCEPTION&#10;    WHEN NO_DATA_FOUND THEN&#10;      NULL;&#10;    WHEN TOO_MANY_ROWS THEN&#10;      IF SHOW_LOV('LOV_AUTORIZADOR') THEN&#10;        NULL;&#10;      END IF;&#10;  END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="/*DECLARE  &#10;  --I_MENSAGEM  VARCHAR2(2000);&#10;  --E_GERAL     EXCEPTION;*/&#10;--DECLARE &#10;--  V_MENSAGEM VARCHAR2(32000);&#10;--  V_CD_AUTORICCUSTO ITEMCOMPRACCUSTO.CD_AUTORIZADOR%TYPE;  &#10;BEGIN&#10;&#10;  /**RSS:21/12/2007:17745&#10;   * FOI ALTERADA A O IF DA VALIDAÇÃO, POIS A MANEIRA QUE ESTAVA NAO ATENDIA A VALIDAÇÃO &#10;   * NA QUAL FOI REQUISITADA, OU SEJA, NAO ACONTECIA A VALIDAÇÃO QUANDO ERA NECESSÁRIA.&#10;   */&#10;  :ITEMCOMPRACCUSTO.CD_SOLICITANTE   := :GLOBAL.CD_USUARIO;&#10;  :ITEMCOMPRACCUSTO.CD_EMPRESA       := :ITEMCOMPRA.CD_EMPRESA;&#10;  :ITEMCOMPRACCUSTO.CD_EMPRESASOLIC  := :ITEMCOMPRA.CD_EMPRESA;&#10;  &#10;  IF PACK_GLOBAL.ST_APROVSOLIC = 'S' AND NVL (PACK_GLOBAL.ST_VALIDACCUSTO,'N') IN ('C','A') &#10;    AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN&#10;    :ITEMCOMPRACCUSTO.CD_EMPRESAUTORIZ := :ITEMCOMPRA.CD_EMPRESA;&#10;  /**GRA:09/03/2007:15399&#10;   * Inclusa a validação para não deixar passar&#10;   * se não autorizador para o centro de custo informado.&#10;   */&#10;    IF (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL)THEN&#10;      IF (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL) THEN  &#10;        NULL;&#10;        --MENSAGEM('Maxys', 'O autorizador do centro de custo deve ser informado',2);&#10;      ELSE&#10;        BEGIN&#10;          SELECT CCUSTOAUTORIZ.CD_USUARIO,USUARIO.NM_USUARIO&#10;            INTO :ITEMCOMPRACCUSTO.CD_AUTORIZADOR,:ITEMCOMPRACCUSTO.NM_AUTORIZADOR&#10;            FROM CCUSTOAUTORIZ,USUARIO&#10;           WHERE USUARIO.CD_USUARIO            = CCUSTOAUTORIZ.CD_USUARIO&#10;             AND USUARIO.CD_USUARIO            = :ITEMCOMPRACCUSTO.CD_AUTORIZADOR&#10;             AND CCUSTOAUTORIZ.CD_EMPRESA      = :ITEMCOMPRACCUSTO.CD_EMPRESA&#10;             AND CCUSTOAUTORIZ.CD_CENTROCUSTO  = :ITEMCOMPRACCUSTO.CD_CENTROCUSTO&#10;             AND CCUSTOAUTORIZ.TP_AUTORIZADOR IN ('A','T');      &#10;        EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            --O Usuário/Autorizador ¢CD_USUARIO¢ não está autorizado para o Centro de Custo ¢CD_CENTROCUSTO¢. Verifique TCO003.&#10;            MENSAGEM_PADRAO(3771,'¢CD_USUARIO='||:ITEMCOMPRACCUSTO.CD_AUTORIZADOR||'¢CD_CENTROCUSTO='||:ITEMCOMPRACCUSTO.CD_CENTROCUSTO||'¢');&#10;             :ITEMCOMPRACCUSTO.CD_AUTORIZADOR := NULL;&#10;             :ITEMCOMPRACCUSTO.NM_AUTORIZADOR := NULL;&#10;             RAISE FORM_TRIGGER_FAILURE;&#10;          WHEN TOO_MANY_ROWS THEN&#10;            IF SHOW_LOV('LOV_AUTORIZADOR') THEN&#10;              NULL;&#10;            END IF;&#10;          WHEN OTHERS THEN&#10;            MENSAGEM('Maxys',SQLERRM,1);&#10;            RAISE FORM_TRIGGER_FAILURE;&#10;        END;&#10;      END IF;&#10;  END IF;&#10;  &#10;END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;   IF PACK_GLOBAL.TP_ITEM = 'S' THEN&#10;      --:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL:=0;&#10;      SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.PC_PARTICIPACAO', ENABLED, PROPERTY_TRUE);      &#10;      SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.PC_PARTICIPACAO', NAVIGABLE, PROPERTY_TRUE);&#10;      GO_ITEM('ITEMCOMPRACCUSTO.PC_PARTICIPACAO');    &#10;   ELSE&#10;      NEXT_ITEM;&#10;   END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_AUTORIZADOR: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_EMPRESADEST: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PEDIDAUNIDSOL: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL THEN       &#10;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL  THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);  &#10;       --A movimentação deve ser informada.&#10;       MENSAGEM_PADRAO(298,'');&#10;       GO_ITEM('ITEMCOMPRACCUSTO.CD_MOVIMENTACAO');&#10;    ELSIF:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL THEN&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;        --O centro de custo deve ser informado.&#10;        MENSAGEM_PADRAO(292,'');&#10;        GO_ITEM('ITEMCOMPRACCUSTO.CD_CENTROCUSTO');&#10;    ELSE   &#10;      IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL &#60; 0 THEN--AUG:126984:29/10/2018&#10;        --O Peso ou Quantidade do item do pedido não pode ser negativo.&#10;        MENSAGEM_PADRAO(3282, NULL);&#10;        RAISE FORM_TRIGGER_FAILURE;&#10;      END IF;&#10;    &#10;      IF (:CONTROLE.LST_AUTOSUGESTAO = 2) THEN&#10;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#10;          SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;          SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;           GO_ITEM('ITEMCOMPRACCUSTO.BTN_OK');&#10;        ELSE &#10;          IF GET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED) = 'TRUE' THEN&#10;            SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED,PROPERTY_FALSE);&#10;           END IF;&#10;             NEXT_RECORD;&#10;             GO_ITEM('ITEMCOMPRACCUSTO.CD_CENTROCUSTO');&#10;        END IF;&#10;      ELSE&#10;        NEXT_ITEM;&#10;      END IF;&#10;    END IF;&#10;  ELSE&#10;    NEXT_ITEM;      &#10;  END IF;     &#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN   &#10;  &#10;  IF :SYSTEM.CURSOR_ITEM = 'ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL'  AND :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM THEN&#10;    &#10;    &#10;    DECLARE&#10;      V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE;&#10;    BEGIN &#10;      SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#10;        INTO V_ST_UNIDMEDIDA&#10;        FROM ITEM, UNIDMEDIDA&#10;       WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#10;         AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;          &#10;      IF ( V_ST_UNIDMEDIDA = 'U' AND (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) ) THEN&#10;         :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL);&#10;      END IF;         &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        NULL;&#10;    END;&#10;    IF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL &#60;> 0) THEN&#10;      :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * (100 / ZVL(:ITEMCOMPRACCUSTO.QT_PREVISTA, 1));&#10;    END IF;&#10;    &#10;    IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL,2) > ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA,2)THEN&#10;      :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL - (ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL,2) - ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA,2));&#10;    END IF;&#10;    &#10;    IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL &#60; 0 THEN--AUG:126984:29/10/2018&#10;      --O Peso ou Quantidade do item do pedido não pode ser negativo.&#10;      MENSAGEM_PADRAO(3282, NULL);&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;    &#10;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (2,3)) THEN&#10;      IF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NULL) THEN&#10;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * 100 /&#10;                                                   :ITEMCOMPRACCUSTO.QT_PREVISTA,3);&#10;                                                &#10;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#10;           SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;           SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;        ELSE &#10;          IF (GET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED) = 'TRUE') THEN&#10;            SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED,PROPERTY_FALSE);&#10;          END IF;&#10;        END IF;        &#10;        &#10;        /* DCS:19/12/2013:67379 &#10;         * faz o arredondamento no último percentual, com base na autosugestão do percentual apos digitar a última quantidade d&#10;         * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#10;         */&#10;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) AND&#10;           NVL(:ITEMCOMPRACCUSTO.PC_TOTAL,0) > 100 THEN&#10;          :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.PC_PARTICIPACAO - (:ITEMCOMPRACCUSTO.PC_TOTAL - 100);&#10;        END IF;&#10;        &#10;      ELSIF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NOT NULL) THEN&#10;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * 100 /&#10;                                                   :ITEMCOMPRACCUSTO.QT_PREVISTA,3);&#10;        &#10;        /* DCS:19/12/2013:67379 &#10;         * faz o arredondamento no último percentual, com base na autosugestão do percentual apos digitar a última quantidade do&#10;         * centro de custo e quando o percentual total sumarizar mais de 100 %.&#10;         */&#10;        IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) AND&#10;           NVL(:ITEMCOMPRACCUSTO.PC_TOTAL,0) > 100 THEN&#10;          :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.PC_PARTICIPACAO - (:ITEMCOMPRACCUSTO.PC_TOTAL - 100);&#10;        END IF;        &#10;        &#10;      ELSIF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL) THEN&#10;        SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',ENABLED,PROPERTY_TRUE);&#10;        SET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.PC_PARTICIPACAO',NAVIGABLE,PROPERTY_TRUE);&#10;      END IF;&#10;    END IF;&#10;  END IF;&#10;&#10;END;">
</node>
</node>
</node>
<node TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;   IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) &#60; ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;   ELSIF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) > ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#10;       --A soma dos valores lançados em Centro de Custo ¢VL_CCUSTO¢ para o item ¢CD_ITEM¢ deve corresponder ao valor lançados no pedido ¢VL_TOTITEM¢.&#10;      MENSAGEM_PADRAO(4526,'¢VL_CCUSTO=' ||ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL)||&#10;                           '¢CD_ITEM='   ||:ITEMCOMPRACCUSTO.CD_ITEM||&#10;                           '¢VL_TOTITEM='||ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA)||'¢');&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;   ELSIF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;   END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN  &#10;  IF (ERROR_TYPE = 'FRM') AND (ERROR_CODE = 40209) THEN&#10;    MENSAGEM('','Os caracteres válidos são 0-9 - e +.',4);&#10;  ELSE&#10;    VALIDA_ERROS;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="PC_PARTICIPACAO: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="% Partic.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Percentual de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Percentual de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL      EXCEPTION;&#10;  E_SAIDA      EXCEPTION;&#10;BEGIN&#10;  IF :SYSTEM.CURSOR_ITEM = 'ITEMCOMPRACCUSTO.PC_PARTICIPACAO' AND (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NOT NULL) THEN&#10;    IF (NVL(:ITEMCOMPRACCUSTO.PC_PARTICIPACAO,0) &#60;= 0) THEN&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20921, NULL);&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    /* ASF:19/02/2020:140506&#10;     * Se estiver selecionado a opção &#34;Considerar apenas %&#34; no drop down &#34;Opções de auto-sugestão&#34;&#10;     * nenhuma validação, ou inserção de valor será feita para a Quantidade do rateio do Centro de Custo&#10;     */&#10;    IF (:CONTROLE.LST_AUTOSUGESTAO = 5) THEN&#10;      RAISE E_SAIDA;&#10;    END IF;&#10;      &#10;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN     &#10;      :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO / 100 ,3);&#10;    END IF;&#10;&#10;    --RAN:07/01/2019:126984&#10;     IF :SYSTEM.CURSOR_ITEM = 'ITEMCOMPRACCUSTO.PC_PARTICIPACAO' THEN&#10;      IF (:ITEMCOMPRACCUSTO.PC_PARTICIPACAO IS NOT NULL) THEN&#10;        IF :ITEMCOMPRACCUSTO.PC_PARTICIPACAO &#60;> 0  THEN&#10;          :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO / 100 ,3);&#10;          --:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(((:ITEMCOMPRACCUSTO.QT_PREVISTA / ZVL(:ITEMCOMPRACCUSTO.COUNT_ITEMCOMPRA,1)) * :ITEMCOMPRACCUSTO.PC_PARTICIPACAO) / 100,2);&#10;          --SYNCHRONIZE;    &#10;        END IF;&#10;      END IF;&#10;    END IF;&#10;&#10;    IF NVL(PACK_GLOBAL.TP_ITEM,'N') &#60;> 'S'  THEN&#10;       &#10;      DECLARE&#10;        V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE;&#10;      BEGIN &#10;        SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#10;          INTO V_ST_UNIDMEDIDA&#10;          FROM ITEM, UNIDMEDIDA&#10;         WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#10;           AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;             &#10;        IF ( V_ST_UNIDMEDIDA = 'U' ) AND (:CONTROLE.LST_AUTOSUGESTAO IN (1,3))  THEN&#10;          :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL);&#10;          :ITEMCOMPRACCUSTO.PC_PARTICIPACAO  := ROUND(:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL * 100 / :ITEMCOMPRACCUSTO.QT_PREVISTA,3);&#10;        END IF;&#10;           &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          NULL;&#10;      END;&#10;                                                  &#10;     ELSIF  GET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',ENABLED) = 'TRUE' THEN&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL',ENABLED,PROPERTY_FALSE);&#10;     END IF;&#10;&#10;     /* DCS:19/12/2013:67379 &#10;     * faz o arredondamento no último percentual, com base na autosugestão do percentual apos digitar a última quantidade d&#10;     * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#10;     */&#10;     IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN &#10;       IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL) = ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) AND&#10;        NVL(:ITEMCOMPRACCUSTO.PC_TOTAL,0) > 100 THEN&#10;        :ITEMCOMPRACCUSTO.PC_PARTICIPACAO := :ITEMCOMPRACCUSTO.PC_PARTICIPACAO - (:ITEMCOMPRACCUSTO.PC_TOTAL - 100);&#10;      END IF;&#10;     END IF;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN E_SAIDA THEN&#10;    NULL;  &#10;END;">
</node>
</node>
</node>
<node TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN &#10;  IF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) &#60; 100 THEN&#10;    IF GET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED) = 'TRUE' THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;    END IF;&#10;  ELSIF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) > 100 THEN&#10;     --A soma do percentual de participação dos centros de custos deve ser igual a 100%.&#10;     MENSAGEM_PADRAO(4740,'');     &#10;    :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := NULL;&#10;    :ITEMCOMPRACCUSTO.PC_PARTICIPACAO  := NULL;&#10;    IF GET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED) = 'TRUE' THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;    END IF;&#10;   &#10;  ELSIF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) = 100 THEN&#10;    IF GET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED) = 'FALSE' THEN&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;    END IF;&#10;  END IF;&#10;  IF ROUND(:ITEMCOMPRACCUSTO.PC_PARTICIPACAO,3) = 100 AND (:CONTROLE.LST_AUTOSUGESTAO &#60;> 5) THEN&#10;     :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL := :ITEMCOMPRACCUSTO.QT_PREVISTA;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  VALIDATE(ITEM_SCOPE);&#10;  IF FORM_SUCCESS THEN&#10;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL  THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);  &#10;       --A movimentação deve ser informada.&#10;       MENSAGEM_PADRAO(298,'');&#10;       GO_ITEM('ITEMCOMPRACCUSTO.CD_MOVIMENTACAO');&#10;    ELSIF:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL THEN&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;        --O centro de custo deve ser informado.&#10;        MENSAGEM_PADRAO(292,'');&#10;        GO_ITEM('ITEMCOMPRACCUSTO.CD_CENTROCUSTO');&#10;    ELSE&#10;      IF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) &#60; 100 THEN&#10;         NEXT_RECORD;&#10;         --GDG:01/08/2011:28715&#10;         IF GET_ITEM_PROPERTY('ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST', VISUAL_ATTRIBUTE) = 'VSA_CAMPOTEXTO' THEN&#10;           GO_ITEM('ITEMCOMPRACCUSTO.CD_EMPRCCUSTODEST');&#10;         ELSE&#10;           GO_ITEM('ITEMCOMPRACCUSTO.CD_CENTROCUSTO');&#10;         END IF;&#10;      ELSIF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) = 100 THEN&#10;        GO_ITEM('ITEMCOMPRACCUSTO.BTN_OK');&#10;      END IF;    &#10;    END IF;     &#10;  ELSE            &#10;    RETURN;&#10;  END IF;&#10;END;&#10;">
</node>
</node>
</node>
<node TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN  &#10;  IF (ERROR_TYPE = 'FRM') AND (ERROR_CODE = 40209) THEN&#10;    MENSAGEM('','Os caracteres válidos são 0-9 - e +.',4);&#10;  ELSE&#10;    VALIDA_ERROS;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Complemento">
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
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_OK: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  E_GERAL         EXCEPTION;&#10;  E_ALERTA        EXCEPTION;&#10;  V_MENSAGEM       VARCHAR2(32000);&#10;  V_ST_EXIBEMSG    BOOLEAN DEFAULT FALSE;--MGK:61460:30/07/2013&#10;  V_ALERT          NUMBER;--MGK:61460:30/07/2013&#10;  COUNT_NULL       NUMBER;&#10;  COUNT_NOT_NULL   NUMBER;&#10;  COUNT_GERAL      NUMBER;&#10;BEGIN&#10;  GO_ITEM('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL');&#10;  --GDG:01/08/2011:28715  &#10;  VALIDATE(ITEM_SCOPE);&#10;  IF FORM_SUCCESS THEN&#10;    VALIDATE(RECORD_SCOPE);&#10;    IF NOT FORM_SUCCESS THEN&#10;      RETURN;&#10;    END IF;&#10;  ELSE&#10;    RETURN;&#10;  END IF;&#10;  &#10;  IF (NVL(:ITEMCOMPRACCUSTO.QT_TOTAL,0) > 0) THEN&#10;    IF ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL)&#60;> ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA) THEN&#10;      --A  Quantidade tolal prevista para o centro de custo ¢QT_PREVISTA¢ é diferente do total rateado  ¢QT_TOTAL¢.                            &#10;      MENSAGEM_PADRAO(32776, '¢QT_PREVISTA='||ROUND(:ITEMCOMPRACCUSTO.QT_PREVISTA)||'¢QT_TOTAL='||ROUND(:ITEMCOMPRACCUSTO.QT_TOTAL)||'¢');                                                         &#10;      RAISE FORM_TRIGGER_FAILURE;               &#10;     END IF;&#10;  END IF;  &#10;    &#10;  IF ROUND(:ITEMCOMPRACCUSTO.PC_TOTAL,2) = 100 THEN    &#10;    IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL AND :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL /*AND :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL*/ THEN     &#10;     DELETE_RECORD;&#10;    END IF;&#10;    --------------------------------------------------------------------&#10;    --VERIFICA SE A MOVIMENTAÇÃO E O CENTRO DE CUSTO ESTÃO PREENCHIDOS--&#10;    --------------------------------------------------------------------&#10;    COUNT_NULL      := 0;&#10;    COUNT_NOT_NULL   := 0;&#10;    COUNT_GERAL     := 0;&#10;    &#10;    FIRST_RECORD;&#10;    LOOP&#10;      --RAN:126984:07/01/2019  &#10;      IF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NOT NULL THEN&#10;        COUNT_NOT_NULL := COUNT_NOT_NULL+1;&#10;      ELSIF :ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL THEN&#10;        COUNT_NULL := COUNT_NULL+1;&#10;      END IF;&#10;      &#10;      COUNT_GERAL := COUNT_GERAL+1;&#10;       &#10;      /**RSS:21/12/2007:17745&#10;       * Condição para validação do centro de custo, assim como determinado no COM009. &#10;       */&#10;       /*ATR:115974:26/12/2017*/&#10;     &#10;      IF PACK_GLOBAL.ST_APROVSOLIC = 'S' AND NVL(PACK_GLOBAL.ST_VALIDACCUSTO,'N') IN ('C','A') AND&#10;         (:ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NOT NULL) AND &#10;        (:ITEMCOMPRACCUSTO.CD_AUTORIZADOR IS NULL) AND NVL(PACK_PARMGEN.CONSULTA_PARAMETRO('COM',9,'MAX',:ITEMCOMPRA.CD_EMPRESA,'ST_NAOBRIGAUTORIZ'),'N') = 'N' THEN  &#10;        --O autorizador do centro de custo deve ser informado.&#10;        MENSAGEM_PADRAO(4739,'');&#10;        RAISE E_GERAL;&#10;      END IF;&#10;      &#10;      IF :ITEMCOMPRACCUSTO.CD_MOVIMENTACAO IS NULL OR :ITEMCOMPRACCUSTO.CD_CENTROCUSTO IS NULL THEN&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRACCUSTO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;        RAISE E_GERAL;&#10;      END IF;&#10;      &#10;      IF (:ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL IS NULL) THEN&#10;        V_ST_EXIBEMSG := TRUE;&#10;      END IF;&#10;      &#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    IF ZVL(COUNT_NULL, COUNT_GERAL) &#60;> COUNT_GERAL OR &#10;       ZVL(COUNT_NOT_NULL, COUNT_GERAL) &#60;> COUNT_GERAL THEN&#10;      MENSAGEM_PADRAO(32001, NULL);&#10;&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    /* RBM: 05/09/2008&#10;     * Incluida validação para que não insira no bloco ITECOMPRACCUSTO centros de custos repetido.&#10;     */&#10;     /**CSL:30317:22/12/2010&#10;      * Esta validação foi alterada para verificar o código do centro de custos e o código do negócio, pois&#10;      * apartir desta versão será permitido inserir mais de um registro com o mesmo centro de custos, porém &#10;      * o código do negócio deve ser diferente.&#10;      */&#10;    VALIDA_DUPLICADOS(V_MENSAGEM);&#10;    &#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      MENSAGEM('Maxys',V_MENSAGEM,2);&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    ADICIONA_GRUPO;&#10;    GO_ITEM('ITEMCOMPRA.DS_OBSERVACAO');&#10;  ELSE&#10;     --A soma do percentual de participação dos centros de custos deve ser igual a 100%.&#10;     MENSAGEM_PADRAO(4740,'');     &#10;    GO_ITEM('ITEMCOMPRACCUSTO.QT_PEDIDAUNIDSOL');&#10;  END IF;&#10;  &#10;  /*ASF:19/02/2020:140506*/&#10;  --MGK:61460:30/07/2013&#10;  IF (V_ST_EXIBEMSG) AND (:CONTROLE.LST_AUTOSUGESTAO &#60;> 5) THEN&#10;    V_ALERT := SHOW_ALERT('ALR_QTDENULA');&#10;    IF (V_ALERT = ALERT_BUTTON1) THEN&#10;      NULL;&#10;    ELSIF (V_ALERT = ALERT_BUTTON2) THEN &#10;      GO_BLOCK('ITEMCOMPRACCUSTO');&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20836, NULL);&#10;      RAISE E_ALERTA;&#10;    ELSE&#10;      NULL;&#10;    END IF;&#10;  END IF;&#10;  &#10;EXCEPTION&#10;  WHEN E_ALERTA THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN E_GERAL THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_CANCELAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  GO_BLOCK('ITEMCOMPRACCUSTO');&#10;  CLEAR_BLOCK (NO_VALIDATE);&#10;  --:ITEMCOMPRA.QT_PREVISTA := 0;  &#10;  PACK_GRUPO.DELETA_GRUPO_CC(:ITEMCOMPRACCUSTO.CD_ITEM);&#10;  GO_ITEM('ITEMCOMPRA.QT_PREVISTA');&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Soma das Quantidades">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="PC_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Soma dos Percentuais de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PREVISTA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade a Solicitar">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nr Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESAUTORIZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresautoriz">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESASOLIC: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresasolic">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_SOLICITANTE: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":GLOBAL.CD_USUARIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_ITEMCOMPRA: Number(2)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DT_LIBERACAO: Date(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Atualizacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_LIBERADO: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="St Liberado">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_RECORD: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="HR_RECORD: Char(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Hr Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CONTAORCAMENTO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DS_CAMINHO: Char(3200)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Importação de Planilha">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_IMPORTAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM VARCHAR2(32000);&#10;BEGIN&#10;  IF(:ITEMCOMPRACCUSTO.DS_CAMINHO IS NOT NULL)THEN  &#10;    IMPORTA_ARQUIVO(V_MENSAGEM);&#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      RAISE FORM_TRIGGER_FAILURE;&#10;    END IF;&#10;  ELSE&#10;    --  É necessário informar o caminho do arquivo para importar os dados.&#10;    MENSAGEM_PADRAO(4140, NULL);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  END IF;    &#10;END;&#10;&#10;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_NEGOCIOCENTRO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Centro Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_NEGOCIOPLANILHA: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="St Liberado">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="N">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="ULTIMASCOMPRAS">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="BTN_FECHAR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  GO_BLOCK('ITEMCOMPRA');&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CLIFOR: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Fornecedor">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_CLIFOR: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="PS_ATENDIDO: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Peso">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_ATENDIDA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="VL_UNITITEM: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Valor Unit.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="VL_TOTITEM: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Valor Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_NFEMPR: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nota">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_EMISSAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="PC_IPI: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="IPI %">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="ITEMCOMPRA_AUX">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="VL_ESTIMADO_AUX: Number(21)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA_AUX.VL_ESTIMADO_AUX IS NULL THEN&#10;    --Informe um valor estimado para compra por unidade do item.&#10;    MENSAGEM_PADRAO(4741,'');&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  END IF;&#10;  :ITEMCOMPRA.VL_ESTIMADO := :ITEMCOMPRA_AUX.VL_ESTIMADO_AUX;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_VOLTAR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRA_AUX.VL_ESTIMADO_AUX IS NULL THEN&#10;    --Informe um valor estimado para compra por unidade do item.&#10;    MENSAGEM_PADRAO(4741,'');&#10;    GO_ITEM('ITEMCOMPRA_AUX.VL_ESTIMADO_AUX');&#10;  ELSE&#10;    GO_ITEM('ITEMCOMPRA.QT_PREVISTA');&#10;    EXECUTE_TRIGGER('KEY-NEXT-ITEM');&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="DEVOLUCAO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NR_LOTECOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_BEMPAT: Char(7)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Bempat">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESAITEM: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresaitem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESASOLIC: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresasolic">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESAUTORIZ: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Empresautoriz">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ENDERENTREGA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Enderentrega">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_PROJETO: Char(7)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_SOLICITANTE: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEMSERVICO: Char(1000)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Ds Itemservico">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_ALTERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Alteracao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_CONSOLIDACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Consolidacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_LIBERACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Liberacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_RECORD: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_SOLICITACAO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Solicitacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="HR_RECORD: Char(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Hr Record">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMPRORIGEM: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nr Itemprorigem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_NEGOCIACAO: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nr Negociacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_NEGOCIADA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Qt Negociada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_EMISSAONF: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="St Emissaonf">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ST_ITEMCOMPRA: Number(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="St Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_STATUS: Char(32000)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Status">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_CANCELAMENTO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Cancelamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="TP_APROVSOLIC: Char(1)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Tp Aprovsolic">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Number(9)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Solicitação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Número da Solicitação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Item">
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
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Mov.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_USUAUTORIZ: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PREVISTA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade ">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cd Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Ds Observacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_INICIO: Date(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Dt Inicio">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSCANCEL: Char(500)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Ds Obscancel">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_FECHAR: Char(30)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;   --:CONTROLE.NR_ITEMCOMPRA:=:DEVOLUCAO.NR_ITEMCOMPRA;&#10;   :CONTROLE.NR_LOTECOMPRA:= :DEVOLUCAO.NR_LOTECOMPRA;&#10;   HIDE_WINDOW('WIN_SEL');&#10;   --GO_BLOCK('CONTROLE');&#10;   GO_ITEM('CONTROLE.NR_LOTECOMPRA');&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="CONS_ITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":GLOBAL.CD_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESA2">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :CONS_ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#10;    :CONS_ITEMCOMPRA.NM_EMPRESA := PACK_VALIDATE.RETORNA_NM_EMPRESA(:CONS_ITEMCOMPRA.CD_EMPRESA);&#10;  ELSE&#10;    :CONS_ITEMCOMPRA.NM_EMPRESA := NULL;&#10;  END IF;  &#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  --V_INSTRUCAO       VARCHAR2(1000);&#10;  E_GERAL            EXCEPTION;&#10;  V_MENSAGEM        VARCHAR2(32000);     &#10;  --V_COUNT            NUMBER;&#10;  --V_CD_EMPRESA      ITEMCOMPRA.CD_EMPRESA%TYPE;&#10;  --V_NR_LOTECOMPRA    ITEMCOMPRA.NR_ITEMCOMPRA%TYPE;&#10;  --V_CD_AUTORIZADOR  ITEMCOMPRA.CD_AUTORIZADOR%TYPE;&#10;  --V_CD_TIPOCOMPRA    ITEMCOMPRA.CD_TIPOCOMPRA%TYPE;&#10;  --V_DT_DESEJADA      ITEMCOMPRA.DT_DESEJADA%TYPE;&#10;  --V_DT_INICIO        ITEMCOMPRA.DT_INICIO%TYPE;&#10;  --V_NR_CONTRATO      ITEMCOMPRA.NR_CONTRATO%TYPE;&#10;  --V_CD_DEPARTAMENTO ITEMCOMPRA.CD_DEPARTAMENTO%TYPE;&#10;  &#10;BEGIN  &#10;  IF :CONS_ITEMCOMPRA.NR_LOTECOMPRA IS NOT NULL AND :CONS_ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#10;    PACK_PROCEDIMENTOS.CARREGA_ITEMCOMPRA(I_CD_EMPRESA     => :CONS_ITEMCOMPRA.CD_EMPRESA,&#10;                                          I_NR_LOTECOMPRA => :CONS_ITEMCOMPRA.NR_LOTECOMPRA,&#10;                                          O_MENSAGEM      => V_MENSAGEM);                                                &#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      RAISE E_GERAL;&#10;    END IF;&#10;  ELSE&#10;    GO_ITEM('CONS_ITEMCOMPRA.NR_LOTECOMPRA');&#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('MAXYS',V_MENSAGEM,2);&#10;  WHEN OTHERS THEN&#10;    NULL;    &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_EMPRESA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome da Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT=":GLOBAL.DS_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_LOTECOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Número do Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOTECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  E_GERAL            EXCEPTION;&#10;  V_MENSAGEM        VARCHAR2(32000);       &#10;BEGIN  &#10;  IF :CONS_ITEMCOMPRA.NR_LOTECOMPRA IS NOT NULL AND :CONS_ITEMCOMPRA.CD_EMPRESA IS NOT NULL THEN&#10;    PACK_PROCEDIMENTOS.CARREGA_ITEMCOMPRA(I_CD_EMPRESA     => :CONS_ITEMCOMPRA.CD_EMPRESA,&#10;                                          I_NR_LOTECOMPRA => :CONS_ITEMCOMPRA.NR_LOTECOMPRA,&#10;                                          O_MENSAGEM      => V_MENSAGEM);                                                &#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      RAISE E_GERAL;&#10;    END IF;&#10;  ELSE&#10;    GO_ITEM('CONS_ITEMCOMPRA.CD_EMPRESA');&#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('MAXYS',V_MENSAGEM,2);&#10;  WHEN OTHERS THEN&#10;    NULL;    &#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_CARREGA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :DUPLICAITEMCOMPRA.NR_LOTECOMPRA IS NOT NULL THEN&#10;    PACK_PROCEDIMENTOS.CARREGA_LOTE;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_CANCELA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="&#10;&#10;GO_BLOCK('DUPLICAITEMCOMPRACC');&#10;CLEAR_BLOCK(NO_VALIDATE);&#10;GO_BLOCK('DUPLICAITEMCOMPRA');&#10;CLEAR_BLOCK(NO_VALIDATE);&#10;GO_ITEM('CONTROLE.CD_AUTORIZADOR');">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="DUPLICAITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="NR_LOTECOMPRA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Nr. Solicitação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Número da Solicitação de Compras">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Número da Solicitação de Compras">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Number(8)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Moviment.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PREVISTA: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Quantidade a Solicitar. Somente será aceito casas decimais para este campo se o tipo de cálculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade a Solicitar.Somente será aceito casas decimais para este campo se o tipo de cálculo do Item for Peso.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO IS NOT NULL THEN&#10;    GO_ITEM('DUPLICAITEMCOMPRACC.CD_EMPRCCUSTODEST');&#10;  ELSIF :DUPLICAITEMCOMPRACC.CD_CENTROCUSTO IS NULL AND :SYSTEM.LAST_RECORD = 'FALSE' THEN&#10;    NEXT_RECORD;&#10;  ELSE&#10;    GO_ITEM('DUPLICAITEMCOMPRA.NR_ITEMCOMPRA');&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="DUPLICAITEMCOMPRACC">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRCCUSTODEST: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Empresa&#10;dest. custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CENTROCUSTO: Number(5)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Centro Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_CENTROCUSTO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_NEGOCIO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cód. Mov.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_AUTORIZADOR: Char(3)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PEDIDAUNIDSOL: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="PC_PARTICIPACAO: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="% Partic.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Percentual de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Percentual de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :SYSTEM.LAST_RECORD = 'FALSE' THEN&#10;    NEXT_RECORD;&#10;  ELSE&#10;    GO_ITEM('DUPLICAITEMCOMPRA.NR_ITEMCOMPRA');&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="ITEMCOMPRANEGOCIO">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PREVISTA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade a Solicitar">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRCCUSTODEST: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Empresa&#10;Destino">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESANEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST IS NULL THEN&#10;    :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST := :ITEMCOMPRA.CD_EMPRESA;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="&#10;BEGIN&#10;  IF :ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST IS NOT NULL THEN&#10;    :ITEMCOMPRANEGOCIO.NM_EMPRESADEST := PACK_VALIDATE.RETORNA_NM_EMPRESA(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST);&#10;  ELSE&#10;    :ITEMCOMPRANEGOCIO.NM_EMPRESADEST := NULL;&#10;  END IF;&#10;    &#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-NEW-ITEM-INSTANCE">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  :ITEMCOMPRANEGOCIO.CD_ITEM     := :ITEMCOMPRA.CD_ITEM;&#10;  :ITEMCOMPRANEGOCIO.DS_ITEM     := :ITEMCOMPRA.DS_ITEM;&#10;  :ITEMCOMPRANEGOCIO.QT_PREVISTA := :ITEMCOMPRA.QT_PREVISTA;&#10;  :ITEMCOMPRANEGOCIO.DS_UNIDMED  := :ITEMCOMPRA.DS_UNIDMED;&#10;  :ITEMCOMPRANEGOCIO.CD_EMPRESA  := :ITEMCOMPRA.CD_EMPRESA;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_EMPRESADEST: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cód. Movto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_TP_PEDIDO    PARMOVIMENT.TP_PEDIDO%TYPE; --PHS:60051:11/07/2013&#10;  I_CD_NATUREZA  PLANOCONTABIL.CD_NATUREZA%TYPE;&#10;  I_MENSAGEM     VARCHAR2(32000);&#10;  E_GERAL        EXCEPTION; &#10;BEGIN&#10;&#10;  IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NOT NULL THEN&#10;      IF PACK_GLOBAL.TP_SELECAOCONTA = 'O' THEN&#10;        /*MVP:72940:02/07/2014 - Alterado para voltar a mensagem padrão da função VALIDA_SELECAOCONTA quando for 'CO'*/&#10;        I_MENSAGEM := VALIDA_SELECAOCONTA (NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST,:CONTROLE.CD_EMPRESA),&#10;                                           :ITEMCOMPRANEGOCIO.CD_ITEM,&#10;                                           :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO, &#10;                                           NULL, 'CO');    &#10;        IF (I_MENSAGEM IS NOT NULL) AND (I_MENSAGEM &#60;> 'S') THEN&#10;          RAISE E_GERAL;&#10;        END IF;&#10;      END IF;&#10;      &#10;      /* CSL:02/12/2013:64869&#10;       * Alterado para chamar o procedimento VALIDA_CONTABIL_PLANO para não permitir realizar lançamentos em contas, &#10;       * que não pertencem a versão do plano de contas da empresa do lançamento.&#10;       */&#10;      PACK_VALIDA.VALIDA_CONTABIL_PLANO(:ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO, NULL, TRUNC(SYSDATE), NVL(:ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST,:GLOBAL.CD_EMPRESA), I_MENSAGEM);&#10;    &#10;      IF I_MENSAGEM IS NOT NULL THEN&#10;        RAISE E_GERAL;&#10;      END IF;&#10;      &#10;      BEGIN&#10;        /*CSL:30/12/2013:64869*/&#10;        IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;                 PLANOCONTABIL.CD_NATUREZA,&#10;                 PARMOVIMENT.TP_PEDIDO&#10;            INTO :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO,&#10;                 I_CD_NATUREZA,&#10;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#10;            FROM PARMOVIMENT,HISTCONTB,PLANOCONTABIL&#10;           WHERE PARMOVIMENT.CD_MOVIMENTACAO    = :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO&#10;             AND HISTCONTB.CD_HISTCONTB         = PARMOVIMENT.CD_HISTCONTB&#10;             AND PLANOCONTABIL.CD_CONTACONTABIL = HISTCONTB.CD_CONTACONTABIL&#10;             /*AND PLANOCONTABIL.TP_CONTACONTABIL = 'CC'*/;&#10;        &#10;        ELSE&#10;          SELECT PARMOVIMENT.DS_MOVIMENTACAO,&#10;                 PLANOCONTABILVERSAO.CD_NATUREZA,&#10;                 PARMOVIMENT.TP_PEDIDO&#10;            INTO :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO,&#10;                 I_CD_NATUREZA,&#10;                 V_TP_PEDIDO --PHS:60051:11/07/2013&#10;            FROM PARMOVIMENT, HISTCONTB, PLANOCONTABILVERSAO&#10;           WHERE PARMOVIMENT.CD_MOVIMENTACAO           = :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO&#10;             AND HISTCONTB.CD_HISTCONTB                = PARMOVIMENT.CD_HISTCONTB&#10;             AND PLANOCONTABILVERSAO.CD_CONTACONTABIL  = HISTCONTB.CD_CONTACONTABIL&#10;             /*AND PLANOCONTABILVERSAO.TP_CONTACONTABIL  = 'CC'*/&#10;             AND PLANOCONTABILVERSAO.CD_VERSAOPLANOCTB = &#10;                 PACK_CONTABIL.RETORNA_VERSAOPLANOCTBEMPR(NVL(:ITEMCOMPRA.CD_EMPRESA,:GLOBAL.CD_EMPRESA),TRUNC(SYSDATE));  &#10;        END IF;&#10;        &#10;      EXCEPTION&#10;        WHEN NO_DATA_FOUND THEN&#10;          --Movimentação ¢CD_MOVIMENTACAO¢ não cadastrada, não é de compra ou não é de Centro de Custo. Verifique TCB008.&#10;          I_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(3775,'¢CD_MOVIMENTACAO='||:ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO||'¢');&#10;          RAISE E_GERAL;&#10;      END;&#10;    &#10;      --PHS:60051:11/07/2013&#10;      IF V_TP_PEDIDO &#60;> PACK_GLOBAL.TP_PEDIDO THEN&#10;        --A movimentação ¢CD_MOVIMENTACAO¢ possui o tipo de pedido ¢TP_PEDIDO¢ diferente do tipo de pedido ¢TP_CADPEDIDO¢ cadastrado para o programa. Verificar os programas TCB008 e ANV008.&#10;        MENSAGEM_PADRAO(20737,'¢CD_MOVIMENTACAO='||:ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO||'¢TP_PEDIDO='||V_TP_PEDIDO||'¢TP_CADPEDIDO='||PACK_GLOBAL.TP_PEDIDO||'¢'); &#10;      END IF;  &#10;    &#10;          &#10;  ELSE&#10;    :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO := NULL;&#10;  END IF;&#10;  &#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO := NULL;&#10;     :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO := NULL;&#10;    MENSAGEM('Maxys',I_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    :ITEMCOMPRANEGOCIO.DS_MOVIMENTACAO := NULL;&#10;     :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO := NULL;&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEYLISTVAL">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  /*CSL:30/12/2013:64869*/&#10;  IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN &#10;    SET_LOV_PROPERTY('LOV_PARMOVIMENT',GROUP_NAME, 'LOV_PARMOVIMENT1');   &#10;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'X') IN ('O','S') &#10;        AND SHOW_LOV('LOV_PARMOVIMENT') THEN&#10;      NULL; &#10;    ELSE&#10;       SET_LOV_PROPERTY('LOV_PARMOVIMENT',GROUP_NAME, 'LOV_PARMOVIMENT');&#10;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'S')= 'S' &#10;          AND SHOW_LOV('LOV_PARMOVIMENT') THEN&#10;           NULL;&#10;      END IF;&#10;    END IF;&#10;&#10;  ELSE--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN&#10;    &#10;    SET_LOV_PROPERTY('LOV_PARMOVIMENTVERSAO',GROUP_NAME, 'LOV_PARMOVIMENT1VERSAO');   &#10;    IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'X') IN ('O','S') &#10;        AND SHOW_LOV('LOV_PARMOVIMENTVERSAO') THEN&#10;      NULL; &#10;    ELSE&#10;       SET_LOV_PROPERTY('LOV_PARMOVIMENTVERSAO',GROUP_NAME, 'LOV_PARMOVIMENTVERSAO');&#10;       IF NVL(PACK_GLOBAL.TP_SELECAOCONTA,'S')= 'S' &#10;          AND SHOW_LOV('LOV_PARMOVIMENTVERSAO') THEN&#10;           NULL;&#10;      END IF;&#10;    END IF;&#10;  END IF;--IF NVL(PACK_VALIDA.RETORNA_OPCAO_PLANOCONTAS,'D') = 'D' THEN  &#10;END;">
</node>
</node>
</node>
<node TEXT="PRE-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL THEN&#10;    :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO := :ITEMCOMPRA.CD_MOVIMENTACAO;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_NEGOCIO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_NEGOCIORATEIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN  &#10;    SELECT DS_NEGOCIO&#10;      INTO :ITEMCOMPRANEGOCIO.DS_NEGOCIO&#10;      FROM NEGOCIO&#10;     WHERE NEGOCIO.CD_NEGOCIO = :ITEMCOMPRANEGOCIO.CD_NEGOCIO;&#10;     &#10;    IF :SYSTEM.CURSOR_ITEM = :SYSTEM.TRIGGER_ITEM AND  :ITEMCOMPRA.CD_MOVIMENTACAO IS NOT NULL AND :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NOT NULL THEN&#10;      VALIDA_CONTA_ORCAMENTO('ITEMCOMPRANEGOCIO.CD_CONTAORCAMENTO', :ITEMCOMPRA.CD_MOVIMENTACAO, null,:ITEMCOMPRANEGOCIO.CD_NEGOCIO);&#10;    END IF; &#10;  ELSE&#10;    :ITEMCOMPRANEGOCIO.DS_NEGOCIO := NULL;&#10;  END IF;&#10;EXCEPTION&#10;  WHEN NO_DATA_FOUND THEN&#10;    MENSAGEM_PADRAO(147,'¢CD_NEGOCIO='||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||'¢');--O Negócio ¢CD_NEGOCIO¢ não está cadastrado. Verifique o programa TCB001.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN TOO_MANY_ROWS THEN&#10;    MENSAGEM_PADRAO(148,'¢CD_NEGOCIO='||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||'¢');--O Negócio ¢CD_NEGOCIO¢ está cadastrado várias vezes. Verifique o programa TCB001.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM_PADRAO(149,'¢CD_NEGOCIO='||:ITEMCOMPRANEGOCIO.CD_NEGOCIO||'¢SQLERRM='||SQLERRM||'¢');--Ocorreu um erro inesperado ao consultar os dados do código de Negócio ¢CD_NEGOCIO¢. Erro: ¢SQLERRM¢.&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_NEGOCIO: Char(60)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_NEGOCIORATEIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PEDIDAUNIDSOL: Number(17)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NOT NULL THEN       &#10;    IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL  THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);  &#10;       --A movimentação deve ser informada. &#10;       MENSAGEM_PADRAO(298,'');&#10;       GO_ITEM('ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO');&#10;    ELSIF:ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;        --O centro de custo deve ser informado.&#10;        MENSAGEM_PADRAO(292,'');&#10;        GO_ITEM('ITEMCOMPRANEGOCIO.CD_NEGOCIO');&#10;    ELSE   &#10;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#10;          SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;          SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;           GO_ITEM('ITEMCOMPRANEGOCIO.BTN_OK');&#10;        ELSE &#10;          IF GET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.PC_PARTICIPACAO',ENABLED) = 'TRUE' THEN&#10;            SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.PC_PARTICIPACAO',ENABLED,PROPERTY_FALSE);&#10;           END IF;&#10;             &#10;             &#10;           IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) > ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#10;                   --A soma dos valores lançados em Centro de Custo ¢VL_CCUSTO¢ para o item ¢CD_ITEM¢ deve corresponder ao valor lançados no pedido ¢VL_TOTITEM¢.&#10;                  MENSAGEM_PADRAO(29150,'¢VL_CCUSTO=' ||ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL)||&#10;                                       '¢CD_ITEM='   ||:ITEMCOMPRANEGOCIO.CD_ITEM||&#10;                                       '¢VL_TOTITEM='||ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA)||'¢');&#10;                  SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;                 RAISE FORM_TRIGGER_FAILURE;&#10;               &#10;            END IF;&#10;             NEXT_RECORD;&#10;             GO_ITEM('ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST');&#10;             &#10;        END IF;      &#10;    END IF;&#10;  ELSE&#10;    NEXT_ITEM;      &#10;  END IF;   &#10;END;">
</node>
</node>
</node>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  IF :SYSTEM.CURSOR_ITEM = 'ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL' THEN&#10;    DECLARE&#10;      V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE; &#10;    BEGIN &#10;      SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#10;        INTO V_ST_UNIDMEDIDA&#10;        FROM ITEM, UNIDMEDIDA&#10;       WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#10;         AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;           &#10;      IF ( V_ST_UNIDMEDIDA = 'U' ) THEN&#10;         :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL);&#10;      END IF;         &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        NULL;&#10;    END;  &#10;    &#10;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (2,3)) THEN&#10;      IF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO IS NULL) THEN&#10;        :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL * 100 /&#10;                                                   :ITEMCOMPRANEGOCIO.QT_PREVISTA,3);&#10;                                                &#10;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#10;           SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;           SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;        ELSE &#10;          IF (GET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.PC_PARTICIPACAO',ENABLED) = 'TRUE') THEN&#10;             SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.PC_PARTICIPACAO',ENABLED,PROPERTY_FALSE);&#10;          END IF;&#10;        END IF;        &#10;        &#10;        /* DCS:19/12/2013:67379 &#10;         * faz o arredondamento no último percentual, com base na autosugestão do percentual apos digitar a última quantidade d&#10;         * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#10;         */&#10;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) AND&#10;           NVL(:ITEMCOMPRANEGOCIO.PC_TOTAL,0) > 100 THEN&#10;          :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO - (:ITEMCOMPRANEGOCIO.PC_TOTAL - 100);&#10;        END IF;&#10;        &#10;      ELSIF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NOT NULL) AND (:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO IS NOT NULL) THEN&#10;        :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL * 100 /&#10;                                                   :ITEMCOMPRANEGOCIO.QT_PREVISTA,3);&#10;        &#10;        /* DCS:19/12/2013:67379 &#10;         * faz o arredondamento no último percentual, com base na autosugestão do percentual apos digitar a última quantidade d&#10;         * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#10;         */&#10;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) AND&#10;           NVL(:ITEMCOMPRANEGOCIO.PC_TOTAL,0) > 100 THEN&#10;          :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO - (:ITEMCOMPRANEGOCIO.PC_TOTAL - 100);&#10;        END IF;        &#10;        &#10;      ELSIF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NULL) THEN&#10;        SET_ITEM_PROPERTY('ITEMCOMPRANEGOCIO.PC_PARTICIPACAO',ENABLED,PROPERTY_TRUE);&#10;        SET_ITEM_PROPERTY('ITEMCOMPRANEGOCIO.PC_PARTICIPACAO',NAVIGABLE,PROPERTY_TRUE);&#10;      END IF;&#10;    END IF;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;   IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) &#60; ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) > ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#10;       --A soma dos valores lançados em Centro de Custo ¢VL_CCUSTO¢ para o item ¢CD_ITEM¢ deve corresponder ao valor lançados no pedido ¢VL_TOTITEM¢.&#10;      MENSAGEM_PADRAO(4526,'¢VL_CCUSTO=' ||ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL)||&#10;                           '¢CD_ITEM='   ||:ITEMCOMPRANEGOCIO.CD_ITEM||&#10;                           '¢VL_TOTITEM='||ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA)||'¢');&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) THEN&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;      SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;   END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN  &#10;  IF (ERROR_TYPE = 'FRM') AND (ERROR_CODE = 40209) THEN&#10;    MENSAGEM('','Os caracteres válidos são 0-9 - e +.',4);&#10;  ELSE&#10;    VALIDA_ERROS;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="PC_PARTICIPACAO: Number(10)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="% Partic.">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Percentual de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Percentual de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM  VARCHAR2(32000);&#10;  E_GERAL      EXCEPTION;&#10;BEGIN&#10;  IF :SYSTEM.CURSOR_ITEM = 'ITEMCOMPRANEGOCIO.PC_PARTICIPACAO' AND (:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO IS NOT NULL) THEN&#10;    &#10;    IF (NVL(:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO,0) &#60;= 0) THEN&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20921, NULL);&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN     &#10;      :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA * :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO / 100 ,3);&#10;    END IF;                                              &#10;       &#10;     IF NVL(PACK_GLOBAL.TP_ITEM,'N') &#60;> 'S'  THEN&#10;       &#10;       DECLARE&#10;         V_ST_UNIDMEDIDA UNIDMEDIDA.ST_UNIDMEDIDA%TYPE;&#10;       BEGIN &#10;         SELECT UNIDMEDIDA.ST_UNIDMEDIDA&#10;           INTO V_ST_UNIDMEDIDA&#10;           FROM ITEM, UNIDMEDIDA&#10;          WHERE UNIDMEDIDA.CD_UNIDMED = ITEM.CD_UNIDMED &#10;            AND ITEM.CD_ITEM = :ITEMCOMPRA.CD_ITEM;&#10;             &#10;         IF ( V_ST_UNIDMEDIDA = 'U' ) AND (:CONTROLE.LST_AUTOSUGESTAO IN (1,3))  THEN&#10;            :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL);&#10;            :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO  := ROUND(:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL * 100 /&#10;                                                        :ITEMCOMPRANEGOCIO.QT_PREVISTA,3);&#10;         END IF;&#10;           &#10;       EXCEPTION&#10;          WHEN NO_DATA_FOUND THEN&#10;            NULL;&#10;       END;&#10;                                                  &#10;      ELSIF  GET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL',ENABLED) = 'TRUE' THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL',ENABLED,PROPERTY_FALSE);&#10;      END IF;&#10;      &#10;      /* DCS:19/12/2013:67379 &#10;      * faz o arredondamento no último percentual, com base na autosugestão do percentual apos digitar a última quantidade d&#10;      * o centro de custo e quando o percentual total sumarizar mais de 100 %.&#10;      */&#10;      IF (:CONTROLE.LST_AUTOSUGESTAO IN (1,3)) THEN &#10;        IF ROUND(:ITEMCOMPRANEGOCIO.QT_TOTAL) = ROUND(:ITEMCOMPRANEGOCIO.QT_PREVISTA) AND&#10;          NVL(:ITEMCOMPRANEGOCIO.PC_TOTAL,0) > 100 THEN&#10;         :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO := :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO - (:ITEMCOMPRANEGOCIO.PC_TOTAL - 100);&#10;       END IF;&#10;      END IF;&#10;      &#10;  END IF;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
<node TEXT="POST-TEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN &#10;   IF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) &#60; 100 THEN&#10;      IF GET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED) = 'TRUE' THEN&#10;         SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;      END IF;&#10;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) > 100 THEN&#10;       --A soma do percentual de participação dos centros de custos deve ser igual a 100%.&#10;       MENSAGEM_PADRAO(4740,'');     &#10;      :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL := NULL;&#10;      :ITEMCOMPRANEGOCIO.PC_PARTICIPACAO  := NULL;&#10;      IF GET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED) = 'TRUE' THEN&#10;         SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;      END IF;&#10;     &#10;   ELSIF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) = 100 THEN&#10;      IF GET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED) = 'FALSE' THEN&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_TRUE);&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',NAVIGABLE,PROPERTY_TRUE);&#10;      END IF;&#10;   END IF;&#10;   IF ROUND(:ITEMCOMPRANEGOCIO.PC_PARTICIPACAO,3) = 100 THEN&#10;      :ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL:=:ITEMCOMPRANEGOCIO.QT_PREVISTA;&#10;   END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="KEY-NEXT-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  VALIDATE(ITEM_SCOPE);&#10;  IF FORM_SUCCESS THEN&#10;    IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL  THEN&#10;       SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);  &#10;       --A movimentação deve ser informada.&#10;       MENSAGEM_PADRAO(298,'');&#10;       GO_ITEM('ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO');&#10;    ELSIF:ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;        --O centro de custo deve ser informado.&#10;        MENSAGEM_PADRAO(292,'');&#10;        GO_ITEM('ITEMCOMPRANEGOCIO.CD_NEGOCIO');&#10;    ELSE&#10;      IF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) &#60; 100 THEN&#10;         NEXT_RECORD;&#10;         --GDG:01/08/2011:28715&#10;         IF GET_ITEM_PROPERTY('ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST', VISUAL_ATTRIBUTE) = 'VSA_CAMPOTEXTO' THEN&#10;           GO_ITEM('ITEMCOMPRANEGOCIO.CD_EMPRCCUSTODEST');&#10;         ELSE&#10;           GO_ITEM('ITEMCOMPRANEGOCIO.CD_NEGOCIO');&#10;         END IF;&#10;      ELSIF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) = 100 THEN&#10;        GO_ITEM('ITEMCOMPRANEGOCIO.BTN_OK');&#10;      END IF;    &#10;    END IF;     &#10;  ELSE            &#10;    RETURN;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
<node TEXT="ON-ERROR">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN  &#10;  IF (ERROR_TYPE = 'FRM') AND (ERROR_CODE = 40209) THEN&#10;    MENSAGEM('','Os caracteres válidos são 0-9 - e +.',4);&#10;  ELSE&#10;    VALIDA_ERROS;&#10;  END IF;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSERVACAO: Char(150)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Complemento">
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
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_OK: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  E_GERAL       EXCEPTION;&#10;  E_ALERTA      EXCEPTION;&#10;  V_MENSAGEM     VARCHAR2(32000);&#10;  V_ST_EXIBEMSG  BOOLEAN DEFAULT FALSE;--MGK:61460:30/07/2013&#10;  &#10;BEGIN&#10;  --GDG:01/08/2011:28715&#10;  VALIDATE(ITEM_SCOPE);&#10;  IF FORM_SUCCESS THEN&#10;    VALIDATE(RECORD_SCOPE);&#10;    IF NOT FORM_SUCCESS THEN&#10;      RETURN;&#10;    END IF;&#10;  ELSE&#10;    RETURN;&#10;  END IF;&#10;  &#10;  IF ROUND(:ITEMCOMPRANEGOCIO.PC_TOTAL,2) = 100 THEN&#10;    IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL AND :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#10;       DELETE_RECORD;&#10;    END IF;&#10;    --------------------------------------------------------------------&#10;    --VERIFICA SE A MOVIMENTAÇÃO E O CENTRO DE CUSTO ESTÃO PREENCHIDOS--&#10;    --------------------------------------------------------------------&#10;    FIRST_RECORD;&#10;    LOOP &#10;      IF :ITEMCOMPRANEGOCIO.CD_MOVIMENTACAO IS NULL OR :ITEMCOMPRANEGOCIO.CD_NEGOCIO IS NULL THEN&#10;        SET_ITEM_PROPERTY ('ITEMCOMPRANEGOCIO.BTN_OK',ENABLED,PROPERTY_FALSE);&#10;        RAISE E_GERAL;&#10;      END IF;&#10;      &#10;      IF (:ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL IS NULL) THEN&#10;        V_ST_EXIBEMSG := TRUE;&#10;      END IF;&#10;      &#10;      EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;      NEXT_RECORD;&#10;    END LOOP;&#10;    &#10;    &#10;    VALIDA_DUPLICADOS_NEGOCIO(V_MENSAGEM);&#10;    &#10;    IF V_MENSAGEM IS NOT NULL THEN&#10;      MENSAGEM('Maxys',V_MENSAGEM,2);&#10;      RAISE E_GERAL;&#10;    END IF;&#10;    &#10;    ADICIONA_GRUPO_NEGOCIO;&#10;    GO_ITEM('ITEMCOMPRA.DS_OBSERVACAO');&#10;  ELSE&#10;     --A soma do percentual de participação dos centros de custos deve ser igual a 100%.&#10;     MENSAGEM_PADRAO(4740,'');     &#10;    GO_ITEM('ITEMCOMPRANEGOCIO.QT_PEDIDAUNIDSOL');&#10;  END IF;&#10;  &#10;  --MGK:61460:30/07/2013&#10;  /*IF (V_ST_EXIBEMSG) THEN&#10;    V_ALERT := SHOW_ALERT('ALR_QTDENULA');&#10;    IF (V_ALERT = ALERT_BUTTON1) THEN&#10;      NULL;&#10;    ELSIF (V_ALERT = ALERT_BUTTON2) THEN &#10;      GO_BLOCK('ITEMCOMPRANEGOCIO');&#10;      V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20836, NULL);&#10;      RAISE E_ALERTA;&#10;    ELSE&#10;      NULL;&#10;    END IF;&#10;  END IF;*/&#10;  &#10;EXCEPTION&#10;  WHEN E_ALERTA THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN E_GERAL THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_CANCELAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  CLEAR_BLOCK (NO_VALIDATE);&#10;  --:ITEMCOMPRA.QT_PREVISTA := 0;&#10;  PACK_GRUPO_NEGOCIO.DELETA_GRUPO_NEGOCIO(:ITEMCOMPRANEGOCIO.CD_ITEM);&#10;  GO_ITEM('ITEMCOMPRA.QT_PREVISTA');&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Soma das Quantidades">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="PC_TOTAL: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Soma dos Percentuais de Participação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CONTAORCAMENTO: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
</node>
</node>
<node TEXT="PROJETOITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEM: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_UNIDMED: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Unidade de Medida do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PREVISTA: Number(20)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade Total">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Quantidade a Solicitar">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ESTUDO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM     VARCHAR2(32000);&#10;  E_GERAL        EXCEPTION; &#10;BEGIN&#10;  BEGIN&#10;    SELECT PROJETOMONI.CD_PROJETO, &#10;           ESTUDOMONI.NM_ESTUDO&#10;      INTO :PROJETOITEMCOMPRA.CD_PROJETO, &#10;           :PROJETOITEMCOMPRA.DS_PROJETO&#10;      FROM PROJETOMONI, ESTUDOMONI&#10;     WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#10;       AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#10;       AND PROJETOMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#10;                                       FROM PROJETOMONI PROJ&#10;                                      WHERE PROJETOMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#10;                                        AND PROJETOMONI.CD_PROJETO = PROJ.CD_PROJETO);&#10;&#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      NULL;&#10;  END;&#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_PROJETO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PROJETOMONI">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM     VARCHAR2(32000);&#10;  E_GERAL        EXCEPTION; &#10;BEGIN&#10;  IF :PROJETOITEMCOMPRA.CD_PROJETO IS NOT NULL THEN&#10;    BEGIN&#10;      SELECT DISTINCT PROJETOMONI.CD_ESTUDO, &#10;                      PROJETOMONI.CD_PROJETO, &#10;                      PROJETOMONI.NR_VERSAO, &#10;                      ESTUDOMONI.NM_ESTUDO&#10;        INTO :PROJETOITEMCOMPRA.CD_ESTUDO, &#10;             :PROJETOITEMCOMPRA.CD_PROJETO, &#10;             :PROJETOITEMCOMPRA.NR_VERSAO, &#10;             :PROJETOITEMCOMPRA.DS_PROJETO&#10;        FROM PROJETOMONI,&#10;             ESTUDOMONI,&#10;             ORCAMENTOMONI,&#10;             GRUPOMOVIMENTACAOMONI,&#10;             MOVIMENTACAOGRUPOMONI&#10;       WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#10;         AND ORCAMENTOMONI.CD_ESTUDO = PROJETOMONI.CD_ESTUDO&#10;         AND ORCAMENTOMONI.CD_PROJETO = PROJETOMONI.CD_PROJETO&#10;         AND ORCAMENTOMONI.NR_VERSAO = PROJETOMONI.NR_VERSAO&#10;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#10;             GRUPOMOVIMENTACAOMONI.CD_GRUPOMOVIMENTACAO&#10;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#10;             MOVIMENTACAOGRUPOMONI.CD_GRUPOMOVIMENTACAO&#10;         AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;         AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#10;         AND PROJETOMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#10;                                         FROM PROJETOMONI PROJ&#10;                                        WHERE PROJETOMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#10;                                          AND PROJETOMONI.CD_PROJETO = PROJ.CD_PROJETO);&#10;  &#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32294, '¢CD_PROJETO='||:PROJETOITEMCOMPRA.CD_PROJETO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32295, '¢CD_PROJETO='||:PROJETOITEMCOMPRA.CD_PROJETO||'¢SQLERRM='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;  ELSE&#10;    :PROJETOITEMCOMPRA.DS_PROJETO := NULL;&#10;  END IF;&#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_VERSAO: Number(4)">
<icon BUILTIN="Mapping.directToField"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código do Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM     VARCHAR2(32000);&#10;  E_GERAL        EXCEPTION; &#10;BEGIN&#10;  BEGIN&#10;    SELECT PROJETOMONI.CD_PROJETO, &#10;           ESTUDOMONI.NM_ESTUDO&#10;      INTO :PROJETOITEMCOMPRA.CD_PROJETO, &#10;           :PROJETOITEMCOMPRA.DS_PROJETO&#10;      FROM PROJETOMONI, ESTUDOMONI&#10;     WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#10;       AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#10;       AND PROJETOMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#10;                                       FROM PROJETOMONI PROJ&#10;                                      WHERE PROJETOMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#10;                                        AND PROJETOMONI.CD_PROJETO = PROJ.CD_PROJETO);&#10;&#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      NULL;&#10;  END;&#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_PROJETO: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Nome do Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ETAPA: Number(5)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Etapa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="hint">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Código da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ETAPAMONI">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM     VARCHAR2(32000);&#10;  E_GERAL        EXCEPTION; &#10;BEGIN&#10;    &#10;  IF :PROJETOITEMCOMPRA.CD_ETAPA IS NOT NULL THEN&#10;    BEGIN&#10;      SELECT ETAPAMONI.CD_ETAPA, &#10;             ETAPAMONI.DS_ETAPA&#10;        INTO :PROJETOITEMCOMPRA.CD_ETAPA,&#10;             :PROJETOITEMCOMPRA.DS_ETAPA&#10;        FROM ETAPAMONI,&#10;             PROJETOMONI,&#10;             ESTUDOMONI,&#10;             ORCAMENTOMONI,&#10;             GRUPOMOVIMENTACAOMONI,&#10;             MOVIMENTACAOGRUPOMONI&#10;       WHERE PROJETOMONI.CD_ESTUDO = ESTUDOMONI.CD_ESTUDO&#10;         AND ORCAMENTOMONI.CD_ESTUDO = PROJETOMONI.CD_ESTUDO&#10;         AND ORCAMENTOMONI.CD_PROJETO = PROJETOMONI.CD_PROJETO&#10;         AND ORCAMENTOMONI.NR_VERSAO = PROJETOMONI.NR_VERSAO&#10;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#10;             GRUPOMOVIMENTACAOMONI.CD_GRUPOMOVIMENTACAO&#10;         AND ORCAMENTOMONI.CD_GRUPOMOVIMENTACAO =&#10;             MOVIMENTACAOGRUPOMONI.CD_GRUPOMOVIMENTACAO&#10;         AND MOVIMENTACAOGRUPOMONI.CD_MOVIMENTACAO = :ITEMCOMPRA.CD_MOVIMENTACAO&#10;         AND PROJETOMONI.CD_ESTUDO = ETAPAMONI.CD_ESTUDO&#10;         AND PROJETOMONI.CD_PROJETO = ETAPAMONI.CD_PROJETO&#10;         AND PROJETOMONI.NR_VERSAO = ETAPAMONI.NR_VERSAO&#10;         AND ETAPAMONI.CD_ETAPA = ORCAMENTOMONI.CD_ETAPA&#10;         AND PROJETOMONI.CD_PROJETO = :PROJETOITEMCOMPRA.CD_PROJETO&#10;         AND ETAPAMONI.CD_ETAPA = :PROJETOITEMCOMPRA.CD_ETAPA&#10;         AND ETAPAMONI.NR_VERSAO IN (SELECT MAX(NR_VERSAO)&#10;                                       FROM PROJETOMONI PROJ&#10;                                      WHERE ETAPAMONI.CD_ESTUDO = PROJ.CD_ESTUDO&#10;                                        AND ETAPAMONI.CD_PROJETO = PROJ.CD_PROJETO);&#10;    EXCEPTION&#10;      WHEN NO_DATA_FOUND THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32296, '¢CD_ETAPA='||:PROJETOITEMCOMPRA.CD_ETAPA||'¢CD_PROJETO='||:PROJETOITEMCOMPRA.CD_PROJETO||'¢');&#10;        RAISE E_GERAL;&#10;      WHEN OTHERS THEN&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(32297, '¢CD_ETAPA='||:PROJETOITEMCOMPRA.CD_ETAPA||'¢CD_PROJETO='||:PROJETOITEMCOMPRA.CD_PROJETO||'¢SQLERRM='||SQLERRM||'¢');&#10;        RAISE E_GERAL;&#10;    END;&#10;  ELSE&#10;    :PROJETOITEMCOMPRA.DS_ETAPA := NULL;&#10;  END IF;&#10;  &#10;EXCEPTION  &#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys COM001 - Erro',SQLERRM,1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ETAPA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="tooltip">
<icon BUILTIN="element"/>
<node TEXT="Descrição da Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BTN_OK: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  E_GERAL       EXCEPTION;&#10;  E_ALERTA      EXCEPTION;&#10;  V_MENSAGEM     VARCHAR2(32000);&#10;  &#10;BEGIN&#10;  --GDG:01/08/2011:28715&#10;  VALIDATE(ITEM_SCOPE);&#10;  IF FORM_SUCCESS THEN&#10;    VALIDATE(RECORD_SCOPE);&#10;    IF NOT FORM_SUCCESS THEN&#10;      RETURN;&#10;    END IF;&#10;  ELSE&#10;    RETURN;&#10;  END IF;&#10;  &#10;  IF :PROJETOITEMCOMPRA.CD_PROJETO IS NOT NULL AND :PROJETOITEMCOMPRA.CD_ETAPA IS NOT NULL THEN&#10;    :ITEMCOMPRA.CD_ESTUDOMONI := :PROJETOITEMCOMPRA.CD_ESTUDO;&#10;    :ITEMCOMPRA.CD_PROJETOMONI := :PROJETOITEMCOMPRA.CD_PROJETO;&#10;    :ITEMCOMPRA.NR_VERSAOMONI := :PROJETOITEMCOMPRA.NR_VERSAO;&#10;    :ITEMCOMPRA.CD_ETAPAMONI   := :PROJETOITEMCOMPRA.CD_ETAPA;&#10;  END IF;&#10;  :ITEMCOMPRA.ST_PROJETOMONI := 'S';&#10;  GO_BLOCK('ITEMCOMPRA');&#10;  EXECUTE_TRIGGER('KEY-COMMIT');&#10;  &#10;EXCEPTION&#10;  WHEN E_ALERTA THEN&#10;    MENSAGEM('Maxys',V_MENSAGEM,2);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN E_GERAL THEN&#10;    NULL;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_CANCELAR: Char(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="BEGIN&#10;  CLEAR_BLOCK (NO_VALIDATE);&#10;  --:ITEMCOMPRA.QT_PREVISTA := 0;&#10;  GO_ITEM('ITEMCOMPRA.QT_PREVISTA');&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="PREITEMCOMPRA">
<icon BUILTIN="Descriptor.advancedProperties"/>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="ST_MARCADO: Number(1)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="">
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
<node TEXT="">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="defaultValue">
<icon BUILTIN="element"/>
<node TEXT="0">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Item Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_PREITEMCOMPRA: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Descrição Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEMAXYS: Number(7)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Cód. Item &#10;Maxys">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMPRECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-VALIDATE-ITEM">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT=":PREITEMCOMPRA.DS_ITEMAXYS := PACK_VALIDATE.RETORNA_DS_ITEM(I_CD_ITEM => :PREITEMCOMPRA.CD_ITEMAXYS);">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_ITEM: Number(15)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Quantidade">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_OBSERVACAO: Char(600)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Observação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_AGRUPAMENTO: Number(8)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Lote Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DS_ITEMAXYS: Char(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Descrição Item Maxys">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="valuesListName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMPRECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_SELECIONADOS: Number()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DT_DESEJADA: Date(10)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="label">
<icon BUILTIN="element"/>
<node TEXT="Data Desejada">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_CONFIRMAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  TYPE R_PREITEMCOMPRA IS RECORD (NR_PREITEMCOMPRA PREITEMCOMPRA.NR_PREITEMCOMPRA%TYPE,&#10;                                  CD_ITEM          PREITEMCOMPRA.CD_ITEM%TYPE,&#10;                                  QT_ITEM          PREITEMCOMPRA.QT_ITEM%TYPE);&#10;  &#10;  TYPE T_PREITEMCOMPRA IS TABLE OF R_PREITEMCOMPRA INDEX BY BINARY_INTEGER;&#10;  &#10;  V_PREITEMCOMPRA  T_PREITEMCOMPRA;&#10;  V_MENSAGEM       VARCHAR2(32000);&#10;  E_GERAL           EXCEPTION;&#10;  V                NUMBER;&#10;  V_DT_DESEJADA     PREITEMCOMPRA.DT_DESEJADA%TYPE;&#10;BEGIN&#10;  IF NVL(:PREITEMCOMPRA.QT_SELECIONADOS, 0) = 0 THEN&#10;    /*Deve ser selecionado ao menos um item.*/&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34157, NULL);&#10;    RAISE E_GERAL;&#10;  END IF;&#10;&#10;  IF (SHOW_ALERT('CONFIRMA_PREITEMCOMPRA') &#60;> ALERT_BUTTON1) THEN&#10;    /*Processo abortado pelo usuário.*/&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20773, NULL);&#10;    RAISE E_GERAL;&#10;  END IF;&#10;  &#10;  V_PREITEMCOMPRA.DELETE;&#10;  V := 1;&#10;&#10;  GO_BLOCK('PREITEMCOMPRA');&#10;  FIRST_RECORD;&#10;  &#10;  LOOP&#10;    IF (:PREITEMCOMPRA.ST_MARCADO = 1) THEN    &#10;      IF (:PREITEMCOMPRA.CD_ITEMAXYS IS NULL) THEN&#10;        /*O Item deve ser informado.*/&#10;        V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(2624, NULL);&#10;        RAISE E_GERAL;&#10;      END IF;&#10;      &#10;      V_PREITEMCOMPRA(V).NR_PREITEMCOMPRA := :PREITEMCOMPRA.NR_ITEMCOMPRA;&#10;      V_PREITEMCOMPRA(V).CD_ITEM          := :PREITEMCOMPRA.CD_ITEMAXYS;&#10;      V_PREITEMCOMPRA(V).QT_ITEM          := :PREITEMCOMPRA.QT_ITEM;&#10;  &#10;      IF ((V_DT_DESEJADA IS NULL) OR (V_DT_DESEJADA > :PREITEMCOMPRA.DT_DESEJADA)) THEN&#10;        V_DT_DESEJADA := :PREITEMCOMPRA.DT_DESEJADA;&#10;      END IF;&#10;    END IF;&#10;    EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;    &#10;    IF (:PREITEMCOMPRA.ST_MARCADO = 1) THEN&#10;      V := V + 1;&#10;    END IF;&#10;&#10;    NEXT_RECORD;&#10;  END LOOP;&#10;&#10;  :CONTROLE.DT_DESEJADA := V_DT_DESEJADA;&#10;  :CONTROLE.CD_EMPRESA := :GLOBAL.CD_EMPRESA;&#10;&#10;  GO_BLOCK('ITEMCOMPRA');&#10;  FIRST_RECORD;&#10;  &#10;  FOR I IN 1..V_PREITEMCOMPRA.COUNT LOOP&#10;    :ITEMCOMPRA.NR_PREITEMCOMPRA := V_PREITEMCOMPRA(I).NR_PREITEMCOMPRA;&#10;    :ITEMCOMPRA.CD_ITEM          := V_PREITEMCOMPRA(I).CD_ITEM;&#10;    :ITEMCOMPRA.QT_PREVISTA       := V_PREITEMCOMPRA(I).QT_ITEM;&#10;    &#10;    NEXT_RECORD;&#10;  END LOOP;&#10;  &#10;  FIRST_RECORD;&#10;&#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||' - Erro', V_MENSAGEM, 1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||' - Erro', SQLERRM, 1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="BT_FECHAR: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="GO_ITEM('CONTROLE.CD_EMPRESA');">
</node>
</node>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ITEM189: Button()">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="trigger">
<icon BUILTIN="element"/>
<node TEXT="WHEN-BUTTON-PRESSED">
<icon BUILTIN="element"/>
<node FOLDED="true" TEXT="body">
<node TEXT="DECLARE&#10;  V_MENSAGEM             VARCHAR2(32000);&#10;  E_GERAL                 EXCEPTION;&#10;  V_COUNTITEMCOMPRA       NUMBER;&#10;BEGIN&#10;  IF NVL(:PREITEMCOMPRA.QT_SELECIONADOS, 0) = 0 THEN&#10;    /*Deve ser selecionado ao menos um item.*/&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(34157, NULL);&#10;    RAISE E_GERAL;&#10;  END IF;&#10;&#10;  IF (SHOW_ALERT('CANCELA_PREITEMCOMPRA') &#60;> ALERT_BUTTON1) THEN&#10;    /*Processo abortado pelo usuário.*/&#10;    V_MENSAGEM := PACK_MENSAGEM.MENS_PADRAO(20773, NULL);&#10;    RAISE E_GERAL;&#10;  END IF;&#10;&#10;  GO_BLOCK('PREITEMCOMPRA');&#10;  FIRST_RECORD;&#10;  &#10;  LOOP&#10;    IF (:PREITEMCOMPRA.ST_MARCADO = 1) THEN&#10;      BEGIN&#10;      UPDATE PREITEMCOMPRA&#10;         SET PREITEMCOMPRA.ST_PREITEMCOMPRA = '9'&#10;       WHERE PREITEMCOMPRA.NR_PREITEMCOMPRA = :PREITEMCOMPRA.NR_ITEMCOMPRA;&#10;      EXCEPTION&#10;        WHEN OTHERS THEN&#10;          NULL;&#10;      END;&#10;      &#10;    END IF;&#10;&#10;    EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';&#10;    NEXT_RECORD;&#10;  END LOOP;&#10;&#10;  FAZ_COMMIT;&#10;  &#10;  /*Solicitações de compra Canceladas.*/&#10;  MENSAGEM_PADRAO(34180, NULL);&#10;  &#10;  BEGIN&#10;    SELECT COUNT(*)&#10;      INTO V_COUNTITEMCOMPRA&#10;      FROM PREITEMCOMPRA&#10;     WHERE PREITEMCOMPRA.CD_EMPRESA = :GLOBAL.CD_EMPRESA&#10;       AND PREITEMCOMPRA.ST_PREITEMCOMPRA = '1';    &#10;  EXCEPTION&#10;    WHEN OTHERS THEN&#10;      V_COUNTITEMCOMPRA := 0;&#10;  END;&#10;&#10;  IF (V_COUNTITEMCOMPRA > 0) THEN    &#10;    PACK_PREITEMCOMPRA.CARREGA_PREITEMCOMPRA(V_MENSAGEM);&#10;&#10;    IF (V_MENSAGEM IS NOT NULL) THEN&#10;      RAISE E_GERAL;&#10;    END IF;&#10;  ELSE&#10;    CLEAR_BLOCK(NO_VALIDATE);&#10;    GO_ITEM('CONTROLE.CD_EMPRESA');&#10;  END IF;&#10;  &#10;EXCEPTION&#10;  WHEN E_GERAL THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||' - Erro', V_MENSAGEM, 1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;  WHEN OTHERS THEN&#10;    MENSAGEM('Maxys '||:GLOBAL.CD_MODULO||LPAD(:GLOBAL.CD_PROGRAMA, 3, 0)||' - Erro', SQLERRM, 1);&#10;    RAISE FORM_TRIGGER_FAILURE;&#10;END;">
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="list of values">
<icon BUILTIN="Descriptor.grouping"/>
<node TEXT="LOV_LOCALORIGEM">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Locais de Armazenagem de Origem">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOCALARMAZENAGEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_LOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Local Armazenagem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_TIPOLOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_LOCALARMAZ: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ1: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ2: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ3: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 3">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ4: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 4">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_LOCALUSUARIO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Locais de Armazenagem de Origem">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ARMAZEMUSUARIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_LOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Local Armazenagem">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_TIPOLOCALARMAZ: Button(100)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_LOCALARMAZ: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Local">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ1: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ2: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 2">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ3: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 3">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_SUBLOCARMAZ4: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Sub 4">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_DEPCOMPRAAUTO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Selecione o Departamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_DEPCOMPRAAUTO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_DEPARTAMENTO: Button(675)">
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
<node FOLDED="true" TEXT="CD_DEPARTAMENTO: Button(45)">
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
<node TEXT="LOV_ETAPAMONI">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Etapa">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ETAPAMONI">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_ETAPA: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Etapa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ETAPA: Button(80)">
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
<node TEXT="LOV_PROJETOMONI">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Projeto ">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PROJETOMONI">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NM_ESTUDO: Button(300)">
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
<node FOLDED="true" TEXT="CD_ESTUDO: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Estudo">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_PROJETO: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Projeto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_VERSAO: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Versão">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_EMPRCCUSTODEST">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Empresa de destino do custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NM_EMPRESA: Button(400)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Nome">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(50)">
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
<node TEXT="LOV_EMPRESANEGOCIO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Empresa de destino do Negocio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESANEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NM_EMPRESA: Button(400)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Nome">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(50)">
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
<node TEXT="LOV_NEGOCIO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_NEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_NEGOCIO: Button(350)">
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
<node FOLDED="true" TEXT="CD_NEGOCIO: Button(40)">
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
<node TEXT="LOV_SOLICAUTORIZ_DEPTO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Buscar aprovadores de necessidades">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_SOLICAUTORIZ_DEPTO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NM_USUARIO: Button(350)">
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
<node FOLDED="true" TEXT="CD_USUARIO: Button(40)">
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
<node TEXT="LOV_NEGOCIORATEIO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_NEGOCIORATEIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_NEGOCIO: Button(350)">
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
<node FOLDED="true" TEXT="CD_NEGOCIO: Button(40)">
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
<node TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Código Movimentação por Negócio">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PARMOVIMENTNEGOCIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Button(333)">
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
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Button(67)">
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
<node TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção do Tipo de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_TIPOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_TIPOCOMPRA: Button(200)">
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
<node FOLDED="true" TEXT="CD_TIPOCOMPRA: Button(35)">
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
<node TEXT="LOV_MOVIMENTACAO1">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_MOVIMENTACAO1">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Button(549)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Ds_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Button(54)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Cd_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_MOVIMENTACAO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_MOVIMENTACAO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Button(549)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Ds_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Button(54)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Cd_Movimentacao">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_ITEMCOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Solicitação de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_ITEM: Button(549)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Ds_Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_ITEM: Button(81)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Cd_Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Nr_Itemcompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_LOTECOMPRA: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Nr_Lotecompra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="ICRGGQ_0: Button(144)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Icrggq_0">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_GRUPOCC">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Centro de Custos informados">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_GRUPOCC">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NR_REGISTRO: Button(54)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Registro">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_CENTROCUSTO: Button(1000)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Centrocusto">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="PROFILE">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Programas Disponíveis">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="PROFILE">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_PROGRAMA: Button(250)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="ICRGGQ_0: Button(198)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
</node>
</node>
<node TEXT="LOV_EMPRESA">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Empresas">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(35)">
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
<node FOLDED="true" TEXT="NM_EMPRESA: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Descrição Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_EMPRESA2">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Empresas">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_EMPRESA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(35)">
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
<node FOLDED="true" TEXT="NM_EMPRESA: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Descrição Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_COMPRAS">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Solicitações em aberto">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_COMPRAS">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_ITEMCOMPRA: Button(49)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Solicitação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="QT_PREVISTA: Button(53)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Qtde Prev.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_LOTECOMPRA: Button(24)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Lote">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_SOLICITANTE: Button(48)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_SOLICITANTE: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_AUTORIZADOR: Button(55)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_AUTORIZADOR: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="DT_SOLICITACAO: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Data de Solicitação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_ITEM">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Itens">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEM">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_ITEM: Button(227)">
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
<node FOLDED="true" TEXT="CD_ITEM: Button(45)">
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
<node FOLDED="true" TEXT="ICRGGQ_0: Button(114)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Tipo do Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(36)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_SOLICAUTORIZ">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NM_USUARIO: Button(350)">
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
<node FOLDED="true" TEXT="CD_USUARIO: Button(40)">
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
<node TEXT="LOV_AUTORIZADOR">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Autorizadores por Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_AUTORIZADOR">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="NM_USUARIO: Button(333)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Nome">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_USUARIO: Button(67)">
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
<node TEXT="LOV_PARMOVIMENT">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Código Movimentação por Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PARMOVIMENT">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Button(333)">
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
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Button(67)">
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
<node TEXT="LOV_PARMOVIMENTVERSAO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Código Movimentação por Centro de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_PARMOVIMENTVERSAO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Button(333)">
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
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Button(67)">
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
<node TEXT="LOV_CENTROCUSTO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Centros de Custo">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_CENTROCUSTO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_CENTROCUSTO: Button(333)">
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
<node FOLDED="true" TEXT="CD_CENTROCUSTO: Button(67)">
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
<node TEXT="LOV_CENTROCUSTOUSUARIO">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Centros de Custo Usuário">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_CENTROCUSTOUSUARIO">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_CENTROCUSTO: Button(333)">
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
<node FOLDED="true" TEXT="CD_CENTROCUSTO: Button(67)">
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
<node TEXT="LOV_DEPARTAMENTOCOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Selecione o Departamento">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_DEPARTAMENTOCOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_DEPARTAMENTO: Button(675)">
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
<node FOLDED="true" TEXT="CD_DEPARTAMENTO: Button(45)">
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
<node TEXT="LOV_LOTECOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Lotes de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_LOTECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(30)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NR_LOTECOMPRA: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Lote de Compra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_SOLICITACAO: Button(90)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Data de Solicitação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_SOLICITANTE: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Solicitante">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_SOLICITANTE: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
<node FOLDED="true" TEXT="CD_AUTORIZADOR: Button(40)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Autorizador">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_AUTORIZADOR: Button(170)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
</node>
</node>
</node>
</node>
<node TEXT="LOV_CONTAORC">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Selecione uma Conta Orçamentária..">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_CONTAORC">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="CD_CONTAORCAMENTO: Button(85)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Cod. Cta Orc.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_CONTAORCAMENTO: Button(250)">
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
<node FOLDED="true" TEXT="CD_CONTACONTABIL: Button(85)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Cod. Cta Cont.">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="NM_CONTACONTABIL: Button(250)">
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
</node>
</node>
<node TEXT="LOV_ITEMPARMOV">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMPARMOV">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_MOVIMENTACAO: Button(450)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Movimentação">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_MOVIMENTACAO: Button(80)">
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
<node TEXT="LOV_ANOSAFRA">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Ano Safra">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ANOSAFRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_ANOSAFRA: Button(200)">
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
<node FOLDED="true" TEXT="NR_SEQUENCIAL: Button(80)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Nr. Sequencial">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_ANOSAFRA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Ano Safra">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_INISAFRA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Data Início">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="DT_FIMSAFRA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Data Final">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
<node FOLDED="true" TEXT="CD_EMPRESA: Button(60)">
<icon BUILTIN="Mapping.unmapped"/>
<node TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Empresa">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
</node>
</node>
</node>
<node TEXT="LOV_ITEMPRECOMPRA">
<icon BUILTIN="Descriptor.enum"/>
<node FOLDED="true" TEXT="@">
<node TEXT="title">
<icon BUILTIN="element"/>
<node TEXT="Seleção de Item">
<icon BUILTIN="tag_green"/>
</node>
</node>
<node TEXT="RecordGroupName">
<icon BUILTIN="element"/>
<node TEXT="LOV_ITEMPRECOMPRA">
<icon BUILTIN="tag_green"/>
</node>
</node>
</node>
<node TEXT="atributos">
<icon BUILTIN="Descriptor.grouping"/>
<node FOLDED="true" TEXT="DS_ITEM: Button(600)">
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
<node FOLDED="true" TEXT="CD_ITEM: Button(72)">
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
</node>
</map>