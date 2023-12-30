**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZCHBKL
/// @info Change Object Backup List API resources
///
/// @project QAPIFREE
/// @author kokuen
/// @version 7.1
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Exports & Imports
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/IF defined(backup_apis)
  /EOF
/ELSE
  /DEFINE qezchbkl
/ENDIF

/IF not defined(shared_resources)
  /INCLUDE SHARED,RESOURCES
/ENDIF

/IF not defined(qusec)
  /INCLUDE SHARED,QUSEC
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
  recordLength int(10);
  structure likeds(RecordStructure);
  dataLength int(10);
  Data char(INT10_MAX) options(*varsize);
end-ds;

/// @refers QEZCHBKL(inputStructure).Records.key
/// @field "Names" Library names are of type char(10) while folder names are of type char(12)
dcl-ds RecordStructure qualified template;
  arraySize int(10);
  backupType char(1);
  Names char(INT10_MAX) options(*varsize);
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
/// @param This structure includes the keys and data that are needed to make the necessary changes to the backup
/// definitions.
/// @param The length of the input structure.
/// @param The structure in which to return error information.
dcl-pr QEZCHBKL extpgm('QEZCHBKL');
  inputStructure char(INT10_MAX) options(*varsize) const;
  inputLength int(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;