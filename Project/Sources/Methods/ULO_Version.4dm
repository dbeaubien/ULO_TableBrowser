//%attributes = {"shared":true}
C_TEXT:C284($0)
$0:="1.2.8"

  //2021-02-10 - 1.2.8
  // ULO_EXPORT_VIEW_CSV - Fixed issue where CR was being printed before the last field, resulting in last field being first value for following record

  //2021-02-08 - 1.2.7
  // ULO_CHANGE_SIDEBAR_SELECTION - Added option 2nd param for passing new selection for targeted handle

  //2021-02-03 - 1.2.6
  // ULO_LOAD_VIEW   - Test for format#'' before setting format
  // BUTTON_VIEW_POP - 'Amend View' now always enabled when logged in as Designer
  // ULO_VIEW_EDIT_DETIAL (FORM) -  Increased height of Formula field

  //2021-02-02 - 1.2.5
  // VIEW_EDIT       - Added test when duping for fake ID assigned to system default
  // ULO_LOAD_THEME  - Added query for system default (user = 0) where user default not found
  // BUTTON_VIEW_POP - Now disables 'My Views' and 'Other Views' when no non-default options found
  // ULO_LOAD_VIEW   - Set handle when generating default to prevent future errors 

  //2021-01-29 - 1.2.4
  // ULO_LOAD_VIEW - Added fake ID to generated view so pop menu marks System Default as selected

  //2021-01-29 - 1.2.3
  // BUTTON_VIEW_POP - Removed 'default' check from MyView and OtherViews queries
  //                 - Instead checks the view is not System or User default when adding to menu
  //                   This is to support sharing of views between concessions
  // VIEW_EDIT       - In 'Dupe' case, handle is now always set to the current navItem handle
  //                   This is to allow duping of view assigned to different handle

  //2021-01-28 - 1.2.2
  // BUTTON_VIEW_POP - Fixed parameter usage from prev change
  //                 - Changed 'Null' view query on load case to pass object
  // ULO_LOAD_VIEW   - Added check for above object to force creation of system default view

  //2021-01-28 - 1.2.1
  // BUTTON_VIEW_POP - Added use of 'handle' to default view queries

  //2020-12-03 - 1.2.0
  // Save / Load in Query editor


  //2020-11-11 - 1.1.1
  //

  //2020-02-11 - 1.1.0
  //- New Query Editor 

  //2020-05-20 - 0.0.1
  //- Start of version history
  //  Method added to hold changes and return the current version of the ULO component.

