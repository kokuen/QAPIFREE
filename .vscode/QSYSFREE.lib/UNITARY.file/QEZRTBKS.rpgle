**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZRTBKS
/// @info Retrieve Backup Schedule API resources
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
  /DEFINE qezrtbks
/ENDIF

/IF not defined(api_common)
  /INCLUDE QAPIFREE,COMMON
/ENDIF

/IF not defined(qusec)
  /INCLUDE QAPIFREE,QUSEC
/ENDIF




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Data Structures
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @refers QEZRTBKS(ouput)
/// @field hoursBeforeReminder
///   Hours before backup to send load-tape message
/// @field backupWeekMonth
///   Occurrence of week in month to run backup
/// @field useSchedule
///   Run backup using this schedule
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
// Constants
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @refers QEZCHBKS(inputFormat)
dcl-c FORMAT_RBKS0100 'RBKS0100';




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


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