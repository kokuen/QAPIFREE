**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZRTBKO
/// @info Retrieve Backup Options API resources
///
/// @project QAPIFREE
/// @author kokuen
/// @version 7.1
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Exports & Imports
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/IF defined(backup_gen)
  /EOF
/ELSE
  /DEFINE qezrtbko
/ENDIF

/IF not defined(api_common)
  /INCLUDE QAPIFREE,COMMON
/ENDIF

/IF not defined(qusec)
  /INCLUDE QAPIFREE,QUSEC
/ENDIF



// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Constants
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @refers QEZRTBKO(formatName) => Information about what the user has selected to be saved on the next backup for
///   that type (*DAILY, *WEEKLY, or *MONTHLY).
dcl-c RBKO_FORMAT_0100 const('RBKO0100');
/// @refers QEZRTBKO(formatName) => information on the last backup date and time, and when the next backup date and time
///   for that backup option are scheduled to occur.
dcl-c RBKO_FORMAT_0200 const('RBKO0200');

// -------------------------------------

/// @refers QEZRTBKO(backupOption) => Daily backup options.
dcl-c BACKUP_DAILY const('*DAILY');
/// @refers QEZRTBKO(backupOption) => Weekly backup options.
dcl-c BACKUP_WEEKLY const('*WEEKLY');
/// @refers QEZRTBKO(backupOption) => Monthly backup options.
dcl-c BACKUP_MONTHLY const('*MONTHLY');
/// @refers QEZRTBKO(backupOption) => The backup options for all types of backup (*DAILY, *WEEKLY, and *MONTHLY).
dcl-c BACKUP_ALL const('*ALL');




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Data Structures
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @info Header of the info returned by the API.
dcl-ds RBOH_0100 qualified template;
  bytesReturned int(10);
  bytesAvailable int(10);
  offsetToDailyOption int(10); 
  offsetToWeeklyOption int(10); 
  offsetToMonthlyOption int(10); 
end-ds;

// -------------------------------------

/// @info Structure of the information about what the user has selected to be saved on the next
/// backup.
/// @field "backupDevices&tapeSetsToRotate" char(10) array and char(4) array with sizes depending on
/// "backupDevicesNumber" and "offsetToTapesToRotate" fields value.
dcl-ds RBKO_0100 qualified inz;
  offsetToBackupDevices int(10);
  backupDevicesNumber int(10);
  offsetToTapesToRotate int(10);
  TapesToRotateNumber int(10);
  lastUsedTape char(4);
  nextTape char(4);
  EraseTapeBeforeBackup ind;
  backupUserLibraries char(1);
  backupFolders char(1);
  backupUserDirectories char(1);
  backupSecurityData ind;
  backupConfigurationData ind;
  backupMail char(1);
  backupCalendars char(1);
  submitAsBatchJob ind;
  saveChangedObjectsOnly ind;
  printDetailedReport ind;
  userExitProgramName char(10);
  userExitProgramLibrary char(10);
  *n char(1); // Reserved by the system
  offsetToAdditionalInfo int(10);
  backupDevices&tapeSetsToRotate char(INT5_MAX) options(*varsize);
end-ds;

/// @info Structure of the information on the last backup date and time, and when the next backup
/// date and time for that backup option are scheduled to occur.
/// @fields "[*]Date" The format of this field is CYYMMDD.
dcl-ds RBKO_0200 qualified inz;
  SaveInformation likeds(RBKO_0100);
  lastBackupDate char(7);
  lastBackupTime char(6);
  nextBackupDate char(7);
  nextBackupTime char(6);
end-ds;


// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @info The Retrieve Backup Options (QEZRTBKO) API returns in a receiver variable the backup options for the requested
/// backup type.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/QEZRTBKO.html
/// @param The receiver variable that receives the information requested. Use the "RBKO_" data structures.
/// @param The length of the receiver variable provided.
/// @param The format of the backup option descriptions to be returned. Use the "RBKO_FORMAT" constants.
/// @param The backup options to retrieve. Use the "BACKUP_" constants.
/// @param The structure in which to return error information.
dcl-pr QEZRTBKO extpgm('QEZRTBKO');
  output char(INT10_MAX) options(*varsize);
  outputLength int(10) const;
  formatName char(8) const;
  backupOption char(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;