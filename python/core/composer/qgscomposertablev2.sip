/** List of QVariants, representing a the contents of a single row in
 * a QgsComposerTable
 * \note Added in version 2.5
*/
typedef QList< QVariant > QgsComposerTableRow;

/** List of QgsComposerTableRows, representing rows and column cell contents
 * for a QgsComposerTable
 * \note Added in version 2.5
*/
typedef QList< QList< QVariant > > QgsComposerTableContents;

/** List of column definitions for a QgsComposerTable
 * \note Added in version 2.5
*/
typedef QList<QgsComposerTableColumn*> QgsComposerTableColumns;


/** \ingroup core
 *  \class QgsComposerTableStyle
 *  \brief Styling option for a composer table cell
 *  \note added in QGIS 2.12
 */

class QgsComposerTableStyle
{
%TypeHeaderCode
#include <qgscomposertablev2.h>
%End
  public:

    QgsComposerTableStyle();

    //! Whether the styling option is enabled
    bool enabled;

    //! Cell background color
    QColor cellBackgroundColor;

    /** Writes the style's properties to XML for storage.
     * @param styleElem an existing QDomElement in which to store the style's properties.
     * @param doc QDomDocument for the destination XML.
     * @see readXML
     */
    bool writeXml( QDomElement& styleElem, QDomDocument & doc ) const;

    /** Reads the style's properties from XML.
     * @param styleElem a QDomElement holding the style's desired properties.
     * @see writeXML
     */
    bool readXml( const QDomElement& styleElem );

};

/** A class to display a table in the print composer, and allow
 * the table to span over multiple frames
 * \ingroup core
 * @note added in QGIS 2.5
 */
class QgsComposerTableV2: QgsComposerMultiFrame
{
%TypeHeaderCode
#include <qgscomposertablev2.h>
%End

  public:

    /** Controls how headers are horizontally aligned in a table
     */
    enum HeaderHAlignment
    {
      FollowColumn, /*!< header uses the same alignment as the column */
      HeaderLeft, /*!< align headers left */
      HeaderCenter, /*!< align headers to center */
      HeaderRight /*!< align headers right */
    };

    /** Controls where headers are shown in the table
     */
    enum HeaderMode
    {
      FirstFrame, /*!< header shown on first frame only */
      AllFrames, /*!< headers shown on all frames */
      NoHeaders /*!< no headers shown for table */
    };

    /** Controls how empty tables are displayed
     */
    enum EmptyTableMode
    {
      HeadersOnly, /*!< show header rows only */
      HideTable, /*!< hides entire table if empty */
      ShowMessage /*!< shows preset message instead of table contents*/
    };

    /** Controls how long strings in the table are handled
     */
    enum WrapBehaviour
    {
      TruncateText = 0, /*!< text which doesn't fit inside the cell is truncated */
      WrapText /*!< text which doesn't fit inside the cell is wrapped. Note that this only applies to text in columns with a fixed width. */
    };

    /** Row or column groups for cell styling
     */
    enum CellStyleGroup
    {
      OddColumns, /*!< Style odd numbered columns */
      EvenColumns, /*!< Style even numbered columns */
      OddRows, /*!< Style odd numbered rows */
      EvenRows, /*!< Style even numbered rows */
      FirstColumn, /*!< Style first column only */
      LastColumn, /*!< Style last column only */
      HeaderRow, /*!< Style header row */
      FirstRow, /*!< Style first row only */
      LastRow /*!< Style last row only */
    };

    QgsComposerTableV2( QgsComposition* composition /TransferThis/, bool createUndoCommands );
    QgsComposerTableV2();

    virtual ~QgsComposerTableV2();

    /** Sets the margin distance between cell borders and their contents.
     * @param margin margin for cell contents
     * @see cellMargin
     */
    void setCellMargin( const double margin );

    /** Returns the margin distance between cell borders and their contents.
     * @returns margin for cell contents
     * @see setCellMargin
     */
    double cellMargin() const;

    /** Sets the behaviour for empty tables with no content rows.
     * @param mode behaviour mode for empty tables
     * @see emptyTableBehaviour
     */
    void setEmptyTableBehaviour( const EmptyTableMode mode );

