unit form1;

interface

uses
  qtx.sysutils,
  qtx.classes,
  qtx.dom.types,
  qtx.dom.events,
  qtx.dom.graphics,
  qtx.dom.widgets,
  qtx.dom.border,
  qtx.dom.theme,
  qtx.dom.application,
  qtx.dom.forms,
  qtx.dom.events.mouse,
  qtx.dom.events.pointer,
  qtx.dom.events.keyboard,
  qtx.dom.events.touch,
qtx.delegates,
qtx.dom.control.Button,
qtx.dom.stylesheet,
qtx.dom.control.edit,
qtx.dom.control.contentbox,
qtx.dom.control.listbox;




type

  Tform1 = class( TQTXForm )
  {$I "intf::form1"}
  protected
    procedure FormPresented; override;
    procedure FormHidden; override;

    procedure StyleObject; override;
  public
      procedure HandlebtnAddElementClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
      procedure HandlebtnRemoveElementsClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
    constructor Create(AOwner: TQTXComponent; CB: TQTXFormConstructor); override;
    destructor Destroy; override;
end;

implementation

procedure Tform1.HandlebtnAddElementClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
begin
  ListBox1.AddText(Edit1.Text);
  Edit1.Text := '';
  Edit1.SetFocus;
end;

procedure Tform1.HandlebtnRemoveElementsClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
begin
  if assigned(ListBox1.Selected) then
    ListBox1.Remove(ListBox1.SelectedIndex);
end;

constructor Tform1.Create(AOwner: TQTXComponent; CB: TQTXFormConstructor);
begin
  inherited Create(AOwner, procedure (Form: TQTXForm)
  begin
    {$I "impl::form1"}

  if assigned( CB ) then
	  CB( self );
  end);
end;

destructor Tform1.destroy;
begin
  inherited;
end;

procedure Tform1.StyleObject;
begin
  inherited;
end;

procedure Tform1.FormPresented;
begin
  inherited;
end;

procedure Tform1.FormHidden;
begin
  inherited;
end;


end.
