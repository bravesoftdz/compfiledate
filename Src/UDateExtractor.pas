{
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2014, Peter Johnson (www.delphidabbler.com).
 *
 * Static class that extracts a suported file date from a file, optionally
 * following sym-links.
}


unit UDateExtractor;


interface


type
  {$SCOPEDENUMS ON}
  ///  <summary>Type of date to be extracted from a file.</summary>
  ///  <remarks>
  ///  <para>- LastModified - get date file was last modified.</para>
  ///  <para>- Created - get date file was created.</para>
  ///  </remarks>
  TDateType = (LastModified, Created);
  {$SCOPEDENUMS OFF}

  TDateExtractor = class
  public
    constructor Create;
    class function GetDate(const FileName: string; const DateType: TDateType;
      const FollowSymLinks: Boolean): TDateTime;
  end;


implementation


uses
  // Delphi
  SysUtils, RTLConsts,
  // Project
  UAppException;

{ TDateExtractor }

constructor TDateExtractor.Create;
begin
  raise ENoConstructException.CreateFmt(sNoConstruct, [ClassName]);
end;

class function TDateExtractor.GetDate(const FileName: string;
  const DateType: TDateType; const FollowSymLinks: Boolean): TDateTime;
var
  DTI: TDateTimeInfoRec;
begin
  if not FileGetDateTimeInfo(FileName, DTI, FollowSymLinks) then
    raise EApplication.Create(
      sAppErrFileNameNotFound, [FileName], cAppErrFileNameNotFound
    );
  case DateType of
    TDateType.LastModified:
      Result := DTI.TimeStamp;
    TDateType.Created:
      Result := DTI.CreationTime;
  else
    raise Exception.Create('Invalid TDateType value');
  end;
end;

end.
