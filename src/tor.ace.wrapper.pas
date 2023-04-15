/*
MIT License

Copyright (c) 2023, Toky Olivier RAZANAKOTONARIVO

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

unit tor.ace.wrapper;

interface

uses
  qtx.sysutils,
  qtx.classes,
  qtx.delegates,
  qtx.dom.types,
  qtx.dom.widgets,
  qtx.promises,
  qtx.dom.events,
  qtx.delegates,
  qtx.dom.events.mouse,
  qtx.dom.events.pointer,
  qtx.dom.events.keyboard,
  qtx.dom.events.touch;

const
  AceWrapperVersion = '0.3';

  {$R 'src-min-noconflict/ace.js'}

type
  TAceStdCB       = procedure ();
  TAceOnPasteCB   = procedure (text: String);
  TAceStdEventCB  = procedure (e: Variant);
  TAceOnReloadTokenizerCB = procedure (e: Variant);

  TAceRange = class;
  TAceDocument = class;
  TAceSelection = class;
  TAceUndoManager = class;
  TAceAnchor = class;

  TAceOptionsRenderer = class
  protected
    fOpts: Variant;
    function getProp(prop: String): Variant;
    procedure setProp(prop: String; value: Variant);
  public
    constructor Create(opts: Variant = null);
    function RenderOptions(): Variant; virtual;
  end;

  TAceUndoManager = class external "AceUndoManager"
    procedure execute(options: Variant);
    function hasRedo(): Boolean;
    function hasUndo(): Boolean;
    procedure redo(dontSelect: Boolean);
    procedure reset();
    procedure undo(dontSelect: Boolean);

    constructor Create();
  end;

  TAceDocument = class external "AceDocument"
    procedure &on(event: String; CB: TAceStdEventCB);

    procedure applyDeltas (deltas: Variant);
    function createAnchor(row, column: Integer): TAceAnchor;
    function getAllLines(): array of String;
    function getLength: Integer;
    function getLine(row: Integer): String;
    function getLines(firstRow, lastRow: Integer): array of String;
    function getNewLineCharacter(): String;
    function getNewLineMode(): String;
    function getTextRange(range: TAceRange): String;
    function getValue(): String;
    function indexToPosition(index, startRow: Integer): Variant;
    function insert(position: Variant; text: String): Variant;
    function insertInLine(position: Variant; text: String): Variant;
    function insertLines(row: integer; lines: array of string): Variant;
    function insertNewLine(position: Variant): Variant;
    function isNewLine(text: String): Boolean;
    function positionToIndex(pos: Variant; startRow: Integer): Integer;
    procedure remove(range: TAceRange);
    procedure removeInLine(row, startColumn, endColumn: Integer);
    procedure removeLines(firstRow, lastRow: Integer);
    procedure removeNewLine(row: Integer);
    procedure replace(range: TAceRange; text: String);
    procedure revertDeltas(deltas: Variant);
    procedure setNewLineMode(newLineMode: String);
    procedure setValue(text: String);

    constructor Create(text: String); overload;
    constructor Create(text: array of String); overload;
  end;

  TAceEditSession = class external "AceEditSession"
    procedure &on(event: String; CB: Variant);
    procedure addDynamicMarker(marker: Variant; inFront: Boolean);
    procedure addGutterDecoration(row: Integer; className: String);
    procedure addMarker(range: TAceRange; clazz: String; &type: Variant; inFront: Boolean);
    procedure clearAnnotations();
    procedure clearBreakpoint(row: Integer);
    procedure clearBreakpoints();
    function documentToScreenColumn(docRow, docColumn: Integer): Variant;
    function documentToScreenPosition(docRow, docColumn: Integer): Variant;
    function documentToScreenRow(docRow, docColumn: Integer): Variant;
    procedure duplicateLines(firstRow, lastRow: Integer);
    function getAnnotations(): Variant;
    function getAWordRange(): TAceRange;
    function getBreakpoints(): Array of Integer;
    function getDocument(): TAceDocument;
    function getDocumentLastRowColumn(docRow, docColumn: Integer): Integer;
    function getDocumentLastRowColumnPosition(docRow, docColumn: Integer): Integer;
    function getLength(): Integer;
    function getLine(row: Integer): String;
    function getLines(): Array of String;
    function getMarkers(): Array of String;
    function getMode(): Variant;
    function getNewLineMode(): String;
    function getOverwrite(): Boolean;
    function getRowLength(row: Integer): Integer;
    function getRowSplitData(row: Integer): String;
    function getScreenLastRowColumn(screenRow: Integer): Integer;
    function getScreenLength(): Integer;
    function getScreenTabSize(screenColumn: Integer): Integer;
    function getScreenWidth(): Integer;
    function getScrollLeft(): Integer;
    function getScrollTop(): Integer;
    function getSelection(): TAceSelection;
    function getState(row: Integer): Variant;
    function getTabSize(): Integer;
    function getTabString(): String;
    function getTextRange(range: TAceRange): String;
    function getTokenAt(row, column: Integer): Variant;
    function getTokens(row: Integer): Array of Variant;
    function getUndoManager(): TAceUndoManager;
    function getUseSoftTabs(): Boolean;
    function getUseWorker(): Boolean;
    function getUseWrapMode(): Boolean;
    function getValue(): String;
    function getWordRange(row, column: Integer): TAceRange;
    function getWrapLimit(): Integer;
    function getWrapLimitRange(): Variant;
    procedure highlight();
    procedure highlightLines();
    procedure indentRows(startRow, endRow: Integer; identString: String);
    function insert(position: Variant; text: String): Variant;
    function isTabStop(): Boolean;
    function moveLinesDown(firstRow, lastRow: Integer): Integer;
    function moveLinesUp(firstRow, lastRow: Integer): Integer;
    function moveText(fromRange: TAceRange; toPosition: Variant): TAceRange;
    procedure onChange(CB: TAceStdCB);
    procedure onChangeFold(CB: TAceStdCB);
    procedure onReloadTokenizer(CB: TAceOnReloadTokenizerCB);
    procedure outdentRows(range: TAceRange);
    procedure redo();
    procedure redoChanges(deltas: Array of Variant; dontSelect: boolean);
    procedure remove(range: TAceRange);
    procedure removeGutterDecoration(row: Integer; className: String);
    procedure removeMarker(markerId: Integer);
    procedure replace(range: TAceRange; text: String);
    procedure reset();
    procedure resetCaches();
    function screenToDocumentColumn(screenRow, screenColumn: Integer): Integer;
    function screenToDocumentPosition(screenRow, screenColumn: Integer): Variant;
    function screenToDocumentRow(screenRow, screenColumn: Integer): Integer;
    procedure setAnnotations(annotations: array of Variant);
    procedure setBreakpoint(row: Integer; className: String);
    procedure setBreakpoints(rows: Array of Integer);
    procedure setDocument(doc: TAceDocument);
    procedure setMode(mode: Variant);
    procedure setNewLineMode(newLineMode: String);
    procedure setOverwrite(overwrite: Boolean);
    procedure setScrollLeft(scrollLeft: Integer);
    procedure setScrollTop(scrollTop: Integer);
    procedure setTabSize(tabSize: Integer);
    procedure setUndoManager(undoManager: TAceUndoManager);
    procedure setUndoSelect(enable: Boolean);
    procedure setUseSoftTabs(useSoftTabs: Boolean);
    procedure setUseWorker(useWorker: Boolean);
    procedure setUseWrapMode(useWrapMode: Boolean);
    procedure setValue(text: String);
    procedure setWrapLimitRange(min, max: integer);
    procedure toggleOverwrite();
    function toString(): String;
    procedure undo();
    procedure undoChanges(deltas: Array of Variant; dontSelect: Boolean);
    constructor Create(text: String; mode: Variant);
  end;

  TAceAnchor = class external "AceAnchor"
    procedure &on(event: String; CB: TAceStdEventCB);
    procedure detach();
    function getDocument(): TAceDocument;
    function getPosition(): Variant;
    procedure onChange(CB: TAceStdCB);
    procedure setPosition(row, column: Integer; noClip: Boolean);

    constructor Create(doc: TAceDocument; row, column: Integer);
  end;

  TAceSelection = class external "AceSelection"
    procedure addRange(range: TAceRange; blockChangeEvents: Boolean);
    procedure clearSelection();
    procedure detach();
    function fromOrientedRange(range: TAceRange): Variant;
    function getAllRanges(): Array of TAceRange;
    function getCursor(): Integer;
    function getLineRange(row: Integer): TAceRange;
    function getRange(): TAceRange;
    function getSelectionAnchor(): Variant;
    function getSelectionLead(): Variant;
    function getWordRange(row, column: Integer): TAceRange;
    function isBackwards(): Boolean;
    function isEmpty(): Boolean;
    function isMultiLine(): Boolean;
    procedure mergeOverlappingRanges();
    procedure moveCursorBy(rows, chars: Integer);
    procedure moveCursorDown();
    procedure moveCursorFileEnd();
    procedure moveCursorFileStart();
    procedure moveCursorLeft();
    procedure moveCursorLineEnd();
    procedure moveCursorLineStart();
    procedure moveCursorLongWordLeft();
    procedure moveCursorLongWordRight();
    procedure moveCursorRight();
    procedure moveCursorShortWordLeft();
    procedure moveCursorShortWordRight();
    procedure moveCursorTo(row, column: Integer; keepDesiredColumn: Boolean);
    procedure moveCursorToPosition(position: Variant);
    procedure moveCursorToScreen(row, column: Integer; keepDesiredColumn: Boolean);
    procedure moveCursorUp();
    procedure moveCursorWordLeft();
    procedure moveCursorWordRight();
    procedure rectangularRangeBlock(screenCursor: Variant; screenAnchor: TAceAnchor; includeEmptyLines: Boolean);
    procedure selectAll();
    procedure selectAWord();
    procedure selectDown();
    procedure selectFileEnd();
    procedure selectFileStart();
    procedure selectLeft();
    procedure selectLine();
    procedure selectLineEnd();
    procedure selectLineStart();
    procedure selectRight();
    procedure selectTo(row, column: integer);
    procedure selectToPosition(pos: Variant);
    procedure selectUp();
    procedure selectWord();
    procedure selectWordLeft();
    procedure selectWordRight();
    procedure setSelectionAnchor(row, column: integer);
    procedure setSelectionRange(range: TAceRange; reverse: Boolean);
    procedure shiftSelection(columns: Integer);
    procedure splitIntoLines();
    procedure substractPoint(pos: TAceRange);
    procedure toggleBlockSelection();
    procedure toOrientedRange();
    procedure toSingleRange();

    constructor Create(session: TAceEditSession);
  end;

  TAceVisualRenderer = class external "AceVisualRenderer"
    procedure _loadTheme();
    procedure adjustWrapLimit();
    procedure alignCursor();
    procedure animateScrolling();
    procedure destroy();
    function getAnimatedScroll(): Boolean;
    function getContainerElement(): JElement;
    function getDisplayIndentGuides(): Variant;
    function getFadeFoldWidgets(): Variant;
    function getFirstFullyVisibleRow(): Integer;
    function getFirstVisibleRow(): Integer;
    function getHighlightGutterLine(): Variant;
    function getHScrollBarAlwaysVisible(): Boolean;
    function getLastFullyVisibleRow(): Integer;
    function getLastVisibleRow(): Integer;
    function getMouseEventTarget(): JElement;
    function getPrintMarginColumn(): Boolean;
    function getScrollBottomRow(): Integer;
    function getScrollLeft(): Integer;
    function getScrollTop(): Integer;
    function getScrollTopRow(): Integer;
    function getShowGutter(): Boolean;
    function getShowInvisibles(): Boolean;
    function getShowPrintMargin(): Boolean;
    function getTextAreaContainer(): JElement;
    function getTheme(): String;
    procedure hideComposition();
    procedure hideCursor();
    function isScrollableBy(deltaX, deltaY: Integer): Boolean;
    procedure onResize(force: Boolean; gutterWidth, width, height: Integer);
    function pixelToScreenCoordinates(): Variant;
    function screenToTextCoordinates(): Variant;
    procedure scrollBy(deltaX, deltaY: Integer);
    procedure scrollCursorIntoView(cursor, offset: Variant);
    procedure scrollSelectionIntoView();
    procedure scrollToLine(line: Integer; center, animate: Boolean; CB: TAceStdCB);
    procedure scrollToRow(row: Integer);
    procedure scrollToX(scrollLeft: Integer);
    procedure scrollToY(scrollTop: Integer);
    procedure setAnimatedScroll(shouldAnimate: Boolean);
    procedure setAnnotations(annotations: array of Variant);
    procedure setCompositionText(text: String);
    //procedure setDisplayIndentGuides();
    //procedure setFadeFoldWidgets();
    //procedure setHighlightGutterLine();
    procedure setHScrollBarAlwaysVisible(alwaysVisible: Boolean);
    procedure setPadding(padding: Integer);
    procedure setPrintMarginColumn(showPrintMargin: Boolean);
    procedure setSession(session: TAceEditSession);
    procedure setShowGutter(show: Boolean);
    procedure setShowInvisibles(showInvisibles: Boolean);
    procedure setShowPrintMargin(showPrintMargin: Boolean);
    procedure setStyle(style: String);
    procedure setTheme(theme: String);
    procedure showCursor();
    function textToScreenCoordinates(row, column: Integer): Variant;
    procedure unsetStyle(style: String);
    procedure updateBackMarkers();
    procedure updateBreakpoints(rows: Variant);
    procedure updateCharacterSize();
    procedure updateCursor();
    procedure updateFontSize();
    procedure updateFrontMarkers();
    procedure updateFull(force: Boolean);
    procedure updateLines(firstRow, lastRow: Integer);
    procedure updateText();
    procedure visualizeBlur();
    procedure visualizeFocus();

    constructor Create(container: JElement; theme: string);
  end;

  TAceRange = class external "AceRange"
    function clipRows(firstRow, lastRow: Integer): TAceRange;
    function clone(): TAceRange;
    function collapseRows(): TAceRange;
    function compare(row, column: Integer): Integer;
    function compareEnd(row, column: Integer): Integer;
    function compareInside(row, column: Integer): Integer;
    function comparePoint(p: TAceRange): Integer;
    function compareRange(range: TAceRange): Integer;
    function compareStart(row, column: Integer): Integer;
    function contains(row, column: Integer): Boolean;
    function containsRange(range: TAceRange): Boolean;
    function extend(row, column: integer): TAceRange;
    function fromPoints(start, &end: TAceRange): TAceRange;
    function inside(row, column: Integer): Boolean;
    function insideEnd(row, column: integer): boolean;
    function insideStart(row, column: integer): boolean;
    function intersects(range: TAceRange): boolean;
    function isEmpty(): Boolean;
    function isEnd(row, column: Integer): Boolean;
    function isEqual(range: TAceRange): Boolean;
    function isMultiLine(): Boolean;
    function isStart(): Boolean;
    procedure setEnd(row, column: Integer);
    procedure setStart(row, column: Integer);
    function toScreenRange(session: TAceEditSession): TAceRange;
    function toString(): String;

    constructor Create(startRow, startColumn, endRow, endColumn: Integer);
  end;

  TAceEditor = class external "AceEditor"
    procedure &on(event: String; CB: Variant); external "on";
    function addSelectionMarker(orientedRange: TAceRange): TAceRange;
    procedure alignCursors();
    procedure blockOutdent();
    procedure blur();
    procedure centerSelection();
    procedure clearSelection();
    procedure copyLinesDown();
    procedure copyLinesUp();
    procedure destroy();
    procedure duplicateSelection();
    procedure execCommand(command: String);
    procedure exitMultiSelectMode();
    procedure find(needle: String; options: Variant; animate: Boolean);
    function findAll(needle: String; options: Variant; keeps: Boolean): Integer;
    procedure findNext(options: Variant; animate: Boolean);
    procedure findPrevious(options: Variant; animate: Boolean);
    procedure focus();
    procedure forEachSelection(cmd, args: String);
    function getAnimatedScroll(): Boolean;
    function getBehavioursEnabled(): Boolean;
    function getCopyText(): String;
    function getCursorPosition(): Variant;
    function getCursorPositionScreen(): Integer;
    function getDisplayIndentGuides(): Variant;
    function getDragDelay(): Integer;
    function getFadeFoldWidgets(): Variant;
    function getFirstVisibleRow(): Integer;
    function getHighlightActiveLine(): Boolean;
    function getHighlightGutterLine(): Boolean;
    function getHighlightSelectedWord(): Boolean;
    function getKeyboardHandler(): String;
    function getLastSearchOptions(): Variant;
    function getLastVisibleRow(): Integer;
    function getNumberAt(row, column: Integer): integer;
    function getOverwrite(): boolean;
    function getPrintMarginColumn(): integer;
    function getReadOnly(): boolean;
    function getScrollSpeed(): Integer;
    function getSelection(): TAceSelection;
    function getSelectionRange(): TAceRange;
    function getSelectionStyle(): String;
    function getSession(): TAceEditSession;
    function getShowFoldWidgets(): Boolean;
    function getShowInvisibles(): Boolean;
    function getShowPrintMargin(): Boolean;
    function getTheme(): String;
    function getValue(): String;
    function getWrapBehavioursEnabled(): Boolean;
    procedure gotoLine(lineNumber, column: Integer; animate: Boolean);
    procedure gotoPageDown();
    procedure gotoPageUp();
    procedure indent();
    procedure insert(text: string);
    function isFocused(): Boolean;
    function isRowFullyVisible(): Boolean;
    function isRowVisible(): Boolean;
    procedure jumpToMatching(select: Variant);
    procedure modifyNumber(amount: Integer);
    procedure moveCursorTo(row, column: Integer);
    procedure moveCursorToPosition(pos: Variant);
    function moveLinesDown(): Integer;
    function moveLinesUp(): Integer;
    procedure moveText();
    procedure navigateDown(times: integer);
    procedure navigateFileEnd();
    procedure navigateFileStart();
    procedure navigateLeft();
    procedure navigateLineEnd();
    procedure navigateLineStart();
    procedure navigateRight();
    procedure navigateTo(row, column: integer);
    procedure navigateUp(times: integer);
    procedure navigateWordLeft();
    procedure navigateWordRight();
    procedure onBlur(CB: TAceStdCB);
    procedure onChangeAnnotation(CB: TAceStdCB);
    procedure onChangeBackMarker(CB: TAceStdCB);
    procedure onChangeBreakpoint(CB: TAceStdCB);
    procedure onChangeFold(CB: TAceStdCB);
    procedure onChangeFrontMarker(CB: TAceStdCB);
    procedure onChangeMode(CB: TAceStdCB);
    procedure onChangeWrapLimit(CB: TAceStdCB);
    procedure onChangeWrapMode(CB: TAceStdCB);
    procedure onCommandKey(CB: TAceStdCB);
    procedure onCompositionEnd(CB: TAceStdCB);
    procedure onCompositionStart(CB: TAceStdCB);
    procedure onCompositionUpdate(CB: TAceStdCB);
    procedure onCopy(CB: TAceStdCB);
    procedure onCursorChange(CB: TAceStdCB);
    procedure onCut(CB: TAceStdCB);
    procedure onDocumentChange(CB: TAceStdCB);
    procedure onFocus(CB: TAceStdCB);
    procedure onPaste(CB: TAceOnPasteCB);
    procedure onScrollLeftChange(CB: TAceStdCB);
    procedure onScrollTopChange(CB: TAceStdCB);
    procedure onSelectionChange(CB: TAceStdCB);
    procedure onTextInput(CB: TAceStdCB);
    procedure onTokenizerUpdate(CB: TAceStdCB);
    procedure redo();
    procedure remove(dir: String);
    procedure removeLines();
    procedure removeSelectionMarker(range: TAceRange);
    procedure removeToLineEnd();
    procedure removeToLineStart();
    procedure removeWordLeft();
    procedure removeWordRight();
    procedure replace(replacement: String; options: Variant);
    procedure replaceAll(replacement: String; options: Variant);
    procedure resize(force: Boolean);
    procedure revealRange();
    procedure scrollPageDown();
    procedure scrollPageUp();
    procedure scrollToLine(line: Integer; center, animate: Boolean; CB: TAceStdCB);
    procedure scrollToRow(row: Integer);
    procedure selectAll();
    procedure selectMore(dir: Integer; skip: Boolean);
    procedure selectMoreLines(dir: Integer; skip: Boolean);
    procedure selectPageDown();
    procedure selectPageUp();
    procedure setAnimatedScroll();
    procedure setBehavioursEnabled(enabled: Boolean);
    procedure setDisplayIndentGuides(identGuides: Variant);
    procedure setDragDelay(dragDelay: Integer);
    procedure setFadeFoldWidgets(fadeFoldWidget: Variant);
    procedure setFontSize(size: Integer);
    procedure setHighlightActiveLine(shouldHighlight: Boolean);
    procedure setHighlightGutterLine(gutterLine: Integer);
    procedure setHighlightSelectedWord(shoudHighlight: Boolean);
    procedure setKeyboardHandler(keyboardHandler: string); //Vim, windows, etc
    procedure setOverwrite(overwrite: Boolean);
    procedure setPrintMarginColumn(showPrintMargin: Boolean);
    procedure setReadOnly(readOnly: Boolean);
    procedure setScrollSpeed(speed: Boolean);
    procedure setSelectionStyle(style: String);
    procedure setSession(session: TAceEditSession);
    procedure setShowFoldWidgets(show: Boolean);
    procedure setShowInvisibles(showInvisibles: Boolean);
    procedure setShowPrintMargin(showPrintMargin: Boolean);
    procedure setStyle(style: String);
    procedure setTheme(theme: String);
    function setValue(val: String; curPos: Variant): String;
    procedure setWrapBehavioursEnabled(enabled: Boolean);
    procedure sortLines();
    procedure splitLine();
    procedure toggleCommentLines();
    procedure toggleOverwrite();
    procedure toLowerCase();
    procedure toUpperCase();
    procedure transposeLetters();
    procedure transposeSelections(dir: Integer);
    procedure undo();
    procedure unsetStyle(style: Variant);
    procedure updateSelectionMarkers();

    session: TAceEditSession;

    constructor Create(renderer: TAceVisualRenderer; session: TAceEditSession);
  end;

  TQTXAceEditor = class;

  TQTXAceEditorConstructorCB = procedure (widget: TQTXAceEditor);

  TEnumAceTheme = (
    atAmbiance,
    atChaos,
    atChrome,
    atCloud9Day,
    atCloud9Night,
    atCloud9NightLowColor,
    atClouds,
    atCloudsMidnight,
    atCobalt,
    atCrimsonEditor,
    atDawn,
    atDracula,
    atDreamweaver,
    atEclipse,
    atGithub,
    atGob,
    atGruvbox,
    atGruvboxDarkHard,
    atGruvboxLightHard,
    atIdleFingers,
    atIplastic,
    atKatzenmilch,
    atKrTheme,
    atKuroir,
    atMerbivore,
    atMerbivoreSoft,
    atMonoIndustrial,
    atMonokai,
    atNordDark,
    atPastelOnDark,
    atSolarizedDark,
    atSolairzedLight,
    atSqlserver,
    atTerminal,
    atTextmate,
    atTomorrow,
    atTomorrowNight,
    atTomorrowNightBlue,
    atTomorrowNightBright,
    atTomorrowNightEighties,
    atTwilight,
    atVibrantInk,
    atXcode
  );

  const TEnumAceThemeStr: array [TEnumAceTheme] of string = (
    'ace/theme/ambiance',
    'ace/theme/chaos',
    'ace/theme/chrom',
    'ace/theme/cloud9_day',
    'ace/theme/cloud9_night',
    'ace/theme/cloud9_night_low_color',
    'ace/theme/clouds',
    'ace/theme/clouds_midnight',
    'ace/theme/cobalt',
    'ace/theme/crimson_editor',
    'ace/theme/dawn',
    'ace/theme/dracula',
    'ace/theme/dreamweaver',
    'ace/theme/eclipse',
    'ace/theme/github',
    'ace/theme/gob',
    'ace/theme/gruvbox',
    'ace/theme/gruvbox_dark_hard',
    'ace/theme/gruvbox_light_hard',
    'ace/theme/idle_fingers',
    'ace/theme/iplastic',
    'ace/theme/katzenmilch',
    'ace/theme/kr_theme',
    'ace/theme/kuroir',
    'ace/theme/merbivore',
    'ace/theme/merbivore_soft',
    'ace/theme/mono_industrial',
    'ace/theme/monokai',
    'ace/theme/nord_dark',
    'ace/theme/pastel_on_dark',
    'ace/theme/solarized_dark',
    'ace/theme/solarized_light',
    'ace/theme/sql_server',
    'ace/theme/terminal',
    'ace/theme/textmate',
    'ace/theme/tomorrow',
    'ace/theme/tomorrow_night',
    'ace/theme/tomorrow_night_blue',
    'ace/theme/tomorrow_night_bright',
    'ace/theme/tomorrow_night_eighties',
    'ace/theme/twilight',
    'ace/theme/vibrant_ink',
    'ace/theme/xcode'
  );

  type
  TEnumAceMode = (
    amAbap,
    amAbc,
    amActionscript,
    amAda,
    amAlda,
    amApacheConf,
    amApex,
    amApplescript,
    amAql,
    amAsciidoc,
    amAsl,
    amAssemblyX86,
    amAutohotkey,
    amBatchfile,
    amBibtex,
    amC9search,
    amCirru,
    amClojure,
    amCobol,
    amCoffee,
    amColdfusion,
    amCrystal,
    amCsharp,
    amCsoundDocument,
    amCsoundOrchestra,
    amCsoundScore,
    amCsp,
    amCss,
    amCurly,
    amC_Cpp,
    amD,
    amDart,
    amDiff,
    amDjango,
    amDockerfile,
    amDot,
    amDrools,
    amEdifact,
    amEiffel,
    amEjs,
    amElixir,
    amElm,
    amErlang,
    amForth,
    amFortran,
    amFsharp,
    amFsl,
    amFtl,
    amGcode,
    amGherkin,
    amGitignore,
    amGlsl,
    amGobstones,
    amGolang,
    amGraphqlschema,
    amGroovy,
    amHaml,
    amHandlebars,
    amHaskell,
    amHaskellCabal,
    amHaxe,
    amHjson,
    amHtml,
    amHtmlElixir,
    amHtmlRuby,
    amIni,
    amIo,
    amIon,
    amJack,
    amJade,
    amJava,
    amJavascript,
    amJexl,
    amJson,
    amJson5,
    amJsoniq,
    amJsp,
    amJssm,
    amJsx,
    amJulia,
    amKotlin,
    amLatex,
    amLatte,
    amLess,
    amLiquid,
    amLisp,
    amLivescript,
    amLogiql,
    amLogtalk,
    amLsl,
    amLua,
    amLuapage,
    amLucene,
    amMakefile,
    amMarkdown,
    amMask,
    amMatlab,
    amMaze,
    amMediawiki,
    amMel,
    amMips,
    amMixal,
    amMushcode,
    amMysql,
    amNginx,
    amNim,
    amNix,
    amNsis,
    amNunjucks,
    amObjectivec,
    amOcaml,
    amPartiql,
    amPascal,
    amPerl,
    amPgsql,
    amPhp,
    amPhpLaravelBlade,
    amPig,
    amPlainText,
    amPlsql,
    amPowershell,
    amPraat,
    amPrisma,
    amProlog,
    amProperties,
    amProtobuf,
    amPuppet,
    amPython,
    amQml,
    amR,
    amRaku,
    amRazor,
    amRdoc,
    amRed,
    amRedshift,
    amRhtml,
    amRobot,
    amRst,
    amRuby,
    amRust,
    amSac,
    amSass,
    amScad,
    amScala,
    amScheme,
    amScrypt,
    amScss,
    amSh,
    amSjs,
    amSlim,
    amSmarty,
    amSmithy,
    amSnippets,
    amSoyTemplate,
    amSpace,
    amSparql,
    amSql,
    amSqlserver,
    amStylus,
    amSvg,
    amSwift,
    amTcl,
    amTerraform,
    amTex,
    amText,
    amTextile,
    amToml,
    amTsx,
    amTurtle,
    amTwig,
    amTypescript,
    amVala,
    amVbscript,
    amVelocity,
    amVerilog,
    amVhdl,
    amVisualforce,
    amWollok,
    amXml,
    amXquery,
    amYaml,
    amZeek
  );

  const TEnumAceModeStr: array [TEnumAceMode] of String = [
    'ace/mode/abap',
    'ace/mode/abc',
    'ace/mode/actionscript',
    'ace/mode/ada',
    'ace/mode/alda',
    'ace/mode/apache_conf',
    'ace/mode/apex',
    'ace/mode/applescript',
    'ace/mode/aql',
    'ace/mode/asciidoc',
    'ace/mode/asl',
    'ace/mode/assembly_x86',
    'ace/mode/autohotkey',
    'ace/mode/batchfile',
    'ace/mode/bibtex',
    'ace/mode/c9search',
    'ace/mode/cirru',
    'ace/mode/clojure',
    'ace/mode/cobol',
    'ace/mode/coffee',
    'ace/mode/coldfusion',
    'ace/mode/crystal',
    'ace/mode/csharp',
    'ace/mode/csound_document',
    'ace/mode/csound_orchestra',
    'ace/mode/csound_score',
    'ace/mode/csp',
    'ace/mode/css',
    'ace/mode/curly',
    'ace/mode/c_cpp',
    'ace/mode/d',
    'ace/mode/dart',
    'ace/mode/diff',
    'ace/mode/django',
    'ace/mode/dockerfile',
    'ace/mode/dot',
    'ace/mode/drools',
    'ace/mode/edifact',
    'ace/mode/eiffel',
    'ace/mode/ejs',
    'ace/mode/elixir',
    'ace/mode/elm',
    'ace/mode/erlang',
    'ace/mode/forth',
    'ace/mode/fortran',
    'ace/mode/fsharp',
    'ace/mode/fsl',
    'ace/mode/ftl',
    'ace/mode/gcode',
    'ace/mode/gherkin',
    'ace/mode/gitignore',
    'ace/mode/glsl',
    'ace/mode/gobstones',
    'ace/mode/golang',
    'ace/mode/graphqlschema',
    'ace/mode/groovy',
    'ace/mode/haml',
    'ace/mode/handlebars',
    'ace/mode/haskell',
    'ace/mode/haskell_cabal',
    'ace/mode/haxe',
    'ace/mode/hjson',
    'ace/mode/html',
    'ace/mode/html_elixir',
    'ace/mode/html_ruby',
    'ace/mode/ini',
    'ace/mode/io',
    'ace/mode/ion',
    'ace/mode/jack',
    'ace/mode/jade',
    'ace/mode/java',
    'ace/mode/javascript',
    'ace/mode/jexl',
    'ace/mode/json',
    'ace/mode/json5',
    'ace/mode/jsoniq',
    'ace/mode/jsp',
    'ace/mode/jssm',
    'ace/mode/jsx',
    'ace/mode/julia',
    'ace/mode/kotlin',
    'ace/mode/latex',
    'ace/mode/latte',
    'ace/mode/less',
    'ace/mode/liquid',
    'ace/mode/lisp',
    'ace/mode/livescript',
    'ace/mode/logiql',
    'ace/mode/logtalk',
    'ace/mode/lsl',
    'ace/mode/lua',
    'ace/mode/luapage',
    'ace/mode/lucene',
    'ace/mode/makefile',
    'ace/mode/markdown',
    'ace/mode/mask',
    'ace/mode/matlab',
    'ace/mode/maze',
    'ace/mode/mediawiki',
    'ace/mode/mel',
    'ace/mode/mips',
    'ace/mode/mixal',
    'ace/mode/mushcode',
    'ace/mode/mysql',
    'ace/mode/nginx',
    'ace/mode/nim',
    'ace/mode/nix',
    'ace/mode/nsis',
    'ace/mode/nunjucks',
    'ace/mode/objectivec',
    'ace/mode/ocaml',
    'ace/mode/partiql',
    'ace/mode/pascal',
    'ace/mode/perl',
    'ace/mode/pgsql',
    'ace/mode/php',
    'ace/mode/php_laravel_blade',
    'ace/mode/pig',
    'ace/mode/plain_text',
    'ace/mode/plsql',
    'ace/mode/powershell',
    'ace/mode/praat',
    'ace/mode/prisma',
    'ace/mode/prolog',
    'ace/mode/properties',
    'ace/mode/protobuf',
    'ace/mode/puppet',
    'ace/mode/python',
    'ace/mode/qml',
    'ace/mode/r',
    'ace/mode/raku',
    'ace/mode/razor',
    'ace/mode/rdoc',
    'ace/mode/red',
    'ace/mode/redshift',
    'ace/mode/rhtml',
    'ace/mode/robot',
    'ace/mode/rst',
    'ace/mode/ruby',
    'ace/mode/rust',
    'ace/mode/sac',
    'ace/mode/sass',
    'ace/mode/scad',
    'ace/mode/scala',
    'ace/mode/scheme',
    'ace/mode/scrypt',
    'ace/mode/scss',
    'ace/mode/sh',
    'ace/mode/sjs',
    'ace/mode/slim',
    'ace/mode/smarty',
    'ace/mode/smithy',
    'ace/mode/snippets',
    'ace/mode/soy_template',
    'ace/mode/space',
    'ace/mode/sparql',
    'ace/mode/sql',
    'ace/mode/sqlserver',
    'ace/mode/stylus',
    'ace/mode/svg',
    'ace/mode/swift',
    'ace/mode/tcl',
    'ace/mode/terraform',
    'ace/mode/tex',
    'ace/mode/text',
    'ace/mode/textile',
    'ace/mode/toml',
    'ace/mode/tsx',
    'ace/mode/turtle',
    'ace/mode/twig',
    'ace/mode/typescript',
    'ace/mode/vala',
    'ace/mode/vbscript',
    'ace/mode/velocity',
    'ace/mode/verilog',
    'ace/mode/vhdl',
    'ace/mode/visualforce',
    'ace/mode/wollok',
    'ace/mode/xml',
    'ace/mode/xquery',
    'ace/mode/yaml',
    'ace/mode/zeek'
  ];

  type
  [RegisterWidget(pidBrowser, ccGeneral)]
  [RegisterInfo('Ace Editor Wrapper', 'tor_ui_ace.png')]
  [DefaultName('AceEditor')]
  [PropertyDialog('Text', dlgText)]
  [BindDelegates([
    TQTXDOMMouseWheelDelegate,
    TQTXDOMMouseClickDelegate,
    TQTXDOMMouseDblClickDelegate,
    TQTXDOMMouseEnterDelegate,
    TQTXDOMMouseLeaveDelegate,
    TQTXDOMMouseDownDelegate,
    TQTXDOMMouseMoveDelegate,
    TQTXDOMMouseUpDelegate,
    TQTXDOMPointerLostCaptureDelegate,
    TQTXDOMPointerGotCaptureDelegate,
    TQTXDOMPointerUpDelegate,
    TQTXDOMPointerMoveDelegate,
    TQTXDOMPointerDownDelegate,
    TQTXDOMPointerLeaveDelegate,
    TQTXDOMPointerEnterDelegate,
    TQTXDOMKeyboardPressDelegate,
    TQTXDOMKeyboardUpDelegate,
    TQTXDOMKeyboardDownDelegate,
    TQTXDOMTouchStartDelegate,
    TQTXDOMTouchEndDelegate,
    TQTXDOMTouchMoveDelegate,
    TQTXDOMTouchCancelDelegate
    ])]
  TQTXAceEditor = class(TQTXWidget)
  private
    fDivEditor: TQTXWidget;
    fAceEditor: TAceEditor;
    fAceWrapperVersion: String;
    fTheme: TEnumAceTheme;
    fMode: TEnumAceMode;
  public
    property Editor: TAceEditor read fAceEditor;
    property Session: TAceEditSession read (fAceEditor.session);

    procedure WhenAceReady(CB: TStdCallBack); overload;
    procedure WhenAceReady(CB: TQTXWidgetConstructor); overload;

    procedure setMode(AMode: TEnumAceMode);

    function addSelectionMarker(orientedRange: TAceRange): TAceRange;
    procedure alignCursors();
    procedure blockOutdent();
    procedure blur();
    procedure centerSelection();
    procedure clearSelection();
    procedure copyLinesDown();
    procedure copyLinesUp();
    procedure duplicateSelection();
    procedure execCommand(command: String);
    procedure exitMultiSelectMode();
    procedure find(needle: String; options: Variant; animate: Boolean);
    function findAll(needle: String; options: Variant; keeps: Boolean): Integer;
    procedure findNext(options: Variant; animate: Boolean);
    procedure findPrevious(options: Variant; animate: Boolean);
    procedure focus();
    procedure forEachSelection(cmd, args: String);
    function getAnimatedScroll(): Boolean;
    function getBehavioursEnabled(): Boolean;
    function getCopyText(): String;
    function getCursorPosition(): Variant;
    function getCursorPositionScreen(): Integer;
    function getDisplayIndentGuides(): Variant;
    function getDragDelay(): Integer;
    function getFadeFoldWidgets(): Variant;
    function getFirstVisibleRow(): Integer;
    function getHighlightActiveLine(): Boolean;
    function getHighlightGutterLine(): Boolean;
    function getHighlightSelectedWord(): Boolean;
    function getKeyboardHandler(): String;
    function getLastSearchOptions(): Variant;
    function getLastVisibleRow(): Integer;
    function getNumberAt(row, column: Integer): integer;
    function getOverwrite(): boolean;
    function getPrintMarginColumn(): integer;
    function getReadOnly(): boolean;
    function getScrollSpeed(): Integer;
    function getSelection(): TAceSelection;
    function getSelectionRange(): TAceRange;
    function getSelectionStyle(): String;
    function getSession(): TAceEditSession;
    function getShowFoldWidgets(): Boolean;
    function getShowInvisibles(): Boolean;
    function getShowPrintMargin(): Boolean;
    function getTheme(): String;
    function getValue(): String;
    function getWrapBehavioursEnabled(): Boolean;
    procedure gotoLine(lineNumber, column: Integer; animate: Boolean);
    procedure gotoPageDown();
    procedure gotoPageUp();
    procedure indent();
    procedure insert(text: string);
    function isFocused(): Boolean;
    function isRowFullyVisible(): Boolean;
    function isRowVisible(): Boolean;
    procedure jumpToMatching(select: Variant);
    procedure modifyNumber(amount: Integer);
    procedure moveCursorTo(row, column: Integer);
    procedure moveCursorToPosition(pos: Variant);
    function moveLinesDown(): Integer;
    function moveLinesUp(): Integer;
    procedure moveText();
    procedure navigateDown(times: integer);
    procedure navigateFileEnd();
    procedure navigateFileStart();
    procedure navigateLeft();
    procedure navigateLineEnd();
    procedure navigateLineStart();
    procedure navigateRight();
    procedure navigateTo(row, column: integer);
    procedure navigateUp(times: integer);
    procedure navigateWordLeft();
    procedure navigateWordRight();
    procedure onBlur(CB: TAceStdCB);
    procedure onChangeAnnotation(CB: TAceStdCB);
    procedure onChangeBackMarker(CB: TAceStdCB);
    procedure onChangeBreakpoint(CB: TAceStdCB);
    procedure onChangeFold(CB: TAceStdCB);
    procedure onChangeFrontMarker(CB: TAceStdCB);
    procedure onChangeMode(CB: TAceStdCB);
    procedure onChangeWrapLimit(CB: TAceStdCB);
    procedure onChangeWrapMode(CB: TAceStdCB);
    procedure onCommandKey(CB: TAceStdCB);
    procedure onCompositionEnd(CB: TAceStdCB);
    procedure onCompositionStart(CB: TAceStdCB);
    procedure onCompositionUpdate(CB: TAceStdCB);
    procedure onCopy(CB: TAceStdCB);
    procedure onCursorChange(CB: TAceStdCB);
    procedure onCut(CB: TAceStdCB);
    procedure onDocumentChange(CB: TAceStdCB);
    procedure onFocus(CB: TAceStdCB);
    procedure onPaste(CB: TAceOnPasteCB);
    procedure onScrollLeftChange(CB: TAceStdCB);
    procedure onScrollTopChange(CB: TAceStdCB);
    procedure onSelectionChange(CB: TAceStdCB);
    procedure onTextInput(CB: TAceStdCB);
    procedure onTokenizerUpdate(CB: TAceStdCB);
    procedure redo();
    procedure remove(dir: String);
    procedure removeLines();
    procedure removeSelectionMarker(range: TAceRange);
    procedure removeToLineEnd();
    procedure removeToLineStart();
    procedure removeWordLeft();
    procedure removeWordRight();
    procedure replace(replacement: String; options: Variant);
    procedure replaceAll(replacement: String; options: Variant);
    procedure resizeEditor(force: Boolean);
    procedure revealRange();
    procedure scrollPageDown();
    procedure scrollPageUp();
    procedure scrollToLine(line: Integer; center, animate: Boolean; CB: TAceStdCB);
    procedure scrollToRow(row: Integer);
    procedure selectAll();
    procedure selectMore(dir: Integer; skip: Boolean);
    procedure selectMoreLines(dir: Integer; skip: Boolean);
    procedure selectPageDown();
    procedure selectPageUp();
    procedure setAnimatedScroll();
    procedure setBehavioursEnabled(enabled: Boolean);
    procedure setDisplayIndentGuides(identGuides: Variant);
    procedure setDragDelay(dragDelay: Integer);
    procedure setFadeFoldWidgets(fadeFoldWidget: Variant);
    procedure setFontSize(size: Integer);
    procedure setHighlightActiveLine(shouldHighlight: Boolean);
    procedure setHighlightGutterLine(gutterLine: Integer);
    procedure setHighlightSelectedWord(shoudHighlight: Boolean);
    procedure setKeyboardHandler(keyboardHandler: string); //Vim, windows, etc
    procedure setOverwrite(overwrite: Boolean);
    procedure setPrintMarginColumn(showPrintMargin: Boolean);
    procedure setReadOnly(readOnly: Boolean);
    procedure setScrollSpeed(speed: Boolean);
    procedure setSelectionStyle(style: String);
    procedure setSession(session: TAceEditSession);
    procedure setShowFoldWidgets(show: Boolean);
    procedure setShowInvisibles(showInvisibles: Boolean);
    procedure setShowPrintMargin(showPrintMargin: Boolean);
    procedure setStyle(style: String);
    procedure setTheme(theme: String);
    function setValue(val: String; curPos: Variant): String;
    procedure setWrapBehavioursEnabled(enabled: Boolean);
    procedure sortLines();
    procedure splitLine();
    procedure toggleCommentLines();
    procedure toggleOverwrite();
    procedure toLowerCase();
    procedure toUpperCase();
    procedure transposeLetters();
    procedure transposeSelections(dir: Integer);
    procedure undo();
    procedure unsetStyle(style: Variant);
    procedure updateSelectionMarkers();

    constructor Create(AOwner: TQTXComponent; CB: TQTXAceEditorConstructorCB); override;
    destructor Destroy(); override;
  published
    property Text: string read (getValue()) write (setValue(value, -1)) default '';
    property Mode: TEnumAceMode read (fMode) write (setMode(value)) default amPascal;
    property Theme: TEnumAceTheme read (fTheme) write (setTheme(TEnumAceThemeStr[value])) default atTwilight;
    property Version: string read (FAceWrapperVersion) write (FAceWrapperVersion) default AceWrapperVersion;
  end;

  function NewAceEditor(elt: String): TAceEditor; overload; external "ace.edit";
  function NewAceEditor(elt: JElement): TAceEditor; overload; external "ace.edit";

implementation

constructor TAceOptionsRenderer.Create(opts: Variant = null);
begin
  inherited Create();

  fOpts := TVariant.CreateObject;
  if opts <> null then begin
    asm
     @fOpts = Object.assign(@fOpts, @opts);
    end;
  end;
end;

function TAceOptionsRenderer.getProp(prop: String): Variant;
begin
  Result := fOpts[prop];
end;

procedure TAceOptionsRenderer.setProp(prop: String; value: Variant);
begin
  fOpts[prop] := value;
end;

function TAceOptionsRenderer.RenderOptions(): Variant;
begin
  Result := fOpts;
end;

constructor TQTXAceEditor.Create(AOwner: TQTXComponent; CB: TQTXAceEditorConstructorCB);
begin
  inherited Create(AOwner, procedure (widget: TQTXWidget)
  begin

    widget.Width := 900;
    widget.Height := 300;

    fDivEditor := TQTXWidget.Create(widget, procedure (divEditor: TQTXWidget)
    begin
      divEditor.PositionMode := TQTXWidgetPositionMode.cpAbsolute;
      divEditor.CssClasses.ClassListSet('');
      divEditor.ParentFont := false;
      divEditor.Handle.style['left'] := 0;
      divEditor.Handle.style['right'] := 0;
      divEditor.Handle.style['top'] := 0;
      divEditor.Handle.style['bottom'] := 0;

      TQTXDispatch.Execute(procedure ()
      begin
        fAceEditor := NewAceEditor(divEditor.Name);

        if Assigned(CB) then CB(Self);
      end, 10);
    end);


  end);
end;

destructor TQTXAceEditor.Destroy();
begin
  Editor.destroy();
  inherited Destroy();
end;

procedure  TQTXAceEditor.WhenAceReady(CB: TStdCallBack);
begin
  if Assigned(fAceEditor) then begin
    CB();
  end else begin
    TQTXDispatch.Execute(procedure()
    begin
      WhenAceReady(@CB);
    end, 1);
  end;
end;

procedure  TQTXAceEditor.WhenAceReady(CB: TQTXWidgetConstructor);
begin
  if Assigned(fAceEditor) then begin
    CB(Self);
  end else begin
    TQTXDispatch.Execute(procedure()
    begin
      WhenAceReady(@CB);
    end, 1);
  end;
end;

procedure TQTXAceEditor.setMode(AMode: TEnumAceMode);
begin
  WhenAceReady(lambda Session.setMode(TEnumAceModeStr[AMode]); end);
end;

//Aliases functions and procedures from TAceEditor
function TQTXAceEditor.addSelectionMarker(orientedRange:TAceRange):TAceRange;
begin
  if Assigned(fAceEditor) then
    Result := fAceEditor.addSelectionMarker(orientedRange)
  else
    Result := nil;
end;

procedure TQTXAceEditor.alignCursors();
begin
  WhenAceReady(lambda () fAceEditor.alignCursors() end);
end;

procedure TQTXAceEditor.blockOutdent();
begin
  WhenAceReady(lambda () fAceEditor.blockOutdent() end);;
end;

procedure TQTXAceEditor.blur();
begin
  WhenAceReady(lambda () fAceEditor.blur() end);;
end;

procedure TQTXAceEditor.centerSelection();
begin
  WhenAceReady(lambda () fAceEditor.centerSelection() end);;
end;

procedure TQTXAceEditor.clearSelection();
begin
  WhenAceReady(lambda () fAceEditor.clearSelection() end);;
end;

procedure TQTXAceEditor.copyLinesDown();
begin
  WhenAceReady(lambda () fAceEditor.copyLinesDown() end);;
end;

procedure TQTXAceEditor.copyLinesUp();
begin
  WhenAceReady(lambda () fAceEditor.copyLinesUp() end);;
end;

procedure TQTXAceEditor.duplicateSelection();
begin
  WhenAceReady(lambda () fAceEditor.duplicateSelection() end);;
end;

procedure TQTXAceEditor.execCommand(command:String);
begin
  WhenAceReady(lambda () fAceEditor.execCommand(command) end);;
end;

procedure TQTXAceEditor.exitMultiSelectMode();
begin
  WhenAceReady(lambda () fAceEditor.exitMultiSelectMode() end);;
end;

procedure TQTXAceEditor.find(needle:String;options:Variant;animate:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.find(needle, options, animate) end);;
end;

function TQTXAceEditor.findAll(needle:String;options:Variant;keeps:Boolean):Integer;
begin
  Result := fAceEditor.findAll(needle, options, keeps);
end;

procedure TQTXAceEditor.findNext(options:Variant;animate:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.findNext(options, animate) end);;
end;

procedure TQTXAceEditor.findPrevious(options:Variant;animate:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.findPrevious(options, animate) end);;
end;

procedure TQTXAceEditor.focus();
begin
  WhenAceReady(lambda () fAceEditor.focus() end);;
end;

procedure TQTXAceEditor.forEachSelection(cmd, args:String);
begin
  WhenAceReady(lambda () fAceEditor.forEachSelection(cmd, args) end);;
end;

function TQTXAceEditor.getAnimatedScroll():Boolean;
begin
  Result := fAceEditor.getAnimatedScroll();
end;

function TQTXAceEditor.getBehavioursEnabled():Boolean;
begin
  Result := fAceEditor.getBehavioursEnabled();
end;

function TQTXAceEditor.getCopyText():String;
begin
  Result := fAceEditor.getCopyText();
end;

function TQTXAceEditor.getCursorPosition():Variant;
begin
  Result := fAceEditor.getCursorPosition();
end;

function TQTXAceEditor.getCursorPositionScreen():Integer;
begin
  Result := fAceEditor.getCursorPositionScreen();
end;

function TQTXAceEditor.getDisplayIndentGuides():Variant;
begin
  Result := fAceEditor.getDisplayIndentGuides();
end;

function TQTXAceEditor.getDragDelay():Integer;
begin
  Result := fAceEditor.getDragDelay();
end;

function TQTXAceEditor.getFadeFoldWidgets():Variant;
begin
  Result := fAceEditor.getFadeFoldWidgets();
end;

function TQTXAceEditor.getFirstVisibleRow():Integer;
begin
  Result := fAceEditor.getFirstVisibleRow();
end;

function TQTXAceEditor.getHighlightActiveLine():Boolean;
begin
  Result := fAceEditor.getHighlightActiveLine();
end;

function TQTXAceEditor.getHighlightGutterLine():Boolean;
begin
  Result := fAceEditor.getHighlightGutterLine();
end;

function TQTXAceEditor.getHighlightSelectedWord():Boolean;
begin
  Result := fAceEditor.getHighlightSelectedWord();
end;

function TQTXAceEditor.getKeyboardHandler():String;
begin
  Result := fAceEditor.getKeyboardHandler();
end;

function TQTXAceEditor.getLastSearchOptions():Variant;
begin
  Result := fAceEditor.getLastSearchOptions();
end;

function TQTXAceEditor.getLastVisibleRow():Integer;
begin
  Result := fAceEditor.getLastVisibleRow();
end;

function TQTXAceEditor.getNumberAt(row, column:Integer):integer;
begin
  Result := fAceEditor.getNumberAt(row, column);
end;

function TQTXAceEditor.getOverwrite():boolean;
begin
  Result := fAceEditor.getOverwrite();
end;

function TQTXAceEditor.getPrintMarginColumn():integer;
begin
  Result := fAceEditor.getPrintMarginColumn();
end;

function TQTXAceEditor.getReadOnly():boolean;
begin
  Result := fAceEditor.getReadOnly();
end;

function TQTXAceEditor.getScrollSpeed():Integer;
begin
  Result := fAceEditor.getScrollSpeed();
end;

function TQTXAceEditor.getSelection():TAceSelection;
begin
  Result := fAceEditor.getSelection();
end;

function TQTXAceEditor.getSelectionRange():TAceRange;
begin
  Result := fAceEditor.getSelectionRange();
end;

function TQTXAceEditor.getSelectionStyle():String;
begin
  Result := fAceEditor.getSelectionStyle();
end;

function TQTXAceEditor.getSession():TAceEditSession;
begin
  Result := fAceEditor.getSession();
end;

function TQTXAceEditor.getShowFoldWidgets():Boolean;
begin
  Result := fAceEditor.getShowFoldWidgets();
end;

function TQTXAceEditor.getShowInvisibles():Boolean;
begin
  Result := fAceEditor.getShowInvisibles();
end;

function TQTXAceEditor.getShowPrintMargin():Boolean;
begin
  Result := fAceEditor.getShowPrintMargin() ;
end;

function TQTXAceEditor.getTheme():String;
begin
  Result := fAceEditor.getTheme();
end;

function TQTXAceEditor.getValue():String;
begin
  Result := fAceEditor.getValue();
end;

function TQTXAceEditor.getWrapBehavioursEnabled():Boolean;
begin
  Result := fAceEditor.getWrapBehavioursEnabled();
end;

procedure TQTXAceEditor.gotoLine(lineNumber, column:Integer;animate:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.gotoLine(lineNumber, column, animate) end);
end;

procedure TQTXAceEditor.gotoPageDown();
begin
  WhenAceReady(lambda () fAceEditor.gotoPageDown() end);
end;

procedure TQTXAceEditor.gotoPageUp();
begin
  WhenAceReady(lambda () fAceEditor.gotoPageUp() end);
end;

procedure TQTXAceEditor.indent();
begin
  WhenAceReady(lambda () fAceEditor.indent() end);
end;

procedure TQTXAceEditor.insert(text:string);
begin
  WhenAceReady(lambda () fAceEditor.insert(text) end);
end;

function TQTXAceEditor.isFocused():Boolean;
begin
  Result := fAceEditor.isFocused();
end;

function TQTXAceEditor.isRowFullyVisible():Boolean;
begin
  Result := fAceEditor.isRowFullyVisible();
end;

function TQTXAceEditor.isRowVisible():Boolean;
begin
  Result := fAceEditor.isRowVisible();
end;

procedure TQTXAceEditor.jumpToMatching(select:Variant);
begin
  WhenAceReady(lambda () fAceEditor.jumpToMatching(select) end);
end;

procedure TQTXAceEditor.modifyNumber(amount:Integer);
begin
  WhenAceReady(lambda () fAceEditor.modifyNumber(amount) end);
end;

procedure TQTXAceEditor.moveCursorTo(row, column:Integer);
begin
  WhenAceReady(lambda () fAceEditor.moveCursorTo(row, column) end);
end;

procedure TQTXAceEditor.moveCursorToPosition(pos:Variant);
begin
  WhenAceReady(lambda () fAceEditor.moveCursorToPosition(pos) end);
end;

function TQTXAceEditor.moveLinesDown():Integer;
begin
  Result := fAceEditor.moveLinesDown();
end;

function TQTXAceEditor.moveLinesUp():Integer;
begin
  Result := fAceEditor.moveLinesUp();
end;

procedure TQTXAceEditor.moveText();
begin
  WhenAceReady(lambda () fAceEditor.moveText() end);
end;

procedure TQTXAceEditor.navigateDown(times:integer);
begin
  WhenAceReady(lambda () fAceEditor.navigateDown(times) end);
end;

procedure TQTXAceEditor.navigateFileEnd();
begin
  WhenAceReady(lambda () fAceEditor.navigateFileEnd() end);
end;

procedure TQTXAceEditor.navigateFileStart();
begin
  WhenAceReady(lambda () fAceEditor.navigateFileStart() end);
end;

procedure TQTXAceEditor.navigateLeft();
begin
  WhenAceReady(lambda () fAceEditor.navigateLeft() end);
end;

procedure TQTXAceEditor.navigateLineEnd();
begin
  WhenAceReady(lambda () fAceEditor.navigateLineEnd() end);
end;

procedure TQTXAceEditor.navigateLineStart();
begin
  WhenAceReady(lambda () fAceEditor.navigateLineStart() end);
end;

procedure TQTXAceEditor.navigateRight();
begin
  WhenAceReady(lambda () fAceEditor.navigateRight() end);
end;

procedure TQTXAceEditor.navigateTo(row, column:integer);
begin
  WhenAceReady(lambda () fAceEditor.navigateTo(row, column) end);
end;

procedure TQTXAceEditor.navigateUp(times:integer);
begin
  WhenAceReady(lambda () fAceEditor.navigateUp(times) end);
end;

procedure TQTXAceEditor.navigateWordLeft();
begin
  WhenAceReady(lambda () fAceEditor.navigateWordLeft() end);
end;

procedure TQTXAceEditor.navigateWordRight();
begin
  WhenAceReady(lambda () fAceEditor.navigateWordRight() end);
end;

procedure TQTXAceEditor.onBlur(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onBlur(CB) end);
end;

procedure TQTXAceEditor.onChangeAnnotation(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeAnnotation(CB) end);
end;

procedure TQTXAceEditor.onChangeBackMarker(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeBackMarker(CB) end);
end;

procedure TQTXAceEditor.onChangeBreakpoint(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeBreakpoint(CB) end);
end;

procedure TQTXAceEditor.onChangeFold(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeFold(CB) end);
end;

procedure TQTXAceEditor.onChangeFrontMarker(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeFrontMarker(CB) end);
end;

procedure TQTXAceEditor.onChangeMode(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeMode(CB) end);
end;

procedure TQTXAceEditor.onChangeWrapLimit(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeWrapLimit(CB) end);
end;

procedure TQTXAceEditor.onChangeWrapMode(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onChangeWrapMode(CB) end);
end;

procedure TQTXAceEditor.onCommandKey(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onCommandKey(CB) end);
end;

procedure TQTXAceEditor.onCompositionEnd(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onCompositionEnd(CB) end);
end;

procedure TQTXAceEditor.onCompositionStart(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onCompositionStart(CB) end);
end;

procedure TQTXAceEditor.onCompositionUpdate(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onCompositionUpdate(CB) end);
end;

procedure TQTXAceEditor.onCopy(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onCopy(CB) end);
end;

procedure TQTXAceEditor.onCursorChange(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onCursorChange(CB) end);
end;

procedure TQTXAceEditor.onCut(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onCut(CB) end);
end;

procedure TQTXAceEditor.onDocumentChange(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onDocumentChange(CB) end);
end;

procedure TQTXAceEditor.onFocus(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onFocus(CB) end);
end;

procedure TQTXAceEditor.onPaste(CB:TAceOnPasteCB);
begin
  WhenAceReady(lambda () fAceEditor.onPaste(CB) end);
end;

procedure TQTXAceEditor.onScrollLeftChange(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onScrollLeftChange(CB) end);
end;

procedure TQTXAceEditor.onScrollTopChange(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onScrollTopChange(CB) end);
end;

procedure TQTXAceEditor.onSelectionChange(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onSelectionChange(CB) end);
end;

procedure TQTXAceEditor.onTextInput(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onTextInput(CB) end);
end;

procedure TQTXAceEditor.onTokenizerUpdate(CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.onTokenizerUpdate(CB) end);
end;

procedure TQTXAceEditor.redo();
begin
  WhenAceReady(lambda () fAceEditor.redo() end);
end;

procedure TQTXAceEditor.remove(dir:String);
begin
  WhenAceReady(lambda () fAceEditor.remove(dir) end);
end;

procedure TQTXAceEditor.removeLines();
begin
  WhenAceReady(lambda () fAceEditor.removeLines() end);
end;

procedure TQTXAceEditor.removeSelectionMarker(range:TAceRange);
begin
  WhenAceReady(lambda () fAceEditor.removeSelectionMarker(range) end);
end;

procedure TQTXAceEditor.removeToLineEnd();
begin
  WhenAceReady(lambda () fAceEditor.removeToLineEnd() end);
end;

procedure TQTXAceEditor.removeToLineStart();
begin
  WhenAceReady(lambda () fAceEditor.removeToLineStart() end);
end;

procedure TQTXAceEditor.removeWordLeft();
begin
  WhenAceReady(lambda () fAceEditor.removeWordLeft() end);
end;

procedure TQTXAceEditor.removeWordRight();
begin
  WhenAceReady(lambda () fAceEditor.removeWordRight() end);
end;

procedure TQTXAceEditor.replace(replacement:String;options:Variant);
begin
  WhenAceReady(lambda () fAceEditor.replace(replacement, options) end);
end;

procedure TQTXAceEditor.replaceAll(replacement:String;options:Variant);
begin
  WhenAceReady(lambda () fAceEditor.replaceAll(replacement, options) end);
end;

procedure TQTXAceEditor.resizeEditor(force:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.resize(force) end);
end;

procedure TQTXAceEditor.revealRange();
begin
  WhenAceReady(lambda () fAceEditor.revealRange() end);
end;

procedure TQTXAceEditor.scrollPageDown();
begin
  WhenAceReady(lambda () fAceEditor.scrollPageDown() end);
end;

procedure TQTXAceEditor.scrollPageUp();
begin
  WhenAceReady(lambda () fAceEditor.scrollPageUp() end);
end;

procedure TQTXAceEditor.scrollToLine(line:Integer;center, animate:Boolean;CB:TAceStdCB);
begin
  WhenAceReady(lambda () fAceEditor.scrollToLine(line, center, animate, CB) end);
end;

procedure TQTXAceEditor.scrollToRow(row:Integer);
begin
  WhenAceReady(lambda () fAceEditor.scrollToRow(row) end);
end;

procedure TQTXAceEditor.selectAll();
begin
  WhenAceReady(lambda () fAceEditor.selectAll() end);
end;

procedure TQTXAceEditor.selectMore(dir:Integer;skip:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.selectMore(dir, skip) end);
end;

procedure TQTXAceEditor.selectMoreLines(dir:Integer;skip:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.selectMoreLines(dir, skip) end);
end;

procedure TQTXAceEditor.selectPageDown();
begin
  WhenAceReady(lambda () fAceEditor.selectPageDown() end);
end;

procedure TQTXAceEditor.selectPageUp();
begin
  WhenAceReady(lambda () fAceEditor.selectPageUp() end);
end;

procedure TQTXAceEditor.setAnimatedScroll();
begin
  WhenAceReady(lambda () fAceEditor.setAnimatedScroll() end);
end;

procedure TQTXAceEditor.setBehavioursEnabled(enabled:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setBehavioursEnabled(enabled) end);
end;

procedure TQTXAceEditor.setDisplayIndentGuides(identGuides:Variant);
begin
  WhenAceReady(lambda () fAceEditor.setDisplayIndentGuides(identGuides) end);
end;

procedure TQTXAceEditor.setDragDelay(dragDelay:Integer);
begin
  WhenAceReady(lambda () fAceEditor.setDragDelay(dragDelay) end);
end;

procedure TQTXAceEditor.setFadeFoldWidgets(fadeFoldWidget:Variant);
begin
  WhenAceReady(lambda () fAceEditor.setFadeFoldWidgets(fadeFoldWidget) end);
end;

procedure TQTXAceEditor.setFontSize(size:Integer);
begin
  WhenAceReady(lambda () fAceEditor.setFontSize(size) end);
end;

procedure TQTXAceEditor.setHighlightActiveLine(shouldHighlight:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setHighlightActiveLine(shouldHighlight) end);
end;

procedure TQTXAceEditor.setHighlightGutterLine(gutterLine:Integer);
begin
  WhenAceReady(lambda () fAceEditor.setHighlightGutterLine(gutterLine) end);
end;

procedure TQTXAceEditor.setHighlightSelectedWord(shoudHighlight:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setHighlightSelectedWord(shoudHighlight) end);
end;

procedure TQTXAceEditor.setKeyboardHandler(keyboardHandler:string);//Vim, windows, etc
begin
  WhenAceReady(lambda () fAceEditor.setKeyboardHandler(keyboardHandler) end);
end;

procedure TQTXAceEditor.setOverwrite(overwrite:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setOverwrite(overwrite) end);
end;

procedure TQTXAceEditor.setPrintMarginColumn(showPrintMargin:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setPrintMarginColumn(showPrintMargin) end);
end;

procedure TQTXAceEditor.setReadOnly(readOnly:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setReadOnly(readOnly) end);
end;

procedure TQTXAceEditor.setScrollSpeed(speed:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setScrollSpeed(speed) end);
end;

procedure TQTXAceEditor.setSelectionStyle(style:String);
begin
  WhenAceReady(lambda () fAceEditor.setSelectionStyle(style) end);
end;

procedure TQTXAceEditor.setSession(session:TAceEditSession);
begin
  WhenAceReady(lambda () fAceEditor.setSession(session) end);
end;

procedure TQTXAceEditor.setShowFoldWidgets(show:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setShowFoldWidgets(show) end);
end;

procedure TQTXAceEditor.setShowInvisibles(showInvisibles:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setShowInvisibles(showInvisibles) end);
end;

procedure TQTXAceEditor.setShowPrintMargin(showPrintMargin:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setShowPrintMargin(showPrintMargin) end);
end;

procedure TQTXAceEditor.setStyle(style:String);
begin
  WhenAceReady(lambda () fAceEditor.setStyle(style) end);
end;

procedure TQTXAceEditor.setTheme(theme:String);
begin
  WhenAceReady(lambda () fAceEditor.setTheme(theme) end);
end;

function TQTXAceEditor.setValue(val:String;curPos:Variant):String;
begin
  WhenAceReady(lambda () fAceEditor.setValue(val, curPos) end);
  Result := val;
end;

procedure TQTXAceEditor.setWrapBehavioursEnabled(enabled:Boolean);
begin
  WhenAceReady(lambda () fAceEditor.setWrapBehavioursEnabled(enabled) end);
end;

procedure TQTXAceEditor.sortLines();
begin
  WhenAceReady(lambda () fAceEditor.sortLines() end);
end;

procedure TQTXAceEditor.splitLine();
begin
  WhenAceReady(lambda () fAceEditor.splitLine() end);
end;

procedure TQTXAceEditor.toggleCommentLines();
begin
  WhenAceReady(lambda () fAceEditor.toggleCommentLines() end);
end;

procedure TQTXAceEditor.toggleOverwrite();
begin
  WhenAceReady(lambda () fAceEditor.toggleOverwrite() end);
end;

procedure TQTXAceEditor.toLowerCase();
begin
  WhenAceReady(lambda () fAceEditor.toLowerCase() end);
end;

procedure TQTXAceEditor.toUpperCase();
begin
  WhenAceReady(lambda () fAceEditor.toUpperCase() end);
end;

procedure TQTXAceEditor.transposeLetters();
begin
  WhenAceReady(lambda () fAceEditor.transposeLetters() end);
end;

procedure TQTXAceEditor.transposeSelections(dir:Integer);
begin
  WhenAceReady(lambda () fAceEditor.transposeSelections(dir) end);
end;

procedure TQTXAceEditor.undo();
begin
  WhenAceReady(lambda () fAceEditor.undo() end);
end;

procedure TQTXAceEditor.unsetStyle(style:Variant);
begin
  WhenAceReady(lambda () fAceEditor.unsetStyle(style) end);
end;

procedure TQTXAceEditor.updateSelectionMarkers();
begin
  WhenAceReady(lambda () fAceEditor.updateSelectionMarkers() end);
end;


initialization
  asm
    var AceVisualRenderer = ace.require('ace/virtual_renderer').VisualRenderer;
    var AceEditor = ace.require('ace/editor').Editor;
    var AceRange = ace.require('ace/range').Range;
    var AceSelection = ace.require('ace/selection').Selection;
    var AceUndoManager = ace.require('ace/undomanager').UndoManager;
    var AceDocument = ace.require('ace/document').Document;
    var AceAnchor = ace.require('ace/anchor').Anchor;
  end;
end.
