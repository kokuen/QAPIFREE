**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZRTBKS
/// @info All general backup related API resources
///
/// @project QAPIFREE
/// @author kokuen
/// @version 7.1
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Exports & Imports
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




/IF not defined(api_common)
  /INCLUDE BASE,COMMON
/ENDIF

/IF not defined(qusec)
  /INCLUDE BASE,QUSEC
/ENDIF

// -----------------

/IF defined(qezchbkl)
  /EOF
/ELSEIF defined(qezchbks)
  /EOF
/ELSEIF defined(qezolbkl)
  /EOF
/ELSEIF defined(qezrtbkd)
  /EOF
/ELSEIF defined(qezrtbkh)
  /EOF
/ELSEIF defined(qezrtbko)
  /EOF
/ELSEIF defined(qezrtbks)
  /EOF
/ELSE
  /DEFINE backup_apis
/ENDIF




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Constants
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// ---------------------------------------------------------
//  Formats names
// ---------------------------------------------------------
/// @const QEZCHBKS only format.
dcl-c CBKS_0100 const('CBKS0100');

/// @const Library basic information format.
dcl-c OBKL_0100 const('OBKL0100');
/// @const Folder basic information format.
dcl-c OBKL_0200 const('OBKL0200');
/// @const Complete information format.
dcl-c OBKL_0600 const('OBKL0600');

/// @const QEZRTBKD only format.
dcl-c RBKD_0100 const('RBKD0100');

/// @const Basic backup status and history.
dcl-c RBKH_0100 const('RBKH0100');
/// @const Detailed backup status and information.
dcl-c RBKH_0200 const('RBKH0200');

/// @const Header of the information returned by the API.
dcl-c RBKO_HEADER const('RBOH0100');
/// @const Information about what the user has selected to be saved on the next backup for that type
/// (*DAILY, *WEEKLY, or *MONTHLY).
dcl-c RBKO_0100 const('RBKO0100');
/// @const information on the last backup date and time, and when the next backup date and time for 
/// that backup option are scheduled to occur.
dcl-c RBKO_0200 const('RBKO0200');

/// @const QEZRTBKS only format.
dcl-c RBKS_0100 const('RBKS0100');


// ---------------------------------------------------------
//  APIs Shared constants
// ---------------------------------------------------------
/// The folder information is returned.
dcl-c OBJECT_FOLDER const('*FLR');
/// The library information is returned.
dcl-c OBJECT_LIBRARY const('*LIB');

/// @const Return information for objects that are backed up *DAILY.
dcl-c BACKUP_DAILY const('*DAILY');
/// @const Return information for objects that are backed up *WEEKLY.
dcl-c BACKUP_WEEKLY const('*WEEKLY');
/// @const Return information for objects that are backed up *MONTHLY.
dcl-c BACKUP_MONTHLY const('*MONTHLY');
/// @const Return information for objects that are backed up *DAILY, *WEEKLY or *MONTHLY.
dcl-c BACKUP_ALL const('*ALL');


// ---------------------------------------------------------
//  QEZCHBKL constants
// ---------------------------------------------------------
/// @const Back up daily.
dcl-c BACKUP_DAILY_SCHEDULE const(1);
/// @const Back up weekly.
dcl-c BACKUP_WEEKLY_SCHEDULE const(2);
/// @const Back up monthly.
dcl-c BACKUP_MONTHLY_SCHEDULE const(3);
/// @const No backup
dcl-c BACKUP_NONE_SCHEDULE const(4);


// ---------------------------------------------------------
//  QEZCHBKS constants
// ---------------------------------------------------------
/// @const Daily backup.
dcl-c FREQUENCE_DAILY const('1');
/// @const Weekly backup.
dcl-c FREQUENCE_WEEKLY const('2');
/// @const Monthly backup.
dcl-c FREQUENCE_MONTHLY const('3');
/// @const Every week except for the week that the monthly backup is to occur.
dcl-c FREQUENCE_WEEKMONTH const('4');
/// @const No change is made.
dcl-c FREQUENCE_SAME const('9');
/// @const No backup is scheduled.
dcl-c FREQUENCE_NONE const(*blank);

/// @const No backup operations are scheduled.
dcl-c TIME_NONE const(*blanks);
/// @const No change should be made to the current backup operations.
dcl-c TIME_SAME const('*SAME');

/// @const No message is sent.
dcl-c HOURS_NONE const(0);
/// @const No change is made.
dcl-c HOURS_SAME const(-1);

/// @const No changes are made.
dcl-c WEEKMONTH_SAME const(-1);
/// @const No monthly backups are scheduled.
dcl-c WEEKMONTH_NONE const(*zeros);
/// @const The last week for any given month.
dcl-c WEEKMONTH_LAST const(5);

