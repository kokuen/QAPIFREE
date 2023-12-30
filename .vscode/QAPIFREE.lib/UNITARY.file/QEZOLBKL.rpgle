**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZOLBKL
/// @info Open List of Objects to be Backed Up API resources
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
  /DEFINE qezolbkl
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


/// @refers QEZOLBKL(ListInformation)
dcl-ds ListInformation qualified inz;
  totalRecords int(10);
  recordsReturned int(10);
  requestHandle char(4);
  recordLength int(10);
  informationState char(1);
  creationDateTime char(13);
  listStatus char(1);
  *n char(1); // Reserved by the system
  outputLength int(10);
  firstBufferRecord int(10);
  userAuthority int(10);
  *n char(36); // Reserved by the system
end-ds;

/// @info The OBKL0100 format includes the basic information for a library object entry.
/// @field backupOption
///   Use the "BACKUP_" constants.
dcl-ds OBKL0100 qualified inz;
  backupOption char(10);
  libraryName char(10);
  *n char(2); // Reserved by the system
end-ds;

/// @info The OBKL0200 format includes the basic information for a folder object entry.
dcl-ds OBKL0200 qualified inz;
  backupOption char(10);
  folderName char(12);
end-ds;

/// @info The OBKL0600 format includes the complete information for a library object entry.
dcl-ds OBKL0600_library qualified dim;
  Info likeds(OBKL0100);
  lastBackupDate char(7);
  lastBackupTIme char(6);
  objectDescription char(50);
  changedSinceLastBackup ind;
  *n char(21); // Reserved by the system
end-ds;

/// @info The OBKL0600 format includes the complete information for a folder object entry.
dcl-ds OBKL0600_folder qualified dim;
  Info likeds(OBKL0200);
  lastBackupDate char(7);
  lastBackupTIme char(6);
  objectDescription char(50);
  changedSinceLastBackup ind;
  *n char(21); // Reserved by the system
end-ds;




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Constants
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


// Constants common to many resources

/// @refers QEZOLBKL(backupType) | OBKL0100(backupOption) | OBKL0200(backupOption):
/// Return information for objects that are backed up *DAILY.
dcl-c BACKUP_DAILY '*DAILY';
/// @refers QEZOLBKL(backupType) | OBKL0100(backupOption) | OBKL0200(backupOption):
/// Return information for objects that are backed up *WEEKLY.
dcl-c BACKUP_WEEKLY '*WEEKLY';
/// @refers QEZOLBKL(backupType) | OBKL0100(backupOption) | OBKL0200(backupOption):
/// Return information for objects that are backed up *MONTHLY.
dcl-c BACKUP_MONTHLY '*MONTHLY';

// +++++++++++++++++++++++++++++++++++++

/// @refers QEZOLBKL(outputFormat): Library basic information format.
dcl-c OBKL_0100 'OBKL0100';
/// @refers QEZOLBKL(outputFormat): Folder basic information format.
dcl-c OBKL_0200 'OBKL0200';
/// @refers QEZOLBKL(outputFormat): Complete information format.
dcl-c OBKL_0600 'OBKL0600';

/// @refers QEZOLBKL(objectType): The folder information is returned.
dcl-c OBJECT_FOLDER '*FLR';
/// @refers QEZOLBKL(objectType): The library information is returned.
dcl-c OBJECT_LIBRARY '*LIB';

/// @refers QEZOLBKL(backupType): Return information for objects that are backed up *DAILY, *WEEKLY, or *MONTHLY.
dcl-c BACKUP_ALL '*ALL';




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @info The Open List of Objects to be Backed Up (QEZOLBKL) API retrieves an open list of the objects that are to be
///   backed up.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71%2Fapis%2Fqezolbkl.html
/// @parameter The receiver variable that receives the information requested.
/// @parameter The length of the receiver variable provided.
/// @parameter Information about the list that is created by this program. See XXXXX
/// @parameter The number of records in the list to put into the receiver variable.
/// @parameter The name of the format to be used to return the requested information. Use the "FORMAT_" constants.
/// @parameter The type of the objects to be returned in the list.
/// @parameter The backup type of the objects that you request.
/// @parameter The structure in which to return error information.
dcl-pr QEZOLBKL extpgm('QEZOLBKL');
  output char(INT10_MAX) options(*varsize);
  expectedOutputLength int(10) const;
  ListInformation likeds(ListInformation);
  recordsNumber int(10) const;
  outputFormat char(8) const;
  objectType char(10) const;
  backupType char(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;