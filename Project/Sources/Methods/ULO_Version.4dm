//%attributes = {"shared":true}
C_TEXT:C284($0)
$0:="2.0.2"

//2022-06-21 - 2.0.2
// Fixed CTRL+E shortcut opening the 'Export View' window multiple times
// Fixed Simple Search field in toolbar triggering the search when not required, this was due to the field being auto focused when loading the browser / navigating the sidebar

//2022-06-20 - 2.0.1
// Error handler installed for view export - ON ERR CALL("DATA_EXPORT_ERR_TRAP")
// To handle errors caused by null and undefined values.
// Set for both XLS and CSV export formats.


//2022-05-27 - 2.0.0
// Code base converted to v19r4
// Added ability set the logo image via ULO_SET_PREF("logo";imageFilePath)
// Export dialog now checks for XL Plugin being installed and disables XL Export option if not present.
// - Developers will have to apply their own license key otherwise functionality will time out after 1 hour.
// The findFields collection (if passed) now uses the default find fields before any host specific find method is activated
// User is now defaulted to zero (Storage.user.id:=0) to prevent significant errors
// in the event that ULO_SET_USER is not called from the host
// Fixed error when editing system default views for the first time.

//2022-06-13 - 1.9.4
// ULO_BROWSER_EVENT - Removed sidebarSource selection assignment in 'relate' case

//2022-05-20 - 1.9.3
// Added ability to have public sets
// - Checkbox on new set creation to make public
// - Checkbox on manage sets for creating new sets as public
// - New menu option to show public sets to users
// - Made public sets available for set manage operations.
// - Added public checkbox to set manage window for resulting sets

//2022-04-08 - 1.9.2
// Changed ULO Query to return object containing entity selection and query data collection

//2022-04-08 1.9.1
// Added ob is defined check in ULO_Query which was incorrectly removed

//2022-04-07 1.9.0
// Made amendments to ULO_Query and ULO_QE_Run to make both methods available to host database
// Fixed issue in Manage Sorts interface where sort direction could not be changed for System sorts


//2022-03-18 - 1.8.4
// Updated default buttons and forms
// - Added Enter and esc for Save and Cancel
// - Fixed view edit window sizing issue
// - Changed window type and title for all forms to be consistent


//2021-11-03 - 1.8.3
// BUTTON_SORT_POP - Added check for selectSort=null to prevent errors

//2021-10-14 - 1.8.2
// ULO_BROWSER_EVENT - When changing sidebar selection, current uloRecords is always saved to sidebarSource and navItems
// ULO_MAIN - added default allocation to sidebarSourceIndex
// ULO_LOAD_VIEW - Added allocation to sidebarSourceIndex

//2021-10-11 - 1.8.1
// BUTTON_SORT_POP - Added checks for the currently selected sort
// SORT_MANAGE_FORM_METHOD - Added check to prevent general users from adding fields to system sorts
// VIEW_EDIT_FORM - Added dropdown menu for assigning a sort to a view

//2021-10-08 - 1.8.0
// SORT_MANAGE_SET_ENABLED - Added checks for System Tab and user is designer
//                         - Added management of new form object 'cb_default'
// ULO_GET_SORT - New method, returns default sort for given table/user, or system default if none found for user
// ULO_LOAD_VIEW - Added use of ULO_GET_SORT where no sort has already been applied

//2021-10-05 - 1.7.1
// ULO_Query_Lines_New Delete Button - Fixed error when deleting first row in query editor

//2021-07-12 - 1.7.0
// ULO_SET_SIDEBAR_ITEM - Now checks for 'access' property in passed object and sets 'allowedAccess' against storage sidebar items
// ULO_BROWSER_EVENT - When selecting a sidebar item the 'allowedAccess' property is checked
// ULO_DISABLE_ACCESS - If access is not allowed on selected sidebar item, this method changes form to new page 3, and displays an image set via PREFS
// ULO_Browser - Added new page for displaying no access image 

//2021-05-26
// ULO_UPDATE_BUTTON_STATE - New method allowing HOST to set button state on the fly
// ULO_MAIN - Now attempts to call host method 'setWindowRef' to pass newly opened window ref to host
// ULO_LOAD_VIEW - Checks todo items and disables button if none available 

//2021-05-21 - 1.5.2
// ULO_LOAD_BUTTONS - Mac button positioning

//2021-05-20 - 1.5.1
// ULO_BROWSER_EVENT - Added handling of 'findHistory' used by search bar
// UTIL_SUBFORM_GOTO - New method to allow focusing a subform element
// ULO_LOAD_BUTTONS - Setup 'SearchPop' button
// UTIL_FIND_SEARCH_BUTTON - Returns coordinates of search button for moving pop button

//2021-05-19 - 1.5.0
// QE_Run, ULO_Query, ULO_Query_Editor_New - Added 'Query in Selection' checkbox to form

//2021-05-12 1.4.12
// Modified VIEW_EDIT to ensure default values for some properties were not set to null
//                    Added the same default values to the Edit case

//2021-05-04 1.4.11
// ULO_EXPORT_VIEW_XLSX - Reinstating Picture printing, and removal of process logging

//2021-04-30 1.4.10
// ULO_EXPORT_VIEW_XLSX - Patch to prevent export of picture fields until crash is resovled.

//2021-04-30 1.4.9
// ULO_LOAD_VIEW - Reordered to Get the View before calling 'hostMethods.sidebarLoad' as view is required for certain cases where data is loaded into memory according to selected view

