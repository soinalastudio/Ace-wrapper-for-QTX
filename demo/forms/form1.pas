unit form1;

interface

uses
  qtx.sysutils,
  qtx.classes,
  qtx.dom.types,
  qtx.dom.events,
  qtx.dom.graphics,
  qtx.dom.widgets,
  qtx.dom.theme,
  qtx.dom.application,
  qtx.dom.forms,
  tor.ace.wrapper,
  qtx.delegates,
  qtx.promises,
  qtx.dom.events.mouse,
  qtx.dom.events.pointer,
  qtx.dom.events.keyboard,
  qtx.dom.events.touch,
qtx.dom.stylesheet,
qtx.dom.control.contentbox,
qtx.dom.control.label,
qtx.dom.control.button,
qtx.time,
qtx.dom.option,
qtx.dom.datalist,
qtx.dom.control.common,
qtx.dom.control.combobox;

type

  Tform1 = class(TQTXForm)
  {$I "intf::form1"}
  protected
    procedure InitializeObject; override;
    procedure HandleDelegate1(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
    procedure FinalizeObject; override;
    procedure StyleObject; override;
  public

  end;

implementation

procedure Tform1.InitializeObject;
begin
  inherited;
  {$I "impl::form1"}

  WhenReady(procedure(widget: TQTXWidget)
  begin
    ComboBox1.Add('atAmbiance', '0');
    ComboBox1.Add('atChaos', '1');
    ComboBox1.Add('atChrome', '2');
    ComboBox1.Add('atCloud9Day', '3');
    ComboBox1.Add('atCloud9Night', '4');
    ComboBox1.Add('atCloud9NightLowColor', '5');
    ComboBox1.Add('atClouds', '6');
    ComboBox1.Add('atCloudsMidnight', '7');
    ComboBox1.Add('atCobalt', '8');
    ComboBox1.Add('atCrimsonEditor', '9');
    ComboBox1.Add('atDawn', '10');
    ComboBox1.Add('atDracula', '11');
    ComboBox1.Add('atDreamweaver', '12');
    ComboBox1.Add('atEclipse', '13');
    ComboBox1.Add('atGithub', '14');
    ComboBox1.Add('atGob', '15');
    ComboBox1.Add('atGruvbox', '16');
    ComboBox1.Add('atGruvboxDarkHard', '17');
    ComboBox1.Add('atGruvboxLightHard', '18');
    ComboBox1.Add('atIdleFingers', '19');
    ComboBox1.Add('atIplastic', '20');
    ComboBox1.Add('atKatzenmilch', '21');
    ComboBox1.Add('atKrTheme', '22');
    ComboBox1.Add('atKuroir', '23');
    ComboBox1.Add('atMerbivore', '24');
    ComboBox1.Add('atMerbivoreSoft', '25');
    ComboBox1.Add('atMonoIndustrial', '26');
    ComboBox1.Add('atMonokai', '27');
    ComboBox1.Add('atNordDark', '28');
    ComboBox1.Add('atPastelOnDark', '29');
    ComboBox1.Add('atSolarizedDark', '30');
    ComboBox1.Add('atSolairzedLight', '31');
    ComboBox1.Add('atSqlserver', '32');
    ComboBox1.Add('atTerminal', '33');
    ComboBox1.Add('atTextmate', '34');
    ComboBox1.Add('atTomorrow', '35');
    ComboBox1.Add('atTomorrowNight', '36');
    ComboBox1.Add('atTomorrowNightBlue', '37');
    ComboBox1.Add('atTomorrowNightBright', '38');
    ComboBox1.Add('atTomorrowNightEighties', '39');
    ComboBox1.Add('atTwilight', '40');
    ComboBox1.Add('atVibrantInk', '41');
    ComboBox1.Add('atXcode', '42');

    ComboBox1.Handle.addEventListener('change', procedure()
    begin
      var theme := TEnumAceTheme(StrToInt(ComboBox1.Handle.value));
      AceEditor1.setTheme(TEnumAceThemeStr[theme]);
    end);

    ComboBox2.Add('amAbap', '0');
    ComboBox2.Add('amAbc', '1');
    ComboBox2.Add('amActionscript', '2');
    ComboBox2.Add('amAda', '3');
    ComboBox2.Add('amAlda', '4');
    ComboBox2.Add('amApacheConf', '5');
    ComboBox2.Add('amApex', '6');
    ComboBox2.Add('amApplescript', '7');
    ComboBox2.Add('amAql', '8');
    ComboBox2.Add('amAsciidoc', '9');
    ComboBox2.Add('amAsl', '10');
    ComboBox2.Add('amAssemblyX86', '11');
    ComboBox2.Add('amAutohotkey', '12');
    ComboBox2.Add('amBatchfile', '13');
    ComboBox2.Add('amBibtex', '14');
    ComboBox2.Add('amC9search', '15');
    ComboBox2.Add('amCirru', '16');
    ComboBox2.Add('amClojure', '17');
    ComboBox2.Add('amCobol', '18');
    ComboBox2.Add('amCoffee', '19');
    ComboBox2.Add('amColdfusion', '20');
    ComboBox2.Add('amCrystal', '21');
    ComboBox2.Add('amCsharp', '22');
    ComboBox2.Add('amCsoundDocument', '23');
    ComboBox2.Add('amCsoundOrchestra', '24');
    ComboBox2.Add('amCsoundScore', '25');
    ComboBox2.Add('amCsp', '26');
    ComboBox2.Add('amCss', '27');
    ComboBox2.Add('amCurly', '28');
    ComboBox2.Add('amC_Cpp', '29');
    ComboBox2.Add('amD', '30');
    ComboBox2.Add('amDart', '31');
    ComboBox2.Add('amDiff', '32');
    ComboBox2.Add('amDjango', '33');
    ComboBox2.Add('amDockerfile', '34');
    ComboBox2.Add('amDot', '35');
    ComboBox2.Add('amDrools', '36');
    ComboBox2.Add('amEdifact', '37');
    ComboBox2.Add('amEiffel', '38');
    ComboBox2.Add('amEjs', '39');
    ComboBox2.Add('amElixir', '40');
    ComboBox2.Add('amElm', '41');
    ComboBox2.Add('amErlang', '42');
    ComboBox2.Add('amForth', '43');
    ComboBox2.Add('amFortran', '44');
    ComboBox2.Add('amFsharp', '45');
    ComboBox2.Add('amFsl', '46');
    ComboBox2.Add('amFtl', '47');
    ComboBox2.Add('amGcode', '48');
    ComboBox2.Add('amGherkin', '49');
    ComboBox2.Add('amGitignore', '50');
    ComboBox2.Add('amGlsl', '51');
    ComboBox2.Add('amGobstones', '52');
    ComboBox2.Add('amGolang', '53');
    ComboBox2.Add('amGraphqlschema', '54');
    ComboBox2.Add('amGroovy', '55');
    ComboBox2.Add('amHaml', '56');
    ComboBox2.Add('amHandlebars', '57');
    ComboBox2.Add('amHaskell', '58');
    ComboBox2.Add('amHaskellCabal', '59');
    ComboBox2.Add('amHaxe', '60');
    ComboBox2.Add('amHjson', '61');
    ComboBox2.Add('amHtml', '62');
    ComboBox2.Add('amHtmlElixir', '63');
    ComboBox2.Add('amHtmlRuby', '64');
    ComboBox2.Add('amIni', '65');
    ComboBox2.Add('amIo', '66');
    ComboBox2.Add('amIon', '67');
    ComboBox2.Add('amJack', '68');
    ComboBox2.Add('amJade', '69');
    ComboBox2.Add('amJava', '70');
    ComboBox2.Add('amJavascript', '71');
    ComboBox2.Add('amJexl', '72');
    ComboBox2.Add('amJson', '73');
    ComboBox2.Add('amJson5', '74');
    ComboBox2.Add('amJsoniq', '75');
    ComboBox2.Add('amJsp', '76');
    ComboBox2.Add('amJssm', '77');
    ComboBox2.Add('amJsx', '78');
    ComboBox2.Add('amJulia', '79');
    ComboBox2.Add('amKotlin', '80');
    ComboBox2.Add('amLatex', '81');
    ComboBox2.Add('amLatte', '82');
    ComboBox2.Add('amLess', '83');
    ComboBox2.Add('amLiquid', '84');
    ComboBox2.Add('amLisp', '85');
    ComboBox2.Add('amLivescript', '86');
    ComboBox2.Add('amLogiql', '87');
    ComboBox2.Add('amLogtalk', '88');
    ComboBox2.Add('amLsl', '89');
    ComboBox2.Add('amLua', '90');
    ComboBox2.Add('amLuapage', '91');
    ComboBox2.Add('amLucene', '92');
    ComboBox2.Add('amMakefile', '93');
    ComboBox2.Add('amMarkdown', '94');
    ComboBox2.Add('amMask', '95');
    ComboBox2.Add('amMatlab', '96');
    ComboBox2.Add('amMaze', '97');
    ComboBox2.Add('amMediawiki', '98');
    ComboBox2.Add('amMel', '99');
    ComboBox2.Add('amMips', '100');
    ComboBox2.Add('amMixal', '101');
    ComboBox2.Add('amMushcode', '102');
    ComboBox2.Add('amMysql', '103');
    ComboBox2.Add('amNginx', '104');
    ComboBox2.Add('amNim', '105');
    ComboBox2.Add('amNix', '106');
    ComboBox2.Add('amNsis', '107');
    ComboBox2.Add('amNunjucks', '108');
    ComboBox2.Add('amObjectivec', '109');
    ComboBox2.Add('amOcaml', '110');
    ComboBox2.Add('amPartiql', '111');
    ComboBox2.Add('amPascal', '112');
    ComboBox2.Add('amPerl', '113');
    ComboBox2.Add('amPgsql', '114');
    ComboBox2.Add('amPhp', '115');
    ComboBox2.Add('amPhpLaravelBlade', '116');
    ComboBox2.Add('amPig', '117');
    ComboBox2.Add('amPlainText', '118');
    ComboBox2.Add('amPlsql', '119');
    ComboBox2.Add('amPowershell', '120');
    ComboBox2.Add('amPraat', '121');
    ComboBox2.Add('amPrisma', '122');
    ComboBox2.Add('amProlog', '123');
    ComboBox2.Add('amProperties', '124');
    ComboBox2.Add('amProtobuf', '125');
    ComboBox2.Add('amPuppet', '126');
    ComboBox2.Add('amPython', '127');
    ComboBox2.Add('amQml', '128');
    ComboBox2.Add('amR', '129');
    ComboBox2.Add('amRaku', '130');
    ComboBox2.Add('amRazor', '131');
    ComboBox2.Add('amRdoc', '132');
    ComboBox2.Add('amRed', '133');
    ComboBox2.Add('amRedshift', '134');
    ComboBox2.Add('amRhtml', '135');
    ComboBox2.Add('amRobot', '136');
    ComboBox2.Add('amRst', '137');
    ComboBox2.Add('amRuby', '138');
    ComboBox2.Add('amRust', '139');
    ComboBox2.Add('amSac', '140');
    ComboBox2.Add('amSass', '141');
    ComboBox2.Add('amScad', '142');
    ComboBox2.Add('amScala', '143');
    ComboBox2.Add('amScheme', '144');
    ComboBox2.Add('amScrypt', '145');
    ComboBox2.Add('amScss', '146');
    ComboBox2.Add('amSh', '147');
    ComboBox2.Add('amSjs', '148');
    ComboBox2.Add('amSlim', '149');
    ComboBox2.Add('amSmarty', '150');
    ComboBox2.Add('amSmithy', '151');
    ComboBox2.Add('amSnippets', '152');
    ComboBox2.Add('amSoyTemplate', '153');
    ComboBox2.Add('amSpace', '154');
    ComboBox2.Add('amSparql', '155');
    ComboBox2.Add('amSql', '156');
    ComboBox2.Add('amSqlserver', '157');
    ComboBox2.Add('amStylus', '158');
    ComboBox2.Add('amSvg', '159');
    ComboBox2.Add('amSwift', '160');
    ComboBox2.Add('amTcl', '161');
    ComboBox2.Add('amTerraform', '162');
    ComboBox2.Add('amTex', '163');
    ComboBox2.Add('amText', '164');
    ComboBox2.Add('amTextile', '165');
    ComboBox2.Add('amToml', '166');
    ComboBox2.Add('amTsx', '167');
    ComboBox2.Add('amTurtle', '168');
    ComboBox2.Add('amTwig', '169');
    ComboBox2.Add('amTypescript', '170');
    ComboBox2.Add('amVala', '171');
    ComboBox2.Add('amVbscript', '172');
    ComboBox2.Add('amVelocity', '173');
    ComboBox2.Add('amVerilog', '174');
    ComboBox2.Add('amVhdl', '175');
    ComboBox2.Add('amVisualforce', '176');
    ComboBox2.Add('amWollok', '177');
    ComboBox2.Add('amXml', '178');
    ComboBox2.Add('amXquery', '179');
    ComboBox2.Add('amYaml', '180');
    ComboBox2.Add('amZeek', '181');

    ComboBox2.Handle.addEventListener('change', procedure()
    begin
      var mode := TEnumAceMode(StrToInt(ComboBox2.Handle.value));
      AceEditor1.setMode(mode);
    end);

  end);

end;

procedure Tform1.HandleDelegate1(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
begin
  AceEditor1.duplicateSelection();
end;

procedure Tform1.FinalizeObject;
begin
  inherited;
end;

procedure Tform1.StyleObject;
begin
  inherited;
  PositionMode := TQTXWidgetPositionMode.cpInitial;
  DisplayMode := TQTXWidgetDisplayMode.cdBlock;
end;


end.
