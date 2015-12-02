conky configuration
===================

Multiple conky instanes are used simultaneously. Use `conkyexec` to start.

For a display resolution of 1920x1080 and 6 conky instances/columns.
Calculating column width from display width number of columns and spacing
between columns;

    columnWidth = (screenWidth - (numberColumns * spacing)) / numberColumns

Assume spacing = 10, numberColumns = 6, screenWidth = 1920. 

    (1920 - (6 * 10)) / 6 = 310

Column width is 310.


The horizontal offset for column 'n' can be calculated as;

    offset = (n - 1) * (spacing + columnWidth)

So the column offset for the above assumptions is calculated as;

    n = 1:    1 - 1 * (10 + 310) = 0
    n = 2:    2 - 1 * (10 + 310) = 320
    n = 3:    2 - 1 * (10 + 310) = 640
    n = 4:    2 - 1 * (10 + 310) = 960
    n = 5:    2 - 1 * (10 + 310) = 1280
    n = 6:    2 - 1 * (10 + 310) = 1600