    /** Returns the behaviour mode for empty tables. This property controls
     * how the table is drawn if it contains no content rows.
     * @returns behaviour mode for empty tables
     * @see setEmptyTableBehaviour
     */
    EmptyTableMode emptyTableBehaviour() const;

    /** Sets the message for empty tables with no content rows. This message
     * is displayed in the table body if the empty table behaviour is
     * set to ShowMessage
     * @param message message to show for empty tables
     * @see emptyTableMessage
     * @see setEmptyTableBehaviour
     */
    void setEmptyTableMessage( const QString& message );

    /** Returns the message for empty tables with no content rows. This message
     * is displayed in the table body if the empty table behaviour is
     * set to ShowMessage
     * @returns message to show for empty tables
     * @see setEmptyTableMessage
     * @see emptyTableBehaviour
     */
    QString emptyTableMessage() const;

    /** Sets whether empty rows should be drawn. Tables default to hiding empty rows.
     * @param showEmpty set to true to show empty rows in the table
     * @see showEmptyRows
     */
    void setShowEmptyRows( const bool showEmpty );

    /** Returns whether empty rows are drawn in the table
     * @returns true if empty rows are drawn
     * @see setShowEmptyRows
     */
    bool showEmptyRows() const;

    /** Sets the font used to draw header text in the table.
     * @param font font for header cells
     * @see headerFont
     * @see setContentFont
     */
    void setHeaderFont( const QFont& font );

    /** Returns the font used to draw header text in the table.
     * @returns font for header cells
     * @see setHeaderFont
     * @see contentFont
     */
    QFont headerFont() const;

    /** Sets the color used to draw header text in the table.
     * @param color header text color
     * @see headerFontColor
     * @see setHeaderFont
     * @see setContentFontColor
     */
    void setHeaderFontColor( const QColor& color );

    /** Returns the color used to draw header text in the table.
     * @returns color for header text
     * @see setHeaderFontColor
     * @see headerFont
     * @see contentFontColor
     */
    QColor headerFontColor() const;

    /** Sets the horizontal alignment for table headers
     * @param alignment Horizontal alignment for table header cells
     * @see headerHAlignment
     */
    void setHeaderHAlignment( const HeaderHAlignment alignment );

    /** Returns the horizontal alignment for table headers
     * @returns Horizontal alignment for table header cells
     * @see setHeaderHAlignment
     */
    HeaderHAlignment headerHAlignment() const;

    /** Sets the display mode for headers in the table. This property controls
     * if and where headers are shown in the table.
     * @param mode display mode for headers
     * @see headerMode
     */
    void setHeaderMode( const HeaderMode mode );

    /** Returns the display mode for headers in the table. This property controls
     * if and where headers are shown in the table.
     * @returns display mode for headers
     * @see setHeaderMode
     */
    HeaderMode headerMode() const;

    /** Sets the font used to draw text in table body cells.
     * @param font font for table cells
     * @see contentFont
     * @see setHeaderFont
     */
    void setContentFont( const QFont& font );

    /** Returns the font used to draw text in table body cells.
     * @returns font for table cells
     * @see setContentFont
     * @see headerFont
     */
    QFont contentFont() const;

    /** Sets the color used to draw text in table body cells.
     * @param color table cell text color
     * @see contentFontColor
     * @see setContentFont
     * @see setHeaderFontColor
     */
    void setContentFontColor( const QColor& color );

    /** Returns the color used to draw text in table body cells.
     * @returns text color for table cells
     * @see setContentFontColor
     * @see contentFont
     * @see headerFontColor
     */
    QColor contentFontColor() const;

    /** Sets whether grid lines should be drawn in the table
     * @param showGrid set to true to show grid lines
     * @see showGrid
     * @see setGridStrokeWidth
     * @see setGridColor
     */
    void setShowGrid( const bool showGrid );

    /** Returns whether grid lines are drawn in the table
     * @returns true if grid lines are shown
     * @see setShowGrid
     * @see gridStrokeWidth
     * @see gridColor
     */
    bool showGrid() const;

