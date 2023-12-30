**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZCHBKS
/// @info Change Backup Schedule API resources
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
  /DEFINE qezchbks
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


/// @refers QEZCHBKS(input)
/// @field hoursBeforeReminder 
///   Hours before backup to send load-tape message
/// @field backupWeekMonth
///   Occurrence of week in month to run backup
/// @field useSchedule
///   Run backup using this schedule
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




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Constants
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @refers QEZCHBKS(inputFormat)
dcl-c FORMAT_CBKS0100 'CBKS0100';

/// @refers CBKS0100.[day]Backup: daily backup.
dcl-c FREQUENCE_DAILY '1';
/// @refers CBKS0100.[day]Backup: weekly backup.
dcl-c FREQUENCE_WEEKLY '2';
/// @refers CBKS0100.[day]Backup: monthly backup.
dcl-c FREQUENCE_MONTHLY '3';
/// @refers CBKS0100.[day]Backup: every week except for the week that the monthly backup is to occur.
dcl-c FREQUENCE_WEEKMONTH '4';
/// @refers CBKS0100.[day]Backup: no change is made.
dcl-c FREQUENCE_SAME '9';
/// @refers CBKS0100.[day]Backup: no backup is scheduled.
dcl-c FREQUENCE_NONE *blank;

/// @refers CBKS0100.[day]BackupTime: no backup operations are scheduled.
dcl-c TIME_NONE *blanks;
/// @refers CBKS0100.[day]BackupTime: no change should be made to the current backup operations.
dcl-c TIME_SAME '*SAME';

/// @refers CBKS0100.hoursBeforeReminder: no message is sent.
dcl-c HOURS_NONE 0;
/// @refers CBKS0100.hoursBeforeReminder: no change is made.
dcl-c HOURS_SAME -1;

/// @refers CBKS0100.backupWeekMonth: no changes are made.
dcl-c WEEKMONTH_SAME -1;
/// @refers CBKS0100.backupWeekMonth: no monthly backups are scheduled.
dcl-c WEEKMONTH_NONE 0;
/// @refers CBKS0100.backupWeekMonth: the last week for any given month.
dcl-c WEEKMONTH_LAST 5;

/// @refers CBKS0100.useSchedule: no
dcl-c USE_NO '0';
/// @refers CBKS0100.useSchedule: yes
dcl-c USE_YES '1';
/// @refers CBKS0100.useSchedule: same
dcl-c USE_SAME *blank;




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @info The Change Backup Schedule (QEZCHBKS) API allows the user to change the Operational Assistant backup schedules.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/QEZCHBKS.html
/// @param The variable that contains the backup schedule changes.
/// @param Length of the change request structure.
/// @param The format of the input structure data, see FORMAT_CBKS0100.
/// @param The structure in which to return error information.
dcl-pr QEZCHBKS extpgm('QEZCHBKS');
  input char(INT10_MAX) options(*varsize) const;
  inputLength int(10) const;
  inputFormat char(8) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;