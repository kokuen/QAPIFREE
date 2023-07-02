**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @brief QUSEC
/// @info Error management resources for APIs
/// 
/// @project FREESYSINC
/// @author kokuen
/// @version 7.1
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Exports & Imports
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/DEFINE qusec

/IF not defined(common)
  /INCLUDE FREESYSINC,COMMON
/ENDIF




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Data structures
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


dcl-ds ERRC0100 qualified inz;
  bytesProvided int(10) const;
  bytesAvailable int(10);
  exceptionID char(7);
  *n char(1); // Reserved by the system
  output char(INT5_MAX) options(*varsize);
end-ds;


dcl-ds ERRC0200 qualified inz;
  bytesProvided int(10) const;
  bytesAvailable int(10);
  exceptionID char(7);
  *n char(1); // Reserved by the system
  dataCCSID int(10);
  OffsetToData int(10);
  dataLength int(10);
  output char(INT5_MAX) options(*varsize);
end-ds;