class PdfAnnotation < Annotation
  # (x1, y1) is the top left corner and (x2, y2) is the bottom right corner
  # of the rectangle containing the annotation.
  validates_presence_of :x1, :x2, :y1, :y2, :page, :id
  validates_numericality_of :x1, :x2, :y1, :y2, :page, :id

  # Return a hash containing the coordinates of the rectangle containing the
  # annotation and the page.
  #
  # ===Returns:
  #
  # A hash with keys id, x1, y1, x2, y2, page where (x1, y1) is the top left
  # corner and (x2, y2) is the bottom right corner of the rectangle and id is
  # the annotation_text_id instance.
  def extract_coords
    horiz_range = { start: [x1, x2].min, end: [x1, x2].max }
    vert_range = { start: [y1, y2].min, end: [y1, y2].max }

    {
      id: annotation_text_id,
      annot_id: id,
      x1: horiz_range[:start], y1: vert_range[:start],
      x2: horiz_range[:end], y2: vert_range[:end],
      page: page
    }
  end

  def annotation_list_link_partial
    '/annotations/image_annotation_list_link'
  end
end
