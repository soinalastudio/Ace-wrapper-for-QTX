uses
  qtx.sysutils,
  qtx.classes,
  qtx.time,
  qtx.dom.widgets,
  qtx.dom.theme,
  qtx.dom.types,
  qtx.dom.events,
  qtx.dom.graphics,
  qtx.dom.application,
  qtx.dom.forms,
form1;
                       
begin
  TQTXDOMApplicationBoxed.Create(nil, procedure (Widget: TQTXComponent)
  begin
    var App := TQTXDOMApplicationBoxed(Widget);
    {$I "app::form.init"}
    App.Showform('form1', fdNone);
  end);
  
end.