    /** Sets the width for grid lines in the table.
     * @param width grid line width
     * @see gridStrokeWidth
     * @see setShowGrid
     * @see setGridColor
     */
    void setGridStrokeWidth( const double width );

    /** Returns the width of grid lines in the table.
     * @returns grid line width
     * @see setGridStrokeWidth
     * @see showGrid
     * @see gridColor
     */
    double gridStrokeWidth() const;

    /** Sets color used for grid lines in the table.
     * @param color grid line color
     * @see gridColor
     * @see setShowGrid
     * @see setGridStrokeWidth
     */
    void setGridColor( const QColor& color );

    /** Returns the color used for grid lines in the table.
     * @returns grid line color
     * @see setGridColor
     * @see showGrid
     * @see gridStrokeWidth
     */
    QColor gridColor() const;

    /** Sets color used for background of table.
     * @param color table background color
     * @see backgroundColor
     * @see setGridColor
     */
    void setBackgroundColor( const QColor& color );

    /** Returns the color used for the background of the table.
     * @returns table background color
     * @see setBackgroundColor
     * @see gridColor
     */
    QColor backgroundColor() const;

    /** Sets the wrap behaviour for the table, which controls how text within cells is
     * automatically wrapped.
     * @param behaviour wrap behaviour
     * @see wrapBehaviour
     * @note added in QGIS 2.12
     */
    void setWrapBehaviour( WrapBehaviour behaviour );

    /** Returns the wrap behaviour for the table, which controls how text within cells is
     * automatically wrapped.
     * @returns current wrap behaviour
     * @see setWrapBehaviour
     * @note added in QGIS 2.12
     */
    WrapBehaviour wrapBehaviour() const;

    /** Returns a pointer to the list of QgsComposerTableColumns shown in the table
     * @returns pointer to list of columns in table
     * @see setColumns
     */
    QgsComposerTableColumns* columns();

    /** Replaces the columns in the table with a specified list of QgsComposerTableColumns.
     * @param columns list of QgsComposerTableColumns to show in table. Ownership of columns
     * is transferred to the table.
     * @see columns
     */
    void setColumns( const QgsComposerTableColumns& columns /Transfer/ );

    /** Sets the cell style for a cell group.
     * @param group group to set style for
     * @param style new cell style
     * @see cellStyle()
     * @note added in QGIS 2.12
     */
    void setCellStyle( CellStyleGroup group, const QgsComposerTableStyle& style );

    /** Returns the cell style for a cell group.
     * @param group group to retrieve style for
     * @see setCellStyle()
     * @note added in QGIS 2.12
     */
    const QgsComposerTableStyle* cellStyle( CellStyleGroup group ) const;

    /** Returns the text used in the column headers for the table.
     * @returns QMap of int to QString, where the int is the column index (starting at 0),
     * and the string is the text to use for the column's header
     * @note not available in python bindings
     */
    virtual QMap<int, QString> headerLabels() const;

    /** Fetches the contents used for the cells in the table.
     * @returns true if table contents were successfully retrieved.
     * @param contents QgsComposerTableContents to store retrieved row data in
     * @note not available in python bindings
     */
    virtual bool getTableContents( QgsComposerTableContents &contents ) = 0;

    /** Returns the current contents of the table. Excludes header cells.
     * @returns table contents
     */
    QgsComposerTableContents* contents();

    //reimplemented to return fixed table width
    virtual QSizeF fixedFrameSize( const int frameIndex = -1 ) const;

    //reimplemented to return min frame height
    virtual QSizeF minFrameSize( const int frameIndex = -1 ) const;

    virtual bool writeXml( QDomElement& elem, QDomDocument & doc, bool ignoreFrames = false ) const;
    virtual bool readXml( const QDomElement& itemElem, const QDomDocument& doc, bool ignoreFrames = false );
    virtual QSizeF totalSize() const;
    virtual void render( QPainter* p, const QRectF& renderExtent, const int frameIndex );

  public slots:

