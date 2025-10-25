unit fMain;

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
  qtx.dom.control.contentbox,
  qtx.dom.control.listbox,
  uDelphiBooksTypes,
  qtx.dom.control.common,
  qtx.dom.control.image;


type
  TfrmMain = class( TQTXForm )
  {$I "intf::fMain"}
  protected
    FBooksList: JDelphiBooksList;
    FPrevSelected: TQTXListItem;
    procedure FormPresented; override;
    procedure FormHidden; override;
    procedure StyleObject; override;
  public
    procedure HandleDelphiBooksListClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
    procedure HandleLoadBooksListClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
    constructor Create(AOwner: TQTXComponent; CB: TQTXFormConstructor); override;
    destructor Destroy; override;
  end;

implementation

uses
  qtx.json,
  qtx.dom.http;

procedure TfrmMain.HandleDelphiBooksListClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
begin
  if assigned(lbDelphiBooksList.Selected) then begin
    imgBookCover.Visible := true;
    imgBookCover.Picture.Url := FBooksList[lbDelphiBooksList.SelectedIndex].thumb;
    if assigned(FPrevSelected) then
      FPrevSelected.CssClasses.ClassRemove('active');
    lbDelphiBooksList.Selected.CssClasses.ClassAdd('active');
    FPrevSelected := lbDelphiBooksList.Selected;
  end;
end;

procedure TfrmMain.HandleLoadBooksListClick(Sender: TQTXDOMMouseDelegate; EventObj: JMouseEvent);
begin
    // btnLoadBooksList.Visible := false;
    btnLoadBooksList.Enabled := false;

    TQTXHttpRequest.GetTextFile('https://delphi-books.com/api/b/all.json',procedure (Request: TQTXHttpRequest; TextData: string; Error: Exception)
    var
      i : integer;
      QTXBookIndex : integer;
    begin
      if Error <> nil then begin
        writeln(Error.Message);
        raise Error;
      end;

      // writeln(TextData);

      FBooksList := JDelphiBooksList(TQTXJSON.Parse(TextData));

      QTXBookIndex := -1;

      lbDelphiBooksList.Clear;
      lbDelphiBooksList.BeginUpdate;
      try
        // for var j := 1 to 50 do
        for i := 0 to FBooksList.Count-1 do begin
          lbDelphiBooksList.AddText(FBooksList[i].name);
          if (FBooksList[i].name.Contains('Quartex')) then
            QTXBookIndex := i;
        end;
      finally
        lbDelphiBooksList.EndUpdate;
      end;

      asm
        let lst = document.getElementsByClassName('TQTXListItemText');
        for(let i = 0; i < lst.length; i++) {
          lst[i].classList.add('list-group-item');
          lst[i].classList.add('list-group-item-action');
        }
      end;

      // TODO : préselectionner le livre de Kevin Bond sur Quartex
      // voir quand et comment on peut l'ajouter sans planter le reste
  //    if QTXBookIndex>=0 then begin
   //     lbDelphiBooksList.Items[QTXBookIndex].Select;
//        HandleLoadBooksListClick(Sender, EventObj);
     // end;
    end);
end;

constructor TfrmMain.Create(AOwner: TQTXComponent; CB: TQTXFormConstructor);
begin
  inherited Create(AOwner, procedure (Form: TQTXForm)
  begin
    {$I "impl::fMain"}

    btnLoadBooksList.CssClasses.ClassAdd('btn');
    btnLoadBooksList.CssClasses.ClassAdd('btn-primary');

    lbDelphiBooksList.CssClasses.ClassAdd('list-group');

    imgBookCover.Picture.ObjectFit := TQTXObjectFit.fsContain;

  	if assigned( CB ) then
  	  CB( self );
  end);

  FPrevSelected := nil;
end;

destructor TfrmMain.destroy;
begin
  inherited;
end;

procedure TfrmMain.StyleObject;
begin
  inherited;
end;

procedure TfrmMain.FormPresented;
begin
  inherited;
end;

procedure TfrmMain.FormHidden;
begin
  inherited;
end;


end.