/// @const Don't use the given schedule.
dcl-c USE_NO const('0');
/// @const Use the given schedule.
dcl-c USE_YES const('1');
/// @const Use the current schedule.
dcl-c USE_SAME const(*blank);


// ---------------------------------------------------------
//   constants
// ---------------------------------------------------------





// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Data Structures
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// ---------------------------------------------------------
// QEZCHBKL data structures 
// ---------------------------------------------------------


/// @info Base structure used by the QEZCHBKL API.
dcl-ds InputStructure qualified inz;
  recordsNumber int(10) inz(2);
  Records likeds(Record) dim(2);
end-ds;

/// @info Record structure of the input structure used by the QEZCHBKL API.
dcl-ds Record qualified template;
  recordLength int(10);
  Structures likeds(Structures);
  dataLength int(10);
  data char(INT10_MAX) options(*varsize);
end-ds;

/// @info Structures linked to a record of the input structure used by the QEZCHBKL API.
/// @field "backupType"
///   @useonly "BACKUP_DAILY_SCHEDULE", "BACKUP_WEEKLY_SCHEDULE", "BACKUP_MONTHLY_SCHEDULE",
///   "BACKUP_NONE_SCHEDULE"
/// @field "Names" Library names are of type char(10) while folder names are of type char(12)
dcl-ds Structures qualified template;
  arraySize int(10);
  backupType char(1);
  Names char(INT10_MAX) options(*varsize);
end-ds;


// ---------------------------------------------------------
// QEZCHBKS data structures 
// ---------------------------------------------------------


/// @info Format CBKS0100 contains the information regarding changes to the Operational Assistant
/// backup schedule.
/// @field "hoursBeforeReminder" Hours before backup to send load-tape message.
///   @use "HOURS_NONE", "HOURS_SAME"
/// @field "backupWeekMonth" Occurrence of week in month to run backup.
///   @use "WEEKMONTH_SAME", "WEEKMONTH_NONE", "WEEKMONTH_LAST"
/// @field "useSchedule" Run backup using this schedule.
///   @useonly "USE_NO", "USE_YES", "USE_SAME"
/// @fields "backupOn[day]"
///   @useonly "FREQUENCE_DAILY", "FREQUENCE_WEEKLY", "FREQUENCE_MONTHLY", "FREQUENCE_WEEKMONTH",
///   "FREQUENCE_SAME", "FREQUENCE_NONE"
/// @fields "[day]BackupTime"
///   @use "TIME_NONE", "TIME_SAME"
dcl-ds CBKS0100 qualified inz;
  hoursBeforeReminder int(10);
  backupWeekMonth int(10);
  useSchedule char(1);
  backupOnSunday char(1);
  sundayBackupTime char(6);
  backupOnMonday char(1);
  mondayBackupTime char(6);
  backupOnTuesday char(1);
  tuesdayBackupTime char(6);
  backupOnWednesday char(1);
  wednesdayBackupTime char(6);
  backupOnThursday char(1);
  thursdayBackupTime char(6);
  backupOnFriday char(1);
  fridayBackupTime char(6);
  backupOnSaturday char(1);
  saturdayBackupTime char(6);
end-ds;


// ---------------------------------------------------------
// QEZOLBKL data structures 
// ---------------------------------------------------------


/// @info Informations about the list of objects that are to be backed up.
/// @fields "*n" Reserved by the system
dcl-ds ListInformation qualified inz;
  totalRecords int(10);
  recordsReturned int(10);
  requestHandle char(4);
  recordLength int(10);
  informationState char(1);
  creationDateTime char(13);
  listStatus char(1);
  *n char(1);
  outputLength int(10);
  firstBufferRecord int(10);
  userAuthority int(10);
  *n char(36);
end-ds;

/// @info The OBKL0100 format includes the basic information for a library object entry.
/// @field "backupOption"
///   @use "BACKUP_DAILY", "BACKUP_WEEKLY", "BACKUP_MONTHLY"
/// @field "*n" Reserved by the system
dcl-ds OBKL0100 qualified inz;
  backupOption char(10);
  libraryName char(10);
  *n char(2);
end-ds;

/// @info The OBKL0200 format includes the basic information for a folder object entry.
/// @field "backupOption"
///   @useonly "BACKUP_DAILY", "BACKUP_WEEKLY", "BACKUP_MONTHLY"
dcl-ds OBKL0200 qualified inz;
  backupOption char(10);
  folderName char(12);
end-ds;

/// @info The OBKL0600 format includes the complete information for a library object entry.
dcl-ds OBKL0600_library qualified inz;
  Info likeds(OBKL0100);
  lastBackupDate char(7);
  lastBackupTIme char(6);
  objectDescription char(50);
  changedSinceLastBackup ind;
  *n char(21); // Reserved by the system
