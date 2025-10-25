unit uDelphiBooksTypes;

interface

uses
  qtx.sysutils, qtx.classes;

type
  JDelphiBooksListItem = class(JObject)
    id : integer;
    name: string;
    url: string;
    thumb: string;
    lang: string;
    pubdate: string;
  end;

  JDelphiBooksList = array of JDelphiBooksListItem;

implementation



end.
