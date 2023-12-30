**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZRTBKH
/// @info Retrieve Backup History API resources
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
  /DEFINE qezrtbkh
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


/// @refers QEZRTBKH(formatName) => basic backup status and history.
dcl-c RBKH_FORMAT_0100 const('RBKH0100');
/// @refers QEZRTBKH(formatName) => detailed backup status and information.
dcl-c RBKH_FORMAT_0100 const('RBKH0200');




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Data Structures
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @fields [*]Date => The format of this field is CYYMMDD.
dcl-ds RBKH_0100 qualified inz;
  bytesReturned int(10);
  bytesAvailable int(10);
  allUserLibrariesLastBackupDate char(7);
  allUserLibrariesLastBackupTime char(6);
  allUserLibrariesTape char(4);
  allUserLibrariesChangesLastBackupDate char(7);
  allUserLibrariesChangesLastBackupTime char(6);
  allUserLibrariesChangesTape char(4);
  librariesOnListLastBackupDate char(7);
  librariesOnListLastBackupTime char(6);
  librariesOnListTape char(4);
  librariesOnListChangesLastBackupDate char(7);
  librariesOnListChangesLastBackupTime char(6);
  librariesOnListChangesTape char(4);
  allFoldersLastBackupDate char(7);
  allFoldersLastBackupTime char(6);
  allFoldersTape char(4);
  allFoldersChangesLastBackupDate char(7);
  allFoldersChangesLastBackupTime char(6);
  allFoldersChangesTape char(4);
  foldersOnListLastBackupDate char(7);
  foldersOnListLastBackupTime char(6);
  foldersOnListTape char(4);
  securityDataLastBackupDate char(7);
  securityDataLastBackupTime char(6);
  securityDataTape char(4);
  configurationDataLastBackupDate char(7);
  configurationDataLastBackupTime char(6);
  configurationDataTape char(4);
  calendarsLastBackupDate char(7);
  calendarsLastBackupTime char(6);
  calendarsTape char(4);
  mailBackupDate char(7);
  mailLastBackupTime char(6);
  mailTape char(4);
  allUserDirectoriesLastBackupDate char(7);
  allUserDirectoriesLastBackupTime char(6);
  allUserDirectoriesTape char(4);
  allUserDirectoriesChangesLastBackupDate char(7);
  allUserDirectoriesChangesLastBackupTime char(6);
  allUserDirectoriesChangesTape char(4);
  *n char(21); // Reserved by the system
end-ds;

dcl-ds RBKH_0200 qualified inz;
  BasicInfo likeds(RBKH_0100);
  BackupInfos likeds(BackupInfo) dim(UNS3_MAX);
end-ds;

/// @field backupDate => The format of this field is CYYMMDD.
dcl-ds BackupInfo qualified template;
  backupDate char(7);
  backupTime(6);
  backupOptions char(10);
  tapeSet char(4);
  changesOnly ind;
  userLibrariesSaved char(1);
  foldersSaved char(1);
  userDirectoriesSaved char(1);
  securityDataSaved ind;
  configurationSaved ind;
  calendarsSaved ind;
  mailSaved ind;
end-ds;



// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @info The Retrieve Backup History (QEZRTBKH) API retrieves information about the backup status and history into a 
///   single variable in the calling program.
/// @param The receiver variable that receives the information requested. Use the "RBKH_" data structures.
/// @param The length of the receiver variable provided.
/// @param The format of the command information to be returned. Use the "RBKH_FORMAT_" constants.
/// @param The structure in which to return error information. 
dcl-pr QEZRTBKH extpgm('QEZRTBKH');
  output char(INT10_MAX) options(*varsize);
  outputLength int(10) const;
  formatName char(8) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;