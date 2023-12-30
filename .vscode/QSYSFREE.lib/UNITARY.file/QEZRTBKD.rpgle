**free
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/// @title QEZRTBKD
/// @info Retrieve Backup Detail API resources
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
  /DEFINE qezrtbkd
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


/// @refers QEZRTBKD(formatName)
dcl-c FORMAT_RBKD_0100 const('RBKD0100');

/// @refers QEZRTBKD(objectType)
dcl-c OBJECT_FOLDER const('*FLR');
/// @refers QEZRTBKD(objectType)
dcl-c OBJECT_LIBRARY const('*LIB');



// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Data Structures
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @field lastSavedDate
///   The format of this field is CYYMMDD.
dcl-ds RBKD_0100 qualified inz;
  bytesAvailable int(10);
  bytesReturned int(10);
  lastSavedDate char(7);
  lastSavedTime char(6);
  objectDescription char(50);
  changedSinceLastBackup ind;
end-ds;




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Prototypes
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/// @info The Retrieve Backup Detail (QEZRTBKD) API retrieves more detailed information about the library or folder that
///   is to be backed up.
/// @link https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/qdbbrcds.htm
/// @param The receiver variable that receives the information requested.
/// @param The length of the receiver variable provided.
/// @param The name of the object to retrieve backup detail information about.
/// @param The length of the name of the object about which to retrieve backup detail information.
/// @param The name of the format to be used to return information to caller. Use the "RBKD_FORMAT_" constants
/// @param The type of object for which you are requesting information.
dcl-pr QEZRTBKD extpgm('QEZRTBKD');
  output char(INT10_MAX) options(*varsize);
  outputLength int(10) const;
  objectName char(12) const options(*varsize);
  objectNameLength int(10) const;
  formatName char(8) const;
  objectType char(10) const;
  errorCode char(INT5_MAX) options(*varsize);
end-pr;