//2021-04-15 1.4.8
// ULO_EXPORT_VIEW_XLSX - Implemented use of 'Formula from string' to handle custom formulas
// ULO_EXPORT_VIEW_CSV - Same fixes as for Excel

//2021-04-14 1.4.7
// ULO_EXPORT_VIEW_XLSX - Fixed Execute Formula commands to fix export of Related Tables
// ULO_EXPORT_VIEW_CSV - Same fixes as for Excel

//2021-04-14 1.4.6
// ULO_LIST_UPDATE_FOOTER - Fixed bad copy/paste where all footer values were being calculated with '.max()'
// ULO_Query - New operator 'Contains'
// QE_Run - Support for 'contains' operator

//2021-04-06 1.4.5
// Changed 'Your ..' menu prompts to 'My ..'
// BUTTON_SORT_POP
// BUTTON_VIEW_POP
// QE_BUILD_LOAD_MENU

//2021-03-25 1.4.4
// ULO_LIST_UPDATE_FOOTER - Fixed issues where not all cols are 'selected'
//                        - Fixed errors around use of time/date footers
//                        - Now applied Column display format to footer values
// A manually selected theme is now retained after use of a view with a theme assigned.

//2021-03-24 1.4.3
// Minor change to theme loading logic. A theme attached to a view is no longer retained when loading a new view, User must select theme from My Themes

//2021-03-19 1.4.2
// ULO_LOAD_THEME - If passed theme ID no longer exists, now falls back to user/system default instead of using ULO's default ugly theme

//2021-03-17 1.4.1
// ULO_EDIT_THEME [FORM] - Assigned correct variable to Verticle Lines checkbox
// ULO_LOAD_THEME        - Removed query for any user theme, should only search for defaults

//2021-03-17 1.4.0
// A host of changes to support multi user themes and assigning a theme to a view, see commit for more details!

//2021-03-15 - 1.3.12
// ULO_LIST_UPDATE_FOOTER - Added idx < collection.length test to account for 'fillerColumn' created when total column width < listbox width

//2021-03-12 - 1.3.11
// SORT_MANAGE_SET_ENABLED - Added disable / enable of table dropdown

//2021-03-12 - 1.3.10
// SORT_MANAGE_FORM_METHOD - Expanded Sort delete process to re-run query for user/system sorts to prevent deleted entity from being retained by selections
//                         - Also added the required updates to form objects, SORT_MANAGE_SET_ENABLED and Form.displayFields:=New collection
// ULO_LOAD_SORT           - Added Else when selectedSort=Null to clear current sort applied to listing

//2021-03-09 - 1.3.9
// INIT_STORAGE - Added the pref 'exportViewThemeColours' which defaults to false, can be enabled via ULO_SET_PREF
// ULO_EXPORT_VIEW_XLSX - Added use of 'exportViewThemeColours' which ignores theme font/bg colours, font decoration and borders when false

//2021-03-08 - 1.3.8
// ULO_BROWSER_EVENT - Added 'SET TIMER(-1)' to NavBar selection change event to trigger form updates when selecting new listing.

//2021-02-25 - 1.3.7
// ULO_BROWSER_EVENT - Added missing calls to ULO_DISABLE_BUTTON during initialisation of default data listing

//2021-02-18 - 1.3.6
// ULO_BROWSER_EVENT - Added missing call to Host Filter method when ULO_SEARCH clicked
// ULO_LOAD_VIEW - Added missing call to Host Filter method when loading initial selection of all records
// ULO_SET_HOST_METHOD - New method for setting/clearing host methods

//2021-02-17 - 1.3.5
// ULO_EXPORT_VIEW_CSV - Reworked columns loop to first query for selected cols to prevent printing issues where not every col is selected

//2021-02-16 - 1.3.4
// QE_FILL_LINE_DATA - Added check for 'in' operator, shows text entry
// QE_RUN            - Added handling of 'in' and 'not in' operators
// CSV_PARSE_RECORD_COL - New method for parsing in list values

//2021-02-16 - 1.3.3
// ULO_MAIN          - Saves window settings to Storage
// BUTTON_RELATE_POP - Uses saved settings when opening new window

//2021-02-15 - 1.3.2
// ULO_SET_PREF - Special case for 'relateIgnoreTables' where value is pushed into shared collection
// INIT_STORAGE - Initialisation of collection
// BUTTON_RELATE_POP - Now checks relateIgnoreTables before adding table to relate menu
//                   - Checks HOST relate options for given handle when searching sidebar

//2021-02-15 - 1.3.1
// ULO_LOAD_VIEW               - Now totals columns widths and adds blank column to fill empty space where column width < listbox width
//                             - Added support for Header Alignment
// ULO_VIEW_EDIT_DETAIL (Form) - Added missing variable to Right alignment radio box
//                             - Added radio buttons for Header Alignment
// VIEW_FORM_DETAIL_METHOD     - Added support for header alignment form objects
// VIEW_EDIT                   - Added check for attempts to Edit System Generated view

//2021-02-11 - 1.3.0
// INIT_STORAGE      - Added allowNewRelateWindow to default 'prefs' obj
// BUTTON_RELATE_POP - Creates separate New and Current window menus when above pref is true
// ULO_MAIN          - Added support for passing obj containing collection of ids and table to query
// ULO_SET_PREF      - New method for setting Storage.prefs values
// ULO_BROWSER_EVENT - A number of changes to support opening relate as new process

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

