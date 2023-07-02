**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @brief QEZCHBKL
/// @info Change Object Backup List
///
/// @project FREESYSINC
/// @author kokuen
/// @version 7.1
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Exports & Imports
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/DEFINE qezchbkl

/IF not defined(common)
  /INCLUDE FREESYSINC,COMMON
/ENDIF

/IF not defined(qusec)
  /INCLUDE FREESYSINC,QUSEC
/ENDIF




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Data Structures
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @refers QEZCHBKL(inputStructure)
dcl-ds InputStructure qualified inz;
  recordsNumber int(10) inz(2);
  Records likeds(record) dim(2);
end-ds;

/// @refers QEZCHBKL(inputStructure).Records
dcl-ds Record qualified template;
  recordLenght int(10);
  key char(INT3_MAX) options(*varsize);
  dataLength int(10);
  Data likeds(RecordData);
end-ds;

/// @refers QEZCHBKL(inputStructure).Records.Data
dcl-ds RecordData qualified template;
  arraySize int(10);
  backupType char(1);
  Names char(INT10_MAX) options(*varsize); // Library name = char(10), folder name = char(12)
end-ds;




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Constants
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @refers QEZCHBKL(inputStructure).Records.Data.backupType: back up daily.
dcl-c BACKUP_DAILY 1;
/// @refers QEZCHBKL(inputStructure).Records.Data.backupType: back up weekly.
dcl-c BACKUP_WEEKLY 2;
/// @refers QEZCHBKL(inputStructure).Records.Data.backupType: back up monthly.
dcl-c BACKUP_MONTHLY 3;
/// @refers QEZCHBKL(inputStructure).Records.Data.backupType: no backup.
dcl-c BACKUP_NONE 4;





// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @info The Change Object Backup List (QEZCHBKL) API changes the backup type for a list of objects that are specified
/// by the user.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71%2Fapis%2FQEZCHBKL.html
///
/// @param This structure includes the keys and data that are needed to make the necessary changes to the backup
/// definitions.
/// @param The length of the input structure.
/// @param The structure in which to return error information.
dcl-pr QEZCHBKL extpgm('QEZCHBKL');
  inputStructure char(INT10_MAX) options(*varsize) const;
  inputLength int(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;