end-ds;

/// @info The OBKL0600 format includes the complete information for a folder object entry.
/// @field "*n" Reserved by the system
dcl-ds OBKL0600_folder qualified inz;
  Info likeds(OBKL0200);
  lastBackupDate char(7);
  lastBackupTIme char(6);
  objectDescription char(50);
  changedSinceLastBackup ind;
  *n char(21);
end-ds;


// ---------------------------------------------------------
// QEZRTBKD data structures 
// ---------------------------------------------------------


/// @info Structure of the output of the QEZRTBKD API.
/// @field "lastSavedDate" The format of this field is CYYMMDD.
dcl-ds RBKD0100 qualified inz;
  bytesAvailable int(10);
  bytesReturned int(10);
  lastSavedDate char(7);
  lastSavedTime char(6);
  objectDescription char(50);
  changedSinceLastBackup ind;
end-ds;


// ---------------------------------------------------------
// QEZRTBKH data structures 
// ---------------------------------------------------------


/// @info Structure of the output of the QEZRTBKH API when using the RBKH0100 format.
/// @fields "[*]Date" The format of this field is CYYMMDD.
/// @field "*n" Reserved by the system.
dcl-ds RBKH0100 qualified inz;
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
  *n char(21);
end-ds;

/// @info Structure of the output of the QEZRTBKH API when using the RBKH0200 format.
dcl-ds RBKH0200 qualified inz;
  BasicInfos likeds(RBKH_0100);
  BackupInfos likeds(BackupInfo) dim(UNS3_MAX);
end-ds;

/// @info General information about the backup history.
/// @field "backupDate" The format of this field is CYYMMDD.
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


// ---------------------------------------------------------
// QEZRTBKO data structures 
// ---------------------------------------------------------


/// @info Structure of the header of the output of the QEZRTBKO API.
dcl-ds RBOH0100 qualified template;
  bytesReturned int(10);
  bytesAvailable int(10);
  offsetToDailyOption int(10); 
  offsetToWeeklyOption int(10); 
  offsetToMonthlyOption int(10); 
end-ds;


/// @info Structure of the output of the QEZRTBKO API when using the RBKO0100 format.
/// @field "backupDevices&tapeSetsToRotate" char(10) array and char(4) array with sizes depending on
/// "backupDevicesNumber" and "offsetToTapesToRotate" fields value.
/// @field "*n" Reserved by the system.
dcl-ds RBKO0100 qualified inz;
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
  *n char(1);
  offsetToAdditionalInfo int(10);
  backupDevices&tapeSetsToRotate char(INT5_MAX) options(*varsize);
end-ds;

/// @info Structure of the output of the QEZRTBKO API when using the RBKO0200 format.
/// @fields "[*]Date" The format of this field is CYYMMDD.
dcl-ds RBKO0200 qualified inz;
  SaveInformation likeds(RBKO_0100);
  lastBackupDate char(7);
  lastBackupTime char(6);
  nextBackupDate char(7);
  nextBackupTime char(6);
end-ds;


// ---------------------------------------------------------
// QEZRTBKS data structures 
// ---------------------------------------------------------


/// @info
/// @field "hoursBeforeReminder"
dcl-ds RBKS0100 qualified;
  bytesReturned int(10);
  bytesAvailable int(10);
  hoursBeforeReminder int(10);
  backupWeekMonth int(10);
  useSchedule char(1);
  backupOnSunday char(1);
  sundayBackupTime char(6);
  backupOnMonday char(1);
  mondayBackupTime char(6);
  backupOnTuesday char(1);
  tuesdayBackupTime char(6);
  backupOnWednesday char(1);
  wednesdayBackupTime char(6);
  backupOnThursday char(1);
  thursdayBackupTime char(6);
  backupOnFriday char(1);
  fridayBackupTime char(6);
  backupOnSaturday char(1);
  saturdayBackupTime char(6);
end-ds;




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