    /** Refreshes the contents shown in the table by querying for new data.
     * This also causes the column widths and size of the table to change to accommodate the
     * new data.
     * @see adjustFrameToSize
     */
    virtual void refreshAttributes();

    void recalculateFrameSizes();

  protected:

    /** Calculates the maximum width of text shown in columns.
     */
    virtual bool calculateMaxColumnWidths();

    /** Calculates the maximum height of text shown in rows.
     * @note added in QGIS 2.12
     */
    virtual bool calculateMaxRowHeights();

    /** Returns total width of table contents.
     * @returns table width
     * @see totalHeight
     */
    //not const, as needs to call calculateMaxColumnWidths()
    double totalWidth();

    /** Returns total height of table contents.
     * @returns total height
     * @see totalWidth
     */
    //not const, as needs to call calculateMaxRowHeights()
    double totalHeight();

    /** Calculates how many content rows would be visible within a frame of the specified
     * height.
     * @param frameHeight height of frame
     * @param firstRow index of first row visible in frame (where 0 = first row in table)
     * @param includeHeader set to true if frame would include a header row
     * @param includeEmptyRows set to true to also include rows which would be empty in the returned count. For instance,
     * if the frame would include all table content rows and have space left for extra rows then setting this parameter
     * to true would also include a count of these extra blank rows.
     * @returns number of visible content rows (excluding header row)
     * @note added in QGIS 2.12
     */
    int rowsVisible( double frameHeight, int firstRow, bool includeHeader, bool includeEmptyRows ) const;

    /** Calculates how many content rows are visible within a given frame.
     * @param frameIndex index number for frame
     * @param firstRow index of first row visible in frame (where 0 = first row in table)
     * @param includeEmptyRows set to true to also include rows which would be empty in the returned count. For instance,
     * if the frame would include all table content rows and have space left for extra rows then setting this parameter
     * to true would also include a count of these extra blank rows.
     * @returns number of visible content rows (excludes header rows)
     * @note added in QGIS 2.12
     */
    int rowsVisible( int frameIndex, int firstRow, bool includeEmptyRows ) const;

    /** Calculates a range of rows which should be visible in a given frame.
     * @param frameIndex index number for frame
     * @returns row range
     * @note added in QGIS 2.12
     */
    QPair<int, int> rowRange( int frameIndex ) const;

    /** Draws the horizontal grid lines for the table.
     * @param painter destination painter for grid lines
     * @param firstRow index corresponding to first row shown in frame
     * @param lastRow index corresponding to last row shown in frame. If greater than the number of content rows in the
     * table, then the default row height will be used for the remaining rows.
     * @param drawHeaderLines set to true to include for the table header
     * @see drawVerticalGridLines
     * @note added in QGIS 2.12
     */
    void drawHorizontalGridLines( QPainter* painter, int firstRow, int lastRow, bool drawHeaderLines ) const;

    /** Draws the vertical grid lines for the table.
     * @param painter destination painter for grid lines
     * @param maxWidthMap QMap of int to double, where the int contains the column number and the double is the
     * maximum width of text present in the column.
     * @param firstRow index corresponding to first row shown in frame
     * @param lastRow index corresponding to last row shown in frame. If greater than the number of content rows in the
     * table, then the default row height will be used for the remaining rows.
     * @param hasHeader set to true if table frame includes header cells
     * @param mergeCells set to true to merge table content cells
     * @note not available in python bindings
     * @see drawVerticalGridLines
     * @see calculateMaxColumnWidths
     * @note not available in python bindings
     * @note added in QGIS 2.12
     */
    //void drawVerticalGridLines( QPainter* painter, const QMap<int, double>& maxWidthMap, int firstRow, int lastRow, bool hasHeader, bool mergeCells = false ) const;

    /** Recalculates and updates the size of the table and all table frames.
     */
    void recalculateTableSize();

    /** Checks whether a table contents contains a given row
     * @param contents table contents to check
     * @param row row to check for
     * @returns true if contents contains rows
     */
    bool contentsContainsRow( const QgsComposerTableContents &contents, const QgsComposerTableRow &row ) const;

};
