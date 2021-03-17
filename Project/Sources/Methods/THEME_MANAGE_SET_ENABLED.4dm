//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 16/03/21, 15:48:17
  // ----------------------------------------------------
  // Method: THEME_MANAGE_SET_ENABLED
  // Description
  // Sets enabled state according to selected theme
  //
  // Parameters
  // ----------------------------------------------------

C_BOOLEAN:C305($vb_enabled)

$vb_enabled:=(Form:C1466.workingTheme#Null:C1517)

OBJECT SET ENABLED:C1123(*;"input_theme_name";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"cb_hori_lines";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"cb_vert_lines";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_colour_hLineColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_colour_vLineColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_colour_hLineColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_colour_vLineColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_font";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_fontSize";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_colour_headerFontColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_colour_headerBgColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_colour_headerFontColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_colour_headerBgColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_font_row";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_fontSize_row";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_colour_rowFontColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_colour_rowColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"input_colour_rowAltColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_colour_rowFontColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_colour_rowColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_colour_rowAltColour";$vb_enabled)
OBJECT SET ENABLED:C1123(*;"bt_preview";$vb_enabled)