/// @info The Change Object Backup List (QEZCHBKL) API changes the backup type for a list of objects 
/// that are specified by the user.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/QEZCHBKL.html
/// @param This structure includes the keys and data that are needed to make the necessary changes
/// to the backup definitions.
///   @useonly "InputStructure"
/// @param The length of the input structure.
/// @param The structure in which to return error information.
dcl-pr QEZCHBKL extpgm('QEZCHBKL');
  inputStructure char(INT10_MAX) options(*varsize) const;
  inputLength int(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;


/// @info The Change Backup Schedule (QEZCHBKS) API allows the user to change the Operational
/// Assistant backup schedules.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/QEZCHBKS.html
/// @param The variable that contains the backup schedule changes.
///   @useonly "CBKS0100"
/// @param Length of the change request structure.
/// @param The format of the input structure data
///   @useonly "FORMAT_CBKS_0100".
/// @param The structure in which to return error information.
dcl-pr QEZCHBKS extpgm('QEZCHBKS');
  input char(INT10_MAX) options(*varsize) const;
  inputLength int(10) const;
  inputFormat char(8) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;


/// @info The Open List of Objects to be Backed Up (QEZOLBKL) API retrieves an open list of the objects that are to be
/// backed up.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/qezolbkl.html
/// @parameter The receiver variable that receives the information requested.
/// @parameter The length of the receiver variable provided.
/// @parameter Information about the list that is created by this program.
///   @useonly "ListInformation"
/// @parameter The number of records in the list to put into the receiver variable.
/// @parameter The name of the format to be used to return the requested information.
///   @useonly "OBKL_0100", "OBKL_0200", "OBKL_0600"
/// @parameter The type of the objects to be returned in the list.
///   @useonly "OBJECT_FOLDER", "OBJECT_LIBRARY"
/// @parameter The backup type of the objects that you request.
///   @useonly "BACKUP_DAILY", "BACKUP_WEEKLY", "BACKUP_MONTHLY", "BACKUP_ALL"
/// @parameter The structure in which to return error information.
dcl-pr QEZOLBKL extpgm('QEZOLBKL');
  output char(INT10_MAX) options(*varsize);
  expectedOutputLength int(10) const;
  listInformation likeds(ListInformation);
  recordsNumber int(10) const;
  outputFormat char(8) const;
  objectType char(10) const;
  backupType char(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;


/// @info The Retrieve Backup Detail (QEZRTBKD) API retrieves more detailed information about the
/// library or folder that is to be backed up.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/qezrtbkd.html
/// @param The receiver variable that receives the information requested.
///   @useonly "RBKD0100"
/// @param The length of the receiver variable provided.
/// @param The name of the object to retrieve backup detail information about.
/// @param The length of the name of the object about which to retrieve backup detail information.
/// @param The name of the format to be used to return information to caller
///   @useonly "RBKD_0100"
/// @param The type of object for which you are requesting information.
///   @useonly "OBJECT_FOLDER", "OBJECT_LIBRARY"
/// @parameter The structure in which to return error information.
dcl-pr QEZRTBKD extpgm('QEZRTBKD');
  output char(INT10_MAX) options(*varsize);
  outputLength int(10) const;
  objectName char(12) const options(*varsize);
  objectNameLength int(10) const;
  formatName char(8) const;
  objectType char(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;


/// @info The Retrieve Backup History (QEZRTBKH) API retrieves information about the backup status
/// and history into a single variable in the calling program.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/qezrtbkh.html
/// @param The receiver variable that receives the information requested.
///   @useonly "RBKH0100", "RBKH0200"
/// @param The length of the receiver variable provided.
/// @param The format of the command information to be returned.
///   @useonly "RBKH_0100", "RBKH_0200"
/// @param The structure in which to return error information. 
dcl-pr QEZRTBKH extpgm('QEZRTBKH');
  output char(INT10_MAX) options(*varsize);
  outputLength int(10) const;
  formatName char(8) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;


/// @info The Retrieve Backup Options (QEZRTBKO) API returns in a receiver variable the backup options for the requested
/// backup type.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/qezrtbko.html
/// @param The receiver variable that receives the information requested.
///   @useonly "RBKO_HEADER", "RBKO_0100", "RBKO_0200"
/// @param The length of the receiver variable provided.
/// @param The format of the backup option descriptions to be returned.
///   @use "RBKO0100", "RBKO0200", "RBOH0100"
/// @param The backup options to retrieve.
///   @use "BACKUP_DAILY", "BACKUP_WEEKLY", "BACKUP_MONTHLY", "BACKUP_ALL"
/// @param The structure in which to return error information.
dcl-pr QEZRTBKO extpgm('QEZRTBKO');
  output char(INT10_MAX) options(*varsize);
  outputLength int(10) const;
  formatName char(8) const;
  backupOption char(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;


/// @info The Retrieve Backup Schedule (QEZRTBKS) API returns in a receiver variable information about when the 
///   Operational Assistant backups are scheduled to be run.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/qezrtbks.html
/// @param The receiver variable that receives the information requested.
/// @param The length of the receiver variable provided.
/// @param The name of the format in which to return the backup schedule. See FORMAT_RBKS0100.
/// @param The structure in which to return error information.
dcl-pr QEZRTBKS extpgm('QEZRTBKS');
  output char(INT10_MAX) options(*varsize);
  outputLength int(10) const;
  outputFormat char(8) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;