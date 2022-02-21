# MATLAB CSV Editor

CsvEditor is made for viewing and editing .csv files. It supports basic functionality for adding, removing, and rearranging columns and rows through context menus and keyboard shortcuts.

## Shortcuts

### Highlighting Cells
- shift + direction: Selects multiple cells (built-in), useful when combined with the following shortcuts.

### Moving Rows & Columns
- ctrl + up: Moves selected row up
- ctrl + down: Moves selected row down
- ctrl + left: Moves selected column left
- ctrl + right: Moves selected column right

### Adding Rows & Columns
- alt + up: Adds row above the currently selected row
- alt + down: Adds row below the currently selected row
- alt + left: Adds column to the left of the currently selected column
- alt + right: Adds column to the right of the currently selected column

### Removing Rows & Columns
- ctrl + alt + up OR ctrl + alt + down: Removes the currently selected row(s)
- ctrl + alt + left OR ctrl + alt + right: Removes the currently selected columns(s)

## Future Improvements
- Support for row names
- Option to allow saving sorted data
- Hooks into some optional function to check for valid cell values per column/allow drop-down values?
- Value/command evaluation (make Excel... but extra and entirely in MATLAB... for some reason...)
